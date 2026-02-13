ProductStand = {}
setmetatable(ProductStand, GridItem)
ProductStand.__index = ProductStand

function ProductStand:new(t)
    local tbl = GridItem:new(t)
    setmetatable(tbl, self)
    
    tbl.ingredients = {}
    self.product = nil

    EventSystem:add_listener("get_product", function (props)
        tbl:handle_get_product(props)        
    end)

    return tbl
end

function ProductStand:interact()
    if self.product == nil then
        log("product stand is empty")
        return
    end
    self:serve()
end

function ProductStand:serve()
    EventSystem:emit("serve_product", {product = self.product})
    self.product = nil 
end


function ProductStand:handle_get_product(props)
    self.product = props.product
end