-- Disable terminate
local orginalPullEvent = os.pullEvent
os.pullEvent = os.pullEventRaw

-- Require
local sha256 = require("sha2").sha256

-- Load
settings.load(".password_settings")

settings.define("password.hash", {
    description = "The password hash",
    default = "",
    type = "string",
})

if settings.get("password.hash") ~= "" then
    local attempt = read("*")
    if sha256(attempt) == settings.get("password.hash") then
        term.clear()
        term.setCursorPos(1,1)
    else
        os.shutdown()
    end
else
    print("DATA IS NOT PROTECTED!")
    print("No password set. Please run setpassword to set one.")
end

-- Allow terminate again
os.pullEvent = orginalPullEvent