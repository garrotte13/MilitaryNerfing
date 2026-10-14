require("__MilitaryNerfing__/prototypes/artillery-basics")

if mods["bobplates"] and mods["bobrevamp"] and (settings.startup["bobmods-revamp-oil"].value and settings.startup["bobmods-revamp-hardmode"].value) and not mods["angelspetrochem"] then
    require("__MilitaryNerfing__/prototypes/advanced-chemical")
    require("__MilitaryNerfing__/prototypes/sulfur_coke")
    require("__MilitaryNerfing__/prototypes/asphalt")    
end
if data.raw.recipe["kr-advanced-chemical-plant"] then
    require("__MilitaryNerfing__/prototypes/heavywater")
end
if mods["bobwarfare"] then
    require("__MilitaryNerfing__/prototypes/bobwdata")
    --require("__MilitaryNerfing__/prototypes/mortar")
end