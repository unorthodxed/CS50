function love.load()
    playWidth = 800
    playHeight = 600
end

function love.update()

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
    love.graphics.draw(ladder, 300, 330, 0, 0.5, 0.8)
    door = love.graphics.newImage("door.png")
    love.graphics.draw(door, 700, 375, 0, 0.15, 0.15)
    defaultPlayer = love.graphics.newImage("player_default.png")
    love.graphics.draw(defaultPlayer, 25, 375, 0, 0.75, 0.75)
    enemy = love.graphics.newImage("enemy.png")
    love.graphics.draw(enemy, 200, 380, 0, 0.1, 0.1)
    powerup = love.graphics.newImage("powerup.png")
    love.graphics.draw(powerup, 450, 65, 0, 0.15, 0.15)
end