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

        local window = {
            input = {
                keys = {
                    ["<Esc>"] = { "close", mode = { "n", "i" } },
                },
            },
        }
        local finder = {
            hidden = true,
            win = window,
        }
        local config = {
            explorer = {
                hidden = true,
                win = window,
                layout = {
                    layout = {
                        position = "right",
                    },
                },
            },
            files = finder,
            grep = finder,
            recent = finder,
            lsp_workspace_symbols = finder,
        }

        snacks.indent.enable()

        vim.keymap.set("n", "<leader>e", function()
            snacks.explorer(config.explorer)
        end)

        vim.keymap.set("n", "<leader>q", function()
            snacks.bufdelete()
        end)

        vim.keymap.set("n", "<leader>ff", function()
            snacks.picker.files(config.files)
        end)
        vim.keymap.set("n", "<leader>fg", function()
            snacks.picker.grep(config.grep)
        end)
        vim.keymap.set("n", "<leader>fh", function()
            snacks.picker.recent(config.recent)
        end)
        vim.keymap.set("n", "<leader>fs", function()
            snacks.picker.lsp_workspace_symbols(config.lsp_workspace_symbols)
        end)
        vim.keymap.set("n", "<leader>fd", function()
            snacks.picker.diagnostics({})
        end)
    end,
}
