return {
	"michaelrommel/nvim-silicon",
	lazy = true,
	cmd = "Silicon",
	config = function()
		require("silicon").setup({
			font = "JetBrainsMono Nerd Font=34;Noto Color Emoji=34",
			theme = "Catppuccin Mocha",
			background = "#94e2d5",
			to_clipboard = true,
			window_title = function()
				return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
			end,
		})

		-- local wk = require("which-key")
		-- local silicon = require("nvim-silicon")
		--
		-- wk.add({
		-- 	mode = { "v" },
		-- 	{ "<leader>s", group = "Silicon" },
		-- 	{
		-- 		"<leader>sc",
		-- 		function()
		-- 			silicon.clip()
		-- 		end,
		-- 		desc = "Copy code screenshot to clipboard",
		-- 	},
		-- 	{
		-- 		"<leader>sf",
		-- 		function()
		-- 			silicon.file()
		-- 		end,
		-- 		desc = "Save code screenshot as file",
		-- 	},
		-- })
	end,
}
