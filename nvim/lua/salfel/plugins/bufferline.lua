return {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    after = "catppuccin",
    config = function()
        require("bufferline").setup({
            options = {
                diagnostics = "nvim_lsp",
                diagnostics_indicator = function(count, level, _, _)
                    local icon = level:match("error") and "" or ""
                    return " " .. icon .. " " .. count
                end,
                indicator = {
                    style = 'underline'
                },
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        text_align = "center",
                        separator = false
                    }
                },
            },
            highlights = require("catppuccin.groups.integrations.bufferline").get()
        })
    end
}
