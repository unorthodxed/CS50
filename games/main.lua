function love.load()
    loadmap()
    playerX = 25
    playerY = 375
    defaultPlayer = love.graphics.newImage("assets/player_default.png")
    isAttacking = false
    isDead = false
    spawnLadder1()
    spawnLadder2()
    spawnLadder3()
    ladderTop4 = -15
    enemy = {
    {   enemyY = 380,
        enemyX = love.math.random(200, 700),
        minEnemyX = 200,
        maxEnemyX = 700,
        enemyDirection = love.math.random(1,2),
        image = love.graphics.newImage("assets/enemy.png"),
        enemyDead = false
    }, 
    {   enemyY = 270,
        enemyX = love.math.random(200, floorEndX),
        minEnemyX = 200,
        maxEnemyX = floorEndX,
        enemyDirection = love.math.random(1, 2),
        image = love.graphics.newImage("assets/enemy.png"),
        enemyDead = false
    }, 
    {   enemyY = 155,
        enemyX = love.math.random(200, floorEndX),
        minEnemyX = 200,
        maxEnemyX = floorEndX,
        enemyDirection = love.math.random(1, 2),
        image = love.graphics.newImage("assets/enemy.png"),
        enemyDead = false
    }, 
    {   enemyY = 40,
        enemyX = love.math.random(200, floorEndX),
        minEnemyX = 200,
        maxEnemyX = floorEndX,
        enemyDirection = love.math.random(1, 2),
        image = love.graphics.newImage("assets/enemy.png"),
        enemyDead = false
    }
    }
end


function love.update(dt)
    for index, value in ipairs(enemy) do
        if value.enemyDead ~= true then
            if value.enemyDirection == 1 then
                value.enemyX = value.enemyX + (150 * dt)
                value.image = love.graphics.newImage("assets/enemy.png")
            else
                value.enemyX = value.enemyX - (150 * dt)
                value.image = love.graphics.newImage("assets/enemybackwards.png")
            end
            if value.enemyX > value.maxEnemyX then
                value.enemyDirection = 2
            elseif value.enemyX < value.minEnemyX then
                value.enemyDirection = 1
            end
        end
    end
    if playerY <= ladderTop3 then
        isAlive(dt, ladderTop4, enemy[4])
        killEnemy(dt, ladderTop4, enemy[4])
    elseif playerY <= ladderTop2 then
        isAlive(dt, ladderTop3, enemy[3])
        killEnemy(dt, ladderTop3, enemy[3])
    elseif playerY > ladderTop2 and playerY <= ladderTop1 then
        isAlive(dt, ladderTop2, enemy[2])
        killEnemy(dt, ladderTop2, enemy[2])
    else
        isAlive(dt, ladderTop1, enemy[1])
        killEnemy(dt, ladderTop1, enemy[1])
    end
    function ladderCheck(ladderBeginX, ladderEndX, ladderTop, ladderBottom)
        if isDead ~= true then 
            if playerX >= ladderBeginX - 15 and playerX <= ladderEndX - 15 and playerY >= ladderTop and playerY <= ladderBottom then
                onLadder = true
                if playerY < ladderTop then
                    playerY = ladderTop
                elseif playerY > ladderBottom then
                    playerY = ladderBottom
                end
                movePlayer(dt, ladderTop, ladderBottom, ladderBeginX, ladderEndX)
            else
                onLadder = false
                movePlayer(dt, ladderTop, ladderBottom, ladderBeginX, ladderEndX)
            end
            boundsCheck(dt)
        end
    end
    --maybe add conditional here depending on playerY to determine which ladder to check for
    ladderCheck(ladderBeginX1, ladderEndX1, ladderTop1, ladderBottom1)
    ladderCheck(ladderBeginX2, ladderEndX2, ladderTop2, ladderBottom2)
    ladderCheck(ladderBeginX3, ladderEndX3, ladderTop3, ladderBottom3)
end


function love.draw()
    background = love.graphics.newImage("assets/background.jpg")
    love.graphics.setColor(.5, .3, .6)
    love.graphics.draw(background, 0, 0, 0, 1.34, 1.7) --load background and scale image to fit window
    key = love.graphics.newImage("assets/key.png")
    love.graphics.draw(key, 600, 60, 0, 0.1, 0.1)
    floor = love.graphics.newImage("assets/floor.png")
    love.graphics.draw(floor, floorBeginX, floorBeginY1, 0, 3, 0.5)
    love.graphics.draw(floor, floorBeginX, floorBeginY2, 0, 3, 0.5)
    love.graphics.draw(floor, floorBeginX, floorBeginY3, 0, 3, 0.5)
    ladder = love.graphics.newImage("assets/ladder.png")
    local function drawLadder(ladderBeginX, ladderBeginY)
        love.graphics.draw(ladder, ladderBeginX, ladderBeginY, 0, 0.5, 0.8)
    end
    drawLadder(ladderBeginX1, ladderBeginY1)
    drawLadder(ladderBeginX2, ladderBeginY2) 
    drawLadder(ladderBeginX3, ladderBeginY3)
    door = love.graphics.newImage("assets/door.png")
    love.graphics.draw(door, 700, 375, 0, 0.15, 0.15)
    love.graphics.draw(defaultPlayer, playerX, playerY, 0, 0.75, 0.75)
    local function drawEnemy(image, enemyX, enemyY)
        love.graphics.draw(image, enemyX, enemyY, 0, 0.1, 0.1)
    end
    drawEnemy(enemy[1].image, enemy[1].enemyX, enemy[1].enemyY)
    drawEnemy(enemy[2].image, enemy[2].enemyX, enemy[2].enemyY)
    drawEnemy(enemy[3].image, enemy[3].enemyX, enemy[3].enemyY)
    drawEnemy(enemy[4].image, enemy[4].enemyX, enemy[4].enemyY)
    powerup = love.graphics.newImage("assets/powerup.png")
    love.graphics.draw(powerup, 450, 65, 0, 0.15, 0.15)
    love.graphics.print(playerY, 25, 25)
    love.graphics.print(playerX, 25, 35)
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
    repeat 
        placeholder = love.math.random(ladderMin, ladderMax)
    until placeholder < ladderBeginX1 - 40 or placeholder > ladderBeginX1 + 40
    ladderBeginX2 = placeholder
    ladderEndX2 = ladderBeginX2 + 30
    ladderBeginY2 = 215
    ladderTop2 = 150
    ladderBottom2 = 265
end

function spawnLadder3()
    ladderMin = 250
    ladderMax = 600
    repeat 
        placeholder = love.math.random(ladderMin, ladderMax)
    until placeholder < ladderBeginX2 - 40 or placeholder > ladderBeginX2 + 40
    ladderBeginX3 = placeholder
    ladderEndX3 = ladderBeginX3 + 30
    ladderBeginY3 = 100
    ladderTop3 = 35
    ladderBottom3 = 150
end


function movePlayer(dt, ladderTop, ladderBottom, ladderBeginX, ladderEndX)
    if playerDirection == 'left' then
        if playerY < ladderBottom and playerY > ladderTop then
            playerX = ladderBeginX
            isAttacking = false
        else
            playerX = playerX - (40 * dt)
        end
        if isAttacking == true then
            defaultPlayer = love.graphics.newImage("assets/player_attackbackwards.png")
        else
            defaultPlayer = love.graphics.newImage("assets/player_defaultbackwards.png")
        end
        if playerX < floorBeginX - 18 and playerY < ladderBottom1 then
            playerX = floorBeginX - 18
        end
    elseif playerDirection == 'right' then
        if playerY < ladderBottom and playerY > ladderTop then
            playerX = ladderBeginX
            isAttacking = false
        else
            playerX = playerX + (40 * dt)
        end
        if isAttacking == true then
            defaultPlayer = love.graphics.newImage("assets/player_attack.png")
        else
            defaultPlayer = love.graphics.newImage("assets/player_default.png")
        end
        if playerX > floorEndX and playerY < ladderBottom1 then
            playerX = floorEndX
        end
    elseif playerDirection == 'up' and onLadder == true then
        playerY = playerY - (40 * dt)
        if playerY <= ladderTop then 
            playerY = ladderTop
        end
    elseif playerDirection == 'down' and onLadder == true then
        playerY = playerY + (40 * dt)
        if (playerY > ladderBottom2 and ladderBottom == ladderBottom2) or (playerY > ladderBottom1 and ladderBottom == ladderBottom1) or (playerY > ladderBottom3 and ladderBottom == ladderBottom3) then
            playerY = ladderBottom
        end
    end
end


function isAlive(dt, ladderTop, enemy)
    if enemy.enemyX + 15 > playerX and enemy.enemyX - 15 < playerX and playerY >= ladderTop + 45 and isAttacking == false and enemy.enemyDead == false then
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

function killEnemy(dt, ladderTop, enemy)
    if enemy.enemyX + 15 > playerX and enemy.enemyX - 15 < playerX and playerY >= ladderTop + 45 and isAttacking == true then
        enemy.image = love.graphics.newImage("assets/poof.png")
        enemy.enemyDead = true
    end
    return enemyDead
end


function loadmap()
    playWidth = 800
    playHeight = 600
    floorBeginX = 150
    floorBeginY1 = 330
    floorBeginY2 = 215
    floorBeginY3 = 100
    floorEndX = 650
end
