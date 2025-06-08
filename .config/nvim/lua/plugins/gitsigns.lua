return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			on_attach = function()
				local gs = require("gitsigns")
				local wk = require("which-key")

				wk.add({
					{ "<leader>h", group = "[H]unk" },
					{ "<leader>hp", gs.preview_hunk, desc = "Preview Hunk" },
					{ "<leader>hr", gs.reset_hunk, desc = "Reset Hunk" },
					{ "<leader>hb", gs.blame_line, desc = "Blame Hunk" },
					{
						"[h",
						function()
							gs.nav_hunk("next")
						end,
						desc = "Next Hunk",
					},
					{
						"]h",
						function()
							gs.nav_hunk("prev")
						end,
						desc = "Prev Hunk",
					},
				})
			end,
		})
	end,
}
