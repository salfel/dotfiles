local apps = require("lua/applications")

local main_mod = "SUPER"

local function workspace_switch_sceen()
	local active_monitor = hl.get_active_monitor().name

	for _, monitor in ipairs(hl.get_monitors()) do
		if monitor.name ~= active_monitor then
			hl.dispatch(hl.dsp.workspace.move({ workspace = hl.get_active_workspace(), monitor = monitor }))
		end
	end
end

local function toggle_integrated_screen()
	local default_monitor = require("lua/monitors").default
	local monitors = hl.get_monitors()

	hl.monitor({ output = default_monitor.output, disabled = #monitors >= 2 })
end

hl.bind(main_mod .. " + Return", hl.dsp.exec_cmd(apps.terminal))
hl.bind(main_mod .. " + B", hl.dsp.exec_cmd(apps.browser))
hl.bind(main_mod .. " + O", hl.dsp.exec_cmd(apps.obsidian))
hl.bind(main_mod .. " + Q", hl.dsp.window.close())
hl.bind(main_mod .. " + M", hl.dsp.exec_cmd("hyprlock"))
hl.bind(main_mod .. " + N", hl.dsp.exec_cmd("networkmanager"))
hl.bind(main_mod .. " + W", workspace_switch_sceen)
hl.bind(main_mod .. " + SHIFT + W", toggle_integrated_screen)
hl.bind(main_mod .. " + E", hl.dsp.exec_cmd(apps.file_manager))
hl.bind(main_mod .. " + R", hl.dsp.exec_cmd(apps.menu))
hl.bind(main_mod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(main_mod .. " + F", hl.dsp.exec_cmd("hyprctl dispatch fullscreen 0"))
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind(main_mod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind(main_mod .. " + SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region"))

for i = 1, 10 do
	local key = tostring(i % 10)
	hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Switch window
for _, pair in ipairs({
	{ "left", "l" },
	{ "right", "r" },
	{ "up", "u" },
	{ "down", "d" },
	{ "H", "l" },
	{ "J", "d" },
	{ "K", "u" },
	{ "L", "r" },
}) do
	hl.bind(main_mod .. " + " .. pair[1], hl.dsp.focus({ direction = pair[2] }))
end

-- Move window
for _, pair in ipairs({
	{ "H", "l" },
	{ "J", "d" },
	{ "K", "u" },
	{ "L", "r" },
}) do
	hl.bind(main_mod .. " + SHIFT + " .. pair[1], hl.dsp.window.move({ direction = pair[2] }))
end

hl.bind(main_mod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(main_mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(main_mod .. " + X", hl.dsp.exec_cmd("hyprctl switchxkblayout all next"), { locked = true })

local function osd_action(action, cmd)
	return function()
		local command = "swayosd-client --monitor " .. hl.get_active_monitor().name .. " --" .. action .. " " .. cmd

		hl.dispatch(hl.dsp.exec_cmd(command))
	end
end

hl.bind("XF86AudioRaiseVolume", osd_action("output-volume", "raise"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", osd_action("output-volume", "lower"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", osd_action("output-volume", "mute-toggle"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", osd_action("playerctl", "next"), { locked = true })
hl.bind("XF86AudioPause", osd_action("playerctl", "play-pause"), { locked = true })
hl.bind("XF86AudioPlay", osd_action("playerctl", "play-pause"), { locked = true })
hl.bind("XF86AudioPrev", osd_action("playerctl", "previous"), { locked = true })

hl.bind("XF86MonBrightnessUp", osd_action("brightness", "raise"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", osd_action("brightness", "lower"), { locked = true, repeating = true })
