GridItem = {}
GridItem.__index = GridItem

function GridItem:new(t)
    t = t or {}
    local tbl = copy_table(t)

    setmetatable(tbl, self)

    
    assert(tbl.pos)
    assert(tbl.draw_pos)

    tbl.color = tbl.color or 7
    
    return tbl
end

function GridItem:draw()
    if _GLOBALS.light then
        local x,y = self.draw_pos.x,self.draw_pos.y

        if self.spr then
            spr(self.spr, x, y, 2, 2)
        else
            rectfill(x, y, x+8, y+8, self.color)
        end

    end
end

function GridItem:draw_pointer()
    local mid = {x = self.draw_pos.x-2, y = self.draw_pos.y+8}
    line(mid.x, mid.y, mid.x-2, mid.y-2, 11)
    line(mid.x, mid.y, mid.x-2, mid.y+2, 11)

end

function GridItem:interact()
    log("No interact function", "WARNING")
end