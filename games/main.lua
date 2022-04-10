function love.load()
    playWidth = 800
    playHeight = 600
    playerX = 25
    playerY = 375
    defaultPlayer = love.graphics.newImage("assets/player_default.png")
    isAttacking = false
    isDead = false
    enemyDead = false
    enemyY = 380
    spawnLadder1()
    spawnLadder2()
    spawnEnemy(enemyY)
end


function love.update(dt)
    killEnemy(dt, ladderTop1)
    killEnemy(dt, ladderTop2)
    if enemyDead ~= true then
        if enemyDirection == 1 then
            enemyX = enemyX + (150 * dt)
            enemy = love.graphics.newImage("assets/enemy.png")
        else
            enemyX = enemyX - (150 * dt)
            enemy = love.graphics.newImage("assets/enemybackwards.png")
        end
        if enemyX > maxEnemyX then
            enemyDirection = 2
        elseif enemyX < minEnemyX then
            enemyDirection = 1
        end
    end
    isAlive(dt, ladderTop1)
    isAlive(dt, ladderTop2)
    function ladderCheck(ladderBeginX, ladderEndX, ladderTop, ladderBottom)
        if isDead ~= true then 
            if playerX >= ladderBeginX - 15 and playerX <= ladderEndX - 15 and playerY >= ladderTop and playerY <= ladderBottom then
                onLadder = true
                if playerY < ladderTop - 1 then
                    playerY = playerY + 1
                elseif playerY > ladderBottom then
                    playerY = playerY - 1
                end
                movePlayer(dt)
            else
                onLadder = false
                movePlayer(dt)
            end
            boundsCheck(dt)
        end
    end
    --maybe add conditional here depending on playerY to determine which ladder to check for
    ladderCheck(ladderBeginX1, ladderEndX1, ladderTop1, ladderBottom1)
    ladderCheck(ladderBeginX2, ladderEndX2, ladderTop2, ladderBottom2)
end


function love.draw()
    background = love.graphics.newImage("assets/background.jpg")
    love.graphics.setColor(.5, .3, .6)
    love.graphics.draw(background, 0, 0, 0, 1.34, 1.7) --load background and scale image to fit window
    key = love.graphics.newImage("assets/key.png")
    love.graphics.draw(key, 600, 60, 0, 0.1, 0.1)
    floor = love.graphics.newImage("assets/floor.png")
    love.graphics.draw(floor, 150, 330, 0, 3, 0.5)
    love.graphics.draw(floor, 150, 215, 0, 3, 0.5)
    ladder = love.graphics.newImage("assets/ladder.png")
    local function drawLadder(ladderBeginX, ladderBeginY)
        love.graphics.draw(ladder, ladderBeginX, ladderBeginY, 0, 0.5, 0.8)
    end
    drawLadder(ladderBeginX1, ladderBeginY1)
    drawLadder(ladderBeginX2, ladderBeginY2)
    door = love.graphics.newImage("assets/door.png")
    love.graphics.draw(door, 700, 375, 0, 0.15, 0.15)
    love.graphics.draw(defaultPlayer, playerX, playerY, 0, 0.75, 0.75)
    love.graphics.draw(enemy, enemyX, enemyY, 0, 0.1, 0.1)
    powerup = love.graphics.newImage("assets/powerup.png")
    love.graphics.draw(powerup, 450, 65, 0, 0.15, 0.15)
    love.graphics.print(playerY, 25, 25)
end


function love.keypressed(key)
    if key == 'space' then
        isAttacking = true
    else
        isAttacking = false
    end
        if key == 'left' then
            playerDirection = 'left'
        elseif key == 'right' then
            playerDirection = 'right'
        elseif key == 'up' then
            playerDirection = 'up'
        elseif key =='down' then
            playerDirection = 'down'
        elseif key ~= 'space' then
            playerDirection = nil
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


function spawnLadder1()
    ladderMin = 250
    ladderMax = 600
    ladderBeginX1 = love.math.random(ladderMin, ladderMax)
    ladderEndX1 = ladderBeginX1 + 30
    ladderBeginY1 = 330
    ladderTop1 = 265
    ladderBottom1 = 375
end

function spawnLadder2()
    ladderMin = 250
    ladderMax = 600
    ladderBeginX2 = love.math.random(ladderMin, ladderMax)
    ladderEndX2 = ladderBeginX2 + 30
    ladderBeginY2 = 215
    ladderTop2 = 150
    ladderBottom2 = 265
end


function movePlayer(dt)
    if playerDirection == 'left' then
        if playerY >= 374 or (playerY <= ladderTop1 and playerY >= ladderBottom2) then
            playerX = playerX - (60 * dt)
        end
        if isAttacking == true and onLadder == false then
            defaultPlayer = love.graphics.newImage("assets/player_attackbackwards.png")
        else
            defaultPlayer = love.graphics.newImage("assets/player_defaultbackwards.png")
        end
    elseif playerDirection == 'right' then
        if playerY >= 374 or (playerY <= ladderTop1 and playerY >= ladderBottom2) then
            playerX = playerX + (60 * dt)
        end
        if isAttacking == true and onLadder == false then
            defaultPlayer = love.graphics.newImage("assets/player_attack.png")
        else
            defaultPlayer = love.graphics.newImage("assets/player_default.png")
        end
    elseif playerDirection == 'up' and onLadder == true then
        playerY = playerY - (40 * dt)
        if playerY < ladderTop1 then 
            --might be problematic since we want to climb ladder 2 
            playerY = ladderTop1
        end
    elseif playerDirection == 'down' and onLadder == true then
        playerY = playerY + (40 * dt)
        if playerY > 375 then
            playerY = 375
        end
    end
end


function isAlive(dt, ladderTop)
    if enemyX + 15 > playerX and enemyX - 15 < playerX and playerY >= ladderTop + 45 and isAttacking == false and enemyDead == false then
        defaultPlayer = love.graphics.newImage("assets/death.png")
        isDead = true
    end
    return isDead
end


function boundsCheck(dt)
    if playerX < 10 then
        playerX = playerX + 5  
    elseif playerX > playWidth - 50 then
        playerX = playerX - 5
    end
end

function killEnemy(dt, ladderTop)
    if enemyX + 15 > playerX and enemyX - 15 < playerX and playerY >= ladderTop + 45 and isAttacking == true then
        enemy = love.graphics.newImage("assets/poof.png")
        enemyDead = true
    end
    return enemyDead
end


function spawnEnemy(enemyY)
    minEnemyX = 200
    maxEnemyX = playWidth - 100
    enemySpawn = love.math.random(minEnemyX, maxEnemyX)
    enemyX = enemySpawn
    enemyDirection = love.math.random(1,2)
end