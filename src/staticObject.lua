local staticObject = Object:extend()

function staticObject:new()
  staticObject.super.new(self)
  self.type = "staticObject" 
  self.r = C.colors.staticObject[1]
  self.g = C.colors.staticObject[2]
  self.b = C.colors.staticObject[3]
  self.physicType = "static"

end



return staticObject