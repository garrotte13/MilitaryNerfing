local function hide_obj(name, entity_class)
    if data.raw.item[name] then
        data.raw.item[name].hidden = true
    end
    if data.raw.recipe[name] then
        data.raw.recipe[name].hidden = true
    end
    if data.raw[entity_class][name] then
        data.raw[entity_class][name].hidden = true
    end
end

local r = data.raw.recipe["piercing-rounds-magazine"]
for i, component in pairs(r.ingredients) do
    if component.name == "firearm-magazine" then
        component.amount = 1
    end
end
r.energy_required = 3
r.results[1].amount = 1

if mods["bobwarfare"] then
    data.raw.technology["bob-robot-gun-drones"].hidden = true
    data.raw.technology["bob-robot-laser-drones"].hidden = true
    data.raw.technology["bob-robot-flamethrower-drones"].hidden = true
    data.raw.technology["bob-robot-plasma-drones"].hidden = true
    hide_obj("bob-robot-plasma-drone", "unit")
    hide_obj("bob-robot-flamethrower-drone", "unit")
    hide_obj("bob-robot-laser-drone", "unit")
    hide_obj("bob-robot-gun-drone", "unit")
    data.raw.recipe["bob-robot-drone-frame"].hidden = true
    data.raw.recipe["bob-robot-drone-frame-large"].hidden = true
    --[[data.raw.item["bob-robot-plasma-drone"].hidden = true
    data.raw.item["bob-robot-flamethrower-drone"].hidden = true
    data.raw.item["bob-robot-laser-drone"].hidden = true
    data.raw.item["bob-robot-gun-drone"].hidden = true
    data.raw.recipe["bob-robot-plasma-drone"].hidden = true
    data.raw.recipe["bob-robot-flamethrower-drone"].hidden = true
    data.raw.recipe["bob-robot-laser-drone"].hidden = true
    data.raw.recipe["bob-robot-gun-drone"].hidden = true]]
    --data.raw.item["bob-plutonium-239"].hidden = true
    data.raw.recipe["rocket"].hidden = true
    data.raw.ammo["rocket"].hidden = true
    data.raw.recipe["explosive-rocket"].hidden = true
    data.raw.ammo["explosive-rocket"].hidden = true
    data.raw.technology["explosive-rocketry"].hidden = true
else
    table.insert(data.raw.recipe["rocket"].ingredients, {type="item", name="advanced-circuit", amount=1})
end

