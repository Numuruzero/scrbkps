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
        if data.name == "minecraft:stone" then
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
