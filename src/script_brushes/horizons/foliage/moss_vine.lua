local place_sides = $boolean(Place Sides, true)$
local place_corners = $boolean(Place Corner, true)$
local place_top = $boolean(Place On Top, false)$
local place_bottom = $boolean(Place On Bottom, false)$

local vine = $blockState(Vine Block, horizon:eldermoss_vine)$
local corner_vine = $blockState(Corner Vine, horizon:eldermoss_vine_corner)$

local directions = {"north", "west", "south", "east"}

local block_property = "blaze_cardinal_direction=north"
local nearby_blocks = 0
corner_found = false
top_found = false
bottom_found = false

-- Check for valid sides
if isSolid(getBlock(x, y, z-1)) then
    block_property = "blaze_cardinal_direction=north"
    nearby_blocks = nearby_blocks + 1
end
if isSolid(getBlock(x, y, z+1)) then
    block_property = "blaze_cardinal_direction=south"
    nearby_blocks = nearby_blocks + 1
end
if isSolid(getBlock(x+1, y, z)) then
    block_property = "blaze_cardinal_direction=east"
    nearby_blocks = nearby_blocks + 1
end
if isSolid(getBlock(x-1, y, z)) then
    block_property = "blaze_cardinal_direction=west"
    nearby_blocks = nearby_blocks + 1
end

-- Check for valid corner spots
if isSolid(getBlock(x, y+1, z)) then
    corner_found = true
end

-- Check for valid top spots
if isSolid(getBlock(x, y, z)) and getBlock(x,y+1,z) == blocks.air then
    top_found = true
end

-- Check for valid bottom spots
if isSolid(getBlock(x, y+1, z)) and getBlock(x,y,z) == blocks.air then
    bottom_found = true
end

-- Place top vines
if top_found and place_top then
    setBlock(x,y+1,z,withBlockProperty(vine, "blaze_attachment=bottom"))
end

-- Place bottom vines
if bottom_found and place_bottom then
    setBlock(x,y,z,withBlockProperty(vine, "blaze_attachment=top"))
end

-- Place side/corner vines
if nearby_blocks >= 1 then
    if getBlock(x, y, z) ~= blocks.air then
        return
    end

    if corner_found and place_corners then
        setBlock(x,y,z,withBlockProperty(corner_vine, block_property))
    elseif place_sides then
        setBlock(x,y,z,withBlockProperty(vine, block_property))
    end
end