GridSystem = {}
GridSystem.__index = GridSystem

function GridSystem:new(t)
    t = t or {}
    local tbl = copy_table(t)

    setmetatable(tbl, self)

    tbl.pointer = tbl.pointer or 1
    tbl.sleep = tbl.sleep or false
    assert(tbl.items)

    return tbl
end

function GridSystem:update()
    foreach(self.items, function (i)
        if (type(i.update) == "function") i:update()
    end)
    if not self.sleep then 
        self:move_pointer()
        self:interact()
    end
end

function GridSystem:draw()
    foreach(self.items, function (e)
        e:draw()
    end)
    if (not self.sleep) self.items[self.pointer]:draw_pointer()
end

function GridSystem:move_pointer()
    local pos = copy_table(self.items[self.pointer].pos)
    local l_pos = copy_table(pos)

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

    if pos.x != l_pos.x or pos.y != l_pos.y then
        for k,v in pairs(self.items) do 
            if v.pos.x==pos.x and v.pos.y==pos.y then
                self.pointer=k 
                -- sfx(0)
            end
        end
    end
end

function GridSystem:interact()
    if btnp(5) then
        self.items[self.pointer]:interact()
        -- sfx(self.items[self.poinzter].sfx)
    end
end

function GridSystem:switch_sleep(sleep)
    self.sleep = sleep
end