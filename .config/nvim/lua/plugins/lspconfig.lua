return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		require("mason").setup({})
		require("mason-lspconfig").setup({
			ensure_installed = { "gopls", "intelephense", "phpactor", "astro" },
			handlers = {
				function(server_name)
					vim.lsp.config[server_name] = {}
				end,
				rust_analyzer = function() end,
			},
		})

		-- Language Servers not able to be installed through mason due to dynamic linking
		local custom_lsp_servers = { "nixd", "clangd", "lua_ls", "zls", "rust_analyzer", "cmake", "ols" }

		for _, server_name in pairs(custom_lsp_servers) do
			vim.lsp.config[server_name] = {}
		end

		-- tabs are of length 2 in nix
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "nix",
			callback = function()
				vim.bo.tabstop = 2
				vim.bo.shiftwidth = 2
			end,
		})

		vim.keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition)
		vim.keymap.set("n", "ga", vim.lsp.buf.code_action)
		vim.keymap.set("n", "gr", vim.lsp.buf.references)
		vim.keymap.set("n", "gl", vim.diagnostic.open_float)
		vim.keymap.set("n", "K", vim.lsp.buf.hover)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)

		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			underline = true,
			update_in_insert = false,
		})
	end,
}
