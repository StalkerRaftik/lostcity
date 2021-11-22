function rp.Jobs.OpenMenu(id)
	local Main = vgui.Create( "BFrame" )
	Main:SetSize( ScrW(), ScrH() )
	Main:SetSizable(false)
	Main:SetTitle( "" )
	Main:SetVisible( true )
	Main:ShowCloseButton( true )
	Main:Center()
	Main:SetDraggable(false)
	Main:MakePopup()
	Main:ParentToHUD()
	Main:SetScreenLock(true)

	local previewwindow = vgui.Create("BPanel", Main)
	previewwindow:SetSize(Main:GetWide()/3, Main:GetTall())
	previewwindow:Dock(RIGHT)
	previewwindow:DockMargin(5,5,5,5)
	previewwindow.Paint = function(self, w, h)
		surface.SetDrawColor(50,50,50,120)
		surface.DrawRect(0,0,w,h)
	end

	-- model preview
	local preview = vgui.Create( "DModelPanel", previewwindow )
	preview:SizeToContents()
	preview:Dock(FILL)
	preview:SetPos(0, 0)
	preview:SetFOV(40)
	function preview:LayoutEntity( Entity ) return end

	local modelID = false
	local Job = false
	local DModelsTbl = {}

	local b = Main:Add("BButton")
	b:SetSize(10,30)
	b:Dock( BOTTOM )
	b:DockMargin(5,5,5,5)
	b:SetText('')
	b.DoClick = function()
		net.Start("SendMyJobSkinToServer")
			net.WriteString(CurModelsTable[modelID])
			net.WriteUInt(Job, 16)
		net.SendToServer()
		RunConsoleCommand("say", prev_command)
	end

	local donatorPnl = vgui.Create("DPanel", previewwindow)
	donatorPnl:SetPos(0, 0)
	donatorPnl:SetSize(previewwindow:GetWide(),30)
	donatorPnl:SetText("")
	donatorPnl:SetVisible(false)
	function donatorPnl:Paint(w, h)
		draw.RoundedBox( 16, 0, 0, w, h, Color(255,112,112, 50) )
		draw.ShadowSimpleText("Недоступно", "rp.ui.30", w/2, h/2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	function HandleModelAccess(Job, mdl)
		if IsDonateModel(Job, mdl) and not LocalPlayer():HasUpgrade(DonateSkinsDict[Job][mdl]) then
			b:SetTextColor(Color(250,106,106, 197))
			b:SetText("Вам недоступна эта модель")
			b:SetEnabled(false)
			donatorPnl:SetVisible(true)
		else
			b:SetTextColor(Color(255,255,255))
			b:SetText("Стать "..rp.teams[Job].name)
			b:SetEnabled(true)
			donatorPnl:SetVisible(false)
		end
	end

	local nextmodel = vgui.Create("DButton", previewwindow)
	nextmodel:SetPos(previewwindow:GetWide()*0.9-30, previewwindow:GetTall()*0.4-30)
	nextmodel:SetSize(60,60)
	nextmodel:SetText("")
	nextmodel:SetVisible(false)
	function nextmodel:Paint(w, h)
		if modelID == false then return end
		draw.RoundedBox( 16, 0, 0, w, h, Color(255,255,255, 20) )
		draw.SimpleText(">", "rp.ui.30", w/2, h/2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	function nextmodel:DoClick()
		if modelID == false or Job == false then return end

		modelID = modelID + 1
		if modelID > #CurModelsTable then
			modelID = 1
		end

		local mdl = CurModelsTable[modelID]
		preview:SetModel(mdl)
		if rp.teams[Job].PlayerSpawn then
			rp.teams[Job].PlayerSpawn(preview.Entity)
		end

		HandleModelAccess(Job, mdl)

		preview.Entity:SetAngles(preview.Entity:GetAngles() + Angle(0,45,0))
	end

	local prevmodel = vgui.Create("DButton", previewwindow)
	prevmodel:SetPos(previewwindow:GetWide()*0.1-30, previewwindow:GetTall()*0.4-30)
	prevmodel:SetSize(60,60)
	prevmodel:SetText("")
	prevmodel:SetVisible(false)
	function prevmodel:Paint(w, h)
		if modelID == false then return end
		draw.RoundedBox( 16, 0, 0, w, h, Color(255,255,255, 20) )
		draw.SimpleText("<", "rp.ui.30", w/2, h/2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	function prevmodel:DoClick()
		if modelID == false or Job == false then return end

		modelID = modelID - 1
		if modelID < 1 then
			modelID = #CurModelsTable
		end

		local mdl = CurModelsTable[modelID]
		preview:SetModel(mdl)
		if rp.teams[Job].PlayerSpawn then
			rp.teams[Job].PlayerSpawn(preview.Entity)
		end
		
		HandleModelAccess(Job, mdl)

		preview.Entity:SetAngles(preview.Entity:GetAngles() + Angle(0,45,0))
	end

	local desc = vgui.Create("DLabel", Main)
	desc:SetTall(50)
	desc:Dock( FILL )
	desc:DockMargin(10,10,10,10)
	desc:SetText("")
	desc:SetTextColor(Color(255,255,255))
	desc:SetWrap(true)
	desc:SetFont("rp.ui.24")
	desc:DockMargin(5,5,5,5)
	desc.Paint = function(self, w, h)
		surface.SetDrawColor(50,50,50,120)
		surface.DrawRect(0,0,w,h)
	end


	local JBL = vgui.Create("monoPanel", Main)
	JBL:Dock(LEFT)
	JBL:SetWide(Main:GetWide() / 4.5)
	JBL:DockMargin(5,5,5,5)
	JBL.PaintOver = function(self,w,h)
		draw.ShadowSimpleText("Список профессий", 'rp.ui.24', w/2, h*0.01, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	local JBLbar = vgui.Create( "SRP_ScrollPanel", JBL ) 
		JBLbar:Dock(FILL)
		JBLbar:DockMargin(5,40,5,5)  
		JBLbar.sbar = JBLbar:GetVBar()
		JBLbar.sbar.Paint = function( self, w, h ) draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150)) end
		JBLbar.sbar.btnUp.Paint = function( self, w, h ) end
		JBLbar.sbar.btnDown.Paint = function( self, w, h ) end
		JBLbar.sbar.btnGrip.Paint = function( self, w, h ) draw.RoundedBox(0, 0, 0, w, h, Color(200, 200, 200, 150)) end
		JBLbar.Paint = function( self, w, h )
	end

	for tab, tbl in pairs(rp.teams) do-- rp.Jobs.Config[id].jobs
		local cat = tbl.category
		if id and cat and cat ~= "Other" and not rp.Jobs.Config[id].cats[cat] then continue end

		local bg = vgui.Create('DPanel', JBLbar)
		bg:SetSize(JBLbar,60)
		bg:Dock(TOP)
		bg:DockMargin(5,0,5,3)
		bg.Paint = function(self, w, h) end

		btn = vgui.Create( "BButton", bg)
		btn:SetText("")
		btn:Dock( FILL )
		btn:SetSize( bg:GetSize() )
		btn:SetPos( Main:GetWide() * 0.005, Main:GetTall() * 0.75 - ( 90 / 2 ) )

		btn.Paint = function(s,w,h)
		local jobclr = tbl.color     
		local col = Color( jobclr.r, jobclr.g, jobclr.b, 100)
		if s:IsHovered() then
			col = Color(200,200,200, 150)
		end
		draw.RoundedBox(0, 0, 0, w, h, col)
			local font = "rp.ui." .. math.floor(29 - (#rp.teams[tab].name-10)/7)
			draw.ShadowSimpleText(rp.teams[tab].name, font, w/2, h/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		btn.DoClick = function(this)
			modelID = false
			Job = tab
			local preview_model

			modelID = 1
			preview_team = rp.teams[tab]

			CurModelsTable = {}
			table.Add(CurModelsTable, rp.teams[tab].model)
			if DonateSkins[tab] then
				table.Add(CurModelsTable, DonateSkins[tab])
			end
			preview_model = CurModelsTable[1]

			if #CurModelsTable > 1 then
				nextmodel:SetVisible(true)
				prevmodel:SetVisible(true)
				nextmodel:SetEnabled(true)
				prevmodel:SetEnabled(true)
			else
				nextmodel:SetVisible(false)
				prevmodel:SetVisible(false)
				nextmodel:SetEnabled(false)
				prevmodel:SetEnabled(false)
			end

			preview:SetModel(preview_model)
			if rp.teams[Job].PlayerSpawn then
				rp.teams[Job].PlayerSpawn(preview.Entity)
			end
			preview.Entity:SetAngles(preview.Entity:GetAngles() + Angle(0,45,0))
			desc:SetText(BuildJobDescription(Job))
			prev_command = "/"..rp.teams[tab].command
			b:SetText("Стать "..rp.teams[tab].name)
		end	
	end
end

local function BuildKitItemsString(kit)
	local itemsString= ""
	for type, items in pairs(kit) do
		for key, value in pairs(items) do
			local count = 0
			local item
			local class
			if not isnumber(value) then
				class = value
			else
				class = key
				count = value
			end

			item = Inventory.GetItem(type, class)
			if not item then item = rp.Ammo[class.Name] end

			if item then
				itemsString = itemsString .. ", " .. item.name
				if count ~= 0 then
					itemsString = itemsString .. " x" .. count
				end
			end
		end
	end

	itemsString = string.sub(itemsString, 2, #itemsString)
	return itemsString
end

function BuildJobDescription(job)
	local description = rp.teams[job].description .. "\n\n"
	description = description .. rp.teams[job].salary.." монет в " .. math.floor(rp.cfg.PayDayTime/60) .." минут\n"
	description = description .. "Необходим "..(rp.teams[job].lvl or 1).." уровень\n\n"
	if rp.teams[job].kits then
		description = description .. "Снаряжение:\n"
		
		for kitLevel, kitTbl in SortedPairs(rp.teams[job].kits) do
			if not table.IsEmpty(kitTbl) then
				description = description .. kitLevel .. " уровень: "
				description = description .. BuildKitItemsString(kitTbl)
				description = description .. "\n"
			end
		end
	end
	return description
end