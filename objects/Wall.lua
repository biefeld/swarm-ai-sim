local Class = require "lib.30log"

Wall = Class("Wall")

function Wall:init(_x, _y, _width, _height, _angle, _mass)
    self.body = love.physics.newBody(world, _x , _y, "static")
    self.body:setMass(_mass)
    self.shape = love.physics.newRectangleShape(0, 0, _width, _height, _angle)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setUserData("Wall")
end


function Wall:draw()
    love.graphics.setColor(1,0,0)
    love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end


return Wall