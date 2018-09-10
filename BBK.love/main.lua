require "camera"
require "coins"

function love.load()    
    -- Window
    love.window.setMode(1280, 720)
    love.window.setTitle("By Birth Kingdom")

    -- Game
    x = 0.0

    -- Map
    map = love.graphics.newImage("/assets/map.png")
    mapEnd = 3370.0
    ground = 318.0
    gravity = 0
    count = 0

    -- Player
    playerDir = "/assets/player/"
    idle1 = love.graphics.newImage(playerDir.."idle1.png")
    idle2 = love.graphics.newImage(playerDir.."idle2.png")
    walk1 = love.graphics.newImage(playerDir.."walk1.png")
    walk2 = love.graphics.newImage(playerDir.."walk2.png")
    walk3 = love.graphics.newImage(playerDir.."walk3.png")
    walk4 = love.graphics.newImage(playerDir.."walk4.png")
    walk5 = love.graphics.newImage(playerDir.."walk5.png")
    walk6 = love.graphics.newImage(playerDir.."walk6.png")
    walk7 = love.graphics.newImage(playerDir.."walk7.png")
    walk8 = love.graphics.newImage(playerDir.."walk8.png")
    crown = love.graphics.newImage("/assets/crown.png")

    centre = (love.graphics.getWidth() / 2) - (idle1:getWidth() / 2)
    playerX = centre
    playerY = ground + idle1:getHeight()
    playerFlip = 1
    vel = 200
    idleTick = 0
    walkTick = 0

    -- Coins
    initCoins()
    
    -- Sky
    sky = love.graphics.newImage("/assets/sky.jpg")
end

function love.update()
    if idleTick % 2 < 1 then
        player = idle1
    else
        player = idle2
    end

    if (love.keyboard.isScancodeDown("a") or 
        love.keyboard.isScancodeDown("left")) then

    		playerFlip = -1     	
    	if playerX > centre or (x <= 0 and playerX > player:getWidth() / 2) then
    		playerX = playerX - (vel * love.timer.getDelta())
    		walkAnimation()
    	elseif x > 0 then
			x = x - (vel * love.timer.getDelta())
			walkAnimation()
		end
    elseif (love.keyboard.isScancodeDown("d") or 
        love.keyboard.isScancodeDown("right")) then

        	playerFlip = 1
    	if playerX < centre or (x >= mapEnd - player:getWidth() and 
    		playerX < love.graphics.getWidth() - (player:getWidth() / 2)) then

    		playerX = playerX + (vel * love.timer.getDelta())
    		walkAnimation()
		elseif x < mapEnd - player:getWidth() then
			x = x + (vel * love.timer.getDelta())
			walkAnimation()
		end
    else
    	walkTick = 0
    end

    updateCoins()
	animateCoins()

    idleTick = idleTick + love.timer.getDelta()
    camera.x = x
end

function walkAnimation()
	if walkTick % 1 < 0.125 then
		player = walk1
	elseif walkTick % 1 < 0.25 then
		player = walk2
	elseif walkTick % 1 < 0.375 then
		player = walk3
	elseif walkTick % 1 < 0.5 then
		player = walk4
	elseif walkTick % 1 < 0.625 then
		player = walk5
	elseif walkTick % 1 < 0.75 then
		player = walk6
	elseif walkTick % 1 < 0.875 then
		player = walk7
	elseif walkTick % 1 < 1 then
		player = walk8
	end
	walkTick = walkTick + 0.75 * love.timer.getDelta()
	idleTick = 0
end

function love.draw()
	camera:set()
	love.graphics.draw(sky, x / 2, 0, 0, 1)
	love.graphics.draw(map, 0, 100, 0, 0.4)
	
	for i = 1, numCoins do
		if not coinAnimDone[i] then
			love.graphics.draw(curCoin, coinPos[i], ground + player:getHeight() + coin1:getHeight())
		end
	end

	love.graphics.draw(player, x + playerX, playerY, 
		0, playerFlip, 1, player:getWidth() / 2, 0)

	love.graphics.draw(coin1, 
		x + (love.graphics.getWidth() - 4 * coinPadding), coinY, 0, coinScale)
	love.graphics.print(coinCount,
		x + (love.graphics.getWidth() - 1.8 * coinPadding), coinY + 4.25, 0, coinScale * 2)
	
	camera:unset()
end