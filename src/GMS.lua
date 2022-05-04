-- ========= Label Class ================
Label = {}
Label.__index = Label

function Label:getName()
    return self.name
end

function Label:getX()
    return self.xPos
end

function Label:getY()
    return self.yPos
end

function Label:getInputX()
    return self.inputX
end

function Label:getInputY()
    return self.inputY
end

function Label.new(name, xPos, yPos)
    local instance = setmetatable({}, Label)
    instance.name = name
    instance.xPos = xPos
    instance.yPos = yPos
    instance.inputX = xPos + string.len(name)
    instance.inputY = yPos
    return instance
end

function Label:render()
    term.setCursorPos(self.xPos, self.yPos)
    io.write(self.name)
end

function renderLabel(name, xPos, yPos)
    term.setCursorPos(xPos, yPos)
    io.write(name)
end
-- ======================================

-- ========= Input Class ================
Input = {}
Input.__index = Input

function Input:getXPos()
    return self.xPos
end

function Input:getYPos()
    return self.yPos
end

function Input:getInLength()
    return self.inLength
end

function Input:getXEnd()
    return self.xPos + self.inLength
end

function Input:getBackgroundColor()
    return self.bGnd
end

function Input:clearLine()
    term.setCursorPos(self.xPos, self.yPos)
    local xPos = self.xPos
    term.clearLine()
    
    for i = 0, self.inLength, 1
    do
        term.setBackgroundColor(self.bGnd)
        io.write(" ")
        xPos = xPos + 1
        term.setCursorPos(xPos, self.yPos)
    end
    term.setBackgroundColor(colors.black)
end

function Input:read()

    term.setCursorPos(self.xPos, self.yPos)
    term.getBackgroundColor(self.bGnd)
    local xPos = self.xPos
    
    for i = 0, self.inLength, 1
    do
        term.setBackgroundColor(self.bGnd)
        io.write(" ")
        xPos = xPos + 1
        term.setCursorPos(xPos, self.yPos)
    end

    term.setCursorBlink(true)
    term.setCursorPos(self.xPos, self.yPos)
    local input = io.read()

    term.setBackgroundColor(colors.black)

    return input
end

function Input.new(inLength, xPos, yPos, bGnd)
    local instance = setmetatable({}, Input)
    instance.inLength = inLength
    instance.xPos = xPos
    instance.yPos = yPos
    instance.bGnd = bGnd

    return instance
end

function Input:render()
    paintutils.drawLine(self.xPos, self.yPos, self.xPos + self.inLength, self.yPos, self.bGnd)
    term.setBackgroundColor(colors.black)
end

function lineInput(xPos, yPos)
    term.setCursorBlink(true)
    term.setCursorPos(xPos, yPos)
    local input = io.read()

    return input
end
-- ======================================

-- ========= Button Class ===============
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

function Button:render()
    term.setBackgroundColor(self.color)
    term.setCursorPos(self.xPos, self.yPos)

    if (self.color == colors.white) then
        term.setTextColor(colors.black)
    end

    io.write(self.name)
    term.setTextColor(colors.white)
    term.setBackgroundColor(colors.black)
end

function Button.new(name, xPos, yPos, color)
    local instance = setmetatable({}, Button)
    instance.name = name
    instance.xPos = xPos
    instance.yPos = yPos
    instance.color = color

    return instance
end
-- ======================================


-- ========= Border Class ===============
Border = {}
Border.__index = Border

function Border:render()
    paintutils.drawLine(self.xPos, self.yPos, 52, self.yPos, self.bGnd)
end

function Border.new(xPos, yPos, bGnd)
    local instance = setmetatable({}, Border)
    instance.xPos = xPos
    instance.yPos = yPos
    instance.bGnd = bGnd

    return instance
end
-- ======================================

-- GilliCom Messaging System (GMS) --

function mainWindow()
    GMSLabel = Label.new("GMS 0.1", 45, 1)
    sendBtn = Button.new("Send", 20, 18, colors.blue)
    clearBtn = Button.new("Clear", 28, 18, colors.white)
    msgInput = Input.new(20, 16, 16, colors.gray)
    paintutils.drawBox(1, 1, 51, 14, colors.blue)

    GMSLabel:render()
    term.setBackgroundColor(colors.black)
    sendBtn:render()
    clearBtn:render()
    msgInput:render()

    mainWindowEvents()

    return 0
end

function mainWindowEvents()
    while true do
        local event, p1, p2, p3 = os.pullEvent()

        if event == "mouse_click" then
            local x = p2
            local y = p3
            if (x >= sendBtn:getXPos() and x <= sendBtn:getXEnd() and y == sendBtn:getYPos()) then
                term.setCursorPos(1,1)
                
            end
            if (x >= clearBtn:getXPos() and x <= clearBtn:getXEnd() and y == clearBtn:getYPos()) then
                msgInput:clearLine()
            end
            if (x >= msgInput:getXPos() and x <= msgInput:getXEnd() and y == msgInput:getYPos()) then
                msgInput:read()
            end
        end
    end
end

function renderPage(pageNum)
    term.clear()
    if pageNum == 1 then
        mainWindow()
    end
end

function GMS()
    local mainWindow = 1

    term.clear()
    renderPage(mainWindow)
end

GMS()