function love.load()
    timer = 0
    snakeSegments = {
        {x = 3, y = 1},
        {x = 2, y = 1},
        {x = 1, y = 1}
    }
    direction_queue = {'right'}
end

function love.update(dt)
    timer = timer + dt
    if timer >= 0.15 then 
        timer = 0
        local nextPositionX = snakeSegments[1].x
        local nextPositionY = snakeSegments[1].y 

        if nextPositionX > gridXcount then
            nextPositionX = 1
        elseif nextPositionX < 1 then
            nextPositionX = gridXcount
        elseif nextPositionY > gridYcount then
            nextPositionY = 1
        elseif nextPositionY < 1 then
            nextPositionY = gridYcount
        end

        if direction_queue[1] == 'right' then
            nextPositionX = nextPositionX + 1
        elseif direction_queue[1] == 'left' then
            nextPositionX = nextPositionX - 1
        elseif direction_queue[1] == 'up' then
            nextPositionY = nextPositionY - 1
        elseif direction_queue[1] == 'down' then
            nextPositionY = nextPositionY + 1
        end
        table.insert(snakeSegments, 1, {x = nextPositionX,
        y = nextPositionY})
        table.remove(snakeSegments)

        if #direction_queue > 1 then
            table.remove(direction_queue, 1)
        end
    end
end

function love.draw()
    gridXcount = 50
    gridYcount = 35
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

function love.keypressed(key)
    if key == 'right' and direction_queue[#direction_queue] ~= 'left' then
        table.insert(direction_queue, 'right')
    elseif key == 'left' and direction_queue[#direction_queue] ~= 'right' then
        table.insert(direction_queue, 'left')
    elseif key == 'up' and direction_queue[#direction_queue] ~= 'down' then
        table.insert(direction_queue, 'up')
    elseif key =='down' and direction_queue[#direction_queue] ~= 'up' then
        table.insert(direction_queue, 'down')
    end
end
