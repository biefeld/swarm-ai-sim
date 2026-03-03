local Player = require "objects.Player"
local Background = require "objects.Background"
local Enemy = require "objects.Enemy"
local Swarm = require "objects.Swarm"
local Wall = require "objects.Wall"
local PlayerHealth = require "objects.gui.PlayerHealth"

local Camera = require "lib.camera"
local json = require "lib.json"

local Category = require "enum.category"
local Input = require "enum.input"

-- Required objects
world = nil
camera = nil
math.randomseed(os.time())

swarm_points = json.decode(io.open("db/swarm_points.json", "r"):read("*all"))
wall_points = json.decode(io.open("db/wall.json", "r"):read("*all"))


function love.keypressed(key, scancode, isrepeat)
   if key == "r" then
        love.load()
   end
   if key == "q" then
        love.event.quit() 
    end
    if key == "p" then
        game.paused = not game.paused
    end
end

function love.load()
    world = love.physics.newWorld(0, 0, true)
    world:setCallbacks(begin_contact, end_contact, _, _)

    game = {
        paused = false,
        alive = true,
        debug_text = ""
    }


    camera = Camera()
    background = Background()
    gui = {
        player_health = PlayerHealth()
    }

    player = Player(gui.player_health)

    swarm = {
        swarm_1 = Swarm({
        {400, 700, 50, 200, "SwarmEnemySalmon1", {1,0.5,0.5}, "salmon.png"},
        {400, 700, 50, 200, "SwarmEnemySalmon2", {0.5,1,0.5}, "salmon.png"},
        {400, 700, 50, 200, "SwarmEnemySalmon3", {0.5,0.5,1}, "salmon.png"}
        }),
        swarm_2 = Swarm(Swarm:generate(unpack(swarm_points[1]))),
        swarm_3 = Swarm(Swarm:generate(unpack(swarm_points[2])))
    }

    wall = {
        left = Wall(unpack(wall_points[1])),
        right = Wall(unpack(wall_points[2])),
        top = Wall(unpack(wall_points[3])),
        bottom = Wall(unpack(wall_points[4]))
    }

end

function love.update(dt)
    if game.paused or not game.alive then return end

    world:update(dt)

    player:move() -- if the method has "self" as a parameter, must use colon
    camera:lockPosition(player.body:getX(), player.body:getY())
    
    for _, s in pairs(swarm) do
        s:move(dt)
    end
end

function love.draw()
    camera:attach()

    background:draw()
    player:draw()
    
    for _, v in pairs(wall) do
        v:draw()
    end

      for _, s in pairs(swarm) do
        s:draw(dt)
    end

    camera:detach()

    -- stationary on screen: good for UI elements
    love.graphics.setColor(0,0.5,1)
    love.graphics.print(game.debug_text, 0, 0, 0, 2, 2)
    
    for _,v in pairs(gui) do
        v:draw()
    end
end



-- Investigating collision callbacks

function is_damaging(id_a, id_b)
    return (id_a:find("^Player") ~= nil and id_b:find("^SwarmEnemy") ~= nil) or
           (id_b:find("^Player") ~= nil and id_a:find("^SwarmEnemy") ~= nil)
end

-- function is_detecting(id_a, id_b)
--     return (id_a:find("^Player") ~= nil and id_b:find("^Detection") ~= nil) or
--            (id_b:find("^Player") ~= nil and id_a:find("^Detection") ~= nil)
-- end

function begin_contact(a, b, coll)
    local id_a = a:getUserData()
	local id_b = b:getUserData()

   game.debug_text = game.debug_text..id_a.." colliding with "..id_b.."\n"
    if is_damaging(id_a, id_b) then
        player:take_damage()
        game.debug_text = game.debug_text.."Damage interaction\n"
    end


    if player.health <= 0 then
        game.debug_text = game.debug_text.."player dead\n"
        game.paused = true
        game.alive = false
    end
end

function end_contact(a, b, coll)
	local id_a = a:getUserData()
	local id_b = b:getUserData()
    game.debug_text = game.debug_text..id_a.." uncolliding with "..id_b.."\n"
end