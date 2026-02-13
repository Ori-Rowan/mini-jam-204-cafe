GridSystem = {}
GridSystem.__index = GridSystem

function GridSystem:new(t)
    t = t or {}
    local tbl = copy_table(t)

    setmetatable(tbl, self)

    tbl.pointer = tbl.pointer or 1
    assert(tbl.items)

    return tbl
end

function GridSystem:update()
    self:move_pointer()
    self:interact()
    foreach(self.items, function (i)
        if (type(i.update) == "function") i:update()
    end)
end

function GridSystem:draw()
    foreach(self.items, function (e)
        e:draw()
    end)
    self.items[self.pointer]:draw_pointer()
end

function GridSystem:move_pointer()
    local pos = copy_table(self.items[self.pointer].pos)

    if btnp(0) then
        pos.x-=1
    end
    if btnp(1) then
        pos.x+=1
    end
    if btnp(2) then
        pos.y-=1
    end
    if btnp(3) then
        pos.y+=1
    end

    for k,v in pairs(self.items) do 
        if (v.pos.x==pos.x and v.pos.y==pos.y) self.pointer=k 
    end
end

function GridSystem:interact()
    if btnp(5) then
        self.items[self.pointer]:interact()
    end
end