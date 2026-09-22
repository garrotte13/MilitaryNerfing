require("__MilitaryNerfing__/prototypes/fix-graphics")


local furnaces_to_remove = {}
for furnace_name, furnace_prototype in pairs(data.raw["furnace"]) do
    if string.find(furnace_name, "^bob%-distillery") then
        local new_assembler = table.deepcopy(furnace_prototype)
        new_assembler.type = "assembling-machine"
        new_assembler.crafting_categories = furnace_prototype.crafting_categories or { "smelting" }
        new_assembler.ingredient_count = new_assembler.ingredient_count or 4 
        new_assembler.result_inventory_size = 2 
        new_assembler.show_recipe_icon = false
        data.raw["assembling-machine"][furnace_name] = new_assembler
        table.insert(furnaces_to_remove, furnace_name)
    end
end
for _, furnace_name in ipairs(furnaces_to_remove) do
    data.raw["furnace"][furnace_name] = nil
end

--local plasma_proj = data.raw["projectile"]["bob-plasma-projectile"]
r = data.raw.recipe["bob-heavy-water"]
r.category = "advanced-chemistry"
r.energy_required = 50
r.allow_consumption = false
r.allow_speed = false
r.ingredients = {
    { amount = 35, name = "low-enrich-heavy-water-mn", type = "fluid" }
}
r.results = {
    { amount = 5, name = "bob-heavy-water", type = "fluid" },
    { amount = 30, name = "bob-pure-water", type = "fluid" }

}


local old_plasma = data.raw["electric-turret"]["bob-plasma-turret-3"]
if old_plasma then
    local new_plasma = table.deepcopy(old_plasma)
    new_plasma.type = "ammo-turret"
    --new_plasma.name = "electric-ammo-turret-x"
    new_plasma.inventory_size = 1
    --new_plasma.prepare_with_no_ammo = false
    --new_plasma.start_attacking_only_when_can_shoot = true
    new_plasma.automated_ammo_count = 10
    new_plasma.energy_source = table.deepcopy(old_plasma.energy_source)
    new_plasma.energy_source.drain = "4800kW"
    new_plasma.energy_per_shot = old_plasma.attack_parameters.ammo_type.energy_consumption  -- "22000kJ"
    new_plasma.attack_parameters = table.deepcopy(old_plasma.attack_parameters)
    new_plasma.attack_parameters.ammo_category = "bob-plasma-category-mn"
    new_plasma.attack_parameters.health_penalty = -1
    --new_plasma.prepare_range = nil
    data.raw["electric-turret"]["bob-plasma-turret-3"] = nil
    data:extend({ new_plasma,    
     })
end

