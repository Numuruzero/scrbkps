function plantSapling()
    for slot = 1, 16 do
        local item = turtle.getItemDetail(slot)
        if item and item.name == "minecraft:birch_sapling" then
            turtle.select(slot)
            turtle.placeDown()
            return true
        end
    end
end

function farmTree()
    turtle.dig()
    turtle.forward()
    while true do
        local success, data = turtle.inspectUp()
        if success and data.name == "minecraft:birch_log" then
            turtle.digUp()
            turtle.up()
        else
            break
        end
    end
    while not turtle.detectDown() do
        turtle.down()
    end
    plantSapling()
    turtle.back()
end

function determineMove()
    if nextTurn == "right" then
        nextTurn = "left"
        turtle.turnRight()
        turtle.forward()
        turtle.forward()
        turtle.turnRight()
        turtle.forward()
    else
        nextTurn = "right"
        turtle.turnLeft()
        turtle.forward()
        turtle.forward()
        turtle.turnLeft()
        turtle.forward()
    end
end

function farmRows()
    -- Assuming we start facing towards the far fence, we check for trees on the left and right before moving forward
    turtle.turnLeft()
    local success, data = turtle.inspect()
    if success and data.name == "minecraft:birch_log" then
        farmTree()
    end
    -- farmTree will leave us facing the way we were and in the same place, so we have to turn all the way around to check the tree on the right
    turtle.turnRight()
    turtle.turnRight()
    success, data = turtle.inspect()
    if success and data.name == "minecraft:birch_log" then
        farmTree()
    end
    -- This should reorient us back down the lane
    turtle.turnLeft()
    -- We move forward once, which will put us in a non-tree lane
    turtle.forward()
    -- Check if we're at the end of the lane
    local blocked = turtle.detect()
    if blocked then
        determineMove()
    else
        -- If we're not at the end of the lane, move forward again to check the next tree lane
        turtle.forward()
    end
end

-- Global variable to keep track of the next turn direction
nextTurn = "right"

-- Main loop to continuously farm trees
while true do
    farmRows()
end
