local function set_tab_width(filetype, width)
	vim.api.nvim_create_autocmd("FileType", {
		pattern = filetype,
		callback = function()
			vim.bo.tabstop = width
			vim.bo.shiftwidth = width
		end,
	})
end

local function set_options(filetype, options)
	vim.api.nvim_create_autocmd("FileType", {
		pattern = filetype,
		callback = function()
			for key, value in pairs(options) do
				vim.opt_local[key] = value
			end
		end,
	})
end

local luals_settings = {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = { enable = false },
		},
	},
}

local pyright_settings = {
	settings = {
		python = {
			venvPath = ".",
			venv = "venv",
		},
	},
}

local jdtls_settings = {
	settings = {
		java = {
			configuration = {
				runtimes = {
					{
						name = "JavaSE-25",
						path = "/run/current-system/sw/lib/openjdk",
						default = true,
					},
				},
			},
		},
	},
}

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"mfussenegger/nvim-jdtls",
	},
	config = function()
		require("mason").setup({
			registries = {
				"github:mason-org/mason-registry",
				"github:Crashdummyy/mason-registry",
			},
		})
		require("mason-lspconfig").setup({
			ensure_installed = { "gopls", "intelephense", "phpactor", "astro", "pyright", "bashls" },
		})

		-- Language Servers not able to be installed through mason due to dynamic linking
		local custom_lsp_servers =
			{ "nixd", "clangd", "lua_ls", "zls", "rust_analyzer", "cmake", "ols", "jdtls", "texlab" }
		vim.lsp.enable(custom_lsp_servers)

		vim.lsp.config("lua_ls", luals_settings)
		vim.lsp.config("pyright", pyright_settings)
		vim.lsp.config("jdtls", jdtls_settings)

		-- tabs are of length 2 in nix
		set_tab_width("nix", 2)

		set_options("markdown", {
			wrap = true,
			linebreak = true,
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

		vim.filetype.add({
			extension = {
				axaml = "xml",
			},
		})
	end,
}
