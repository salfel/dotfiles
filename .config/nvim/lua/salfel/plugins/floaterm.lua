return {
	"voldikss/vim-floaterm",
	cmd = { "FloatermToggle" },
	init = function()
		vim.keymap.set("n", "<leader>t", ":FloatermToggle<CR>")
		vim.keymap.set("t", "<C-t>", "<C-\\><C-n>:FloatermToggle<CR>")
	end,
}
