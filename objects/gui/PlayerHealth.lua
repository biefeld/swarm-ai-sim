local Class = require "lib.30log"

Life = Class("Life")

function Life:init()
    self.health = 0
end

function Life:update_health(n)
    self.health = n
end

function Life:draw()
    love.graphics.setColor(0.7,0.7,0)
    love.graphics.rectangle("line", 500,800,500,50)
    love.graphics.rectangle("fill",500,800,500*self.health/100,50)

    -- love.graphics.print("Health:"..self.health.."%",800,800,0,5,5)
end


return Life