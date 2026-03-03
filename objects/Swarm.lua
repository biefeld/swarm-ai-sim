local Class = require "lib.30log"

--- A collection of Enemy entities. 
--- Each Enemy in the swarm requires (in order):
---@param _x number
---@param _y number
---@param _angle number
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


return Swarm