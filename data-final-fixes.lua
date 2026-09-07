require("__MilitaryNerfing__/prototypes/fix-graphics")

-- Create a list of furnace names we want to clean up after copying
local furnaces_to_remove = {}

for furnace_name, furnace_prototype in pairs(data.raw["furnace"]) do
    
    -- CONDITION: Only process furnaces whose name starts with "bob-distillery"
    if string.find(furnace_name, "^bob%-distillery") then
        
        -- 1. Deep clone the furnace prototype to preserve all graphics/sounds
        local new_assembler = table.deepcopy(furnace_prototype)
        
        -- 2. Change the internal prototype type
        new_assembler.type = "assembling-machine"
        
        -- 3. Add MANDATORY properties required by Assembling Machines but missing in Furnaces
        new_assembler.crafting_categories = furnace_prototype.crafting_categories or { "smelting" }
        
        -- Assembling machines require a defined source inventory size for ingredients
        new_assembler.ingredient_count = new_assembler.ingredient_count or 4 
        
        -- Expand the result inventory size to support multiple output items
        new_assembler.result_inventory_size = 2 
        
        -- 4. Set optional visual cleanups (Hides the recipe selection circle over it)
        new_assembler.show_recipe_icon = false
        
        -- 5. Inject the newly converted entity into the assembling-machine table
        data.raw["assembling-machine"][furnace_name] = new_assembler
        
        -- Queue the old furnace name for deletion
        table.insert(furnaces_to_remove, furnace_name)
    end
end

-- 6. Clean up data.raw so the game engine doesn't process them as furnaces anymore
for _, furnace_name in ipairs(furnaces_to_remove) do
    data.raw["furnace"][furnace_name] = nil
end