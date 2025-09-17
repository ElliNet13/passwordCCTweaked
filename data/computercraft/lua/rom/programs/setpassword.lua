local password = require("password")
local sha256 = require("sha2").sha256

settings.load(".password_settings")

local myPass = password.read("Type your new password:", false)

settings.set("password.hash", sha256(myPass))

settings.save(".password_settings")