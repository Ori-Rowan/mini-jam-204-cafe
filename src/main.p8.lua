
function _init()
    SceneManager:enter_scene(GameScene)
end

function _update()
    SceneManager:update()
    EventSystem:update()
end

function _draw()
    cls()
    SceneManager:draw()
end