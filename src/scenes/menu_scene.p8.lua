MenuScene = Scene:new()
MenuScene.__index = MenuScene


function MenuScene:new(t)
    t = t or {}
    local tbl = copy_table(t)

    setmetatable(tbl,self)
    
    return tbl   
end

MENU_SCENE_STATE={
    main=1,
}

function MenuScene:update()
    if self.state==MENU_SCENE_STATE.main then
        self:main_update()
    end
end

function MenuScene:draw()
    if self.state==MENU_SCENE_STATE.main then
        self:main_draw()
    end    
end

function MenuScene:enter()
    self.pointer = 1 
    self.state = MENU_SCENE_STATE.main
end

function MenuScene:main_update()
    -- pointer
    local l_pointer = self.pointer
    if btnp(2) then
        self.pointer-=1
    end
    if btnp(3) then
        self.pointer+=1
    end
    self.pointer = mid(1,self.pointer,2)
    if l_pointer != self.pointer then
        sfx(0)
    end


    -- btn press
    if btnp(5) then
        sfx(0)
        if self.pointer==1 then
            log('Enter TutorialScene')
            _GLOBALS.night = 0
            SceneManager:enter_scene(TutorialScene)
        elseif self.pointer==2 and _GLOBALS.night != 0 then
            log('Enter GameScene')
            if type(_GLOBALS.night) == "number" and _GLOBALS.night > 5 then
                _GLOBALS.night = 5
            end
            SceneManager:enter_scene(GameScene)
        end
    end
end

function MenuScene:main_draw()
    spr(145,44,10,6,8)

    self:draw_button(39,60,50,10,'new game', self.pointer==1)
    self:draw_button(39,72,50,10,'continue', self.pointer==2)
    print("controls:", 4,98,11)
    print("⬅️⬆️⬇️➡️=arrows", 4,106,11)
    print("🅾️=z", 4,114,11)
    print("❎=x", 22,114,11)

end

function MenuScene:draw_button(x,y,w,h,msg,pointer)
    if pointer then
        msg ="❎ "..msg
    end
    rectfill(x,y,x+w,y+h,0)
    rect(x,y,x+w,y+h,11)
    print_align_center(msg, x,y+h/2-2,w,11)
end