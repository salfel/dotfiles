local default_monitor_config = {
	output = "eDP-1",
	mode = "preferred",
	position = "0x0",
	scale = 1.3333,
}

hl.monitor(default_monitor_config)

hl.monitor({
	output = "desc:Dell Inc. DELL U2724DE 6WHM8P3",
	mode = "preferred",
	position = "1692x0",
	scale = 1,
})

hl.monitor({
	output = "desc:AOC U27B3A ZXLR3HA001353",
	mode = "preferred",
	position = "1692x0",
	scale = 1.5,
})

hl.monitor({
	output = "desc:Samsung Electric Company SyncMaster",
	mode = "preferred",
	position = "1692x0",
	scale = 1,
})

hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = 1,
})

return {
	default = default_monitor_config,
}
