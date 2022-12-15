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

-- TODO: Item Selection
-- ========= SLabel Class ================
SLabel = {}
SLabel.__index = SLabel

function SLabel:getSelected()
    return self.selected
end

function SLabel:getName()
    return self.name
end

function SLabel:getX()
    return self.xPos
end

function SLabel:getY()
    return self.yPos
end

function SLabel:getInputX()
    return self.inputX
end

function SLabel:getInputY()
    return self.inputY
end

function SLabel.new(name, xPos, yPos)
    local instance = setmetatable({}, Label)
    instance.name = name
    instance.xPos = xPos
    instance.yPos = yPos
    instance.inputX = xPos + string.len(name)
    instance.inputY = yPos
    instance.labelLen = string.len(name)
    instance.selected = false
    return instance
end

function SLabel:toggle()
    local toggleCheck = 0
    if self.selected == false then
        local toggleCheck = 1
        self.selected = true

        term.setBackgroundColor(colors.gray)
        term.setTextColor(colors.black)
        term.setCursorPos(self.xPos, self.yPos)
        io.write(self.name)
        term.setBackgroundColor(colors.black)
        term.setTextColor(colors.white)
    end
    if self.selected == true and toggleCheck == 0 then
        self.selected = false
        term.setCursorPos(self.xPos, self.yPos)
        io.write(self.name)
    end
    toggleCheck = 0
end

function SLabel:render()
    term.setCursorPos(self.xPos, self.yPos)
    io.write(self.name)
end
-- ========================================

