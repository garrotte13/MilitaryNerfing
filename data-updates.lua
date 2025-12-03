
local r = data.raw.recipe["piercing-rounds-magazine"]
if r.ingredients then
    for i, component in pairs(r.ingredients) do
        if component.name == "firearm-magazine" then
            component.amount = 1
        end
    end
    r.energy_required = 3
    r.results[1].amount = 1
else

end

if mods["bobwarfare"] then
    data.raw.recipe["rocket"].hidden = true
    data.raw.ammo["rocket"].hidden = true
    data.raw.recipe["explosive-rocket"].hidden = true
    data.raw.ammo["explosive-rocket"].hidden = true
    data.raw.technology["explosive-rocketry"].hidden = true
else
    r = data.raw.recipe["rocket"]
    if r.ingredients then
        table.insert(r.ingredients,
        {type="item", name="advanced-circuit", amount=1}
        )
    end
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
    if r.ingredients then
        for i, component in pairs(r.ingredients) do
            if component.name == "water" then
                component.amount = 75
            end
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
        if r.ingredients and r.results then
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