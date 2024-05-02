return {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
        "zbirenbaum/copilot.lua",
        "nvim-lua/plenary.nvim"
    },
    opts = {
        debug = true
    },
    config = function ()
        require("CopilotChat").setup()
        local wk = require("which-key")
        wk.register({
            g = {
                name = "Copilot",
                c = { "<cmd>CopilotChat<cr>", "Open Copilot Chat" }
            }
        }, { prefix = "<leader>"})
    end
}
