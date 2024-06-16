return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require('gitsigns').setup({
            on_attach = function (bufnr)
                local gs = require("gitsigns")
                local wk = require("which-key")

                wk.register({
                    h = {
                        name = "Git hunks",
                        p = { gs.preview_hunk, "Preview Hunk" },
                        r = { gs.reset_hunk, "Reset Hunk" },
                        b = { gs.blame_line, "Blame Hunk" }
                    }
                }, { prefix = "<leader>" } )
            end
        })
    end
}
