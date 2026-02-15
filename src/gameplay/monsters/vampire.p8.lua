Vampire = {}
setmetatable(Vampire, Customer)
Vampire.__index = Vampire

function Vampire:new()
    local tbl = copy_table(MONSTERS_ENUM.VAMPIRE)

    tbl = Customer:new(tbl)

    setmetatable(tbl, self)
    
    tbl.time_treshold = 300
    tbl.timer = tbl.time_treshold

    return tbl
end

function Vampire:draw()
    palt(_CONFIG.default_bg_col,false)
    palt(self.bg_col, true)

    local x, y = self.seat.draw_pos.x, self.seat.draw_pos.y

    if self.timer <= self.time_treshold/2 then
        x += rnd(2)-1      
        y += rnd(2)-1       
    end

    if _GLOBALS.light then
        spr(self.spr,x,y-16, 2,4)
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

function Vampire:special_behaviour()
    self.timer -= 1
    if self.timer == 0 then
        self:leave(false)
    end
end