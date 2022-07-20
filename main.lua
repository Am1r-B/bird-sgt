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
  
  -- a function that resets pipe 
  function newPipeSpaceY()
    local pipeSpaceYMin = 54
    -- random pipe Space location
    return love.math.random(
      pipeSpaceYMin,
      playingAreaHeight - pipeSpaceHeight - pipeSpaceYMin
    )
  end
  
  pipe1X = 100
  pipe1SpaceY = newPipeSpaceY()
  
  pipe2X = 200
  pipe2SpaceY = newPipeSpaceY()
end

function love.update(dt)
  -- bird falling down
  birdYSpeed = birdYSpeed + 516 * dt
  birdY = birdY + birdYSpeed * dt
  
  
  function movePipe(pipeX, pipeSpaceY)
    -- pipe moving to left
    pipeX = pipeX - 60 * dt
    
    if pipeX + pipeWidth < 0 then
      pipeX = playingAreaWidth
      pipeSpaceY = newPipeSpaceY()
    end
    
    return pipeX, pipeSpaceY
  end
  
  pipe1X, pipe1SpaceY = movePipe(pipe1X, pipe1SpaceY)
  pipe2X, pipe2SpaceY = movePipe(pipe2X, pipe2SpaceY)
  --[[
  -- if bird collide with the pipe
  if
  birdX < pipeX + pipeWidth
  and
  birdX + birdWidth > pipeX
  and (
    birdY < pipeSpaceY
    or
    birdY + birdHeight > pipeSpaceY + pipeSpaceHeight
  ) then
    love.load()
  end
  ]]--
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
  
  local function drawPipe(pipeX, pipeSpaceY)
    -- draw pipe
    love.graphics.setColor(.37, .82, .28)
    -- draw first segment
    love.graphics.rectangle(
      'fill',
      pipeX,
      0,
      pipeWidth,
      pipeSpaceY
    )
    -- draw second segment
    love.graphics.rectangle(
      'fill',
      pipeX,
      pipeSpaceY + pipeSpaceHeight,
      pipeWidth,
      playingAreaHeight - pipeSpaceY - pipeSpaceHeight
    )
  end
  
  drawPipe(pipe1X, pipe1SpaceY)
  drawPipe(pipe2X, pipe2SpaceY)
end