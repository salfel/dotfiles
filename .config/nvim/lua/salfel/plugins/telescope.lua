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
            pickers = {
                find_files = {
                    hidden = true
                }
            }
        })

        require("telescope").load_extension("fzf")

		local builtin = require('telescope.builtin')

		vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
		vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
		vim.keymap.set('n', '<leader>fh', builtin.oldfiles, {})
	end
}
