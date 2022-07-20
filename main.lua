function love.load()
  playingAreaWidth = 300
  playingAreaHeight = 388
  
  birdX = 62
  birdY = 200
  birdWidth = 30
  birdHeight = 25
end

function love.draw()
  love.graphics.setColor(.14, .36, .46)
  love.graphics.rectangle('fill', 0, 0, playingAreaWidth, playingAreaHeight)
  
  love.graphics.setColor(.87, .84, .27)
  love.graphics.rectangle('fill', birdX, birdY, birdWidth, birdHeight)
end