return {
    "nvim-lualine/lualine.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require("lualine").setup({
            options = {
                theme = "catppuccin",
                globalstatus = true,
            },
            sections = {
                lualine_a  = { 'mode' },
                lualine_b = { 'branch', 'diff' },
                lualine_c = { 'diagnostics' },
                lualine_x = { 'filename' },
                lualine_y = { 'filetype' },
                lualine_z = { 'location' }
            }
        })
    end
}
