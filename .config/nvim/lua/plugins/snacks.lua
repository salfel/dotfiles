return {
    "folke/snacks.nvim",
    priority = 1000,
    ---@type snacks.Config
    opts = {
        --- @type snacks.explorer.Config
        explorer = {
            replace_netrw = true,
        },
        notifier = {
            enabled = true,
        },
        picker = {
            sources = {},
            win = {
                list = {
                    keys = {
                        ["<Esc>"] = { "close", mode = { "n", "i" } },
                    },
                },
            },
        },
    },

    config = function()
        local snacks = require("snacks")

        snacks.indent.enable()

        vim.keymap.set("n", "<leader>e", function()
            snacks.explorer({
                finder = "explorer",
                hidden = true,
            })
        end)

        vim.keymap.set("n", "<leader>q", function()
            snacks.bufdelete()
        end)

        vim.keymap.set("n", "<leader>ff", function()
            snacks.picker.files({
                hidden = true,
            })
        end)
        vim.keymap.set("n", "<leader>fg", function()
            snacks.picker.grep({
                hidden = true,
            })
        end)
        vim.keymap.set("n", "<leader>fh", function()
            snacks.picker.recent({ hidden = true })
        end)
    end,
}
