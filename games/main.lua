function love.load()
    playWidth = 800
    playHeight = 600
end

function love.update()

end

function love.draw()
    love.graphics.setColor(.3, .3, .3)
    love.graphics.rectangle('fill',
    0,
    0, 
    playWidth, 
    playHeight)
    love.graphics.setColor(.6, .8, .3)
    background = love.graphics.newImage("background.jpg")
    love.graphics.draw(background, 0, 0, 0, 1.34, 1.7) --load background and scale image to fit window
end