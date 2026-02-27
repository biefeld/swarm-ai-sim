local Player = require "objects.Player"
local Background = require "objects.Background"
local Enemy = require "objects.Enemy"
local Wall = require "objects.Wall"


function event_check()
    if love.keyboard.isDown("r") then
        love.load()
    end
end

function love.load()
    player = Player()
    background = Background()
    enemy = Enemy()
    wall = Wall(20, 20, 30, 100)
end

function love.update(dt)
    event_check()
    player:move() -- if the method has "self" as a parameter, must use colon
    dx,dy,v = -player.dx, -player.dy, player:get_v()
    
    
    if wall:collide(player.x, player.y, player.width, player.height) then
        dx, dy = 0, 0
    end
    
    background:move(dx, dy, v)
    wall:move(dx, dy, v)
    enemy:move(dt,dx,dy,v)
end

function love.draw()
    background:draw()
    player:draw()
    enemy:draw()
    wall:draw()
end