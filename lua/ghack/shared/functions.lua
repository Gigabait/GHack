--Generate random password--
GHack = GHack or {}

local chars = string.Explode("","abcdefghijklmopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-_$")

function GHack.RandomPassword()
    local genpw = {}
    for i = 1,8 do
        table.insert(genpw,nil,table.Random(chars))
    end
    genpw = string.Implode("",genpw)
    return genpw
end
