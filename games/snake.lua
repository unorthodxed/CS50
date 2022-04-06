function love.load()
    timer = 0
    snakeSegments = {
        {x = 3, y = 1},
        {x = 2, y = 1},
        {x = 1, y = 1}
    }
    direction_queue = {'right'}
    gridXcount = 50
    gridYcount = 35

    function moveFood()
        foodposition = {
        x = love.math.random(1, gridXcount),
        y = love.math.random(1, gridYcount),
    }
    end
    moveFood()
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

        local canMove = true
        for segmentIndex, segment in ipairs(snakeSegments) do
            if segmentIndex ~= #snakeSegments
            and nextPositionX == segment.x
            and nextPositionY == segment.y then
                canMove = false
            end
        end

        if canMove then
            table.insert(snakeSegments, 1, {x = nextPositionX,
        y = nextPositionY})
            if snakeSegments[1].x == foodposition.x and
            snakeSegments[1].y == foodposition.y then
                moveFood()
            else
                table.remove(snakeSegments)
            end

            if #direction_queue > 1 then
                table.remove(direction_queue, 1)
            end
        else
            love.load()
        end
    end
end

function love.draw()
    cellSize = 15

    local function drawCell(x, y)
        love.graphics.rectangle(
            'fill',
            (x - 1) * cellSize,
            (y - 1) * cellSize,
            cellSize - 1,
            cellSize - 1
            )
    end
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
        drawCell(segment.x, segment.y)
    end

    love.graphics.setColor(1, .3, .3)
    drawCell(foodposition.x, foodposition.y)
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
