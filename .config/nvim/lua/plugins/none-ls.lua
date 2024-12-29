return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

        local checkRoot = function(utils, files)
            for _, file in ipairs(files) do
                if utils.root_has_file(file) then
                    return true
                end
            end
            return false
        end

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.biome.with({
                    condition = function(utils)
                        return utils.root_has_file("biome.json")
                    end,
                }),
                null_ls.builtins.formatting.pint.with({
                    condition = function(utils)
                        return checkRoot(utils, { "pint.json", "vendor/bin/pint" })
                    end,
                }),
                -- null_ls.builtins.formatting.stylua,
                -- Rust formatting
                null_ls.builtins.formatting.dxfmt,
                null_ls.builtins.formatting.nixfmt,
                null_ls.builtins.formatting.gofmt,
                null_ls.builtins.formatting.prettier.with({
                    extra_filetypes = { "astro" },
                    condition = function(utils)
                        return checkRoot(utils, {
                            ".prettierrc",
                            ".prettierrc.json",
                            ".prettierrc.yaml",
                            ".prettierrc.yml",
                            ".prettierrc.js",
                            ".prettierrc.cjs",
                            ".prettierrc.mjs",
                            "prettier.config.js",
                            "prettier.config.cjs",
                            "prettier.config.mjs",
                            "prettier.config.ts",
                        })
                    end,
                }),
            },
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({
                        group = augroup,
                        buffer = bufnr,
                    })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ async = false })
                        end,
                    })
                end
            end,
        })
    end,
}
