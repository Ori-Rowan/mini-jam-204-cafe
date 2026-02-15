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
    if _GLOBALS.light then

        -- draw bar
        clip(0,64,128,64)
        rectfill(0,64,128,128,4)
        
        -- draw corners
        rectfill(0,70,58,128,0)
        circfill(58,70,58,4)
        rectfill(70,70,128,128,0)
        circfill(70,70,58,4)
        
        -- draw background
        clip(0,0,128,64)

        rectfill(0,0,128,64,5)
        
        -- draw corners
        rectfill(0,0,58,58,0)
        circfill(58,58,58,5)
        rectfill(70,0,128,58,0)
        circfill(70,58,58,5)

        clip(0,0,128,128)

        
        line(0,64,128,64,0)
        spr(102,106, 48,2,2)

    else
        line(0,64,128,64,2)
        spr_dark(102,106, 48,2,2)
    end


    self.customer_system:draw()
    self.bar_grid:draw()

end

function GameScene:enter()

    local night_data = NIGHTS_ENUM["NIGHT_".._GLOBALS.night]

    EventSystem:clear()   

    self.light_system = LightSystem:new({start_time = 2000})
    
    local product_stand = ProductStand:new({
        pos = {x = 3, y =1},
        draw_pos = {x=82, y=98}
    })
    local coffe_machine = CoffeeMachine:new({
        pos = {x=3, y=0},
        draw_pos = {x=82, y=80},
        product_stand = product_stand,
        spr=4
    })
    local workstation = Workstation:new({
        pos = {x=2, y=0},
        draw_pos = {x=60, y=80},
        coffe_machine = coffe_machine
    })
    local cookbook = Cookbook:new({
        pos = {x = 2, y =1},
        draw_pos = {x=60, y=98},
        spr=36,
        available_monsters = night_data.available_monsters
    })

     local grid_items={
        Ingredient:new({
            pos = {x=0, y=0},
            draw_pos = {x=22, y=80},
            ingredient = INGREDIENTS_ENUM.COFFEE_BEANS
        }),
        Ingredient:new({
            pos = {x=0, y=1},
            draw_pos = {x=22, y=98},
            ingredient = INGREDIENTS_ENUM.CHOCOLATE
        }),
        Ingredient:new({
            pos = {x=1, y=0},
            draw_pos = {x=42, y=80},
            ingredient = INGREDIENTS_ENUM.MILK
        }),
        Ingredient:new({
            pos = {x=1, y=1},
            draw_pos = {x=42, y=98},
            ingredient = INGREDIENTS_ENUM.BERRY_SYRUP
        }),
        workstation,
        coffe_machine,
        product_stand,
        cookbook
    }

    self.bar_grid = GridSystem:new({
        items = grid_items
    })

    self.customer_system = CustomerSystem:new({
        seat_amount = 4,
        available_monsters = night_data.available_monsters
    })

    EventSystem:add_listener("serve_product", function (props)
        self.customer_system.grid_system:switch_sleep(false)
        self.bar_grid:switch_sleep(true)        
    end)

    EventSystem:add_listener("product_served", function (props)
        self.customer_system.grid_system:switch_sleep(true)
        self.bar_grid:switch_sleep(false)        
    end)

    EventSystem:add_listener("cookbook_open", function (props)
        self.bar_grid:switch_sleep(true)
    end)

    EventSystem:add_listener("cookbook_close", function (props)
        self.bar_grid:switch_sleep(false)
    end)



end