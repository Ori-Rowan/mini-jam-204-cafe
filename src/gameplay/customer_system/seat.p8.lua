Seat = {}
setmetatable(Seat, GridItem)
Seat.__index = Seat


function Seat:new(t)
    local tbl = GridItem:new(t)

    tbl.customer = nil

    assert(tbl.customer_system)

    tbl.spr = 54
    setmetatable(tbl, self)

    return tbl
end

function Seat:update()
    if self.customer then
        self.customer:update()
    end
end

function Seat:draw()
    if _GLOBALS.light then
        spr(self.spr, self.draw_pos.x, self.draw_pos.y+8, 2, 1)    
    end
    
    if self.customer then
        self.customer:draw()
    end
end

function Seat:add_customer(customer)
    customer.seat = self
    self.customer = customer
end


function Seat:del_customer()
    self.customer = nil
end

function Seat:interact()
    if self.customer == nil then
        log("seat empty")
        return
    end

    self.customer:serve(self.customer_system.product)
end
