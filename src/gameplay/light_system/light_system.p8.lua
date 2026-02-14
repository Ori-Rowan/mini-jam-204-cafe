LightSystem = {}
LightSystem.__index = LightSystem

function LightSystem:new(t)
    t = t or {}
    local tbl = copy_table(t)

    setmetatable(tbl, self)

    assert(tbl.timer)

    tbl.sleep = tbl.sleep or false

    _GLOBALS.light = false

    return tbl
end


function LightSystem:update()
    if not self.sleep and btnp(4) then
        self:switch()
    end
    
    if _GLOBALS.light then
        self.timer -= 1
    end

    if self.timer == 0 then
        EventSystem:emit("lights_ran_out")
    end
end

function LightSystem:switch()
    _GLOBALS.light = not _GLOBALS.light   
    if _GLOBALS.light then
        log("lights on")
    else
        log("lights off")
    end
end