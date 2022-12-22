--Button Class
Button = {}
Button.__index = Button
 
function Button:getXEnd()
    return self.xPos + string.len(self.name)
end
 
function Button:getXPos()
    return self.xPos
end
 
function Button:getYPos()
    return self.yPos
end
 
function Button:onClick(func, val1, val2)
    func = func or nil
    val1 = val1 or nil
    val2 = val2 or nil
end
 
function Button:render(screen)
    screen.setBackgroundColor(self.color)
    screen.setCursorPos(self.xPos, self.yPos)
    
    if(self.color == colors.white) then
        screen.setTextColor(colors.black)
    end
    
    screen.write(self.name)
    screen.setTextColor(colors.white)
    screen.setBackgroundColor(colors.black)
end
 
function Button.new(name, xPos, yPos, color)
    local instance = setmetatable({}, Button)
    instance.name = name
    instance.xPos = xPos
    instance.yPos = yPos
    instance.color = color
    
    return instance
end
--End Button Class
 
rf = peripheral.find("redstoneIntegrator")
local callTop = peripheral.wrap("monitor_1")
local floorSelectTop = peripheral.wrap("monitor_0")
local callBottom = peripheral.wrap("monitor_3")
local floorSelectBottom = peripheral.wrap("monitor_2")
 
inputSide = "left"
 
local scale = 1
 
callTop.clear()
callTop.setTextScale(scale)
floorSelectTop.clear()
floorSelectTop.setTextScale(scale)
callBottom.clear()
callBottom.setTextScale(scale)
floorSelectBottom.clear()
floorSelectBottom.setTextScale(scale)
 
function elevatorUp()
    rf.setOutput(inputSide, false)    
end
 
function elevatorDown()
    rf.setOutput(inputSide, true)
end
 
function handleTopCallDisplay()
    local callBtn = Button.new("Call", 2, 2, colors.blue)
    callBtn:render(callTop)
    
    while(true) do
        local event, side, x, y = os.pullEvent("monitor_touch")
        if(x >= callBtn:getXPos() and x <= callBtn:getXEnd() and y == callBtn:getYPos() and side == "monitor_1") then
            elevatorUp()
        end
        os.sleep(0)
    end
end
 
function handleTopFloorSelectDisplay()
    local floorBtn = Button.new("Down", 2, 2, colors.blue)
    floorBtn:render(floorSelectTop)
 
    while(true) do
        local event, side, x, y = os.pullEvent("monitor_touch")
        if(x >= floorBtn:getXPos() and x <= floorBtn:getXEnd() and y == floorBtn:getYPos() and side == "monitor_0" ) then
            elevatorDown()
        end
        os.sleep(0)
    end
end
 
function handleBottomCallDisplay()
    local callBottomBtn = Button.new("Up", 2, 2, colors.blue)
    callBottomBtn:render(callBottom)
    
    while(true) do
        local event, side, x, y = os.pullEvent("monitor_touch")
        if(x >= callBottomBtn:getXPos() and x <= callBottomBtn:getXEnd() and y == callBottomBtn:getYPos() and side == "monitor_3") then
            elevatorUp()
        end
        os.sleep(0)
    end
end
 
function handleBottomFloorSelectDisplay()
    local floorBtnBottom = Button.new("Call", 2, 2, colors.blue)
    floorBtnBottom:render(floorSelectBottom)
    
    while(true) do
        local event, side, x, y = os.pullEvent("monitor_touch")
        if(x >= floorBtnBottom:getXPos() and x <= floorBtnBottom:getXEnd() and y == floorBtnBottom:getYPos() and side == "monitor_2") then
            elevatorDown()
        end
        os.sleep(0)
    end
end
 
parallel.waitForAll(handleTopCallDisplay, handleTopFloorSelectDisplay, handleBottomCallDisplay, handleBottomFloorSelectDisplay)