function love.load()
  playingAreaWidth = 300
  playingAreaHeight = 388
  
  birdX = 62
  birdY = 200
  birdWidth = 30
  birdHeight = 25
  birdYSpeed = 0
  
  pipeWidth = 54
  pipeSpaceHeight = 100
  local pipeSpaceYMin = 54
  pipeSpaceY = love.math.random(
    pipeSpaceYMin,
    playingAreaHeight - pipeSpaceHeight - pipeSpaceYMin)
end

function love.update(dt)
  -- bird falling down
  birdYSpeed = birdYSpeed + 516 * dt
  birdY = birdY + birdYSpeed * dt
end

-- executes when any key pressed
function love.keypressed()
  -- bird only flaps when its on the screen
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
  
  -- draw pipe
  love.graphics.setColor(.37, .82, .28)
  -- draw first segment
  love.graphics.rectangle(
    'fill',
    playingAreaWidth,
    0,
    pipeWidth,
    pipeSpaceY
  )
  -- draw second segment
  love.graphics.rectangle(
    'fill',
    playingAreaWidth,
    pipeSpaceY + pipeSpaceHeight,
    pipeWidth,
    playingAreaHeight - pipeSpaceY - pipeSpaceHeight
  )
end