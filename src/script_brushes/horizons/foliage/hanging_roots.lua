local upper = $blockState(Upper Root, horizon:hanging_roots_upper)$
local lower = $blockState(Lower Root, horizon:hanging_roots_lower)$
local corner = $blockState(Corner Root, horizon:hanging_roots_large)$

local maximum_length = $int(Maximum Length,6,1,16)$
local density = $float(Placement Chance, 0.35, 0.1, 1.0)$
local place_hanging_roots = $boolean(Place Hanging Roots, true)$
local place_corner_roots = $boolean(Place Corner Roots, true)$

local corner_chance = 0.3

local length_modifier = math.random() * 0.5
local calculated_length = math.floor(maximum_length - (maximum_length * length_modifier))


-- Density check
if math.random() >= density then
    return nil
end

-- Check for valid placement
if not (isSolid(getBlock(x, y+1, z)) and getBlock(x,y,z) == blocks.air) then
    return nil
end

local block_property = "facing=north"
local nearby_blocks = 0

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

-- Janky thing to split corner/hanging roots
local do_corner = false
local do_hanging = false

if place_corner_roots and place_hanging_roots then
    if math.random() <= corner_chance then
        do_corner = true
    else
        do_hanging = true
    end
elseif place_corner_roots then
    do_corner = true
elseif place_hanging_roots then
    do_hanging = true
end


if do_corner and nearby_blocks >= 1 then
    setBlock(x,y,z, withBlockProperty(corner, block_property))
end


if do_hanging then
    for i = 0, calculated_length do
        if getBlock(x, y-i, z) ~= blocks.air then
            setBlock(x,y-i+1,z,lower)
            break
        end

        if i == (calculated_length - 1) then
            setBlock(x,y-i,z,lower)
            break
        end
        setBlock(x,y-i,z,upper)

    end
end
