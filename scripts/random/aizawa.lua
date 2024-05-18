-- langford/aizawa attractor
-- https://www.dynamicmath.xyz/strange-attractors/
$once$

-- variables
local size = $int(Size,50,1,100)$
local y_offset = $int(Y Offset,50,1,100)$
local block = $blockState(Block, stone)$
local step_size = 0.01
local num_points = 20000

-- constants
local a = 0.95
local b = 0.7
local c = 0.6
local d = 3.5
local e = 0.25
local f = 0.1

-- starting position
local x_t = 0.1
local y_t = 0
local z_t = 0

-- buncha math to determine the next position given an (x,y,z) position
local function aizawa(x_t, y_t, z_t)
    local x1 = (z_t - b) * x_t - d * y_t
    local y1 = d * x_t + (z_t - b) * y_t
    local z1 = c + a * z_t - (z_t^3 / 3) - (x_t^2 + y_t^2) * (1 + e * z_t) + f * z_t * (x_t^3)
    
    return x_t + step_size * x1, y_t + step_size * y1, z_t + step_size * z1
end


for i=1, num_points do
 	x_t, y_t, z_t = aizawa(x_t, y_t, z_t)

    local xo = math.floor(x_t * size)
    local yo = math.floor(z_t * size)
    local zo = math.floor(y_t * size)
    
    setBlock(xo + x, y_offset + yo + y, zo + z, block)
end

