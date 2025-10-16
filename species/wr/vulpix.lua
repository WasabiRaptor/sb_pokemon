-- these are just the names of the variables internally and how they're used on the creation screen, do whatever you want with them here!
-- but probably put name species and gender as the ones supplied, thats probably a good idea
-- I've supplied the bare minimum as a template here, do with it what you will
local function wrap(index, length, secondary, secondaryLength)
	if not index then
		index = math.floor(wrap(secondary, secondaryLength * length) / secondaryLength)
	end
	if index < length then return index end
	return math.fmod(index, length)
end
function create(name, species, genderIndex, furColor, hairColor, pawsColor, hairStyle, bellyColor, markingsColor, eyeColor, pantsColor, personality, tailMarkingsColor, ...)
	-- these values are zero indexed!

	local speciesConfig = root.speciesConfig(species)
	local humanoidConfig = sb.jsonMerge(root.assetJson(speciesConfig.humanoidConfig or "/humanoid.config"), speciesConfig.humanoidOverrides or {})

	tailMarkingsColor = wrap(tailMarkingsColor, #speciesConfig.tailMarkingsColor, markingsColor, #speciesConfig.markingsColor)

	genderIndex = wrap(genderIndex, #speciesConfig.genders)
	furColor = wrap(furColor, #speciesConfig.furColor)
	pawsColor = wrap(pawsColor, #speciesConfig.pawsColor)
	bellyColor = wrap(bellyColor, #speciesConfig.bellyColor)
	hairColor = wrap(hairColor, #speciesConfig.hairColor)
	eyeColor = wrap(eyeColor, #speciesConfig.eyeColor)
	hairStyle = wrap(hairStyle, #speciesConfig.hairStyle)
	markingsColor = wrap(markingsColor, #speciesConfig.markingsColor)
	personality = wrap(personality, #humanoidConfig.personalities)

	local directives = ""

	directives = directives..(speciesConfig.bellyColor[bellyColor+1])
	directives = directives..(speciesConfig.tailMarkingsColor[tailMarkingsColor+1])
	directives = directives..(speciesConfig.markingsColor[markingsColor+1])
	directives = directives..(speciesConfig.furColor[furColor+1])
	directives = directives..(speciesConfig.pawsColor[pawsColor+1])
	directives = directives..(speciesConfig.hairColor[hairColor+1])
	directives = directives..(speciesConfig.eyeColor[eyeColor+1])

	local personalityIdle, personalityArmIdle, personalityHeadOffset, personalityArmOffset = table.unpack(humanoidConfig.personalities[personality+1])

	local identity = {
		name = name,
		species = species,
		gender = speciesConfig.genders[genderIndex+1].name,
		hairGroup = "hair",
		hairType = speciesConfig.hairStyle[hairStyle+1],
		hairDirectives = directives,
		bodyDirectives = directives,
		emoteDirectives = directives,
		facialHairGroup = "",
		facialHairType = "",
		facialHairDirectives = directives,
		facialMaskGroup = "",
		facialMaskType = "",
		facialMaskDirectives = directives,
		personalityIdle = personalityIdle,
		personalityArmIdle = personalityArmIdle,
		personalityHeadOffset = personalityHeadOffset,
		personalityArmOffset = personalityArmOffset,
		color = {51, 117, 237, 255},
	}
	local parameters = {
		choices = { genderIndex, furColor, hairColor, pawsColor, hairStyle, bellyColor, markingsColor, eyeColor, pantsColor, personality, ... },
		--this you can do a lot with, see the humanoid build script
	}
	local armor = {
		head = nil,
		chest = nil,
		legs = nil,
		back = nil,
		headCosmetic = nil,
		chestCosmetic = nil,
		legsCosmetic = nil,
		backCosmetic = nil,
		cosmetic1 = nil,
		cosmetic2 = nil,
		cosmetic3 = nil,
		cosmetic4 = nil,
		cosmetic5 = nil,
		cosmetic6 = nil,
		cosmetic7 = nil,
		cosmetic8 = nil,
		cosmetic9 = nil,
		cosmetic10 = nil,
		cosmetic11 = nil,
		cosmetic12 = nil,
	}
	return identity, parameters, armor
end
