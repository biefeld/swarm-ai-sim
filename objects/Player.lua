local Class = require "lib.30log"

Player = Class("Player")

local MASS = 100

function Player:init()
    -- Drawing fields
    self.sprite = love.graphics.newImage("assets/player.png")
    self.sprite_direction = 1

    -- Moving fields
    self.sprinting = false
    self.velocity = 500
    self.sprint_modifier = 2


    -- Physics fields
    -- setup body data (mass, location, dynamics); setup shape and fix to body
    self.body = love.physics.newBody(world, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, "dynamic")
    self.body:setFixedRotation(true)

    self.shape = love.physics.newCircleShape(25)

    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setUserData("Player")

    self.body:setMass(MASS) -- must do after all fixtures are attached
end


function Player:draw()
    -- love.graphics.setColor(0.2,0.5,0.1)
    -- love.graphics.circle("line", self.body:getX(),self.body:getY(), self.shape:getRadius()) -- if we want to have a sprite, dont draw this. draw the sprite instead, should be linked to the coordinates of the body too.
    love.graphics.setColor(1,1,1)
    love.graphics.draw(self.sprite,self.body:getX()-25*self.sprite_direction, self.body:getY()-25, 0, 0.15*self.sprite_direction, 0.15)
end

function Player:get_velocity()
    if self.sprinting then
        return self.velocity*self.sprint_modifier
    end
    return self.velocity
end


function Player:move()
    self.dx, self.dy = 0, 0

    self.sprinting = love.keyboard.isDown("lshift")

    if love.keyboard.isDown(Input.LEFT) then
        self.dx = self.dx - self:get_velocity()
    end
    if love.keyboard.isDown(Input.RIGHT) then
        self.dx = self.dx + self:get_velocity()
    end
    if love.keyboard.isDown(Input.DOWN) then
        self.dy = self.dy + self:get_velocity()
    end
    if love.keyboard.isDown(Input.UP) then
        self.dy = self.dy - self:get_velocity()
    end

    if self.dx > 0 then
        self.sprite_direction = 1
    elseif self.dx < 0 then
        self.sprite_direction = -1
    end

    self.body:setLinearVelocity(self.dx, self.dy)
end

return Player