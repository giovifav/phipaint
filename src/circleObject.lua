local circleObject = Object:extend()
------------------------------------------------------------------------------------------------------
function circleObject:new()
    circleObject.super.new(self)
end
------------------------------------------------------------------------------------------------------
function circleObject:createBodies(world)
    self.body = love.physics.newBody(world, self.x, self.y, self.physicType)
    self.shapes = {}
    for k, v in ipairs(self.table) do
        local fx, fy = v[1] * C.pixelRatio - self.x, v[2] * C.pixelRatio - self.y
        local shape = love.physics.newCircleShape(fx, fy, C.pixelRatio)
        local fixture = love.physics.newFixture(self.body, shape)
        fixture:setFriction(self.friction)
        fixture:setUserData(self)
        fixture:setRestitution(self.restitution)
        fixture:setDensity(self.density)
        table.insert(self.shapes, shape)
    end
    self.table = nil
end
------------------------------------------------------------------------------------------------------
function circleObject:draw()
    love.graphics.setColor(self.r, self.g, self.b)
    for k, v in ipairs(self.shapes) do
        local x, y = self.body:getWorldPoints(v:getPoint())
        love.graphics.circle(C.drawMode, x, y, C.pixelRatio)
    end
end
------------------------------------------------------------------------------------------------------
return circleObject
