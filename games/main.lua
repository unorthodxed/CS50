function love.load()
    birdY = 200
    birdYspeed = 0
end

function love.update(dt)
    birdY = birdY + (birdYspeed * dt)
    birdYspeed = birdYspeed + (516 * dt)
end

function love.draw()
    love.graphics.setColor(.14, .36, .46)
    love.graphics.rectangle('fill', 0, 0, 300, 388)

    love.graphics.setColor(.87, .84, .27)
    love.graphics.rectangle('fill', 62, birdY, 30, 25)
end

function love.keypressed(space)
    birdYspeed = -165
end