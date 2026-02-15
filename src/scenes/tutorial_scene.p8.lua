TutorialScene = Scene:new()
TutorialScene.__index = TutorialScene

function TutorialScene:new(t)
    t = t or {}
    local tbl = copy_table(t)

    setmetatable(tbl,self)
    
    return tbl   
end


function TutorialScene:update()
    GameScene.update(self)

    if btnp(5) and not self.sleep then
        coresume(self.conversation)
    end
end

function TutorialScene:draw()
    GameScene.draw(self)
    
    local txt = self.msg_list[self.msg]
    if txt then
        rectfill(60,20,120,48,11)
        rect(60,20,120,48,0)
        print_align_center(txt, 62,24,58,0)
        if not self.sleep then
            print("❎",112,42,0)
        end
    end

end

function TutorialScene:enter()
    GameScene.enter(self)

    self.customer_system.spawn_timer= -1
    self.bar_grid:switch_sleep(true)
    self.score_system = nil

    self.msg_list = {
        "hello hello!",
        "sorry i forgot to pay the electricity bill",
        "you can light a candle with the 🅾️ button",
        "great now you can see",
        "welcome to your new job",
        "your job is to serve coffee to...",
        "monsters!",
        "but dont worry they wont hurt you",
        "... unless you burn the candle out",
        "so just use it sparingly and you'll be fine",
        "look! here's a customer",
        "look into the beastiary book to see what he likes",
        "use ⬅️⬆️⬇️➡️ to select it and ❎ to open the book", 
        nil,
        nil,
        "now use ❎ to put the beans on the board",  
        "use ❎ on the board to brew coffee",
        "now we wait for it to finish",
        "use ❎ to get the coffee from the coffee machine",
        "use ❎ to to serve the product to the customer",
        "select the zombie and use ❎ to give him the coffee",
        "uh the zombie didn't like that, try again",
        "great job!",
        "if you serve them what they like you'll get money",
        "otherwise they get angry and you loose money",
        "well see ya tommorow"
    }

    self.msg = 1

    self.conversation = cocreate(function ()
        self.msg += 1
        yield()
        self.msg += 1

        
        self.sleep = true
        EventSystem:add_listener("lights_on", function (props)
            self.sleep = false
            self.msg += 1
        end, true)

        for i=1,7 do
            yield()
            self.msg += 1
        end
        self.customer_system:spawn()

        yield()
        self.msg += 1
        yield()
        self.msg += 1
        self.sleep = true
        self.bar_grid:switch_sleep(false)

        self:add_sequential_listeners(
            {"cookbook_open", "cookbook_close", "cookbook_close", "add_ingredient", "start_brewing", "finished_brewing", "get_product", "serve_product"},
            function(step, props)
                self.msg += 1
            end
        )

        EventSystem:add_listener("customer_left", function (props)
            if props.satisfied then
                self.msg = 23
                self.sleep = false
                self.bar_grid:switch_sleep(true)
            else
                self.msg = 22
                self.customer_system:spawn()
            end
        end)

        for i=1,3 do
            yield()
            self.msg += 1
        end
        
        yield()
        SceneManager:enter_scene(NightFinishedScene)        
    
    end)
end

function TutorialScene:add_sequential_listeners(events, on_step)
    local function register_step(i)
        if (i > #events) return

        EventSystem:add_listener(events[i],
            function(props)
                if on_step then
                    on_step(i, props)
                end
                register_step(i + 1)
            end,
        true)
    end

    register_step(1)
end



