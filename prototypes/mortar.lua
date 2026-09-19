
require "util"
local sounds = require("__base__.prototypes.entity.sounds")
local hit_effects = require ("__base__.prototypes.entity.hit-effects")

local mortar_help = require("mortar_helpers")
local capsuleGrey = {r=0,g=0,b=0,a=0.9}
local particleGrey = {r=0,g=0,b=0,a=0.9}
local makeStreamProjectile = mortar_help.makeStreamProjectile

local function CapsuleLauncherSheet()
    return
        {
            layers =
                {
                    {
                        filename = "__MilitaryNerfing__/graphics/entity/arty2x2-sheet.png",
                        priority = "high",
                        width = 168,
                        height = 168,
                        line_length = 8,
                        axially_symmetrical = false,
                        direction_count = 64,
                        frame_count = 1,
                        shift = {0, -1.4},
                    }
                }
        }
end 

data:extend({
    {
        type = "ammo-category",
        name = "mortar-ammo-mn",
        subgroup = "ammo-category"
    },
    {
        type = "item-subgroup",
        name = "mortar-ammo-mn",
        group = "combat"
    },
    {
        type = "trigger-target-type",
        name = "mortar-victims",
    },
    {
        type = "ammo",
        name = "basic-mortar-mn",
        icon = "__MilitaryNerfing__/graphics/icons/grenade-capsule-ammo.png",
        icon_size = 32,
        magazine_size = 1,
        subgroup = "mortar-ammo-mn",
        order = "a[capsule]",
        stack_size = 100,
        ammo_category = "mortar-ammo-mn",			
        ammo_type = {
            category = "mortar-ammo-mn",
            target_type = "position",
            clamp_position = true,

            action =
            {
                type = "direct",
                action_delivery =
                    {
                        type = "stream",
                        stream = makeStreamProjectile({
                                name = "basic-mortar-mn",
                                bufferSize = 1,
                                spineAnimationTint = capsuleGrey,
                                particleTint = particleGrey,
                                spawnInterval = 1,
                                actions = {
                                    {
                                        type = "direct",
                                        action_delivery =
                                            {
                                                type = "instant",
                                                target_effects =
                                                    {
                                                        {
                                                            type = "create-entity",
                                                            entity_name = "medium-explosion"
                                                        },
                                                        {
                                                            type = "create-entity",
                                                            entity_name = "small-scorchmark",
                                                            check_buildability = true
                                                        },
                                                        {
                                                            type = "damage",
                                                            damage = {amount = 80, type = "impact"}
                                                        },
                                                        {
                                                            type = "invoke-tile-trigger",
                                                            repeat_count = 1,
                                                        },
                                                        {
                                                            type = "destroy-decoratives",
                                                            from_render_layer = "decorative",
                                                            to_render_layer = "object",
                                                            include_soft_decoratives = true,
                                                            include_decals = false,
                                                            invoke_decorative_trigger = true,
                                                            decoratives_with_trigger_only = false,
                                                            radius = 3
                                                        }
                                                    }
                                            }
                                    },
                                    {
                                        type = "area",
                                        radius = 5,
                                        action_delivery =
                                            {
                                                type = "instant",
                                                target_effects =
                                                    {
                                                        {
                                                            type = "damage",
                                                            damage = {amount = 400, type = "explosion"}
                                                        },
                                                        {
                                                            type = "create-entity",
                                                            entity_name = "explosion"
                                                        }
                                                    }
                                            }
                                    }
                                }
                        }),
                        max_length = 9,
                        duration = 200,
                    }
            }
    }},
    {
        name = "mortar-turret-mn",
        type = "ammo-turret",
        icon = "__MilitaryNerfing__/graphics/icons/capsuleTurret.png",
        icon_size = 32,
        flags = {"placeable-player", "player-creation"},
        minable = {mining_time = 2, result = "mortar-turret-mn"},
        max_health = 900,
        corpse = "medium-remnants",
        --starting_attack_sound = {
        --        {filename = "__MilitaryNerfing__/sounds/mortar-shot.ogg", volume = 0.8}
        --},
        attack_parameters = {
            ammo_category = "mortar-ammo-mn",
            type = "stream",
            cooldown = 450,
            damage_modifier = 1.25,
            lead_target_for_projectile_speed = 0.4,
            gun_center_shift = { --to reconsider
                north = {0, 0},
                east = {0, -1},
                south = {0, 0},
                west = {0, -1}
            },
            gun_barrel_length = 3.5,
            min_range = 19,
            turn_range = 0.5,
            range = 57,
            sound = {
                    {filename = "__MilitaryNerfing__/sounds/mortar-shot.ogg", volume = 0.8}
                }
        },
        attack_target_mask = {"mortar-victims"},
        collision_box = {{-0.9, -0.9 }, {0.9, 0.9}},
        selection_box = {{-1, -1 }, {1, 1}},
        rotation_speed = 0.004,
        preparing_sound = sounds.gun_turret_activate,
        folding_sound = sounds.gun_turret_deactivate,
        rotating_sound =
        {
            sound =
                {
                    filename = "__base__/sound/fight/gun-turret-rotation-01.ogg",
                    volume = 0.3
                }
        },
        preparing_speed = 0.08,
        folding_speed = 0.08,
        dying_explosion = "medium-explosion",
        inventory_size = 1,
        automated_ammo_count = 5,
        attacking_speed = 0.5,
        alert_when_attacking = true,
        open_sound = sounds.machine_open,
        close_sound = sounds.machine_close,
        graphics_set = {},
        folded_animation = CapsuleLauncherSheet(),
        preparing_animation = CapsuleLauncherSheet(),
        prepared_animation = CapsuleLauncherSheet(),
        folding_animation = CapsuleLauncherSheet(),
        water_reflection =
        {
            pictures =
                {
                    filename = "__base__/graphics/entity/gun-turret/gun-turret-reflection.png",
                    priority = "extra-high",
                    width = 20,
                    height = 32,
                    shift = util.by_pixel(0, 40),
                    variation_count = 1,
                    scale = 5,
                },
            rotate = false,
            orientation_to_variation = false
        },
        call_for_help_radius = 40,
        vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },        
        --turret_base_has_direction = true,
        resistances = {
            {
                type = "fire",
                percent = 30
            },
            {
                type = "impact",
                percent = 30
            },
            {
                type = "explosion",
                percent = 20
            },
            {
                type = "physical",
                percent = 20
            },
            {
                type = "acid",
                percent = 30
            },
            {
                type = "electric",
                percent = 20
            },
            {
                type = "laser",
                percent = 20
            },
            {
                type = "poison",
                percent = 30
            }
        }
    },
    {
        type = "item",
        name = "mortar-turret-mn",
        icon = "__MilitaryNerfing__/graphics/icons/capsuleTurret.png",
        icon_size = 32,
        subgroup = "defensive-structure",
        order = "b[turret]-d[acapsule-turret]",
        place_result = "mortar-turret-mn",
        stack_size = 50
    },
    {
        type = "recipe",
        name = "mortar-turret-mn",
        energy_required = 30,
        enabled = false,
        ingredients =
        {
          { type = "item", name = "engine-unit", amount = 2 },
          { type = "item", name = "advanced-circuit", amount = 12 },
          { type = "item", name = "bob-aluminium-plate", amount = 12 },
          --{ type = "item", name = "bob-nickel-plate", amount = 5 },
          { type = "item", name = "steel-plate", amount = 12 },
          { type = "item", name = "bob-cobalt-steel-bearing", amount = 10 },
        },
        results = { { type = "item", name = "mortar-turret-mn", amount = 1 } },
    },
    {
        type = "recipe",
        name = "basic-mortar-mn",
        energy_required = 10,
        enabled = false,
        ingredients = {
            {type = "item", name = "steel-plate", amount = 1},
            {type = "item", name = "bob-aluminium-plate", amount = 1},
            {type = "item", name = "explosives", amount = 3}
        },
        results = { { type = "item", name = "basic-mortar-mn", amount = 1 } },
    },

      {
        type = "technology",
        name = "mortar-turret-mn",
        icon = "__MilitaryNerfing__/graphics/technology/capsule-turrets.png",
        icon_size = 128,
        effects = {
          {
            type = "unlock-recipe",
            recipe = "basic-mortar-mn",
          },
          {
            type = "unlock-recipe",
            recipe = "mortar-turret-mn",
          },
          
        },
        prerequisites =
        {
          "military-3",
          "explosives",
          "engine",
        },
        unit = {
          count = 350,
          ingredients = {
            { "chemical-science-pack", 1 },
            { "automation-science-pack", 1 },
            { "military-science-pack", 1 },
            { "logistic-science-pack",   1 }
          },
          time = 30,
        }
      }
})
local function addEffectToTech(tech, recipe)
    t = data.raw["technology"][tech]
    if t then
        t.effects[#t.effects+1] = recipe
    end
end
addEffectToTech("stronger-explosives-2",
{
    type = "ammo-damage",
    ammo_category = "mortar-ammo-mn",
    modifier = 0.1
})

addEffectToTech("stronger-explosives-3",
{
    type = "ammo-damage",
    ammo_category = "mortar-ammo-mn",
    modifier = 0.3
})

addEffectToTech("stronger-explosives-4",
{
    type = "ammo-damage",
    ammo_category = "mortar-ammo-mn",
    modifier = 0.4
})

addEffectToTech("stronger-explosives-5",
{
    type = "ammo-damage",
    ammo_category = "mortar-ammo-mn",
    modifier = 0.5
})

addEffectToTech("stronger-explosives-6",
{
    type = "ammo-damage",
    ammo_category = "mortar-ammo-mn",
    modifier = 0.6
})
addEffectToTech("stronger-explosives-2",
{
    type = "turret-attack",
    turret_id = "mortar-turret-mn",
    modifier = 0.1
})

addEffectToTech("stronger-explosives-3",
{
    type = "turret-attack",
    turret_id = "mortar-turret-mn",
    modifier = 0.2
})

addEffectToTech("stronger-explosives-4",
{
    type = "turret-attack",
    turret_id = "mortar-turret-mn",
    modifier = 0.3
})

addEffectToTech("stronger-explosives-5",
{
    type = "turret-attack",
    turret_id = "mortar-turret-mn",
    modifier = 0.4
})

addEffectToTech("stronger-explosives-6",
{
    type = "turret-attack",
    turret_id = "mortar-turret-mn",
    modifier = 0.5
}) 



