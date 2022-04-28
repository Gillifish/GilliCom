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

function Input:read()
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


-- ========= Button Class ===============
Button = {}
Button.__index = Button

function Button:render()
    return 0
end

function Button.new(xPos, yPos, width, height)
    local instance = setmetatable({}, Button)
    instance.xPos = xPos
    instance.yPos = yPos
    instance.width = width
    instance.height = height

    return instance
end
-- ======================================


-- =========> MAIN APPLICATION <=========

function login(user, pass)
    return 0
end

function loginWindow()
    GCLabel = Label.new("GilliCom V0.2", 1, 1)
    UserL = Label.new("Username:", 17, 9)
    PassL = Label.new("Password:", 17, 10)
    UInput = Input.new(UserL:getInputX(), UserL:getInputY())
    PInput = Input.new(PassL:getInputX(), PassL:getInputY())

    GCLabel:render()
    UserL:render()
    PassL:render()
    
    return 0
end

function renderPage(pageNum)
    if (pageNum == 1) then
        loginWindow()
    end
end

function events()
    local xMin = PassL:getInputX()
    local xMax = xMin + 6
    local userY = UserL:getInputY()
    local passY = PassL:getInputY()

    while true do
        local event, button, x, y = os.pullEvent("mouse_click")
        term.setCursorPos(x, y)
        if (x >= xMin and x <= xMax and y == userY) then
            userInput = UInput:read()
        end
        if (x >= xMin and x <= xMax and y == passY) then
            passInput = PInput:read()
        end
    end
    
    return 0
end

function Main()
    local login = 1

    term.clear()
    renderPage(login)
    events()
end

Main()