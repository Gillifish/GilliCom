Label = {name = "", xPos = 0, yPos = 0}

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
    return self.xPos + string.len(self.name)
end

function Label:getInputY()
    return self.yPos
end

function Label:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Label:render()
    term.setCursorPos(self.xPos, self.yPos)
    io.write(self.name)
end

return Label