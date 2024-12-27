local function getQuickFix()
	local open = false

	for _, win in ipairs(vim.fn.getwininfo()) do
		if win.quickfix == 1 then
			open = true
		end
	end

	return {
		open = open,
		current = vim.fn.getqflist({ idx = 0 }).idx,
		length = #vim.fn.getqflist(),
	}
end

return {
	getQuickFix = getQuickFix,
}
