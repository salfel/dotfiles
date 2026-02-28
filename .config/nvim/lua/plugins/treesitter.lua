return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	opts = {},
	config = function()
		local treesitter = require("nvim-treesitter")

		local languages = {
			"rust",
			"go",
			"lua",
			"javascript",
			"typescript",
			"php",
			"python",
			"c",
			"cpp",
			"java",
			"odin",
		}

		treesitter.install(languages)

		-- Highlighting
		vim.api.nvim_create_autocmd("FileType", {
			pattern = languages,
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
