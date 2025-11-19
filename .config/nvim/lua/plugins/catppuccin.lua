return {
	"catppuccin/nvim",
	name = "catppuccin",
	config = function()
		require("catppuccin").setup({
			integrations = {
				aerial = true,
				gitsigns = true,
				indent_blankline = true,
				mason = true,
				treesitter_context = true,
				treesitter = true,
				nvimtree = true,
				dap = true,
				dap_ui = true,
				render_markdown = true,
				telescope = { enabled = true },
			},
			transparent_background = true,
			styles = {
				keywords = { "italic" },
			},
		})

		vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
		vim.fn.sign_define(
			"DapBreakpointCondition",
			{ text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
		)
		vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

		vim.cmd("colorscheme catppuccin-mocha")
	end,
}
