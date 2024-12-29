return {
	"mrcjkb/rustaceanvim",
	version = "^5",
	lazy = false,
	config = function()
		vim.g.rustaceanvim = {
			server = {
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				["rust-analyzer"] = { "rust" },
			},
		}
	end,
}
