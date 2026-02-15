LightSystem = {}
LightSystem.__index = LightSystem

function LightSystem:new(t)
    t = t or {}
    local tbl = copy_table(t)

    setmetatable(tbl, self)

    assert(tbl.start_time)

    tbl.timer = tbl.start_time
    tbl.sleep = tbl.sleep or false
    tbl.candle_lenght = 10

    _GLOBALS.light = false


    return tbl
end


function LightSystem:update()
    self.candle_lenght = ceil(10* (self.timer/self.start_time))

    if not self.sleep and btnp(4) then
        self:switch()
    end
    
    if _GLOBALS.light then
        self.timer -= 1
        ParticleManager:create_particle(FireParticle, {
            x=63 , y= 75-self.candle_lenght
        })
    end

    if self.timer == 0 then
        SceneManager:enter_scene(GameOverScene)
    end
end

function LightSystem:draw()
    if _GLOBALS.light then
        spr(76,55,72,2,1)
        rectfill(62,76-self.candle_lenght, 64,76,8)
        pset(63,75-self.candle_lenght,0)
    end
end


function LightSystem:switch()
    _GLOBALS.light = not _GLOBALS.light   
    if _GLOBALS.light then
        EventSystem:emit("lights_on")
        sfx(5)
        log("lights on")
    else
        sfx(4)
        log("lights off")
    end
end