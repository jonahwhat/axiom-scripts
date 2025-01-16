-- Script that converts lava blocks to water blocks
-- Unchecking the tickbox will reverse the script so it changes water to lava instead

lavaToWater=$boolean(Lava To Water, true)$
states = 7

toBlock = blocks.water
fromBlock = blocks.lava

if not lavaToWater then
    toBlock = blocks.lava
    fromBlock = blocks.water
end

for i = 0, states do
    if getBlock(x,y,z) == fromBlock and getBlockProperty(getBlockState(x,y,z), "Level") == tostring(i) then
        return withBlockProperty(toBlock,"level=".. i)
    end
end
