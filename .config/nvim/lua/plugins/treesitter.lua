return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		require("nvim-treesitter").setup()
		require("ts_context_commentstring").setup({})
		vim.g.skip_ts_context_commentstring_module = true

		require("nvim-treesitter.configs").setup({
			autotag = {
				enable = true,
			},
			indent = {
				enable = true,
			},
			rainbow = {
				enable = true,
			},
			highlight = {
				enable = true,
			},
		})
	end,
}
