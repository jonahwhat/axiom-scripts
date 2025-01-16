-- Script that converts lava blocks to water blocks
-- Unchecking the tickbox will reverse the script so it changes water to lava instead

lavaToWater=$boolean(Lava To Water, true)$
states = 7

if lavaToWater then
    for i = 0, states do
        if getBlock(x,y,z) == blocks.lava and getBlockProperty(getBlockState(x,y,z), "Level") == tostring(i) then
            return withBlockProperty(blocks.water,"level=".. i)
        end
    end

else
    for i = 0, states do
        if getBlock(x,y,z) == blocks.water and getBlockProperty(getBlockState(x,y,z), "Level") == tostring(i) then
            return withBlockProperty(blocks.lava,"level=".. i)
        end
    end
end