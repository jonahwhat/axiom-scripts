-- Check if target block is air
if getBlock(x, y, z) ~= blocks.water then
	return nil
end

-- Check if a solid block is below
if not isSolid(getBlockState(x, y-1, z)) then
	return nil
end

-- Load custom arguments
local grassiness = $float(Density, 0.4, 0.0, 1.0)$
local tall_grassiness = $float(Amount of Tall Eelgrass, 0.25, 0.0, 1.0)$
local do_tall_grass = $boolean(Allow Tall Eelgrass, true)$

local eelgrass_tall = withBlockProperty(blocks.horizon.eelgrass_tall, "waterlogged=true")
local eelgrass_short = withBlockProperty(blocks.horizon.eelgrass_short, "waterlogged=true")

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
if simplex < transformed then
	if do_tall_grass and math.random() < tall_grassiness and getBlock(x,y+1,z) == blocks.water then

		setBlock(x, y+1, z, withBlockProperty(eelgrass_tall, "blaze_half=upper"))
		return eelgrass_tall
	else
		return eelgrass_short
	end
end
