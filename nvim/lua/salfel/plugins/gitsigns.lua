return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require('gitsigns').setup({
            on_attach = function (bufnr)
                local gs = require('gitsigns')

                local function opts(desc)
                    return { buffer = bufnr, desc = desc}
                end
                vim.keymap.set("n", "<leader>ph", gs.preview_hunk, opts "preview hunk")
                vim.keymap.set("n", "<leader>rh", gs.reset_hunk, opts "reset hunk")
                vim.keymap.set("n", "<leader>gb", gs.blame_line, opts "Blame hunk")
            end
        })
    end
}
