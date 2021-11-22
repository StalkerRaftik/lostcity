local Tag = "ContextMenuExtention"

local enabled = CreateClientConVar("cmenu_enabled", 1, true, false)



local function Option(title, icon, cmd, test)
	return {title = title, icon = icon, cmd = cmd, test = test}
end



local function SubMenu(title, icon, func, test)
	return {title = title, icon = icon, func = func, test = test}
end

local function Spacer(test)
	return {test = test}
end

local function Request(title, text, ...)
	local t = {...}
	return function(arg)
		Derma_StringRequest(title, text, function(s)
			if type(t[1]) == "function" then
				t[1](s, arg)
			elseif t[1] == "darkrp" then
				LocalPlayer():ConCommand((chatbox and chathud and "say /" or "say /") .. table.concat(t, " "):sub(8) .. " " .. s)
			else
				local t = table.Copy(t)
				table.insert(t, s)
				RunConsoleCommand(unpack(t))
			end
		end)
	end
end



local function RequestN(title, text, def, min, max, ...)
	local t = {...}
	return function(arg)

		Derma_StringRequest(title, text, def, function(s)
			if type(t[1]) == "function" then
				t[1](s, arg)
			elseif t[1] == "darkrp" then
				LocalPlayer():ConCommand((chatbox and chathud and "say /" or "say /") .. table.concat(t, " "):sub(8) .. " " .. s)
			else
				local t = table.Copy(t)
				table.insert(t, s)
				RunConsoleCommand(unpack(t))
			end
		end, nil, nil, nil, type(min) == "function" and min() or min, type(max) == "function" and max() or max)
	end
end


local function Request2(title, text, func)

	return function()

		Derma_StringRequest(title, text, nil, function(s)

			func(s)

		end)

	end

end


local function players()
	local tbl = player.GetAll()
	return tbl
end

-- conditions

	local IsCP = false

	local function isMayor()
		return LocalPlayer():IsMayor() and true or false
	end

	local function IsLeader()
		return (rp.teams[LocalPlayer():Team()].leader or (rp.teams[LocalPlayer():Team()].subleader)) or LocalPlayer():IsSuperAdmin() and true or false
	end

	local function canJail()
		return false
	end

	local function isPremium()
		return LocalPlayer():GetNWBool("DARKRP_PREMIUM")
	end

	local specialjobs = {}
	hook.Add("loadCustomDarkRPItems", "cmenuspecialjobs", function()
		specialjobs = {TEAM_GANG, TEAM_MOB, TEAM_TAXI, TEAM_GUN, TEAM_TRADE, TEAM_COOK, TEAM_CAR}
	end)

local Menu = {
  SubMenu("Жесты", "emoticon_evilgrin", function(self)
  	self:AddOption("Сесть на землю/встать", function() 
		LocalPlayer():ConCommand( "ground_sit" )
    end)
    self:AddSpacer()
    for i, data in ipairs(ANIMS) do
      if data[1] == -1 then
        self:AddSpacer()
      else
        self:AddOption(data[2], function() 
			net.Start("StartPlayerAnimation")
			net.WriteFloat(data[1])
			net.SendToServer()
        end)
      end
    end
  end),
  Spacer(),
	Option('Выбросить деньги', "money", RequestN('Выбросить деньги', "Введите сумму", 2, 2, function() return LocalPlayer():getDarkRPVar("money") end, "darkrp", "dropmoney")),
	Option('Вид от 3го лица', "eye", {"rp", "tpv"}),
	Option("Открыть правила", "page_attach", function() gui.OpenURL( "https://docs.google.com/document/d/1PJbpkike4S44oKMTgBexHSnbKky5g7BTEWIUXbKs7Bo/edit?usp=sharing" ) end),
	Option('Вкл/Выкл фоновую музыку', "music", {"lost_music_onoff"}),
	Option('Режим строительства', "brick", {"rp", "buildingmode"}),

	Option('Редактировать состав фракции', "group_edit", function() SH_WHITELIST:OpenMenu() end, IsLeader),


	Spacer(),

	SubMenu("Уволить игрока", "user_delete", function(self)
		for k, v in pairs(players()) do
			if rp.teams[LocalPlayer():Team()].type == rp.teams[v:Team()].type and v ~= LocalPlayer() then 
				self:AddOption(v:RPName(), Request2("Понизить игрока", "За что вы хотите его понизить?", function(s) RunConsoleCommand("rp", "leaderdemote", v:SteamID(), s) end)):SetColor(team.GetColor(v:Team()))
			end
		end
	end, IsLeader),

}



local function deployable_pack(ent)
	net.Start("deployable_pack")
	net.WriteEntity(ent)
	net.SendToServer()
end

local ContextMenu = {
	player = {
		title = function(ent) return ent:RPName() end,
		test = function(me, ent) return ent:Alive() end,
    Spacer(),
    Spacer(),
    {
      title = "Познакомиться",
      icon = "status_online",
      cmd = function(ent) rp.RunCommand('id', ent:SteamID64()) end,
      test = function(me, ent) return not me:IsFriend(ent) end
    }, 
	{
	title = "Передать деньги",
	icon = "money",
	cmd = function(ent)    
		Derma_StringRequest(
		"Передать деньги "..ent:RPName(),
		"Введите количество",
		"",
		function( s ) 
		RunConsoleCommand("darkrp","give", s, ent:SteamID64())
		end)
    	end
	},
    {
      title = "Ограбить",
      icon = "zoom_out",
      cmd = function(ent) rp.RunCommand('roberry', ent:SteamID64()) end,
    }, 
	},
	-- spawned_shipment = {
	-- 	title = function(ent) return CustomShipments[ent:Getcontents()].name .. " x " .. ent:Getcount() end,
	-- 	test = function(me, ent) return ent.Getcontents and ent.Getcount and true end, -- for some reason functions didn't exist for a moment after shipment was created
	-- 	Option("Разделить ящик", "box", function(ent) RunConsoleCommand("darkrp", "splitshipment", tostring(ent:EntIndex())) end)
	-- },

	-- spawned_weapon = {
	-- 	title = function(ent) return ent:GetWeaponTable().PrintName end,
	-- 	test = function(me, ent) return true end,
	-- 	Option("Сделать ящиком", "box", function(ent) RunConsoleCommand("darkrp", "makeshipment", tostring(ent:EntIndex())) end)

	-- },

	-- deployable

	-- prop_door_rotating = {
	-- 	title = function(ent) return DarkRP.getPhrase("door_single") .. " " .. ent:getDoorOwner():Name() end,
	-- 	test = function(me, ent) return me:IsCP() and ent:getDoorOwner() and ent:getDoorOwner():IsValid() end,
	-- 	{
	-- 		title = "Запросить ордер на обыск",
	-- 		icon = "door_in",
	-- 		cmd = Request2("Запросить ордер на обыск", "enter_reason", function(s, ent) RunConsoleCommand("darkrp", "warrant", tostring(ent:getDoorOwner():UserID()), s) end),
	-- 		test = function(me, ent) return me:IsCP() and not me:isMayor() and not ent:getDoorOwner():isArrested() end
	-- 	},
	-- 	{
	-- 		title = "Выдать ордер на обыск",
	-- 		icon = "door_in",
	-- 		cmd = Request2("Выдать ордер на обыск", "enter_reason", function(s, ent) RunConsoleCommand("darkrp", "warrant", tostring(ent:getDoorOwner():UserID()), s) end),
	-- 		test = function(me, ent) return me:isMayor() and not ent:getDoorOwner():isArrested() end
	-- 	}
	-- }
}


local function createmenu(parent)
	local rdmfc = RegisterDermaMenuForClose
	RegisterDermaMenuForClose = function() end
	local panel = vgui.Create("DMenu", parent)
	RegisterDermaMenuForClose = rdmfc
	local o = panel.Open
	panel.Open = function(self, ...)
		local rdmfc = RegisterDermaMenuForClose
		RegisterDermaMenuForClose = function() end
		o(self, ...)
		RegisterDermaMenuForClose = rdmfc
	end
	return panel
end

hook.Add("OnContextMenuOpen", Tag, function()
	if not IsValid(LocalPlayer()) then return end
	if not LocalPlayer():Alive() then return end
	if LocalPlayer():GetNVar('PlayerDataLoaded') ~= true then return end
	
	hook.Remove("HUDPaint", "contextmenu_hint")
	cookie.Set(Tag .. "_seen_hud", os.time())
	if not enabled:GetBool() then
		return
	end

	if not g_ContextMenu:IsVisible() then
		local orig = g_ContextMenu.Open
		g_ContextMenu.Open = function(self, ...)
			self.Open = orig
			orig(self, ...)
			local me = LocalPlayer()
			local menu = createmenu()
      menu:SetSkin('core')
			menu:SetDrawOnTop(false)
			for _, v in pairs(Menu) do
				if not v.test or v.test(me) then
					if v.cmd then
						local ok, ret = pcall(v.title)
						menu:AddOption(ok and ret or v.title, isfunction(v.cmd) and v.cmd or function() RunConsoleCommand(unpack(v.cmd)) end):SetImage("icon16/" .. v.icon .. ".png")
					elseif v.func then
						local ok, ret = pcall(v.title)
						local new, sub = menu:AddSubMenu(ok and ret or v.title)
						sub:SetImage("icon16/" .. v.icon .. ".png")
            sub:SetSkin('core')
						v.func(new)
					else
						menu:AddSpacer()
					end
				end
			end
			menu:Open()
      menu:SetSkin('core')
			menu:CenterHorizontal()
			menu.y = ScrH()
			menu:MoveTo(menu.x, ScrH() - menu:GetTall() - 8, .1, 0)
			function menu:Think()
				if g_ContextMenu:IsVisible() then
					menu:MakePopup()
					menu:SetKeyBoardInputEnabled(false)
          menu:SetSkin('core')
					for _, ent in next, ents.FindInSphere(me:GetShootPos(), 130) do
						if not ent.cmenu and ent ~= me and not ent:GetNoDraw() then
							local tbl = ContextMenu[ent:GetClass()]
							if tbl and (not tbl.test or tbl.test(me, ent)) then
								local pos = ent:LocalToWorld(ent:OBBCenter()):ToScreen()
								if pos.visible and pos.x > 0 and pos.y > 0 and pos.x < ScrW() and pos.y < ScrH() then
									ent.cmenu = true
									local frame = vgui.Create("DFrame")
									frame:ShowCloseButton(false)
                  frame:SetSkin('core')
									local menuc = createmenu(frame)
                  menuc:SetSkin('core')
									for k, v in pairs(tbl) do
										if k ~= "title" and k ~= "test" and (not v.test or v.test(me, ent)) then
											if v.cmd then
												if v.state then
													local option = menuc:AddOption(type(v.title) == "function" and v.title(ent) or v.title, function(self) v.cmd(ent, self:GetChecked()) end)
													option:SetIsCheckable(true)
													option:SetChecked(v.state(ent))
												else
													menuc:AddOption(type(v.title) == "function" and v.title(ent) or v.title, function() v.cmd(ent) end):SetImage("icon16/" .. v.icon .. ".png")
												end
											elseif v.func then
												local ok, ret = pcall(DarkRP.getPhrase, v.title)
												local new, sub = menuc:AddSubMenu(ok and ret or v.title)
												sub:SetImage("icon16/" .. v.icon .. ".png")
												v.func(new)
											else
												menuc:AddSpacer()
											end
										end
									end
									frame:SetPos((ScrW() - frame:GetWide()) / 2, -frame:GetTall())
									menuc:Open(frame.x, frame.y)
									local old = menuc.PerformLayout
									function menuc:PerformLayout(...)
										menuc.PerformLayout = old
										old(self, ...)
										frame:SetSize(menuc:GetWide() * 1.18, menuc:GetTall() + 20)
										frame:CenterHorizontal()
										frame.y = -frame:GetTall()
										frame:SetDrawOnTop(false)
										menuc:SetDrawOnTop(false)
										frame:SetDrawOnTop(true)
										menuc:SetDrawOnTop(true)
									end
									local function close()
										if not frame.closing then
											frame.closing = true
											menuc:SetMouseInputEnabled(false)
											frame:MoveTo((ScrW() - frame:GetWide()) / 2, -frame:GetTall(), .1, 0) -- callback function is not reliable
											timer.Simple(.1, function()
												if ent:IsValid() then
													ent.cmenu = nil
												end
												if frame:IsValid() then
													frame:Remove()
												end
											end)
										end
									end
									function frame:Think()
										if not ent:IsValid() then
											close()
										elseif not g_ContextMenu:IsVisible() then
											close()
										else
											local pos = ent:LocalToWorld(ent:OBBCenter()):ToScreen()
											if pos.visible and pos.x > 0 and pos.y > 0 and pos.x < ScrW() and pos.y < ScrH() then
												self:SetTitle(tbl.title(ent))
												local pos = ent:LocalToWorld(ent:OBBCenter())
												pos[3] = pos[3] + 16
												pos = pos:ToScreen()
												frame:SetPos(Lerp(FrameTime() * 10, frame.x + frame:GetWide()/2, pos.x) - frame:GetWide()/2, Lerp(FrameTime() * 10, frame.y, pos.y))
											else
												close()
											end
										end
									end
									function menuc:Think()
										self:SetPos(self:GetParent().x, self:GetParent().y + 20)
									end
								end
							end
						end
					end
				elseif not self.closing then
					self.closing = true
					self:SetMouseInputEnabled(false)
					self:MoveTo(self.x, ScrH(), .1, 0, nil, function() self:Remove() end)
				end
			end
		end
	end
end)