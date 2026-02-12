
function _init()
    SceneManager:enter_scene(MenuScene)
end

function _update()
    SceneManager:update()
end

function _draw()
    cls()
    SceneManager:draw()
end