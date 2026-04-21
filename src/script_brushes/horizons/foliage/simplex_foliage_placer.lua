-- uses simplex noise to determine whether to place or not
-- if seeded is enabled, new brush strokes will follow the same pattern

local chance = $float(Chance, 0.5, 0.0, 1.0)$
local scale = $int(Scale, 5, 1, 15)$
local block = $blockState(Block, short_grass)$
local seeded = $boolean(Seeded, false)$

local simplex

if seeded then
    simplex = getSimplexNoise(x/scale, y/scale, z/scale, seeded)
else
    simplex = getSimplexNoise(x/scale, y/scale, z/scale)
end

if simplex > chance then
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