CustomerSystem = {}
CustomerSystem.__index = CustomerSystem


function CustomerSystem:new(t)
    t = t or {}
    local tbl = copy_table(t)
    
    setmetatable(tbl, self)

    assert(tbl.seat_amount and tbl.available_monsters)
    
    tbl.seats = {}
    tbl.product = nil

    tbl.spawn_time = tbl.spawn_time or 150
    tbl.spawn_timer = tbl.spawn_time

    tbl:init_grid_system()    

    EventSystem:add_listener("serve_product", function (props)
        tbl:handle_serve_product(props)
    end)


    return tbl
end

function CustomerSystem:update()
    self.grid_system:update()

    self.spawn_timer -= 1
    if self.spawn_timer == 0 then
        self:spawn()
        self.spawn_timer = self.spawn_time
    end
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
            x = 5,
            y = 48
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
                x = 5 + i*20,
                y = 48
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

function CustomerSystem:spawn()
    log("spawning monster")
    local rnd_index = 1+flr(rnd(#self.available_monsters))
    local monster = self.available_monsters[rnd_index].class:new()

    for seat in all(self.seats) do
        if seat.customer == nil then
            seat:add_customer(monster)
            break;
        end
    end
end
