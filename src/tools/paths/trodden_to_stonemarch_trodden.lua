local path = blocks.horizon.path_haven_trodden
local path_edge = blocks.horizon.path_haven_trodden_grassy
local path_corner = blocks.horizon.path_haven_trodden_grassy_corner
local path_slab = blocks.horizon.path_haven_trodden_slab

local trodden = blocks.horizon.path_stonemarch_trodden
local trodden_edge = blocks.horizon.path_stonemarch_trodden_grassy
local trodden_corner = blocks.horizon.path_stonemarch_trodden_grassy_corner
local trodden_slab = blocks.horizon.path_stonemarch_trodden_slab

-- Replace path blocks
if getBlock(x, y, z) == path then
    return trodden
end

-- Replace edge and corners
if getBlockProperty(getBlockState(x, y, z), "blaze_cardinal_direction") then
    if getBlock(x, y, z) == path_edge then
        local direction = getBlockProperty(getBlockState(x, y, z), "blaze_cardinal_direction")
        return withBlockProperty(trodden_edge, "blaze_cardinal_direction=" .. direction)
    end
    if getBlock(x, y, z) == path_corner then
        local direction = getBlockProperty(getBlockState(x, y, z), "blaze_cardinal_direction")
        return withBlockProperty(trodden_corner, "blaze_cardinal_direction=" .. direction)
    end
end

-- Replace Slabs
if getBlockProperty(getBlockState(x, y, z), "blaze_slab_type") then
    if getBlock(x, y, z) == path_slab then
        local slab_type = getBlockProperty(getBlockState(x, y, z), "blaze_slab_type")
        return withBlockProperty(trodden_slab, "blaze_slab_type=" .. slab_type)
    end
end