Cookbook = {}
setmetatable(Cookbook, GridItem)
Cookbook.__index = Cookbook

function Cookbook:new(t)
    local tbl = GridItem:new(t)
    setmetatable(tbl, self)

    return tbl
end

function Cookbook:interact()
    log("cookbook interaction (not done)")
end