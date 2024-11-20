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

		lsp_zero.format_on_save({
			servers = {
				["rust-analyzer"] = { "rust" },
				["gopls"] = { "go" },
				["stylua"] = { "lua" },
			},
		})

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

		require("lspconfig").nixd.setup({
			cmd = { "nixd" },
			settings = {
				nixd = {
					nixpkgs = "import <nixpkgs> { }",
				},
				formatting = {
					command = "nixfmt",
				},
			},
		})

		-- tabs are of length 2 in nix
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "nix",
			callback = function()
				vim.bo.tabstop = 2
				vim.bo.shiftwidth = 2
			end,
		})

		vim.keymap.set("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>")
		vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
		vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")
		vim.keymap.set("n", "gd", ":Telescope lsp_definitions<CR>")
		vim.keymap.set("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>")
		vim.keymap.set("n", "gi", ":Telescope lsp_implementations<CR>")
		vim.keymap.set("n", "gr", ":Telescope lsp_references<CR>")
		vim.keymap.set("n", "gl", ":lua vim.diagnostic.open_float()<CR>")
		vim.keymap.set("n", "<leader>lr", ":LspRestart<CR>", { silent = true })
		vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
		vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")

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
						local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
						if icon then
							vim_item.kind = icon
							vim_item.kind_hl_group = hl_group
							return vim_item
						end
					end

					return require("lspkind").cmp_format({ with_text = true })(entry, vim_item)
				end,
			},
		})
	end,
}
