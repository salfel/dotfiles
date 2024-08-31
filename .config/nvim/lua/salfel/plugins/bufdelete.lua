return {
    "famiu/bufdelete.nvim",
    config = function()
        vim.keymap.set("n", "<leader>q", ':Bdelete<CR>')
    end
}
