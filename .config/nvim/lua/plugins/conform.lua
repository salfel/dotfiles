return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			go = { "gofmt" },
			python = { "black" },
			cpp = { "clang-format" },
			astro = { "prettier" },
			javascript = { "biome" },
			typescript = { "biome" },
			css = { "prettier" },
			nix = { "alejandra" },
			cmake = { "cmake_format" },
		},
		format_on_save = {
			timeout_ms = 200,
			lsp_format = "fallback",
		},
	},
}
