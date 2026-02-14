Ghost = {}
setmetatable(Ghost, Customer)
Ghost.__index = Ghost

function Ghost:new(t)
    t = t or {}
    local tbl = copy_table(t)

    tbl.fav_recipie = MONSTERS_ENUM.GHOST.fav_recipie.name

    tbl = Customer:new(tbl)
    
    return tbl
end