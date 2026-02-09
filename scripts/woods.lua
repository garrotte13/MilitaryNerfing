local woods = {}
--[[

Random tree generation
In a GH radius.
Conditions:
- grade > 0 and total_trees < maxgrade*1.5
- time check for house.products_finished to pass milestone value, for example, every 7
How close is trees number to average: generate tree if RND(1, 1 * (math.ceil(abs(grade-maxgrade*0.5)/5)+maxgrade*0.05)) == 1
Where to put the tree?
]]
local MNconst = require("scripts.constants")


local function GH_SetRecipe(house, grade)
    local progress_now = house.crafting_progress or 0
    if grade == 0 then
        house.set_recipe(nil)
        house.recipe_locked = true
        return progress_now
    else
        house.set_recipe(MNconst.GH_recipe_prefixes[house.name] .. grade)
        house.crafting_progress = progress_now
        house.recipe_locked = true
    end
end

local function find_houses(entity, dbl)
    if not storage.mn_chunks then
        return
    end
    local s_radius = dbl and 2*MNconst.GH_radius or MNconst.GH_radius
    local zminX = math.floor( (entity.position.x - s_radius) / 32)
    local zmaxX = math.floor( (entity.position.x + s_radius) / 32)
    local zminY = math.floor( (entity.position.y - s_radius) / 32)
    local zmaxY = math.floor( (entity.position.y + s_radius) / 32)
    local found_chunks
    for zx = zminX, zmaxX do
        for zy = zminY, zmaxY do
            if storage.mn_chunks[zx.. ":".. zy] then
                found_chunks = true
                break
            end
            if found_chunks then break end
        end
    end
    if not found_chunks then return end

    local found = entity.surface.find_entities_filtered{position = entity.position, radius = s_radius - 1.28, name = MNconst.GH_names}
    local f_houses = {}
    if found and found[1] then
        for i = 1,#found do
            if found[i] ~= entity then
                table.insert(f_houses, found[i])
            end
        end
    end
    if f_houses[1] then return f_houses end
end

function woods.GHadded(entity, t)
    local pos = entity.position
    local r = entity.unit_number
    local maxgrade = MNconst.GH_max_grades[entity.name] 
    if not storage.mn_gh then
        storage.mn_gh = {}
    end
    local houses = storage.mn_gh
    local houses_near
    local trees_found = entity.surface.find_entities_filtered{position = pos, radius = MNconst.GH_radius-0.38, type = "tree", limit = maxgrade*2}
    local trees_list = {}
    local trees_number = 0
    if trees_found and trees_found[1] then
        houses_near = find_houses(entity, true)
        for i=1,#trees_found do
            local tree_is_busy
            if not ( string.find(trees_found[i].name, "dead") or string.find(trees_found[i].name, "dry") ) then
                local tree_pos = trees_found[i].position.x .. ":" .. trees_found[i].position.y
                if houses_near then
                    for y=1,#houses_near do
                        if houses[houses_near[y].unit_number].tr_list[tree_pos] then
                            tree_is_busy = true
                            break
                        end
                    end
                    if not tree_is_busy then
                        trees_list[tree_pos] = trees_found[i]
                        trees_number = trees_number + 1
                    end
                else
                    trees_list[tree_pos] = trees_found[i]
                    trees_number = trees_number + 1
                end
            end
            if trees_number == maxgrade then
                break
            end
        end
    end

    houses[r] = {
        --grade = math.min(200, trees_number),
        grade = trees_number,
        trees_total = 0,
        pos = pos,
        tr_list = trees_list
    }
    if trees_found then houses[r].trees_total = #trees_found end
    GH_SetRecipe(entity, trees_number)
    game.print("GH installed. Engaged trees: ".. trees_number.. " Total trees: ".. houses[r].trees_total )
    local chunk_x = math.floor(pos.x/32)
    local chunk_y = math.floor(pos.y/32)
    if not storage.mn_chunks then
        storage.mn_chunks = {}
    end
    if storage.mn_chunks[chunk_x.. ":".. chunk_y] then
        storage.mn_chunks[chunk_x.. ":".. chunk_y] = storage.mn_chunks[chunk_x.. ":".. chunk_y] + 1
    else
        storage.mn_chunks[chunk_x.. ":".. chunk_y] = 1
    end
end

function woods.GHremoved(entity, t)
    local r = entity.unit_number
    local pos = entity.position
    local houses = storage.mn_gh
    local chunk_x = math.floor(pos.x/32)
    local chunk_y = math.floor(pos.y/32)
    storage.mn_chunks[chunk_x.. ":".. chunk_y] = storage.mn_chunks[chunk_x.. ":".. chunk_y] - 1
    if storage.mn_chunks[chunk_x.. ":".. chunk_y] < 1 then
        storage.mn_chunks[chunk_x.. ":".. chunk_y] = nil
    end
    if houses[r].grade > 0 then
        local trees_found = {}
        for _, t in pairs(houses[r].tr_list) do
            table.insert(trees_found, t)
        end
        houses[r].tr_list = nil
        local houses_near = find_houses(entity, true)
        if houses_near then
            local ds = MNconst.GH_radius^2
            for y = 1,#trees_found do
                for i = 1,#houses_near do
                    local h = houses_near[i].unit_number
                    if houses[h].grade < MNconst.GH_max_grades[houses_near[i].name] and ((houses[h].pos.x - trees_found[y].position.x)^2 + (houses[h].pos.y - trees_found[y].position.y)^2) <= ds then
                        houses[h].tr_list[trees_found[y].position.x.. ":".. trees_found[y].position.y] = trees_found[y]
                        houses[h].grade = houses[h].grade + 1
                        break
                    end
                end
            end
            for i = 1,#houses_near do
                GH_SetRecipe(houses_near[i], houses[houses_near[i].unit_number].grade)
            end

        end
    end
    houses[r] = nil
end

function woods.TreeAdded(entity, t)
    if not storage.mn_gh then return end
    local houses_near = find_houses(entity)
    if houses_near then
        local houses = storage.mn_gh
        local h
        local tree_is_free = not ( string.find(entity.name, "dead") or string.find(entity.name, "dry") )
        for i = 1,#houses_near do
            h = houses_near[i].unit_number
            houses[h].trees_total = houses[h].trees_total + 1
            if tree_is_free and houses[h].grade < MNconst.GH_max_grades[houses_near[i].name] then
                houses[h].grade = houses[h].grade + 1
                tree_is_free = false
                houses[h].tr_list[entity.position.x .. ":" .. entity.position.y] = entity
                GH_SetRecipe(houses_near[i], houses[h].grade)
            end
        end
    end
end

function woods.TreeRemoved(entity, t)
    if not storage.mn_gh then return end
    local houses_near = find_houses(entity)
    if houses_near then
        local houses = storage.mn_gh
        local h
        for i = 1,#houses_near do
            h = houses_near[i].unit_number
            houses[h].trees_total = houses[h].trees_total - 1
            if houses[h].grade > 0 and houses[h].tr_list[entity.position.x .. ":" .. entity.position.y]  then
                houses[h].tr_list[entity.position.x .. ":" .. entity.position.y] = nil
                houses[h].grade = houses[h].grade - 1
                GH_SetRecipe(houses_near[i], houses[h].grade)
            end
        end
    end
end

return woods