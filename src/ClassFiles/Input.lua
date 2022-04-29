-- ========= Input Class ================
Input = {}
Input.__index = Input

function Input:clearLine(amount)
    term.setCursorPos(self.xPos, self.yPos)
    local xPos = self.xPos
    
    for i = 0, amount, 1
    do
        io.write(" ")
        xPos = xPos + 1
        term.setCursorPos(xPos, self.yPos)
    end
end

function Input:read()
    lineClearAmount = 10

    term.setCursorPos(self.xPos, self.yPos)
    local xPos = self.xPos
    
    for i = 0, lineClearAmount, 1
    do
        io.write(" ")
        xPos = xPos + 1
        term.setCursorPos(xPos, self.yPos)
    end

    term.setCursorBlink(true)
    term.setCursorPos(self.xPos, self.yPos)
    local input = io.read()

    return input
end

function Input.new(xPos, yPos)
    local instance = setmetatable({}, Input)
    instance.xPos = xPos
    instance.yPos = yPos

    return instance
end

function lineInput(xPos, yPos)
    term.setCursorBlink(true)
    term.setCursorPos(xPos, yPos)
    local input = io.read()

    return input
end
-- ======================================