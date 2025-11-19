require "/scripts/rect.lua"
require "/scripts/poly.lua"

local fade = 255
local fading = false
local checkRects = {}
local fadeSpeed = 1
function init()
	for _, v in ipairs(config.getParameter("checkRects")) do
		table.insert(checkRects, rect.translate(v, object.position()))
	end
	fadeSpeed = config.getParameter("fadeSpeed", 1)
end
function update(dt)
	if world.pointTileCollision(entity.position(), { "Null" }) then return end
	fading = false
	for _, v in ipairs(checkRects) do
		local entities = world.playerQuery(rect.ll(v), rect.ur(v))
		world.debugPoly({rect.ll(v),rect.lr(v),rect.ur(v),rect.ul(v)},{255,255,0})
		if entities and entities[1] then fading = true break end
	end
	if fading then
		fade = math.max(fade-(255*dt*fadeSpeed),0)
	else
		fade = math.min(fade+(255*dt*fadeSpeed),255)
	end
	animator.setGlobalTag("fg_fade", "?multiply=FFFFFF"..string.format("%02x", math.floor(fade)))

end
