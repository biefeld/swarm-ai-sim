local Class = require "lib.30log"

--- A collection of Enemy entities. 
--- Each Enemy in the swarm requires (in order):
---@param _x number
---@param _y number
---@param _mass number
---@param _speed number
---@param _name string
---@param _rgb {number, number, number}
---@param _sprite_name string
Swarm = Class("Swarm")

--- Create _number Enemy entities given 2D table of _data
---@param self Swarm
---@param _data table
function Swarm:init(_data)
    self.enemy_table = {}
    for i = 1, #_data, 1 do
        -- io.write("Generating enemy " .. i .. " with data: ")
        -- print(unpack(_data[i]))
        table.insert(self.enemy_table, Enemy(unpack(_data[i]))) -- unpack does {a, b, c} -> a, b, c; allows table to be passed in nicely as seperate function args
    end
end

function Swarm:get_enemy(_idx)
    return self.enemy_table[_idx]
end

function Swarm:draw()
    -- table.foreach(self.enemy_table, function(x) x:draw() end)
    -- this works but i think is slower... and is obscured

    for i = 1, #self.enemy_table, 1 do
        self.enemy_table[i]:draw()
    end
end


function Swarm:move(dt)
    for i = 1, #self.enemy_table, 1 do
        self.enemy_table[i]:move(dt)
    end
end

-- Generates a Swarm of number Enemy entities
-- Random rgb values, random location within circle of origin and radius
function Swarm:generate(number, origin, radius, mass, speed, sprite_name)
    data = {}
    for i = 1, number, 1 do
        x = (math.random(radius) * (math.random(0,1) * 2 - 1))
        y = (math.random(math.floor(math.sqrt(radius^2 - x^2))) * (math.random(0,1) * 2 - 1))
        rgb = {math.random(255)/255, math.random(255)/255, math.random(255)/255}
        name = "SwarmEnemy"..i.."RandomGen"
        entry = {x+origin[1],y+origin[2],mass,speed,name,rgb,sprite_name}
        table.insert(data, entry)
    end
    return data
end

return Swarm