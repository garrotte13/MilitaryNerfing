if mods["bobplates"] and mods["bobrevamp"] and (settings.startup["bobmods-revamp-oil"].value and settings.startup["bobmods-revamp-hardmode"].value) and not mods["angelspetrochem"] then
    require("__MilitaryNerfing__/prototypes/advanced-chemical")
    require("__MilitaryNerfing__/prototypes/sulfur_coke")
    require("__MilitaryNerfing__/prototypes/asphalt")
end