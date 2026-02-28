local Class = require "lib.30log"

Background = Class("Background")

function Background:init()
    self.img = love.graphics.newImage("assets/background.png")
end

function Background:draw()
    love.graphics.setColor(1,1,1)
    love.graphics.draw(self.img, 0, 0, 0, 3, 3)
end

return Background