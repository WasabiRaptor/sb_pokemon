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
    if oldIdMap[diskStore.species] then
        diskStore.species = oldIdMap[diskStore.species]
    end
    if oldIdMap[diskStore.humanoidIdentity.species] then
        diskStore.humanoidIdentity.species = oldIdMap[diskStore.humanoidIdentity.species]
    end
    if oldIdMap[diskStore.humanoidIdentity.species] then
        diskStore.humanoidIdentity.species = oldIdMap[diskStore.humanoidIdentity.species]
    end
    local overrideSpecies = sb.jsonQuery(diskStore, "overrides.identity.species")
    if overrideSpecies then
        if oldIdMap[diskStore.overrides.identity.species] then
            diskStore.overrides.identity.species = oldIdMap[diskStore.overrides.identity.species]
        end
    end
    return old.rebuild(diskStore,e)
end
