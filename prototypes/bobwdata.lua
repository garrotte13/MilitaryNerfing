
data:extend({
    {
        type = "ammo-category",
        name = "bob-plasma-category-mn",
        icon = "__bobwarfare__/graphics/icons/plasma.png",
        icon_size = 64,
        subgroup = "ammo-category"
    },
    {
        type = "ammo",
        name = "bob-plasma-mn",
        icon = "__MilitaryNerfing__/graphics/icons/part-specimin-1.png",
        icon_size = 64,
        magazine_size = 1,
        subgroup = "bob-ammo",
        order = "g[plasma]",
        stack_size = 50,
        ammo_category = "bob-plasma-category-mn",
        ammo_type = {
            category = "bob-plasma-category-mn",
            target_type = "position",
            clamp_position = true,
            action = 
            {
                type = "direct",
                action_delivery = {
                  {
                    type = "projectile",
                    projectile = "bob-plasma-projectile",
                    starting_speed = 1,
                    direction_deviation = 0,
                    range_deviation = 0,
                    max_range = 50 * 2,
                  },
                }
            }
        }
    },
    {
        type = "recipe",
        name = "bob-plasma-mn",
        energy_required = 20,
        category = "chemistry",
        enabled = false,
        ingredients = {
            {type = "item", name = "bob-cobalt-steel-alloy", amount = 3},
            {type = "item", name = "bob-aluminium-plate", amount = 2},
            {type = "item", name = "advanced-circuit", amount = 1 },
            {type = "fluid", name = "bob-nitrogen-dioxide", amount = 45},
            {type = "fluid", name = "bob-deuterium", amount = 5},
            {type = "item", name = "bob-alien-artifact", amount = 1},
            {type = "item", name = "explosives", amount = 1}
        },
        results = { { type = "item", name = "bob-plasma-mn", amount = 1 } },
    }
})

local function addEffectToTech(tech, recipe)
    t = data.raw["technology"][tech]
    if t then
        t.effects[#t.effects+1] = recipe
    end
end



addEffectToTech("laser-weapons-damage-3",
{
    type = "ammo-damage",
    ammo_category = "bob-plasma-category-mn",
    modifier = 0.4
})

addEffectToTech("laser-weapons-damage-4",
{
    type = "ammo-damage",
    ammo_category = "bob-plasma-category-mn",
    modifier = 0.5
})

addEffectToTech("laser-weapons-damage-5",
{
    type = "ammo-damage",
    ammo_category = "bob-plasma-category-mn",
    modifier = 0.6
})

addEffectToTech("laser-weapons-damage-6",
{
    type = "ammo-damage",
    ammo_category = "bob-plasma-category-mn",
    modifier = 0.8
})

addEffectToTech("laser-weapons-damage-7",
{
    type = "ammo-damage",
    ammo_category = "bob-plasma-category-mn",
    modifier = 0.7
})