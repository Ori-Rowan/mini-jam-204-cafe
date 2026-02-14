SatisfactionParticle = Particle:new()
SatisfactionParticle.__index = SatisfactionParticle

function SatisfactionParticle:new(t)
    t = t or {}
    local tbl = copy_table(t)

    setmetatable(tbl, self)

    assert(tbl.x and tbl.y and tbl.type)

    local types = {
        heart = 22,
        sad =23
    }

    tbl.spr = types[tbl.type]
    tbl.speed=0.1
    tbl.lifetime=30
    
    return tbl
end

function SatisfactionParticle:update()
    self.y -= self.speed
    self.lifetime -= 1
    if self.lifetime == 0 then
        self:die()
    end
end

function SatisfactionParticle:draw()
    spr(self.spr, self.x, self.y)
end