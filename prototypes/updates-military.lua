local function hide_obj(name, entity_class)
    if data.raw.item[name] then
        data.raw.item[name].hidden = true
    end
    if data.raw.recipe[name] then
        data.raw.recipe[name].hidden = true
    end
    if entity_class and data.raw[entity_class][name] then
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

r = data.raw["projectile"]["cannon-projectile"]
for i, dmg_effect in pairs(r.action.action_delivery.target_effects) do
    if dmg_effect.type == "damage" and dmg_effect.damage.type == "physical" and dmg_effect.damage.amount == 1000 then
        dmg_effect.damage.amount = 500
        r.piercing_damage = 600
        break
    end
end
r = data.raw["projectile"]["uranium-cannon-projectile"]
for i, dmg_effect in pairs(r.action.action_delivery.target_effects) do
    if dmg_effect.type == "damage" and dmg_effect.damage.type == "physical" and dmg_effect.damage.amount == 2000 then
        dmg_effect.damage.amount = 1000
        r.piercing_damage = 1320
        break
    end
end

r = data.raw["recipe"]["flamethrower-ammo"]
local found
for i, component in pairs(r.ingredients) do
    if component.name == "crude-oil" then
        component.amount = 50
        component.name = "light-oil"
        found = true
        break
    end
end
if found then
    table.insert(r.ingredients, {type="fluid", name="heavy-oil", amount=50})
end



if mods["bobwarfare"] then

    -- Hiding unlimited ammo forever lasting Bob drones
    data.raw.technology["bob-robot-gun-drones"].hidden = true
    data.raw.technology["bob-robot-laser-drones"].hidden = true
    data.raw.technology["bob-robot-flamethrower-drones"].hidden = true
    data.raw.technology["bob-robot-plasma-drones"].hidden = true
    hide_obj("bob-robot-plasma-drone", "unit")
    hide_obj("bob-robot-flamethrower-drone", "unit")
    hide_obj("bob-robot-laser-drone", "unit")
    hide_obj("bob-robot-gun-drone", "unit")
    --data.raw.recipe["bob-robot-drone-frame"].hidden = true
    --data.raw.recipe["bob-robot-drone-frame-large"].hidden = true
    hide_obj("bob-robot-drone-frame")
    hide_obj("bob-robot-drone-frame-large")

    -- Hiding vanilla rocket ammo
    data.raw.recipe["rocket"].hidden = true
    data.raw.ammo["rocket"].hidden = true
    data.raw.recipe["explosive-rocket"].hidden = true
    data.raw.ammo["explosive-rocket"].hidden = true
    data.raw.technology["explosive-rocketry"].hidden = true

    -- Adding min range for Bob sniper turrets
    for i = 1,3 do
        r = data.raw["ammo-turret"]["bob-sniper-turret-" .. i]
        if r then
            r.attack_parameters.min_range = 6 + i
        end
    end


else
    -- a rocket can't reach the target without electronics be it Nauvis or outer worlds
    table.insert(data.raw.recipe["rocket"].ingredients, {type="item", name="advanced-circuit", amount=1})
end

