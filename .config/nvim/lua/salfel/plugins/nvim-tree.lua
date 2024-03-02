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
                dotfiles = false
            }
        })

        vim.keymap.set("n", "<leader>n", ':NvimTreeFindFileToggle<CR>')

        local api = require("nvim-tree.api")
        local Event = api.events.Event

        api.events.subscribe(Event.FileCreated, function(data)
            vim.cmd("e " .. data.fname)
        end)
    end
}
