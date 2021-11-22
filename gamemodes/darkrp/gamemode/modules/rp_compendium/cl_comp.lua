local me



local PANEL = {}

function PANEL:Init()
    self:Dock(TOP)
    self:DockPadding(5,0,5,5)
    self:DockMargin(5,5,5,5)
    self:SetTall(70)
    self:SetText('')
    self:SetHoveredColor(Color(29, 28, 30, 100))
end

function PANEL:CompendiumInit()
    self.CompendiumProgress = self:Add("DLabel")
    self.CompendiumProgress:Dock( LEFT )
    self.CompendiumProgress:SetFont( "font_base_24" )
    self.CompendiumProgress:SetText( 'Уровень боевого пропуска: ' .. LocalPlayer():GetCompendiumLevel())
    self.CompendiumProgress:DockMargin(10, 0, 0, 0)
    self.CompendiumProgress:SizeToContents()

    self.CompendiumProgress = self:Add("DLabel")
    self.CompendiumProgress:Dock( RIGHT )
    self.CompendiumProgress:DockMargin(20, 0, 0, 0)
    self.CompendiumProgress:SetFont( "font_base_normal" )
    self.CompendiumProgress:SetText( LocalPlayer():GetCompendiumLevel() + 1 )
    self.CompendiumProgress:SizeToContents()

    local lvl = LocalPlayer():GetCompendiumLevel()
    local current_exp = LocalPlayer():GetCompendiumExperience()
    local next_level_xp = math.Round(LocalPlayer():GetCompendiumNeedExperience())
    local remaining_percent = (LocalPlayer():GetCompendiumExperience() / LocalPlayer():GetCompendiumNeedExperience())

    self.progress = self:Add( "ZProgressbar")
    self.progress:Dock(FILL)
    self.progress:DockMargin(16, 4, 0, 4)
    self.progress:SetProgress(remaining_percent)

    self.progress.lerp = 0

    self.progress.Paint = function(self, w, h)

      self.lerp = Lerp( 100 * FrameTime(), self.lerp, self:GetProgress() )

      surface.SetDrawColor( Color(50, 50, 50, 150) )
      surface.DrawRect(0,0, w, h)

      -- the bar itself
      surface.SetDrawColor( Color(90, 190, 90, 150) )
      surface.DrawRect(0,0, w * self:GetProgress() - 2, h)

      -- shading
      surface.SetDrawColor( Color(0, 0, 0, 40) )
      surface.DrawRect(0,h/2, w  , h/2)

      surface.SetDrawColor( Color(70, 170, 70, 150) )

      draw.ShadowSimpleText( current_exp .. "xp / " .. ( next_level_xp ).."xp", "font_base_24", w/2, h/2, color_white, 1, 1 )
    end
end

function PANEL:PerformLayout()
    self.progress:SetTall(self:GetTall())
end

derma.DefineControl("rp.CompendiumHeader", "Compendium Header", PANEL, "monoButton")



local PANEL = {}

function PANEL:Init()



	self.back = vgui.Create("DPanel", self)
	self.back:SetSize(self:GetWide(),self:GetTall())
	

	function self.back:Paint(w,h)
		draw.Circle( {x = w/2, y = h/2}, w*0.5, 40, self.clr or Color( 0, 255, 0, 200 ) )
		draw.Circle( {x = w/2, y = h/2}, w*0.5-3, 40, Color( 230, 230, 230, 255 ) )
	end

	
    self.reward = vgui.Create("SpawnIcon", self)
    self.reward.lvl = self.lvl
    self.reward.isDonate = self.isDonate
    self.reward:SetSize(self:GetWide(),self:GetTall())
	self.reward:SetModel("models/weapons/c_crowbar_frame.mdl")
	self.reward.PaintOver = function() end
    self.reward.DoClick = function()         
        net.Start("GivePlayerRewards")
            net.WriteInt(self.lvl, 10)
            net.WriteBool(self.isDonate)
        net.SendToServer()
    end

end

function PANEL:SetModel(model)
    self.reward:SetModel(model)
end

function PANEL:SetToolTip(text)
    self.reward:SetToolTip(text)
end

function PANEL:SetIcon(icon)
    self.reward:SetIcon(icon)
end

function PANEL:SetMaterial(mat)
    self.reward:SetMaterial(mat)
end

function PANEL:SetCircleColor(clr)
    self.back.clr = clr
end

function PANEL:Paint(w,h) 

end

function PANEL:PerformLayout()
	self.back:SetSize(self:GetWide()-5,self:GetTall())
	self.reward:SetSize(self:GetWide()-5,self:GetTall())
end

derma.DefineControl("rp.ModelBox", "Model Box", PANEL, "DPanel")

local PANEL = {}

function PANEL:Init()
    self:Dock(FILL)
    self:DockPadding(5,5,5,5)
    self:DockMargin(5,5,5,5)
    self:SetText('')
    self.rewards = {}
    self.rewardsbar = {}
    self.rewarditem = {}
end

function PANEL:RewardsInit()
	local sbar = self:GetVBar()
	function sbar:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
	end
	function sbar.btnUp:Paint(w, h)
		draw.Triangle(0, 0, w, h, TRIANGLE_TOP, Color(255,255,255,200))
	end
	function sbar.btnDown:Paint(w, h)
		draw.Triangle(0, 0, w, h, TRIANGLE_BOT, Color(255,255,255,200))
	end
	function sbar.btnGrip:Paint(w, h)
		draw.RoundedBox(64, 0, 0, w, h, Color(50,50,50,255))
        draw.RoundedBox(64, 2, 2, w-4, h-4, Color(255,255,255,200))
	end
end



function PANEL:BuildRewards(type, data, parent, lvl, isDonate)
	local invtypes = {"hats", "entity", "weapon", "food"}
	local moneyicon = Material('samprp/moreicons/money_pack.png', 'noclamp smooth')
	local caseicon = Material('samprp/moreicons/gift.png', 'noclamp smooth')
	local mat_sponsor = Material('samprp/moreicons/crown.png', 'noclamp smooth')
	local mat_userplus = Material('samprp/moreicons/man_madd.png', 'noclamp smooth')
	local mat_vip = Material('samprp/moreicons/heart.png', 'noclamp smooth')
	local mat_premium = Material('samprp/moreicons/gift_coin.png', 'noclamp smooth')

	local function timeToStr( time )
	  local tmp = time
	  local s = tmp % 60
	  tmp = math.floor( tmp / 60 )
	  local m = tmp % 60
	  tmp = math.floor( tmp / 60 )
	  local h = tmp % 24
	  tmp = math.floor( tmp / 24 )
	  local d = tmp % 7
	  local w = math.floor( tmp / 7 )

	  return string.format( "%02iн %iд %02iч %02iмин %02iсек", w, d, h, m, s )
	end




    local reward = vgui.Create( "rp.ModelBox", parent) 
    reward:Dock(LEFT)
    reward:DockMargin(0,10,0,10)
    reward:SetSize(75,50)
    reward.lvl = lvl
    reward.isDonate = isDonate


    if table.HasValue(invtypes, type) then                   
        local item = Inventory.GetItem(type, data)
        if item then
            reward:SetModel(item.model)
            reward:SetToolTip(item.name)
            if type == "weapon" then
                reward:SetCircleColor(Color(186, 0, 0))
            elseif type == "entity" then
                reward:SetCircleColor(Color(0, 186, 174))
            else
                reward:SetCircleColor(Color(0, 0, 0))
            end
        end
    end
    if type == "money" then
        reward:SetModel("models/props/cs_assault/money.mdl")
        reward:SetCircleColor(Color(39, 214, 0))
        reward:SetToolTip("Монеты: "..data)

        local label = vgui.Create("DLabel", reward)
        label:SetFont("rp.ui.22")
        label:SetTextColor( Color(0,0,0) )
        label:SetPos(reward:GetWide()*0.2, reward:GetTall()*0.9)
        label:SetText(data .. " м.")

        local label = vgui.Create("DLabel", reward)
        label:SetFont("rp.ui.22")
        label:SetTextColor( Color(255,255,255) )
        label:SetPos(reward:GetWide()*0.2+1, reward:GetTall()*0.9+1)
        label:SetText(data .. " м.")
    end
    if type == "case" then
        reward:SetModel("models/props_wasteland/controlroom_filecabinet002a.mdl")
        reward:SetToolTip("Кейс со случайным содержимым")
        reward:SetCircleColor(Color(170, 0, 255))
    end    
    if type == "vip1mo" then
        reward:SetMaterial(mat_vip)
        reward:SetToolTip("Статус VIP на: "..timeToStr(data))
    end    
    if type == "premium1mo" then
        reward:SetMaterial(mat_premium)
        reward:SetToolTip("Статус Premium на: "..timeToStr(data))
    end  
    if type == "igrokplus1mo" then
        reward:SetMaterial(mat_userplus)
        reward:SetToolTip("Статус Игрок+ на: "..timeToStr(data))
    end    
    if type == "sponsor1mo" then
        reward:SetMaterial(mat_sponsor)
        reward:SetToolTip("Статус Спонсор на: "..timeToStr(data))
    end                  

    parent:AddPanel( reward )
end

function PANEL:PerformLayout()
    self:SetTall(self:GetParent():GetTall()*0.8)
	for i=1, #rp.Compendium.Rewards do
		if self.rewards[i] then continue end
        -- for k, v in pairs(self.rewards) do
        --     function v:PaintOver( w, h )
        --         draw.ShadowSimpleText(k, "font_base", w/2, h*0.03, color_white, 1, 1)
        --         surface.SetDrawColor(Color(190,190,190))
        --         surface.DrawRect(0, h*0.055, w, 2)
        --     end
        -- end

        self.rewards[i] = vgui.Create( "monoPanel", self ) 
        self.rewards[i]:Dock( TOP )
        self.rewards[i]:SetWide(self:GetWide())
        self.rewards[i]:SetTall(90)
        self.rewards[i]:DockMargin(5,5,5,5) 
        self.rewards[i].clr = Color(math.random(30,255),math.random(30,255),math.random(30,255))
        local rewards = self.rewards[i]
        function rewards:Paint( w, h )
            surface.SetDrawColor(Color(30,30,30, 255))
            surface.DrawRect(0, 0, w*0.10, h)
            surface.SetDrawColor(Color(30,30,30, 70))
            surface.DrawRect(0, 0, w, h)
            draw.ShadowSimpleText(i, "rp.ui.40", w*0.05, h/2, color_white, 1, 1)
            surface.SetDrawColor(Color(255,255,255,5))
            surface.DrawRect(0, h-1, w, 1)

            surface.SetDrawColor(self.clr)
            surface.DrawRect(0, 0, w*0.1, 4)

            surface.SetDrawColor(self.clr)
            surface.DrawRect(0, 0, w*0.1, 4)
        end




		self.rewards[i]:SetWide(self:GetWide())

		local parent = self.rewards[i]


		----------Разделитель------
	    ---------------------------

	    self.rewards[i].divider = vgui.Create( "DPanel", self.rewards[i] ) 
	    local divider = self.rewards[i].divider
	    divider:SetWide(1)
	    divider:SetTall(parent:GetTall()-20)
	    divider:SetPos(parent:GetWide()*0.1+265, 10)
	    function divider:Paint( w, h )
	    	draw.RoundedBox( 5, 0, 0, w, h, Color(200,200,200,150) )
	    end



		---------Обычные награды---
		---------------------------

		self.rewards[i].rewardbox1 = vgui.Create( "DHorizontalScroller", self.rewards[i] ) 
		local rewards = self.rewards[i].rewardbox1
	    rewards:SetWide(250)
	    rewards:SetTall(parent:GetTall())
	    rewards:SetPos(parent:GetWide()*0.1, 0)
	    rewards:SetOverlap( -5 )

	    function rewards:Paint( w, h )    
	    	if rp.Compendium.Rewards[i] == nil or table.IsEmpty(rp.Compendium.Rewards[i]) then
	    		surface.SetDrawColor(Color(0,0,0, 40))
            elseif me.comp.rewards[i] == true then
                surface.SetDrawColor(Color(255,60,60, 40))
            elseif me:GetNVar('CompendiumLevel') >= i then
                surface.SetDrawColor(Color(60,255,60, 40))
            else
                surface.SetDrawColor(Color(0,0,0, 40))
            end
	        surface.DrawRect(0, 0, w, h-2)
	    end

	    function rewards.btnLeft:Paint( w, h )
	        draw.ShadowSimpleText("<", "font_base_24", 10, 5, color_white, 1, 1)
	    end
	    function rewards.btnRight:Paint( w, h )
	        draw.ShadowSimpleText(">", "font_base_24", 10, 5, color_white, 1, 1)
	    end
	    

	    if not rp.Compendium.Rewards[i] then continue end
	    for type, data in pairs(rp.Compendium.Rewards[i]) do
            self:BuildRewards(type, data, rewards, i, false)
	    end


		------------Донат-награды----
		-----------------------------

	    self.rewards[i].rewardbox2 = vgui.Create( "DHorizontalScroller", self.rewards[i] ) 
		local rewards = self.rewards[i].rewardbox2
	    rewards:SetWide(parent:GetWide() - parent:GetWide()*0.1 - 280 - 30)
	    rewards:SetTall(parent:GetTall())
	    rewards:SetPos(parent:GetWide()*0.1+280, 0)
	    rewards:SetOverlap( -5 )

	    function rewards:Paint( w, h )  
	    	if rp.Compendium.DonateRewards[i] == nil or table.IsEmpty(rp.Compendium.DonateRewards[i]) then
	    		surface.SetDrawColor(Color(0,0,0, 40))
            elseif me.comp.drewards[i] == true then
                surface.SetDrawColor(Color(255,60,60, 40))
            elseif me:GetNVar('CompendiumLevel') >= i then
                surface.SetDrawColor(Color(60,255,60, 40))
            else
                surface.SetDrawColor(Color(0,0,0, 40))
            end
	        surface.DrawRect(0, 0, w, h-2)
	    end

	    function rewards.btnLeft:Paint( w, h )
	        draw.ShadowSimpleText("<", "font_base_24", 10, 5, color_white, 1, 1)
	    end
	    function rewards.btnRight:Paint( w, h )
	        draw.ShadowSimpleText(">", "font_base_24", 10, 5, color_white, 1, 1)
	    end
	    

	    if not rp.Compendium.DonateRewards[i] then continue end
	    for type, data in pairs(rp.Compendium.DonateRewards[i]) do
	    	self:BuildRewards(type, data, rewards, i, true)
	    end



        ------------Блокировка второй линии----
        ---------------------------------------

        if me:GetNVar('HasCompUpgrade') ~= true then
            self.rewards[i].disable = vgui.Create( "DPanel", self.rewards[i]) 
            local disable = self.rewards[i].disable
            disable:SetWide(parent:GetWide() - parent:GetWide()*0.1 - 250 - 15)
            disable:SetTall(parent:GetTall())
            disable:SetPos(parent:GetWide()*0.1+260, 0)
            function disable:Paint( w, h )
                surface.SetDrawColor(Color(0,0,0, 190))
                surface.DrawRect(0, 0, w, h)
            end
        end
	end

end


derma.DefineControl("rp.CompendiumRewards", "Compendium Rewards", PANEL, "DScrollPanel")


local PANEL = {}

function PANEL:Init()
    me = LocalPlayer()
	me.comp = me.comp or {}
	me.comp.rewards = me.comp.rewards or {}
	me.comp.drewards = me.comp.drewards or {}


    self.Compendium = self:Add( "monoPanel" )
    self.Compendium:Dock(FILL)
    self.Compendium:Clear()
    self.Compendium.Paint = function(self, w, h) end

    self.CompendiumProgress = self.Compendium:Add( "rp.CompendiumHeader")  
    self.CompendiumProgress:Dock(TOP)
    self.CompendiumProgress:SetTall(40)
    self.CompendiumProgress:CompendiumInit()
    self.CompendiumProgress:SetDisabled(true)

    -- self.CompendiumReset = self.Compendium:Add("monoButton")
    -- self.CompendiumReset:Dock( TOP )
    -- self.CompendiumReset:SetTall(30)
    -- self.CompendiumReset:SetFont( "font_base_24" )
    -- self.CompendiumReset:SetText( 'Сбросить уровень' )
    -- self.CompendiumReset:DockMargin(10, 0, 0, 0)
    -- self.CompendiumReset:SizeToContents()
    -- self.CompendiumReset:DockPadding(5,0,5,5)
    -- self.CompendiumReset:DockMargin(5,5,5,5)

    self.rewardsdesc = self.Compendium:Add( "DLabel")
    self.rewardsdesc:Dock(TOP)    
    self.rewardsdesc:SetTall(40)
    self.rewardsdesc:DockPadding(5,0,5,5)
    self.rewardsdesc:DockMargin(5,5,5,5)
    self.rewardsdesc:SetText("  Увеличивайте уровень вашего боевого пропуска и получайте различные награды. Достигнув 300 уровень боевого пропуска, вы получите уникальную награду.")
    self.rewardsdesc:SetFont("font_base_18")
    self.rewardsdesc:SetWrap(true)
    self.rewardsdesc:SetContentAlignment(7)
    self.rewardsdesc.Paint = function( self, w, h ) 
        surface.SetDrawColor(30, 30, 30, 100)
        surface.DrawRect(0, 0, w, h)
    end

    self.rewardtypes = self.Compendium:Add( "DLabel")
    self.rewardtypes:Dock(TOP)    
    self.rewardtypes:SetTall(25)
    self.rewardtypes:DockMargin(5,5,5,0)
    self.rewardtypes:SetText("")
    self.rewardtypes:SetFont("rp.ui.28")
    self.rewardtypes:SetContentAlignment(6)
    self.rewardtypes.Paint = function( self, w, h ) 
        surface.SetDrawColor(252, 248, 0, 150)
        surface.DrawRect(w*0.55, 0, w*0.40, h)

        surface.SetDrawColor(30, 30, 30, 255)
        surface.DrawRect(w*0.55+1, 1, w*0.40-2, h-2)

        draw.ShadowSimpleText("Доступно с пропуском", "rp.ui.26", w*0.75, 0, Color(255,255,255,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    end

    self.rewards = self.Compendium:Add( "rp.CompendiumRewards")
    self.rewards:Dock(TOP)
    self.rewards:RewardsInit()

end

function PANEL:PerformLayout()
	self:SetWide(self:GetParent():GetWide())
	self:SetTall(self:GetParent():GetTall())
end

vgui.Register('rp.CompendiumMenu', PANEL, 'monoPanel')






net.Receive("SendRewardsToClient", function()
    me = me or LocalPlayer()
    me.comp = me.comp or {}
    me.comp.rewards = me.comp.rewards or {}
    me.comp.drewards = me.comp.drewards or {}

    me.comp.rewards = net.ReadTable()
    me.comp.drewards = net.ReadTable()
end)