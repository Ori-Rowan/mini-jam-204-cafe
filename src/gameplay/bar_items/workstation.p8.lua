Workstation = {}
setmetatable(Workstation, GridItem)
Workstation.__index = Workstation

function Workstation:new(t)
    local tbl = GridItem:new(t)
    setmetatable(tbl, self)

    assert(tbl.coffe_machine)
    tbl.ingredients = {}
    EventSystem:add_listener("add_ingredient", function (props)
        tbl:handle_add_ingredient(props)
    end)

    return tbl
end

function Workstation:interact()
    if #self.ingredients == 0 then
        log("no ingredients in working station")
        return
    elseif self.coffe_machine.brewing then
        log("cofee machine brewing")
        return
    elseif self.coffe_machine.product then
        log("cofee machine full")
        return
    end
    EventSystem:emit("start_brewing", {ingredients = self.ingredients})
    self.ingredients = {}
end

function Workstation:draw()
    if not _GLOBALS.light then
        return
    end

    local x,y = self.draw_pos.x, self.draw_pos.y
    rectfill(x,y+2,x+16,y+14, 6)
    rect(x,y+2,x+16,y+14, 0)
    if #self.ingredients>0 then
        spr(6,x+4,y+4)

    end
end

function Workstation:handle_add_ingredient(props)
    add(self.ingredients, props.ingredient)
end