##### WELCOME TO GILLICOM #####


DOCUMENTATION:

####TABLE OF CONTENTS####

1. Project Description
2. Label Class
3. Input Class
4. Button Class


===============================================

PROJECT DESCRIPTION:

Welcome to my computerCraft UI framework! The goal of this project is to create an easy to use, object oriented way to build simple UIs for your projects. Every class is lightweight and is easy to install and use.

LABEL CLASS:

    - Functions:
        -Label.new(name, xPos, yPos)

            -This line creates an instance of the label object. It takes a name, x position, and y position as parameters. The name of the label will be the string that is shown on the screen. The x and y coordinates will be where the FIRST letter of the label begins.
        
        -Label:render()

            -This function will render your label to the screen and should be used AFTER initializing the object.

        -Label:getName(), Label:getX(), Label:getY

            -Returns the parameters entered to set up the label object

        -Label:getInputX(), Label:getInputY()

            -These functions will give the x and y values that an input field should typically be.


INPUT CLASS:
    -Functions:
        -Input.new(xPos, yPos)

            -This line creates an instance of the label object. It takes the x position and y position as parameters and designate where the input will begin.

        -Input:read()

            - This function will begin the process of reading an input value. Value will be reset on running this command again.

        -Input:clearLine(amount)

            -This function will clear the input line by a specified amount. It takes the number of spaces to clear as the "amount" parameter. 


BUTTON CLASS:
    -Functions:
        -Button.new(name, xPos, yPos, color)

            -This line creates an instance of the Button object. It takes the name, x position, y position, and color of the buttons background.

        -Button:render()

            -Function that renders the Button object to the screen.

        -Button:onClick(func, val1, val2)

            -Function that can contain a custom function and can pass 2 values to it. Recommended to be used with the os.pullEvent("mouse_click") event.

        -Button:getXPos(), Button:getYPos()

            -Returns coordinates of the button

        -Button:getXEnd()

            -Returns the end x coordinate of the buttons label.