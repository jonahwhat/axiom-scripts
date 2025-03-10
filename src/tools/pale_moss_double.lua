-- places pale moss carpets with viney sides
-- now with double tall moss

doubleTall=$boolean(Double Tall Moss?, false)$

if getBlock(x, y, z) ~= blocks.air or getBlock(x, y-1, z) == blocks.air or getBlock(x, y-1, z) == blocks.pale_moss_carpet then
	return
end


local pale_moss_carpet = blocks.pale_moss_carpet
local additional_moss = blocks.pale_moss_carpet

if not doubleTall then
	if isSolid(getBlock(x, y, z-1)) then
		pale_moss_carpet = withBlockProperty(pale_moss_carpet, "north=low")
	end
	if isSolid(getBlock(x, y, z+1)) then
		pale_moss_carpet = withBlockProperty(pale_moss_carpet, "south=low")
	end
	if isSolid(getBlock(x+1, y, z)) then
		pale_moss_carpet = withBlockProperty(pale_moss_carpet, "east=low")
	end
	if isSolid(getBlock(x-1, y, z)) then
		pale_moss_carpet = withBlockProperty(pale_moss_carpet, "west=low")
	end

	setBlock(x,y,z, pale_moss_carpet)

else
	if isSolid(getBlock(x, y, z-1)) then
		if isSolid(getBlock(x, y+1, z-1)) and not isSolid(getBlock(x, y+1, z)) then
			pale_moss_carpet = withBlockProperty(pale_moss_carpet, "north=tall")
			additional_moss = withBlockProperty(additional_moss, "north=low", "bottom=false")
		else
			pale_moss_carpet = withBlockProperty(pale_moss_carpet, "north=low")
		end
	end

	if isSolid(getBlock(x, y, z+1)) then
		if isSolid(getBlock(x, y+1, z+1)) and not isSolid(getBlock(x, y+1, z)) then
			pale_moss_carpet = withBlockProperty(pale_moss_carpet, "south=tall")
			additional_moss = withBlockProperty(additional_moss, "south=low", "bottom=false")
		else
			pale_moss_carpet = withBlockProperty(pale_moss_carpet, "south=low")
		end
	end

	if isSolid(getBlock(x+1, y, z)) then
		if isSolid(getBlock(x+1, y+1, z)) and not isSolid(getBlock(x, y+1, z)) then
			pale_moss_carpet = withBlockProperty(pale_moss_carpet, "east=tall")
			additional_moss = withBlockProperty(additional_moss, "east=low", "bottom=false")
		else
			pale_moss_carpet = withBlockProperty(pale_moss_carpet, "east=low")
		end
	end
	
	if isSolid(getBlock(x-1, y, z)) then
		if isSolid(getBlock(x-1, y+1, z)) and not isSolid(getBlock(x, y+1, z)) then
			pale_moss_carpet = withBlockProperty(pale_moss_carpet, "west=tall")
			additional_moss = withBlockProperty(additional_moss, "west=low", "bottom=false")
		else
			pale_moss_carpet = withBlockProperty(pale_moss_carpet, "west=low")
		end
	end

	setBlock(x,y,z, pale_moss_carpet)
	
	if additional_moss ~= blocks.pale_moss_carpet then
		setBlock(x,y+1,z, additional_moss)
	end
end


