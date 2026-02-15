Cookbook = {}
setmetatable(Cookbook, GridItem)
Cookbook.__index = Cookbook

function Cookbook:new(t)
    local tbl = GridItem:new(t)
    setmetatable(tbl, self)

    assert(tbl.available_monsters)

    tbl.open = false
    tbl.page = 1

    return tbl
end

function Cookbook:update()
    if not self.open then
        return
    end

    if btnp(0) then
        self.page -= 1
    end
    if btnp(1) then
        self.page += 1
    end
    self.page = mid(self.page,1,#self.available_monsters)

    if btnp(5) then
        self.open = false
        EventSystem:emit("cookbook_close")
    end
end

function Cookbook:draw()
    if self.open then
        if _GLOBALS.light then
            rectfill(28,28,100,114,11)
            rect(28,28,100,114,0)

            local openedMonster = self.available_monsters[self.page]

            rectfill(74,30,98,68,5)
            rect(74,30,98,68,0)

            print_align_center(openedMonster.name, 31,32,44, 0)
            print_align_center(openedMonster.desc, 31,40,43, 0)

            print("favorite recipie:",32,70,0)

            spr(openedMonster.fav_recipie.spr, 32,78,2,2)
            print("=",50,84)

            for i=1, #openedMonster.fav_recipie.ingredients do
                local ingredient = openedMonster.fav_recipie.ingredients[i]
                local x,y = 38 + i*18, 78
                if i >2 then
                    x-=36
                    y+=18
                end
                spr(ingredient.spr,x,y,2,2)
                
            end

            palt(openedMonster.bg_col, true)
            palt(_CONFIG.default_bg_col, false)

            spr(openedMonster.spr, 79,36,2,4)
            
            palt(openedMonster.bg_col, false)
            palt(_CONFIG.default_bg_col, true)

        else 
            rectfill(15,20,113,108,0)
            rect(14,20,114,108,2)
        end


        
    else
        GridItem.draw(self)
    end
end

function Cookbook:interact()
    self.open = true
    EventSystem:emit("cookbook_open")
end