
-----------------------------------------------------
local adminMenu
local fr
local ent

local doorOptions = {
	{
		Name = 'Продать',
		DoClick = function()
			rp.RunCommand('selldoor')
			fr:Close()
		end
	},
	{
		Name = 'Дать ключи',
		Check = function() return (#player.GetAll() > 1) end,
		DoClick = function()
			ui.PlayerReuqest(function(pl)
				rp.RunCommand('addcoowner', pl:SteamID())
			end)
		end
	},
	{
		Name = 'Забрать ключи',
		Check = function() return (ent:DoorGetCoOwners() ~= nil) and (#ent:DoorGetCoOwners() > 0) end,
		DoClick = function()
			ui.PlayerReuqest(ent:DoorGetCoOwners(), function(pl)
				rp.RunCommand('removecoowner', pl:SteamID())
			end)
		end
	},
	{
		Name = 'Дать ключи Ораганиз',
		Check = function() return (#player.GetAll() > 1) and (LocalPlayer():GetOrg() ~= nil) end,
		DoClick = function()
			rp.RunCommand('orgown')
		end
	},
	{
		Name = 'Надпись',
		DoClick = function()
			ui.StringRequest('Надпись', 'Напишите текст который будет на двери', '', function(a)
				rp.RunCommand('settitle', tostring(a))
			end)
		end
	},
	{
		Name = 'Admin options',
		Check = function() return LocalPlayer():IsSuperAdmin() end,
		DoClick = function(self)
			fr:Close()
			adminMenu()
		end
	}
}

function keysMenu()
	if IsValid(fr) then
		fr:Close()
	end

	ent = LocalPlayer():GetEyeTrace().Entity

	if IsValid(ent) and ent:IsDoor() and ent:DoorOwnedBy(LocalPlayer()) and (ent:GetPos():DistToSqr(LocalPlayer():GetPos()) < 13225) then
		fr = ui.Create('ui_frame', function(self)
			self:SetTitle('Настройки')
			self:Center()
			self:MakePopup()

			self.Think = function(self)
				ent = LocalPlayer():GetEyeTrace().Entity

				if not IsValid(ent) or (ent:GetPos():DistToSqr(LocalPlayer():GetPos()) > 13225) then
					fr:Close()
				end
			end
		end)

		local count = -1
		local x, y = fr:GetDockPos()

		for k, v in ipairs(doorOptions) do
			if (v.Check == nil) or (v.Check(ent) == true) then
				count = count + 1
				fr:SetSize(ScrW() * .125, ((count + 1) * 29) + (y + 7))
				fr:Center()

				ui.Create('DButton', function(self)
					self:SetPos(x, (count * 29) + y)
					self:SetSize(ScrW() * .125 - 10, 30)
					self:SetText(v.Name)
					self.DoClick = v.DoClick
				end, fr)
			end
		end
	elseif IsValid(ent) and ent:IsDoor() and (ent:GetPos():DistToSqr(LocalPlayer():GetPos()) < 13225) and ent:DoorIsOwnable() then
		rp.RunCommand('buydoor')
	elseif LocalPlayer():IsSuperAdmin() and IsValid(ent) and ent:IsDoor() and (ent:GetPos():DistToSqr(LocalPlayer():GetPos()) < 13225) and not ent:DoorIsOwnable() then
		adminMenu()
	end
end

net('rp.keysMenu', keysMenu)
GM.ShowTeam = keysMenu

--
-- Admin Menu
--
local adminOptions = {
	{
		Name = 'Toggle Ownable',
		DoClick = function()
			rp.RunCommand('setownable')
		end
	},
	{
		Name = 'Toggle Locked',
		DoClick = function()
			rp.RunCommand('setlocked')
		end
	},
	{
		Name = 'Set Team Own',
		DoClick = function()
			local m = ui.DermaMenu()

			for k, v in ipairs(rp.teams) do
				m:AddOption(v.name, function()
					rp.RunCommand('setteamown', k)
				end)
			end

			m:Open()
		end
	},
	{
		Name = 'Set Group Own(for LostCity)',
		DoClick = function()
			local m = ui.DermaMenu()

			for k, v in pairs(DarkRP.getCategories().jobs) do
				m:AddOption(v.name, function()
					rp.RunCommand('setgroupown', v.name)
				end)
			end

			m:Open()
		end
	}
}

function adminMenu()
	if IsValid(fr) then
		fr:Close()
	end

	fr = ui.Create('ui_frame', function(self)
		self:SetTitle('Admin Door Options')
		self:Center()
		self:MakePopup()

		self.Think = function(self)
			ent = LocalPlayer():GetEyeTrace().Entity

			if not IsValid(ent) or (ent:GetPos():DistToSqr(LocalPlayer():GetPos()) > 13225) then
				fr:Close()
			end
		end
	end)

	local count = -1
	local x, y = fr:GetDockPos()

	for k, v in ipairs(adminOptions) do
		count = count + 1
		fr:SetSize(ScrW() * .125, ((count + 1) * 29) + (y + 7))
		fr:Center()

		ui.Create('DButton', function(self)
			self:SetPos(x, (count * 29) + y)
			self:SetSize(ScrW() * .125 - 10, 30)
			self:SetText(v.Name)
			self.DoClick = v.DoClick
		end, fr)
	end
end

concommand.Add('rp_dooradmin', adminMenu)