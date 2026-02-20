require("__MilitaryNerfing__/prototypes/updates-economics")
if mods["bobgreenhouse"] and settings.startup["mn-NewGreenhouse"].value then
    require("__MilitaryNerfing__/prototypes/newgreenhouse")
    require("__MilitaryNerfing__/prototypes/saplings")
end
require("__MilitaryNerfing__/prototypes/updates-military")

data.raw["gun"]["bob-tank-artillery-1"].attack_parameters.movement_slow_down_factor = 0.3
data.raw["gun"]["bob-tank-artillery-1"].attack_parameters.movement_slow_down_cooldown = 170
data.raw["gun"]["bob-tank-artillery-2"].attack_parameters.movement_slow_down_factor = 0.3
data.raw["gun"]["bob-tank-artillery-2"].attack_parameters.movement_slow_down_cooldown = 170