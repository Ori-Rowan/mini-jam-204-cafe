Ghost = {}
setmetatable(Ghost, Customer)
Ghost.__index = Ghost

function Ghost:new()
    local tbl = copy_table(MONSTERS_ENUM.GHOST)

    tbl = Customer:new(tbl)

    setmetatable(tbl, self)
    
    tbl.light_treshold = 200
    tbl.timer = tbl.light_treshold
    if tbl.do_sfx then
        
    end

    return tbl
end

function Ghost:draw()
    palt(_CONFIG.default_bg_col,false)
    palt(self.bg_col, true)

    local x, y = self.seat.draw_pos.x, self.seat.draw_pos.y
    local y_offset = 60 - 60 * self.timer/self.light_treshold
    if _GLOBALS.light then
        spr(self.spr,x,y-16-y_offset,2,4)
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

function Ghost:special_behaviour()
    if _GLOBALS.light then
        self.timer -= 1
    end

    if self.timer == 0 then
        self:leave(false)
    end
end