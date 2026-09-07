
if mods["angelspetrochemgraphics"] then


    data.raw.item["bob-sodium-perchlorate"].icon = "__angelspetrochemgraphics__/graphics/icons/solid-sodium-perchlorate.png"
    data.raw.recipe["bob-sodium-perchlorate"].icon = "__angelspetrochemgraphics__/graphics/icons/solid-sodium-perchlorate.png"
    data.raw.item["bob-sodium-chlorate"].icon = "__angelspetrochemgraphics__/graphics/icons/solid-sodium-chlorate.png"
    data.raw.recipe["bob-sodium-chlorate"].icon = "__angelspetrochemgraphics__/graphics/icons/solid-sodium-chlorate.png"
    data.raw.item["bob-sodium-hydroxide"].icon = "__angelspetrochemgraphics__/graphics/icons/solid-sodium-hydroxide.png"
    data.raw.item["bob-sodium-hydroxide"].icon_size = 32
--    data.raw.item["coke"].icon = "__angelspetrochemgraphics__/graphics/icons/solid-coke.png"
 --   data.raw.item["coke"].icon_size = 32
end

if mods["bobplates"] and mods["bobrevamp"] and (settings.startup["bobmods-revamp-oil"].value and settings.startup["bobmods-revamp-hardmode"].value) and not mods["angelspetrochem"] then
    data.raw.recipe["basic-oil-processing"].icon = "__MilitaryNerfing__/graphics/icons/basic-processing.png"
    data.raw.recipe["basic-oil-processing"].icon_size = 32
    data.raw.recipe["advanced-oil-processing"].icon = "__MilitaryNerfing__/graphics/icons/advanced-processing.png"
    data.raw.recipe["advanced-oil-processing"].icon_size = 32

    data.raw.recipe["bob-oil-processing"].hidden = true
    data.raw.recipe["bob-carbon-dioxide-oil-processing"].hidden = true
    data.raw.recipe["bob-solid-fuel-from-sour-gas"].hidden = true
    data.raw.recipe["solid-fuel-from-heavy-oil"].hidden = true
    data.raw.recipe["bob-liquid-fuel"].hidden = true
    data.raw.fluid["bob-liquid-fuel"].icon = "__MilitaryNerfing__/graphics/icons/raw-fuel-oil.png"
    data.raw.fluid["bob-liquid-fuel"].icon_size = 32
    data.raw.recipe["bob-liquid-fuel"].icon = "__MilitaryNerfing__/graphics/icons/raw-fuel-oil.png"
    data.raw.recipe["bob-liquid-fuel"].icon_size = 32
end