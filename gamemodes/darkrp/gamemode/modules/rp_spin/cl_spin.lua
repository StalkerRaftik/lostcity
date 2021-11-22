hasInited = false

function init2233()

	if hasInited == false and IsValid(LocalPlayer()) then
		LocalPlayer().unboxing = {}
		LocalPlayer().unboxing.crates = 0

		hasInited  = true

		net.Start("GetSpawnUpdateUnbox")
		net.SendToServer()

	end

end

hook.Add( "Think", "InitThePlayer", init2233 )

surface.CreateFont( "SpinFont", { font = "Nexa Bold", size = 30, weight = 500, blursize = 0, scanlines = 0, antialias = true, underline = false, italic = false, strikeout = false, symbol = false, rotary = false, shadow = false, additive = false, outline = false} )
surface.CreateFont( "SpinFont2", { font = "Nexa Bold", size = 40, weight = 500, blursize = 0, scanlines = 0, antialias = true, underline = false, italic = false, strikeout = false, symbol = false, rotary = false, shadow = false, additive = false, outline = false} )
surface.CreateFont( "SpinFont3", {font = "Nexa Bold",size = 60,weight = 500,blursize = 0,scanlines = 0,antialias = true,underline = false,italic = false,strikeout = false,symbol = false,rotary = false,shadow = false,additive = false,outline = false,} )
surface.CreateFont( "SpinButton4", {font = "Nexa Bold", size = 17, weight = 500, blursize = 0, scanlines = 0, antialias = true, underline = false, italic = false, strikeout = false, symbol = false, rotary = false, shadow = false, additive = false, outline = false} )
surface.CreateFont( "SpinButton5", {font = "Nexa Bold", size = 20, weight = 500, blursize = 0, scanlines = 0, antialias = true, underline = false, italic = false, strikeout = false, symbol = false, rotary = false, shadow = false, additive = false, outline = false} )

local Frame = nil
local SpinPanel = nil
local items = {}
local isSpinning = false

UnboxWindowOpen = false
IsUnboxingItems = false

local OpenIcon = Material("unboxing/icon_padlock.png")

function OpenStore()
    local rewards = {}
    local rewardsbar = {}
    local rewarditem = {}
	if IsValid(Frame) then Frame:Remove() end

	Frame = vgui.Create("DFrame")
	Frame:SetSize(ScrW(), ScrH())
	Frame:SetSkin('core')
	Frame:MakePopup()
	Frame:SetDeleteOnClose(true)
	Frame:ShowCloseButton(false)
	Frame:SetTitle("")
    Frame:SetDraggable(false)
	-- Frame.Paint = function(self , w ,h)
	-- 	draw.RoundedBox(0,0,0,w,h,Color(20,20,20,255))
	-- end

	Frame.OnClose = function(self)

		UnboxWindowOpen = false
		self:Remove()

	end

	CloseButton = vgui.Create("DButton" , Frame)
	CloseButton:SetSize(20,20)
	CloseButton:SetPos(Frame:GetWide()/1.02, 2)
	CloseButton:SetText("")
	CloseButton.Paint = function(self , w , h)

		if IsUnboxingItems == false then

			draw.RoundedBox(0,0,0,w,h,Color( 85 , 125 , 37))

		else

			draw.RoundedBox(0,0,0,w,h,Color(60,60,60))

		end

			surface.SetTextColor(Color( 180,180,180))
			surface.SetFont("SpinButton5")
			local x = surface.GetTextSize("X")/2
			surface.SetTextPos((w/2 )- x , 0)
			surface.DrawText("X")


	end
	CloseButton.DoClick = function(self)

		if IsUnboxingItems == false then

			Frame:Close()

		end

	end

	IconPanel = Frame:Add("DPanel")
    IconPanel:Dock(TOP)
	IconPanel:SetSize(Frame:GetWide(),380)
	IconPanel.Paint = function(self , w , h)
        -- draw.RoundedBox(0,0,0,w,h,Color( 85 , 125 , 37))
		-- surface.SetMaterial(OpenIcon )
		-- surface.SetDrawColor(120,120,120)
		-- surface.DrawTexturedRect(w/2, h/1.5, 124, 124)
	end

	UnboxCrate = IconPanel:Add("BButton")
	UnboxCrate:SetSize(190 , 40)
	UnboxCrate:Dock(BOTTOM)
	-- UnboxCrate:SetPos(Frame:GetWide()/2.15, Frame:GetTall()/2.9)
	UnboxCrate:SetText("Открыть кейс")
	UnboxCrate.DoClick = function()
		if LocalPlayer().unboxing.crates > 0 and IsUnboxingItems == false then

			net.Start("OpenCrate")
			net.SendToServer()

		end
	end

	RewardsPanel = Frame:Add("DPanel")
	RewardsPanel:Dock(FILL)
	RewardsPanel.Paint = function(self , w , h)
        -- draw.ShadowSimpleText("Возможные награды", "font_base", w/2, 0, color_white, 1, 1)
	end

    rewardsscroller = RewardsPanel:Add("DHorizontalScroller")
    rewardsscroller:Dock( FILL )
    rewardsscroller:DockMargin(10,24,10,0)
    rewardsscroller:SetOverlap( -10 )
    function rewardsscroller.btnLeft:Paint( w, h )
        draw.ShadowSimpleText("<", "font_base_24", 0, 0, color_white, 1, 1)
    end
    function rewardsscroller.btnRight:Paint( w, h )
        draw.ShadowSimpleText(">    ", "font_base_24", 0, 0, color_white, 1, 1)
    end
    function rewardsscroller:Paint( w, h )
        surface.SetDrawColor(Color(30,30,30, 40))
        surface.DrawRect(0, 0, w, h)
    end


    for i, reward in pairs(rp.Spin.Rewards) do
        if rewards[i] then continue end
        rewards[i] = vgui.Create( "monoPanel", rewardsscroller )
        rewards[i]:Dock( LEFT )
        rewards[i]:SetWide(rewardsscroller:GetWide()*4)
        rewards[i]:DockMargin(5,5,5,5)
        rewards[i].data = reward
        for k, v in pairs(rewards) do
            function v:Paint( w, h )
                surface.SetDrawColor(Color(30,30,30, 255))
                surface.DrawRect(0, 0, w, h*0.054)
                surface.SetDrawColor(Color(30,30,30, 150))
                surface.DrawRect(0, 0, w, h)
                draw.ShadowSimpleText(v.data.name, "font_base", w/2, h*0.02, color_white, 1, 1)
                surface.SetDrawColor(rp.Spin.Chance[v.data.rarity].color)
                surface.DrawRect(0, h*0.055, w, 2)
                if v.data.icon then
                    surface.SetMaterial(v.data.icon )
                    surface.SetDrawColor(255,255,255)
                    surface.DrawTexturedRect(w/4, h/3, 124, 124)
                end
            end
        end

        rewardsbar[i] = vgui.Create( "DScrollPanel", rewards[i] )
        rewardsbar[i]:Dock( FILL )
        rewardsbar[i]:SetWide(rp.Spin.Rewards[i] and rewards[i]:GetWide()*2 or 40)
        rewardsbar[i]:DockMargin(5,30,5,5)
        rewardsbar[i].sbar = rewardsbar[i]:GetVBar()
        rewardsbar[i].sbar.Paint = function( self, w, h ) draw.RoundedBox( 4, 3, 13, 8, h-24, Color(0,0,0,70)) end
        rewardsbar[i].sbar.btnUp.Paint = function( self, w, h ) end
        rewardsbar[i].sbar.btnDown.Paint = function( self, w, h ) end
        rewardsbar[i].sbar.btnGrip.Paint = function( self, w, h ) draw.RoundedBox( 4, 5, 0, 4, h+22, Color(0,0,0,70)) end
    end

    for id, reward in pairs(rp.Spin.Rewards) do
        for k, v in pairs(rewardsbar) do
            if id == k then
                if rewarditem[id] then continue end
                if not reward.items then continue end
                if reward.type == "PRIVEL" then continue end
                if reward.type == "LEVEL" then continue end
                if reward.type == "MONEY" then continue end
                if reward.type == "DONATEMONEY" then continue end
                for class, rewardtab in pairs(reward.items) do
                    local item = Inventory.GetItem(rewardtab.type and rewardtab.type or reward.type, class)
                    if not item then continue end
                    -- PrintTable(item)
                    rewarditem[id] = v:Add("rp.itemmodel")
                    rewarditem[id]:Dock(TOP)
                    rewarditem[id]:SetPos( 0, 0 )
                    rewarditem[id]:SetModel(item.model)
                    if reward.type == "hats" then
                        rewarditem[id]:SetSkin(Cosmetics.Items[class].skin or 0)
                    end
                    rewarditem[id]:SetTall(150)
                    rewarditem[id]:DockMargin(5,15,5,5)
                    rewarditem[id]:CenterCamera(1)
                    rewarditem[id]:SetColor(rp.Spin.Chance[rewardtab.rarity].color)
                end
            end
        end
    end

	CreateWindow()
	GenerateItems(GenerateSpinList())
	ShiftItems()

end


function GenerateSpinList()

	local totalChance = 0

	for k , v in pairs(rp.Spin.Items) do
		totalChance = totalChance + v.itemChance
	end

	local itemList = {}

	for i = 0  , 99 do

		local num = math.random(1 , totalChance)
		local prevCheck = 0
		local curCheck = 0

		local item

		for k ,v in pairs(rp.Spin.Items) do
			if num >= prevCheck and num <= prevCheck + v.itemChance then
				item = v
			end
			prevCheck = prevCheck + v.itemChance
		end

		itemList[i] = item

	end

	return itemList


end

function ShiftItems()
	for k ,v in pairs(items) do
		v.panel:SetPos(v.xPos + 2000 , 10)
	end
end

function CreateWindow()

	UnboxWindowOpen = true

	SpinPanel = vgui.Create("DPanel" , Frame)
	SpinPanel:SetPos(Frame:GetWide()*0.03, Frame:GetTall()*0.05)
	SpinPanel:SetSize(Frame:GetWide()/1.05 , 300)
	SpinPanel.Paint = function(self, w ,h)
		draw.RoundedBox(0,0,0,w,h,Color(30,30,30))
	end

end

function GenerateItems(DataTable)

	local randomItems = DataTable

	for i = 0 , 99 do

		items[i] = {}
		items[i].xPos = ((((280 + 10) * i) * -1) + ((280 + 10)/2)) - 80

		items[i].panel = vgui.Create("DPanel" , SpinPanel)
		items[i].panel.id = i
		items[i].panel.item = randomItems[i]
		items[i].panel:SetPos( ((((280 + 10) * i) * -1) + ((280 + 10)/2)) - 55 ,10)
		items[i].panel:SetSize(280 , 280)
		items[i].panel.Paint = function(self , w , h)
			draw.RoundedBox(0,0,0,w,h,Color(180,180,180))
			draw.RoundedBox(0,0,h-80,w,80,self.item.itemColor)
			draw.ShadowSimpleText(self.item.itemName , "SpinFont", w/2 ,h/1.2 , Color(255,255,255), 1, 1)
		end

		if randomItems[i].Type ~= "DONATEMONEY" and randomItems[i].Type ~= "LEVEL" and randomItems[i].Type ~= "PRIVEL" then

			items[i].modelView  = vgui.Create("DModelPanel" , items[i].panel )
			items[i].modelView:SetSize(280,200)
			-- PrintTable(items[i].panel.item)
			items[i].modelView:SetModel(items[i].panel.item.itemModel)
            if items[i].panel.item.itemType == "hats" then
                items[i].modelView:SetSkin(Cosmetics.Items[items[i].panel.item.itemClass].skin or 0)
            end

			local min, max = items[i].modelView.Entity:GetRenderBounds()

			items[i].modelView:SetCamPos(min:Distance(max) * Vector(0.7, 0.7, 0.7))
			items[i].modelView:SetLookAt((max + min) / 2)

		else

			items[i].modelView  = vgui.Create("DImage" , items[i].panel )
			items[i].modelView:SetSize(200,200)
			items[i].modelView:SetPos(40,0)
			items[i].modelView:SetImage(randomItems[i].itemIcon)


		end

	end

	Line = vgui.Create("DPanel" , SpinPanel)
	Line:SetSize(SpinPanel:GetWide(), 300)
	Line.Paint = function(self , w , h)
		draw.RoundedBox(0,w/2, 0 , 4 , h , Color(244,129,0 , 150))
	end

end

net.Receive("InitSpin" , function()

	local data = net.ReadTable()

	Spin(data)

end)

Speed = 10000
EndPoint = 0

function Spin(data)

	CreateWindow()

	for k ,v in pairs(items) do

		if IsValid(items[k].panel) then

			items[k].panel:Remove()
			items[k].modelView:Remove()

		end

	end

	if IsValid(Line) then
		Line:Remove()
	end

	IsUnboxingItems = true

	GenerateItems(data)

	isSpinning = true
	Speed = math.random(15000 , 18000)
	EndPoint = (280*7) + (math.random(20,250))
end

local prevItemValue = 0



function SpinItems()

	Speed = Lerp(0.4*FrameTime() , Speed , EndPoint )

	if math.floor(Speed / (280 + 10)) ~= prevItemValue then

		LocalPlayer():EmitSound("unboxing/next_item.wav")

	end

	for k ,v in pairs(items) do

		v.panel:SetPos(v.xPos + Speed , 10)

	end

	if Speed < EndPoint  + 100 then

		isSpinning = false

		LocalPlayer():ChatPrint(items[prevItemValue].panel.item.itemName)

		net.Start("FinishedUnbox")
			net.WriteInt(math.floor(Speed / (280)) , 16)
		net.SendToServer()

		surface.PlaySound("buttons/lever6.wav")

		IsUnboxingItems = false

	end

	prevItemValue = math.floor(Speed / (280 + 10))

end

function spinUpdate()

	if isSpinning then

		SpinItems()

	end


end


hook.Add("Think" , "Spin The Items" , spinUpdate)

net.Receive("OpenUnboxMenu" , function()

	OpenStore()

end)




net.Receive("UnboxUpdate" , function(len)
	local crates = net.ReadInt(16)

	LocalPlayer().unboxing = {}
	LocalPlayer().unboxing.crates = crates

end)


local hasInited = false

