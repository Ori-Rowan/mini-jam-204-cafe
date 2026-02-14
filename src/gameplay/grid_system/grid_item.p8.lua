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
        rectfill(x, y, x+8, y+8, self.color)
    end
end

function GridItem:draw_pointer()
    local x,y = self.draw_pos.x,self.draw_pos.y
    rect(x, y, x+8, y+8, 4)
end

function GridItem:interact()
    log("No interact function", "WARNING")
end