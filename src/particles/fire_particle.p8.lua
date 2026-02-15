FireParticle = Particle:new()
FireParticle.__index = FireParticle

function FireParticle:new(t)
    t = t or {}
    local tbl = copy_table(t)

    setmetatable(tbl, self)

    assert(tbl.x and tbl.y)

    tbl.dir = get_vector_from_angle(rnd(1)/2)

    tbl.speed=1
    tbl.lifetime=5
    
    return tbl
end

function FireParticle:update()
    self.x += self.dir.x * self.speed
    self.y += self.dir.y * self.speed

    self.lifetime -= 1
    if self.lifetime == 0 then
        self:die()
    end
end

function FireParticle:draw()
    pset(self.x, self.y,13)
end