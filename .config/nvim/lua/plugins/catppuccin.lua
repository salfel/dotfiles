return {
	"catppuccin/nvim",
	name = "catppuccin",
	config = function()
		require("catppuccin").setup({
			integrations = {
				dashboard = true,
				gitsigns = true,
				indent_blankline = true,
				cmp = true,
				mason = true,
				treesitter_context = true,
				treesitter = true,
				nvimtree = true,
			},
			transparent_background = true,
			styles = {
				keywords = { "italic" },
			},
		})

		vim.cmd("colorscheme catppuccin-mocha")
	end,
}
