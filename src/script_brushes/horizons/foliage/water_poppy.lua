-- WATER POPPY BRUSH

-- Recommended Settings 
-- - Cylinder Shape
-- - Radius 1-3, Height 4+



-- Axiom Variables
local flower = $blockState(Water Poppy, horizon:water_poppy)$
local density = $float(Density, 0.3, 0.0, 1.0)$
local place_new_flowers = $boolean(Add New Poppies, true)$
local grow_flowers = $boolean(Grow Poppies, true)$
local rotate_flowers = $boolean(Smart Rotate Poppies, true)$

local increase_flower_count_odds = 0.7
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

 
if getBlock(x, y-1, z) == blocks.water and white < density and getBlock(x, y, z) == blocks.air and place_new_flowers then
    return randFlower
end

-- Get count and nearest direction of nearby flowers
local blocks_surrounding = 0
local nearest_direction = "north" 

if getBlockProperty(getBlock(x,y,z-1), "blaze_count_6") ~= nil then
    blocks_surrounding = blocks_surrounding + 1
    nearest_direction = "east"
end 

if getBlockProperty(getBlock(x,y,z+1), "blaze_count_6") ~= nil then
    blocks_surrounding = blocks_surrounding + 1
    nearest_direction = "west"
end 

if getBlockProperty(getBlock(x-1,y,z), "blaze_count_6") ~= nil then
    blocks_surrounding = blocks_surrounding + 1
    nearest_direction = "north"
end 

if getBlockProperty(getBlock(x+1,y,z), "blaze_count_6") ~= nil then
    blocks_surrounding = blocks_surrounding + 1
    nearest_direction = "south"
end 

-- If 0 < blocks_surrounding < 1 then rotate to correct direction
if blocks_surrounding <= 1 and getBlockProperty(getBlock(x,y,z), "blaze_count_6") ~= nil and rotate_flowers then
    block = getBlockState(x, y, z)
    return withBlockProperty(block, "blaze_cardinal_direction=" .. nearest_direction)

end
-- If blocks_surrounding > 2 then add +1 to count of flowers
if grow_flowers and blocks_surrounding >= 1 and white < increase_flower_count_odds and getBlockProperty(getBlock(x,y,z), "blaze_count_6") ~= nil then
    block = getBlockState(x, y, z)
    flower_count = getBlockProperty(block, "blaze_count_6")

    if flower_count ~= nil then
        if flower_count == "0" or flower_count == "1" or flower_count == "2" then
            return withBlockProperty(block, "blaze_count_6=" .. flower_count + 1)
        end
        if (flower_count == "3" or flower_count == "4") and math.random() >= 0.5 then
            return withBlockProperty(block, "blaze_count_6=" .. flower_count + 1)
        end
    end
end

