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

function Workstation:handle_add_ingredient(props)
    add(self.ingredients, props.ingredient)
end