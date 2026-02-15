
function _init()
    _GLOBALS = {}
    poke(0x5f2e,1)
    pal(_CONFIG.default_pal,1)
    palt(0,false)
    palt(_CONFIG.default_bg_col,true)

    _GLOBALS.night = 5

    SceneManager:enter_scene(MenuScene)   
        -- ParticleManager:create_particle(AngryParticle,{x=60,y=60})   

    -- _GLOBALS.night = 5
    -- SceneManager:enter_scene(GameScene)
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