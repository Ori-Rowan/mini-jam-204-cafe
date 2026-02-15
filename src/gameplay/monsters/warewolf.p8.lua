Warewolf = {}
setmetatable(Warewolf, Customer)
Warewolf.__index = Warewolf

function Warewolf:new()
    local tbl = copy_table(MONSTERS_ENUM.WAREWOLF)

    tbl = Customer:new(tbl)

    setmetatable(tbl, self)
    
    tbl.dark_treshold = 100
    tbl.timer = tbl.dark_treshold

    return tbl
end

function Warewolf:draw()
    palt(_CONFIG.default_bg_col,false)
    palt(self.bg_col, true)

    local x, y = self.seat.draw_pos.x, self.seat.draw_pos.y

    if self.timer <= self.dark_treshold/2 then
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

function Warewolf:special_behaviour()
    if not _GLOBALS.light then
        self.timer -= 1
    else
        self.timer = self.dark_treshold
    end
    if self.timer == self.dark_treshold/2 then
        sfx(10)
    end

    if self.timer == 0 then
        self:leave(false)
    end
end