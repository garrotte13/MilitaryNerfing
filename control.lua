local woods = require("__MilitaryNerfing__/scripts/woods")

--[[

]]

local function v_in_table(v, t)
    for i = 1, #t do
        if t[i] == v then return true end
    end
end

-- CONSTANTS
local GH_radius = 30
local GH_grade_max = 200
local GH_names = {"bob-greenhouse","bob-greenhouse-carbo","bob-greenhouse-advanced"}

local function smth_built(e)
    if e.entity and e.entity.valid then
        if v_in_table(e.entity.name, GH_names) then
            woods.GHadded(e.entity, e.tick)
        elseif e.entity.type == "tree" then
            woods.TreeAdded(e.entity, e.tick)
        end
    end
end

local function smth_destroyed(e)
    if e.entity then
        if v_in_table(e.entity.name, GH_names) then
            woods.GHremoved(e.entity, e.tick)
        elseif e.entity.type == "tree" then
            woods.TreeRemoved(e.entity, e.tick)
        end
    end
end


script.on_init(function()
    storage.mn_gh = {}
end)

script.on_event({
	defines.events.on_built_entity,
	defines.events.on_robot_built_entity,
	defines.events.script_raised_built,
	defines.events.script_raised_revive,
	defines.events.on_entity_cloned,
}, smth_built)

script.on_event({
	defines.events.on_player_mined_entity,
	defines.events.on_robot_mined_entity,
    defines.events.on_entity_died,
	defines.events.script_raised_destroy,
}, smth_destroyed)

