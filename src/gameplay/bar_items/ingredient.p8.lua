Ingredient = {}
setmetatable(Ingredient, GridItem)
Ingredient.__index = Ingredient

function Ingredient:new(t)
    local tbl = GridItem:new(t)
    setmetatable(tbl, self)

    assert(tbl.ingredient)

    return tbl
end

function Ingredient:interact()
    log("Ingredient: "..self.ingredient)
    EventSystem:emit("add_ingredient", {ingredient=self.ingredient})
end