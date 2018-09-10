-- warriors

function initCoins()
    coinDir = "/assets/coins/"
    coin1 = love.graphics.newImage(coinDir.."coin1.png")
    coin2 = love.graphics.newImage(coinDir.."coin2.png")
    coin3 = love.graphics.newImage(coinDir.."coin3.png")
    coin4 = love.graphics.newImage(coinDir.."coin4.png")

    coinCountVel = 200
    coinCount = 0
    showCount = false
    animFinished = false
    showCountTimer = 0.0
    coinPadding = 30
    coinScale = 1.5
    coinY = -coinScale * coin1:getHeight()
    curCoin = coin1
    coinTick = 0
    numCoins = 3
    coinPos = {200, 700, 1250}
    coinClcd = {}
    coinAnimDone = {}
    for i = 1, numCoins do
        coinClcd[i] = false
        coinAnimDone[i] = false
    end
    animSpeed = 25
end

function updateCoins()
    if love.keyboard.isScancodeDown('c') then
        if showCount then
            showCountTimer = 0.0
        else
            showCount = true
        end
    end
    if showCount then
        if coinY < coinPadding then
            coinY = coinY + (coinCountVel * love.timer.getDelta())
        end
        showCountTimer = showCountTimer + love.timer.getDelta()
        if showCountTimer > 5 then
            showCount = false
            showCountTimer = 0.0
        end
    end
    if not showCount and coinY > -coinScale * coin1:getHeight() then
        coinY = coinY - (coinCountVel * love.timer.getDelta())
    end

    for i = 1, numCoins do
        if (playerX + x - coinPos[i] >= -30 and 
            playerX + x - coinPos[i] <= 30 + coin1:getWidth()) and not coinClcd[i] then
        
            coinClcd[i] = true
            coinCount = coinCount + 1
            if not showCount then
                showCount = true
                showCountTimer = 0.0
            end
        end
        if coinClcd[i] and not coinAnimDone[i] then
            coinPos[i] = coinPos[i] + (playerX + x - 15 - coinPos[i]) / animSpeed
            animSpeed = animSpeed - 0.5
            if playerX + x - coinPos[i] > -2 and playerX + x - coinPos[i] < 2 + coin1:getWidth() then
                coinAnimDone[i] = true
                animSpeed = 25
            end
        end
    end
end

function animateCoins()
    if coinTick % 1 < 0.25 then
        curCoin = coin1
    elseif coinTick % 1 < 0.5 then
        curCoin = coin2
    elseif coinTick % 1 < 0.75 then
        curCoin = coin3
    elseif coinTick % 1 < 1 then
        curCoin = coin4
    end
    coinTick = coinTick + love.timer.getDelta()
end
