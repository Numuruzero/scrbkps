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

while true do
    farmWheat()
    os.sleep(10) -- Wait for 10 seconds before checking again
end
