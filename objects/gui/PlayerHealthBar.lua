local Class = require "lib.30log"

PlayerHealthBar = Class("PlayerHealthBar")

function PlayerHealthBar:init()
    self.health = 0
end

function PlayerHealthBar:update_health(n)
    self.health = n
end

function PlayerHealthBar:draw()
    love.graphics.setColor(0.7,0.7,0)
    love.graphics.rectangle("line", 500,800,500,50)
    love.graphics.rectangle("fill",500,800,500*self.health/100,50)
end


return PlayerHealthBar