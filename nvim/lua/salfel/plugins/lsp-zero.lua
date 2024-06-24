return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local lsp_zero = require("lsp-zero")
        local wk = require("which-key")

        lsp_zero.on_attach = function(_, bufnr)
            lsp_zero.default_keymaps({ bufnr = bufnr })
        end

        vim.g.rustaceanvim = {
            server = {
                on_attach = lsp_zero.on_attach,
                capabilities = lsp_zero.get_capabilities(),
                ["rust-analyzer"] = { "rust" }
            }
        }

        lsp_zero.format_on_save({
            servers = {
                ["rust-analyzer"] = { "rust" },
                ["gopls"] = { "go" },
                ["lua_ls"] = { "lua" },
            }
        })

        wk.register({
            r = {
                n = { vim.lsp.buf.rename, "Rename" },
            }
        }, { prefix = "<leader>" })

        require("mason").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "tsserver", "gopls", "intelephense", "astro" },
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({})
                end,
                rust_analyzer = lsp_zero.noop,
                lua_ls = function()
                    require("lspconfig").lua_ls.setup({
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = {
                                        "vim"
                                    }
                                },
                                workspace = {
                                    library = vim.api.nvim_get_runtime_file("", true)
                                }
                            }
                        }
                    })
                end
            }
        })

        vim.keymap.set("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>")
        vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
        vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")
        vim.keymap.set("n", "gd", ":Telescope lsp_definitions<CR>")
        vim.keymap.set("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>")
        vim.keymap.set("n", "gi", ":Telescope lsp_implementations<CR>")
        vim.keymap.set("n", "gr", ":Telescope lsp_references<CR>")
        vim.keymap.set("n", "gl", ":lua vim.diagnostic.open_float()<CR>")
        vim.keymap.set("n", "<leader>lr", ":LspRestart<CR>", { silent = true })
        vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
        vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")

        local cmp = require("cmp")

        cmp.setup({
            sources = {
                { name = "path" },
                { name = "nvim_lsp" },
                { name = "nvim_lua" },
                { name = "buffer" },
                { name = "luasnip" },
                { name = "supermaven" },
            },
            mapping = cmp.mapping.preset.insert({
                ["<CR>"] = cmp.mapping.confirm({ select = true })
            })
        })
    end
}
