-- Load Axiom arguments
local tall = $blockState(Tall grass, horizon:meadowgrass_tall)$
local short = $blockState(Shoft Grass, horizon:meadowgrass_short)$
local tiny = $blockState(Half Short Grass, horizon:meadowgrass_short_half)$
local grassiness = $float(Grassiness, 0.5, 0.0, 1.0)$
local height = $float(Tallness, 0.5, 0.0, 1.0)$

-- Replace existing grass boolean? TODO


-- Check if target block is air
if getBlock(x, y, z) ~= blocks.air then
	return nil
end

-- Check if a solid block is below
if not isSolid(getBlockState(x, y-1, z)) then
	return nil
end

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
if simplex - height < transformed/2 - 0.5 and math.random() < 0.45 then

	setBlock(x, y+1, z, withBlockProperty(tall, "blaze_half=upper"))
	setBlock(x,y,z, withBlockProperty(tall, "blaze_half=lower"))
	return

elseif simplex < transformed and height < white - 0.2 then
	return tiny

elseif simplex < transformed then
	return short
end