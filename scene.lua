local scenesFolder = "scenes"

Scene = {}
local mt = 

setmetatable(Scene,{__index = function(t,k)
                                  if currentScene and type(currentScene[k]) == "function" then
                                      return currentScene[k]
                                  end
                                  return function() end
                              end})

function Scene.Load(name)
    if currentScene then Scene.unload() end
    local chunk = love.filesystem.load(scenesFolder.."/"..name..".lua")
    if not chunk then error("Attempt to load scene \"" .. name .. "\", but it was not found in \""..scenesFolder.."\" folder.", 2) end
    currentScene = chunk()
    collectgarbage()
    Scene.load()
end