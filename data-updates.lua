require("__MilitaryNerfing__/prototypes/updates-economics")
require("__MilitaryNerfing__/prototypes/updates-military")
require("__MilitaryNerfing__/prototypes/oil-drilling")
if mods["bobplates"] and mods["bobrevamp"] and (settings.startup["bobmods-revamp-oil"].value and settings.startup["bobmods-revamp-hardmode"].value) and not mods["angelspetrochem"] then
    require("__MilitaryNerfing__/prototypes/oil-bob-processing")
else
    
local r = data.raw.recipe["bob-enriched-fuel"]
if r then
    for i, component in pairs(r.ingredients) do
        if component.name == "bob-liquid-fuel" then
            component.amount = 24
        end
    end
end

r = data.raw.recipe["bob-liquid-fuel"]
if r then
    r.energy_required = 3
    for i, component in pairs(r.ingredients) do
        if component.name == "light-oil" then
            component.amount = 32
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



r = data.raw.recipe["bob-oil-processing"]
if r then
    for i, component in pairs(r.results) do
        if component.name == "light-oil" then
            component.amount = 15
        elseif component.name == "heavy-oil"  then
            component.amount = 35
        end
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
            component.amount = 45
        elseif component.name == "heavy-oil"  then
            component.amount = 55
        end
    end
end

end


data.raw["gun"]["bob-tank-artillery-1"].attack_parameters.movement_slow_down_factor = 0.3
data.raw["gun"]["bob-tank-artillery-1"].attack_parameters.movement_slow_down_cooldown = 170
data.raw["gun"]["bob-tank-artillery-2"].attack_parameters.movement_slow_down_factor = 0.3
data.raw["gun"]["bob-tank-artillery-2"].attack_parameters.movement_slow_down_cooldown = 170