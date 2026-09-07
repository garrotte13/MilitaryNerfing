
require ("__base__.prototypes.entity.pipecovers")

for k,v in pairs(data.raw["mining-drill"]) do
	if not v.input_fluid_box and v.resource_categories[1] == "basic-fluid" then
		v.input_fluid_box =
		{
		  pipe_covers = pipecoverspictures(),
		  volume = 200,
		  pipe_connections =
		  {
			{ direction = defines.direction.west, position = {-1, 0}},
			{ direction = defines.direction.east, position = {1, 0}},
			{ direction = defines.direction.south, position = {0, 1}}
		  }
		}
	end
end

local origin_o = data.raw.resource["crude-oil"]
local assisted_oil = util.table.deepcopy(origin_o)

origin_o.minable.mining_time = 0.8
origin_o.infinite = false
origin_o.minable.results[1].amount_min = 7
origin_o.minable.results[1].amount_max = 9
assisted_oil.autoplace = nil
assisted_oil.name = "mn-assisted-oil"
--assisted_oil.minimum = 80000
assisted_oil.minable.required_fluid = "bob-carbon-dioxide"
assisted_oil.minable.fluid_amount = 15
assisted_oil.minable.mining_time = 1.5
assisted_oil.minable.results[1].amount_min = 15
assisted_oil.minable.results[1].amount_max = 20

data:extend(
{
	assisted_oil
})

local original_expression = origin_o.autoplace.richness_expression
if type(original_expression) == "string" then
    origin_o.autoplace.richness_expression = "(" .. original_expression .. ") * 0.1"
else
	data.raw.resource["crude-oil"].autoplace.richness_expression = original_richness * 0.1
end