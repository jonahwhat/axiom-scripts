if getBlock(x, y, z) ~= blocks.air then
	return false
end

return true



-- target bottom block
-- if not within 5 blocks of bottom block vertically, then return false, else return true