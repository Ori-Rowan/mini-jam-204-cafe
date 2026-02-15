NightFinishedScene = Scene:new()
NightFinishedScene.__index = NightFinishedScene

function NightFinishedScene:new(t)
    t = t or {}
    local tbl = copy_table(t)

    setmetatable(tbl,self)
    
    return tbl   
end


function NightFinishedScene:update()

    if btnp(5) and _GLOBALS.night != 6 then
        SceneManager:enter_scene(GameScene)
    elseif btnp(4)then
        SceneManager:enter_scene(MenuScene)
    end
end

function NightFinishedScene:draw()
    if _GLOBALS.night == 6 then
        print_align_center("you finished night ".._GLOBALS.night-1, 0,40,128, 11)    
        print_align_center("thank you for playing", 0,50,128, 11)  
        print_align_center("🅾️ menu", 0,60,128, 11)      
    else
        print_align_center("you finished night ".._GLOBALS.night-1, 0,40,128, 11)    
        print_align_center("❎ continue", 0,50,128, 11)  
        print_align_center("🅾️ menu", 0,60,128, 11)      
    end

end

function NightFinishedScene:enter()
    _GLOBALS.night += 1
    dset(0, _GLOBALS.night)
end



