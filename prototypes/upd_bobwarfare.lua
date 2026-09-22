

--[[
for _, prototype in pairs(data.raw.fire) do
    if string.find(prototype.name, "acid-splash", 1, true) then
      prototype.trigger_target_mask = {"ground-unit", "rock", "tree"}
      if settings.startup["pools-affect-structures"].value then
        table.insert(prototype.trigger_target_mask, "ground-static")
      end
]]

--** Fixing tanks balance
local r = data.raw.technology["bob-tanks-2"]
for i, component in pairs(r.prerequisites) do
  if component == "artillery" then
      r.prerequisites[i] = "bob-laser-rifle"
      break
  end
end
table.insert(data.raw.technology["bob-tanks-3"].prerequisites, "bob-plasma-turrets-3")

local tank_art_gun = data.raw["gun"]["bob-tank-artillery-2"]
if tank_art_gun then
    tank_art_gun.icon = "__reskins-bobs__/graphics/icons/vehicle-equipment/vehicle-plasma-turret/vehicle-plasma-turret-icon-base.png" 
    tank_art_gun.icon_size = 64
    tank_art_gun.attack_parameters.ammo_category = "bob-plasma-category-mn"
    tank_art_gun.attack_parameters.range = 58
    tank_art_gun.attack_parameters.damage_modifier = 5
    tank_art_gun.attack_parameters.cooldown = 375
end

local tank_laser0 = table.deepcopy(data.raw["gun"]["bob-tank-laser"])
tank_laser0.name = "bob-tank-laser-0"
tank_laser0.order = "z[tank]-c[0laser]"
tank_laser0.attack_parameters.damage_modifier = 1.5
tank_laser0.attack_parameters.range = 22
tank_laser0.attack_parameters.cooldown = 30
data:extend({ tank_laser0 })

local tank2 = data.raw["car"]["bob-tank-2"]
tank2.consumption = "1200kW"
tank2.guns = { "bob-tank-cannon-2", "bob-gatling-gun", "bob-tank-flamethrower-2", "bob-tank-laser-0" }

local tank3 = data.raw["car"]["bob-tank-3"]
tank3.consumption = "1700kW"
tank3.guns = { "bob-tank-cannon-3", "bob-gatling-gun", "bob-tank-flamethrower-3", "bob-tank-laser", "bob-tank-artillery-2"}

--** Fixing Artillery
data.raw["ammo"]["artillery-shell"].stack_size = 1
local r = data.raw.technology["artillery"]
for i, component in pairs(r.prerequisites) do
  if component == "processing-unit" then
      r.prerequisites[i] = "military-4"
      break
  end
end
table.insert(r.unit.ingredients, { "utility-science-pack" , 1 })

data.raw["recipe"]["artillery-shell"].ingredients = {
  {type = "item", name = "part-artillery-shell-mn", amount = 1},
  {type = "item", name = "explosives", amount = 10},
}
data.raw["recipe"]["part-artillery-shell-mn"].ingredients = {
  {type = "item", name = "radar", amount = 1},
  {type = "item", name = "steel-plate", amount = 6},
  {type = "item", name = "plastic-bar", amount = 5},
  {type = "item", name = "bob-aluminium-plate", amount = 5},
  {type = "item", name = "explosives", amount = 3},
  {type = "item", name = "solid-fuel", amount = 1}
}

data.raw["recipe"]["bob-distractor-artillery-shell"].ingredients = {
  {type = "item", name = "part-artillery-shell-mn", amount = 1},
  {type = "item", name = "bob-distractor-robot", amount = 15}
}

data.raw["recipe"]["bob-explosive-artillery-shell"].ingredients = {
  {type = "item", name = "part-artillery-shell-mn", amount = 1},
  {type = "fluid", name = "bob-alien-explosive", amount = 180}
}

data.raw["recipe"]["bob-fire-artillery-shell"].ingredients = {
  {type = "item", name = "part-artillery-shell-mn", amount = 1},
  {type = "fluid", name = "bob-alien-fire", amount = 150}
}

data.raw["recipe"]["bob-poison-artillery-shell"].ingredients = {
  {type = "item", name = "part-artillery-shell-mn", amount = 1},
  {type = "fluid", name = "bob-alien-poison", amount = 150}
}

data.raw["recipe"]["bob-atomic-artillery-shell"].ingredients = {
  {type = "item", name = "part-artillery-shell-mn", amount = 1},
  {type = "item", name = "explosives", amount = 10},
  {type = "item", name = "processing-unit", amount = 10},
  {type = "item", name = "uranium-235", amount = 20},
  {type = "item", name = "plutonium", amount = 10}
}