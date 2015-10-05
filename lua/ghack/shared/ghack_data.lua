local META = FindMetaTable("Player")

function META:GetGHackIP()
    if SERVER then
        if self:GetPData("ghack_ip") == nil then
            self:NewGHackIP()
        else
            return self:GetPData("ghack_ip")
        end
    elseif CLIENT then
        return self:GetNWString("ghack_ip")
    end
end

function META:GetGHackMoney()
    if SERVER then
        if self:GetPData("ghack_money") == nil then
            self:SetPData("ghack_money",100)
        else
            return self:GetPData("ghack_money")
        end
    elseif CLIENT then
        return self:GetNWInt("ghack_money")
    end
end

function META:SetGHackMoney(amt)
    self:SetPData("ghack_ip",amt)
    self:SetNWInt("ghack_ip",amt)
end

function META:SetGHackIP()
    self:SetNWString("ghack_ip",self:GetPData("ghack_ip"))
    self:SetPData("ghack_ip",self:GetPData("ghack_ip"))
end

function META:NewGHackIP()
    if CLIENT then return end
    local ip = tostring(math.random(1,255).."."..math.random(0,255).."."..math.random(0,255).."."..math.random(0,255))
    self:SetPData("ghack_ip",ip)
    self:SetNWInt("ghack_ip",ip)
    MsgC(Color(0,255,0),"[GHack] ",Color(255,255,255),"New GHack IP assigned for "..tostring(self).." ("..ip..")\n")
end

if SERVER then
    for _,p in pairs(player.GetAll()) do
        if p:GetPData("ghack_ip") == nil or p:GetPData("ghack_ip") == "no ip?" or p:GetPData("ghack_ip") == "nil" then
            p:NewGHackIP()
        end
        if p:GetPData("ghack_money") == nil then
            p:SetGHackMoney(100)
        end
        p:SetGHackIP()
    end

    hook.Add("PlayerDisconnect","GHack.SaveData",function(ply)
        ply:SetPData("ghack_ip",ply:GetPData("ghack_ip"))
        ply:SetPData("ghack_money",ply:GetPData("ghack_money"))
        MsgC(Color(0,255,0),"[GHack] ",Color(255,255,255),"Saved GHack data for "..tostring(ply).."\n")
    end)

    hook.Add("PlayerInitialSpawn","GHack.LoadData",function(ply)
        if ply:GetPData("ghack_ip") == nil then
            ply:NewGHackIP()
            ply:SetGHackIP()
        end

        ply:SetGHackIP()
        ply:SetNWInt(ply:GetPData("ghack_money") or 100)
        MsgC(Color(0,255,0),"[GHack] ",Color(255,255,255),"Loaded GHack data for "..tostring(ply).." (IP: "..ply:GetGHackIP()..")\n")
    end)
end

if CLIENT then
    LocalPlayer():SetGHackIP()
end
