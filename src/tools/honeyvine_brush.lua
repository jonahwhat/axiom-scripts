-- Axiom Variables
local maximum_length = $int(Maximum Length,4,1,16)$
local density = $float(Placement Chance, 0.8, 0.1, 1.0)$
local flowering_density = $float(Flowering Density, 0.3, 0.0, 1.0)$
local place_sides = $boolean(Place Sides, true)$
local place_corners = $boolean(Place Corner, true)$
local place_top = $boolean(Place On Top, false)$
local place_bottom = $boolean(Place On Bottom, false)$

local vine = blocks.horizon.honeyvine
local corner_vine = blocks.horizon.honeyvine_corner
local flowering_vine = blocks.horizon.honeyvine_flowering

local directions = {"north", "west", "south", "east"}
local random_vine = withBlockProperty(blocks.horizon.honeyvine, "blaze_cardinal_direction=" .. directions[math.random(#directions)])
local random_flowering_vine = withBlockProperty(blocks.horizon.honeyvine_flowering, "blaze_cardinal_direction=" .. directions[math.random(#directions)])

local length_modifier = math.random() * 0.5
local calculated_length = math.floor(maximum_length - (maximum_length * length_modifier))

local block_property = "blaze_cardinal_direction=north"
local nearby_blocks = 0
corner_found = false
top_found = false
bottom_found = false

-- Density check
if math.random() >= density then
    return nil
end

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
    if math.random() >= flowering_density then
        setBlock(x,y+1,z,withBlockProperty(random_vine, "blaze_attachment=bottom"))
    else
        setBlock(x,y+1,z,withBlockProperty(random_flowering_vine, "blaze_attachment=bottom"))
    end
end

-- Place bottom vines
if bottom_found and place_bottom then
    if math.random() >= flowering_density then
        setBlock(x,y,z,withBlockProperty(random_vine, "blaze_attachment=top"))
    else
        setBlock(x,y,z,withBlockProperty(random_flowering_vine, "blaze_attachment=top"))
    end
end

-- Place side/corner vines
if nearby_blocks >= 1 then
    for i = 0, calculated_length do
        if getBlock(x, y-i, z) ~= blocks.air then
            break
        end
        
        if corner_found and i == 0 and place_corners then
            setBlock(x,y-i,z,withBlockProperty(corner_vine, block_property))
        elseif math.random() >= flowering_density and place_sides then
            setBlock(x,y-i,z,withBlockProperty(vine, block_property))
        elseif place_sides then
            setBlock(x,y-i,z,withBlockProperty(flowering_vine, block_property))
        end
    end

end