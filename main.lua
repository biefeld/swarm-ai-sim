local Player = require "objects.Player"
local Background = require "objects.Background"
local Enemy = require "objects.Enemy"
local Wall = require "objects.Wall"

_G.world = nil


function event_check()
    if love.keyboard.isDown("r") then
        love.load()
    end
end

function love.load()
    world = love.physics.newWorld(0, 0, true)

    player = Player()
    player:init()

    background = Background()
    -- enemy = Enemy()
    wall = Wall(200, 200, 30, 100, 0)
    wall:init()
end

function love.update(dt)
    world:update(dt)

    -- event_check()
    player:move() -- if the method has "self" as a parameter, must use colon
    dx,dy,v = -player.dx, -player.dy, player:get_v()
    
    
    -- if wall:collide(player.x, player.y, player.width, player.height) then
    --     dx, dy = 0, 0
    -- end
    
    background:move(dx, dy, v)
    wall:move(dx, dy, v)
    -- enemy:move(dt,dx,dy,v)
end

function love.draw()

    -- love.graphics.circle("line", ball.b:getX(),ball.b:getY(), ball.s:getRadius(), 20)
    -- love.graphics.polygon("line", static.b:getWorldPoints(static.s:getPoints()))

    -- background:draw()
    player:draw()
    -- enemy:draw()
    wall:draw()
end