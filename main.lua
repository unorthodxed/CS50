function love.load()
    timer = 0
end
function love.update()
    timer = timer + 0.15 * dt
    if timer >= 0.15 then timer = 0 end
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

    local snakeSegments = {
        {x = 3, y = 1},
        {x = 2, y = 1},
        {x = 1, y = 1}
    }
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
