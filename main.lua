require "scene"

local FIRST_SCENE = "main"

function love.load()
    Scene.Load(FIRST_SCENE)
end

-- rewrote run function to handle love and scene functions in a "clean" way
function love.run()
    if love.math then
        love.math.setRandomSeed(os.time())
    end

    if love.event then
        love.event.pump()
    end

    if love.load then love.load(arg) end

    -- We don't want the first frame's dt to include time taken by love.load.
    if love.timer then love.timer.step() end

    local dt = 0

    -- Main loop time.
    while true do
        -- Process events.
        if love.event then
            love.event.pump()
            for e,a,b,c,d in love.event.poll() do
                if e == "quit" then
                    if not Scene.quit() then
                        if not love.quit or not love.quit() then
                            if love.audio then
                                love.audio.stop()
                            end
                            return
                        end
                    end
                end
                love.handlers[e](a,b,c,d)
                Scene[e](a,b,c,d) -- handle scene event, if any
            end
        end

        -- Update dt, as we'll be passing it to update
        if love.timer then
            love.timer.step()
            dt = love.timer.getDelta()
        end

        -- Call update and draw
        if love.update then love.update(dt) end -- will pass 0 if love.timer is disabled
        Scene.update(dt) -- update current scene, if any

        if love.window and love.graphics and love.window.isCreated() then
            love.graphics.clear()
            love.graphics.origin()
            if love.draw then love.draw() end
            Scene.draw() -- draw current scene, if any
            love.graphics.present()
        end

        if love.timer then love.timer.sleep(0.001) end
    end
end