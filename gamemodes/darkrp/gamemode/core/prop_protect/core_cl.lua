rp.pp = rp.pp or {}

--
-- Hooks
--
hook('CanTool', 'pp.CanTool', function(pl, trace, tool)
	local ent = trace.Entity

	return (IsValid(ent) and (ent:GetNetVar('PropIsOwned') == true))
end)

hook('PhysgunPickup', 'pp.PhysgunPickup', function(pl, ent) return false end)

function GM:GravGunPunt(pl, ent)
	return false
end


hook.Add( 'HUDPaint', 'rp.CPPIOwnerDisplay', function()
	if LocalPlayer():IsAdmin() then 

	local ent = LocalPlayer():GetEyeTrace().Entity

		if IsValid( ent ) and not ent:IsPlayer() then 
			local fraction = ent:GetNVar("PropFraction")
			if fraction and ent:GetNVar("PropFractionSave") then
				local owner_name = fraction
				draw.WordBox( 6, 5, ScrH() * 0.48, owner_name, "ui.15", Color( 0, 0, 0, 140 ), Color( 255,255,255 ) )
			elseif ent:GetNetVar('PropOwner') then
				local owner = ent:GetNetVar('PropOwner')
				if IsValid( owner ) then   
					local owner_name = owner:RPName(true) or "world"
					draw.WordBox( 6, 5, ScrH() * 0.48, owner_name, "ui.15", Color( 0, 0, 0, 140 ), Color( 255,255,255 ) )
				end
			end
		end  
	end
end)

--
-- Menus
--
local ranks = {
	[0] = 'user',
	[1] = 'VIP',
	[2] = 'Admin',
	[3] = 'Globaladmin'
}

function rp.pp.ToolEditor()
	local tools = net.ReadTable()

	local fr = ui.Create('ui_frame', function(self)
		self:SetSize(500, 400)
		self:SetTitle('Tool editor')
		self:Center()
		self:MakePopup()
	end)

	local targ

	local list = ui.Create('DListView', function(self, p) -- TODO: FIX
		self:SetPos(5, 30)
		self:SetSize(p:GetWide() - 10, p:GetTall() - 65)
		self:SetMultiSelect(false)
		self:AddColumn('Tool')
		self:AddColumn('Rank')

		self.OnRowSelected = function(parent, line)
			targ = self:GetLine(line):GetColumnText(1)
		end

		for a, b in ipairs(spawnmenu.GetTools()) do
			for c, d in ipairs(spawnmenu.GetTools()[a].Items) do
				for e, f in ipairs(spawnmenu.GetTools()[a].Items[c]) do
					if (type(f) == 'table') and string.find(f.Command, 'gmod_tool') then
						self:AddLine(f.ItemName, tools[f.ItemName] and ranks[tools[f.ItemName]] or 'user')
					end
				end
			end
		end
	end, fr)

	for i = 1, 4 do
		ui.Create('DButton', function(self, p)
			self:SetSize(p:GetWide() / 4 - 6, 25)
			self:SetPos((i - 1) * (p:GetWide() / 4 - 6) + (5 * i), p:GetTall() - 30)
			self:SetText(ranks[i - 1])

			self.DoClick = function()
				rp.RunCommand('settoolgroup', targ, (i - 1))
			end
		end, fr)
	end
end

net('rp.toolEditor', rp.pp.ToolEditor)

function rp.pp.SharePropMenu()
	local fr = ui.Create('ui_frame', function(self)
		self:SetSize(500, 400)
		self:SetTitle('Share Props')
		self:Center()
		self:MakePopup()
	end)

	local targ

	local list = ui.Create('DListView', function(self, p)
		self:SetPos(5, 30)
		self:SetSize(250 - 5, p:GetTall() - 65)
		self:SetMultiSelect(false)
		self:AddColumn('Player')

		self.OnRowSelected = function(parent, line)
			targ = self:GetLine(line):GetColumnText(1)
		end

		for k, v in ipairs(player.GetAll()) do
			if (v == LocalPlayer()) then continue end
			self:AddLine(v:Name())
		end
	end, fr)

	ui.Create('DButton', function(self, p)
		self:SetSize(250 - 5, 25)
		self:SetPos(5, p:GetTall() - 30)
		self:SetText('Share')

		self.DoClick = function()
			rp.RunCommand('shareprops', targ)
		end
	end, fr)

	local targ

	local list = ui.Create('DListView', function(self, p)
		self:SetPos(252.5, 30)
		self:SetSize(250 - 5, p:GetTall() - 65)
		self:SetMultiSelect(false)
		self:AddColumn('Player')

		self.OnRowSelected = function(parent, line)
			targ = self:GetLine(line):GetColumnText(1)
		end

		for k, v in pairs(LocalPlayer():GetNetVar('ShareProps') or {}) do
			self:AddLine(k:Name())
		end
	end, fr)

	ui.Create('DButton', function(self, p)
		self:SetSize(250 - 5, 25)
		self:SetPos(252.5, p:GetTall() - 30)
		self:SetText('Unshare')

		self.DoClick = function()
			rp.RunCommand('shareprops', targ)
		end
	end, fr)
end

--
-- Context menus
--
properties.Add('ppWhitelist', {
	MenuLabel = 'Add/Remove from whitelist',
	Order = 2001,
	MenuIcon = 'icon16/arrow_refresh.png',
	Filter = function(self, ent, pl)
		if not IsValid(ent) or ent:IsPlayer() then return false end

		return pl:IsSuperAdmin()
	end,
	Action = function(self, ent)
		if not IsValid(ent) then return end
		rp.RunCommand('whitelist', ent:GetModel())
	end
})

properties.Add('ppShareProp', {
	MenuLabel = 'Дать доступ к пропу',
	Order = 2002,
	MenuIcon = 'icon16/user.png',
	Filter = function(self, ent, pl)
		if not IsValid(ent) or ent:IsPlayer() then return false end

		return true
	end,
	Action = function(self, ent)
		rp.pp.SharePropMenu()
	end
})
