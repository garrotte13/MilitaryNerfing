local r = data.raw.recipe["automation-science-pack"]
--[[if r then
    for i, component in pairs(r.ingredients) do
        if component.name == "bob-basic-circuit-board" then
            component.name = "copper-cable"
            component.amount = 3
        end
    end
end]]

if mods["bobgreenhouse"] and not mods["nForester"] then
    r = data.raw.recipe["bob-basic-greenhouse-cycle"]
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
                component.amount_max = 35
                component.amount_min = 15
            end
        end
    end
    r = data.raw["assembling-machine"]["bob-greenhouse"]
    if r then
        r.crafting_speed = 0.5
        r.energy_usage = "175kW"
    end
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

--[[ SECOND way
    r = data.raw.recipe["bob-sodium-chlorate"]
    if r then
        r.ingredients = {
            { amount = 3, name = "bob-sodium-hydroxide", type = "item" },
            { amount = 3, name = "bob-hydrogen-chloride", type = "fluid" },
            { amount = 30, name = "bob-pure-water", type = "fluid" }
        }
        r.category = "chemistry"
        r.energy_required = 6
        r.results = {
            { amount = 3, name = "bob-sodium-chlorate", type = "item" },
        }

    end ]]
    r = data.raw.recipe["bob-sodium-chlorate"]
    if r then
        for i, component in pairs(r.ingredients) do
            if component.name == "bob-salt" then
                component.amount = 3
            end
        end
        for i, component in pairs(r.results) do
            if component.name == "bob-sodium-chlorate" then
                component.amount = 2
            end
        end
        r.energy_required = 2
    end

  r = data.raw.recipe["bob-calcium-chloride"]
    if r then
        for i, component in pairs(r.ingredients) do
            if component.name == "bob-hydrogen-chloride" then
                component.amount = 25
            end
        end
        for i, component in pairs(r.results) do
            if component.name == "bob-hydrogen" then
                component.amount = 10
            end
        end
    end


    r = data.raw.recipe["bob-salt-water-electrolysis"]
    if r then
        for i, component in pairs(r.ingredients) do
            if component.name == "bob-salt" then
                component.amount = 2
            elseif component.name == "bob-pure-water" then
                component.amount = 20
            end
        end
        for i, component in pairs(r.results) do
            if component.name == "bob-chlorine" then
                component.amount = 20
            elseif component.name == "bob-hydrogen" then
                component.amount = 12
            end
        end
    end
    --[[r = data.raw.recipe["bob-brine-electrolysis"]
    if r then
        for i, component in pairs(r.ingredients) do
            if component.name == "bob-brine" then
                component.amount = 30
            end
        end
        for i, component in pairs(r.results) do
            if component.name == "bob-chlorine" then
                component.amount = 20
            elseif component.name == "bob-hydrogen" then
                component.amount = 15
            end
        end
    end]]
    r = data.raw.recipe["bob-alumina"]
    if r then
        for i, component in pairs(r.ingredients) do
            if component.name == "bob-bauxite-ore" then
                component.amount = 4
            elseif component.name == "bob-sodium-hydroxide" then
                component.amount = 2
            end
        end
        r.energy_required = r.energy_required * 3
        for i, component in pairs(r.results) do
            if component.name == "bob-alumina" then
                component.amount = 3
            end
        end
    end
 --[[   r = data.raw.recipe["bob-aluminium-plate"]
    if r then
        for i, component in pairs(r.ingredients) do
            if component.name == "bob-alumina" then
                component.amount = 4
            end
        end
        r.energy_required = r.energy_required * 2
        for i, component in pairs(r.results) do
            if component.name == "bob-aluminium-plate" then
                component.amount = 4
            end
        end
    end]]


    r = data.raw.recipe["carbon"]
    if r then
        r.main_product = "carbon"
        r.energy_required = 4
        table.insert(r.results, {type = "item", name = "sulfur", amount = 1, probability=.1, ignored_by_productivity = 1})
        for i, component in pairs(r.ingredients) do
            if component.name == "water" then
                component.amount = 30
            end
        end
        --[[r.ingredients = {
            { amount = 4, name = "coal", type = "item" },
            { amount = 120, name = "water", type = "fluid" }
        }
        r.results = {
            { amount = 8, name = "carbon", type = "item" },
            { amount = 1, name = "sulfur", type = "item", ignored_by_productivity = 1  }
        }]]
    end
end

--[[
    r = data.raw.recipe["carbon"]
    if r then
        r.main_product = "carbon"
        table.insert(r.results, {type = "item", name = "sulfur", amount = 1, probability=.04})
    end

    r = data.raw["recipe"]["rocket-fuel"]
    if data.raw.recipe["bob-liquid-fuel"] then
        table.insert(r.ingredients, {type = "fluid", name = "bob-liquid-fuel", amount = 10})
    else
        table.insert(r.ingredients, {type = "fluid", name = "light-oil", amount = 10})
    end
    ]]


r = data.raw.recipe["bob-pure-water"]
if r then
    r.results[1].amount = 150
    r.ingredients[1].amount = 150
    table.insert(r.results, { amount = 1, name = "bob-salt", type = "item" })
    r.main_product = "bob-pure-water"
    r.energy_required = 3
end
r = data.raw.recipe["bob-salt"]
if r then
    r.ingredients[1].amount = 150
    r.energy_required = 1
end

r = data.raw.recipe["bob-carbon-from-wood"] -- don't go this way unless you're out of coal
if r then
    r.energy_required = 15
    for i, component in pairs(r.ingredients) do
        if component.name == "wood" then
            component.amount = 10
        end
    end
    for i, component in pairs(r.results) do
        if component.name == "carbon" then
            component.amount = nil
            component.amount_min = 3
            component.amount_max = 4
        end
    end
end

--[[
r = data.raw.recipe["bob-limestone"]
if r then
    for i, component in pairs(r.results) do
        if component.name == "bob-carbon-dioxide" then
            component.amount = 20
        end
    end
end
]]

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
            component.amount = 3
        end
    end
end

r = data.raw["resource"]["bob-sulfur"]
if r then
    r.minable.fluid_amount = 10
    r.minable.required_fluid = "steam"
end

r = data.raw.recipe["bob-cobalt-plate"]
if r then
    for i, component in pairs(r.ingredients) do
        if component.name == "bob-cobalt-oxide" then
            component.amount = 3
        end
    end
    r.energy_required = r.energy_required * 2
end

r = data.raw.technology["bob-nitroglycerin-processing"]
if r and data.raw.recipe["kr-advanced-chemical-plant"] then
    for i, component in pairs(r.prerequisites) do
        if component == "oil-processing" then
            r.prerequisites[i] = "kr-advanced-chemical-plant"
            break
        end        
    end
    r = data.raw.recipe["bob-nitroglycerin"]
    r.category = "advanced-chemistry"
    r.energy_required = 2
    r.ingredients = {
        { amount = 10, name = "bob-glycerol", type = "fluid" },
        { amount = 15, name = "sulfuric-acid", type = "fluid" },
        { amount = 15, name = "bob-nitric-acid", type = "fluid" },
    }
    data.raw.recipe["bob-sulfuric-nitric-acid"].hidden = true
    data.raw.fluid["bob-sulfuric-nitric-acid"].hidden = true
end

if data.raw.recipe["bob-electric-chemical-mixing-furnace"] and data.raw.recipe["bob-electric-mixing-furnace"] and
  not (settings.startup["bobmods-plates-convert-recipes"] and settings.startup["bobmods-plates-convert-recipes"].value) then
    r = table.deepcopy(data.raw.recipe["bob-electric-chemical-mixing-furnace"])
    r.localised_name = { "entity-name.bob-electric-chemical-mixing-furnace" }
    r.name = "bob-electric-chemical-mixing-furnace-from-mixing"
    table.insert(r.ingredients, { amount = 5, name = "bob-steel-pipe", type = "item" })
    for i, component in pairs(r.ingredients) do
        if component.name == "bob-electric-chemical-furnace" then
            component.name = "bob-electric-mixing-furnace"
        end
    end
    data:extend({r})
    table.insert(data.raw.technology["bob-multi-purpose-furnace-1"].effects, { recipe = "bob-electric-chemical-mixing-furnace-from-mixing", type = "unlock-recipe" })
end

r = data.raw.technology["bob-railway-3"]
--if r and data.raw.item["bob-advanced-logistic-science-pack"] then
if r then
    for i, component in pairs(r.unit.ingredients) do
        if component[1] == "production-science-pack" then
            r.unit.ingredients[i][1] = "bob-advanced-logistic-science-pack"
        end        
    end
    r.unit.count = 200
    for i, component in pairs(r.prerequisites) do
        if component == "production-science-pack" then
            r.prerequisites[i] = "bob-advanced-logistic-science-pack"
        end        
    end

end

r = data.raw.technology["bob-fluid-wagon-3"]
if r then
    for i, component in pairs(r.unit.ingredients) do
        if component[1] == "production-science-pack" then
            r.unit.ingredients[i][1] = "bob-advanced-logistic-science-pack"
        end        
    end
    for i, component in pairs(r.prerequisites) do
        if component == "production-science-pack" then
            r.prerequisites[i] = "bob-advanced-logistic-science-pack"
        end        
    end

end