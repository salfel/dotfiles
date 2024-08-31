return {
    "mbbill/undotree",
    opts = {},
    config = function()
        local wk = require("which-key")

        wk.add({
            "<leader>u",
            function()
                vim.cmd("UndotreeToggle")
                vim.cmd("UndotreeFocus")
            end,
            desc = "UndoTree"
        })
    end
}
