function love.load()
    playareaWidth = 300
    playareaHeight = 388
    pipeWidth = 30
    pipeMin = 30
    pipeMax = playareaHeight - 30
    birdX = 62
    birdY = 200
    birdYspeed = 0
    
    resetPipe()
end

function love.update(dt)
    birdY = birdY + (birdYspeed * dt)
    birdYspeed = birdYspeed + (516 * dt)
    pipeX = pipeX - (80 * dt)
    spaceBeginX = spaceBeginX - (80 * dt)
    if pipeX + pipeWidth < 0 then
        resetPipe()
    end
    if birdX + pipeWidth > spaceBeginX and birdX < spaceBeginX + pipeWidth and birdY < spaceBeginY then
        resetPipe()
    elseif birdX + pipeWidth > spaceBeginX and birdX + pipeWidth < spaceBeginX + pipeWidth and birdY + pipeWidth > spaceBeginY + spaceHeight then
        resetPipe()
    end
end

function love.draw()
    love.graphics.setColor(.14, .36, .46)
    love.graphics.rectangle('fill', 0, 0, playareaWidth, playareaHeight)

    love.graphics.setColor(.87, .84, .27)
    love.graphics.rectangle('fill', birdX, birdY, pipeWidth, 25)
    
    love.graphics.setColor(.2, .8, .1)
    love.graphics.rectangle('fill', pipeX, 0, pipeWidth, playareaHeight)

    love.graphics.setColor(.28, .28, .28)
    love.graphics.rectangle('fill', spaceBeginX, spaceBeginY, pipeWidth, spaceHeight)
end

function resetPipe()
    pipeX = playareaWidth - pipeWidth
    spaceBeginX = playareaWidth - pipeWidth
    spaceBeginY = love.math.random(pipeMin, pipeMax)
    spaceHeight = 85
end

function love.keypressed(space)
    if birdY > 0 then
        birdYspeed = -165
    end
end