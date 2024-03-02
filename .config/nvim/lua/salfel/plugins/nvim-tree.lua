return {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        require("nvim-tree").setup({
            view = {
                width = 35
            },
            renderer = {
                group_empty = true
            },
            filters = {
                dotfiles = true
            }
        })

        vim.keymap.set("n", "<leader>n", ':NvimTreeFindFileToggle<CR>')
        vim.keymap.set("n", "<leader>N", ':NvimTreeFindFile<CR>')

        local api = require("nvim-tree.api")
        local Event = api.events.Event

        api.events.subscribe(Event.FileCreated, function(data)
            vim.cmd("e " .. data.fname)
        end)
    end
}
