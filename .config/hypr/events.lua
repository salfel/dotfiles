local applications = require("applications")

hl.on("hyprland.start", function()
	local cmds = { "hyprpaper", "hypridle", "hyprsunset", "waybar", "nm-applet", "swayosd-server" }

	hl.exec_cmd(applications.browser)
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
	hl.exec_cmd('hyprctl setcursor "Banana-Catppuccin-Mocha" 64')

	for _, cmd in ipairs(cmds) do
		hl.exec_cmd(cmd)
	end
end)

hl.on("window.open", function(window)
	if window.class == "gcr-prompter" then
		hl.dispatch(hl.dsp.window.close(window))
	end
end)
