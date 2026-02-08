local function myround(x)
    return math.floor(x+0.5)
end
local function get_basic_recipe(grade) -- 10..20 max
    --local grade = math.min(200, grade)
    local min_from_grade = myround(grade/20)
    local max_from_grade = math.min(20, ( min_from_grade + math.ceil(grade/13.4) ))
    local seed_prob = grade/400
    return min_from_grade, max_from_grade, seed_prob
end
local function get_carbo_recipe(grade) -- 15..35 max
    --local grade = math.min(200, grade)
    local min_from_grade = myround(grade/13.4)
    local max_from_grade = math.min(35, ( min_from_grade + math.ceil(grade/6.8) ))
    local seed_prob = grade/300
    return min_from_grade, max_from_grade, seed_prob
end
local function get_fertilizer_recipe(grade) -- 20..40 max
    --local grade = math.min(200, grade)
    local min_from_grade = myround(grade/10)
    local max_from_grade = math.min(40, ( min_from_grade + math.ceil(grade/6.8) ))
    local seed_prob = grade/200
    return min_from_grade, max_from_grade, seed_prob
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

for i = 1, 200 do
    min_r, max_r, seed_prob = get_basic_recipe(i)
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
            energy_required = 45,
            always_show_products = true,
            --show_amount_in_title = false,
            emissions_multiplier = 2,
            localised_name = {"item-name.wood"},
            main_product = "wood"
        }
    })
    min_r, max_r, seed_prob = get_carbo_recipe(i)
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
            energy_required = 45,
            always_show_products = true,
            --show_amount_in_title = false,
            emissions_multiplier = 1,
            localised_name = {"item-name.wood"},
            main_product = "wood"
        }
    })
    min_r, max_r, seed_prob = get_fertilizer_recipe(i)
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
            energy_required = 45,
            always_show_products = true,
            --show_amount_in_title = false,
            emissions_multiplier = 1.5,
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