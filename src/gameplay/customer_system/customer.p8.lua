Customer = {}
Customer.__index = Customer


function Customer:new(t)
    t = t or {}
    local tbl = copy_table(t)

    setmetatable(tbl, Customer)

    assert(tbl.fav_recipie)

    return tbl
end

function Customer:update()
    self:special_behaviour()
end

function Customer:draw()
    palt(_CONFIG.default_bg_col,false)
    palt(self.bg_col, true)

    local x, y = self.seat.draw_pos.x, self.seat.draw_pos.y
    if _GLOBALS.light then
            spr(self.spr,x,y-24,2,4)
    end

    palt(_CONFIG.default_bg_col,true)
    palt(self.bg_col, false)
end

function Customer:serve(product)
    if product.name == self.fav_recipie then
        log("customer satisfied")
    else
        log("customer dissatisfied")
    end
    self.seat:del_customer()

    EventSystem:emit("product_served")
end

function Customer:special_behaviour()

end