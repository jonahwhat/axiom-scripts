-- Axiom Variables
local maximum_length = $int(Maximum Length,6,1,16)$
local density = $float(Placement Chance, 0.35, 0.1, 1.0)$

local upper_moss = $blockState(Upper Moss, horizon:curtain_moss_upper)$
local lower_moss = $blockState(Lower Moss, horizon:curtain_moss_lower)$

local length_modifier = math.random() * 0.5
local calculated_length = math.floor(maximum_length - (maximum_length * length_modifier))

-- Density check
if math.random() >= density then
    return nil
end

-- Check for valid placement
if not (isSolid(getBlock(x, y+1, z)) and getBlock(x,y,z) == blocks.air) then
    return nil
end

-- Place hanging moss
for i = 0, calculated_length do
    if getBlock(x, y-i, z) ~= blocks.air then
        break
    end

    if i == (calculated_length - 1) then
        setBlock(x,y-i,z,lower_moss)
        break
    end
    setBlock(x,y-i,z,upper_moss)

end
