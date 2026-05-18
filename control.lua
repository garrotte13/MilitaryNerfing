script.on_event(defines.events.on_resource_depleted, function(e)
    local entity = e.entity
	if entity.name == "crude-oil" then
        entity.surface.create_entity{name="mn-assisted-oil", position=entity.position, amount=entity.initial_amount}
        --[[local pumpjack = entity.surface.find_entities_filtered{type="mining-drill", area={{entity.position.x-1, entity.position.y-1}, {entity.position.x+1, entity.position.y+1}}}
		if #pumpjack >= 1 then
			pumpjack = pumpjack[1]
			local pumpjack2 = entity.surface.create_entity{name=pumpjack.name, position=pumpjack.position, direction=pumpjack.direction, force=pumpjack.force, fast_replace=true, spill=false}
			pumpjack.destroy()
		end]]
    end
end)
