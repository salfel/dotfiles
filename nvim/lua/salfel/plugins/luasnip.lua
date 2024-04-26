return {
    "L3MON4D3/LuaSnip",
    tag = "2.*",
    build = "make install jsregexp",
    config = function()
        require("luasnip.loaders.from_vscode").load()
    end
}
