-- CONSTANTS in prototype phase
local GH_radius = 20
local GH_names = {"bob-greenhouse","bob-greenhouse-carbo","bob-greenhouse-advanced"}
local GH_recipe_prefixes = {
    ["bob-greenhouse"] = "mn-basic-greenhouse-cycle-",
    ["bob-greenhouse-carbo"] = "mn-carbo-greenhouse-cycle-",
    ["bob-greenhouse-advanced"] = "mn-advanced-greenhouse-cycle-"
}

local GH_max_grades = {
    ["bob-greenhouse"] = 60,
    ["bob-greenhouse-carbo"] = 90,
    ["bob-greenhouse-advanced"] = 120
}

local function myround(x)
    return math.floor(x+0.5)
end

local function get_wood_recipe(minTop, maxTop, seedTop, timeTop, gradeTop, grade)
    local min_from_grade = myround( grade / (gradeTop/minTop) )
    local max_from_grade = math.min(maxTop, min_from_grade + math.ceil( grade / (gradeTop / (1.5*minTop) ) ) )
    local seed_prob = (grade/gradeTop) * seedTop
    local time_from_grade = timeTop + myround( (1 - grade/gradeTop) * ( timeTop / 3 ) )
    return min_from_grade, max_from_grade, seed_prob, time_from_grade
end

data.raw.recipe["bob-seedling"].hidden = true
data.raw.recipe["bob-advanced-greenhouse-cycle"].hidden = true
data.raw.recipe["bob-basic-greenhouse-cycle"].hidden = true

data:extend({
    {
        type = "recipe-category",
        name = "mn-wood-spam-tier1"
    },
    {
        type = "recipe-category",
        name = "mn-wood-spam-tier2"
    },
    {
        type = "recipe-category",
        name = "mn-wood-spam-tier3"
    }     
})
local min_r
local max_r
local seed_prob
local time_req

for i = 1, GH_max_grades["bob-greenhouse"] do
    min_r, max_r, seed_prob, time_req = get_wood_recipe(10, 20, 0.4, 60, GH_max_grades["bob-greenhouse"], i)
    data:extend({
        {
            type = "recipe",
            name = "mn-basic-greenhouse-cycle-" .. i,
            category = "mn-wood-spam-tier1",
            enabled = true,
            hidden = true,
            ingredients = {
                { type = "fluid", name = "water", amount = 75 }
            },
            results = {
                { type = "item", name = "wood", amount_min = min_r, amount_max = max_r },
                { type = "item", name = "bob-seedling", amount = 1, probability = seed_prob}
            },
            allow_decomposition = false,
            energy_required = time_req,
            always_show_products = true,
            --show_amount_in_title = false,
            emissions_multiplier = 0.5,
            localised_name = {"item-name.wood"},
            main_product = "wood"
        }
    })
end
for i = 1, GH_max_grades["bob-greenhouse-carbo"] do
    min_r, max_r, seed_prob, time_req = get_wood_recipe(15, 35, 0.6, 60, GH_max_grades["bob-greenhouse-carbo"], i)
    data:extend({
        {
            type = "recipe",
            name = "mn-carbo-greenhouse-cycle-" .. i,
            category = "mn-wood-spam-tier2",
            enabled = true,
            hidden = true,
            ingredients = {
                { type = "fluid", name = "water", amount = 75 },
                { type = "fluid", name = "bob-carbon-dioxide", amount = 10 }
            },
            results = {
                { type = "item", name = "wood", amount_min = min_r, amount_max = max_r },
                { type = "item", name = "bob-seedling", amount = 1, probability = seed_prob}
            },
            allow_decomposition = false,
            energy_required = time_req,
            always_show_products = true,
            --show_amount_in_title = false,
            emissions_multiplier = 0.1,
            localised_name = {"item-name.wood"},
            main_product = "wood"
        }
    })
end
for i = 1, GH_max_grades["bob-greenhouse-advanced"] do
    min_r, max_r, seed_prob, time_req = get_wood_recipe(20, 40, 0.9, 45, GH_max_grades["bob-greenhouse-advanced"], i)
    data:extend({
        {
            type = "recipe",
            name = "mn-advanced-greenhouse-cycle-" .. i,
            category = "mn-wood-spam-tier3",
            enabled = true,
            hidden = true,
            ingredients = {
                { type = "fluid", name = "water", amount = 75 },
                { type = "fluid", name = "bob-carbon-dioxide", amount = 10 },
                { type = "item", name = "bob-fertiliser", amount = 5 },
            },
            results = {
                { type = "item", name = "wood", amount_min = min_r, amount_max = max_r },
                { type = "item", name = "bob-seedling", amount = 1, probability = seed_prob}
            },
            allow_decomposition = false,
            energy_required = time_req,
            always_show_products = true,
            --show_amount_in_title = false,
            emissions_multiplier = 0.2,
            localised_name = {"item-name.wood"},
            main_product = "wood"
        }
    })

end

local i_gh_carbo = table.deepcopy(data.raw.item["bob-greenhouse"])
i_gh_carbo.name = "bob-greenhouse-carbo"
i_gh_carbo.place_result = "bob-greenhouse-carbo"
i_gh_carbo.order = "g[greenhouse]b"

local i_gh_adv = table.deepcopy(i_gh_carbo)
i_gh_adv.name = "bob-greenhouse-advanced"
i_gh_adv.place_result = "bob-greenhouse-advanced"
i_gh_adv.order = "g[greenhouse]c"

local c_gh_carbo = {
    type = "recipe",
    name = "bob-greenhouse-carbo",
    energy_required = 10,
    enabled = false,
    ingredients = {
      { type = "item", name = "bob-greenhouse", amount = 1 },
      { type = "item", name = "electronic-circuit", amount = 4 },
      mods["boblogistics"] and { type = "item", name = "bob-copper-pipe", amount = 5 } or { type = "item", name = "pipe", amount = 5 },
    },
    results = { { type = "item", name = "bob-greenhouse-carbo", amount = 1 } },
}
local c_gh_adv = {
    type = "recipe",
    name = "bob-greenhouse-advanced",
    energy_required = 10,
    enabled = false,
    ingredients = {
      { type = "item", name = "bob-greenhouse-carbo", amount = 1 },
      { type = "item", name = "advanced-circuit", amount = 3 },
      mods["bobplates"] and { type = "item", name = "bob-steel-gear-wheel", amount = 3 } or { type = "item", name = "steel-plate", amount = 5 },
    },
    results = { { type = "item", name = "bob-greenhouse-advanced", amount = 1 } },
}

table.insert(data.raw.technology["bob-fertiliser"].effects,
{
    type = "unlock-recipe",
    recipe = "bob-greenhouse-carbo"
})
table.insert(data.raw.technology["bob-fertiliser"].effects,
{
    type = "unlock-recipe",
    recipe = "bob-greenhouse-advanced"
})

local r = data.raw["assembling-machine"]["bob-greenhouse"]
r.crafting_categories = {"mn-wood-spam-tier1"}
r.allow_copy_paste = false
r.next_upgrade = "bob-greenhouse-carbo"

local gh_carbo = table.deepcopy(r)
gh_carbo.name = "bob-greenhouse-carbo"
gh_carbo.next_upgrade = "bob-greenhouse-advanced"
gh_carbo.minable.result = "bob-greenhouse-carbo"
gh_carbo.crafting_categories = {"mn-wood-spam-tier2"}
table.insert(gh_carbo.fluid_boxes, {
    production_type = "input",
    pipe_picture = {
      north = {
        filename = "__bobgreenhouse__/graphics/entity/greenhouse-pipe-N.png",
        priority = "extra-high",
        width = 71,
        height = 46,
        shift = util.by_pixel(2.25, 17),
        scale = 0.5,
      },
      east = {
        filename = "__base__/graphics/entity/assembling-machine-3/assembling-machine-3-pipe-E.png",
        priority = "extra-high",
        width = 42,
        height = 76,
        shift = util.by_pixel(-24.5, 1),
        scale = 0.5,
      },
      south = {
        filename = "__base__/graphics/entity/assembling-machine-3/assembling-machine-3-pipe-S.png",
        priority = "extra-high",
        width = 88,
        height = 61,
        shift = util.by_pixel(0, -31.25),
        scale = 0.5,
      },
      west = {
        filename = "__bobgreenhouse__/graphics/entity/greenhouse-pipe-W.png",
        priority = "extra-high",
        width = 39,
        height = 73,
        shift = util.by_pixel(25.75, 1.25),
        scale = 0.5,
      },
    },
    pipe_covers = pipecoverspictures(),
    volume = 1000,
    height = 2,
    base_level = -2,
    pipe_connections = { { flow_direction = "input", position = { -1, 0 }, direction = defines.direction.west } },
   -- secondary_draw_orders = { west = -1,0 },
})
if feature_flags["freezing"] and mods["space-age"] then
    gh_carbo.fluid_boxes[2].pipe_picture_frozen = data.raw["assembling-machine"]["assembling-machine-2"].fluid_boxes[1].pipe_picture_frozen
    gh_carbo.fluid_boxes[2].pipe_covers_frozen = data.raw["assembling-machine"]["assembling-machine-2"].fluid_boxes[1].pipe_covers_frozen
end

local gh_adv = table.deepcopy(gh_carbo)
gh_adv.name = "bob-greenhouse-advanced"
gh_adv.crafting_categories = {"mn-wood-spam-tier3"}
gh_adv.minable.result = "bob-greenhouse-advanced"
gh_adv.next_upgrade = nil

data:extend({i_gh_carbo, i_gh_adv, gh_carbo, gh_adv, c_gh_carbo, c_gh_adv})