return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				globalstatus = true,
				theme = "catppuccin",
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" },
				lualine_c = { "diagnostics" },
				lualine_x = { { "filename", path = 1 } },
				lualine_y = { "filetype" },
			},
		})
	end,
}
