ScoreSystem = {}
ScoreSystem.__index = ScoreSystem

function ScoreSystem:new(t)
    t = t or {}
    local tbl = copy_table(t)

    setmetatable(tbl, self)
    
    assert(tbl.goal)

    tbl.score = 0

    EventSystem:add_listener("customer_left", function (props)
        tbl:handle_customer_left(props)
    end)

    return tbl
end

function ScoreSystem:draw()
    local msg = "money: "..self.score
    if (self.goal != "infinite") msg+="/"..self.goal
    print_align_center(msg,0,8,128,15)
end

function ScoreSystem:handle_customer_left(props)
    if props.satisfied then
        sfx(6)
        self.score += props.value
    else
        sfx(7)
        self.score -= props.value
        if self.score < 0 then
            self.score = 0
        end
    end
    
    if self.score >= self.goal then
        SceneManager:enter_scene(NightFinishedScene)
    end
end