local old = {
	build = build
}
function build(identity, humanoidParameters, humanoidConfig, npcHumanoidConfig)
	local speciesConfig = root.speciesConfig(identity.species)
	local merged = sb.jsonMerge(humanoidConfig, humanoidParameters)
	if merged.bodyType and speciesConfig.bodyTypeHumanoidConfig[merged.bodyType] then
		humanoidConfig = sb.jsonMerge(root.assetJson(speciesConfig.bodyTypeHumanoidConfig[merged.bodyType].base), speciesConfig.bodyTypeHumanoidConfig[merged.bodyType].overrides)
	end
	humanoidConfig = old.build(identity, humanoidParameters, humanoidConfig, npcHumanoidConfig)
	for k, v in ipairs(humanoidConfig.particleEmitters.deathPoof.particles) do
		v.particle.animation = v.particle.animation..speciesConfig.effectDirectives
	end
	return humanoidConfig
end
