-- Notes
-- Add Corner?
-- Max Length Variable
-- Flowering
-- Top/Bottom boolean, should this have a random rotation?
-- Add option for no follow-up length? (max length 0)
-- note order of checks, should side be prioritized over bottom/top?
-- prioritize corner over side
-- CORNER > SIDE > TOP > BOTTOM


-- Axiom Variables
local flower = $blockState(Quad Flower, horizon:meadowlets)$
local density = $float(Density, 0.2, 0.0, 1.0)$
local place_new_flowers = $boolean(Add New Flowers, true)$
local grow_flowers = $boolean(Grow Flowers, true)$

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
    nearest_direction = "south"
end 

if getBlockProperty(getBlock(x,y,z+1), "blaze_count_4") ~= nil then
    blocks_surrounding = blocks_surrounding + 1
    nearest_direction = "north"
end 

if getBlockProperty(getBlock(x-1,y,z), "blaze_count_4") ~= nil then
    blocks_surrounding = blocks_surrounding + 1
    nearest_direction = "east"
end 

if getBlockProperty(getBlock(x+1,y,z), "blaze_count_4") ~= nil then
    blocks_surrounding = blocks_surrounding + 1
    nearest_direction = "west"
end 

-- If 0 < blocks_surrounding < 1 then rotate to correct direction
if blocks_surrounding == 1 and getBlockProperty(getBlock(x,y,z), "blaze_count_4") ~= nil then
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


-- weeping vines that extend to ground

multiplier=$float(Multiplier,1.5,0.01,4)$
heightMax=$int(Maximum Length,12,2,32)$

noise=math.random()
length=math.floor(math.random(2,heightMax))

if noise<(multiplier*0.1) and length>=heightMax and isSolid(getBlock(x,y+length,z)) and getBlock(x,y,z)==blocks.air then
    for block = 0,length do
        if not isSolid(getBlock(x,y+block,z)) then
            setBlock(x,y+block,z,blocks.weeping_vines_plant)
        end
    end
    return withBlockProperty(blocks.weeping_vines,"age=1")
end





-- vine brush

if getBlock(x, y, z) ~= blocks.air then
	return
end

local vine = blocks.vine

if isSolid(getBlock(x, y, z-1)) then
	vine = withBlockProperty(vine, "north=true")
end
if isSolid(getBlock(x, y, z+1)) then
	vine = withBlockProperty(vine, "south=true")
end
if isSolid(getBlock(x+1, y, z)) then
	vine = withBlockProperty(vine, "east=true")
end
if isSolid(getBlock(x-1, y, z)) then
	vine = withBlockProperty(vine, "west=true")
end
if isSolid(getBlock(x, y+1, z)) then
	vine = withBlockProperty(vine, "up=true")
end

if vine ~= blocks.vine then
	return vine
end

