Seat = {}
setmetatable(Seat, GridItem)
Seat.__index = Seat


function Seat:new(t)
    local tbl = GridItem:new(t)

    tbl.customer = nil

    assert(tbl.customer_system)

    setmetatable(tbl, self)

    return tbl
end

-- function Seat:update()

-- end

-- function Seat:draw()
    
-- end

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
