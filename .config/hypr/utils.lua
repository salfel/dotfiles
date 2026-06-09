local function workspace_switch_screen()
	local active_monitor = hl.get_active_monitor().name

	for _, monitor in ipairs(hl.get_monitors()) do
		if monitor.name ~= active_monitor then
			hl.dispatch(hl.dsp.workspace.move({ workspace = hl.get_active_workspace(), monitor = monitor }))
		end
	end
end

return {
	workspace_switch_screen = workspace_switch_screen,
}
