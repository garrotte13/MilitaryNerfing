local constants = {}
-- CONSTANTS

constants.GH_radius = 20
constants.GH_names = {"bob-greenhouse","bob-greenhouse-carbo","bob-greenhouse-advanced"}
constants.GH_recipe_prefixes = {
    ["bob-greenhouse"] = "mn-basic-greenhouse-cycle-",
    ["bob-greenhouse-carbo"] = "mn-carbo-greenhouse-cycle-",
    ["bob-greenhouse-advanced"] = "mn-advanced-greenhouse-cycle-"
}

constants.GH_max_grades = {
    ["bob-greenhouse"] = 60,
    ["bob-greenhouse-carbo"] = 90,
    ["bob-greenhouse-advanced"] = 120
}


return constants