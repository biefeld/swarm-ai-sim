function Wall(_x, _y, _width, _height, _angle)
    return {
        body,
        shape,
        fixture,

        x = _x,
        y = _y,
        height = _height,
        width = _width,
        angle = _angle,
        mass = 0,

        init = function(self)
            self.body = love.physics.newBody(world, self.x,self.y, "dynamic")
            self.body:setMass(self.mass)
            self.shape = love.physics.newRectangleShape(self.x, self.y, self.width, self.height, self.angle)
            self.fixture = love.physics.newFixture(self.body, self.shape)
            self.fixture:setUserData("Wall")
            self.body:setAngularDamping(math.huge)
        end,


        draw = function(self) -- passing in self means we can access any vars/methods in the table
            love.graphics.setColor(0.5,1,1)
	        love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
        end,

        move = function(self,dx,dy,v)
            self.body:setLinearVelocity(dx, dy)

            -- if dx < 0 then
            --     self.body:applyLinearImpulse(dx, dy)
            --     -- self.body:setX(self.body:getX() - v)
            -- end
            -- if dx > 0 then
            --     -- self.body:setX(self.body:getX() + v)
            -- end
            -- if dy > 0 then
            --     self.body:applyLinearImpulse(dx, dy)
            --     -- self.body:setY(self.body:getY() + v)
            -- end
            -- if dy < 0 then
            --     self.body:applyLinearImpulse(dx, dy)
            --     -- self.body:setY(self.body:getY() - v)
            -- end
        end,
    }
end

return Wall