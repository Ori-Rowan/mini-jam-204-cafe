Doppleganger = {}
setmetatable(Doppleganger, Customer)
Doppleganger.__index = Doppleganger

function Doppleganger:new(t)
    t = t or {}
    local tbl = copy_table(t)

    tbl.fav_recipie = MONSTERS_ENUM.DOPPLEGANGER.fav_recipie.name

    tbl = Customer:new(tbl)
    
    return tbl
end