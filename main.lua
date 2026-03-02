local Player = require "objects.Player"
local Background = require "objects.Background"
local Enemy = require "objects.Enemy"
local Swarm = require "objects.Swarm"
local Wall = require "objects.Wall"

local Camera = require "lib.camera"

local Category = require "enum.category"
local Input = require "enum.input"

-- Required objects
world = nil
camera = nil

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
    swarm = Swarm({
        {400, 700, 0, 50, 300, 2, "SwarmEnemy1", {1,0.5,0.5}, "salmon.png"},
        {600, 700, 0, 50, 100, 1, "SwarmEnemy2", {0.5,1,0.5}, "salmon.png"},
        {300, 700, 0, 50, 400, 2.5, "SwarmEnemy3", {0.5,0.5,1}, "salmon.png"}
    })

    wall = Wall(200, 200, 30, 100, 0, 100)
end

function love.update(dt)
    world:update(dt)

    player:move() -- if the method has "self" as a parameter, must use colon
    camera:lockPosition(player.body:getX(), player.body:getY())
    swarm:move(dt)
end

function love.draw()
    camera:attach()

    background:draw()

    -- Maybe think about adding entities to thier own namespace and
    -- Then only having to call one draw() function
    -- then do Entities:draw() iterate over each draw function like swarms end
    -- Maybe same with move()
    player:draw()
    wall:draw()
    swarm:draw()

    camera:detach()
end