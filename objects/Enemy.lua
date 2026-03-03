local Class = require "lib.30log"

Enemy = Class("Enemy")

--- Initialize enemy entity
---@param _x number
---@param _y number
---@param _mass number
---@param _speed number
---@param _name string
---@param _rgb {number, number, number}
---@param _sprite_name string
function Enemy:init(_x, _y, _mass, _speed, _name, _rgb, _sprite_name)
    -- Drawing fields
    self.sprite = love.graphics.newImage("assets/".._sprite_name)
    self.rgb = _rgb

    -- Movement fields
    self.speed = _speed
    self.moving = {1,1}
    self.cycle_time = 0.0
    self.timer = 0.0
    
    -- Physics fields 
    self.body = love.physics.newBody(world, _x , _y, "dynamic")
    self.body:setFixedRotation(true) --body cannot rotate?

    self.shape = love.physics.newRectangleShape(0, 0, self.sprite:getWidth(), self.sprite:getHeight(), 0)
    
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setUserData(_name)
    self.fixture:setCategory(Category.ENEMY) -- Part of ENEMY category
    self.fixture:setMask(Category.ENEMY) -- Cannot collide with ENEMY entities

    self.body:setMass(_mass)
end

function Enemy:draw()
    love.graphics.setColor(unpack(self.rgb))
    x_offset,y_offset = self.shape:getPoints()
   
    -- doesn't fit perfectly into hitbox at the moment
    love.graphics.draw(
        self.sprite,
        self.body:getX() + x_offset*self.moving[1], -- x coord
        self.body:getY() + y_offset, -- y coord
        self.body:getAngle(), -- angle
        self.moving[1], --x scaling
        1 --y scaling
    )

    -- debug hitbox
    -- love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
end


function Enemy:move(dt)
    --[[
    Easy random movement
    1. After last cycle has finished: Choose a random point in space
    2. Choose a random curved-path to take - parameterised by sin/cos or smth
    3. Move (takes random time to do so based on above - calc before and set to cycle_time)
    ]]--

    if self.timer >= self.cycle_time then
        self.timer = 0.0

        self.dx, self.dy =  math.random(200,800),  math.random(0,100)
        self.moving = {math.random(0,1) * 2 - 1, math.random(0,1) * 2 - 1}
        r = math.sqrt(self.dx^2 + self.dy^2)

        time = r / self.speed
        self.cycle_time = time

        self.vx = self.dx/time*self.moving[1]
        self.vy = self.dy/time*self.moving[2]

        angle = math.atan2(self.vy, self.vx)
        if math.abs(angle) > math.pi/2 then
            angle = -math.pi + angle
        end

        self.body:setAngle(angle)

        -- print(self.dx, self.dy, self.body:getX(), self.body:getY(), r, time)
        -- print(self.vx, self.vy)
    end

    self.body:setLinearVelocity(self.vx, self.vy)

    self.timer = self.timer + dt
end


return Enemy