local password = require("password")
local sha256 = require("sha2").sha256

settings.load(".password_settings")

local myPass = password.read("Type your new password (Leave empty to clear):", false)

if myPass == "" then
    settings.set("password.hash", "")
    print("Password cleared.")
    return
end

if myPass ~= password.read("Retype your new password:", false) then
    print("Passwords do not match.")
    return
end

settings.set("password.hash", sha256(myPass))

settings.save(".password_settings")