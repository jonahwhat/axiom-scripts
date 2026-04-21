-- plots a lorenz attractor
-- https://en.wikipedia.org/wiki/Lorenz_system

$once$

-- variables
local size = $float(Size, 2.5, 0.5, 5)$
local sigma = $int(Sigma, 10, 0, 100)$
local rho = $int(Rho, 28, 0, 100)$
local beta = $float(Beta, 2.666666666, -1.0, 10.0)$
local block = $blockState(Block, verdant_froglight)$

-- constants
local num_points = 10000
local y_offset = 50
local d_t = 0.01

-- starting position
local x_t = 0.1
local y_t = 0
local z_t = 0

-- function to compute the next position using the Lorenz system equations
local function lorenz(x_t, y_t, z_t, sigma, rho, beta, d_t)
    local x1 = sigma * (y_t - x_t)
    local y1 = x_t * (rho - z_t) - y_t
    local z1 = (x_t * y_t - beta * z_t)
    
    return x_t + (d_t * x1), y_t + (d_t * y1), z_t + (d_t * z1)
end

-- main loop
for i=1, num_points do
    x_t, y_t, z_t = lorenz(x_t, y_t, z_t, sigma, rho, beta, d_t)

    local x_final = math.floor(x_t * size) + x
    local y_final = math.floor(z_t * size) + y + y_offset
    local z_final = math.floor(y_t * size) + z
    
    setBlock(x_final, y_final, z_final, block)
end

