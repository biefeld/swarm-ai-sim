function Wall(_x, _y, _width, _height)
    return {
        x = _x,
        y = _y,
        height = _height,
        width = _width,



        draw = function(self) -- passing in self means we can access any vars/methods in the table
            love.graphics.setColor(0.5,1,1)
            love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
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
        end,

        collide = function(self, x, y, width, height)
            return self.x < x + width and
         x < self.x+self.width and
         self.y < y+height and
         y < self.y+self.height
        end
    }
end

return Wall