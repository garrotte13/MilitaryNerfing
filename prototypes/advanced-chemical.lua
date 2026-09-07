local hit_effects = require("__base__/prototypes/entity/hit-effects")
local sounds = require("__base__/prototypes/entity/sounds")

-- remnant
data:extend({
    {
        type = "recipe-category",
        name = "advanced-chemistry"
      },
  {
    type = "corpse",
    name = "kr-big-random-pipes-remnant",
    icon = "__MilitaryNerfing__/graphics/remnant/remnants-icon.png",
    flags = { "placeable-neutral", "building-direction-8-way", "not-on-map" },
    selection_box = { { -4, -4 }, { 4, 4 } },
    tile_width = 3,
    tile_height = 3,
    selectable_in_game = false,
    subgroup = "remnants",
    order = "z[remnants]-a[generic]-b[big]",
    time_before_removed = 60 * 60 * 20, -- 20 minutes
    final_render_layer = "remnants",
    remove_on_tile_placement = false,
    animation = make_rotated_animation_variations_from_sheet(1, {
      filename = "__MilitaryNerfing__/graphics/remnant/hr-big-random-pipes-remnant.png",
      line_length = 1,
      width = 500,
      height = 500,
      frame_count = 1,
      direction_count = 1,
      scale = 0.5,
    }),
  },
})

-- pipes
local empty_sprite = {
  filename = "__MilitaryNerfing__/graphics/empty.png",
  priority = "high",
  width = 1,
  height = 1,
  scale = 0.5,
  shift = { 0, 0 },
}

local kr_pipe_path = {
  north = empty_sprite,
  east = empty_sprite,
  south = {
    filename = "__MilitaryNerfing__/graphics/pipe-patch/hr-pipe-patch.png",
    priority = "high",
    width = 55,
    height = 50,
    scale = 0.5,
    shift = { 0.01, -0.58 },
  },
  west = empty_sprite,
}

-- item
local chemical_plant_item = {
  type = "item",
  name = "kr-advanced-chemical-plant",
  icon = "__MilitaryNerfing__/graphics/icons/advanced-chemical-plant.png",
  subgroup = "bob-chemical-machine",
  order = "e[chemical-plant]-b[advanced-chemical-plant]",
  place_result = "kr-advanced-chemical-plant",
  stack_size = 50,
}

data:extend({ chemical_plant_item })

-- entity
data:extend({
  {
    type = "assembling-machine",
    name = "kr-advanced-chemical-plant",
    icon = "__MilitaryNerfing__/graphics/icons/advanced-chemical-plant.png",
    flags = { "placeable-neutral", "placeable-player", "player-creation" },
    minable = { mining_time = 1, result = "kr-advanced-chemical-plant" },
    max_health = 950,
    circuit_wire_max_distance = assembling_machine_circuit_wire_max_distance,
    circuit_connector = circuit_connector_definitions.create_vector(universal_connector_template,
      {
        { variation = 0, main_offset = util.by_pixel(96, -88),    shadow_offset = util.by_pixel(96, -88),    show_shadow = true },
        { variation = 6, main_offset = util.by_pixel(50.5, 19.5), shadow_offset = util.by_pixel(77.5, 52.5), show_shadow = false },
        { variation = 4, main_offset = util.by_pixel(-72, 8),     shadow_offset = util.by_pixel(-33, 52),    show_shadow = false },
        { variation = 2, main_offset = util.by_pixel(-50.5, 12),  shadow_offset = util.by_pixel(-33.5, 42),  show_shadow = false }
      }
    ),
    corpse = "kr-big-random-pipes-remnant",
    dying_explosion = "big-explosion",
    damaged_trigger_effect = hit_effects.entity(),
    resistances = {
      { type = "physical", percent = 50 },
      { type = "fire",     percent = 70 },
      { type = "impact",   percent = 70 },
    },
    fluid_boxes = {
      {
        production_type = "input",
        pipe_covers = pipecoverspictures(),
        pipe_picture = kr_pipe_path,
        volume = 2000,
        base_area = 20,
        base_level = -1,
        pipe_connections = { { flow_direction = "input", direction = defines.direction.north, position = { 2, -3 } } },
      },
      {
        production_type = "input",
        pipe_covers = pipecoverspictures(),
        pipe_picture = kr_pipe_path,
        volume = 2000,
        pipe_connections = { { flow_direction = "input", direction = defines.direction.north, position = { 0, -3 } } },
      },
      {
        production_type = "input",
        pipe_covers = pipecoverspictures(),
        pipe_picture = kr_pipe_path,
        volume = 2000,
        pipe_connections = { { flow_direction = "input", direction = defines.direction.north, position = { -2, -3 } } },
      },
      {
        production_type = "output",
        pipe_covers = pipecoverspictures(),
        pipe_picture = kr_pipe_path,
        volume = 1000,
        pipe_connections = { { flow_direction = "output", direction = defines.direction.south, position = { 2, 3 } } },
      },
      {
        production_type = "output",
        pipe_covers = pipecoverspictures(),
        pipe_picture = kr_pipe_path,
        volume = 1000,
        pipe_connections = { { flow_direction = "output", direction = defines.direction.south, position = { 0, 3 } } },
      },
      {
        production_type = "output",
        pipe_covers = pipecoverspictures(),
        pipe_picture = kr_pipe_path,
        volume = 1000,
        pipe_connections = { { flow_direction = "output", direction = defines.direction.south, position = { -2, 3 } } },
      },
    },
    collision_box = { { -3.25, -3.25 }, { 3.25, 3.25 } },
    selection_box = { { -3.5, -3.5 }, { 3.5, 3.5 } },
    fast_replaceable_group = "assembling-machine",
    crafting_categories = { "advanced-chemistry" },
    crafting_speed = 3,
    ingredient_count = 6,
    module_slots = 5,
    allowed_effects = { "consumption", "speed", "pollution" },
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = { pollution = 3 },
    },
    energy_usage = "500kW",
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    vehicle_impact_sound = sounds.generic_impact,
    working_sound = {
      sound = { filename = "__MilitaryNerfing__/sounds/advanced-chemical-plant.ogg" },
      idle_sound = { filename = "__base__/sound/idle1.ogg" },
      apparent_volume = 1,
    },
    graphics_set = {
      animation = {
        layers = {
          {
            filename = "__MilitaryNerfing__/graphics/entity/hr-advanced-chemical-plant.png",
            priority = "high",
            width = 451,
            height = 535,
            shift = { 0, -0.48 },
            frame_count = 20,
            line_length = 5,
            animation_speed = 0.25,
            scale = 0.5,
          },
          {
            filename = "__MilitaryNerfing__/graphics/entity/hr-advanced-chemical-plant-sh.png",
            priority = "high",
            width = 516,
            height = 458,
            shift = { 0.33, 0.32 },
            frame_count = 1,
            repeat_count = 20,
            animation_speed = 0.25,
            scale = 0.5,
            draw_as_shadow = true,
          },
        },
      },
    },
    water_reflection = {
      pictures = {
        filename = "__MilitaryNerfing__/graphics/entity/advanced-chemical-plant-reflection.png",
        priority = "extra-high",
        width = 80,
        height = 60,
        shift = util.by_pixel(0, 40),
        variation_count = 1,
        scale = 5,
      },
      rotate = false,
      orientation_to_variation = false,
    },
    icon_draw_specification = { scale = 2, shift = { 0, -0.3 } },
    icons_positioning = { { inventory_index = defines.inventory.assembling_machine_modules, shift = { 0, 1.25 } } },
  }
})

-- recipe
data:extend({
  {
    type = "recipe",
    name = "kr-advanced-chemical-plant",
    energy_required = 30,
    enabled = false,
    ingredients =
    {
      { type = "item", name = "bob-chemical-plant-2", amount = 2 },
      { type = "item", name = "advanced-circuit", amount = 18 },
      { type = "item", name = "bob-titanium-bearing", amount = 10 },
      { type = "item", name = "speed-module-2", amount = 4 },
      { type = "item", name = "bob-nickel-plate", amount = 10 },
      { type = "item", name = "efficiency-module-2", amount = 4 },
    },
    results = { { type = "item", name = "kr-advanced-chemical-plant", amount = 1 } },
  }
})

-- technology
data:extend({
  {
    type = "technology",
    name = "kr-advanced-chemical-plant",
    --mod = "Krastorio2",
    icon = "__MilitaryNerfing__/graphics/technology/advanced-chemical-plant.png",
    icon_size = 256,
    effects = {
      {
        type = "unlock-recipe",
        recipe = "kr-advanced-chemical-plant",
      },
      {
        type = "unlock-recipe",
        recipe = "mn-advanced-sulphuric-acid",
      },
      
    },
    prerequisites =
    {
      "speed-module-2",
      "efficiency-module-2",
      "bob-chemical-plant-2",
      --"production-science-pack"
    },
    unit = {
      count = 250,
      ingredients = {
        { "chemical-science-pack", 1 },
        { "automation-science-pack", 1 },
        { "logistic-science-pack",   1 },
        --{ "production-science-pack", 1 }
      },
      time = 45,
    },
  }
}) 