return {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    after = "catppuccin",
    config = function()
        require("bufferline").setup({
            options = {
                diagnostics = "nvim_lsp",
                diagnostics_indicator = function(count, level, _, test)
                    local icon = level:match("error") and "" or level:match("warning") and "" or ""
                    return " " .. icon .. " " .. count
                end,
                indicator = {
                    style = 'underline'
                },
            },
            highlights = require("catppuccin.groups.integrations.bufferline").get()
        })
    end
}
