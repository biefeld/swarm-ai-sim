local Class = require "lib.30log"

Enemy = Class("Enemy")

local CYCLE_TIME = 2

function Enemy:init(_x, _y, _width, _height, _angle, _mass, _name)
    self.body = love.physics.newBody(world, _x , _y, "dynamic")
    self.body:setFixedRotation(true) --body cannot rotate?
    self.body:setMass(_mass)
    self.shape = love.physics.newRectangleShape(_x, _y, _width, _height, _angle)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setUserData(_name)

    self.velocity = 300
    self.moving = {
        {1, 0},
        {-1, 0}
    }
    self.timer = 0
    self.cycle = 1
end

function Enemy:draw()
    love.graphics.setColor(1,0.1,0.1)
    love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end


function Enemy:move(dt)
    self.dx, self.dy = 0, 0

    if self.timer >= CYCLE_TIME then
        self.cycle = self.cycle % #self.moving + 1
        self.timer = 0
    end

    self.dx = self.dx + self.velocity*self.moving[self.cycle][1]
    self.dy = self.dy + self.velocity*self.moving[self.cycle][2]

    self.body:setLinearVelocity(self.dx, self.dy)

    self.timer = self.timer + dt
end

return Enemy