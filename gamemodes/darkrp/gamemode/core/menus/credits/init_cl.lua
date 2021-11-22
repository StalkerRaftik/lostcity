surface.CreateFont('rp.ui.20_deleted', {font = 'Roboto', size = ba.ScreenScale(20), weight = 400, extended = true, rotary = true,})

local fr
local mat
local categoryCreationFuncs
local moneyicon = Material("samprp/money_pile.png", "noclamp smooth")
categoryCreationFuncs = {
	["Основное"] = function(upgrade, parent)
		local text = string.Wrap('rp.ui.22', upgrade:GetDesc(), parent:GetWide() - 10)
		local y = (parent:GetTall() - (#text * 22)) * 0.5

		for k, v in pairs(text) do
			ui.Create('DLabel', function(self)
				self:SetText(v)
				self:SizeToContents()
				self:CenterHorizontal()
				self:SetPos(self.x, y)
				y = y + 22
			end, parent)
		end
	end,
	["Валюта"] = function(upgrade, parent)
		local mdlpnl = ui.Create("DModelPanel", function(self) -- TODO: FIX
			self:SetSize(parent:GetSize())
			self:Center()
			local nm = upgrade:GetName()

			self:SetDirectionalLight( BOX_TOP, Color( 255, 255, 255 ) )
			self:SetDirectionalLight( BOX_FRONT, Color( 255, 255, 255 ) )

			self:SetModel('models/props/cs_assault/money.mdl')

			//if (nm == '.357 Magnum') then
			//	self:SetFOV(25)
			//	self:SetCamPos(Vector(10, -60, 15))
			//	self:SetLookAt(Vector(0, 45, -8))
			//elseif (nm == "Knife") then
			//	self:SetFOV(50)
			//	self:SetCamPos(Vector(0, 25, 10))
			//	self:SetLookAt(Vector(0, 0, 9))
			//elseif (nm == "Stunstick" or nm == "Crowbar") then
			//	self:SetFOV(85)
			//	self:SetCamPos(Vector(0, 25, 10))
			//	self:SetLookAt(Vector(0, 0, 0))
			//elseif (nm == '.357 Magnum') then
			//	self:SetFOV(40)
			//	self:SetCamPos(Vector(0, 25, 10))
			//	self:SetLookAt(Vector(0, 0, -2))
			//end
			local size1, size2 = self.Entity:GetRenderBounds()
			local size = (-size1+size2):Length()
			self:SetFOV(25)
			self:SetCamPos(Vector(size/2,size*5,size*1))
			self:SetLookAt((size1+size2)/20)

		end, parent)


		local text = string.Wrap('rp.ui.22', upgrade:GetDesc() or '', parent:GetWide() - 10)
		local y = (parent:GetTall() - (#text * 22)) - 50
	
		for k, v in pairs(text) do
			ui.Create('DLabel', function(self)
				self:SetText(v)
				self:SizeToContents()
				self:CenterHorizontal()
				self:SetPos(self.x, y)
				y = y + 22
			end, parent)
		end
	end,
	["Временно оружие"] = function(upgrade, parent)
		local text = string.Wrap('rp.ui.22', upgrade:GetDesc(), parent:GetWide() - 10)
		local y = (parent:GetTall() - (#text * 22)) * 0.5

		for k, v in pairs(text) do
			ui.Create('DLabel', function(self)
				self:SetText(v)
				self:SizeToContents()
				self:CenterHorizontal()
				self:SetPos(self.x, y)
				y = y + 22
			end, parent)
		end
	end,
	["Наборы"] = function(upgrade, parent)
		if (not upgrade:GetIcon()) then
			categoryCreationFuncs["Основное"](upgrade, parent)

			return
		end

		local mdlpnl = ui.Create("DModelPanel", function(self) -- TODO: FIX
			self:SetSize(parent:GetSize())
			self:Center()
			local nm = upgrade:GetName()

			self:SetDirectionalLight( BOX_TOP, Color( 255, 255, 255 ) )
			self:SetDirectionalLight( BOX_FRONT, Color( 255, 255, 255 ) )

			self:SetModel(upgrade:GetIcon())

			local size1, size2 = self.Entity:GetRenderBounds()
			local size = (-size1+size2):Length()
			self:SetFOV(25)
			self:SetCamPos(Vector(size/2,size*5,size*1))
			self:SetLookAt((size1+size2)/20)

		end, parent)


		local text = string.Wrap('rp.ui.22', upgrade:GetDesc() or '', parent:GetWide() - 10)
		local y = (parent:GetTall() - (#text * 22)) - 50
	
		for k, v in pairs(text) do
			ui.Create('DLabel', function(self)
				self:SetText(v)
				self:SizeToContents()
				self:CenterHorizontal()
				self:SetPos(self.x, y)
				y = y + 22
			end, parent)
		end
	end,
	["Модели"] = function(upgrade, parent)
		if (not upgrade:GetIcon()) then
			categoryCreationFuncs["Основное"](upgrade, parent)

			return
		end

		local mdlpnl = ui.Create("DModelPanel", function(self) -- TODO: FIX
			self:SetSize(parent:GetSize())
			self:Center()
			local nm = upgrade:GetName()

			self:SetDirectionalLight( BOX_TOP, Color( 255, 255, 255 ) )
			self:SetDirectionalLight( BOX_FRONT, Color( 255, 255, 255 ) )

			self:SetModel(upgrade:GetIcon())

			local size1, size2 = self.Entity:GetRenderBounds()
			local size = (-size1+size2):Length()
			self:SetFOV(25)
			self:SetCamPos(Vector(size/2,size*2,size*1))
			self:SetLookAt((size1+size2)/1.4)
			function self:LayoutEntity( Entity ) return end
			self.Entity:SetAngles(self.Entity:GetAngles() + Angle(0,80,0))


		end, parent)


		local text = string.Wrap('rp.ui.22', upgrade:GetDesc() or '', parent:GetWide() - 10)
		local y = (parent:GetTall() - (#text * 22)) - 50
	
		for k, v in pairs(text) do
			ui.Create('DLabel', function(self)
				self:SetText(v)
				self:SizeToContents()
				self:CenterHorizontal()
				self:SetPos(self.x, y)
				y = y + 22
			end, parent)
		end
	end,
	["Компендиум"] = function(upgrade, parent)
		if (not upgrade:GetIcon()) then
			categoryCreationFuncs["Основное"](upgrade, parent)

			return
		end

		local mdlpnl = ui.Create("DModelPanel", function(self) -- TODO: FIX
			self:SetSize(parent:GetSize())
			self:Center()
			local nm = upgrade:GetName()

			self:SetDirectionalLight( BOX_TOP, Color( 255, 255, 255 ) )
			self:SetDirectionalLight( BOX_FRONT, Color( 255, 255, 255 ) )

			self:SetModel(upgrade:GetIcon())

			local size1, size2 = self.Entity:GetRenderBounds()
			local size = (-size1+size2):Length()
			self:SetFOV(25)
			self:SetCamPos(Vector(size/2,size*5,size*1))
			self:SetLookAt((size1+size2)/20)

		end, parent)


		local text = string.Wrap('rp.ui.22', upgrade:GetDesc() or '', parent:GetWide() - 10)
		local y = (parent:GetTall() - (#text * 22)) - 50
	
		for k, v in pairs(text) do
			ui.Create('DLabel', function(self)
				self:SetText(v)
				self:SizeToContents()
				self:CenterHorizontal()
				self:SetPos(self.x, y)
				y = y + 22
			end, parent)
		end
	end,
	["Дорогое"] = function(upgrade, parent)
		if (not upgrade:GetIcon()) then
			categoryCreationFuncs["Основное"](upgrade, parent)

			return
		end

		local mdlpnl = ui.Create("DModelPanel", function(self) -- TODO: FIX
			self:SetSize(parent:GetSize())
			self:Center()
			local nm = upgrade:GetName()

			self:SetDirectionalLight( BOX_TOP, Color( 255, 255, 255 ) )
			self:SetDirectionalLight( BOX_FRONT, Color( 255, 255, 255 ) )

			self:SetModel(upgrade:GetIcon())

			local size1, size2 = self.Entity:GetRenderBounds()
			local size = (-size1+size2):Length()
			self:SetFOV(25)
			self:SetCamPos(Vector(size/2,size*5,size*1))
			self:SetLookAt((size1+size2)/20)

		end, parent)


		local text = string.Wrap('rp.ui.22', upgrade:GetDesc() or '', parent:GetWide() - 10)
		local y = (parent:GetTall() - (#text * 22)) - 50
	
		for k, v in pairs(text) do
			ui.Create('DLabel', function(self)
				self:SetText(v)
				self:SizeToContents()
				self:CenterHorizontal()
				self:SetPos(self.x, y)
				y = y + 22
			end, parent)
		end
	end,
		
	-- ["Скины для оружия"] = function(upgrade, parent)
	-- 	if (not upgrade:GetIcon()) then
	-- 		categoryCreationFuncs["Основное"](upgrade, parent)

	-- 		return
	-- 	end

	-- 	local matPath = upgrade:GetSkin() or ""


	-- 	local contentPnl = vgui.Create("DPanel", parent)
	-- 	contentPnl:SetSize(700,500)
	-- 	contentPnl:Center()
	-- 	contentPnl.Paint = function(self, w, h)
	-- 		-- -- bg
	-- 		-- surface.SetDrawColor(SH_EASYSKINS.COL.DARKGREY)
	-- 		-- surface.DrawRect(0,0,w,h)
	-- 	end
	-- 	contentPnl:SetDrawBackground(false)

	-- 	-- model preview
	-- 	local _, wmPath = SH_EASYSKINS.GetWeaponModels(upgrade:GetIcon())
	-- 	local previewPnl, previewLbl = CL_EASYSKINS.CreateWeaponModelPnl(0,0,contentPnl:GetWide(),'',true,contentPnl,true,true)
	-- 	previewLbl:SetVisible(false)
	-- 	previewPnl:UpdateModel(upgrade:GetIcon())
		
	-- 	local offset = 0
		
	-- 	local allResSize, largeResSize = contentPnl:GetTall()*0.32, contentPnl:GetWide()*0.24
		
	-- 	if largeResSize > allResSize then
	-- 		offset = (contentPnl:GetWide()-contentPnl:GetTall())/2
	-- 	end
		
	-- 	previewPnl:SetPos(0,-offset)
		
	-- 	CL_EASYSKINS.CenterInElement(previewPnl, contentPnl)
		
	-- 	-- apply skin
	-- 	SH_EASYSKINS.ApplySkinToModel(previewPnl.Entity, matPath)



	-- 	local text = string.Wrap('rp.ui.22', upgrade:GetDesc() or '', parent:GetWide() - 10)
	-- 	local y = (parent:GetTall() - (#text * 22)) - 50
	
	-- 	for k, v in pairs(text) do
	-- 		ui.Create('DLabel', function(self)
	-- 			self:SetText(v)
	-- 			self:SizeToContents()
	-- 			self:CenterHorizontal()
	-- 			self:SetPos(self.x, y)
	-- 			y = y + 22
	-- 		end, parent)
	-- 	end
	-- end,
	["Оружие навсегда"] = function(upgrade, parent)
		if (not upgrade:GetIcon()) then
			categoryCreationFuncs["Основное"](upgrade, parent)

			return
		end

		local mdlpnl = ui.Create("DModelPanel", function(self) -- TODO: FIX
			self:SetSize(parent:GetSize())
			self:Center()
			local nm = upgrade:GetName()

			self:SetDirectionalLight( BOX_TOP, Color( 255, 255, 255 ) )
			self:SetDirectionalLight( BOX_FRONT, Color( 255, 255, 255 ) )

			self:SetModel(upgrade:GetIcon())

			//if (nm == '.357 Magnum') then
			//	self:SetFOV(25)
			//	self:SetCamPos(Vector(10, -60, 15))
			//	self:SetLookAt(Vector(0, 45, -8))
			//elseif (nm == "Knife") then
			//	self:SetFOV(50)
			//	self:SetCamPos(Vector(0, 25, 10))
			//	self:SetLookAt(Vector(0, 0, 9))
			//elseif (nm == "Stunstick" or nm == "Crowbar") then
			//	self:SetFOV(85)
			//	self:SetCamPos(Vector(0, 25, 10))
			//	self:SetLookAt(Vector(0, 0, 0))
			//elseif (nm == '.357 Magnum') then
			//	self:SetFOV(40)
			//	self:SetCamPos(Vector(0, 25, 10))
			//	self:SetLookAt(Vector(0, 0, -2))
			//end
			local size1, size2 = self.Entity:GetRenderBounds()
			local size = (-size1+size2):Length()
			self:SetFOV(25)
			self:SetCamPos(Vector(size*2,size*1,size*1))
			self:SetLookAt((size1+size2)/2)

		end, parent)


		local text = string.Wrap('rp.ui.22', upgrade:GetDesc() or '', parent:GetWide() - 10)
		local y = (parent:GetTall() - (#text * 22)) - 50
	
		for k, v in pairs(text) do
			ui.Create('DLabel', function(self)
				self:SetText(v)
				self:SizeToContents()
				self:CenterHorizontal()
				self:SetPos(self.x, y)
				y = y + 22
			end, parent)
		end
		
	end,
	["Аксессуары"] = function(upgrade, parent)
		local prev = ui.Create('rp_playerpreview', function(self, p)
			self:SetPos(p:GetWide() * 0.175, 25)
			self:SetSize(p:GetWide(), p:GetTall())
			self:SetFOV(25)
		end, parent)

		local hasHat
		local model

		for k, v in pairs(rp.hats.list) do
			if (v.name == upgrade:GetName()) then
				prev:SetHat(v.model)
				hasHat = table.HasValue(LocalPlayer():GetNetVar('HatData') or {}, v.model)
				model = v.model
				break
			end
		end

		if (hasHat) then
			ui.Create("DButton", function(self)
				self:SetText("Equip")
				self:SetSize(parent:GetWide() - 10, 25)
				self:SetPos(5, parent:GetTall() - 60)

				self.DoClick = function()
					if (self.Unequip) then
						rp.RunCommand('removehat')
					else
						rp.RunCommand('sethat', model)
					end
				end
			end, parent)
		end
	end,
	["Ножи"] = function(upgrade, parent)
		if (not upgrade:GetIcon()) then
			categoryCreationFuncs["Основное"](upgrade, parent)

			return
		end

		local mdlpnl = ui.Create("DModelPanel", function(self) -- TODO: FIX
			self:SetSize(parent:GetSize())
			self:Center()
			local nm = upgrade:GetName()

			self:SetDirectionalLight( BOX_TOP, Color( 255, 255, 255 ) )
			self:SetDirectionalLight( BOX_FRONT, Color( 255, 255, 255 ) )

			self:SetModel(upgrade:GetIcon())
			if upgrade:GetSkin() then
				self:GetEntity():SetSkin(upgrade:GetSkin())
			end

			//if (nm == '.357 Magnum') then
			//	self:SetFOV(25)
			//	self:SetCamPos(Vector(10, -60, 15))
			//	self:SetLookAt(Vector(0, 45, -8))
			//elseif (nm == "Knife") then
			//	self:SetFOV(50)
			//	self:SetCamPos(Vector(0, 25, 10))
			//	self:SetLookAt(Vector(0, 0, 9))
			//elseif (nm == "Stunstick" or nm == "Crowbar") then
			//	self:SetFOV(85)
			//	self:SetCamPos(Vector(0, 25, 10))
			//	self:SetLookAt(Vector(0, 0, 0))
			//elseif (nm == '.357 Magnum') then
			//	self:SetFOV(40)
			//	self:SetCamPos(Vector(0, 25, 10))
			//	self:SetLookAt(Vector(0, 0, -2))
			//end
			local size1, size2 = self.Entity:GetRenderBounds()
			local size = (-size1+size2):Length()
			self:SetFOV(25)
			self:SetCamPos(Vector(size*2,size*1,size*1))
			self:SetLookAt((size1+size2)/2)

		end, parent)


		local text = string.Wrap('rp.ui.22', upgrade:GetDesc() or '', parent:GetWide() - 10)
		local y = (parent:GetTall() - (#text * 22)) - 50
	
		for k, v in pairs(text) do
			ui.Create('DLabel', function(self)
				self:SetText(v)
				self:SizeToContents()
				self:CenterHorizontal()
				self:SetPos(self.x, y)
				y = y + 22
			end, parent)
		end
		
	end
}


local function createUpgradeInfo(upgrade, note, disabled, parent)
	parent:Clear()

	parent.btnPurchase = ui.Create("DButton", function(self)
		self:SetText(disabled and "Покупка недоступна" or "Купить")
		self:SetSize(0, 25)
		self:DockMargin(5, 5, 5, 5)
		self:Dock(BOTTOM)

		if (disabled) then
			self:SetDisabled(true)
		else
			self.DoClick = function(s)
				if (not s.Timeout) then
					s.Timeout = SysTime()
					s:SetText("Подтвердите")

					return
				end

				rp.RunCommand('buyupgrade', tostring(upgrade:GetID()))
				s:SetText("Покупка..")
				fr.Category = upgrade:GetCat()
				fr.Upgrade = upgrade:GetUID()

				fr.Blocker = ui.Create("Panel", function(s)
					s:SetSize(fr:GetSize())
				end, fr)

				fr.btnClose:MoveToFront()
			end
		end

		self.Think = function(s)
			if (s.Timeout and SysTime() > s.Timeout + 3) then
				s:SetText("Купить")
				s.Timeout = nil
			end

			s:MoveToFront()
		end
	end, parent)

	local creationFunc = categoryCreationFuncs[upgrade:GetCat()] or categoryCreationFuncs["Основное"]
	creationFunc(upgrade, parent)

	parent.lblName = ui.Create("DLabel", function(self)
		self:SetFont('rp.ui.28')
		self:SetText(upgrade:GetName())
		self:SizeToContents()
		self:CenterHorizontal()
		self:SetPos(self.x, 5)
	end, parent)

	local sfont
	local scolor
	local oldstring = note
	local stbl = string.Split( note, " " )
	PrintTable(stbl)
	local number = tonumber(stbl[1])
	local isAlreadyBought = false
	if not number then 
		isAlreadyBought = true
	end
	if rp.shop.GlobalDiscount and rp.shop.GlobalDiscount > 0 and isAlreadyBought ~= true then
		sfont = "rp.ui.20_deleted"
		scolor = Color(200,0,0)
		note = math.floor(number/ (rp.shop.GlobalDiscount*100) * 100) .. " кредитов"
	else
		sfont = "rp.ui.22"
		note = oldstring
		scolor = Color(255,255,255, 0)
	end
	 

	parent.lblNote = ui.Create("DLabel", function(self)
		self:SetFont(sfont)
		self:SetText(note)
		self:SetTextColor(scolor)
		self:SizeToContents()
		self:CenterHorizontal()
		self:SetPos(self.x, parent.lblName:GetTall() + 5)

		if (disabled) then
			self:SetTextColor(rp.col.Red)
		end
	end, parent)

	if not rp.shop.GlobalDiscount or rp.shop.GlobalDiscount <= 0 then return end

	
	local text = "ЦЕНА СО СКИДКОЙ: " .. number
	if tonumber(stbl[1]) == nil then
		text = text .. "\nВы не можете себе это позволить!"
	end
	parent.lblNote = ui.Create("DLabel", function(self)
		self:SetFont("rp.ui.22")
		self:SetText(text)
		self:SizeToContents()
		self:CenterHorizontal()
		self:SetPos(self.x, parent.lblName:GetTall() + 25)

		if (disabled) then
			self:SetTextColor(rp.col.Red)
		end
	end, parent)
end

local function createUpgradeSheet(category)
	local pnl = ui.Create('Panel', function(self)
		self:DockPadding(0, 5, 0, 0)
		self:Dock(FILL)
	end)

	local toClick

	pnl.List = ui.Create('ui_listview', function(self)
		self.Paint = function(self, w, h)
			-- draw.OutlinedBox(0, self:GetCanvas().y, w, self:GetCanvas():GetTall(), rp.col.core, ui.col.Outline)
		end

		self:SetSize(210, 0)
		self:DockMargin(0, 0, 5, 0)
		self:Dock(LEFT)

		for k, v in ipairs(category.Upgrades) do
			if (not v.Price and not self.HasUnavailableTag) then
				self:AddRow("Недоступны:", true)
				self.HasUnavailableTag = true
			end

			local btn = self:AddRow(v.Upgrade:GetName())

			if (not v.Price) then
				-- btn:SetBackgroundColor(ui.col.ButtonRed)
			end

			btn.ODC = btn.DoClick

			btn.DoClick = function(self)
				self:ODC()
				createUpgradeInfo(v.Upgrade, v.Price or v.Reason, v.Price == nil, pnl.Content)
			end

			btn.PaintOver = function(s, w, h)
				if (not v.Price) then
					surface.SetDrawColor(255, 50, 50, 50)
					surface.DrawRect(0, 0, w, h)
				end
			end

			if (not toClick) then
				toClick = (k + (self.HasUnavailableTag and 1 or 0))
			end

			if (fr.Upgrade and fr.Upgrade == v.Upgrade:GetUID()) then
				toClick = k
			end
		end
	end, pnl)

	pnl.Content = ui.Create('ui_panel', function(self)
		self:SetSize(505, 478)
		self:DockMargin(0, 0, 0, 0)
		self:Dock(FILL)
	end, pnl)

	pnl.List.Rows[toClick]:DoClick()

	pnl.Content.Paint = function(s, w, h)
		draw.RoundedBoxOutlined( 2, 0, 0, w, h, Color(70, 70, 70, 200), Color(30,30,30,150) )
	end

	return pnl
end

net('rp.CreditShop', function()
	local cannotbuy = {}
	local canbuy = {}
	local categories = {}

	for i = 1, net.ReadUInt(8) do
		if net.ReadBool() then
			canbuy[net.ReadUInt(8)] = net.ReadUInt(16)
		else
			cannotbuy[net.ReadUInt(8)] = net.ReadString()
		end
	end

	for k, v in pairs(canbuy) do
		local upg = rp.shop.GetTable()[k]

		canbuy[k] = {
			Upgrade = upg,
			Price = v .. ' кредитов',
			buyable = true
		}

		local cat

		for k, v in ipairs(categories) do
			if (v.Name == upg:GetCat()) then
				cat = v
				break
			end
		end

		cat = cat or categories[table.insert(categories, {
			Name = upg:GetCat(),
			Upgrades = {}
		})]

		table.insert(cat.Upgrades, canbuy[k])
	end

	for k, v in pairs(cannotbuy) do
		local upg = rp.shop.GetTable()[k]

		cannotbuy[k] = {
			Upgrade = upg,
			Reason = v,
			Buyable = false
		}

		local cat

		for k, v in ipairs(categories) do
			if (v.Name == upg:GetCat()) then
				cat = v
				break
			end
		end

		cat = cat or categories[table.insert(categories, {
			Name = upg:GetCat(),
			Upgrades = {}
		})]

		table.insert(cat.Upgrades, cannotbuy[k])
	end

	if (IsValid(fr)) then
		if IsValid(fr.Blocker) then
			fr.Blocker:Remove()
		end
		fr.PropertyList:Remove()
		fr.PropertyList = nil
	else
		fr = nil
	end

	fr = fr or ui.Create('ui_frame')
	fr:SetTitle("Донат Магазин")
	fr:SetSize(ScrW()/1.3, ScrH()/1.5)
	fr:Center()
	fr:MakePopup()
	fr:SetSkin("core")
	fr.StartSpin = SysTime()
	fr.NextLine = 0
	fr.NextString = 1
	fr.Lines = {}
	fr.ToDel = {}
	fr.Strings = {'Давай, нажми купить!', 'Купи меня, давай купи!'}

	fr.CreditsBtn = fr.CreditsBtn or ui.Create("DButton", function(self)
		PrintTable(self:GetSkin())
		self:SetText("Пополнить счёт")
		-- self:SetBackgroundColor(Color(0,200,0, 150))
		self.DoClick = function(s)
      local parentMenu = DermaMenu()

      local subMenu, parentMenuOption = parentMenu:AddSubMenu( "Пополнить счёт" )
      parentMenuOption:SetIcon( "icon16/money_add.png" )

      local yesOption = subMenu:AddOption( "На свой аккаунт", function()  
        Derma_StringRequest(
          "Пополнение счёта",
          "Сколько кредитов вы желаете приобрести?",
          "",
          function( text ) timer.Simple(1, function() gui.OpenURL("http://gmod-octopus.ru/donate/redirectfromserver.php?steamid="..LocalPlayer():SteamID().."&amount="..text.."&serverid=1") end) end,
          function( text ) end
         )
      end )
      yesOption:SetIcon( "icon16/user.png" )

      local noOption = subMenu:AddOption( "На другой аккаунт", function() timer.Simple(1, function() gui.OpenURL("http://gmod-octopus.ru/donate/") end) end )
      noOption:SetIcon( "icon16/user_delete.png" )

      local noOption = subMenu:AddOption( "Активировать промокод", function() RunConsoleCommand("say","/promocode") end )
      noOption:SetIcon( "icon16/key.png" )

      parentMenu:Open()
		end

		self:SizeToContents()
		self:SetSize(self:GetWide() + 50, fr.btnClose:GetTall())
		self:SetPos(fr.btnClose.x - self:GetWide() - 10, 2)
	end, fr)

  fr.BalanceBtn = fr.BalanceBtn or ui.Create("DButton", function(self)
    self:SetText("Баланс: "..LocalPlayer():GetCredits())
    -- self:SetBackgroundColor(Color(0,200,0, 150))
  
    self.DoClick = function(s)

    end

    self:SizeToContents()
    self:SetSize(self:GetWide() + 50, fr.btnClose:GetTall())
    self:SetPos(fr.CreditsBtn.x - self:GetWide() - 10, 2)
    self:SetDisabled(true)
  end, fr)

	fr.PropertyList = fr.PropertyList or ui.Create('SPropertySheet', function(self)
		self.tabScroller.pnlCanvas.Paint = function() end
		self:Dock(FILL)
		self:DockMargin(0, -1, 0, 0)
		self:DockPadding(5, 0, 5, 5)
		self:SetPadding(0)

		for k, v in ipairs(categories) do
      self.TabIcons = {
        ["Основное"] = {
          Icon = "samprp/moreicons/bulb_on.png"
        },
        ["Валюта"] = {
          Icon = "samprp/moreicons/money_hand2.png"
        },   
        ["Законопослушность"] = {
          Icon = "samprp/emoji/1f46e-1f3fb.png"
        },  
        ["Привелегии"] = {
          Icon = "samprp/moreicons/crown.png"
        }, 
        ["Оружие навсегда"] = {
          Icon = "samprp/moreicons/gun_pistol.png"
        }, 
        ["Наборы"] = {
          Icon = "samprp/moreicons/gun_pistol.png"
        }, 	
        ["Модели"] = {
          Icon = "samprp/moreicons/clothes_jacket.png"
        }, 
        ["Компендиум"] = {
          Icon = "samprp/moreicons/gift_money.png"
        }, 
        ["Дорогое"] = {
          Icon = "samprp/emoji/1f48e.png"
        }, 
        ["Скины для оружия"] = {
          Icon = "samprp/moreicons/gun_pistol.png"
        }, 		
        ["Временное оружие"] = {
          Icon = "samprp/moreicons/gun_pistol.png"
        }, 
        ["Ножи"] = {
          Icon = "samprp/moreicons/knife.png"
        } 
      }
  
			local dat = self:AddSheet(v.Name, createUpgradeSheet(v), self.TabIcons[v.Name].Icon)
			dat.Tab.ODC = dat.Tab.DoClick

			dat.Tab.DoClick = function(s)
				if (self:GetActiveTab() == s) then return end
				s:ODC()
				fr.StartSpin = SysTime()
			end

			dat.Tab:SetFont('rp.ui.18')

			if (fr.Category and fr.Category == v.Name) then
				dat.Tab:DoClick()
			end
		end
	end, fr)

	fr.OT = fr.OT or fr.Think

	fr.Think = function(s)
		s:OT()

		for k, v in ipairs(s.ToDel or {}) do
			if (not s.Lines[v - (k - 1)]) then break end

			if (s.Lines[v - (k - 1)].str) then
				s.HasStr = nil
			end

			table.remove(s.Lines, v - (k - 1))
		end

		table.Empty(s.ToDel)
	end

	fr.OP = fr.OP or fr.Paint

	fr.Paint = function(s, w, h)
		s:OP(w, h)

		if (mat) then
			local diff = math.Clamp(SysTime() - s.StartSpin, 0, 1) * 1.57079632679
			local rot8 = math.sin(diff + math.pi) + 1
			surface.DisableClipping(true)
			surface.SetMaterial(mat)
			surface.DrawTexturedRectRotated(4, 4, 70, 70, rot8 * 360)
			surface.DisableClipping(false)
		end
	end
end)
