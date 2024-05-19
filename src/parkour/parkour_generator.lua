-- a simple parkour generator
-- generates parkour in the north direction starting where you click
-- adjust the hard jump weight to determine how often difficult jumps are added to the parkour (4 block jumps etc.)

$once$

-- variables
local length_of_parkour = $int(Length of Parkour,25,5,250)$
local hard_jump_weight = $float(Hard Jump Weight, 0.0, 0.0, 1.0)$

-- blocks
local BLOCK_LIST = {
    blocks.white_concrete,
    blocks.orange_concrete,
    blocks.magenta_concrete,
    blocks.light_blue_concrete,
    blocks.yellow_concrete,
    blocks.lime_concrete,
    blocks.pink_concrete,
    blocks.gray_concrete,
    blocks.light_gray_concrete,
    blocks.cyan_concrete,
    blocks.purple_concrete,
    blocks.blue_concrete,
    blocks.brown_concrete,
    blocks.green_concrete,
    blocks.red_concrete,
    blocks.black_concrete
}

-- parkour jumps table
local JUMP_TABLE = {
    {0, 1, -3},
    {0, 1, -3},
    {0, 1, -3},
    {1, 1, -3},
    {1, 1, -3},
    {-1, 1, -3},
    {-1, 1, -3},
    {0, 0, -4},
    {0, 0, -4},
    {0, 0, -4},
    {0, 1, -3},
    {0, -2, -5},
    {0, -1, -4},
    {-2, -1, -4},
    {2, -1, -4},
    {2, 0, -4},
    {-2, 0, -4},
    {1, -4, -6},
    {-1, -4, -6},
    {0, -3, -5},
}

local HARD_JUMPS = {
    {0, 1, -4},
    {0, 1, -4},
    {1, 1, -4},
    {-1, 1, -4},
    {0, 0, -5},
}

-- starting position
local x1 = x
local y1 = y + 1
local z1 = z

local Y_THRESHOLD = y + 2

function getNewBlock(x1, y1, z1)

    local next_block
    local new_y

    -- check to make sure block isn't touching the ground
    repeat
        -- add hard jumps to the jump pool if enabled
        if math.random() <= hard_jump_weight then
            next_block = HARD_JUMPS[math.random(#HARD_JUMPS)]
        else
            next_block = JUMP_TABLE[math.random(#JUMP_TABLE)]
        end

        new_y = y1 + next_block[2]
        
    until new_y >= Y_THRESHOLD

    return x1 + next_block[1], y1 + next_block[2], z1 + next_block[3]
end


-- set starting block
setBlock(x1, y1, z1, blocks.gold_block)

-- generate parkour jumps based on length_of_parkour
for i=1, length_of_parkour do
    x1, y1, z1 = getNewBlock(x1, y1, z1)

    local block = BLOCK_LIST[(i % #BLOCK_LIST) + 1]

    if i == length_of_parkour then
        block = blocks.gold_block
    end

    setBlock(x1, y1, z1, block)
end

