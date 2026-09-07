script.on_event(defines.events.on_resource_depleted, function(e)
    local entity = e.entity
	if entity.name == "crude-oil" then
        entity.surface.create_entity{name="mn-assisted-oil", position=entity.position, amount=entity.initial_amount}
    end
end)
