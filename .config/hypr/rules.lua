hl.window_rule({
	name = "windowrule-1",
	match = { class = "com.mitchellh.ghostty" },
	workspace = "1",
})

hl.window_rule({
	name = "windowrule-2",
	match = { title = "Zen Browser" },
	workspace = "2",
})

hl.window_rule({
	name = "windowrule-3",
	match = { class = "obsidian" },
	workspace = "3",
})

hl.window_rule({
	name = "windowrule-4",
	match = { class = "org.gnome.Nautilus" },
	workspace = "4",
})

hl.window_rule({
	name = "windowrule-5",
	match = { class = "Spotify" },
	workspace = "5",
})

hl.window_rule({
	name = "windowrule-6",
	match = { title = "(.*)(KiCad)(.*)$" },
	workspace = "6",
})

hl.window_rule({
	name = "windowrule-7",
	match = { title = "(.*)(Schematic Editor)$" },
	workspace = "7",
})

hl.window_rule({
	name = "windowrule-8",
	match = { title = "(.*)(PCB Editor)$" },
	workspace = "8",
})

hl.window_rule({
	name = "windowrule-9",
	match = { title = "(.*)(Oracle VirtualBox)(.*)$" },
	workspace = "10",
})

hl.window_rule({
	name = "windowrule-10",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	name = "Picture-in-Picture",
	match = { title = "Picture-in-Picture" },
	float = true,
	pin = true,
	no_initial_focus = true,
	size = "(monitor_w*0.25) (monitor_h*0.225)",
	move = "(monitor_w*0.73) (monitor_h*0.75)",
})

hl.window_rule({
	name = "File Selector",
	match = { title = "(File Upload|Save)(.*)" },
	float = true,
	center = true,
	size = "(monitor_w*0.8) (monitor_h*0.8)",
})

hl.window_rule({
	name = "windowrule-12",
	match = { class = "Brave-browser" },
	tile = true,
})
