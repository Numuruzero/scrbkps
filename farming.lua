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
            turtle.suckUp() -- Try to suck fuel from above if available
            fuelSlot = findFuel()
            if fuelSlot then
                turtle.select(fuelSlot)
                turtle.refuel()
                print("Refueled using slot " ..
                    fuelSlot .. " after sucking up. New fuel level: " .. turtle.getFuelLevel())
            else
                print("No fuel found in inventory or above. Please refuel manually.")
            end
        end
    else
        print("Fuel level sufficient: " .. fuelLevel)
    end
end

function depositItems()
    for slot = 1, 16 do
        local item = turtle.getItemDetail(slot)
        if item and (item.name ~= "minecraft:charcoal" or item.name ~= "minecraft:coal") then
            turtle.select(slot)
            turtle.drop() -- Drop harvested items into chest in front
            print("Deposited " .. item.count .. " of " .. item.name .. " from slot " .. slot)
        end
    end
end

function decideMove()
    -- TODO: Add "last row" logic in case there's an odd number of rows
    -- NEW PLAN the old design was not well thought out, we're doing halfsies
    -- R = right, L = left, - = forward, T = turnaround
    -- R-------R
    -- R--LL---R
    -- R--LL---R
    -- R-------R
    -- OR, FOR ODD ROWS
    -- R-------R
    -- R--LL---R
    -- R--LL---R
    -- R--TT---R
    -- R-------R
    -- The middle L doesn't have to be truly in the middle though it would be more satisfying aesthetically
    -- Unfortunately we need two blocks in the middle so the paths don't cross
    -- TODO: Add special "deposit harvested items" logic
    -- Maybe rather than a special turn block, have it be a special forward block that moves forward first, does deposit logic, then moves on
    local success, data = turtle.inspectUp()
    if success then
        if data.name == "minecraft:glass" then -- Glass being the path forward so we can see below. Maybe revise the other pathing blocks to use color instead of different materials.
            turtle.forward()
        elseif data.name == "minecraft:black_stained_glass" then
            turtle.forward()
            -- Deposit logic here, e.g. checking inventory for harvested items and dropping them into a chest above
            depositItems()
        elseif data.name == "minecraft:chest" then
            -- Refuel logic here
            refuelIfNeeded()
            turtle.forward()
        elseif data.name == "minecraft:white_stained_glass" then
            turtle.turnRight()
            turtle.forward()
        elseif data.name == "minecraft:yellow_stained_glass" then
            turtle.turnLeft()
            turtle.forward()
        elseif data.name == "minecraft:blue_stained_glass" then
            turtle.turnRight()
            turtle.turnRight()
            turtle.forward()
        else -- Add another block to indicate that items should be dropped into a chest ahead
            print("Unknown block above: " .. data.name)
        end
    else
        print("Nothing above to inspect.")
    end
end

function findSeed(plantType)
    -- Wheat has seeds, but other plants like carrots and potatoes are planted using the item itself, so we need to adjust for that
    if plantType == "minecraft:wheat" then
        plantType = "minecraft:wheat_seeds"
    elseif plantType == "minecraft:beetroots" then
        plantType = "minecraft:beetroot_seeds"
    end
    for slot = 1, 16 do
        local item = turtle.getItemDetail(slot)
        if item and item.name == plantType then
            return slot
        end
    end
    return nil -- No seeds found
end

function tendCrop()
    local success, data = turtle.inspectDown()
    if success then
        -- TODO: Add support for other crops, which may require checking for different growth stages. Maybe able to use some kind of "farmable" tag?
        if data.tags["minecraft:crops"] and data.state.age == 7 then
            turtle.digDown()
            turtle.suckDown()
            local seedSlot = findSeed(data.name)
            if seedSlot then
                turtle.select(seedSlot)
                turtle.placeDown()
            else
                print("No seeds found in inventory to replant.")
            end
        else
            print("Not fully grown wheat below.")
        end
    else
        print("Nothing below to inspect.")
    end
end

while true do
    tendCrop()
    decideMove()
end

-- TODO: Add logic for other crops, refueling, and replanting
-- TODO: Create tree farming logic to create a sustainable fuel source
-- TODO: Inventory management to handle harvested crops and fuel
-- Also, a merged inventory system for making "larger" chests?
-- inventory.list()

-- function printTable(table, subt)
--     subt = subt or false
--     for key, value in pairs(table) do
--         print(key .. ": " .. tostring(value))
--         if subt and type(value) == "table" then
--             print("--Begin table: " .. key .. "--")
--             printTable(value, true)
--             print("--End table: " .. key .. "--")
--         end
--     end
-- end

-- Seeing inventory on a PC, e.g.
-- peripheral.call("right","list")
-- Return e.g. {{count = 1, name = "minecraft:wheat"},{count = 1, name = "minecraft:wheat_seeds"},nil,{count = 1, name = "minecraft:dirt"}}
-- If I understand correctly this should mean that the key corresponds to the actual slot in the inventory and the system seems to replace a single empty slot with nil, but will ignore multiple empty slots and instead give the next item the key for its slot
-- Two or more computers can connect to the same peripheral

-- For turtles:
-- turtle.getItemDetail(slot)
-- Returns something like the list function above but only one slot at a time
