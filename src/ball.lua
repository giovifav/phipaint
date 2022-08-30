local ball = CircleObject:extend()
------------------------------------------------------------------------------------------------------
function ball:new()
  ball.super.new(self)
  self.type = "ball"
  self.r = C.colors.ball[1]
  self.g = C.colors.ball[2]
  self.b = C.colors.ball[3]
  self.physicType = "dynamic"
  self.fixedRotation = false
  self.friction = 10
  self.restitution = 0.01
  self.density = 50
  self.maxSpeed = 1000
end
------------------------------------------------------------------------------------------------------
function ball:update(dt)
  local x, y = self.body:getLinearVelocity( )
  if x  > self.maxSpeed  then
    self.body:setLinearVelocity(self.maxSpeed, y)
  elseif y > self.maxSpeed then
    self.body:setLinearVelocity(x, self.maxSpeed)
  end
  
end
------------------------------------------------------------------------------------------------------
return ball