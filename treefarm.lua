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

function farmTree(dir)
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
    if dir == "right" then
        turtle.turnLeft()
    else
        turtle.turnRight()
    end
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
    turtle.turnLeft()
    local success, data = turtle.inspect()
    if success and data.name == "minecraft:birch_log" then
        farmTree("left")
    end
    turtle.turnRight()
    success, data = turtle.inspect()
    if success and data.name == "minecraft:birch_log" then
        farmTree("right")
    end
    turtle.forward()
    local blocked = turtle.detect()
    if blocked then
        determineMove()
    else
        turtle.forward()
    end
end

-- Global variable to keep track of the next turn direction
nextTurn = "right"

-- Main loop to continuously farm trees
while true do
    farmRows()
end
