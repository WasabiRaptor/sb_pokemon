local old = {
    rebuild = rebuild
}
local oldIdMap = {
    ["sbq/flareon"] = "wr/flareon",
    ["sbq/vaporeon"] = "wr/vaporeon",
    ["sbq/meowscarada"] = "wr/meowscarada",
    ["sbq/nickit_anthro"] = "wr/nickit",
}
function rebuild(diskStore, e)
    if oldIdMap[diskStore.identity.species] then
        diskStore.identity.species = oldIdMap[diskStore.identity.species]
    end
    return old.rebuild(diskStore,e)
end
