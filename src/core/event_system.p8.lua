EventSystem = {
    events = {},
    listeners = {}
}

function EventSystem:update()
    foreach(self.listeners, function (l)
        foreach(self.events, function (e)
            if (l.event == e.event) l.func(e.props)
        end)
    end)
    self.events = {}
end

function EventSystem:add_listener(event, func)
    assert(type(func) == "function")
    add(self.listeners,{
        event = event,
        func = func
    })
end

function EventSystem:emit(event, props, reactive)
    reactive = reactive or true
    local payload = props

    if not reactive and props then
        payload = copy_table(props)
    end

    log("Event emitted: "..tostr(event))
    add(self.events, {event=event, props=payload})
end

function EventSystem:clear()
    self.events = {}
    self.listeners = {}
end