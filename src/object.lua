local Object = Class:extend()
------------------------------------------------------------------------------------------------------
function Object:new()
  self.type = "basicObject"
  self.r = 0
  self.g = 0
  self.b = 0
  self.table = {}
  self.physicType = "dynamic"
  self.remove = false
  self.fixedRotation = false
  self.friction = 0
  self.restitution = 0.5
  self.density = 50
end
------------------------------------------------------------------------------------------------------
function Object:addPixel(x,y)
  
  table.insert(self.table,{x , y })
end
------------------------------------------------------------------------------------------------------
function Object:consolidate(world)
  local minX, minY, maxX, maxY = nil, nil, nil, nil
  for k, v in ipairs(self.table) do
    if minX == nil then minX = v[1] end
    if maxX == nil then maxX = v[1] end
    if minY == nil then minY = v[2] end
    if maxY == nil then maxY = v[2] end
    if v[1] <= minX then minX = v[1] end
    if v[1] >= maxX then maxX = v[1] end
    if v[2] <= minY then minY = v[2] end
    if v[2] >= maxY then maxY = v[2] end
  end
  self.width = maxX - minX +1
  self.height = maxY - minY +1 
  self.minX, self.minY = minX, minY
  self.x, self.y = minX + self.width/2* C.pixelRatio, minY + self.height/2* C.pixelRatio
  self:createBodies(world)
end
------------------------------------------------------------------------------------------------------
function Object:createBodies(world)
  self.body = love.physics.newBody(world,self.x, self.y, self.physicType)
  --self.body:setFixedRotation(self.fixedRotation)
  self.shapes = {}
  for k, v in ipairs(self.table) do
    local fx, fy = v[1]* C.pixelRatio - self.x, v[2]* C.pixelRatio - self.y
    local shape = love.physics.newRectangleShape(fx,fy, C.pixelRatio, C.pixelRatio,0)
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
function Object:draw()
  love.graphics.setColor(self.r,self.g,self.b)
  for k,v in ipairs(self.shapes) do
    love.graphics.polygon(C.drawMode, self.body:getWorldPoints(v:getPoints()))
  end
end
------------------------------------------------------------------------------------------------------
function Object:update(dt)
end
------------------------------------------------------------------------------------------------------
function Object:flood8(x, y, map)
  local width = table.count(map)
  local height = table.count(map[1])
  if x < width and x >= 0 and y < height and y >= 0 then
    if type(map[x][y]) == "table" then
        if map[x][y][1] == self.r and map[x][y][2] == self.g and map[x][y][3] == self.b   then
          self:addPixel(x, y)
          map[x][y] = {0,0,0}
          self:flood8(x+1,y,map)
          self:flood8(x-1,y,map)
          self:flood8(x,y+1,map)
          self:flood8(x,y-1,map)
          self:flood8(x+1,y+1,map)
          self:flood8(x+1,y-1,map)
          self:flood8(x-1,y+1,map)
          self:flood8(x-1,y-1,map)
        end
    end
  end
end
------------------------------------------------------------------------------------------------------
function Object:isPixel(x,y)
  for k, v in pairs(self.table) do
    if v [1] == x and v[2] == y then
      return true
    end
  end
end
------------------------------------------------------------------------------------------------------
return Object
