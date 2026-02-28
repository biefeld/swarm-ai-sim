local Class = require "lib.30log"

Player = Class("Player")

local MASS = 100

function Player:init()
    self.sprinting = false
    self.velocity = 500
    self.sprint_modifier = 2

    -- setup body data (mass, location, dynamics); setup shape and fix to body
    self.body = love.physics.newBody(world, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, "dynamic")
    self.body:setMass(self.mass)
    self.shape = love.physics.newCircleShape(25)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setUserData("Player")
end


function Player:draw()
    love.graphics.setColor(0.2,0.5,0.1)
    love.graphics.circle("line", self.body:getX(),self.body:getY(), self.shape:getRadius())
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

    if love.keyboard.isDown("a") then
        self.dx = self.dx - self:get_velocity()
    end
    if love.keyboard.isDown("d") then
        self.dx = self.dx + self:get_velocity()
    end
    if love.keyboard.isDown("s") then
        self.dy = self.dy + self:get_velocity()
    end
    if love.keyboard.isDown("w") then
        self.dy = self.dy - self:get_velocity()
    end

    self.body:setLinearVelocity(self.dx, self.dy)
end

return Player