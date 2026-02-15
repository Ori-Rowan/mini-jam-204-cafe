AngryParticle = Particle:new()
AngryParticle.__index = AngryParticle

function AngryParticle:new(t)
    t = t or {}
    local tbl = copy_table(t)

    setmetatable(tbl, self)

    assert(tbl.x and tbl.y)

    tbl.x += 2+rnd(12)
    tbl.y -=10
    tbl.speed=rnd(1)
    tbl.lifetime=10
    
    return tbl
end

function AngryParticle:update()
    self.y -= self.speed

    self.lifetime -= 1
    if self.lifetime == 0 then
        self:die()
    end
end

function AngryParticle:draw()
    local col = 2
    if _GLOBALS.light then
        col = 0
    end
    pset(self.x, self.y,col)
end