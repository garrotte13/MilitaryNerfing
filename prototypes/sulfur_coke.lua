
local coke = table.deepcopy(data.raw["item"]["solid-fuel"])
coke.name = "coke"
coke.order = "b[chemistry]-ba[coke]"
coke.icon = "__MilitaryNerfing__/graphics/icons/coke.png"
coke.fuel_value = "2MJ"
coke.fuel_acceleration_multiplier = 1.0
coke.fuel_top_speed_multiplier = 1.0
coke.subgroup = "bob-resource"

local residue = table.deepcopy(data.raw["item"]["solid-fuel"])
residue.name = "oil-residue"
residue.stack_size = 100
residue.order = "b[chemistry]-ba[oil-residue]"
residue.icon = "__MilitaryNerfing__/graphics/icons/oil-residue.png"
residue.fuel_value = "1MJ"
residue.fuel_acceleration_multiplier = 0.9
residue.fuel_top_speed_multiplier = 0.8
residue.fuel_emissions_multiplier = 4
residue.subgroup = "bob-resource"

local s_water = table.deepcopy(data.raw["fluid"]["petroleum-gas"])
s_water.name = "sulfur-water"
s_water.order = "a[fluid]-b[oil]-d[volatile-gas]"
s_water.icon = "__MilitaryNerfing__/graphics/icons/s_water.png"
s_water.base_color = { 0.906, 0.878, 0.592 }
s_water.flow_color = { 0.906, 0.878, 0.592 }

local hot_tar = table.deepcopy(data.raw["fluid"]["heavy-oil"])
hot_tar.name = "hot-tar"
hot_tar.default_temperature = 240
hot_tar.max_temperature = 800
hot_tar.heat_capacity = "3kJ"
hot_tar.order = "a[fluid]-b[oil]-d[hot-tar]"
hot_tar.icon = "__MilitaryNerfing__/graphics/icons/hot-tar.png"
hot_tar.base_color = { 0.173, 0.106, 0.090 } -- stat bars & pipe windows
hot_tar.flow_color = { 0.173, 0.106, 0.090 } -- slightly in pipe windows
hot_tar.visualization_color = { 0.173, 0.106, 0.090 } -- pipe visualizations

data:extend(
{
	residue, hot_tar,
    {
        type = "fluid",
		name = "processed-oil",
        icon = "__MilitaryNerfing__/graphics/icons/processed-oil.png",
        icon_size = 32,
        subgroup = "fluid",
        default_temperature = 15,
        max_temperature = 100,
        fuel_value = "300kJ",
        fuel_emissions_multiplier = 7,
        heat_capacity = "2kJ",
        base_color = {r=0.1, g=0.1, b=0.1},
        flow_color = {r=0.1, g=0.1, b=0.1},
	},
    {
        type = "recipe",
		name = "processed-oil",
		energy_required = 3,
        ingredients = {
            { amount = 100, name = "crude-oil", type = "fluid" },
            { amount = 20, name = "bob-pure-water", type = "fluid" }
        },
        results = {
            { amount = 75, name = "processed-oil", type = "fluid" },
            { amount = 20, name = "bob-sour-gas", type = "fluid" },
        },
        enabled = false,
        category = "chemistry",
        subgroup = "bob-fluid-oil",
        order = "a[oil-processing]-a[a-processed-oil]",
        --icon = "__MilitaryNerfing__/graphics/icons/separate.png"
        icons = {
			{
				icon = "__MilitaryNerfing__/graphics/icons/Recipe-Backing.png",
				icon_size = 64,
			},
			{
				icon =  data.raw["fluid"]["bob-pure-water"].icon,
				icon_size = data.raw["fluid"]["bob-pure-water"].icon_size,
				scale = 5 / 16,
				shift = {-6, -8},
			},
			{
				icon = "__base__/graphics/icons/fluid/crude-oil.png",
				icon_size = 64,
				scale = 6 / 16,
				shift = {8, -8},
			},
			{
				icon = "__MilitaryNerfing__/graphics/icons/processed-oil.png",
				icon_size = 32,
				scale = 10 / 16,
				shift = {-11, 10},
			},
			{
				icon =  data.raw["fluid"]["bob-sour-gas"].icon,
				icon_size = data.raw["fluid"]["bob-sour-gas"].icon_size,
				scale = 6 / 16,
				shift = {9, 11},
			},
		},
    },

    {
        type = "recipe",
		name = "mn-advanced-sulphuric-acid",
        localised_name = { "fluid-name.sulfuric-acid" },
		energy_required = 2,
        ingredients = {
            { amount = 50, name = "bob-sulfur-dioxide", type = "fluid" },
            { amount = 50, name = "bob-pure-water", type = "fluid" },
            { amount = 25, name = "bob-oxygen", type = "fluid" },
        },
        results = {
            { amount = 50, name = "sulfuric-acid", type = "fluid" }
        },
        enabled = false,
        category = "advanced-chemistry",
        subgroup = "fluid-recipes",
        order = "b[fluid-chemistry]-f[sulphuric-acid]",
    }
})

local ttech = data.raw.technology["bob-chemical-plant"]
table.insert(data.raw.technology["oil-processing"].effects, { recipe = "processed-oil", type = "unlock-recipe" })
