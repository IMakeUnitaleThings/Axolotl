--VARIABLES
BillBulletLimitLeft = -(Arena.width/2-22)
BillBulletLimitRight = Arena.width/2-22
BillBulletLimitTop = 0+50
BillBulletLimitBottom = 0-17
local isMoving = false
local targetX = 0
local targetY = 0
local moveSpeed = 25

function UpdateBillWalls()
    BillWallBottom = (BillBullet.y <= BillBulletLimitBottom)
    BillWallTop = (BillBullet.y >= BillBulletLimitTop)
    BillWallLeft = (BillBullet.x <= BillBulletLimitLeft)
    BillWallRight = (BillBullet.x >= BillBulletLimitRight)
end

function SetPlayerAsTarget()
    isMoving = true
    local dx = Player.x - BillBullet.x
    local dy = Player.y - BillBullet.y
    local length = math.sqrt(dx * dx + dy * dy)
    targetX = BillBullet.x + dx / length * 1000  -- Extend the vector
    targetY = BillBullet.y + dy / length * 1000
end


function S2FL(list, add)
    local outputlist = {}  
    add = add * 60         
    for listCount = 1, #list do
        local frameNum = list[listCount] * 60  

        table.insert(outputlist, frameNum) 

        for added = 1, add do
            table.insert(outputlist, frameNum + added)
        end
    end
    return outputlist
end

--checks if table has element
function EIT(table, element)
    for _, value in ipairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

function MoveBillBullet()
    if not isMoving then return end

    local dx = targetX - BillBullet.x
    local dy = targetY - BillBullet.y
    local distance = math.sqrt(dx*dx + dy*dy)

    if distance <= moveSpeed then
        BillBullet.MoveTo(targetX, targetY)
        isMoving = false
        Misc.ShakeScreen(3,6,true)
    else
        local angle = math.atan2(dy, dx)
        local moveX = moveSpeed * math.cos(angle)
        local moveY = moveSpeed * math.sin(angle)
        
        -- Check for wall collisions
        local newX = BillBullet.x + moveX
        local newY = BillBullet.y + moveY
        
        if newX <= BillBulletLimitLeft or newX >= BillBulletLimitRight or
           newY <= BillBulletLimitBottom or newY >= BillBulletLimitTop then
            isMoving = false
            Misc.ShakeScreen(5,10,true)
        else
            BillBullet.Move(moveX, moveY)
        end
    end
end

spawntimer = 0
bullets = {}
Audio.LoadFile("AXOLOTL")


--LISTS OF FRAMES
LET = {4, 5.5, 41, 43, 48, 50, 65, 81.5,83,85,87,118,164.5,172.5,174.5,186,209,210.5,242,244,246}
LETSTART = S2FL(LET, 0)
LETMAIN = S2FL(LET, 0.4)

ME = {4.5,6,41.5,43.5,48.5,50.5,65.5,82,83.5,87.5,118.5,165,173,175,186.5,209.5,211,242.5,244.5,246.5}
MESTART = S2FL(ME, 0)
MEMAIN = S2FL(ME, 0.4)

OUT = {5,6.5,42,44,49,51,66,82.5,84,86,88,119,165.5,173.5,175.5,187,210,212,243,245,247}
OUTSTART = S2FL(OUT, 0)
OUTMAIN = S2FL(OUT, 0.4)

--Creating intial bullets (bill)
BillBullet = CreateProjectile("CHAR/Non-Animated-Bill", BillBulletLimitLeft, BillBulletLimitTop)
BillBullet.sprite.scale(0.75,0.75)
BillWallBottom = false
BillWallTop = true
BillWallLeft = true
BillWallRight=true

function Update()
    if spawntimer == 0 then
        Audio.Play()
        Player.speed = 220

    elseif EIT(LETMAIN, spawntimer) then --LET is being
        if EIT(LETSTART, spawntimer) then --LET was just said
            SetPlayerAsTarget()
        end
        MoveBillBullet()
    elseif EIT(MEMAIN, spawntimer) then --ME is being said
        if EIT(MESTART, spawntimer) then --ME was just said
            SetPlayerAsTarget()
        end
        MoveBillBullet()
    elseif EIT(OUTMAIN, spawntimer) then --OUT is being said
        if EIT(OUTSTART, spawntimer) then --OUT was just said
            SetPlayerAsTarget()
        end
        MoveBillBullet()
    else 
        placeholder = 1 
    end
    spawntimer = spawntimer + 1
end
