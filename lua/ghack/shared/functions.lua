--Generate random password--
GHack = GHack or {}

local chars = string.Explode("","abcdefghijklmopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-_$")

function GHack.RandomPassword()
    local genpw = {}
    for i = 1,8 do
        local toinsert = table.Random(chars)
        table.insert(genpw,toinsert)
    end
    genpw = string.Implode("",genpw)
    return genpw
end
