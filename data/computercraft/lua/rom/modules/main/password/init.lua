-- passwordmodule.lua
local passwordmodule = {}

-- Draw the prompt and reset cursor
local function drawPrompt(prompt)
    term.clear()
    term.setCursorPos(1,1)
    print(prompt or "Enter password:")
    term.setCursorPos(1,2)
end

-- Read a password with masking and optional terminate handling
-- ignoreTerminate = true => catch Ctrl+T and reset input
-- ignoreTerminate = false/nil => terminate will crash program
function passwordmodule.read(prompt, ignoreTerminate)
    local password = ""
    local displayChar = "*"

    drawPrompt(prompt)

    term.setCursorBlink(true)

    while true do
        local event, param
        if ignoreTerminate then
            event, param = os.pullEventRaw()  -- catch terminate
        else
            event, param = os.pullEvent()     -- let terminate crash
        end

        if event == "char" then
            password = password .. param
            term.write(displayChar)
        elseif event == "key" then
            if param == keys.backspace and #password > 0 then
                password = password:sub(1, -2)
                local x, y = term.getCursorPos()
                term.setCursorPos(x - 1, y)
                term.write(" ")
                term.setCursorPos(x - 1, y)
            elseif param == keys.enter then
                break
            end
        elseif event == "terminate" and ignoreTerminate then
            -- Reset input instead of terminating
            password = ""
            drawPrompt(prompt)
        end
    end

    term.setCursorBlink(false)
    term.setCursorPos(1,4)
    return password
end

return passwordmodule
