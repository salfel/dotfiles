local colors = {
	blue = "rgb(89b4fa)",
	overlay1 = "rgb(7f849c)",
}

require("lua/monitors")
require("lua/autostart")
require("lua/keybinds")
require("lua/rules")

hl.config({
	general = {
		gaps_in = 4,
		gaps_out = 8,
		border_size = 1,
		col = {
			active_border = colors.blue,
			inactive_border = colors.overlay1,
		},
		resize_on_border = true,
		allow_tearing = false,
		layout = "dwindle",
	},

	decoration = {
		rounding = 0,
		blur = {
			enabled = false,
		},
	},

	animations = {
		enabled = false,
	},

	dwindle = {
		preserve_split = true,
	},

	master = {
		new_status = "master",
	},

	misc = {
		disable_hyprland_logo = true,
		focus_on_activate = true,
	},

	input = {
		kb_layout = "us,de",
		kb_variant = "",
		kb_model = "",
		kb_rules = "",
		follow_mouse = 1,
		sensitivity = 0,
		touchpad = {
			natural_scroll = false,
		},
	},
})
