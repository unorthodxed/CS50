function love.load()
    timer = 0
    snakeSegments = {
        {x = 3, y = 1},
        {x = 2, y = 1},
        {x = 1, y = 1}
    }
end

function love.update(dt)
    timer = timer + dt
    if timer >= 0.15 then 
        timer = 0
        local nextPositionX = snakeSegments[1].x + 1
        local nextPositionY = snakeSegments[1].y 

        table.insert(snakeSegments, 1, {x = nextPositionX,
        y = nextPositionY})
        table.remove(snakeSegments)
    end
end

function love.draw()
    local gridXcount = 50
    local gridYcount = 35
    local cellSize = 15

    love.graphics.setColor(.5, .5, .5)
    love.graphics.rectangle(
        'fill',
        0,
        0,
        gridXcount * cellSize,
        gridYcount * cellSize
    )
    for segmentIndex, segment in ipairs(snakeSegments) do
        love.graphics.setColor(.6, 1, .32)
        love.graphics.rectangle(
            'fill',
            (segment.x - 1) * cellSize,
            (segment.y - 1) * cellSize,
            cellSize - 1,
            cellSize - 1
        )
    end
end
