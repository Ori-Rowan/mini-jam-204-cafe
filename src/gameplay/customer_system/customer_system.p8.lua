CustomerSystem = {}
CustomerSystem.__index = CustomerSystem


function CustomerSystem:new(t)
    t = t or {}
    local tbl = copy_table(t)
    
    setmetatable(tbl, self)

    assert(tbl.seat_amount)
    
    tbl.seats = {}
    tbl.product = nil

    tbl:init_grid_system()    

    EventSystem:add_listener("serve_product", function (props)
        tbl:handle_serve_product(props)
    end)

    local test_customer1 = Customer:new{
        fav_recipie = RECIPIES_ENUM.ESPRESSO.name
    }

    local test_customer2 = Customer:new{
        fav_recipie = RECIPIES_ENUM.CAPPUCCINO.name
    }

    tbl.seats[1]:add_customer(test_customer1)
    tbl.seats[2]:add_customer(test_customer2)


    return tbl
end

function CustomerSystem:update()
    self.grid_system:update()
end

function CustomerSystem:draw()
    self.grid_system:draw()
end

function CustomerSystem:handle_serve_product(props)
    self.product = props.product
    log(self.product.name)
end

function CustomerSystem:init_grid_system()
    local grid_items = {}
    add(grid_items, Trashbin:new({
        pos = {
            x = 0,
            y = 0
        },
        draw_pos = {
            x = 20,
            y = 50
        },
        color = 8,
        customer_system = self
    }))

    for i=1, self.seat_amount do
        local seat = Seat:new({
            pos = {
                x = i,
                y = 0
            },
            draw_pos = {
                x = 20 + i*20,
                y = 50
            },
            color = 3,
            customer_system = self
        })
        add(self.seats, seat)
        add(grid_items, seat)
    end

    self.grid_system = GridSystem:new({
      items = grid_items,
      sleep = true
    })
end
