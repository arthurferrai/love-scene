# love-scene

A very basic LÖVE scene manager.

# How to Use

Add included `main.lua` to your project folder. Then, `require "scene"` on every file you want to load a scene. By default, the first scene loaded is `scenes/main.lua`.

# Configuration

Customize first scene to load by editing `FIRST_SCENE` variable on `main.lua`.
By default, scenes are loaded from `scenes` folder of main folder. You can change it by editing `scenesFolder` variable.

# Defining a Scene

A scene file is a `.lua` file that returns a table with functions with the same name as LÖVE callbacks, plus `unload` (if needed). `load` will be called  on next scene when it's loaded, and `unload` will be called when the current scene is about to be unloaded.

### Example

```
require "scene" -- only needed to load another scene

local s = {} -- define the table that will be returned

function s.load() -- first function to be called by scene manager
    print "Scene loaded"
end

function s.unload() -- last function to be called by scene manager before unload
    print "Scene unloaded"
end

function s.draw() -- a LOVE callback
    love.graphics.print("Drawing scene",0,0)
end

function s.keypressed(key) -- another LOVE callback
    if key == "escape" then
        Scene.Load("anotherScene") -- will try to load "anotherScene.lua" on "scenes" folder
    end
end

return s -- this is important!
```

# Documentation

Every scene must return a table that contains LÖVE callbacks. Every callback is optional, just like `main.lua`.

## Scene.Load(name)

Unloads current scene (if any) by calling `unload` callback on current scene, loads the new scene (the `<name>.lua` file on "scenes" folder) and call `load` callback on the new scene. If `<name>.lua` doesn't exist, an error is raised.

### Parameters

* *name*: the scene file name, without `.lua` part (Example: if you want to load `main.lua` on `scenes` folder, you need to call `Scene.Load("main")`).

## Callbacks

Scene manager supports any callback that LÖVE supports, thanks to modified `love.run` inside included `main.lua`. Also, it supports `unload` callback, used to unload any resources that won't be used anymore on the current scene and the GC can't handle (like physics callbacks and anything like that).