return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v3.x",
	dependencies = {
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"onsails/lspkind.nvim",
	},
	config = function()
		local lsp_zero = require("lsp-zero")
		local wk = require("which-key")
		local utils = require("salfel/utils")

		local function on_attach(_, bufnr)
			lsp_zero.default_keymaps({ bufnr = bufnr })
		end

		lsp_zero.on_attach = on_attach

		vim.g.rustaceanvim = {
			server = {
				on_attach = on_attach,
				capabilities = lsp_zero.get_capabilities(),
				["rust-analyzer"] = { "rust" },
			},
		}

		wk.add({
			{ "<leader>rn", vim.lsp.buf.rename, desc = "Rename" },
		})

		require("mason").setup({})
		require("mason-lspconfig").setup({
			ensure_installed = { "gopls", "intelephense", "phpactor", "astro" },
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end,
				lua_ls = function()
					require("lspconfig").lua_ls.setup({})
				end,
			},
		})

		-- needed for rustaceanvim
		lsp_zero.format_on_save({
			servers = {
				["rust-analyzer"] = { "rust" },
			},
		})

		require("lspconfig").lua_ls.setup({
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
						},
					},
					format = {
						enable = false,
					},
				},
			},
		})

		local custom_lsp_servers = { "nixd", "ccls" }

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

		vim.keymap.set("n", "[d", ":lua vim.diagnostic.goto_prev()<CR>")
		vim.keymap.set("n", "]d", ":lua vim.diagnostic.goto_next()<CR>")
		vim.keymap.set("n", "gd", ":lua vim.lsp.buf.definition()<CR>")
		vim.keymap.set("n", "ga", ":lua vim.lsp.buf.code_action()<CR>")
		vim.keymap.set("n", "gr", ":lua vim.lsp.buf.references()<CR>")
		vim.keymap.set("n", "gl", ":lua vim.diagnostic.open_float()<CR>")
		vim.keymap.set("n", "K", ":lua vim.lsp.buf.hover()<CR>")
		vim.keymap.set("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>")

		vim.keymap.set("n", "<C-n>", function()
			local quickFix = utils.getQuickFix()

			if quickFix.open then
				if quickFix.current == quickFix.length then
					vim.cmd("cc1")
				else
					vim.cmd("cnext")
				end
			end
		end)
		vim.keymap.set("n", "<C-p>", function()
			local quickFix = utils.getQuickFix()

			if quickFix.open then
				if quickFix.current == 1 then
					vim.cmd("cc" .. quickFix.length)
				else
					vim.cmd("cprev")
				end
			end
		end)

		local cmp = require("cmp")

		cmp.setup({
			sources = {
				{ name = "path" },
				{ name = "nvim_lsp" },
				{ name = "nvim_lua" },
				{ name = "buffer" },
				{ name = "luasnip" },
				{ name = "supermaven" },
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
