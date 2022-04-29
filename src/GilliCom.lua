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

function Border.new()
    local instance = setmetatable({}, Border)

    return instance
end

-- ======================================

-- =========> MAIN APPLICATION <=========

function login(user, pass)
    username = "Gillifish"
    password = "3665"

    if (user == username and pass == password) then
        renderPage(2)
    end
    if (user ~= username or pass ~= password) then
        UInput:clearLine(10)
    end

    return 0
end

function loginWindow()
    GCLabel = Label.new("GilliCom V0.2", 1, 1)
    UserL = Label.new("Username:", 17, 9)
    PassL = Label.new("Password:", 17, 10)
    UInput = Input.new(UserL:getInputX(), UserL:getInputY())
    PInput = Input.new(PassL:getInputX(), PassL:getInputY())
    B1 = Button.new("Login", 22, 13, colors.blue)
    clearButton = Button.new("Clear", 28, 13, colors.white)

    B1:render()
    clearButton:render()
    GCLabel:render()
    UserL:render()
    PassL:render()

    loginEvents()
    
    return 0
end

function loginEvents()
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
        if (x >= B1:getXPos() and x <= B1:getXEnd() and y == B1:getYPos()) then
            B1:onClick(login(userInput, passInput))
        end

        if (x >= clearButton:getXPos() and x <= clearButton:getXEnd() and y == clearButton:getYPos()) then
            clearButton:onClick(clearFields())
        end

    end
    
    return 0
end

function mainWindow()
    backButton = Button.new("Logoff", 1, 1, colors.red)
    backButton:render()

    mainWindowEvents()

    return 0
end

function mainWindowEvents()
    local event, button, x, y = os.pullEvent("mouse_click")
    term.setCursorPos(x, y)
    if (x >= backButton:getXPos() and x <= backButton:getXEnd() and y == backButton:getYPos()) then
        backButton:onClick(renderPage(1))
    end
end

function renderPage(pageNum)
    term.clear()
    if (pageNum == 1) then
        loginWindow()
    end
    if (pageNum == 2) then
        mainWindow()
    end
end

function clearFields()
    UInput:clearLine(10)
    PInput:clearLine(10)
end

function GilliCom()
    local login = 1

    term.clear()
    renderPage(login)
end

GilliCom()