
function _init()
    _GLOBALS = {}
    poke(0x5f2e,1)
    pal(_CONFIG.default_pal,1)
    palt(0,false)
    palt(_CONFIG.default_bg_col,true)

    cartdata("five-nights-monster-cafe_by_orion")
    _GLOBALS.night = dget(0)

    SceneManager:enter_scene(MenuScene)   
end

function _update()
    SceneManager:update()
    EventSystem:update()
    ParticleManager:update()
end

function _draw()
    cls()
    SceneManager:draw()
end