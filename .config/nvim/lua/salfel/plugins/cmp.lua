return {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "saadparwaiz1/cmp_luasnip" },
    config = function()
        local cmp = require("cmp")

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end
            },
            mapping = cmp.mapping.preset.insert({
                ['<CR>'] = cmp.mapping.confirm({ select = true })
            }),

            sources = cmp.config.sources({
                { name = "path" },
                { name = "nvim_lsp" },
                { name = "nvim_lua" },
                { name = "buffer" },
                { name = "luasnip" }
            })
        })

        cmp.setup.filetype("gitcommit", {
            sources = cmp.config.sources({
                { name = "git" }
            }, {
                { name = "buffer"}
            })
        })
    end
}
