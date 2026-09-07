local r = data.raw.recipe["plastic-bar"]
if r then
    for i, component in pairs(r.ingredients) do
        if component.name == "petroleum-gas" then
            component.amount = 75
        end
    end
    r.energy_required = 3
end

r = data.raw.recipe["basic-oil-processing"]
r.ingredients = {
    { amount = 145, name = "processed-oil", type = "fluid" },
}
r.energy_required = 6
r.results = {  --125 total (residue is 5 solid units to 30 fluid)
    { amount = 15, name = "heavy-oil", type = "fluid" },
    { amount = 40, name = "bob-liquid-fuel", type = "fluid" },
    { amount = 35, name = "light-oil", type = "fluid" },
    { amount_min = 3, amount_max = 5, name = "oil-residue", type = "item", ignored_by_productivity = 5 },
    { amount_min = 1, amount_max = 2, name = "sulfur", type = "item", ignored_by_productivity = 2 }
}

local r = table.deepcopy(data.raw.recipe["basic-oil-processing"])
r.name = "vacuum-distillation"
r.ingredients = {
    { amount = 36, name = "oil-residue", type = "item" }  -- (residue is 20->2 carbon + 25 solid units to 100 fluid )
}
r.results = {  -- total 90
    { amount = 30, name = "heavy-oil", type = "fluid" },
    { amount = 12, name = "bob-liquid-fuel", type = "fluid" },
    { amount = 35, name = "hot-tar", type = "fluid" },
    { amount = 2, name = "carbon", type = "item", ignored_by_productivity = 2 },
    --{ amount = 3, name = "mn-bitumen", type = "item" }
}
r.energy_required = 9
r.order = "a[oil-processing]-v[vacuum-distillation]"
r.icon = "__MilitaryNerfing__/graphics/icons/residue-fluid.png"
data:extend({r})
table.insert(data.raw.technology["asphalt"].effects, { recipe = "vacuum-distillation", type = "unlock-recipe" })

r = data.raw.recipe["bob-sulfuric-acid-3"]
if r then
    for i, component in pairs(r.ingredients) do
        if component.name == "bob-oxygen" then
            component.amount = 115
        end
    end
end
r = data.raw.recipe["bob-petroleum-gas-sweetening"]
if r then
    r.ingredients = {
        { amount = 40, name = "bob-sour-gas", type = "fluid" },
    }
    r.results = {
        { amount = 40, name = "petroleum-gas", type = "fluid" },
        { amount_min = 1, amount_max = 2, name = "sulfur", type = "item" }
    }
    r.energy_required = 3
end


r = data.raw.recipe["advanced-oil-processing"]
r.ingredients = {
    { amount = 125, name = "processed-oil", type = "fluid" },
    { amount = 50, name = "water", type = "fluid" },
}
r.energy_required = 7
r.results = { --125 total (residue is 5 solid units to 30 fluid)
    { amount = 15, name = "heavy-oil", type = "fluid" },
    { amount = 20, name = "bob-liquid-fuel", type = "fluid" },
    { amount = 55, name = "light-oil", type = "fluid" },
    { amount_min = 3, amount_max = 4, name = "oil-residue", type = "item", ignored_by_productivity = 4 },
    { amount_min = 1, amount_max = 2, name = "sulfur", type = "item", ignored_by_productivity = 2 }
}

r = table.deepcopy(data.raw.recipe["heavy-oil-cracking"])
r.name = "liquid-fuel-cracking"
r.ingredients = {
    {type = "fluid", name = "bob-liquid-fuel", amount = 40},
    {type = "fluid", name = "water", amount = 30}
}
r.results = {
    { amount = 20, name = "petroleum-gas", type = "fluid" },
    { amount = 10, name = "light-oil", type = "fluid" },
}
data:extend({r})
table.insert(data.raw.technology["advanced-oil-processing"].effects, { recipe = "liquid-fuel-cracking", type = "unlock-recipe" })

r = data.raw.recipe["heavy-oil-cracking"]
r.category = "oil-processing"
r.energy_required = 6
r.ingredients = {
    {type = "fluid", name = "bob-hydrogen", amount = 20},
    {type = "fluid", name = "heavy-oil", amount = 80}
}
r.results = {
    { amount = 10, name = "petroleum-gas", type = "fluid" },
    { amount = 35, name = "bob-liquid-fuel", type = "fluid" },
    { amount = 25, name = "light-oil", type = "fluid" },
 }
 r.subgroup = "bob-fluid-oil"

r = data.raw.recipe["bob-coal-cracking"] -- Bergius process
r.category = "oil-processing"
for i, component in pairs(r.ingredients) do
    if component.name == "water" then
        component.amount = 75
        component.name = "bob-hydrogen"
    end
end
table.insert(r.ingredients, {amount = 30, name = "heavy-oil", type = "fluid", ignored_by_stats = 30})
r.energy_required = 5
r.results = {
     { amount = 5, name = "bob-sour-gas", type = "fluid" },
     { amount = 45, name = "heavy-oil", type = "fluid", ignored_by_stats = 30, ignored_by_productivity = 30 },
     { amount = 10, name = "light-oil", type = "fluid" },
     { amount = 2, name = "carbon", type = "item" }
}
r.allow_decomposition = false
r.subgroup = "bob-fluid-oil"

r = data.raw.recipe["coal-liquefaction"] -- Fischer Tropsch process
r.ingredients = {
    { amount = 140, name = "bob-oxygen", type = "fluid" },
    { type = "fluid", name = "steam", amount = 110, minimum_temperature = 325, maximum_temperature = 375},
    { amount = 10, name = "coal", type = "item" }
}
r.energy_required = 7
r.allow_decomposition = false
r.results = {
    { amount = 40, name = "petroleum-gas", type = "fluid" },
    { amount = 45, name = "bob-liquid-fuel", type = "fluid" },
    { amount = 35, name = "bob-carbon-dioxide", type = "fluid" },
    { amount_min = 3, amount_max = 7, name = "oil-residue", type = "item", ignored_by_productivity = 7 },
    { amount_min = 2, amount_max = 3, name = "sulfur", type = "item", ignored_by_productivity = 3 }
}

r = data.raw.recipe["bob-polishing-compound"]
if r then
    for i, component in pairs(r.ingredients) do
        if component.name == "light-oil" then
            component.name = "heavy-oil"
        end
    end
end
r = data.raw.recipe["bob-alien-fire"]
if r then
    for i, component in pairs(r.ingredients) do
        if component.name == "heavy-oil" then
            component.name = "bob-liquid-fuel"
        end
    end
end
r = data.raw.recipe["bob-synthetic-wood"]
if r then
    for i, component in pairs(r.ingredients) do
        if component.name == "heavy-oil" then
            component.name = "light-oil"
        end
    end
end
r = data.raw.recipe["flamethrower-ammo"]
for i, component in pairs(r.ingredients) do
    if component.name == "heavy-oil" then
        component.name = "bob-liquid-fuel"
    end
end
r = data.raw.recipe["bob-glycerol"]
if r then
    r.ingredients = {
        { amount = 60, name = "petroleum-gas", type = "fluid" },
        { amount = 60, name = "bob-chlorine", type = "fluid" },
        { amount = 2, name = "bob-sodium-hydroxide", type = "item" }
    }
    r.results[1].amount = 50
    r.energy_required = 3
end

r = data.raw.recipe["bob-petroleum-gas-cracking"]
for i, component in pairs(r.ingredients) do
    if component.name == "petroleum-gas" then
        component.amount = 20
    elseif component.name == "water" then
        component.amount = 50
    end
    r.energy_required = 4
end

data.raw.fluid["bob-liquid-fuel"].fuel_value = "625kJ"
data.raw.fluid["heavy-oil"].fuel_value = "300kJ"
data.raw.fluid["light-oil"].fuel_value = "410kJ"
data.raw.fluid["crude-oil"].fuel_value = "380kJ"
data.raw.fluid["petroleum-gas"].fuel_value = "420kJ"
data.raw.fluid["bob-sour-gas"].fuel_value = "480kJ"
data.raw.fluid["bob-glycerol"].fuel_value = "380kJ"

r = data.raw.recipe["solid-fuel-from-heavy-oil"]
if r then
    r.ingredients = {
        { amount = 15, name = "heavy-oil", type = "fluid" },
        { amount = 5, name = "bob-liquid-fuel", type = "fluid" },
        { amount = 1, name = "carbon", type = "item" }
    }
    r.energy_required = 2
end
r = data.raw.recipe["solid-fuel-from-petroleum-gas"]
if r then
    r.ingredients = {
        { amount = 25, name = "petroleum-gas", type = "fluid" },
        { amount = 2, name = "carbon", type = "item" }
    }
    r.energy_required = 2
end
r = data.raw.recipe["bob-solid-fuel-from-hydrogen"]
if r then
    for i, component in pairs(r.ingredients) do
        if component.name == "coal" then
            component.amount = 3
            component.name = "carbon"
        elseif component.name == "bob-hydrogen" then
           -- component.amount = 300
        end
    end
end
r = data.raw.recipe["solid-fuel-from-light-oil"]
if r then
    r.ingredients = {
        { amount = 20, name = "light-oil", type = "fluid" },
        { amount = 3, name = "bob-liquid-fuel", type = "fluid" },
        { amount = 1, name = "carbon", type = "item" }
    }
    r.energy_required = 2
end

r = table.deepcopy(data.raw.recipe["solid-fuel-from-light-oil"])
r.name = "solid-fuel"
r.ingredients = {
    { amount = 16, name = "bob-liquid-fuel", type = "fluid" },
    { amount = 1, name = "carbon", type = "item" }
}
r.icon = nil
data:extend({r})
table.insert(data.raw.technology["flammables"].effects, { recipe = "solid-fuel", type = "unlock-recipe" })

r = data.raw.recipe["bob-enriched-fuel"]
r.ingredients = {
    { amount = 45, name = "bob-liquid-fuel", type = "fluid" },
    { amount = 2, name = "solid-fuel", type = "item" }
}