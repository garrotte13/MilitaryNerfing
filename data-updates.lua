local r = data.raw.recipe["piercing-rounds-magazine"]
for i, component in pairs(r.ingredients) do
    if component.name == "firearm-magazine" then
        component.amount = 1
    end
end
r.energy_required = 3
r.results[1].amount = 1

if mods["bobwarfare"] then
    data.raw.recipe["rocket"].hidden = true
    data.raw.ammo["rocket"].hidden = true
    data.raw.recipe["explosive-rocket"].hidden = true
    data.raw.ammo["explosive-rocket"].hidden = true
    data.raw.technology["explosive-rocketry"].hidden = true
else
    table.insert(data.raw.recipe["rocket"].ingredients, {type="item", name="advanced-circuit", amount=1})
end

if mods["bobgreenhouse"] then
    r = data.raw.recipe["bob-basic-greenhouse-cycle"]
    if r.ingredients then
        for i, component in pairs(r.ingredients) do
            if component.name == "water" then
                component.amount = 75
            end
        end
    end
    r = data.raw.recipe["bob-advanced-greenhouse-cycle"]
    for i, component in pairs(r.ingredients) do
        if component.name == "water" then
            component.amount = 75
        end
    end
    r = data.raw["assembling-machine"]["bob-greenhouse"]
    r.crafting_speed = 0.5
    r.energy_usage = "180kW"
end

if mods["bobplates"] and settings.startup["bobmods-plates-cheapersteel"] then --fixing steel recipe balance slightly away from cheating
    r = data.raw.recipe["steel-plate"]
    if settings.startup["bobmods-plates-cheapersteel"].value then
        r.energy_required = 19.2                                                -- it must be always 3.2 per iron-plate
        for i, component in pairs(r.ingredients) do
            if component.name == "iron-plate" then
                component.amount = 6
            elseif component.name == "bob-oxygen"  then
                component.amount = 30                                       -- less oxygen. Asked cheap and we do pay for water and don't void gases!
            end
        end
        for i, component in pairs(r.results) do
            if component.name == "steel-plate" then
                component.amount = 2
            end
        end
    else
        if r.results then
            for i, component in pairs(r.results) do
                if component.name == "steel-plate" then
                    component.amount = 1                    -- player asked to make it NOT cheap
                end
            end
        end
    end

end

if mods["bobplates"] then
    r = data.raw.recipe["bob-liquid-fuel"]
    r.energy_required = 3
    for i, component in pairs(r.ingredients) do
        if component.name == "light-oil" then
            component.amount = 30
        end
    end
    for i, component in pairs(r.results) do
        if component.name == "bob-liquid-fuel" then
            component.amount = 20
        end
    end


end

r = data.raw.recipe["coal-liquefaction"]
if r then
    for i, component in pairs(r.ingredients) do
        if component.name == "steam" then
            component.minimum_temperature = 385
        end
    end
end

r = data.raw.recipe["bob-carbon-dioxide-oil-processing"]    -- make it worth it
if r then
    for i, component in pairs(r.ingredients) do
        if component.name == "crude-oil" then
            component.amount = 75
        end
    end
    r.energy_required = 6
    r.emissions_multiplier = 0.7
end

data.raw["gun"]["bob-tank-artillery-1"].movement_slow_down_factor = 0.3
data.raw["gun"]["bob-tank-artillery-1"].movement_slow_down_factor = 70
data.raw["gun"]["bob-tank-artillery-2"].movement_slow_down_factor = 0.3
data.raw["gun"]["bob-tank-artillery-2"].movement_slow_down_factor = 70