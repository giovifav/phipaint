C = {
  pixelRatio = 50,
  drawMode = "line",
  colors = {
    ball = { 0, 1, 1 },
    staticObject = { 1, 1, 1 },
    spring = { 1, 1, 0 },
    background = { 0, 0, 0 },
  },
}
------------------------------------------------------------------------------------------------------
Class = require("libs.classic")
require("libs.table")
Center = require("libs.center")
pprint = require("libs.pprint")
------------------------------------------------------------------------------------------------------
Object = require("src.object")
CircleObject = require("src.circleObject")
StaticObject = require("src.staticObject")
Ball = require("src.ball")
Spring = require("src.spring")
Level = require("src.level")
local level
------------------------------------------------------------------------------------------------------
function love.load()
  love.graphics.setDefaultFilter("nearest","nearest")
  love.physics.setMeter(C.pixelRatio)
  level = Level("test.png")
  Center:setupScreen(64 * C.pixelRatio, 64 * C.pixelRatio)
  love.graphics.setBackgroundColor(0, 0, 0, 1)
end
------------------------------------------------------------------------------------------------------
function love.draw()
  Center:start()
  love.graphics.translate(0.5 * C.pixelRatio, 0.5 * C.pixelRatio)
  level:draw()
  Center:finish()
end
------------------------------------------------------------------------------------------------------
function love.update(dt)
  level:update(dt)
end
------------------------------------------------------------------------------------------------------
function love.resize(width, height)
  Center:resize(width, height)
end
------------------------------------------------------------------------------------------------------