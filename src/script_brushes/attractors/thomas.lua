-- https://en.wikipedia.org/wiki/Thomas%27_cyclically_symmetric_attractor

$once$

-- variables
local size = $int(Size,15,5,30)$
local y_offset = $int(Y Offset,50,10,100)$ + 30
local b = $float(b,0.18,.01,0.3)$
local block = $blockState(Block, stone)$
local step_size = 0.01
local num_points = 20000

-- starting position
local x_t = 0.1
local y_t = 0
local z_t = 0

-- buncha math to determine the next position given an (x,y,z) position
local function thomas(x_t, y_t, z_t)
    local x1 = math.sin(y_t) - (b * x_t)
    local y1 = math.sin(z_t) - (b * y_t)
    local z1 = math.sin(x_t) - (b * z_t)
    
    return x_t + step_size * x1, y_t + step_size * y1, z_t + step_size * z1
end


for i=1, num_points do
 	x_t, y_t, z_t = thomas(x_t, y_t, z_t)

    local xo = math.floor(x_t * size)
    local yo = math.floor(z_t * size)
    local zo = math.floor(y_t * size)
    
    setBlock(xo + x, y_offset + yo + y, zo + z, block)
end

