return {
     "catppuccin/nvim", name = "catppuccin",
     config = function()
        require("catppuccin").setup({
            integrations = {
                cmp = true,
                mason = true,
                treesitter_context = true
            }
        })

         vim.cmd("colorscheme catppuccin-mocha")
     end
}
