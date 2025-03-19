local function toggle_oil()
	local oil = require("oil")
	if vim.fn.bufname():match("oil://") then
		oil.close()
	else
		local path = vim.fn.fnamemodify(vim.fn.bufname(), ":h")
		oil.open(path)
	end
end

return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local oil = require("oil")

		oil.setup({
			view_options = {
				show_hidden = true,
				is_always_hidden = function(name, _)
					return name == ".git"
				end,
			},
		})
		local wk = require("which-key")

		wk.add({
			"<leader>e",
			toggle_oil,
			desc = "Oil File Manager",
		})
	end,
}
