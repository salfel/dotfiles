return {
	"lervag/vimtex",
	config = function()
		vim.g.vimtex_view_method = "zathura"

		vim.cmd("filetype plugin indent on")

		vim.cmd("syntax enable")
	end,
}
