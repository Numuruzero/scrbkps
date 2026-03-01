-- TODO: Add refueling functionality
-- TODO: Add dropoff functionality
-- I can probably add a chest at the end of the lane and have the turtle drop off, or have it refuel in the middle of determineMove

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
        isBlocked = turtle.detect()
        if isBlocked then
            -- If the path is blocked, we move back and reverse the direction
            turtle.back()
            turtle.back()
            nextTurn = "right"
        else
            -- If the path is not blocked, we move forward and turn right to continue farming
            turtle.forward()
            turtle.forward()
        end
        turtle.turnRight()
        turtle.forward()
    else
        nextTurn = "right"
        turtle.turnLeft()
        isBlocked = turtle.detect()
        if isBlocked then
            -- If the path is blocked, we move back and reverse the direction
            turtle.back()
            turtle.back()
            nextTurn = "left"
        else
            -- If the path is not blocked, we move forward and turn left to continue farming
            turtle.forward()
            turtle.forward()
        end
        turtle.turnLeft()
        turtle.forward()
    end
end

function farmRows()
    -- Assuming we start facing towards the far fence, we check for trees on the left and right before moving forward
    print("Checking tree on the left")
    turtle.turnLeft()
    local success, data = turtle.inspect()
    if success and data.name == "minecraft:birch_log" then
        farmTree()
    end
    -- farmTree will leave us facing the way we were and in the same place, so we have to turn all the way around to check the tree on the right
    print("Reorienting...")
    turtle.turnRight()
    print("Checking tree on the right")
    turtle.turnRight()
    success, data = turtle.inspect()
    if success and data.name == "minecraft:birch_log" then
        farmTree()
    end
    -- This should reorient us back down the lane
    print("Reorienting...")
    turtle.turnLeft()
    -- We move forward once, which will put us in a non-tree lane
    print("Moving forward to the next lane...")
    turtle.forward()
    -- Check if we're at the end of the lane
    print("Checking for end of lane...")
    local isBlocked = turtle.detect()
    if isBlocked then
        print("End of lane detected, determining next move...")
        determineMove()
    else
        -- If we're not at the end of the lane, move forward again to check the next tree lane
        print("Not blocked, moving forward to the next lane...")
        turtle.forward()
    end
end

-- Global variable to keep track of the next turn direction
nextTurn = "right"

-- Main loop to continuously farm trees
while true do
    farmRows()
end
