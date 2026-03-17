-- START OF docs.lua
-- priority: -11

--- Ori's Toolbox is a custom module for PICO-8 development.
-- @module oris_toolbox
-- @author Orion

--- Types.
-- Custom type definitions. These only serve as documentation clarity 
-- and aren't real types from the view of code.
-- @section types

--- (table) Type for a 2D Vector.
-- @table vector2D
-- @field x (number)
-- @field y (number)

--- (table) Type for point coordinates in 2D space.
-- @table point
-- @field x (number)
-- @field y (number)

--- (number) Type for angle. Point on a circle [0,1] where 0 is right.
-- @table angle

-- END OF docs.lua

-- START OF config.p8.lua
-- priority: -10

--- Config.
-- Options for module configuration.
-- @section config

--- @table _CONFIG.oris_toolbox
-- @field log_dir Output directory for custom logging. Default: "/log"
-- @field log_clear_on_start If true, log file clears on cartrige start. Default: true

_CONFIG = _CONFIG or {}

_CONFIG.oris_toolbox = _CONFIG.oris_toolbox or {}

-- set default values for oris_toolbox config
function _CONFIG.oris_toolbox.init(_ENV)
    -- if log file should clear when game runs
    log_clear_on_start = log_clear_on_start ~= false
    -- where the log is stored
    log_dir = log_dir or "/log"
end

_CONFIG.oris_toolbox:init()

-- END OF config.p8.lua

-- START OF general\logging_lib.p8.lua
-- priority: -2
-- tokens: 38

--- Logging library.
-- Helper functions for custom file logging. Output file can be modified via 
-- global _CONFIG.oris_toolbox.log_dir. If _CONFIG.oris_toolbox.log_clear_on_star
-- is true, log file gets cleared on cartrige start.
-- @section logging_lib

printh("["..time().."][INFO]: logging start", _CONFIG.oris_toolbox.log_dir,  _CONFIG.oris_toolbox.log_clear_on_start)
    
--- Logs entry into the log file.
-- Entry has the format "[time][level]msg"
-- @tparam string m the message to log 
-- @tparam string l level of the log. Default: "INFO"
function log(m, l)
    l = l or "INFO"
    printh("["..time().."]["..l.."]: "..m, _CONFIG.oris_toolbox.log_dir)    
end


-- END OF general\logging_lib.p8.lua

-- START OF general\entity_behaviour.p8.lua
-- priority: -1
-- tokens:28

--- Entity behaviour.
-- Helper function for entities in a 2D space.
-- @section entity_behaviour

--- Applies movement logic to an entity.
-- @tparam table e Entity table.
-- @tparam number e.spd Number of pixels to move.
-- @tparam angle e.dir Movement direction.
function entity_movement(e)
  if(e.dir) e.x+=cos(e.dir)*e.spd e.y+=sin(e.dir)*e.spd
end



-- END OF general\entity_behaviour.p8.lua

-- START OF general\input_lib.p8.lua
-- priority: -1
-- tokens: 13

--- Input library.
-- Helper functions for advanced player input.
-- @section input_lib


--- Get direction based on the player input ⬅️⬆️➡️⬇️ for normalized 8d input.
-- @treturn angle|empty Combined input direction or empty on no input or colliding input (left+right, up+down).
function get_8d_input()
    return tonum(split"0.5,0,,0.25,0.375,0.125,0.25,0.75,0.625,0.875,0.75,,0.5,0"[btn()&0b1111])
end
-- END OF general\input_lib.p8.lua

-- START OF general\math_lib.p8.lua
-- priority: -1
-- tokens: 38

--- Math library.
-- Helper functions for numbers.
-- @section math_lib

--- Get digits infront of decimal point of a given number.
-- @tparam number num 
-- @treturn number
function get_digits(num)
    num = abs(flr(num))
    if (num < 10) return 1

    local digits = 0
    while num > 0 do
        num = flr(num / 10)
        digits += 1
    end
    return digits
end


-- END OF general\math_lib.p8.lua

-- START OF general\sfx_lib.p8.lua
-- priority: -1
-- tokens: 49

--- Sfx library.
-- Helper functions for advanced sfx manipulation. 
-- @section sfx_lib

--- Changes the volume of a given sfx through direct memmory access.
-- @tparam number sfx
-- @tparam number volume Int between [0,7].
function change_sfx_volume(sfx,volume)
    sfx=flr(sfx)
    local v = flr(mid(0,volume,7))
    for i=0,31 do
        local n=0x3200+68*sfx+2*i
        poke2(n,%n&~0b111<<9|v<<9)
    end
end


-- END OF general\sfx_lib.p8.lua

-- START OF general\table_lib.p8.lua
-- priority: -1
-- tokens: 44

--- Table library.
-- Helper functions for tables.
-- @section table_lib

--- Creates non reactive copy of a table.
-- @tparam table t
-- @treturn table
function copy_table(t)
  local c = {}
  for k, v in pairs(t) do
    c[k] = v
  end
  return c
end

-- Source - https://stackoverflow.com/a/33511182
-- Posted by Oka, modified by community. See post 'Timeline' for change history
-- Retrieved 2026-01-28, License - CC BY-SA 3.0
--- Checks if table has a value.
-- @tparam table t
-- @tparam any val
-- @treturn bool
function has_value (t, val)
    for i, v in ipairs(t) do
        if (v == val)  return true
    end
    return false
end


-- END OF general\table_lib.p8.lua

-- START OF general\text_lib.p8.lua
-- priority: -1
-- tokens: 136

--- Text library.
-- Helper functions for strings and custom prints.
-- @section text_lib


--- Prints text centered inside a given width.
-- Automatically wraps words to multiple lines.
-- @tparam string msg Text to print.
-- @tparam number x Left position in pixels.
-- @tparam number y Top position in pixels.
-- @tparam number w Width in pixels.
-- @tparam number col Color of the printed text.
function print_align_center(msg, x, y, w, col)
    local words = split(msg, " ")
    local rows = {}
    local current_row = ""

    for i=1, #words do
        local word = words[i]
        if current_row == "" then
            current_row = word
        else
            -- Check if adding the next word would exceed width
            if  str_width(current_row.." "..word)> w then
                add(rows, current_row)
                current_row = word
            else
                current_row ..= " " .. word
            end
        end
    end

    -- Add the last row if anything is left
    if current_row != "" then
        add(rows, current_row)
    end

    -- Print centered
    for i=1, #rows do
        local row = rows[i]
        print(row, x + (w - str_width(row)) / 2, y + 6 * (i-1), col)
    end
end


--- Get width of a given string in pixels.
-- @tparam sring str 
-- @treturn number
function str_width(str)
    local len = 0
    foreach(str, function (char)
        len += 4
        if (ord(char) >= 128) len+=4
    end)
    return len
end


-- END OF general\text_lib.p8.lua

-- START OF general\time_lib.p8.lua
-- priority: -1

--- Time library.
-- Helper functions for time/frames related things.
-- @section time_lib

--- Converts seconds to frames assuming 30 FPS.
-- @tparam number seconds 
-- @treturn number Seconds
function seconds_to_frames(seconds)
    return flr(seconds*30)
end

--- Converts frames to seconds assuming 30 FPS.
-- @tparam number frames
-- @treturn number Seconds
function frame_to_seconds(frames)
    return ceil(frames/30)    
end


-- END OF general\time_lib.p8.lua

-- START OF general\vector_lib.p8.lua
-- priority: -1

--- Vector library.
-- Helper functions for basic vector manipulation.
-- @section vector_lib

--- Get vector table between coordinate tables.
-- @tparam point a
-- @tparam point b
-- @treturn vector2D
function get_vector_from_points(a,b)
	return {x=b.x-a.x,y=b.y-a.y}
end

--- Get the magnitued of a given vector.
-- @tparam vector2D v
-- @treturn number Magnitude
function get_vector_length(v)
	return sqrt(v.x^2+v.y^2)
end

--- Get normilized vector with magnitude of 1.
-- @tparam vector2D v
-- @treturn vector2D
function normalize_vector(v)
    if (get_vector_length(v) == 0) return log('Cannot normalize vector of lenght 0', "WARNING")
	v.x,v.y=v.x/get_vector_length(v),v.y/get_vector_length(v)
end

--- Get normilized vector from an angle.
-- @tparam angle a 
-- @treturn vector2D
function get_vector_from_angle(a)
	return {x=cos(a),y=sin(a)}
end

--- Get angle from a given vector.
-- @tparam vector2D v
-- @treturn angle
function get_angle_from_vector(v)
	return atan2(v.x,v.y)
end


-- END OF general\vector_lib.p8.lua

-- START OF particle_manager\particle.p8.lua

-- priority: 1

Particle = {}
Particle.__index = Particle

function Particle:new(t)
    t = t or {}
    local tbl = copy_table(t)

    setmetatable(tbl, self)

    return tbl
end

function Particle:update()
    log('Update unimplemented in particle', "WARNING")
end

function Particle:draw()
    log('Draw unimplemented in particle', "WARNING")
end

function Particle:die()
    if self.layer then
        del(ParticleManager.layers[self.layer], self)    
    else
        del(ParticleManager.particles, self)    
    end
end
-- END OF particle_manager\particle.p8.lua

-- START OF scene_manager\scene.p8.lua
-- priority : 1

Scene = {}
Scene.__index = Scene

function Scene:new(t)
    t = t or {}
    local tbl = copy_table(t)

    setmetatable(tbl,self)
    
    return tbl   
end

function Scene:update()
    log("Scene has no update method", "WARNING")
end

function Scene:draw()
    log("Scene has no draw method", "WARNING")
end

function Scene:enter()
    log("Scene has no enter method", "WARNING")
end
-- END OF scene_manager\scene.p8.lua

-- START OF camera\camera.p8.lua
-- priority: 1

--- Global camera object to handle camera position.
-- @type Camera

Camera = {
    --- (number) Maximum offset for camera shake.
    shake_offset = 2,
    --- (number) Internal timer for camera shake.
    shake_timer = 0,
}

--- Begin camera shaking for amount of frames.
-- @tparam number f Amount of frames to shake for.
function Camera:shake(f)
    self.shake_timer=f
end

--- Update step function.
function Camera:update()
    if (self.shake_timer > 0) self.shake_timer-=1 
end

--- Draw step function.
function Camera:draw()
    if self.shake_timer > 0 then
        camera(self:get_offset(), self:get_offset())
    else
        camera(0,0)
    end
end

--- Get random camera offset.
-- offset is calculated based on Camera.shake_offset.
-- @return number offset
function Camera:get_offset()
    return rnd(self.shake_offset*2) - self.shake_offset
end
-- END OF camera\camera.p8.lua

-- START OF event_manager\event_manager.p8.lua
-- priority: 1
-- tokens: 102

--- Global singleton manager for the event system. Listeners and events do not have a 
-- deterministic order. Do not rely on multiple events/listeners triggering in a 
-- particular sequence. Event props are shared across listeners, so if a handler mutates 
-- props, subsequent listeners will see the changes.
-- @type EventManager

EventManager = {
    --- Internal queue for pending events. Events are tables like this:
    -- @field 1 (string) event
    -- @field 2 (table) props
    events = {}, 
    --- A list of active listeners. Listeners are tables like this: 
    -- @field 1 (string) event
    -- @field 2 (function) func
    -- @field 3 (bool) die
    listeners = {} 
}


--- Update function for EventManager.
-- Processes all events by calling listener functions. After processing, the event queue is cleared.
function EventManager:update()
    foreach(self.listeners, function (l)
        foreach(self.events, function (e)
            if l[1] == e[1] then 
                l[2](e[2])
                if (l[3]) del(self.listeners, l)
            end
        end)
    end)
    self.events = {}
end

--- Adds a new listener tied to an event.
-- @tparam string event Name of event to listen to.
-- @tparam function func Handler function that recieves one parameter: props table.
-- @tparam bool die If true, the listener is removed after one trigger.
function EventManager:add_listener(event, func, die)
    add(self.listeners,{event,func,die}) -- 1=event, 2=func, 3=die
end

--- Emits an event with props.
-- @tparam string event Name of the event emitted.
-- @tparam table props Props for handler function.
-- @tparam bool reactive If true, props are passed directly; otherwise a safe copy is used.
function EventManager:emit(event, props, reactive)
    add(self.events, {event, reactive and props or copy_table(props)}) -- 1=event, 2=props
end

--- Resets EventManager state.
-- Clears all listeners and event queue.
-- @function EventManager:clear
function EventManager.clear(_ENV)
    events, listeners  = {}, {}
end

-- END OF event_manager\event_manager.p8.lua

-- START OF particle_manager\particle_manager.p8.lua
-- priority: 1

ParticleManager = {
    particles = {},
    layers = {}
}

function ParticleManager:create_particle(particle, tbl, amount, layer)
    amount = amount or 1
    home = self.particles
    if layer then
        local home = self.layers[layer]
        tbl.layer = layer
    end

    for i=1, amount do   
        add(home, particle:new(tbl))
    end
end

function ParticleManager:init_layer(layer)
    self.layers[layer] = {}
end

function ParticleManager:update(layer)
    local particles = self.particles        
    if layer then
        particles = self.layers[layer]
    end
    log("updating layer: "..tostr(layer))

    foreach(particles, function (p)
        p:update()
    end)
end

function ParticleManager:draw(layer)
    local particles = self.particles        
    if layer then
        particles = self.layers[layer]
    end

    foreach(particles, function (p)
        p:draw()
    end)
end
-- END OF particle_manager\particle_manager.p8.lua

-- START OF scene_manager\scene_manager.p8.lua
-- priority: 1

SceneManager = {
    current_scene=nil
}

function SceneManager:update()
    if (self.current_scene == nil) return log("No current scene", "Warning")

    self.current_scene:update()
end

function SceneManager:draw()
    if (self.current_scene == nil) return log("No current scene", "Warning")

    self.current_scene:draw()
end

function SceneManager:enter_scene(scene, tbl)
    tbl = tbl or {}
    self.current_scene = scene:new(tbl)
    self.current_scene:enter()
end
-- END OF scene_manager\scene_manager.p8.lua

