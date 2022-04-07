function love.load()
    playWidth = 800
    playHeight = 600
    playerX = 25
    playerY = 375
    minEnemyX = 200
    maxEnemyX = playWidth - 100
    enemySpawn = love.math.random(minEnemyX, maxEnemyX)
    enemyX = enemySpawn
    enemyDirection = love.math.random(1,2)
    defaultPlayer = love.graphics.newImage("player_default.png")
    isAttacking = false
    spawnLadder()
end

function love.update(dt)
    if enemyDirection == 1 then
        enemyX = enemyX + (150 * dt)
        enemy = love.graphics.newImage("enemy.png")
    else
        enemyX = enemyX - (150 * dt)
        enemy = love.graphics.newImage("enemybackwards.png")
    end
    if enemyX > maxEnemyX then
        enemyDirection = 2
    elseif enemyX < minEnemyX then
        enemyDirection = 1
    end
    if playerX >= ladderBeginX and playerX <= ladderEndX and playerY >= ladderTop and playerY <= ladderBottom then
        onLadder = true
    else
        onLadder = false
        if playerY < ladderTop then
            playerY = playerY + 1
        elseif playerY > ladderBottom then
            playerY = playerY - 1
        end
    end
    if playerDirection == 'left' then
        playerX = playerX - (120 * dt)
        defaultPlayer = love.graphics.newImage("player_defaultbackwards.png")
    elseif playerDirection == 'right' then
        playerX = playerX + (120 * dt)
        defaultPlayer = love.graphics.newImage("player_default.png")
    elseif playerDirection == 'up' and onLadder == true then
        playerY = playerY - (80 * dt)
    elseif playerDirection == 'down' and onLadder == true then
        playerY = playerY + (80 * dt)
    end
    if playerX < 10 then
        playerX = playerX + 5  
    elseif playerX > playWidth - 50 then
        playerX = playerX - 5
    end
end

function love.draw()
    background = love.graphics.newImage("background.jpg")
    love.graphics.setColor(.5, .3, .6)
    love.graphics.draw(background, 0, 0, 0, 1.34, 1.7) --load background and scale image to fit window
    key = love.graphics.newImage("key.png")
    love.graphics.draw(key, 600, 60, 0, 0.1, 0.1)
    floor = love.graphics.newImage("floor.png")
    love.graphics.draw(floor, 150, 330, 0, 3, 0.5)
    ladder = love.graphics.newImage("ladder.png")
    love.graphics.draw(ladder, ladderBeginX, ladderBeginY, 0, 0.5, 0.8)
    door = love.graphics.newImage("door.png")
    love.graphics.draw(door, 700, 375, 0, 0.15, 0.15)
    love.graphics.draw(defaultPlayer, playerX, playerY, 0, 0.75, 0.75)
    love.graphics.draw(enemy, enemyX, 380, 0, 0.1, 0.1)
    powerup = love.graphics.newImage("powerup.png")
    love.graphics.draw(powerup, 450, 65, 0, 0.15, 0.15)
end

function love.keypressed(key)
    if key == 'left' then
        playerDirection = 'left'
    elseif key == 'right' then
        playerDirection = 'right'
    elseif key == 'up' then
        playerDirection = 'up'
    elseif key =='down' then
        playerDirection = 'down'
    else
        playerDirection = nil
    end
    if key == 'space' then
        isAttacking = true
    else
        isAttacking = false
    end
end

function love.keyreleased(key)
    if key == 'left' and playerDirection == 'left' then
        playerDirection = nil
    elseif key == 'right' and playerDirection == 'right' then
        playerDirection = nil
    elseif key == 'up' and playerDirection == 'up' then
        playerDirection = nil
    elseif key == 'down' and playerDirection == 'down' then
        playerDirection = nil
    elseif key == 'space' then
        isAttacking = false
    end
end

function spawnLadder()
    ladderMin = 250
    ladderMax = 600
    ladderBeginX = love.math.random(ladderMin, ladderMax)
    ladderEndX = ladderBeginX + 30
    ladderBeginY = 330
    ladderTop = 265
    ladderBottom = 375
end