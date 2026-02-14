Warewolf = {}
setmetatable(Warewolf, Customer)
Warewolf.__index = Warewolf

function Warewolf:new(t)
    t = t or {}
    local tbl = copy_table(t)

    tbl.fav_recipie = MONSTERS_ENUM.WAREWOLF.fav_recipie.name

    tbl = Customer:new(tbl)
    
    return tbl
end