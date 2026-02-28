local Player = require "objects.Player"
local Background = require "objects.Background"
local Enemy = require "objects.Enemy"
local Wall = require "objects.Wall"

local Camera = require "lib.camera"

world = nil

function love.keypressed(key, scancode, isrepeat)
   if key == "r" then
        love.load()
   end
   if key == "q" then
        love.event.quit() 
    end
end


function love.load()
    world = love.physics.newWorld(0, 0, true)
    camera = Camera()

    player = Player()

    background = Background()
    enemy = Enemy(400, 400, 50, 50, 0, 50, "Enemy")
    wall = Wall(200, 200, 30, 100, 0, 100)
end

function love.update(dt)
    world:update(dt)

    player:move() -- if the method has "self" as a parameter, must use colon
        
    camera:lockPosition(player.body:getX(), player.body:getY())
    enemy:move(dt)
end

function love.draw()
    camera:attach()

    background:draw()
    player:draw()
    enemy:draw()
    wall:draw()

    camera:detach()
end