-- simple foliage placer, chance to place is calculated via random chance
-- if seeded is enabled, new brush strokes will follow the same pattern

local chance = $float(Chance, 0.5, 0.0, 1.0)$
local block = $blockState(Block, short_grass)$
local seeded = $boolean(Seeded, false)$

if seeded then
    local seed =(x * 73856093 + y * 19349663 + z * 83492791) % 2147483647
    math.randomseed(seed)
end

if math.random() > chance then
	return nil
end

if isSolid(getBlock(x, y, z)) and getBlock(x, y+1, z) == blocks.air then
    if getBlockProperty(block, "half") ~= nil then
        if getBlock(x, y+2, z) == blocks.air then
            setBlock(x, y+1, z, withBlockProperty(block, "half=lower"))
            setBlock(x, y+2, z, withBlockProperty(block, "half=upper"))
        end
    else
        setBlock(x, y+1, z, block)
    end
end