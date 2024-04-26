return {
    "catppuccin/nvim", name = "catppuccin",
    config = function()
        require("catppuccin").setup({
            integrations = {
                dashboard = true,
                gitsigns = true,
                indent_blankline = true,
                cmp = true,
                mason = true,
                treesitter_context = true,
                treesitter = true,
                nvimtree = true,
            }
        })

        vim.cmd("colorscheme catppuccin-mocha")
    end
}
