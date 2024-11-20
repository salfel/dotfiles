return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			on_attach = function()
				local gs = require("gitsigns")
				local wk = require("which-key")

				wk.add({
					{ "<leader>hp", gs.preview_hunk, group = "[H]unk", desc = "Preview Hunk" },
					{ "<leader>hr", gs.reset_hunk, group = "[H]unk", desc = "Reset Hunk" },
					{ "<leader>hb", gs.blame_line, group = "[H]unk", desc = "Blame Hunk" },
					{ "[h", gs.next_hunk, group = "[H]unk", desc = "Next Hunk" },
					{ "]h", gs.prev_hunk, group = "[H]unk", desc = "Prev Hunk" },
				})
			end,
		})
	end,
}
