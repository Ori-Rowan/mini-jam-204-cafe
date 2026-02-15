Skeleton = {}
setmetatable(Skeleton, Customer)
Skeleton.__index = Skeleton

function Skeleton:new()
    local tbl = copy_table(MONSTERS_ENUM.SKELETON)

    tbl = Customer:new(tbl)

    setmetatable(tbl, self)
    
    return tbl
end