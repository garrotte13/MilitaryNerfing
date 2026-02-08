local woods = {}
--[[
    Select Grade first time
Count healthy trees in radius.
Count distances for each of nearby houses.
Calculate fine applied by each such house.
Decrease number of trees by the sum of fines (check to be not more than 100%).
Resulting number is the grade.

Change grade
When another GH is installed in GH radius
When tree is created
When tree is destroyed

Random tree generation
In a GH radius.
N > 0 and N < 200*1.5
How close is trees number to average: generate tree if RND(1, 5 * (math.ceil(abs(N-100)/5)+30)) == 1
Where to put the tree?
]]

local GH_radius = 30
local GH_grade_max = 200

local GH_names = {"bob-greenhouse","bob-greenhouse-carbo","bob-greenhouse-advanced"}
--replace with key-value table
local GH_recipe_prefixes = {"mn-basic-greenhouse-cycle-", "mn-carbo-greenhouse-cycle-", "mn-advanced-greenhouse-cycle-"}

local function GH_SetRecipe(house, grade)
    local name
    local progress_now = house.crafting_progress
    if house.name == GH_names[1] then
        name = GH_recipe_prefixes[1]
    elseif house.name == GH_names[2] then
        name = GH_recipe_prefixes[2]
    else
        name = GH_recipe_prefixes[3]
    end 
    house.set_recipe(name .. grade)
    house.crafting_progress = progress_now
    house.recipe_locked = true
end

local function find_houses(entity)
    if not storage.mn_chunks then
        return
    end
    local zminX = math.floor( (entity.position.x - GH_radius) / 32)
    local zmaxX = math.floor( (entity.position.x + GH_radius) / 32)
    local zminY = math.floor( (entity.position.y - GH_radius) / 32)
    local zmaxY = math.floor( (entity.position.y + GH_radius) / 32)
    local found_chunks
    for zx = zminX, zmaxX do
        for zy = zminY, zmaxY do
            if storage.mn_chunks[zx.. ":".. zy] then
                found_chunks = true
                break
            end
        end
    end
    if not found_chunks then return end

    local found = entity.surface.find_entities_filtered{position = entity.position, radius = GH_radius - 1.28, name = GH_names}
    --local found = entity.surface.find_entities_filtered{position = entity.position, radius = GH_radius - 1.28, name = "bob-greenhouse"}
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

local function DnGradeOverlappingHouse(entity, d)
    local houses = storage.mn_gh
    local r = entity.unit_number
    houses[r].fine = houses[r].fine + d
    houses[r].grade = math.min(200, math.floor( houses[r].trees * ( 1 - math.min(1, houses[r].fine) ) ) )
    GH_SetRecipe(entity, houses[r].grade)
end

function woods.GHadded(entity, t)
    local pos = entity.position
    local r = entity.unit_number
    if not storage.mn_gh then
        storage.mn_gh = {}
    end
    local houses = storage.mn_gh
    local houses_near = find_houses(entity)

    local trees_number = entity.surface.count_entities_filtered{position = pos, radius = GH_radius-0.48, type = "tree"}
    local fine = 0
    if houses_near then
        local d
        for i = 1,#houses_near do
            d = (1 - ( math.sqrt((pos.x - houses_near[i].position.x)^2 + (pos.y - houses_near[i].position.y)^2)) / GH_radius ) ^ (1/3)
            DnGradeOverlappingHouse(houses_near[i], d)
            fine = fine + d
        end
    end
    houses[r] = {
        grade = math.min(200, math.floor( trees_number * ( 1 - math.min(1, fine) ) ) ),
        fine = fine,
        trees = trees_number,
        pos = pos
    }
    GH_SetRecipe(entity, houses[r].grade)
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
    local chunk_x = math.floor(pos.x/32)
    local chunk_y = math.floor(pos.y/32)
    storage.mn_chunks[chunk_x.. ":".. chunk_y] = storage.mn_chunks[chunk_x.. ":".. chunk_y] - 1
    if storage.mn_chunks[chunk_x.. ":".. chunk_y] < 1 then
        storage.mn_chunks[chunk_x.. ":".. chunk_y] = nil
    end    
    local houses_near = find_houses(entity)
    if houses_near then
        local d
        for i = 1,#houses_near do
            d = (1 - ( math.sqrt((pos.x - houses_near[i].position.x)^2 + (pos.y - houses_near[i].position.y)^2)) / GH_radius ) ^ (1/3)
            DnGradeOverlappingHouse(houses_near[i], -d)
        end
    end
    storage.mn_gh[r] = nil
end

function woods.TreeAdded(entity, t)
    if not storage.mn_gh then return end
    local houses_near = find_houses(entity)
    if houses_near then
        local houses = storage.mn_gh
        local h
        for i = 1,#houses_near do
            h = houses_near[i].unit_number
            houses[h].trees = houses[h].trees + 1
            if houses[h].grade < 200 then
                houses[h].grade = math.min(200, math.floor( houses[h].trees * ( 1 - math.min(1, houses[h].fine) ) ) )
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
            houses[h].trees = houses[h].trees - 1
            if houses[h].grade > 0 then
                houses[h].grade = math.min(200, math.floor( houses[h].trees * ( 1 - math.min(1, houses[h].fine) ) ) )
                GH_SetRecipe(houses_near[i], houses[h].grade)
            end
        end
    end
end

return woods