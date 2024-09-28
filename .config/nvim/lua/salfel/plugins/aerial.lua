return {
    'stevearc/aerial.nvim',
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        require("aerial").setup()

        local wk = require("which-key")
        wk.add({
            { "<leader>o", "<cmd>AerialToggle<CR>", desc = "outline" }
        })
    end
}
