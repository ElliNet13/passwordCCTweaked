local password = require("password")
local sha256 = require("sha2").sha256

settings.load(".password_settings")

settings.define("password.hash", {
    description = "The password hash",
    default = "",
    type = "string",
})

if settings.get("password.hash") ~= "" then
    local attempt = password.read("Enter password:", true)
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

