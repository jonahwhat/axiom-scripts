local maximum_length = $int(Maximum Length,4,1,16)$
local density = $float(Placement Chance, 0.8, 0.1, 1.0)$
local place_sides = $boolean(Place Sides, true)$
local place_corners = $boolean(Place Corner, true)$
local place_top = $boolean(Place On Top, false)$
local place_bottom = $boolean(Place On Bottom, false)$

local vine = $blockState(Vine, horizon:sylvan_ivy)$
local bottom_vine = $blockState(Bottom Vine, horizon:sylvan_ivy_bottom)$
local corner_vine = $blockState(Corner Vine, horizon:sylvan_ivy_corner)$

local directions = {"north", "west", "south", "east"}
local random_vine = withBlockProperty(vine, "facing=" .. directions[math.random(#directions)])

local length_modifier = math.random() * 0.5
local calculated_length = math.floor(maximum_length - (maximum_length * length_modifier))
local fix_bottom_count = 2 * maximum_length

local block_property = "facing=north"
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
    block_property = "facing=north"
    nearby_blocks = nearby_blocks + 1
end
if isSolid(getBlock(x, y, z+1)) then
    block_property = "facing=south"
    nearby_blocks = nearby_blocks + 1
end
if isSolid(getBlock(x+1, y, z)) then
    block_property = "facing=east"
    nearby_blocks = nearby_blocks + 1
end
if isSolid(getBlock(x-1, y, z)) then
    block_property = "facing=west"
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
    setBlock(x,y+1,z,withBlockProperty(random_vine, "blaze_attachment=bottom"))
end

-- Place bottom vines
if bottom_found and place_bottom then
    setBlock(x,y,z,withBlockProperty(random_vine, "blaze_attachment=top"))
end

-- Place side/corner vines
if nearby_blocks >= 1 then
    for i = 0, calculated_length do
        if getBlock(x, y-i, z) ~= blocks.air then
            break
        end

        if i == (calculated_length) then
            setBlock(x,y-i,z,withBlockProperty(bottom_vine, block_property))
            break
        end
        
        if corner_found and i == 0 and place_corners then
            setBlock(x,y-i,z,withBlockProperty(corner_vine, block_property))
        elseif place_sides then
            setBlock(x,y-i,z,withBlockProperty(vine, block_property))
        end
    end

    -- Janky fix to remove extra vines
    for i = calculated_length + 1, calculated_length + fix_bottom_count do
        if getBlock(x, y-i, z) == blocks.air then
            setBlock(x,y-i,z, blocks.air)
        end
    end

end