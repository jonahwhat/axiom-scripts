-- Check if target block is air
if getBlock(x, y, z) ~= blocks.air then
	return nil
end

-- Check if a solid block is below
if not isSolid(getBlockState(x, y-1, z)) then
	return nil
end

-- Load custom arguments
local grassiness = $float(Grassiness, 0.5, 0.0, 1.0)$
local do_tall_grass = $boolean(Allow Tall Grass, true)$
local tall_grass = $blockState(Tall Bottom, horizon:basaltgrass_tall)$
local tall_grass_upper = $blockState(Tall Upper, horizon:basaltgrass_short_half)$
local short_grass = $blockState(Short, horizon:basaltgrass_short)$

-- Base condition for grassiness
if math.random() > grassiness then
	return nil
end

-- Calculate noise values
local simplex = getSimplexNoise(x/12, y/12, z/12)
local white = math.random()
local transformed
if white < 0.5 then
	transformed = math.sqrt(white / 2)
else
	transformed = 1 - math.sqrt((1 - white)/2)
end

-- Update blocks based on noise
if do_tall_grass and simplex < transformed/2 and math.random() < 0.45 then

	setBlock(x, y+1, z, tall_grass_upper)
	return tall_grass
elseif simplex < transformed then
	return short_grass
end