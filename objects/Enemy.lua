local Class = require "lib.30log"

Enemy = Class("Enemy")

--- Initialize enemy entity
---@param _x number
---@param _y number
---@param _angle number
---@param _mass number
---@param _velocity number
---@param _cycle_time number
---@param _name string
---@param _rgb {number, number, number}
---@param _sprite_name string
function Enemy:init(_x, _y, _angle, _mass, _velocity, _cycle_time, _name, _rgb, _sprite_name)
    -- Drawing fields
    self.sprite = love.graphics.newImage("assets/".._sprite_name)
    self.sprite_direction = 1
    self.rgb = _rgb

    -- Movement fields
    self.velocity = _velocity
    self.moving = {
        {1, 0},
        {-1, 0}
    }
    self.cycle_time = _cycle_time
    self.timer = 0
    self.cycle = 1
    
    -- Physics fields 
    self.body = love.physics.newBody(world, _x , _y, "dynamic")
    self.body:setFixedRotation(true) --body cannot rotate?

    self.shape = love.physics.newRectangleShape(0, 0, self.sprite:getWidth(), self.sprite:getHeight(), _angle)
    
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setUserData(_name)
    self.fixture:setCategory(Category.ENEMY) -- Part of ENEMY category
    self.fixture:setMask(Category.ENEMY) -- Cannot collide with ENEMY entities

    self.body:setMass(_mass)
end

function Enemy:draw()
    love.graphics.setColor(unpack(self.rgb))
    x_offset,y_offset = self.shape:getPoints()
   
    love.graphics.draw(
        self.sprite,
        self.body:getX() + x_offset*self.sprite_direction, -- x coord
        self.body:getY() + y_offset, -- y coord
        0, -- angle
        1*self.sprite_direction, --x scaling
        1 --y scaling
    )

    -- debug hitbox
    -- love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
end


function Enemy:move(dt)
    self.dx, self.dy = 0, 0

    if self.timer >= self.cycle_time then
        self.cycle = self.cycle % #self.moving + 1
        self.timer = 0
    end

    self.dx = self.dx + self.velocity*self.moving[self.cycle][1]
    self.dy = self.dy + self.velocity*self.moving[self.cycle][2]

    if self.dx > 0 then
        self.sprite_direction = 1
    elseif self.dx < 0 then
        self.sprite_direction = -1
    end

    self.body:setLinearVelocity(self.dx, self.dy)

    self.timer = self.timer + dt
end


return Enemy