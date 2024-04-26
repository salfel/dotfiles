return {
	"nvim-telescope/telescope.nvim", tag = '0.1.5',
	dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
    },
	config = function()
        local actions = require('telescope.actions')

        require('telescope').setup({
            defaults = {
                layout_config = {
                    prompt_position = 'top'
                },
                sorting_strategy = 'ascending',
                mappings = {
                    i = {
                        ['<esc>'] = actions.close
                    }
                }
            },
        })

        require("telescope").load_extension("fzf")

		local builtin = require('telescope.builtin')

        local wk = require("which-key")
        wk.register({
            f = {
                name = "Telescope",
                f = { builtin.find_files, "Find Files" },
                g = { builtin.live_grep, "Live Grep" },
                b = { builtin.buffers, "Buffers" },
                h = { builtin.oldfiles, "History" },
                s = { builtin.lsp_workspace_symbols, "Workspace Symbols" },
            }
        }, { prefix = "<leader>"})
	end
}
