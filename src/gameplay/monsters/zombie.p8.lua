Zombie = {}
setmetatable(Zombie, Customer)
Zombie.__index = Zombie

function Zombie:new()
    local tbl = copy_table(MONSTERS_ENUM.ZOMBIE)

    tbl = Customer:new(tbl)

    setmetatable(tbl, self)

    
    return tbl
end