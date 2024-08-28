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
                file_ignore_patterns = { "node_modules", "vendor", ".git/", "target" },
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

        wk.add({
            { "<leader>ff", builtin.find_files,            desc = "Find Files" },
            { "<leader>fh", builtin.oldfiles,              desc = "History" },
            { "<leader>fg", builtin.live_grep,             desc = "Live Grep" },
            { "<leader>fb", builtin.buffers,               desc = "Buffers" },
            { "<leader>fs", builtin.lsp_workspace_symbols, desc = "Lsp Symbols" },
        })
    end
}
