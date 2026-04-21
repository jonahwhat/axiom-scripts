-- places glow lichen on walls similar to the vines brush
-- also works underwater!

if getBlock(x, y, z) ~= blocks.air and getBlock(x, y, z) ~= blocks.water then
	return
end

local glow_lichen = blocks.glow_lichen

if getBlock(x, y, z) == blocks.water then
    glow_lichen = withBlockProperty(glow_lichen, "waterlogged=true")
end
if isSolid(getBlock(x, y, z-1)) then
	glow_lichen = withBlockProperty(glow_lichen, "north=true")
end
if isSolid(getBlock(x, y, z+1)) then
	glow_lichen = withBlockProperty(glow_lichen, "south=true")
end
if isSolid(getBlock(x+1, y, z)) then
	glow_lichen = withBlockProperty(glow_lichen, "east=true")
end
if isSolid(getBlock(x-1, y, z)) then
	glow_lichen = withBlockProperty(glow_lichen, "west=true")
end
if isSolid(getBlock(x, y+1, z)) then
	glow_lichen = withBlockProperty(glow_lichen, "up=true")
end
if isSolid(getBlock(x, y-1, z)) then
	glow_lichen = withBlockProperty(glow_lichen, "down=true")
end

-- terrible check to get rid of weird waterlogged blocks
local function hasNoSolidSides(block) 
    return getBlockProperty(glow_lichen, "west") == "false" and
    getBlockProperty(glow_lichen, "east") == "false" and
    getBlockProperty(glow_lichen, "north") == "false" and
    getBlockProperty(glow_lichen, "south") == "false" and
    getBlockProperty(glow_lichen, "up") == "false" and
    getBlockProperty(glow_lichen, "down") == "false"
end

if getBlockProperty(glow_lichen, "waterlogged") == "true" and hasNoSolidSides(glow_lichen) then
    return
end

if glow_lichen ~= blocks.glow_lichen then
	return glow_lichen
end
