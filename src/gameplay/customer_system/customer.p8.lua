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
        for i=1,15 do
            if not has_value(self.vis_colors, i) then
                palt(i, true)
            end
        end
        pal(0,2)
        spr(self.spr,x,y-16,2,4)
        pal(0,0)

        for i=0,15 do
            palt(i, false)
        end
    end




    palt(_CONFIG.default_bg_col,true)
    palt(self.bg_col, false)
end

function Customer:serve(product)

    local particle_data = copy_table(self.seat.draw_pos)
    particle_data.x += 4
    particle_data.y -= 8

    if product.name == self.fav_recipie.name then
        log("customer satisfied")
        particle_data.type = "heart"
    else
        particle_data.type = "sad"
        log("customer dissatisfied")
    end
    ParticleManager:create_particle(SatisfactionParticle,particle_data)
    self.seat:del_customer()

    EventSystem:emit("product_served")
end

function Customer:special_behaviour()

end