Trashbin = {}
setmetatable(Trashbin, GridItem)
Trashbin.__index = Trashbin


function Trashbin:new(t)
    local tbl = GridItem:new(t)

    tbl.customer = nil

    assert(tbl.customer_system)
    setmetatable(tbl, self)

    return tbl
end

-- function Trashbin:update()

-- end

-- function Trashbin:draw()
    
-- end

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
