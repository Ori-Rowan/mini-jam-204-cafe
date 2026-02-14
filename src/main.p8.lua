
function _init()
    _GLOBALS = {}
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