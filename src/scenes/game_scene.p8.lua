GameScene = Scene:new()
GameScene.__index = GameScene


function GameScene:new(t)
    t = t or {}
    local tbl = copy_table(t)

    setmetatable(tbl,self)
    
    return tbl   
end

function GameScene:draw()
    print_align_center("to be done",0,60,128,7)
end