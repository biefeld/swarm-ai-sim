function Player()
    local MOVE_SPEED = 500
    local SPRINT_MODIFIER = 2

    return {
        body, --metadata about the Player (that its dynamic, position, velocity etc)
        shape, --the actual shape which can collide with things
        fixture, --links the two above together

        x = love.graphics.getWidth() / 2,
        y = love.graphics.getHeight() / 2,
        radius = 25,
        mass = -1,
        sprinting = false,

        init = function(self)
            self.body = love.physics.newBody(world, self.x,self.y, "static")
            self.body:setMass(self.mass)
            self.shape = love.physics.newCircleShape(self.radius)
            self.fixture = love.physics.newFixture(self.body, self.shape)
            self.fixture:setUserData("Player")
        end,

        draw = function(self)
            love.graphics.setColor(0.2,0.5,0.1)
            love.graphics.circle("line", self.body:getX(),self.body:getY(), self.shape:getRadius(), 20)
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

return Player