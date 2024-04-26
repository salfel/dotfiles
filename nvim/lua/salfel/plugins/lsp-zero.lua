return {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
    },
    config = function()
        local lsp_zero = require("lsp-zero")

        vim.api.nvim_create_autocmd("LspAttach", {
            desc = "Lsp Actions",
            callback = function(event)
                local opts = function(desc)
                    return { buffer = event.buf, desc = desc }
                end

                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("Rename"))
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
                vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, opts("Format"))
            end
        })

        local lsps = { "tsserver", "tailwindcss", "templ", "gopls", "golangci_lint_ls", "htmx", "html", "lua_ls",
            "pyright", "biome", "intelephense", "phpactor" }
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        require("lspconfig.configs").laravel_ls = {
            default_config = {
                name = "laravel_ls",
                cmd = { "/home/salfel/.local/bin/laravel-dev-tools", "lsp" },
                filetypes = { "blade" },
                root_dir = function(fname)
                    local util = require("lspconfig.util")
                    local cwd = vim.loop.cwd()
                    local root = util.root_pattern("composer.json", ".git")(fname)
                    return util.path.is_descendant(cwd, root) and cwd or root
                end,
                settings = {}
            }
        }

        require("lspconfig").laravel_ls.setup({
            capabilities = capabilities
        })
        lsp_zero.default_setup("laravel_ls")

        local default_setup = function(server)
            require("lspconfig")[server].setup({
                capabilities = capabilities
            })
        end

        vim.filetype.add({
            extension = {
                templ = "templ",
            },
            pattern = {
                [".*blade.php"] = "blade"
            }
        })

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = lsps,

            handlers = {
                default_setup,
                ["lua_ls"] = function()
                    local lua_opts = lsp_zero.nvim_lua_ls()
                    require("lspconfig").lua_ls.setup(lua_opts)
                end,
                ["intelephense"] = function()
                    require("lspconfig").intelephense.setup({
                        filetypes = { "php", "blade" },
                    })
                end,
                ["phpactor"] = function ()
                    require('lspconfig').phpactor.setup({
                        capabilities = capabilities,
                        on_attach = function(client, bufnr)
                            client.server_capabilities.completionProvider = false
                            client.server_capabilities.hoverProvider = false
                            client.server_capabilities.implementationProvider = false
                            client.server_capabilities.referencesProvider = false
                            client.server_capabilities.renameProvider = false
                            client.server_capabilities.selectionRangeProvider = false
                            client.server_capabilities.signatureHelpProvider = false
                            client.server_capabilities.typeDefinitionProvider = false
                            client.server_capabilities.workspaceSymbolProvider = false
                            client.server_capabilities.definitionProvider = false
                            client.server_capabilities.documentHighlightProvider = false
                            client.server_capabilities.documentSymbolProvider = false
                            client.server_capabilities.documentFormattingProvider = false
                            client.server_capabilities.documentRangeFormattingProvider = false
                        end,
                        -- init_options = {
                        --     ["language_server_phpstan.enabled"] = false,
                        --     ["language_server_psalm.enabled"] = false,
                        -- },
                        handlers = {
                            ['textDocument/publishDiagnostics'] = function() end
                        }
                    })
                end
            },

            automatic_installation = false
        })

        -- Keymaps
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
                { name = "luasnip" }
            },
            mapping = cmp.mapping.preset.insert({
                ["<CR>"] = cmp.mapping.confirm({ select = true })
            })
        })
    end
}
