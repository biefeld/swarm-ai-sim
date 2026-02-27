function Background()
    local IMG  = love.graphics.newImage("assets/background.png")
    local MOVE_SPEED = 2

    return {
        x = 0,
        y = 0,
        -- x = -love.graphics.getWidth() / 8, --start middle of screenish
        -- y = -love.graphics.getHeight() / 8,


        draw = function(self) -- passing in self means we can access any vars/methods in the table
            love.graphics.setColor(1,1,1)
            love.graphics.draw(IMG, self.x, self.y, 0, 3, 3)
        end,

        move = function(self,dx,dy,v)
            if dx < 0 then
                self.x = self.x - v
            end
            if dx > 0 then
                self.x = self.x + v
            end
            if dy > 0 then
                self.y = self.y + v
            end
            if dy < 0 then
                self.y = self.y - v
            end
        end
    }
end

return Background