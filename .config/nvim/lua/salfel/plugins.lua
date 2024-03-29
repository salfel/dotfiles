local function requirePlugins(plugins, finalPlugins)
    local newTable = {}

    for _, value in pairs(plugins) do
        table.insert(newTable, require("salfel/plugins/" .. value))
    end

    for _, value in pairs(finalPlugins) do
        table.insert(newTable, value)
    end

    return newTable
end

require("lazy").setup(requirePlugins({
    "catppuccin",
    "telescope",
    "nvim-tree",
    "lualine",
    "treesitter",
    "bufferline",
    "bufdelete",
    "lspconfig",
    "cmp",
    "gitsigns",
    "floaterm",
    "dashboard",
    "luasnip",
    "silicon"
}, {
    "tpope/vim-surround",
    "tpope/vim-commentary",
    { "windwp/nvim-autopairs", config = true},
    "farmergreg/vim-lastplace",
    "ku1ik/vim-pasta",
    "lewis6991/gitsigns.nvim",
    "tpope/vim-unimpaired",
    "github/copilot.vim",
    "christoomey/vim-tmux-navigator",
    "tpope/vim-fugitive"
}))
