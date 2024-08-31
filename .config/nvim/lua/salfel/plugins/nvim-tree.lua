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
            filters = {
                git_ignored = false,
                custom = {
                    ".git"
                }
            },
            renderer = {
                root_folder_label = false,
                group_empty = true,
                highlight_git = true,

                indent_markers = {
                    enable = true
                },

                icons = {
                    glyphs = {
                        folder = {
                            default = "",
                            empty = "",
                            empty_open = "",
                            open = "",
                            symlink = "",
                            symlink_open = "",
                            arrow_open = "",
                            arrow_closed = "",
                        },
                        git = {
                            unstaged = "✗",
                            staged = "✓",
                            unmerged = "",
                            renamed = "➜",
                            untracked = "★",
                            deleted = "",
                            ignored = "◌",
                        }
                    }
                }

            },
        })

        vim.keymap.set("n", "<leader>n", ':NvimTreeFindFileToggle<CR>')

        local api = require("nvim-tree.api")
        local Event = api.events.Event

        api.events.subscribe(Event.FileCreated, function(data)
            vim.cmd("e " .. data.fname)
        end)
    end
}
