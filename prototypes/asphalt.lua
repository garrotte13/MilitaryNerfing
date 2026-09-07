local tile_transitions = {}

water_tile_type_names = water_tile_type_names or {}
water_transition_group_id = water_transition_group_id or 1
out_of_map_tile_type_names = out_of_map_tile_type_names or {}
out_of_map_transition_group_id = out_of_map_transition_group_id or 2
default_transition_group_id = default_transition_group_id or 0

local tile_graphics = require("__base__/prototypes/tile/tile-graphics")
local tile_spritesheet_layout = tile_graphics.tile_spritesheet_layout

table.insert(water_tile_type_names, "water")
table.insert(water_tile_type_names, "deepwater")
table.insert(water_tile_type_names, "water-green")
table.insert(water_tile_type_names, "deepwater-green")
table.insert(water_tile_type_names, "water-shallow")
table.insert(water_tile_type_names, "water-mud")
table.insert(water_tile_type_names, "water-wube")
table.insert(out_of_map_tile_type_names, "out-of-map")

local stone_path_to_out_of_map_transition =
{
  to_tiles = out_of_map_tile_type_names,
  transition_group = out_of_map_transition_group_id,

  background_layer_offset = 1,
  background_layer_group = "zero",
  offset_background_layer_by_tile_layer = true,

  spritesheet = "__base__/graphics/terrain/out-of-map-transition/stone-path-out-of-map-transition.png",
  layout = tile_spritesheet_layout.transition_4_4_8_1_1,
  mask_enabled = false
}

function tile_transitions.asphalt_transitions()
    return
    {
        {
            to_tiles = water_tile_type_names,
            transition_group = water_transition_group_id,

            spritesheet = "__base__/graphics/terrain/water-transitions/stone-path.png",
            layout = tile_spritesheet_layout.transition_8_8_8_4_4,
            background_enabled = false,
            effect_map_layout =
            {
            spritesheet = "__base__/graphics/terrain/effect-maps/water-stone-mask.png",
            inner_corner_count = 1,
            outer_corner_count = 1,
            side_count = 1,
            u_transition_count = 1,
            o_transition_count = 1
            }
        },
    stone_path_to_out_of_map_transition
    }
end

function tile_transitions.asphalt_transitions_between_transitions()
    return
    {
        {
            transition_group1 = default_transition_group_id,
            transition_group2 = water_transition_group_id,

            spritesheet = "__base__/graphics/terrain/water-transitions/stone-path-transitions.png",
            layout = tile_spritesheet_layout.transition_3_3_3_1_0,
            background_enabled = false,
            effect_map_layout =
            {
            spritesheet = "__base__/graphics/terrain/effect-maps/water-stone-to-land-mask.png",
            --o_transition_count = 0
			inner_corner_count = 1,
			outer_corner_count = 1,
			side_count = 1,
			u_transition_count = 1,
			o_transition_count = 1
            }
        },
        {
            transition_group1 = default_transition_group_id,
            transition_group2 = out_of_map_transition_group_id,

            background_layer_offset = 1,
            background_layer_group = "zero",
            offset_background_layer_by_tile_layer = true,

            spritesheet = "__base__/graphics/terrain/out-of-map-transition/stone-path-out-of-map-transition-b.png",
            layout = tile_spritesheet_layout.transition_3_3_3_1_0,
            mask_enabled = false
        },
        {
            transition_group1 = water_transition_group_id,
            transition_group2 = out_of_map_transition_group_id,

            background_layer_offset = 1,
            background_layer_group = "zero",
            offset_background_layer_by_tile_layer = true,

            spritesheet = "__base__/graphics/terrain/out-of-map-transition/stone-path-shore-out-of-map-transition.png",
            layout = tile_spritesheet_layout.transition_3_3_3_1_0,
            mask_enabled = false,
            effect_map_layout =
            {
            spritesheet = "__base__/graphics/terrain/effect-maps/water-stone-to-out-of-map-mask.png",
            u_transition_count = 0,
            o_transition_count = 0
            }
        }
    }
end


-- asphalt (item)
local asphalt = table.deepcopy(data.raw["item"]["concrete"])
asphalt.name = "asphalt"
asphalt.order = "b[asphalt]-a[plain]"
asphalt.icon = "__MilitaryNerfing__/graphics/icons/asphalt.png"
asphalt.place_as_tile.result = "asphalt"
data:extend{asphalt}

-- asphalt (recipe)
local asphalt_recipe = table.deepcopy(data.raw["recipe"]["concrete"])
asphalt_recipe.name = "asphalt"
asphalt_recipe.energy_required = 8.0
asphalt_recipe.category = "bob-chemical-furnace"
asphalt_recipe.ingredients = {
	{ amount = 1, name = "bob-limestone", type = "item"  },
    { amount = 5, name = "stone", type = "item"  },
	{ amount = 100, name = "hot-tar", type = "fluid" },
}
asphalt_recipe.results = {
	{ amount = 10, name = "asphalt", type = "item" },
}
data:extend{asphalt_recipe}

-- asphalt (technology)
local asphalt_tech = table.deepcopy(data.raw["technology"]["concrete"])
asphalt_tech.name = "asphalt"
asphalt_tech.icon = "__MilitaryNerfing__/graphics/technology/asphalt.png"
asphalt_tech.effects = {
	{ recipe = "asphalt", type = "unlock-recipe" },
}
asphalt_tech.prerequisites = {
	"advanced-oil-processing",
	"lubricant",
	"concrete"
}
asphalt_tech.unit = {
	count = 200,
	ingredients = {
		{ "automation-science-pack", 1 },
		{ "logistic-science-pack" , 1 },
		{ "chemical-science-pack" , 1 },
	},
	time = 30
}
data:extend{asphalt_tech}

-- asphalt (tile)
local asphalt_tile = table.deepcopy(data.raw["tile"]["refined-concrete"])
asphalt_tile.name = "asphalt"
asphalt_tile.minable.result = "asphalt"
asphalt_tile.order = "a[artificial]-b[tier-2]-a[asphalt]"
asphalt_tile.decorative_removal_probability = 0.9
asphalt_tile.walking_speed_modifier = 1.45
--asphalt_tile.vehicle_friction_modifier = 0.7
--asphalt_tile.variants.material_background.picture = "__MilitaryNerfing__/graphics/entity/asphalt.png"
asphalt_tile.variants = 
{
	main =
	{
		{
			picture = "__MilitaryNerfing__/graphics/entity/asphalt1.png",
			count = 16,
			size = 1
		},
		{
			picture = "__MilitaryNerfing__/graphics/entity/asphalt2.png",
			count = 4,
			size = 2,
			probability = 0.3,
		},
		{
			picture = "__MilitaryNerfing__/graphics/entity/asphalt4.png",
			count = 4,
			size = 4,
			probability = 0.8,
		},
	},
	transition = {
		--layout = {
			--overlay = {
			overlay_layout = {
				inner_corner =
				{
					spritesheet = "__base__/graphics/terrain/concrete/concrete-inner-corner.png",
					count = 16,
					scale = 0.5
				},
				outer_corner =
				{
					spritesheet = "__base__/graphics/terrain/concrete/concrete-outer-corner.png",
					count = 8,
					scale = 0.5
				},
				--[[inner_corner =
				{
					spritesheet = "__MilitaryNerfing__/graphics/entity/asphalt-inner-corner.png",
					count = 8
				},
				outer_corner =
				{
					spritesheet = "__MilitaryNerfing__/graphics/entity/asphalt-outer-corner.png",
					count = 8
				},
				side =
				{
					spritesheet = "__MilitaryNerfing__/graphics/entity/asphalt-side.png",
					count = 8
				},]]
				side =
				{
				  spritesheet = "__base__/graphics/terrain/concrete/concrete-side.png",
				  count = 16,
				  scale = 0.5
				},
				u_transition =
				{
					spritesheet = "__base__/graphics/terrain/concrete/concrete-u.png",
					count = 8,
					scale = 0.5
				},
				--[[u_transition =
				{
					spritesheet = "__MilitaryNerfing__/graphics/entity/asphalt-u.png",
					count = 8
				},]]
					o_transition =
				{
					spritesheet = "__MilitaryNerfing__/graphics/entity/asphalt-o.png",
					count = 1
				}
			}, -- End of mask
			mask_layout =
			{
			  inner_corner =
			  {
				spritesheet = "__base__/graphics/terrain/concrete/concrete-inner-corner-mask.png",
				count = 16,
				scale = 0.5
			  },
			  outer_corner =
			  {
				spritesheet = "__base__/graphics/terrain/concrete/concrete-outer-corner-mask.png",
				count = 8,
				scale = 0.5
			  },
			  side =
			  {
				spritesheet = "__base__/graphics/terrain/concrete/concrete-side-mask.png",
				count = 16,
				scale = 0.5
			  },
			  u_transition =
			  {
				spritesheet = "__base__/graphics/terrain/concrete/concrete-u-mask.png",
				count = 8,
				scale = 0.5
			  },
			  o_transition =
			  {
				spritesheet = "__base__/graphics/terrain/concrete/concrete-o-mask.png",
				count = 4,
				scale = 0.5
			  }
			} 
		--} -- End of layout
	} -- end of transition
}
asphalt_tile.transitions = tile_transitions.asphalt_transitions()
asphalt_tile.transitions_between_transitions = tile_transitions.asphalt_transitions_between_transitions()
data:extend{asphalt_tile}
