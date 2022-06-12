local ball = CircleObject:extend()

function ball:new()
  ball.super.new(self)
  self.type = "ball"
  self.r = C.colors.ball[1]
  self.g = C.colors.ball[2]
  self.b = C.colors.ball[3]
  self.physicType = "dynamic"
end

return ball