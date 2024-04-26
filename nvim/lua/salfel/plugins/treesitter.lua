return {
    "nvim-treesitter/nvim-treesitter", build = ':TSUpdate',
    dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
        "nvim-treesitter/nvim-treesitter-textobjects"
    },
    config = function()
        require("nvim-treesitter").setup()
        require('ts_context_commentstring').setup({})
        vim.g.skip_ts_context_commentstring_module = true

        require('nvim-treesitter.configs').setup({
            ensure_installed = { "c", "lua", "javascript", "go", "typescript", "templ" },
            sync_install = false,
            ignore_install = {},
            auto_install = true,
            modules = {},
            autotag = {
                enable = true
            },
            highlight = {
                enable = true
            },
            indent = {
                enable = true
            },
            rainbow = {
                enable = true
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ['if'] = '@function.inner',
                        ['af'] = '@function.outer',
                        ['ia'] = '@parameter.inner',
                        ['aa'] = '@parameter.outer'
                    }
                }
            },
            config = function(_, opts)
                local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

                parser_config.blade = {
                    install_info = {
                        url = "https://github.com/EmranMR/tree-sitter-blade",
                        files = {
                            "src/parser.c",
                        },
                        branch = "main",
                    },
                    filetype = "blade",
                }

                require("nvim-treesitter.config").setup(opts)
            end
        })
    end
}
