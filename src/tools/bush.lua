-- Load custom arguments
local scale = $int(Scale, 2, 1, 6)$
local density = $float(Density, 0.5, 0.0, 1.0)$
local block = $blockState(Block, horizon:bush_haven)$
local dense = $blockState(Block, horizon:bush_haven_dense)$
local frilly = $blockState(Block, horizon:bush_haven_frilly)$

-- Check if target block is air
if getBlock(x, y, z) ~= blocks.air then
	return nil
end

-- Check if there is a solid block below
if not isSolid(getBlock(x, y-1, z)) then
	return nil
end

if math.random() > density then
	return nil
end

function grow(x1, y1, z1, d, check_below)
	-- Calculate growth chance
	local dx = x1 - x
	local dy = y1 - y
	local dz = z1 - z
	local distance = math.sqrt(dx^2 + dy^2 + dz^2)
	local factor = 3 * (1 - distance/scale)
	local growth_chance = factor * d/scale

	-- Check growth chance

	if math.random() > growth_chance then
		return
	end

	-- Ensure replacing air
	if getBlock(x1, y1, z1) ~= blocks.air then
		return
	end

	-- Ensure solid block is below, allowed to move down once
	if check_below >= 0 and not isSolid(getBlock(x1, y1-1, z1)) then
		if check_below > 0 then
			return grow(x1, y1-1, z1, d, check_below - 1)
		else
			return
		end
	end

	-- Set block to leaves
	setBlock(x1, y1, z1, block)

	-- Propagate growth
	if d > 0 then
		grow(x1+1, y1, z1, d-1, 1)
		grow(x1-1, y1, z1, d-1, 1)
		grow(x1, y1, z1+1, d-1, 1)
		grow(x1, y1, z1-1, d-1, 1)
		grow(x1, y1+1, z1, d-1.5, -1)
	end
end

grow(x, y, z, scale, -1)
