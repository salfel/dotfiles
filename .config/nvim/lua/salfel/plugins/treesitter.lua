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
            }
        })
    end
}
