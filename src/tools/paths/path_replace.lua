local start_path = $blockState(Path, horizon:path_haven)$
local start_edge = $blockState(Path Edge, horizon:path_haven_grassy)$
local start_corner = $blockState(Path Corner, horizon:path_haven_grassy_corner)$
local start_slab = $blockState(Path Slab, horizon:path_haven_slab)$

local end_path = $blockState(End Path, horizon:path_haven_trodden)$
local end_edge = $blockState(End Path Edge, horizon:path_haven_trodden_grassy)$
local end_corner = $blockState(End Path Corner, horizon:path_haven_trodden_grassy)$
local end_slab = $blockState(End Path Slab, horizon:path_haven_trodden_slab)$

if getBlockState(x, y, z) == start_path then
    return end_path
end

if getBlockProperty(getBlockState(x, y, z), "blaze_cardinal_direction") then
    if getBlock(x, y, z) == blocks.horizon.path_haven_grassy then
        local direction = getBlockProperty(getBlockState(x, y, z), "blaze_cardinal_direction")
        return withBlockProperty(end_edge, "blaze_cardinal_direction=" .. direction)
    end
end
