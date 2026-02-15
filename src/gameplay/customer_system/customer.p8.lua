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
        spr(self.spr,x,y-16,2,4)
    else
        spr_dark(self.spr,x,y-16,2,4, self.vis_colors)
    end

    palt(_CONFIG.default_bg_col,true)
    palt(self.bg_col, false)
end

function Customer:serve(product)

   self:leave(product.name == self.fav_recipie.name)

    EventSystem:emit("product_served")
end

function Customer:special_behaviour()

end

function Customer:leave(satisfied)
    
    local particle_data = copy_table(self.seat.draw_pos)
    particle_data.x += 4
    particle_data.y -= 8
    if satisfied then
        log("customer satisfied")
        particle_data.type = "heart"
    else
        particle_data.type = "sad"
        log("customer dissatisfied")
    end
    ParticleManager:create_particle(SatisfactionParticle,particle_data)
    
    self.seat:del_customer()
    
    EventSystem:emit("customer_left", {satisfied = satisfied })
end