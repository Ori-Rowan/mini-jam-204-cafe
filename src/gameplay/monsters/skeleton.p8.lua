Skeleton = {}
setmetatable(Skeleton, Customer)
Skeleton.__index = Skeleton

function Skeleton:new(t)
    t = t or {}
    local tbl = copy_table(t)

    tbl.fav_recipie = MONSTERS_ENUM.SKELETON.fav_recipie.name

    tbl = Customer:new(tbl)
    
    return tbl
end