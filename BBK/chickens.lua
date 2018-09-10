-- Chickens

function initChickens()
    chknDir = "/assets/chicken/"
    chicken1 = love.graphics.newImage(chknDir.."chkn1.png")
    chicken2 = love.graphics.newImage(chknDir.."chkn2.png")

    chknCountVel = 200
    chknCount = 0
    showCount = false
    animFinished = false
    showCountTimer = 0.0
    chknPadding = 30
    chknScale = 2
    chknY = -chknscale * chkn1:getHeight()
    curChkn = chkn1
    chknTick = 0
    numchkns = 1
    chknPos = {300}
    chknClcd = {}
    chknAnimDone = {}
    for i = 1, numchkns do
        chknd[i] = false
        chknAnimDone[i] = false
    end
    animSpeed = 25
end


function animateChkn()
    if chknTick % 1 < 0.25 then
        curchkn = chkn1
    elseif chknTick % 1 < 0.75 then
        curchkn = coin3
    end
    chknTick = chknTick + love.timer.getDelta()
end
