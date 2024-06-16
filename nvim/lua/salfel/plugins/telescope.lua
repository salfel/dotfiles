return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
    },
    config = function()
        local actions = require("telescope.actions")

        require("telescope").setup({
            defaults = {
                file_ignore_patterns = { "node_modules", "vendor", ".git/" },
                mappings = {
                    i = {
                        ["<esc>"] = actions.close
                    }
                }
            },
            pickers = {
                find_files = {
                    hidden = true,
                    no_ignore = true,
                },
                oldfiles = {
                    prompt_title = "History"
                }
            },
            extensions = {
                fzf = {
                    fuzzy = true
                }
            }
        })

        local wk = require("which-key")
        local builtin = require("telescope.builtin")

        wk.register({
            f = {
                name = "Telescope | Find",
                f = { function() builtin.find_files() end, "Find Files" },
                h = { function() builtin.oldfiles() end, "History" },
                g = { function() builtin.live_grep() end, "Live Grep" },
                s = { function() builtin.lsp_workspace_symbols() end, "Lsp Symbols" }
            }
        }, { prefix = "<leader>" })
    end
}
