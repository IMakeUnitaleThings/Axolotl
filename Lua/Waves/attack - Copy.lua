--converts seconds into frames, and adds the amount of frames required to move attack
-- Add this function at the beginning of your file
function UpdateBillWalls()
    BillWallBottom = (BillBullet.y <= BillBulletLimitBottom)
    BillWallTop = (BillBullet.y >= BillBulletLimitTop)
    BillWallLeft = (BillBullet.x <= BillBulletLimitLeft)
    BillWallRight = (BillBullet.x >= BillBulletLimitRight)
end

-- Replace the SlamCorner selection code in your LETSTART, MESTART, and OUTSTART sections with this: 




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

--Checks which two numbers are closer (CLOSEST TO A)
function CTA(a, b, c)
    local distanceB = math.abs(a - b)
    local distanceC = math.abs(a - c) 
    if distanceB > distanceC then
        return "B"
    elseif distanceC > distanceB then
        return "C"
    else
        return "ABC"
    end
end

spawntimer = 0
bullets = {}
Audio.LoadFile("AXOLOTL")

--VARIABLES
BillBulletLimitLeft = -(Arena.width/2-22)
BillBulletLimitRight = Arena.width/2-22
BillBulletLimitTop = 0+50
BillBulletLimitBottom = 0-17

--LISTS OF FRAMES
LET = {4, 5.5, 41, 42.5, 48, 50}
LETSTART = S2FL(LET, 0)
LETMAIN = S2FL(LET, 0.4)
ME = {4.5, 6.0, 41.5, 43, 48.5, 50.5}
MESTART = S2FL(ME, 0)
MEMAIN = S2FL(ME, 0.4)
OUT = {5, 6.5, 42, 43.5, 49, 51}
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

    --TODO MAKE "LET ME OUT" MOVE IN A RANDOM PATTERN EACH TIME
    elseif EIT(LETMAIN, spawntimer) then --LET is being
        if EIT(LETSTART, spawntimer) then --LET was just said
            UpdateBillWalls()
            local availableCorners = {}
            if not (BillWallLeft and BillWallTop) then table.insert(availableCorners, 1) end
            if not (BillWallRight and BillWallTop) then table.insert(availableCorners, 2) end
            if not (BillWallLeft and BillWallBottom) then table.insert(availableCorners, 3) end
            if not (BillWallRight and BillWallBottom) then table.insert(availableCorners, 4) end
            if #availableCorners > 0 then
                SlamCorner = availableCorners[math.random(#availableCorners)]
                DEBUG('SlamCorner=' .. SlamCorner)
            else
                -- If all corners are occupied, choose a random one
                SlamCorner = math.random(1, 4)
                DEBUG('All corners occupied, random SlamCorner=' .. SlamCorner)
            end
        end
        if SlamCorner == 1 then
            -- Move to left edge
            if BillBullet.x - 25 <= BillBulletLimitLeft then
                BillBulletMoveX = BillBulletLimitLeft - BillBullet.x
            else
                BillBulletMoveX = -25
            end

            -- Move to top edge
            if BillBullet.y + 15 >= BillBulletLimitTop then
                BillBulletMoveY = BillBulletLimitTop - BillBullet.y
            else
                BillBulletMoveY = 15
            -- Move BillBullet
            BillBullet.Move(BillBulletMoveX, BillBulletMoveY)
            end
        elseif SlamCorner == 2 then
            -- Move to right edge
            if BillBullet.x + 15 >= BillBulletLimitRight then
                BillBulletMoveX = BillBulletLimitRight - BillBullet.x
            else
                BillBulletMoveX = 15
            end

            -- Move to top edge
            if BillBullet.y + 15 >= BillBulletLimitTop then
                BillBulletMoveY = BillBulletLimitTop - BillBullet.y
            else
                BillBulletMoveY = 15
            end
            -- Move BillBullet
            BillBullet.Move(BillBulletMoveX, BillBulletMoveY)

        elseif SlamCorner == 3 then 
            -- Move to left edge
            if BillBullet.x - 25 <= BillBulletLimitLeft then
                BillBulletMoveX = BillBulletLimitLeft - BillBullet.x
            else
                BillBulletMoveX = -25
            end

            -- Move to bottom edge
            if BillBullet.y - 15 <= BillBulletLimitBottom then
                BillBulletMoveY = BillBulletLimitBottom - BillBullet.y
            else
                BillBulletMoveY = -15
            end
            -- Move BillBullet
            BillBullet.Move(BillBulletMoveX, BillBulletMoveY)

        elseif SlamCorner == 4 then
                -- Move to right edge
            if BillBullet.x + 25 >= BillBulletLimitRight then
                BillBulletMoveX = BillBulletLimitRight - BillBullet.x
            else
                BillBulletMoveX = 25
            end

            -- Move to bottom edge
            if BillBullet.y - 15 <= BillBulletLimitBottom then
                BillBulletMoveY = BillBulletLimitBottom - BillBullet.y
            else
                BillBulletMoveY = -15
            end

            -- Move BillBullet
            BillBullet.Move(BillBulletMoveX, BillBulletMoveY)
        end
    elseif EIT(MEMAIN, spawntimer) then --ME is being said
        if EIT(MESTART, spawntimer) then --ME was just said
            UpdateBillWalls()
            local availableCorners = {}
            if not (BillWallLeft and BillWallTop) then table.insert(availableCorners, 1) end
            if not (BillWallRight and BillWallTop) then table.insert(availableCorners, 2) end
            if not (BillWallLeft and BillWallBottom) then table.insert(availableCorners, 3) end
            if not (BillWallRight and BillWallBottom) then table.insert(availableCorners, 4) end
            if #availableCorners > 0 then
                SlamCorner = availableCorners[math.random(#availableCorners)]
                DEBUG('SlamCorner=' .. SlamCorner)
            else
                -- If all corners are occupied, choose a random one
                SlamCorner = math.random(1, 4)
                DEBUG('All corners occupied, random SlamCorner=' .. SlamCorner)
            end
        end
        if SlamCorner == 1 then
            -- Move to left edge
            if BillBullet.x - 25 <= BillBulletLimitLeft then
                BillBulletMoveX = BillBulletLimitLeft - BillBullet.x
            else
                BillBulletMoveX = -25
            end

            -- Move to top edge
            if BillBullet.y + 15 >= BillBulletLimitTop then
                BillBulletMoveY = BillBulletLimitTop - BillBullet.y
            else
                BillBulletMoveY = 15
            -- Move BillBullet
            BillBullet.Move(BillBulletMoveX, BillBulletMoveY)
            end
        elseif SlamCorner == 2 then
            -- Move to right edge
            if BillBullet.x + 25 >= BillBulletLimitRight then
                BillBulletMoveX = BillBulletLimitRight - BillBullet.x
            else
                BillBulletMoveX = 25
            end

            -- Move to top edge
            if BillBullet.y + 15 >= BillBulletLimitTop then
                BillBulletMoveY = BillBulletLimitTop - BillBullet.y
            else
                BillBulletMoveY = 15
            end
            -- Move BillBullet
            BillBullet.Move(BillBulletMoveX, BillBulletMoveY)

        elseif SlamCorner == 3 then 
            -- Move to left edge
            if BillBullet.x - 25 <= BillBulletLimitLeft then
                BillBulletMoveX = BillBulletLimitLeft - BillBullet.x
            else
                BillBulletMoveX = -25
            end

            -- Move to bottom edge
            if BillBullet.y - 15 <= BillBulletLimitBottom then
                BillBulletMoveY = BillBulletLimitBottom - BillBullet.y
            else
                BillBulletMoveY = -15
            end
            -- Move BillBullet
            BillBullet.Move(BillBulletMoveX, BillBulletMoveY)

        elseif SlamCorner == 4 then
                -- Move to right edge
            if BillBullet.x + 25 >= BillBulletLimitRight then
                BillBulletMoveX = BillBulletLimitRight - BillBullet.x
            else
                BillBulletMoveX = 25
            end

            -- Move to bottom edge
            if BillBullet.y - 15 <= BillBulletLimitBottom then
                BillBulletMoveY = BillBulletLimitBottom - BillBullet.y
            else
                BillBulletMoveY = -15
            end

            -- Move BillBullet
            BillBullet.Move(BillBulletMoveX, BillBulletMoveY)
        end
    elseif EIT(OUTMAIN, spawntimer) then --OUT is being said
        if EIT(OUTSTART, spawntimer) then --OUT was just said
            UpdateBillWalls()
            local availableCorners = {}
            if not (BillWallLeft and BillWallTop) then table.insert(availableCorners, 1) end
            if not (BillWallRight and BillWallTop) then table.insert(availableCorners, 2) end
            if not (BillWallLeft and BillWallBottom) then table.insert(availableCorners, 3) end
            if not (BillWallRight and BillWallBottom) then table.insert(availableCorners, 4) end
            if #availableCorners > 0 then
                SlamCorner = availableCorners[math.random(#availableCorners)]
                DEBUG('SlamCorner=' .. SlamCorner)
            else
                -- If all corners are occupied, choose a random one
                SlamCorner = math.random(1, 4)
                DEBUG('All corners occupied, random SlamCorner=' .. SlamCorner)
            end
        end
        if SlamCorner == 1 then
            -- Move to left edge
            if BillBullet.x - 25 <= BillBulletLimitLeft then
                BillBulletMoveX = BillBulletLimitLeft - BillBullet.x
            else
                BillBulletMoveX = -25
            end

            -- Move to top edge
            if BillBullet.y + 15 >= BillBulletLimitTop then
                BillBulletMoveY = BillBulletLimitTop - BillBullet.y
            else
                BillBulletMoveY = 15
            -- Move BillBullet
            BillBullet.Move(BillBulletMoveX, BillBulletMoveY)
            end
        elseif SlamCorner == 2 then
            -- Move to right edge
            if BillBullet.x + 15 >= BillBulletLimitRight then
                BillBulletMoveX = BillBulletLimitRight - BillBullet.x
            else
                BillBulletMoveX = 15
            end

            -- Move to top edge
            if BillBullet.y + 15 >= BillBulletLimitTop then
                BillBulletMoveY = BillBulletLimitTop - BillBullet.y
            else
                BillBulletMoveY = 15
            end
            -- Move BillBullet
            BillBullet.Move(BillBulletMoveX, BillBulletMoveY)

        elseif SlamCorner == 3 then 
            -- Move to left edge
            if BillBullet.x - 25 <= BillBulletLimitLeft then
                BillBulletMoveX = BillBulletLimitLeft - BillBullet.x
            else
                BillBulletMoveX = -25
            end

            -- Move to bottom edge
            if BillBullet.y - 15 <= BillBulletLimitBottom then
                BillBulletMoveY = BillBulletLimitBottom - BillBullet.y
            else
                BillBulletMoveY = -15
            end
            -- Move BillBullet
            BillBullet.Move(BillBulletMoveX, BillBulletMoveY)

        elseif SlamCorner == 4 then
                -- Move to right edge
            if BillBullet.x + 25 >= BillBulletLimitRight then
                BillBulletMoveX = BillBulletLimitRight - BillBullet.x
            else
                BillBulletMoveX = 25
            end

            -- Move to bottom edge
            if BillBullet.y - 15 <= BillBulletLimitBottom then
                BillBulletMoveY = BillBulletLimitBottom - BillBullet.y
            else
                BillBulletMoveY = -15
            end

            -- Move BillBullet
            BillBullet.Move(BillBulletMoveX, BillBulletMoveY)
        end
    else 
        placeholder = 1 
    end

    spawntimer = spawntimer + 1
end
