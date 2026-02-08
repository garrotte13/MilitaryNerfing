if mods["boblogistics"] then
    if data.raw["int-setting"]["bobmods-logistics-beltperlevel"] then
        data.raw["int-setting"]["bobmods-logistics-beltperlevel"].default_value = 3
    end
    if data.raw["int-setting"]["bobmods-logistics-pipeperlevel"] then
        data.raw["int-setting"]["bobmods-logistics-pipeperlevel"].default_value = 3
    end

end

if mods["bobgreenhouse"] and mods["bobrevamp"] then
    data.raw["bool-setting"]["mn-NewGreenhouse"].default_value = true
end