return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"onsails/lspkind.nvim",
	},
	config = function()
		require("mason").setup({})
		require("mason-lspconfig").setup({
			ensure_installed = { "gopls", "intelephense", "phpactor", "astro" },
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end,
				rust_analyzer = function() end,
			},
		})

		-- Language Servers not able to be installed through mason due to dynamic linking
		local custom_lsp_servers = { "nixd", "ccls", "lua_ls" }

		for _, server_name in pairs(custom_lsp_servers) do
			require("lspconfig")[server_name].setup({})
		end

		-- tabs are of length 2 in nix
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "nix",
			callback = function()
				vim.bo.tabstop = 2
				vim.bo.shiftwidth = 2
			end,
		})

		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition)
		vim.keymap.set("n", "ga", vim.lsp.buf.code_action)
		vim.keymap.set("n", "gr", vim.lsp.buf.references)
		vim.keymap.set("n", "gl", vim.diagnostic.open_float)
		vim.keymap.set("n", "K", vim.lsp.buf.hover)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)

		local cmp = require("cmp")

		cmp.setup({
			sources = {
				{ name = "path" },
				{ name = "nvim_lsp" },
				{ name = "nvim_lua" },
				{ name = "buffer" },
				{ name = "luasnip" },
			},
			mapping = cmp.mapping.preset.insert({
				["<CR>"] = cmp.mapping.confirm({ select = true }),
			}),
			window = {
				completion = cmp.config.window.bordered(),
			},
			formatting = {
				format = function(entry, vim_item)
					if vim.tbl_contains({ "path" }, entry.source.name) then
						local icon, hl_group = require("nvim-web-devicons").get_icon(entry.completion_item.label)
						if icon then
							vim_item.kind = icon
							vim_item.kind_hl_group = hl_group
							return vim_item
						end
					end

					return require("lspkind").cmp_format({ with_text = true })(entry, vim_item)
				end,
				expandable_indicator = false,
				fields = { "abbr", "kind", "menu" },
			},
		})
	end,
}
