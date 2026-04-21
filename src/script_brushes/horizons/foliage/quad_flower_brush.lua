-- Recommended Settings 
-- - Cylinder Shape
-- - Radius 1-2, Height 5

-- Axiom Variables
local flower = $blockState(Quad Flower, horizon:meadowlets)$
local density = $float(Density, 0.3, 0.0, 1.0)$
local place_new_flowers = $boolean(Add New Flowers, true)$
local grow_flowers = $boolean(Grow Flowers, true)$
local rotate_flowers = $boolean(Smart Rotate Poppies, true)$

local increase_flower_count_odds = 0.8
local simplex = getSimplexNoise(x/12, y/12, z/12)
local white = math.random()


-- Replace air block with flower with random direction
local directions = {
    "north",
    "west",
    "south",
    "east"
}

local randFlower = withBlockProperty(flower, "blaze_cardinal_direction=" .. directions[math.random(#directions)])

if not isSolid(getBlockState(x, y-1, z)) then
	return nil
end
 
if white < density and getBlock(x, y, z) == blocks.air and place_new_flowers then
    return randFlower
end

-- Get count and nearest direction of nearby flowers
local blocks_surrounding = 0
local nearest_direction = "north" 

if getBlockProperty(getBlock(x,y,z-1), "blaze_count_4") ~= nil then
    blocks_surrounding = blocks_surrounding + 1
    nearest_direction = "west"
end 

if getBlockProperty(getBlock(x,y,z+1), "blaze_count_4") ~= nil then
    blocks_surrounding = blocks_surrounding + 1
    nearest_direction = "east"
end 

if getBlockProperty(getBlock(x-1,y,z), "blaze_count_4") ~= nil then
    blocks_surrounding = blocks_surrounding + 1
    nearest_direction = "south"
end 

if getBlockProperty(getBlock(x+1,y,z), "blaze_count_4") ~= nil then
    blocks_surrounding = blocks_surrounding + 1
    nearest_direction = "north"
end 

-- If 0 < blocks_surrounding < 1 then rotate to correct direction
if blocks_surrounding == 1 and getBlockProperty(getBlock(x,y,z), "blaze_count_4") ~= nil and rotate_flowers then
    block = getBlockState(x, y, z)
    return withBlockProperty(block, "blaze_cardinal_direction=" .. nearest_direction)

end
-- If blocks_surrounding > 2 then add +1 to count of flowers
if grow_flowers and blocks_surrounding >= 1 and white < increase_flower_count_odds and getBlockProperty(getBlock(x,y,z), "blaze_count_4") ~= nil then
    block = getBlockState(x, y, z)
    flower_count = getBlockProperty(block, "blaze_count_4")

    if flower_count ~= nil then
        return withBlockProperty(block, "blaze_count_4=" .. flower_count + 1)
    end
end

