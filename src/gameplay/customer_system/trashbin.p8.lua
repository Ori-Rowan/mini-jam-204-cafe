Trashbin = {}
setmetatable(Trashbin, GridItem)
Trashbin.__index = Trashbin


function Trashbin:new(t)
    local tbl = GridItem:new(t)

    setmetatable(tbl, self)
    
    assert(tbl.customer_system)
    
    tbl.customer = nil
    tbl.spr = 38

    return tbl
end

-- function Trashbin:update()

-- end

function Trashbin:draw()
   if _GLOBALS.light then
        spr(self.spr, self.draw_pos.x, self.draw_pos.y+8, 2, 1)    
    end 
end

function Trashbin:add_customer(customer)
    customer.Trashbin = self
    self.customer = customer
end

function Trashbin:del_customer()
    self.customer = nil
end

function Trashbin:interact()
    log("thowing out product")
    EventSystem:emit("product_served")
end
