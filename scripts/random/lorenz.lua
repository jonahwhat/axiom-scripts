-- https://en.wikipedia.org/wiki/Lorenz_system

$once$

-- variables
local size = $float(Size, 2.5, 0.5, 5)$
local sigma = $int(sigma, 10, 0, 100)$
local rho = $int(rho, 28, 0, 100)$
local beta = $float(beta, 2.666666666, -1.0, 10.0)$
local block = $blockState(Block, stone)$

-- constants
local step_size = 0.01
local num_points = 20000
local y_offset = 50

-- starting position
local x_t = 0.1
local y_t = 0
local z_t = 0

-- buncha math to determine the next position given an (x,y,z) position
local function lorenz(x_t, y_t, z_t)
    local x1 = sigma * (y_t - x_t)
    local y1 = x_t * (rho - z_t) - y_t
    local z1 = (x_t * y_t - beta * z_t)
    
    return x_t + step_size * x1, y_t + step_size * y1, z_t + step_size * z1
end


for i=1, num_points do
 	x_t, y_t, z_t = lorenz(x_t, y_t, z_t)

    local xo = math.floor(x_t * size)
    local yo = math.floor(z_t * size)
    local zo = math.floor(y_t * size)
    
    setBlock(xo + x, y_offset + yo + y, zo + z, block)
end

