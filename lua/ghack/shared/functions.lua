--Generate random password--
GHack = GHack or {}

local chars = string.Explode("","abcdefghijklmopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-_$")

function GHack.RandomPassword()
    local genpw = ""
    for i = 1,8 do
        genpw = genpw .. chars[math.random(1, #chars)]
    end
    return genpw
end
