function love.load()
  playingAreaWidth = 300
  playingAreaHeight = 388
  
  birdX = 62
  birdY = 200
  birdWidth = 30
  birdHeight = 25
  birdYSpeed = 0
end

function love.update(dt)
  birdYSpeed = birdYSpeed + 516 * dt
  birdY = birdY + birdYSpeed * dt
end

function love.keypressed()
  if birdY > 0 then
    birdYSpeed = -165
  end
end

function love.draw()
  -- draw background
  love.graphics.setColor(.14, .36, .46)
  love.graphics.rectangle('fill', 0, 0, playingAreaWidth, playingAreaHeight)
  
  -- draw bird
  love.graphics.setColor(.87, .84, .27)
  love.graphics.rectangle('fill', birdX, birdY, birdWidth, birdHeight)
end