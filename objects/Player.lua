
-- acts as an object
-- return a table which contains public methods and attr 
-- any local ones count as private
function Player()
    local MOVE_SPEED = 5
    local SPRINT_MODIFIER = 2

    return {
        x = love.graphics.getWidth() / 2, --start middle of screenish, dont change this but move the rest of the entities
        y = love.graphics.getHeight() / 2,
        width = 50,
        height = 50,
        dx = 0,
        dy = 0,
        sprinting = false,

        draw = function(self) -- passing in self means we can access any vars/methods in the table
            love.graphics.setColor(0.2,0.5,0.1)
            love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
        end,

        move = function(self)
            self.dx, self.dy = 0, 0

            if love.keyboard.isDown("lshift") then
                self.sprinting = true
            else
                self.sprinting = false
            end

            if love.keyboard.isDown("a") then
                self.dx = self.dx - MOVE_SPEED
            end
            if love.keyboard.isDown("d") then
                self.dx = self.dx + MOVE_SPEED
            end
            if love.keyboard.isDown("s") then
                self.dy = self.dy + MOVE_SPEED
            end
            if love.keyboard.isDown("w") then
                self.dy = self.dy - MOVE_SPEED
            end
        end,

        get_v = function(self)
            if self.sprinting then
                return MOVE_SPEED*SPRINT_MODIFIER
            end
            return MOVE_SPEED
        end

    }
end

-- Must have this here
return Player