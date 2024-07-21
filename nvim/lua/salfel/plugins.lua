local utils = require("salfel/utils")

local plugins = utils.requirePlugins({
    "which-key",
    "telescope",
    "catppuccin",
    "bufferline",
    "oil",
    "lualine",
    "gitsigns",
    "treesitter",
    "lsp-zero",
    "rustaceanvim",
    "none-ls",
    "bufdelete",
    -- "supermaven"
}, {
    "tpope/vim-surround",
    { "windwp/nvim-autopairs",               config = true },
    "farmergreg/vim-lastplace",
    "christoomey/vim-tmux-navigator",
    "alvan/vim-closetag",
    "ku1ik/vim-pasta",
    "tpope/vim-unimpaired",
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
})

require("lazy").setup(plugins)
