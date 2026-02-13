Customer = {}
Customer.__index = Customer


function Customer:new(t)
    t = t or {}
    local tbl = copy_table(t)

    setmetatable(tbl, Customer)

    assert(tbl.fav_recipie)

    return tbl
end

-- function Customer:update()
    
-- end

-- function Customer:draw()
    
-- end

function Customer:serve(product)
    if product.name == self.fav_recipie then
        log("customer satisfied")
    else
        log("customer dissatisfied")
    end
    self.seat:del_customer()

    EventSystem:emit("product_served")
end