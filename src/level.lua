local Level = Class:extend()

local level

function Level:new(imgFileName)
  self:init(imgFileName)
end

function Level:init(imgFileName)
  imgFileName = self.filename or imgFileName
  self.filename = imgFileName
  local source = love.image.newImageData(imgFileName)
  self.width, self.height = source:getWidth() - 1, source:getHeight() - 1
  self.world = love.physics.newWorld(0, 9.81 * C.pixelRatio, true)
  self.world:setCallbacks(self.beginContact, self.endContact, self.preSolve, self.postSolve)
  self.levelTable = {}

  self.objects = {}

  for x = 0, self.width do
    self.levelTable[x] = {}
    for y = 0, self.height do
      r, g, b, a            = source:getPixel(x, y)
      self.levelTable[x][y] = { r, g, b }
    end
  end

  level = self
  self:addObjects()


end

--------------------------------------------------------------------------------------------------
function Level.beginContact(a, b, coll)


end

function Level.endContact(a, b, coll)

end

function Level.preSolve(a, b, coll)

end

function Level.postSolve(a, b, coll)
  local ad, bd = a:getUserData(), b:getUserData()
  --[[
  --- player contro barriere e goal
  if ad.type == "player" and bd.type == "barrier" then
    bd.remove = true

  elseif bd.type == "player" and ad.type == "barrier" then
    ad.remove = true
    --player contro enemy
  elseif ad.type == "player" and bd.type == "goal" then
    bd.remove = true
  elseif bd.type == "player" and ad.type == "goal" then
    ad.remove = true
    --player contro enemy
  elseif ad.type == "player" and bd.type == "enemy" then
    bd.remove = true
    --level:init()
  elseif bd.type == "player" and ad.type == "enemy" then
    ad.remove = true
    --  level:init()
  end
  ]]
end

------------------------------------------------------------------------------------------------
function Level:addObjects()
  local map = self.levelTable
  for x, v in ipairs(map) do
    for y, v1 in ipairs(v) do
      if type(map[x][y]) == "table" then
        if v1[1] == C.colors.ball[1] and v1[2] == C.colors.ball[2] and v1[3] == C.colors.ball[3] then
          local ball = Ball()
          ball:flood8(x, y, map)
          ball:consolidate(self.world)
          table.insert(self.objects, ball)
        elseif v1[1] == C.colors.staticObject[1] and v1[2] == C.colors.staticObject[2] and
            v1[3] == C.colors.staticObject[3] then
          local wall = StaticObject()
          wall:flood8(x, y, map)
          wall:consolidate(self.world)
          table.insert(self.objects, wall)
        elseif v1[1] == C.colors.spring[1] and v1[2] == C.colors.spring[2] and v1[3] == C.colors.spring[3] then
          local spring = Spring()
          spring:flood8(x, y, map)
          spring:consolidate(self.world)
          table.insert(self.objects, spring)
        end
      end

    end
  end
end

------------------------------------------------------------------------------------------------

function Level:draw()
  for k, v in ipairs(self.objects) do
    v:draw()
  end
end

-------------------------------------------------------------------------------
function Level:update(dt)
  self.world:update(dt)

  for k, v in ipairs(self.objects) do
    if v.remove == true then
      v.body:destroy()
      table.remove(self.objects, k)
    else
      v:update(dt)
    end
  end

end

return Level
