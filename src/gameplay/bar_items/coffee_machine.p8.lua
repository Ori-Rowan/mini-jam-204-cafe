CoffeeMachine = {}
setmetatable(CoffeeMachine, GridItem)
CoffeeMachine.__index = CoffeeMachine

function CoffeeMachine:new(t)
    local tbl = GridItem:new(t)
    setmetatable(tbl, self)

    tbl.ingredients = {}
    tbl.brewing = false
    tbl.brew_time = tbl.brew_time or 90
    tbl.brew_timer = 0
    tbl.product = nil

    tbl.cup_spr = 7

    assert(tbl.product_stand)


    EventSystem:add_listener("start_brewing", function (props)
        tbl:handle_start_brewing(props)        
    end)
    return tbl
end

function CoffeeMachine:interact()
    if self.product == nil then
        log("coffee machine is empty")
        return
    elseif self.brewing then
        log("coffe machine is brewing")
        return
    elseif self.product_stand.product != nil then
        log("product stand is full")
        return
    end
    EventSystem:emit("get_product", {product = self.product})
    self.product = nil
end

function CoffeeMachine:update()
    if self.brewing then
        self.brew_timer-=1
        if self.brew_timer == 0 then
            log("brewing finished: "..self.product.name)
            self.brewing=false
        end
    end
end

function CoffeeMachine:draw()
    local x,y = self.draw_pos.x,self.draw_pos.y
    if _GLOBALS.light then
        spr(self.spr, x, y, 2, 2)

        if self.product then
            spr(self.cup_spr,x+5,y+8)
        end
    end

    local light_col = 15
    if self.brewing or self.product == nil then
        light_col = 14
    end
    pset(x+12,y+2,light_col)
    pset(x+13,y+2,light_col)
end

function CoffeeMachine:get_recipie()
    -- for ingredient in all(self.ingredients) do 
    --     log(ingredient)
    -- end

    for name, recipie in pairs(RECIPIES_ENUM) do 
        local match = self:check_recipie(recipie)
        if match then
            -- log("recipie matched: ".. recipie.name)
            return recipie
        end
        -- log("recipie didnt match: ".. recipie.name)
    end
    log("no recipie match")
    return RECIPIES_ENUM.BAD_DRINK
end

function CoffeeMachine:check_recipie(recipie)
    local cm_ingredients = copy_table(self.ingredients)
    for r_ingredient in all(recipie.ingredients) do
        local ingredient_match = false
        for cm_ingredient in all(cm_ingredients) do
            if cm_ingredient == r_ingredient then
                ingredient_match = true
                del(cm_ingredients, cm_ingredient)
                break
            end
        end
        if (ingredient_match==false) return false            
    end
    return #cm_ingredients == 0
end


function CoffeeMachine:handle_start_brewing(props)
    self.ingredients = props.ingredients
    self.brewing = true
    self.brew_timer = self.brew_time
    self.product = self:get_recipie()
    self.ingredients = {}
    log("cofee machine start brewing: "..self.product.name)
end

