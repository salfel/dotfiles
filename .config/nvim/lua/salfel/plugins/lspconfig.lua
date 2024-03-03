return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig", "hrsh7th/cmp-nvim-lsp" },
    config = function()
        local lsps = { "tsserver", "tailwindcss", "templ", "gopls", "htmx", "html", "lua_ls", "pylsp" }
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        vim.filetype.add({
            extension = {
                templ = "templ",
            }
        })

        local configs = {}

        for _, lsp in pairs(lsps) do
            configs[lsp] = {
                capabilities = capabilities
            }
        end

        configs.lua_ls.settings = {
            Lua = {
                diagnostics = {
                    globals = {
                        "vim",
                    }
                },
            }
        }

        for lsp, config in pairs(configs) do
            require("lspconfig")[lsp].setup(config)
        end

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = lsps,

            automatic_installation = false
        })

        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {})

        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostics"} )
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostics"} )
        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" } )
        vim.keymap.set("n", "<leader>w", vim.diagnostic.setloclist, { desc = "Open diagnostic Quickfix list" })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                local opts = { buffer = ev.buf }
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
                vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)

            end
        })
    end
}
