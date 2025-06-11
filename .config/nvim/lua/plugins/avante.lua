return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false, -- Never set this value to "*"! Never!
	opts = {
		provider = "openai",
		providers = {
			openai = {
				endpoint = "https://api.openai.com/v1",
				model = "gpt-4.1-mini", -- your desired model (or use gpt-4o, etc.)
				extra_request_body = {
					temperature = 0,
					max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
				},
			},
		},
		file_selector = "telescope", -- Set telescope as file picker
	},
	build = "make",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
				},
			},
		},
	},
}
