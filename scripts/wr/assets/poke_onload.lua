local races = {
	"wr/flareon",
	"wr/vaporeon",
	"wr/luxio",
	"wr/nickit",
	"wr/meowscarada"
}

for _, species in ipairs(races) do
	local speciesConfig = assets.json("/species/" .. species .. ".species")
	assets.patch("/interface/windowconfig/charcreation.config",
		'[{"op":"add","path":"/speciesOrdering/-","value":"' .. species .. '"}]')
	assets.patch("/universe_server.config", sb.printJson({
		speciesShips = {
			[species] = speciesConfig.ships or {
				"/ships/novakid/novakidt0.structure",
				"/ships/novakid/novakidt1.structure",
				"/ships/novakid/novakidt2.structure",
				"/ships/novakid/novakidt3.structure",
				"/ships/novakid/novakidt4.structure",
				"/ships/novakid/novakidt5.structure",
				"/ships/novakid/novakidt6.structure",
				"/ships/novakid/novakidt7.structure",
				"/ships/novakid/novakidt8.structure"
			}
		}
	}))
	assets.patch("/ai/ai.config", sb.printJson({
		speciesShips = {
			[species] = speciesConfig.ai or {
				aiFrames = "NovakidAI.png",
				portraitFrames = "portraits/novakidportrait.png",
				staticFrames = "staticGlitch.png"
			}
		}
	}))
	assets.patch("/player.config", sb.printJson({
		defaultCodexes = {
			[species] = speciesConfig.defaultCodexes or { "protectorate1", "protectorate2" }
		}
	}))

	if not assets.exists("/cinematics/teleport/deploy_" .. species .. ".cinematic") then
		assets.add("/cinematics/teleport/deploy_" .. species .. ".cinematic",
			assets.bytes(speciesConfig.deployCinematic, "/cinematics/teleport/deploy_wr/template.cinematic"):gsub(
			"%<species%>", species):gsub("%<effectDirectives%>", speciesConfig.effectDirectives))
	end
	if not assets.exists("/cinematics/teleport/teleport_" .. species .. ".cinematic") then
		assets.add("/cinematics/teleport/teleport_" .. species .. ".cinematic",
			assets.bytes(speciesConfig.teleportCinematic, "/cinematics/teleport/teleport_wr/template.cinematic"):gsub(
			"%<species%>", species):gsub("%<effectDirectives%>", speciesConfig.effectDirectives))
	end
	if not assets.exists("/cinematics/respawn/" .. species .. "/respawncasual.cinematic") then
		assets.add("/cinematics/respawn/" .. species .. "/respawncasual.cinematic",
			assets.bytes(speciesConfig.teleportCinematic, "/cinematics/respawn/wr/template/respawncasual.cinematic")
			:gsub("%<species%>", species):gsub("%<effectDirectives%>", speciesConfig.effectDirectives))
	end
	if not assets.exists("/cinematics/respawn/" .. species .. "/respawnsurvival.cinematic") then
		assets.add("/cinematics/respawn/" .. species .. "/respawnsurvival.cinematic",
			assets.bytes(speciesConfig.teleportCinematic, "/cinematics/respawn/wr/template/respawnsurvival.cinematic")
			:gsub("%<species%>", species):gsub("%<effectDirectives%>", speciesConfig.effectDirectives))
	end

	if not assets.exists("/interface/ai/suits/" .. species .. "-female.png") then
		assets.add("/interface/ai/suits/" .. species .. "-female.png",
			assets.image("/interface/ai/suits/wr/template-female.png"))
	end
	if not assets.exists("/interface/ai/suits/" .. species .. "-male.png") then
		assets.add("/interface/ai/suits/" .. species .. "-male.png",
			assets.image("/interface/ai/suits/wr/template-male.png"))
	end

    if not assets.exists("/scripted/techupgrade/suits/" .. species .. "-female.png") then
        assets.add("/scripted/techupgrade/suits/" .. species .. "-female.png",
            assets.image("/scripted/techupgrade/suits/wr/template-female.png"))
    end
	if not assets.exists("/scripted/techupgrade/suits/" .. species .. "-female-body.png") then
		assets.add("/scripted/techupgrade/suits/" .. species .. "-female-body.png",
			assets.image("/scripted/techupgrade/suits/wr/template-female-body.png"))
	end
	if not assets.exists("/scripted/techupgrade/suits/" .. species .. "-female-head.png") then
		assets.add("/scripted/techupgrade/suits/" .. species .. "-female-head.png",
			assets.image("/scripted/techupgrade/suits/wr/template-female-head.png"))
	end
	if not assets.exists("/scripted/techupgrade/suits/" .. species .. "-female-legs.png") then
		assets.add("/scripted/techupgrade/suits/" .. species .. "-female-legs.png",
			assets.image("/scripted/techupgrade/suits/wr/template-female-legs.png"))
	end

	if not assets.exists("/scripted/techupgrade/suits/" .. species .. "-male.png") then
        assets.add("/scripted/techupgrade/suits/" .. species .. "-male.png",
            assets.image("/scripted/techupgrade/suits/wr/template-male.png"))
    end
	if not assets.exists("/scripted/techupgrade/suits/" .. species .. "-male-body.png") then
		assets.add("/scripted/techupgrade/suits/" .. species .. "-male-body.png",
			assets.image("/scripted/techupgrade/suits/wr/template-male-body.png"))
	end
	if not assets.exists("/scripted/techupgrade/suits/" .. species .. "-male-head.png") then
		assets.add("/scripted/techupgrade/suits/" .. species .. "-male-head.png",
			assets.image("/scripted/techupgrade/suits/wr/template-male-head.png"))
	end
	if not assets.exists("/scripted/techupgrade/suits/" .. species .. "-male-legs.png") then
		assets.add("/scripted/techupgrade/suits/" .. species .. "-male-legs.png",
			assets.image("/scripted/techupgrade/suits/wr/template-male-legs.png"))
	end

	if not assets.exists("/ai/portraits/"..species.."questportrait.png") then
		assets.add("/ai/portraits/"..species.."questportrait.png",
			assets.image("/ai/portraits/novakidquestportrait.png"))
	end

end
