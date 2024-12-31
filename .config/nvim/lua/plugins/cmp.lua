return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
        "onsails/lspkind.nvim",
    },
    config = function()
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
