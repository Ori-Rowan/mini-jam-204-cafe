GameScene = Scene:new()
GameScene.__index = GameScene


function GameScene:new(t)
    t = t or {}
    local tbl = copy_table(t)

    setmetatable(tbl,self)
    
    return tbl   
end


function GameScene:update()
    self.bar_grid:update()
    self.customer_system:update()
    self.light_system:update()
end

function GameScene:draw()
    self.bar_grid:draw()
    self.customer_system:draw()
end

function GameScene:enter()

    EventSystem:clear()   

    self.light_system = LightSystem:new({timer = 2000})
    
    local product_stand = ProductStand:new({
        pos = {x = 3, y =1},
        draw_pos = {x=90, y=100}
    })
    local coffe_machine = CoffeeMachine:new({
        pos = {x=3, y=0},
        draw_pos = {x=90, y=80},
        product_stand = product_stand
    })
    local workstation = Workstation:new({
        pos = {x=2, y=0},
        draw_pos = {x=70, y=80},
        coffe_machine = coffe_machine
    })
    local cookbook = Cookbook:new({
        pos = {x = 2, y =1},
        draw_pos = {x=70, y=100}
    })

     local grid_items={
        Ingredient:new({
            pos = {x=0, y=0},
            draw_pos = {x=30, y=80},
            ingredient = INGREDIENTS_ENUM.COFFEE_BEANS
        }),
        Ingredient:new({
            pos = {x=0, y=1},
            draw_pos = {x=30, y=100},
            ingredient = INGREDIENTS_ENUM.CHOCOLATE
        }),
        Ingredient:new({
            pos = {x=1, y=0},
            draw_pos = {x=50, y=80},
            ingredient = INGREDIENTS_ENUM.MILK
        }),
        Ingredient:new({
            pos = {x=1, y=1},
            draw_pos = {x=50, y=100},
            ingredient = INGREDIENTS_ENUM.BERRY_SYRUP
        }),
        workstation,
        cookbook,
        coffe_machine,
        product_stand
    }

    self.bar_grid = GridSystem:new({
        items = grid_items
    })

    self.customer_system = CustomerSystem:new({
        seat_amount = 4
    })

    EventSystem:add_listener("serve_product", function (props)
        self.customer_system.grid_system:switch_sleep(false)
        self.bar_grid:switch_sleep(true)        
    end)

    EventSystem:add_listener("product_served", function (props)
        self.customer_system.grid_system:switch_sleep(true)
        self.bar_grid:switch_sleep(false)        
    end)


end