GameScene = Scene:new()
GameScene.__index = GameScene


function GameScene:new(t)
    t = t or {}
    local tbl = copy_table(t)

    setmetatable(tbl,self)
    
    return tbl   
end


function GameScene:update()
    self.grid_system:update()
    -- EventSystem:update()
end

function GameScene:draw()
    self.grid_system:draw()
end

function GameScene:enter()

    EventSystem:clear()

   

    local product_stand = ProductStand:new({
        pos = {x = 3, y =1},
        draw_pos = {x=70, y=60}
    })
    local coffe_machine = CoffeeMachine:new({
        pos = {x=3, y=0},
        draw_pos = {x=70, y=50},
        product_stand = product_stand
    })
    local workstation = Workstation:new({
        pos = {x=2, y=0},
        draw_pos = {x=50, y=50},
        coffe_machine = coffe_machine
    })
    local cookbook = Cookbook:new({
        pos = {x = 2, y =1},
        draw_pos = {x=50, y=60}
    })

     local grid_items={
        Ingredient:new({
            pos = {x=0, y=0},
            draw_pos = {x=10, y=50},
            ingredient = INGREDIENTS_ENUM.COFFEE_BEANS
        }),
        Ingredient:new({
            pos = {x=0, y=1},
            draw_pos = {x=10, y=60},
            ingredient = INGREDIENTS_ENUM.CHOCOLATE
        }),
        Ingredient:new({
            pos = {x=1, y=0},
            draw_pos = {x=30, y=50},
            ingredient = INGREDIENTS_ENUM.MILK
        }),
        Ingredient:new({
            pos = {x=1, y=1},
            draw_pos = {x=30, y=60},
            ingredient = INGREDIENTS_ENUM.BERRY_SYRUP
        }),
        workstation,
        cookbook,
        coffe_machine,
        product_stand
    }

    self.grid_system = GridSystem:new({
        items = grid_items
    })


end