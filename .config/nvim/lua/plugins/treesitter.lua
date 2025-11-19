return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	opts = {},
	config = function()
		local treesitter = require("nvim-treesitter")

		treesitter
			.update({
				"rust",
				"go",
				"lua",
				"javascript",
				"typescript",
				"php",
				"python",
				"c",
				"cpp",
				"odin",
			})
			:wait(5 * 60 * 1000)

		-- Highlighting
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "<filetype>" },
			callback = function()
				vim.treesitter.start()
			end,
		})

		-- Indentation
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

		-- Folds
		vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
	end,
}
