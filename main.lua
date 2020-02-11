-- include libraries
local sti = require 'libraries/sti'
local bump = require 'libraries/bump/bump'

function love.load()
  
  map = sti("assets/maps/map01.lua", {"bump"})
  world = bump.newWorld(32)
  map:bump_init(world) -- This initializes the bump plugin, and loads all of your collidable tiles
  
  
  -- add a player
  player = {
    x = 400,
    y = 300,
    w = 32,
    h = 64,
  }

  -- add player to bump
  world:add(player, player.x, player.y, player.w, player.h)
end

function love.update(dt)
  map:update(dt)
  
  local speed = 100
  local dx, dy = 0, 0

  if love.keyboard.isDown('right') then
    dx = speed * dt
  elseif love.keyboard.isDown('left') then
    dx = -speed * dt
  end
  if love.keyboard.isDown('down') then
    dy = speed * dt
  elseif love.keyboard.isDown('up') then
    dy = -speed * dt
  end

  if dx ~= 0 or dy ~= 0 then
    player.x, player.y, cols, cols_len = world:move(player, player.x + dx, player.y + dy)
  end
end

function love.draw()
  -- scale world
  local scale =  2
  local screen_width = love.graphics.getWidth() / scale
  local screen_height = love.graphics.getHeight() / scale

  local tx = math.floor(player.x -screen_width / 2)
  local ty = math.floor(player.y - screen_height / 2)
  
  map:draw(-tx, - ty, scale, scale)
  love.graphics.rectangle( "fill",player.x,player.y,player.w,player.h )
end
