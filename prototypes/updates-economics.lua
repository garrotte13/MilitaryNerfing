
local r = data.raw.recipe["bob-basic-greenhouse-cycle"]
if r then
    r = data.raw.recipe["bob-basic-greenhouse-cycle"]
    for i, component in pairs(r.ingredients) do
        if component.name == "water" then
            component.amount = 75
        end
    end
    for i, component in pairs(r.results) do
        if component.name == "wood" then
            component.amount_max = 14
        end
    end
end
r = data.raw.recipe["bob-advanced-greenhouse-cycle"]
if r then
    for i, component in pairs(r.ingredients) do
        if component.name == "water" then
            component.amount = 75
        end
    end
    for i, component in pairs(r.results) do
        if component.name == "wood" then
            component.amount_max = 40
        end
    end
end
r = data.raw["assembling-machine"]["bob-greenhouse"]
if r then
    r.crafting_speed = 0.5
    r.energy_usage = "175kW"
end

if mods["bobplates"] and settings.startup["bobmods-plates-cheapersteel"] then --fixing steel recipe balance slightly away from cheating
    r = data.raw.recipe["steel-plate"]
    if settings.startup["bobmods-plates-cheapersteel"].value then
        r.energy_required = 16                                                -- it must be always 3.2 per iron-plate
        for i, component in pairs(r.ingredients) do
            if component.name == "iron-plate" then
                component.amount = 5
            elseif component.name == "bob-oxygen"  then
                component.amount = 20                                       -- less oxygen. Asked cheap and we do pay for water and don't void gases!
            end
        end
        for i, component in pairs(r.results) do
            if component.name == "steel-plate" then
                component.amount = 2
            end
        end
    else                     -- player asked to make it NOT cheap
        if r.results then
            for i, component in pairs(r.ingredients) do
                if component.name == "bob-oxygen" then
                    component.amount = 25
                end
            end
            for i, component in pairs(r.results) do
                if component.name == "steel-plate" then
                    component.amount = 1
                end
            end
        end
    end

end

if mods["bobplates"] then
    r = data.raw.recipe["bob-liquid-fuel"]
    if r then
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
    r = data.raw.recipe["bob-carbon"]
    if r then
        r.main_product = "bob-carbon"
        table.insert(r.results, {type = "item", name = "sulfur", amount = 1, probability=.04})
    end

    r = data.raw["recipe"]["rocket-fuel"]
    if data.raw.recipe["bob-liquid-fuel"] then
        table.insert(r.ingredients, {type = "fluid", name = "bob-liquid-fuel", amount = 10})
    else
        table.insert(r.ingredients, {type = "fluid", name = "light-oil", amount = 10})
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

r = data.raw.recipe["basic-oil-processing"]
for i, component in pairs(r.results) do
    if component.name == "petroleum-gas" or component.name == "bob-sour-gas" then
        component.amount = 55
    end
end

r = data.raw.recipe["bob-carbon-dioxide-oil-processing"]    -- make it worth it
if r then
    for i, component in pairs(r.ingredients) do
        if component.name == "crude-oil" then
            component.amount = 90
        end
    end
    r.energy_required = 6
    r.emissions_multiplier = 0.7
    for i, component in pairs(r.results) do
        if component.name == "light-oil" then
            component.amount = 55
        elseif component.name == "heavy-oil"  then
            component.amount = 45
        end
    end
end

r = data.raw.recipe["bob-carbon-from-wood"] -- don't go this way unless you're out of coal
if r then
    r.energy_required = 8
    for i, component in pairs(r.ingredients) do
        if component.name == "wood" then
            component.amount = 5
        end
    end
    for i, component in pairs(r.results) do
        if component.name == "bob-carbon" then
            component.amount = nil
            component.amount_min = 1
            component.amount_max = 2
        end
    end
end

r = data.raw.recipe["bob-resin-wood"]
if r then
    for i, component in pairs(r.ingredients) do
        if component.name == "wood" then
            component.amount = 2
        end
    end
end
r = data.raw.recipe["bob-resin-oil"]
if r then
    for i, component in pairs(r.results) do
        if component.name == "bob-resin" then
            component.amount = 2
        end
    end
end
r = data.raw.recipe["bob-rtg"]
if r then
    for i, component in pairs(r.ingredients) do
        if component.name == "bob-plutonium-239" then
            component.amount = 2
        end
    end
end
