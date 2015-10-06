GHack = {
    Tabs = {
        {text = "Home",            icon = "icon16/house.png"},
        {text = "Tasks",           icon = "icon16/monitor.png"},
        {text = "Software",        icon = "icon16/folder.png"},
        {text = "Internet",        icon = "icon16/world.png"},
        {text = "Logs",            icon = "icon16/report.png"},
        {text = "Hardware",        icon = "icon16/server.png"},
        {text = "Research",        icon = "icon16/book_add.png"},
        {text = "Finances",        icon = "icon16/money.png"},
        {text = "Hacked Database", icon = "icon16/database_key.png"},
        {text = "Missions",        icon = "icon16/package.png"},
    },
    Programs = {
        --Programs--
        {type = "Cracker",    ext = ".crc",     icon = "icon16/key.png"},
        {type = "Hasher",     ext = ".hash",    icon = "icon16/lock.png"},
        {type = "Firewall",   ext = ".fwl",     icon = "icon16/world_delete.png"},
        {type = "Hider",      ext = ".hdr",     icon = "icon16/eye.png"},
        {type = "Seeker",     ext = ".skr",     icon = "icon16/find.png"},
        {type = "Anti-Virus", ext = ".av",      icon = "icon16/bug_delete.png"},
        {type = "Collector",  ext = ".vcol",    icon = "icon16/money_dollar.png"},
        {type = "Port Scan",  ext = ".scan",    icon = "icon16/application_xp_terminal.png"},
        {type = "Exploit",    ext = ".exp",     icon = "icon16/application_key.png"},
        {type = "Analyzer",   ext = ".ana",     icon = "icon16/chart_curve.png"},
        {type = "Torrent",    ext = ".torrent", icon = "icon16/attach.png"},
        {type = "Text File",  ext = ".txt",     icon = "icon16/page_white.png"},
        {type = "Wallet",     ext = ".dat",     icon = "icon16/coins.png"},

        --Viruses--
        {type = "Spam",       ext = ".vspam",   icon = "icon16/bug.png"},
        {type = "Warez",      ext = ".vwarez",  icon = "icon16/bug.png"},
        {type = "DDoS",       ext = ".vddos",   icon = "icon16/bug.png"},
        {type = "Miner",      ext = ".vminer",  icon = "icon16/bug.png"},
    },
    Panel = {},
}

local MenuButton = {}

function MenuButton:Init()
    self:SetWide(200)
    self:SetTall(42)
    self:SetImage("icon16/error.png")
    self.btncol = Color(70,70,70)
end

function MenuButton:Paint(w,h)
    if self.Hovered then self.btncol = Color(80,80,80) else self.btncol = Color(70,70,70) end
    draw.RoundedBox(0,0,0,w,h,self.btncol)
    draw.RoundedBox(0,0,h-1,w,1,Color(80,80,80))
    draw.RoundedBox(0,0,h-2,w,1,Color(40,40,40))
end

function MenuButton:UpdateColours(skin)
    return self:SetTextStyleColor(Color(160,160,160))
end

vgui.Register("ghack_menu_button",MenuButton,"DButton")

local TablePanel = {}

function TablePanel:Init()
    self.top = vgui.Create("EditablePanel",self)
    self.top:Dock(TOP)
    self.top:SetTall(28)
    function self.top:Paint(w,h)
        --draw.RoundedBox(0,0,0,w,h,Color(220,220,220))
        --draw.RoundedBox(0,1,1,w-2,h-2,Color(235,235,235))
        draw.RoundedBox(0,0,0,30,h,Color(220,220,220))
        draw.RoundedBox(0,1,1,28,h-2,Color(235,235,235))
        draw.RoundedBox(0,28,0,346,h,Color(220,220,220))
        draw.RoundedBox(0,1,1,28,h-2,Color(235,235,235))
    end
end

function TablePanel:Paint(w,h)
    draw.RoundedBox(0,0,0,w,h,Color(220,220,220))
    draw.RoundedBox(0,1,1,w-2,h-2,Color(250,250,250))
end

vgui.Register("ghack_table",TablePanel,"EditablePanel")

local PANEL = {}

function PANEL:Init()
    self.active_tab = "Home"
    self.last_tab = self.active_tab
    self:SetSize(ScrW()-600,ScrH()-400)
    self:Center()
    self:MakePopup()
    self:SetTitle("GHack - A Garry's Mod based Hacker Experience.")
    self:SetIcon("games/16/garrysmod.png")
    self.btnMaxim:SetVisible(false)
    self.btnMinim:SetVisible(false)

    self.sidebar = vgui.Create("DScrollPanel",self)
    self.sidebar:Dock(LEFT)
    self.sidebar:SetWide(200)
    self.sidebar:DockMargin(-5,-5,-5,-5)

    self.header = vgui.Create("EditablePanel",self)
    self.header:Dock(TOP)
    self.header:SetTall(80)
    self.header:DockMargin(5,-5,-5,0)

    self.header.id = vgui.Create("DLabel",self.header)
    self.header.id:Dock(RIGHT)
    self.header.id:SetText(LocalPlayer():GetGHackIP())
    self.header.id:SetFont("DermaLarge")
    self.header.id:SetColor(Color(90,90,90))
    self.header.id:SizeToContents()
    self.header.id:DockMargin(0,-37,20,0)

    self.header.money = vgui.Create("DLabel",self.header)
    self.header.money:Dock(RIGHT)
    self.header.money:SetText("$"..LocalPlayer():GetGHackMoney())
    self.header.money:SetFont("DermaLarge")
    self.header.money:SetColor(Color(0,128,0))
    self.header.money:SizeToContents()
    self.header.money:DockMargin(0,32,20,0)

    self.header.active = vgui.Create("DLabel",self.header)
    self.header.active:Dock(LEFT)
    self.header.active:SetText(self.active_tab)
    self.header.active:SetFont("DermaLarge")
    self.header.active:SetColor(Color(85,85,85))
    self.header.active:SizeToContents()
    self.header.active:DockMargin(20,0,0,0)

    self.body = vgui.Create("DScrollPanel",self)
    self.body:Dock(FILL)
    self.body:DockMargin(5,0,-5,-5)

    self.tabs = {}

    for _,tab in pairs(GHack.Tabs) do
        self.tabs[tab.text] = vgui.Create("EditablePanel",self.body)
        self.tabs[tab.text]:SetSize(ScrW()-600-200,ScrH()-400-105)
        self.body:AddItem(self.tabs[tab.text])
        self.tabs[tab.text]:SetVisible(false)
    end

    self.tabs[self.active_tab]:SetVisible(true)

    function self.btnClose.Paint(pnl,w,h)
        draw.RoundedBox(0,0,0,w,h,Color(255,0,0))
        draw.DrawText("r","Marlett",w/2,h/4-1,Color(255,255,255),TEXT_ALIGN_CENTER)
    end

    function self.sidebar.Paint(pnl,w,h)
        draw.RoundedBox(0,0,0,w,h,Color(70,70,70))
    end

    function self.header.Paint(pnl,w,h)
        draw.RoundedBox(0,0,0,w,h,Color(250,250,250))
        draw.RoundedBox(0,0,h-1,w,1,Color(210,210,210))
    end

    --Panels--
    self.tabs["Software"].Tabs = vgui.Create("DPropertySheet",self.tabs["Software"])
    self.software_tabs = self.tabs["Software"].Tabs
    self.software_tabs:Dock(FILL)
    self.software_tabs:DockMargin(20,35,20,35)

    function self.software_tabs:Paint(w,h)
        draw.RoundedBox(0,0,0,w,20,Color(200,200,200))
        draw.RoundedBox(0,1,1,w-2,20,Color(230,230,230))
        draw.RoundedBox(0,0,20,w,h-20,Color(200,200,200))
        draw.RoundedBox(0,1,21,w-2,h-22,Color(250,250,250))
    end

    local softwares = vgui.Create("EditablePanel")
    local xhd = vgui.Create("EditablePanel")
    self.software_tabs:AddSheet("Softwares",   softwares, "icon16/folder.png")
    self.software_tabs:AddSheet("External HD", xhd,       "icon16/drive_network.png")

    for _,pnl in pairs(self.software_tabs.tabScroller.Panels) do
        if self.software_tabs.m_pActiveTab == pnl then
            function pnl:Paint(w,h)
                draw.RoundedBox(0,0,0,w,20,Color(200,200,200))
                draw.RoundedBox(0,1,1,w-2,20,Color(250,250,250))
            end
            pnl:SetTextColor(Color(70,70,70))
        else
            function pnl:Paint(w,h)
                draw.RoundedBox(0,0,0,w,20,Color(200,200,200))
                draw.RoundedBox(0,1,1,w-2,20,Color(230,230,230))
            end
            pnl:SetTextColor(Color(150,150,150))
        end
    end

    local software_table = vgui.Create("ghack_table",softwares)
    software_table:Dock(FILL)
    software_table:DockMargin(15,12,15,12)
end

function PANEL:Think()
    if self.active_tab != self.last_tab then
        self.header.active:SetText(self.active_tab)
        self.header.active:SizeToContents()
        self.tabs[self.active_tab]:SetVisible(true)
        self.tabs[self.last_tab]:SetVisible(false)
        self.last_tab = self.active_tab
    end

    for _,pnl in pairs(self.software_tabs.tabScroller.Panels) do
        if self.software_tabs.m_pActiveTab == pnl then
            function pnl:Paint(w,h)
                draw.RoundedBox(0,0,0,w,20,Color(200,200,200))
                draw.RoundedBox(0,1,1,w-2,20,Color(250,250,250))
            end
            pnl:SetTextColor(Color(70,70,70))
        else
            function pnl:Paint(w,h)
                draw.RoundedBox(0,0,0,w,20,Color(200,200,200))
                draw.RoundedBox(0,1,1,w-2,20,Color(230,230,230))
            end
            pnl:SetTextColor(Color(150,150,150))
        end
    end
end

function PANEL:PerformLayout()
    local titlePush = 0

    if IsValid(self.imgIcon) then
        self.imgIcon:SetPos( 5, 5 )
        self.imgIcon:SetSize( 16, 16 )
        titlePush = 16
    end

    self.btnMaxim:SetPos(0,0)
    self.btnMaxim:SetSize(0,0)

    self.btnMinim:SetPos(0,0)
    self.btnMinim:SetSize(0,0)

    self.lblTitle:SetPos( 8 + titlePush, 2 )
    self.lblTitle:SetSize(self:GetWide()-25-titlePush,20)

    self.btnClose:SetPos(self:GetWide()-48)
    self.btnClose:SetSize(48,24)
end

function PANEL:Paint(w,h)
    draw.RoundedBox(0,0,0,w,24,Color(40,40,40))
    draw.RoundedBox(0,0,24,w,h-24,Color(240,240,240))
end

vgui.Register("ghack_menu",PANEL,"DFrame")

hook.Add("PlayerSay","ghack_ui",function(ply,text)
    if text:match("^!ghack") and ply == LocalPlayer() then
        GHack.Panel = vgui.Create("ghack_menu")

        for _,tab in ipairs(GHack.Tabs) do
            local button = vgui.Create("ghack_menu_button",GHack.Panel.sidebar)
            button:SetText(tab.text)
            button:SetImage(tab.icon)
            button:Dock(TOP)

            function button:DoClick()
                GHack.Panel.active_tab = tab.text
            end
        end
    end
end)
