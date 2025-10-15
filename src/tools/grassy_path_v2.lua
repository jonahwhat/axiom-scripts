-- Load Axiom arguments
local grass = $blockState(Grass Block, horizon:meadowgrass)$
local path = $blockState(Path Block, horizon:path_haven)$
local path_edge = $blockState(Edge Block, horizon:path_haven_grassy)$
local path_corner = $blockState(Corner Block, horizon:path_haven_grassy_corner)$

local temp_block = blocks.air
local blocks_surrounding = 0

local north = false
local south = false
local west = false
local east = false

-- Only edit path blocks
if getBlockState(x, y, z) ~= path then
	return
end

-- Check how many grass blocks are around x,y,z
if getBlockState(x,y,z-1) == grass or getBlockState(x,y+1,z-1) == grass or getBlockState(x,y-1,z-1) == grass then
    blocks_surrounding = blocks_surrounding + 1
    north = true
end

if getBlockState(x,y,z+1) == grass or getBlockState(x,y+1,z+1) == grass or getBlockState(x,y-1,z+1) == grass then
    blocks_surrounding = blocks_surrounding + 1
    south = true
end

if getBlockState(x-1,y,z) == grass or getBlockState(x-1,y+1,z) == grass or getBlockState(x-1,y-1,z) == grass then
    blocks_surrounding = blocks_surrounding + 1
    west = true
end

if getBlockState(x+1,y,z) == grass or getBlockState(x+1,y+1,z) == grass or getBlockState(x+1,y-1,z) == grass then
    blocks_surrounding = blocks_surrounding + 1
    east = true
end

-- Case if >2 edges border grass
if blocks_surrounding >= 2 then
    if north and east then
        temp_block = withBlockProperty(path_corner, "blaze_cardinal_direction=east")
    end

    if north and west then
        temp_block = withBlockProperty(path_corner, "blaze_cardinal_direction=north")
    end

    if south and east then
        temp_block = withBlockProperty(path_corner, "blaze_cardinal_direction=south")
    end

    if south and west then
        temp_block = withBlockProperty(path_corner, "blaze_cardinal_direction=west")
    end


-- Case if only 1 edge borders grass
elseif blocks_surrounding == 1 then
    if north then
        temp_block = withBlockProperty(path_edge, "blaze_cardinal_direction=north")
    end

    if south then
        temp_block = withBlockProperty(path_edge, "blaze_cardinal_direction=south")
    end

    if east then
        temp_block = withBlockProperty(path_edge, "blaze_cardinal_direction=east")
    end

    if west then
        temp_block = withBlockProperty(path_edge, "blaze_cardinal_direction=west")
    end
end


-- Return temp_block if conditions met
if temp_block ~= blocks.air then
    return temp_block
end