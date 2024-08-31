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

return {
    requirePlugins = requirePlugins
}
