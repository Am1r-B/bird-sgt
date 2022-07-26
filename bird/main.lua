function love.load()
  playingAreaWidth = 300
  playingAreaHeight = 388
  
  birdX = 62
  birdWidth = 30
  birdHeight = 25
  
  pipeWidth = 54
  pipeSpaceHeight = 100
  
  -- a function that gives new pipeSpaceY to pipe 
  function newPipeSpaceY()
    local pipeSpaceYMin = 54
    -- random pipe Space location
    return love.math.random(
      pipeSpaceYMin,
      playingAreaHeight - pipeSpaceHeight - pipeSpaceYMin
    )
  end
  
  function reset()
    birdY = 200
    birdYSpeed = 0
    
    pipe1X = playingAreaWidth
    pipe1SpaceY = newPipeSpaceY()
    
    pipe2X = playingAreaWidth + (playingAreaWidth + pipeWidth)/2
    pipe2SpaceY = newPipeSpaceY()
    
    score = 0
    
    upcomingPipe = 1
  end

  reset()
end

function love.update(dt)
  -- bird falling down
  birdYSpeed = birdYSpeed + 516 * dt
  birdY = birdY + birdYSpeed * dt
  
  local function movePipe(pipeX, pipeSpaceY)
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
  
  function isBirdCollidingWithPipe(pipeX, pipeSpaceY)
    -- if bird collide with the pipe
    return
    birdX < pipeX + pipeWidth
    and
    birdX + birdWidth > pipeX
    and (
      birdY < pipeSpaceY
      or
      birdY + birdHeight > pipeSpaceY + pipeSpaceHeight
    )
  end
  
  if isBirdCollidingWithPipe(pipe1X, pipe1SpaceY)
  or isBirdCollidingWithPipe(pipe2X, pipe2SpaceY) 
  or birdY > playingAreaHeight then
    reset()
  end
  
  local function updateScoreAndClosestPipe(thisPipe, pipeX, otherPipe)
    if upcomingPipe == thisPipe
    and birdX > pipeX + pipeWidth then 
      score = score + 1
      upcomingPipe = otherPipe
    end
  end
  
  updateScoreAndClosestPipe(1, pipe1X, 2)
  updateScoreAndClosestPipe(2, pipe2X, 1)
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
  
  -- draw pipes
  drawPipe(pipe1X, pipe1SpaceY)
  drawPipe(pipe2X, pipe2SpaceY)
  
  -- draw score
  love.graphics.setColor(1, 1, 1)
  love.graphics.print(score, 15, 15)
end