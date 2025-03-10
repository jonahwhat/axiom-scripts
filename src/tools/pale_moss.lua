-- places pale moss carpets with viney sides

if getBlock(x, y, z) ~= blocks.air or getBlock(x, y-1, z) == blocks.air then
	return
end

local pale_moss_carpet = blocks.pale_moss_carpet

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


