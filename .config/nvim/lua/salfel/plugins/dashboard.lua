return {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = {
        theme = "doom",
        config = {
            header = {
                '',
                '',
                '',
                '',
                '',
                '',
                ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
                ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
                ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
                ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
                ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
                ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
                '',
                '',
                '',
            },
            center = {
                { icon = "   ", desc = "File Explorer", key = "Space + n", action = "NvimTreeOpen" },
                { icon = "   ", desc = 'Find Files', key = "Space + ff", action = "Telescope find_files"},
                { icon = "   ", desc = "Recent Files", key = "Space + fh", action = "Telescope oldfiles"},
                { icon = "   ", desc = "Find Word", key = "Space + fg", action = "Telescope live_grep"}
            },
        }
    },
    dependencies = { "nvim-tree/nvim-web-devicons" }
}
