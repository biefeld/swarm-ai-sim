function Enemy()
    local HEIGHT = 30
    local WIDTH = 30
    local MOVE_SPEED = 2
    local CYCLE_TIME = 2

    return {
        x = love.graphics.getWidth() - 400, --start middle of screenish
        y = love.graphics.getHeight() - 300,
        timer = 0,
        moving_right = 1,


        draw = function(self) -- passing in self means we can access any vars/methods in the table
            love.graphics.setColor(1,0.1,0.1)
            love.graphics.rectangle("fill", self.x, self.y, HEIGHT, WIDTH)
        end,

        move = function(self,dt,dx,dy,v)
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

            if self.timer < CYCLE_TIME then
                self.x = self.x + MOVE_SPEED*self.moving_right
            else
                self.timer = 0
                self.moving_right = self.moving_right * -1
            end

            self.timer = self.timer + dt
        end
    }
end

return Enemy