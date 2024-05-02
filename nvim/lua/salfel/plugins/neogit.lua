return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",

        "nvim-telescope/telescope.nvim",
        "ibhagwan/fzf-lua"
    },
    config = function ()
        require("neogit").setup({})

        local wk = require("which-key")
        wk.register({
            g = {
                n = { "<cmd>Neogit<cr>", "Neogit" }
            }
        }, { prefix = "<leader>"})

    end
}
