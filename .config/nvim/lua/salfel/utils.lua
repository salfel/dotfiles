local function requirePlugins(plugins, finalPlugins)
	local newTable = {}

	for _, value in pairs(plugins) do
		table.insert(newTable, require("salfel/plugins/" .. value))
	end

	for _, value in pairs(finalPlugins) do
		table.insert(newTable, value)
	end

	return newTable
end

local function isQuickFixOpen()
	for _, win in ipairs(vim.fn.getwininfo()) do
		if win.quickfix == 1 then
			return true
		end
	end

	return false
end

return {
	requirePlugins = requirePlugins,
	isQuickFixOpen = isQuickFixOpen,
}
