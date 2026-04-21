-- doesn't work fully because leaf blocks have weird blockstates

$once$

local block = $blockState(Block, oak_leaves)$
local y_level = getHighestBlockYAt(x,z)

for i = -60, y_level do
	if getBlockState(x,i,z) == block then
		setBlock(x,i,z, blocks.air) 
	end
end