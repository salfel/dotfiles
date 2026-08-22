local colors = {
	blue = "rgb(89b4fa)",
	overlay1 = "rgb(7f849c)",
}

require("monitors")
require("utils")
require("keybinds")
require("rules")
require("events")

hl.config({
	general = {
		gaps_in = 4,
		gaps_out = 12,
		border_size = 2,
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
		enabled = true,
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

-- Choose one preset: "subtle", "smooth", "snap", or "playful".
-- Smooth is the default: responsive windows with a gentle workspace slide.
local animation_presets = {
	subtle = {
		curve = { type = "bezier", points = { { 0.25, 1 }, { 0.35, 1 } } },
		animations = {
			{ leaf = "global", enabled = true, speed = 8, bezier = "subtle" },
			{ leaf = "windows", enabled = true, speed = 3, bezier = "subtle", style = "popin 95%" },
			{ leaf = "fade", enabled = true, speed = 3, bezier = "subtle" },
			{ leaf = "workspaces", enabled = true, speed = 3, bezier = "subtle", style = "fade" },
		},
	},

	smooth = {
		curve = { type = "bezier", points = { { 0.22, 1 }, { 0.36, 1 } } },
		animations = {
			{ leaf = "global", enabled = true, speed = 10, bezier = "default" },
			{ leaf = "border", enabled = true, speed = 4, bezier = "smooth" },
			{ leaf = "windows", enabled = true, speed = 4, bezier = "smooth", style = "popin 90%" },
			{ leaf = "windowsIn", enabled = true, speed = 4, bezier = "smooth", style = "popin 90%" },
			{ leaf = "windowsOut", enabled = true, speed = 3, bezier = "smooth", style = "popin 90%" },
			{ leaf = "fade", enabled = true, speed = 3, bezier = "smooth" },
			{ leaf = "layers", enabled = true, speed = 3, bezier = "smooth" },
			{ leaf = "layersIn", enabled = true, speed = 3, bezier = "smooth", style = "fade" },
			{ leaf = "layersOut", enabled = true, speed = 2, bezier = "smooth", style = "fade" },
			{ leaf = "workspaces", enabled = true, speed = 4, bezier = "smooth", style = "slide" },
		},
	},

	snap = {
		curve = { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } },
		animations = {
			{ leaf = "global", enabled = true, speed = 8, bezier = "default" },
			{ leaf = "border", enabled = true, speed = 3, bezier = "snap" },
			{ leaf = "windows", enabled = true, speed = 2, bezier = "snap", style = "popin 92%" },
			{ leaf = "windowsIn", enabled = true, speed = 2, bezier = "snap", style = "popin 92%" },
			{ leaf = "windowsOut", enabled = true, speed = 2, bezier = "snap", style = "slide" },
			{ leaf = "fade", enabled = true, speed = 2, bezier = "snap" },
			{ leaf = "workspaces", enabled = true, speed = 3, bezier = "snap", style = "slide" },
		},
	},

	playful = {
		curve = { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.1 } } },
		animations = {
			{ leaf = "global", enabled = true, speed = 10, bezier = "default" },
			{ leaf = "border", enabled = true, speed = 5, bezier = "playful" },
			{ leaf = "windows", enabled = true, speed = 6, bezier = "playful", style = "popin 80%" },
			{ leaf = "windowsIn", enabled = true, speed = 6, bezier = "playful", style = "popin 80%" },
			{ leaf = "windowsOut", enabled = true, speed = 5, bezier = "playful", style = "slide" },
			{ leaf = "fade", enabled = true, speed = 5, bezier = "playful" },
			{ leaf = "workspaces", enabled = true, speed = 6, bezier = "playful", style = "slidefade" },
		},
	},
}

local active_animation = "subtle"
local animation_preset = assert(animation_presets[active_animation])

hl.curve(active_animation, animation_preset.curve)
for _, animation in ipairs(animation_preset.animations) do
	hl.animation(animation)
end
