

data:extend(
    {
        {
            type = "fluid",
            name = "low-enrich-heavy-water-mn",
            icons = {
                {
                    icon = "__MilitaryNerfing__/graphics/icons/Recipe-Backing.png",
                    icon_size = 64,
                },
                {
                    icon = data.raw["fluid"]["bob-pure-water"].icon,
                    icon_size = data.raw["fluid"]["bob-pure-water"].icon_size,
                    scale = 10 / 16,
                    shift = {-12, 0},
                },
                {
                    icon = data.raw["fluid"]["bob-heavy-water"].icon,
                    icon_size = data.raw["fluid"]["bob-heavy-water"].icon_size,
                    scale = 8 / 16,
                    shift = {10, 0},
                }
            },
            subgroup = "fluid",
            default_temperature = 90,
            max_temperature = 120,
            base_color = { r = 0.2, g = 0.35, b = 0.5 },
            flow_color = { r = 0.8, g = 0.6, b = 0.4 },
        },
        {
            type = "fluid",
            name = "GS-depleted-water-mn",
            icon = "__MilitaryNerfing__/graphics/icons/fluid-droplet-dirty-water.png",
            icon_size = 64,
            subgroup = "fluid",
            default_temperature = 90,
            max_temperature = 120,
            base_color = {r=0.3, g=0.4, b=0.8},
            flow_color = {r=0.9, g=0.8, b=1.0},
        },
        {
            type = "recipe",
            name = "low-enrich-heavy-water-mn",
            icons = {
                {
                    icon = "__MilitaryNerfing__/graphics/icons/Recipe-Backing.png",
                    icon_size = 64,
                },
                {
                    icon =  data.raw["fluid"]["bob-pure-water"].icon,
                    icon_size = data.raw["fluid"]["bob-pure-water"].icon_size,
                    scale = 7 / 16,
                    shift = {-12, 10},
                },
                {
                    icon = "__MilitaryNerfing__/graphics/icons/fluid-droplet-dirty-water.png",
                    icon_size = 64,
                    scale = 7 / 16,
                    shift = {12, 12},
                },
                {
                    icon = data.raw["fluid"]["bob-hydrogen-sulfide"].icon,
                    icon_size = data.raw["fluid"]["bob-hydrogen-sulfide"].icon_size,
                    scale = 6 / 16,
                    shift = {16, -12},
                }
            },
            energy_required = 80,
            category = "advanced-chemistry",
            enabled = false,
            subgroup = "fluid",
            ingredients = {
                {type = "fluid", name = "water", amount = 2000},
                {type = "fluid", name = "bob-hydrogen-sulfide", amount = 15},
                {type = "fluid", name = "bob-pure-water", amount = 200}
            },
            results = {
                { type = "fluid", name = "low-enrich-heavy-water-mn", amount = 1 },
                { type = "fluid", name = "GS-depleted-water-mn", amount = 1700 },
            },
            --main_product = "low-enrich-heavy-water-mn"
        },
        {
            type = "recipe",
            name = "bob-pure-water-out-of-depleted",
            icons = {
                {
                    icon = "__MilitaryNerfing__/graphics/icons/Recipe-Backing.png",
                    icon_size = 64,
                },
                {
                    icon =  data.raw["fluid"]["bob-pure-water"].icon,
                    icon_size = data.raw["fluid"]["bob-pure-water"].icon_size,
                    scale = 7 / 16,
                    shift = {-12, 10},
                },
                {
                    icon = "__MilitaryNerfing__/graphics/icons/fluid-droplet-dirty-water.png",
                    icon_size = 64,
                    scale = 7 / 16,
                    shift = {0, -10},
                },
                {
                    icon = data.raw["item"]["sulfur"].icon,
                    icon_size = 64,
                    scale = 4 / 16,
                    shift = {17, 12},
                },
            },
            energy_required = 10,
            category = "bob-distillery",
            enabled = false,
            ingredients = {
                {type = "fluid", name = "GS-depleted-water-mn", amount = 235}
            },
            results = {
                { type = "item", name = "sulfur", amount = 1 },
                { amount = 200, name = "bob-pure-water", type = "fluid" }
            },
            main_product = "bob-pure-water"
        }
})
table.insert(data.raw.technology["bob-heavy-water-processing"].effects, { recipe = "low-enrich-heavy-water-mn", type = "unlock-recipe" })
table.insert(data.raw.technology["bob-heavy-water-processing"].effects, { recipe = "bob-pure-water-out-of-depleted", type = "unlock-recipe" })
