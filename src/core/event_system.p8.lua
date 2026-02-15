EventSystem = {
    events = {},
    listeners = {}
}

function EventSystem:update()
    foreach(self.listeners, function (l)
        foreach(self.events, function (e)
            if (l.event == e.event) then 
                l.func(e.props)
                if (l.die) del(self.listeners, l)
            end
        end)
    end)
    self.events = {}
end

function EventSystem:add_listener(event, func, die)
    assert(type(func) == "function")
    add(self.listeners,{
        event = event,
        func = func,
        die = die
    })
end

function EventSystem:emit(event, props, reactive)
    reactive = reactive or true
    local payload = props

    if not reactive and props then
        payload = copy_table(props)
    end

    log("event emitted: "..event)
    add(self.events, {event=event, props=payload})
end

function EventSystem:clear()
    self.events = {}
    self.listeners = {}
end