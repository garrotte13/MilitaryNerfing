
require ("__base__.prototypes.entity.pipecovers")

--[[
local fluid_inputs = {}
for k,v in pairs(data.raw["mining-drill"]["electric-mining-drill"]) do
	if string.find(k, "input_fluid") then
		fluid_inputs[k] = util.table.deepcopy(v)
	end
end

local function is_in_box(position, entity)
	if not entity.collision_box then return true end
	--log(serpent.line(position) .." vs " .. entity.name .. ": " .. serpent.line(entity.collision_box))
	if (position[1] < entity.collision_box[1][1] or position[1] > entity.collision_box[2][1]) or
	(position[2] < entity.collision_box[1][2] or position[2] > entity.collision_box[2][2]) then
		return true
	end
	return false
end


for k,v in pairs(data.raw["mining-drill"]) do
	if not v.input_fluid_box and v.resource_categories[1] == "basic-fluid" then
		for n, p in pairs(fluid_inputs) do
			if p.pipe_connections and p.pipe_connections.position then
				if is_in_box(p.pipe_connections.position, v) then
					v[n] = util.table.deepcopy(p)
				end
			else
				if p.pipe_connections then
					for _, entry in pairs(p.pipe_connections) do
						if is_in_box(entry.position, v) then
							v[n] = util.table.deepcopy(p)
						end
					end
				end
			end
		end
	end
end
]]

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
--origin_o.minable.required_fluid = "bob-carbon-dioxide"
--origin_o.minable.fluid_amount = 10
origin_o.infinite = false
origin_o.minable.results[1].amount_min = 5
origin_o.minable.results[1].amount_max = 7
assisted_oil.autoplace = nil
assisted_oil.name = "mn-assisted-oil"
assisted_oil.minable.required_fluid = "bob-carbon-dioxide"
assisted_oil.minable.fluid_amount = 30
assisted_oil.minable.results[1].amount_min = 10
assisted_oil.minable.results[1].amount_max = 12

data:extend(
{
	assisted_oil
})

local original_expression = origin_o.autoplace.richness_expression
if type(original_expression) == "string" then
    origin_o.autoplace.richness_expression = "(" .. original_expression .. ") * 0.1"
else
	data.raw.resource["crude-oil"].autoplace.richness_expression = original_richness * 0.07
end