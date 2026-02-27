local function set_tab_width(filetype, width)
	vim.api.nvim_create_autocmd("FileType", {
		pattern = filetype,
		callback = function()
			vim.bo.tabstop = width
			vim.bo.shiftwidth = width
		end,
	})
end

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
		})

		-- Language Servers not able to be installed through mason due to dynamic linking
		local custom_lsp_servers = { "nixd", "clangd", "lua_ls", "zls", "rust_analyzer", "cmake", "ols", "jdtls" }
		vim.lsp.enable(custom_lsp_servers)

		-- tabs are of length 2 in nix
		set_tab_width("nix", 2)
		set_tab_width("pascal", 2)

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
