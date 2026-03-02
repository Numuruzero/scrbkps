-- Alternate version of tree farm which has the turtle float one block above the ground.
-- This should keep the turtle from getting stuck on torches and allow it to suck down for sticks and saplings
-- TODO: Add suck functionality to pick up saplings and logs, or just leave them on the ground for the player to pick up
-- Also todo, exclude saplings from the drop off
-- May need an additional cleaner bot for items that drop outside the fence
-- Need to add glowstone to the farm so the torch spaces won't have items fall into them

if turtle.detectDown() then
    turtle.up()
end

function findFuel()
    for slot = 1, 16 do
        local item = turtle.getItemDetail(slot)
        if item and (item.name == "minecraft:coal" or item.name == "minecraft:charcoal") then
            return slot
        end
    end
    return nil -- No fuel found
end

function refuelIfNeeded()
    local fuelLevel = turtle.getFuelLevel()
    if fuelLevel < 100 then -- Arbitrary threshold for refueling
        print("Fuel level low: " .. fuelLevel .. ". Attempting to refuel.")
        -- Refueling logic here, e.g. checking inventory for fuel items and using them
        local fuelSlot = findFuel()
        if fuelSlot then
            turtle.select(fuelSlot)
            turtle.refuel()
            print("Refueled using slot " .. fuelSlot .. ". New fuel level: " .. turtle.getFuelLevel())
        else
            turtle.suck() -- Try to suck fuel from in front if available
            fuelSlot = findFuel()
            if fuelSlot then
                turtle.select(fuelSlot)
                turtle.refuel()
                print("Refueled using slot " ..
                    fuelSlot .. " after sucking. New fuel level: " .. turtle.getFuelLevel())
            else
                print("No fuel found in inventory or below. Please refuel manually.")
            end
        end
    else
        print("Fuel level sufficient: " .. fuelLevel)
    end
end

function dropOffItems()
    print("Dropping off items...")
    for slot = 1, 16 do
        local item = turtle.getItemDetail(slot)
        if item and (item.name ~= "minecraft:coal" and item.name ~= "minecraft:charcoal" and item.name ~= "minecraft:birch_sapling") then
            turtle.select(slot)
            turtle.drop()
            print("Dropped " .. item.count .. " of " .. item.name .. " from slot " .. slot)
        end
    end
end

function plantSapling()
    for slot = 1, 16 do
        local item = turtle.getItemDetail(slot)
        if item and item.name == "minecraft:birch_sapling" then
            turtle.select(slot)
            -- Sapling is considered solid so we have to move up and place below us
            turtle.up()
            turtle.placeDown()
            return true
        end
    end
    return false -- No sapling found
end

function farmTree()
    turtle.dig()
    turtle.forward()
    -- We're at ground level+1 so we're going to cut into the tree and then also cut the ground log
    turtle.digDown()
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
    if plantSapling() then
        print("Sapling planted successfully.")
    else
        print("No sapling found to plant.")
        turtle.up() -- Failsafe to move us if we didn't do so to plant
    end
    turtle.back()
    -- No need to move down since we moved up to plant the sapling
end

function determineMove()
    local success, data = turtle.inspect()
    if success and data.name == "minecraft:chest" then
        refuelIfNeeded()
        dropOffItems()
    end
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
