Mimic = {}
setmetatable(Mimic, Customer)
Mimic.__index = Mimic

function Mimic:new()
    local target = Mimic:get_rnd_target()
    tbl = target.class:new()

    setmetatable(tbl,self)
    
    tbl.target = target
    tbl.fav_recipie = MONSTERS_ENUM.MIMIC.fav_recipie
    tbl.value += MONSTERS_ENUM.MIMIC.value

    local col_swap_tbls = {
        zombie = {
            {a=15,b=10},
            {a=7,b=4}
        },
        skeleton = {
            {a=11,b=12},
            {a=5,b=7}
        },
        ghost = {
            {a=14,b=9}
        },
        warewolf = {
            {a=4,b=3},
            {a=3,b=1},
            {a=1,b=5},
        },
        vampire = { 
            {a=14,b=15},
        }
    }

    tbl.col_sawp = col_swap_tbls[tbl.target.name]
    
    return tbl
end


function Mimic:draw()
    

    foreach(tbl.col_sawp, function (col_sawp)
        pal(col_sawp.a, col_sawp.b)
    end)

    self.target.class.draw(self)

    foreach(tbl.col_sawp, function (col_sawp)
        pal(col_sawp.a, col_sawp.a, 0)
    end)
end

function Mimic:special_behaviour()
    self.target.class.special_behaviour(self)
end

function Mimic:get_rnd_target()
    local monster_tbl = {
        MONSTERS_ENUM.ZOMBIE,
        MONSTERS_ENUM.SKELETON,
        MONSTERS_ENUM.GHOST,
        MONSTERS_ENUM.WAREWOLF,
        MONSTERS_ENUM.VAMPIRE,
    }
    return monster_tbl[ceil(rnd(#monster_tbl))]
end

