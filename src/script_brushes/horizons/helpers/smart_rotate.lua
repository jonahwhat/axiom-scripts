
-- Block whitelist
local decorations = {
    [blocks.horizon.eldercaps_mature] = true,
    [blocks.horizon.tree_orchid] = true,
    [blocks.horizon.nest_fern] = true,
}

if not decorations[getBlock(x,y,z)] then
    return nil
end

local block_state = getBlockState(x, y, z)

-- Check each direction for solid blocks and rotate to face them
if isSolid(getBlock(x, y, z-1)) then
    return withBlockProperty(block_state, "blaze_cardinal_direction=north")
end

if isSolid(getBlock(x, y, z+1)) then
    return withBlockProperty(block_state, "blaze_cardinal_direction=south")
end

if isSolid(getBlock(x-1, y, z)) then
    return withBlockProperty(block_state, "blaze_cardinal_direction=west")
end

if isSolid(getBlock(x+1, y, z)) then
    return withBlockProperty(block_state, "blaze_cardinal_direction=east")
end

return nil