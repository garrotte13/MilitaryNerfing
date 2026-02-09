local woods = require("__MilitaryNerfing__/scripts/woods")
local circle_rendering = require("scripts.gh_rendering")
local MN_const = require("scripts.constants")

--[[

]]

local function v_in_table(v, t)
    for i = 1, #t do
        if t[i] == v then return true end
    end
end


local function smth_built(e)
    if e.entity and e.entity.valid then
        if v_in_table(e.entity.name, MN_const.GH_names) then
            circle_rendering.add_circle(e.entity, game.players[e.player_index])
            woods.GHadded(e.entity, e.tick)
        elseif e.entity.type == "tree" then
            woods.TreeAdded(e.entity, e.tick)
        elseif e.entity.name == "entity-ghost" and v_in_table(e.entity.ghost_name , MN_const.GH_names) then
            circle_rendering.add_circle(e.entity, game.players[e.player_index])
        end
    end
end

local function smth_destroyed(e)
    if e.entity then
        if v_in_table(e.entity.name, MN_const.GH_names) then
            circle_rendering.remove_circle(e.entity)
            woods.GHremoved(e.entity, e.tick)
        elseif e.entity.type == "tree" then
            woods.TreeRemoved(e.entity, e.tick)
        elseif e.entity.name == "entity-ghost" and v_in_table(e.entity.ghost_name, MN_const.GH_names) then
            circle_rendering.remove_circle(e.entity)
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


-- Pure rendering events
script.on_event(defines.events.on_selected_entity_changed, function(e)
    circle_rendering.selection_changed(game.players[e.player_index])
end)

 script.on_event(defines.events.on_player_cursor_stack_changed, function(e)
    circle_rendering.cursor_changed(game.players[e.player_index])
end)
