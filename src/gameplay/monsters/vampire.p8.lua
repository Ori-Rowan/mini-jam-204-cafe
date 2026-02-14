Vampire = {}
setmetatable(Vampire, Customer)
Vampire.__index = Vampire

function Vampire:new(t)
    t = t or {}
    local tbl = copy_table(t)

    tbl.fav_recipie = MONSTERS_ENUM.VAMPIRE.fav_recipie.name

    tbl = Customer:new(tbl)
    
    return tbl
end