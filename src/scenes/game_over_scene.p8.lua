GameOverScene = Scene:new()
GameOverScene.__index = GameOverScene

function GameOverScene:new(t)
    t = t or {}
    local tbl = copy_table(t)

    setmetatable(tbl,self)
    
    return tbl   
end


function GameOverScene:update()

    if btnp(5)then
        SceneManager:enter_scene(GameScene)
    elseif btnp(4)then
        SceneManager:enter_scene(MenuScene)
    end
end

function GameOverScene:draw()
    print_align_center("you let the candle burn out", 0,40,128, 11)    
    print_align_center("❎ restart", 0,50,128, 11)  
    print_align_center("🅾️ menu", 0,60,128, 11) 
    
    
end

function GameOverScene:enter()
    sfx(13)     
end



