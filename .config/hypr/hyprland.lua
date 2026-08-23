local colors = {
	rosewater = "#f5e0dc",
	flamingo = "#f2cdcd",
	pink = "#f5c2e7",
	mauve = "#cba6f7",
	red = "#f38ba8",
	maroon = "#eba0ac",
	peach = "#fab387",
	yellow = "#f9e2af",
	green = "#a6e3a1",
	teal = "#94e2d5",
	sky = "#89dceb",
	sapphire = "#74c7ec",
	blue = "#89b4fa",
	lavender = "#b4befe",

	text = "#cdd6f4",
	subtext1 = "#bac2de",
	subtext0 = "#a6adc8",
	overlay2 = "#9399b2",
	overlay1 = "#7f849c",
	overlay0 = "#6c7086",

	surface2 = "#585b70",
	surface1 = "#45475a",
	surface0 = "#313244",
	base = "#1e1e2e",
	mantle = "#181825",
	crust = "#11111b",
}

require("monitors")
require("utils")
require("keybinds")
require("rules")
require("events")

hl.config({
	general = {
		gaps_in = 4,
		gaps_out = 6,
		border_size = 2,
		col = {
			active_border = colors.lavender,
			inactive_border = colors.overlay1,
		},
		resize_on_border = true,
		allow_tearing = false,
		layout = "dwindle",
	},

	decoration = {
		rounding = 6,
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
