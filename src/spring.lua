
local spring = CircleObject:extend()
------------------------------------------------------------------------------------------------------
function spring:new()
  spring.super.new(self)
  self.type = "spring"
  self.r = C.colors.spring[1]
  self.g = C.colors.spring[2]
  self.b = C.colors.spring[3]
  self.physicType = "static"
  self.restitution = 1.5
end
------------------------------------------------------------------------------------------------------
return spring