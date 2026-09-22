
data:extend({
    {
        type = "item",
        name = "part-artillery-shell-mn",
        icon = "__MilitaryNerfing__/graphics/icons/part-artillery-shell-casing.png",
        icon_size = 64,
        subgroup = "intermediate-product",
        order = "b[advanced-intermediates]-c[artillery-shell-part]",
        stack_size = 50
    },
    {
        type = "recipe",
        name = "part-artillery-shell-mn",
        category = "advanced-crafting",
        energy_required = 10,
        enabled = false,
        ingredients = {
            {type = "item", name = "radar", amount = 1},
            {type = "item", name = "explosive-cannon-shell", amount = 4},
            {type = "item", name = "explosives", amount = 2},
            {type = "item", name = "solid-fuel", amount = 1},
        },
        results = { { type = "item", name = "part-artillery-shell-mn", amount = 1 } },
    },
})
table.insert(data.raw.technology["artillery"].effects, { recipe = "part-artillery-shell-mn", type = "unlock-recipe" })
data.raw["recipe"]["artillery-shell"].ingredients = {
    {type = "item", name = "part-artillery-shell-mn", amount = 1},
    {type = "item", name = "explosives", amount = 4},

}