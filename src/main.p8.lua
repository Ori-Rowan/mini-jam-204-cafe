
function _init()
    _GLOBALS = {}
    poke(0x5f2e,1)
    pal({[0]=0,-16,-15,-14,-12,-11,-10,-13,-9,-4,-1,7,6,-7,-8,-5},1)
    palt(0,false)
    palt(_CONFIG.default_bg_col,true)
    SceneManager:enter_scene(GameScene)

    -- local test = CustomerSystem:new({seat_amount=4})
    -- test.seats[1]:interact()
end

function _update()
    SceneManager:update()
    EventSystem:update()
end

function _draw()
    cls()
    SceneManager:draw()
end