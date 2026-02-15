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
    self.pointer = mid(1,self.pointer,MENU_SCENE_STATE.length)
    if l_pointer != self.pointer then
        sfx(3)
    end


    -- btn press
    if btnp(5) then
        sfx(4)
        if self.pointer==1 then
            log('Enter GameScene')
            _GLOBALS.night = 1
            SceneManager:enter_scene(GameScene)
        end
    end
end

function MenuScene:main_draw()
    self:draw_button(39,60,50,10,'new game', self.pointer==1)
end

function MenuScene:draw_button(x,y,w,h,msg,pointer)
    if pointer then
        msg ="❎ "..msg
    end
    rectfill(x,y,x+w,y+h,7)
    rect(x,y,x+w,y+h,5)
    print_align_center(msg, x,y+h/2-2,w,0)
end