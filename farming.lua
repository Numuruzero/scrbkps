function farmWheat()
    local success, data = turtle.inspectDown()
    if success then
        if data.name == "minecraft:wheat" and data.state.age == 7 then
            turtle.digDown()
            turtle.suckDown()
            turtle.placeDown()
        else
            print("Not fully grown wheat below.")
        end
    else
        print("Nothing below to inspect.")
    end
end

function decideMove()
    local success, data = turtle.inspectUp()
    if success then
        if data.name == "minecraft:glass" then -- Glass being the path forward so we can see below. Maybe revise the other pathing blocks to use color instead of different materials.
            turtle.forward()
        elseif data.name == "minecraft:chest" then
            -- Refuel logic here
            turtle.forward()
        elseif data.name == "minecraft:diorite" then
            turtle.turnRight()
            turtle.forward()
        elseif data.name == "minecraft:andesite" then
            turtle.turnLeft()
            turtle.forward()
        else
            print("Unknown block above: " .. data.name)
        end
    else
        print("Nothing above to inspect.")
    end
end

while true do
    farmWheat()
    os.sleep(10) -- Wait for 10 seconds before checking again
end

-- TODO: Add logic for other crops, refueling, and replanting
-- TODO: Create tree farming logic to create a sustainable fuel source
-- TODO: Inventory management to handle harvested crops and fuel
-- Also, a merged inventory system for making "larger" chests?
-- inventory.list()

function printTable(table, subt)
    subt = subt or false
    for key, value in pairs(table) do
        print(key .. ": " .. tostring(value))
        if subt and type(value) == "table" then
            print("--Begin table: " .. key .. "--")
            printTable(value, true)
            print("--End table: " .. key .. "--")
        end
    end
end

-- Seeing inventory on a PC, e.g.
-- peripheral.call("right","list")
-- Return e.g. {{count = 1, name = "minecraft:wheat"},{count = 1, name = "minecraft:wheat_seeds"},nil,{count = 1, name = "minecraft:dirt"}}
-- If I understand correctly this should mean that the key corresponds to the actual slot in the inventory
-- Two or more computers can connect to the same peripheral

-- For turtles:
-- turtle.getItemDetail(slot)
-- Returns something like the list function above but only one slot at a time
