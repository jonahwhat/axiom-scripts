-- https://en.wikipedia.org/wiki/R%C3%B6ssler_attractor

$once$

-- variables
local size = $int(Size,250,100,500)$
local y_offset = $int(Y Offset,10,1,50)$
local block = $blockState(Block, stone)$
local step_size = 0.01
local num_points = 50000

-- constants
local a = 0.2
local b = 0.2
local c = 0.7

-- starting position
local x_t = 0.1
local y_t = 0
local z_t = 0

-- buncha math to determine the next position given an (x,y,z) position
local function rossler(x_t, y_t, z_t)
    local x1 = -y_t - z_t
    local y1 = x_t - (a * y_t)
    local z1 = b + z_t * (x_t - c)
    
    return x_t + step_size * x1, y_t + step_size * y1, z_t + step_size * z1
end


for i=1, num_points do
 	x_t, y_t, z_t = rossler(x_t, y_t, z_t)

    local xo = math.floor(x_t * size)
    local yo = math.floor(z_t * size)
    local zo = math.floor(y_t * size)
    
    setBlock(xo + x, y_offset + yo + y, zo + z, block)
end

