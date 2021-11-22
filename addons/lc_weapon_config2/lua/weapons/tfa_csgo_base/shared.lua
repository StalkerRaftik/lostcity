DEFINE_BASECLASS("tfa_gun_base")
SWEP.Skins = {}
SWEP.Skin = ""
SWEP.Callback = {}
SWEP.VMPos = Vector(0.879, 0.804, -1)
SWEP.VMPos_Additive = false --Set to false for an easier time using VMPos. If true, VMPos will act as a constant delta ON TOP OF ironsights, run, whateverelse
SWEP.ProceduralHolsterEnabled = true
SWEP.ProceduralHolsterTime = 0.0
SWEP.ProceduralHolsterPos = Vector(0, 0, 0)
SWEP.ProceduralHolsterAng = Vector(0, 0, 0)
SWEP.NoStattrak = false
SWEP.NoNametag = false
SWEP.TracerName = "tfa_tracer_csgo" 											-- Change to a string of your tracer name.  Can be custom. There is a nice example at https://github.com/garrynewman/garrysmod/blob/master/garrysmod/gamemodes/base/entities/effects/tooltracer.lua

SWEP.IsTFACSGOWeapon = true

SWEP.SmokeParticles = { pistol = "weapon_muzzle_smoke",  --These are particle effects INSIDE a pcf file, not PCF files, that are played when you shoot.
	smg = "weapon_muzzle_smoke",
	grenade = "weapon_muzzle_smoke",
	ar2 = "weapon_muzzle_smoke_long",
	shotgun = "weapon_muzzle_smoke_long",
	rpg = "weapon_muzzle_smoke",
	physgun = "weapon_muzzle_smoke",
	crossbow = "weapon_muzzle_smoke",
	melee = "weapon_muzzle_smoke",
	slam = "weapon_muzzle_smoke",
	normal = "weapon_muzzle_smoke",
	melee2 = "weapon_muzzle_smoke",
	knife = "weapon_muzzle_smoke",
	duel = "weapon_muzzle_smoke",
	camera = "weapon_muzzle_smoke",
	magic = "weapon_muzzle_smoke",
	revolver = "weapon_muzzle_smoke",
	silenced = "weapon_muzzle_smoke"
}

TFA = TFA or {}
TFA.CSGO = TFA.CSGO or {}
TFA.CSGO.Skins = TFA.CSGO.Skins or {}

function SWEP:Initialize()
	BaseClass.Initialize(self)
	sp = game.SinglePlayer()
	self:ReadSkin()
	self:ReadKills()

	if not self.Owner.CSGOHands and CLIENT and IsValid(self.Owner) and not self.Owner:IsNPC() then
		self.Owner.CSGOHands = ClientsideModel("models/weapons/c_arms_cstrike.mdl")

		if self.Owner.CSGOHands then
			self.Owner.CSGOHands:SetParent(self.Owner:GetViewModel())
			self.Owner.CSGOHands:SetPos(self.Owner:GetShootPos())
			self.Owner.CSGOHands:SetAngles(self.Owner:EyeAngles())
			self.Owner.CSGOHands:AddEffects(EF_BONEMERGE)
			self.Owner.CSGOHands:SetNoDraw(true)
		end
	end

	if not self.Owner.CSGOHands and CLIENT and IsValid(self.Owner) and not self.Owner:IsNPC() then
		self.Owner.CSGOPMHands = ClientsideModel("models/weapons/tfa_csgo/c_hands_translator.mdl")

		if self.Owner.CSGOPMHands then
			self.Owner.CSGOPMHands:SetParent(self.Owner:GetViewModel())
			self.Owner.CSGOPMHands:SetPos(self.Owner:GetShootPos())
			self.Owner.CSGOPMHands:SetAngles(self.Owner:EyeAngles())
			self.Owner.CSGOPMHands:AddEffects(EF_BONEMERGE)
			self.Owner.CSGOPMHands:SetNoDraw(true)
		end
	end

	if SERVER then
		self:CallOnClient("ReadSkin", "")
	end
end

function SWEP:AltAttack()
	if not CLIENT then return end
	if not (game.SinglePlayer() or IsFirstTimePredicted()) then return end
	local bgcolor = Color(0, 0, 0, 255 * 0.78)
	local bordercol = Color(10, 10, 10, 255)
	local scrollbar_buttoncol = Color(96, 96, 96, 255 * 0.8)
	local scrollbar_gripcol = Color(162, 162, 162, 255 * 0.8)
	local btntextcol = Color(255, 255, 255, 255 * 0.9)
	local divcolor = Color(225, 225, 225, 225 * 0.8)
	local panelscale = 0.7

	surface.CreateFont("TFA_CSGO_SKIN", {
		font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		size = 48,
		weight = 500,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false
	})

	local labfont = {
		["font"] = "TFA_CSGO_SKIN",
		["charwidth"] = 42,
		["charheight"] = 48
	}

	local Frame = vgui.Create("DFrame")
	local scrollpanel = vgui.Create("DScrollPanel")
	local sbar = scrollpanel:GetVBar()

	function sbar:Paint(wv, hv)
		draw.RoundedBox(0, 0, 0, wv, hv, bgcolor)
	end

	function sbar.btnUp:Paint(wv, hv)
		draw.RoundedBox(0, 0, 0, wv, hv, scrollbar_buttoncol)
	end

	function sbar.btnDown:Paint(wv, hv)
		draw.RoundedBox(0, 0, 0, wv, hv, scrollbar_buttoncol)
	end

	function sbar.btnGrip:Paint(wv, hv)
		draw.RoundedBox(0, 0, 0, wv, hv, scrollbar_gripcol)
	end

	local scrw, scrh = ScrW(), ScrH()
	local w, h = scrw * panelscale, scrw * panelscale * (scrh / scrw) --790, 790*9/16
	Frame:SetPos((scrw - w) / 2, (scrh - h) / 2)
	Frame:SetSize(w, h)
	Frame:SetTitle("Skin and Name Picker")
	Frame:SetVisible(true)
	Frame:SetDraggable(true)
	Frame:SetSizable(true)
	Frame:SetScreenLock(true)
	Frame:ShowCloseButton(true)
	Frame:MakePopup()
	Frame:SetBackgroundBlur(true)
	Frame.startTime = SysTime()
	Frame.btnMaxim:Hide(true)
	Frame.btnMinim:Hide(true)

	Frame.Paint = function(myself, wv, hv)
		local x, y = myself:GetPos()
		--local x,y = self:GetPos()[1],self:GetPos()[2]
		render.SetScissorRect(x, y, x + wv, y + hv, true)
		Derma_DrawBackgroundBlur(myself, myself.startTime - 60)
		render.SetScissorRect(x, y, x + wv, y + hv, false)
		--DrawBlurRect(x, y, wv, hv, 3, 2)
		draw.NoTexture()
		surface.SetDrawColor(bgcolor)
		surface.DrawRect(0, 0, wv, hv)
	end

	Frame:Center()
	local div2 = vgui.Create("DPanel")
	div2:SetParent(Frame)
	div2:SetSize(w, 2)
	div2:Dock(TOP)

	div2.Paint = function(myself, wv, hv)
		draw.NoTexture()
		surface.SetDrawColor(divcolor)
		surface.DrawRect(0, 0, wv, hv)
	end

	scrollpanel:SetParent(Frame)
	scrollpanel:Dock(FILL)
	scrollpanel.w = w
	keys = table.GetKeys(self.Skins)

	table.sort(keys, function(a, b)
		local namea = self.Skins[a].name
		local nameb = self.Skins[b].name
		local aval = string.lower( language.GetPhrase( namea or tostring(a) ) )
		local bval = string.lower( language.GetPhrase( nameb or tostring(b) ) )

		return aval < bval
	end)

	table.RemoveByValue(keys, "Stock")
	table.insert(keys, 1, "Stock")

	if not self.Skins["Stock"] then
		self.Skins["Stock"] = {
			["name"] = "Stock",
			["tbl"] = {}
		}
	end

	table.RemoveByValue(keys, "BaseClass")
	local yy = 0
	local div

	for i = 1, #keys do
		local k = keys[i]
		local v = self.Skins[k]
		local tmpw = scrollpanel.w

		if not tmpw then
			tmpw = scrollpanel:GetSize()
		end

		local dbtn = vgui.Create("DButton")
		dbtn:SetParent(scrollpanel)
		local name = v.name and v.name or k

		if v.image then
			isimage = true
			dbtn:SetText("")
		else
			dbtn:SetText(name)
		end --file.Exists( "materials/".. (v.image and v.image or "doesn"texists"), "GAME" ) then

		dbtn:SetPos(30, yy + 2)
		dbtn:SetSize(100, 100)
		yy = yy + 100 + 2
		dbtn.skin = k
		dbtn:SetTextColor(btntextcol)

		dbtn.DoClick = function(self2)
			if IsValid(self) and self.Skins and self2.skin and self.Skins[self2.skin] and self.Skins[self2.skin].tbl then
				self.Skin = self2.skin
				self:UpdateSkin()
				self:SyncToServerSkin()
				self:SaveSkin()
			end
		end

		--[[
		if !isimage then
			dbtn.Paint = function(self,wv,hv)
				draw.NoTexture()
				surface.SetDrawColor(buttoncolor_inactive)
				surface.DrawRect(0,0,wv,hv)
			end
		else
		]]
		--
		dbtn.Paint = function(self2, wv, hv)
			draw.NoTexture()

			if not self2.mat then
				self2.mat = Material(v.image and v.image or "vgui/tfa_csgo/default_flat")
			end

			surface.SetMaterial(self2.mat)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect(0, 0, wv, hv)
			surface.SetDrawColor(bordercol)
			draw.NoTexture()
			surface.DrawRect(0, 0, 2, hv)
			surface.DrawRect(wv - 2, 0, 2, hv)
			surface.DrawRect(0, 0, wv, 2)
			surface.DrawRect(0, hv - 2, wv, 2)
		end

		--end
		local dlbl = vgui.Create("DLabel")
		dlbl:SetParent(scrollpanel)
		dlbl:SetFont(labfont.font)
		local xpos = 30 + 100 + 2 + 32
		dlbl:SetPos(xpos, yy - 100)
		dlbl:SetSize(tmpw - xpos - 30, 100)
		dlbl:SetText(name)
		dlbl.skin = k

		dlbl.DoClick = function(self2)
			if IsValid(self) and self.Skins and self2.skin and self.Skins[self2.skin] and self.Skins[self2.skin].tbl then
				self.Skin = self2.skin
				self:UpdateSkin()
				self:SaveSkin()
				self:SyncToServerSkin()
			end
		end

		local extrapadding = 4
		div = vgui.Create("DPanel")
		div:SetParent(scrollpanel)
		div:SetSize(tmpw / 2, 2)
		div:SetPos(0, yy + 2 + extrapadding)

		div.Paint = function(self2, wv, hv)
			if not self2.img then
				self2.img = Material("vgui/spellkaster/divgrad")
			end

			draw.NoTexture()
			surface.SetDrawColor(divcolor)
			surface.SetMaterial(self2.img)
			surface.DrawTexturedRect(0, 0, wv, hv)
		end

		yy = yy + 4 + extrapadding * 2
	end

	if LocalPlayer():GetPData( LocalPlayer():GetActiveWeapon():GetClass() .. "_name" ) then
		local NametagEntry = vgui.Create( "DTextEntry", Frame ) -- create the form as a child of frame
		NametagEntry:Dock( BOTTOM )
		NametagEntry:DockMargin( Frame:GetWide() / 2.5, 0, Frame:GetWide() / 2.5, 0 )
		NametagEntry:SetSize( Frame:GetWide() / 6, Frame:GetTall() / 25 )
		NametagEntry:SetText( LocalPlayer():GetPData( LocalPlayer():GetActiveWeapon():GetClass() .. "_name" ) )
		NametagEntry.OnEnter = function( self )
			LocalPlayer():SetPData( LocalPlayer():GetActiveWeapon():GetClass() .. "_name", self:GetValue() )
		end
		NametagEntry.OnTextChanged = function(self)

			if string.len( self:GetValue() ) <= 20 then
				self.OldText = self:GetValue()
			else
				self:SetValue( self.OldText or "" )
				self:SetText( self.OldText or "" )
			end

		end
		NametagEntry.Paint = function( self, w, h )
			if self:IsEditing() then
				surface.SetDrawColor( 200, 200, 200, 255 )
				surface.DrawRect( 0, 0, w, h )
				if math.fmod( math.Round( RealTime() ), 2 ) == 0 then
					draw.DrawText( self:GetValue(), "TFA_CSGO_NamePicker", w/2, 0 + 3, Color( 0, 0, 0 ), TEXT_ALIGN_CENTER)
				else
					draw.DrawText( self:GetValue() .. "|", "TFA_CSGO_NamePicker", w/2, 0 + 3, Color( 0, 0, 0 ), TEXT_ALIGN_CENTER)
				end
			else
				surface.SetDrawColor( 128, 128, 128, 30 )
				surface.DrawRect( 0, 0, w, h )
				draw.DrawText( self:GetValue(), "TFA_CSGO_NamePicker", w/2, 0 + 3, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER)
			end
		end
	end
	if div and div.Remove then
		div:Remove()
	end
end

function SWEP:SaveSkin()
	if CLIENT then
		if not file.Exists("tfa_csgo/", "DATA") then
			file.CreateDir("tfa_csgo")
		end

		local f = file.Open("tfa_csgo/" .. self:GetClass() .. ".txt", "w", "DATA")
		f:Write(self.Skin and self.Skin or "")
		f:Flush()
	end
end

function SWEP:SyncToServerSkin(skin)
	if not skin or string.len(skin) <= 0 then
		skin = self.Skin
	end

	if not skin then return end
	if not CLIENT then return end
	net.Start("TFA_CSGO_SKIN")
	net.WriteEntity(self)
	net.WriteString(skin)
	net.SendToServer()
end

function SWEP:LoadSkinTable()
	if true then return end
	local cl = self:GetClass()

	if TFA.CSGO.Skins[cl] then
		for k, v in pairs(TFA.CSGO.Skins[cl]) do
			self.Skins[k] = v
		end
	end
end

function SWEP:ReadSkin()
	if CLIENT then
		self:LoadSkinTable()

		local cl = self:GetClass()

		local path = "tfa_csgo/" .. cl .. ".txt"

		if file.Exists(path, "DATA") then
			local f = file.Read(path, "DATA")

			if f and v ~= "" then
				self.Skin = f
			end
		end

		self:SetNWString("skin", self.Skin)
		self:SyncToServerSkin()
	end

	self:UpdateSkin()
end

function SWEP:UpdateSkin()
	if (CLIENT and IsValid(LocalPlayer()) and LocalPlayer() ~= self.Owner) or SERVER then
		self:SetMaterial("")
		self.Skin = self:GetNWString("skin")

		if self.Skins and self.Skins[self.Skin] and self.Skins[self.Skin].tbl then
			self:SetSubMaterial(nil, nil)

			for k, str in ipairs(self.Skins[self.Skin].tbl) do
				if type(str) == "string" then
					self:SetSubMaterial(k - 1, str)

					return
				end
			end
		end
	end

	if not self.Skin then
		self.Skin = ""
	end

	if self.Skin and self.Skins and self.Skins[self.Skin] then
		self.MaterialTable = self.Skins[self.Skin].tbl

		for l, b in pairs(self.MaterialTable) do
			TFA.CSGO.LoadCachedVMT( string.sub(b,2) )
			print("Requesting skin #"..l.."//"..string.sub(b,2))
			if type(b) == "string" and string.sub(b, 1, 4) == "http" then
				GetHTMLMaterialVL(b, function(matn)
					if IsValid(self) then
						self.MaterialTable[k] = matn
						self.MaterialCache = nil
						self.MaterialCached = nil
						self.MaterialsCache = nil
						self.MaterialsCached = nil
					end
				end)
			end
		end

		self.MaterialCache = nil
		self.MaterialCached = nil
		self.MaterialsCache = nil
		self.MaterialsCached = nil
	end
end

local NumberMaterials

local function UpdateStattrackMaterials()
	NumberMaterials = {}

	local i = 0

	while i <= 9 do
		NumberMaterials[i] = Material("vgui/stattrack/" .. i)

		i = i + 1
	end
end

local function DrawStattrackNumber(number, knife)
	UpdateStattrackMaterials()

	if not knife then
		surface.SetMaterial(NumberMaterials[number or 0])
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect(16, 0, 32, 48)
	end

end

local function Stattrack_Calc(wep, digit)
	local stattrack_string

	if not wep.Kills then
		wep.Kills = 0
	end

	stattrack_string = tostring(math.min(math.Round(wep.Kills), 999999))

	while string.len(stattrack_string) < 6 do
		stattrack_string = "0" .. stattrack_string
	end

	return tonumber(string.sub(stattrack_string, digit, digit))
end

SWEP.LerpLight = Vector( 1, 1, 1 )

SWEP.VElements = {
	["digit6"] = {
		type = "Quad",
		name = digit6,
		bone = "v_weapon.stattrack",
		rel = "",
		pos = Vector(0.25, -0.35, 0.4),
		angle = Angle(0, 90, 90),
		size = 0.01,
		draw_func = function(wep)
			DrawStattrackNumber(Stattrack_Calc(wep, 6), wep.IsKnife)
		end,
		stattrack = true,
		digit6 = true
	},
	["digit5"] = {
		type = "Quad",
		name = digit5,
		bone = "v_weapon.stattrack",
		rel = "",
		pos = Vector(0.25, -0.1, 0.4),
		angle = Angle(0, 90, 90),
		size = 0.01,
		draw_func = function(wep)
			DrawStattrackNumber(Stattrack_Calc(wep, 5), wep.IsKnife)
		end,
		stattrack = true,
		digit5 = true
	},
	["digit4"] = {
		type = "Quad",
		name = digit4,
		bone = "v_weapon.stattrack",
		rel = "",
		pos = Vector(0.25, 0.15, 0.4),
		angle = Angle(0, 90, 90),
		size = 0.01,
		draw_func = function(wep)
			DrawStattrackNumber(Stattrack_Calc(wep, 4), wep.IsKnife)
		end,
		stattrack = true,
		digit4 = true
	},
	["digit3"] = {
		type = "Quad",
		name = digit3,
		bone = "v_weapon.stattrack",
		rel = "",
		pos = Vector(0.25, 0.4, 0.4),
		angle = Angle(0, 90, 90),
		size = 0.01,
		draw_func = function(wep)
			DrawStattrackNumber(Stattrack_Calc(wep, 3), wep.IsKnife)
		end,
		stattrack = true,
		digit3 = true
	},
	["digit2"] = {
		type = "Quad",
		name = digit2,
		bone = "v_weapon.stattrack",
		rel = "",
		pos = Vector(0.25, 0.65, 0.4),
		angle = Angle(0, 90, 90),
		size = 0.01,
		draw_func = function(wep)
			DrawStattrackNumber(Stattrack_Calc(wep, 2), wep.IsKnife)
		end,
		stattrack = true,
		digit2 = true
	},
	["digit1"] = {
		type = "Quad",
		bone = "v_weapon.stattrack",
		rel = "",
		pos = Vector(0.25, 0.9, 0.4),
		angle = Angle(0, 90, 90),
		size = 0.01,
		draw_func = function(wep)
			DrawStattrackNumber(Stattrack_Calc(wep, 1), wep.IsKnife)
		end,
		stattrack = true,
		digit1 = true
	},
	["stattrak"] = {
		type = "Model",
		model = "models/weapons/tfa_csgo/stattrack.mdl",
		bone = "v_weapon.stattrack",
		rel = "",
		pos = Vector(0, 0, 0),
		angle = Angle(0, -90, 0),
		size = Vector(1, 1, 1),
		color = Color(255, 255, 255, 255),
		surpresslightning = false,
		material = "",
		skin = 0,
		bodygroup = {},
		stattrack = true
	},
	["nametag"] = {
		type = "Model",
		model = "models/weapons/tfa_csgo/uid.mdl",
		bone = "v_weapon.uid",
		rel = "",
		pos = Vector(0, 0, 0),
		angle = Angle(0, -90, 0),
		size = Vector(1, 1, 1),
		color = Color(255, 255, 255, 255),
		surpresslightning = false,
		material = "",
		skin = 0,
		bodygroup = {},
		stattrack = false,
		nametag = true
	},
	["nametag_text"] = {
		type = "Quad",
		bone = "",
		rel = "nametag",
		pos = Vector(0, -0.025, 0.19),
		angle = Angle(180, 0, -90),
		size = 0.01,
		draw_func = function(wep)
			local lightcolor = render.GetLightColor( LocalPlayer():GetViewModel():GetBonePosition( LocalPlayer():GetViewModel():LookupBone( "v_weapon.uid" ) ) )
			wep.LerpLight = LerpVector( FrameTime() * 10, wep.LerpLight, lightcolor)
			local finalcolor = wep.LerpLight:ToColor()
			finalcolor.r = finalcolor.r * 1.5
			finalcolor.g = finalcolor.g * 1.5
			finalcolor.b = finalcolor.b * 1.5
			draw.DrawText( LocalPlayer():GetPData( LocalPlayer():GetActiveWeapon():GetClass() .. "_name" ), "TFA_CSGO_Nametag", 0, 0, finalcolor, TEXT_ALIGN_CENTER)
		end,
		stattrack = false,
		nametag = true
	}
}

SWEP.Kills = 0

function SWEP:WriteKills()
	if CLIENT then
		--print("writing")
		--print("tfa_csgo/"..self:GetClass().."_kills.txt")
		if not file.Exists("tfa_csgo/", "DATA") then
			file.CreateDir("tfa_csgo")
		end

		local f = file.Open("tfa_csgo/" .. self:GetClass() .. "_kills.txt", "w", "DATA")
		f:Write(tostring(self.Kills and self.Kills or 0))
		f:Flush()
	end
end

function SWEP:ReadKills()
	if SERVER then
		self:CallOnClient("ReadKills", "")
	end

	if CLIENT then
		if not file.Exists("tfa_csgo/", "DATA") then
			file.CreateDir("tfa_csgo")
		end

		local path = "tfa_csgo/" .. self:GetClass() .. "_kills.txt"

		if file.Exists(path, "DATA") then
			local f = file.Read(path, "DATA")

			if f then
				--print(f)
				self.Kills = tonumber(f)
			end
		end
	end
end

function SWEP:IncrementKills()
	--print("incrementing")
	self.Kills = self.Kills and self.Kills + 1 or 1
	self.KillIncrement = self.KillIncrement and self.KillIncrement + 1 or 1

	if self.KillIncrement >= 5 then
		self:WriteKills()
		self.KillIncrement = 0
	end
end

hook.Add("OnNPCKilled", "Stattrack_NPC", function(npc, attacker, inflictor)
	if not SERVER then return end
	local wep

	if IsValid(inflictor) then
		wep = inflictor

		if inflictor:IsPlayer() and inflictor.GetActiveWeapon and IsValid(inflictor:GetActiveWeapon()) then
			wep = inflictor:GetActiveWeapon()
		end
	end

	if not IsValid(wep) then return end
	if not wep:IsWeapon() then return end

	if wep.IncrementKills then
		wep:CallOnClient("IncrementKills")
		wep:IncrementKills()
	end
end)

hook.Add("PlayerDeath", "Stattrack_PLY", function(npc, inflictor, attacker)
	if not SERVER then return end
	local wep

	if IsValid(inflictor) then
		wep = inflictor

		if inflictor:IsPlayer() and inflictor.GetActiveWeapon and IsValid(inflictor:GetActiveWeapon()) then
			wep = inflictor:GetActiveWeapon()
		end
	end

	if not IsValid(wep) then return end
	if not wep:IsWeapon() then return end

	if wep.IncrementKills then
		wep:CallOnClient("IncrementKills")
		wep:IncrementKills()
	end
end)

if CLIENT and not GetConVar("cl_tfa_csgo_stattrack") then
	CreateClientConVar("cl_tfa_csgo_stattrack", 1, true, true)
end

local stattrak_cv = GetConVar("cl_tfa_csgo_stattrack")

function SWEP:SetKnifeStatMaterial( ent, num, kills )
	local kills_length = 6 - string.len( tostring( self.Kills ) )
	if num >= kills_length and self.Kills >= 1 then
		ent:SetSubMaterial( num, "vgui/stattrack_knife/" .. kills )
	else
		ent:SetSubMaterial( num, "vgui/stattrack_knife/blank" )
	end
end

function SWEP:UpdateStattrack()
	local dostattrack = stattrak_cv:GetBool() and not self.NoStattrak

	if not self:IsValid() then return end

	--print(dostattrack)
	for l, b in pairs(self.VElements) do
		if b.stattrack then
			if dostattrack then
				b.active = true
				if self.IsKnife and b.curmodel then
					local ent = ent or b.curmodel
					if IsValid( ent ) then
						for i = 5, 0, -1 do
							self:SetKnifeStatMaterial( ent, i, Stattrack_Calc( self, i + 1 ) )
						end
					end
				end
			else
				b.active = false
			end
		end
		if self.IsKnife and b.model == "models/weapons/tfa_csgo/stattrack.mdl" then
			b.model = "models/weapons/tfa_csgo/stattrack_cut.mdl"
		end
		if b.model == "models/weapons/tfa_csgo/stattrack.mdl" and self:GetClass() == "tfa_csgo_mp5" then
			b.bone = "v_weapon.MP5_Parent"
			b.pos = Vector(0.518, -2.597, 3.7)
			b.angle = Angle( 90, -90, 0 )
		elseif b.type == "Quad" and b.stattrack and b.digit1 and self:GetClass() == "tfa_csgo_mp5" then
			b.bone = "v_weapon.MP5_Parent"
			b.pos = Vector(0.74, -3.00, 4.65)
			b.angle = Angle(-90, 0, 0)
		elseif b.type == "Quad" and b.stattrack and b.digit2 and self:GetClass() == "tfa_csgo_mp5" then
			b.bone = "v_weapon.MP5_Parent"
			b.pos = Vector(0.74, -3.00, 4.40)
			b.angle = Angle(-90, 0, 0)
		elseif b.type == "Quad" and b.stattrack and b.digit3 and self:GetClass() == "tfa_csgo_mp5" then
			b.bone = "v_weapon.MP5_Parent"
			b.pos = Vector(0.74, -3.00, 4.15)
			b.angle = Angle(-90, 0, 0)
		elseif b.type == "Quad" and b.stattrack and b.digit4 and self:GetClass() == "tfa_csgo_mp5" then
			b.bone = "v_weapon.MP5_Parent"
			b.pos = Vector(0.74, -3.00, 3.90)
			b.angle = Angle(-90, 0, 0)
		elseif b.type == "Quad" and b.stattrack and b.digit5 and self:GetClass() == "tfa_csgo_mp5" then
			b.bone = "v_weapon.MP5_Parent"
			b.pos = Vector(0.74, -3.00, 3.65)
			b.angle = Angle(-90, 0, 0)
		elseif b.type == "Quad" and b.stattrack and b.digit6 and self:GetClass() == "tfa_csgo_mp5" then
			b.bone = "v_weapon.MP5_Parent"
			b.pos = Vector(0.74, -3.00, 3.40)
			b.angle = Angle(-90, 0, 0)
		end

		if b.model == "models/weapons/tfa_csgo/stattrack.mdl" and self:GetClass() == "tfa_csgo_scar17" then
			b.bone = "gun_root"
			b.pos = Vector(0.5, -0.801, 0.62)
			b.angle = Angle(0, -90, 0)
		elseif b.type == "Quad" and b.stattrack and b.digit1 and self:GetClass() == "tfa_csgo_scar17" then
			b.bone = "gun_root"
			b.pos = Vector(0.73, 0.15, 1.03)
			b.angle = Angle(0, 90, 90)
		elseif b.type == "Quad" and b.stattrack and b.digit2 and self:GetClass() == "tfa_csgo_scar17" then
			b.bone = "gun_root"
			b.pos = Vector(0.73, -0.10, 1.03)
			b.angle = Angle(0, 90, 90)
		elseif b.type == "Quad" and b.stattrack and b.digit3 and self:GetClass() == "tfa_csgo_scar17" then
			b.bone = "gun_root"
			b.pos = Vector(0.73, -0.35, 1.03)
			b.angle = Angle(0, 90, 90)
		elseif b.type == "Quad" and b.stattrack and b.digit4 and self:GetClass() == "tfa_csgo_scar17" then
			b.bone = "gun_root"
			b.pos = Vector(0.73, -0.60, 1.03)
			b.angle = Angle(0, 90, 90)
		elseif b.type == "Quad" and b.stattrack and b.digit5 and self:GetClass() == "tfa_csgo_scar17" then
			b.bone = "gun_root"
			b.pos = Vector(0.73, -0.85, 1.03)
			b.angle = Angle(0, 90, 90)
		elseif b.type == "Quad" and b.stattrack and b.digit6 and self:GetClass() == "tfa_csgo_scar17" then
			b.bone = "gun_root"
			b.pos = Vector(0.73, -1.10, 1.03)
			b.angle = Angle(0, 90, 90)
		end

	end
end

if CLIENT and not GetConVar("cl_tfa_csgo_nametag") then
	CreateClientConVar("cl_tfa_csgo_nametag", 1, true, true)
end

local nametag_cv = GetConVar("cl_tfa_csgo_nametag")

function SWEP:UpdateNameTag()
	local donametag = nametag_cv:GetBool()

	if not IsValid(self) then return end

	for l, b in pairs(self.VElements) do
		if b.nametag then
			if donametag then
				b.active = true
			else
				b.active = false
			end
		end
		if self.IsKnife and b.model == "models/weapons/tfa_csgo/uid.mdl" and b.nametag and self:GetClass() == "tfa_csgo_knife_classic" then
			b.pos = Vector(-0.141, -1.5, -0.151)
			b.angle = Angle(3.506, -90, -12.858)
		end
		if b.model == "models/weapons/tfa_csgo/uid.mdl" and self:GetClass() == "tfa_csgo_mp5" then
			b.bone = "v_weapon.MP5_Parent"
			b.pos = Vector(0.5, -5, 2.5)
			b.angle = Angle( 90, 0, -90 )
		elseif b.type == "Quad" and b.nametag and self:GetClass() == "tfa_csgo_mp5" then
			b.draw_func = function(wep)
				local lightcolor = render.GetLightColor( LocalPlayer():GetViewModel():GetBonePosition( LocalPlayer():GetViewModel():LookupBone( "v_weapon.MP5_Parent" ) ) )
				wep.LerpLight = LerpVector( FrameTime() * 10, wep.LerpLight, lightcolor)
				local finalcolor = wep.LerpLight:ToColor()
				finalcolor.r = finalcolor.r * 1.5
				finalcolor.g = finalcolor.g * 1.5
				finalcolor.b = finalcolor.b * 1.5
				draw.DrawText( LocalPlayer():GetPData( LocalPlayer():GetActiveWeapon():GetClass() .. "_name" ), "TFA_CSGO_Nametag", 0, 0, finalcolor, TEXT_ALIGN_CENTER)
			end
		end
		if b.model == "models/weapons/tfa_csgo/uid.mdl" and self:GetClass() == "tfa_csgo_scar17" then
			b.bone = "gun_root"
			b.pos = Vector(0.314, -0.52, 1.759)
			b.angle = Angle( 0, -90, 0 )
		elseif b.type == "Quad" and b.nametag and self:GetClass() == "tfa_csgo_scar17" then
			b.draw_func = function(wep)
				local lightcolor = render.GetLightColor( LocalPlayer():GetViewModel():GetBonePosition( LocalPlayer():GetViewModel():LookupBone( "gun_root" ) ) )
				wep.LerpLight = LerpVector( FrameTime() * 10, wep.LerpLight, lightcolor)
				local finalcolor = wep.LerpLight:ToColor()
				finalcolor.r = finalcolor.r * 1.5
				finalcolor.g = finalcolor.g * 1.5
				finalcolor.b = finalcolor.b * 1.5
				draw.DrawText( LocalPlayer():GetPData( LocalPlayer():GetActiveWeapon():GetClass() .. "_name" ), "TFA_CSGO_Nametag", 0, 0, finalcolor, TEXT_ALIGN_CENTER)
			end
		end
		if b.model == "models/weapons/tfa_csgo/uid.mdl" and self:GetClass() == "tfa_csgo_glock18" then
			b.model = "models/weapons/tfa_csgo/uid_small.mdl"
		elseif b.type == "Quad" and b.nametag and self:GetClass() == "tfa_csgo_glock18" then
			b.pos = Vector(0, -0.025, 0.13)
			b.draw_func = function(wep)
				local lightcolor = render.GetLightColor( LocalPlayer():GetViewModel():GetBonePosition( LocalPlayer():GetViewModel():LookupBone( "v_weapon.uid" ) ) )
				wep.LerpLight = LerpVector( FrameTime() * 10, wep.LerpLight, lightcolor)
				local finalcolor = wep.LerpLight:ToColor()
				finalcolor.r = finalcolor.r * 1.5
				finalcolor.g = finalcolor.g * 1.5
				finalcolor.b = finalcolor.b * 1.5
				draw.DrawText( LocalPlayer():GetPData( LocalPlayer():GetActiveWeapon():GetClass() .. "_name" ), "TFA_CSGO_Nametag_Small", 0, 0, finalcolor, TEXT_ALIGN_CENTER)
			end
		end
	end
end

if not GetConVar("cl_tfa_csgo_2dshells") then
	CreateClientConVar("cl_tfa_csgo_2dshells", 1, true, true)
end

local shells_cv = GetConVar("cl_tfa_csgo_2dshells")

function SWEP:UpdateShells()
	local doshells = shells_cv:GetBool()

	if not self:IsValid() then return end

	if doshells then
		self.ShellEffectOverride = "tfa_shell_csgo"
	else
		self.ShellEffectOverride = nil
	end
end

function SWEP:Think2( ... )
	if ((CLIENT and IsValid(LocalPlayer()) and LocalPlayer() ~= self.Owner) or SERVER) and self.Skin ~= self:GetNWString("skin") then
		self.Skin = self:GetNWString("skin")
		self:UpdateSkin()
	end
	if CLIENT then
		self:UpdateStattrack()
		self:UpdateNameTag()
	end

	self:UpdateShells()

	BaseClass.Think2(self, ... )
end

function SWEP:Think()
end

SWEP.HandModels = {
	[0] = "models/weapons/tfa_csgo/hands/ct_arms.mdl",
	[1] = "models/weapons/tfa_csgo/hands/ct_arms_fbi.mdl",
	[2] = "models/weapons/tfa_csgo/hands/ct_arms_gign.mdl",
	[3] = "models/weapons/tfa_csgo/hands/ct_arms_gsg9.mdl",
	[4] = "models/weapons/tfa_csgo/hands/ct_arms_idf.mdl",
	[5] = "models/weapons/tfa_csgo/hands/ct_arms_sas.mdl",
	[6] = "models/weapons/tfa_csgo/hands/ct_arms_st6.mdl",
	[7] = "models/weapons/tfa_csgo/hands/ct_arms_swat.mdl",
	[8] = "models/weapons/tfa_csgo/hands/t_arms.mdl",
	[9] = "models/weapons/tfa_csgo/hands/t_arms_anarchist.mdl",
	[10] = "models/weapons/tfa_csgo/hands/t_arms_balkan.mdl",
	[11] = "models/weapons/tfa_csgo/hands/t_arms_leet.mdl",
	[12] = "models/weapons/tfa_csgo/hands/t_arms.mdl",
	[13] = "models/weapons/tfa_csgo/hands/t_arms_pirate.mdl",
	[14] = "models/weapons/tfa_csgo/hands/t_arms_professional.mdl",
	[15] = "models/weapons/tfa_csgo/hands/t_arms_separatist.mdl",
	[16] = "models/weapons/tfa_csgo/haleg/ct_arms.mdl",
	[17] = "models/weapons/tfa_csgo/haleg/ct_arms_fbi.mdl",
	[18] = "models/weapons/tfa_csgo/haleg/ct_arms_gign.mdl",
	[19] = "models/weapons/tfa_csgo/haleg/ct_arms_gsg9.mdl",
	[20] = "models/weapons/tfa_csgo/haleg/ct_arms_idf.mdl",
	[21] = "models/weapons/tfa_csgo/haleg/ct_arms_sas.mdl",
	[22] = "models/weapons/tfa_csgo/haleg/ct_arms_st6.mdl",
	[23] = "models/weapons/tfa_csgo/haleg/ct_arms_swat.mdl",
	[24] = "models/weapons/tfa_csgo/haleg/t_arms.mdl",
	[25] = "models/weapons/tfa_csgo/haleg/t_arms_anarchist.mdl",
	[26] = "models/weapons/tfa_csgo/haleg/t_arms_balkan.mdl",
	[27] = "models/weapons/tfa_csgo/haleg/t_arms_leet.mdl",
	[28] = "models/weapons/tfa_csgo/haleg/t_arms_phoenix.mdl",
	[29] = "models/weapons/tfa_csgo/haleg/t_arms_pirate.mdl",
	[30] = "models/weapons/tfa_csgo/haleg/t_arms_professional.mdl",
	[31] = "models/weapons/tfa_csgo/haleg/t_arms_separatist.mdl",
	[32] = "models/weapons/c_arms_cstrike.mdl",
}

SWEP.HandModelsValveBiped = {
	[32] = true,
}

function SWEP:DrawHands()
	if not IsValid(self) or not self:OwnerIsValid() then return end
	local vm = self.OwnerViewModel
	if not IsValid(vm) then return end
	local ply = self:GetOwner()

	if not IsValid(ply.CSGOHands) then
		ply.CSGOHands = ClientsideModel("models/weapons/c_arms_cstrike.mdl")
		ply.CSGOHands:SetNoDraw(true)
	end

	ply.CSGOHands:SetParent(vm)
	ply.CSGOHands:SetPos(vm:GetPos())
	ply.CSGOHands:SetAngles(vm:GetAngles())
	ply.CSGOHands:AddEffects(EF_BONEMERGE)

	if not IsValid(ply.CSGOPMHands) then
		ply.CSGOPMHands = ClientsideModel("models/weapons/tfa_csgo/c_hands_translator.mdl")
		ply.CSGOPMHands:SetNoDraw(true)
	end

	ply.CSGOPMHands:SetParent(vm)
	ply.CSGOPMHands:SetPos(vm:GetPos())
	ply.CSGOPMHands:SetAngles(vm:GetAngles())
	ply.CSGOPMHands:AddEffects(EF_BONEMERGE)

	if not self.handenablecvar then
		self.handenablecvar = GetConVar("cl_tfa_csgo_arms_enabled")
	end

	if not self.handpathcvar then
		self.handpathcvar = GetConVar("cl_tfa_csgo_arms_id")
	end

	if ply.CSGOHands and self.handenablecvar and self.handenablecvar:GetBool() then
		self.UseHands = false

		local selected = self.handpathcvar and self.handpathcvar:GetInt() or 0

		local newmdl = self.HandModels[selected] or self.HandModels[0]

		if ply.CSGOHands:GetModel() ~= newmdl then
			ply.CSGOHands:SetModel(newmdl)
		end

		if self.HandModelsValveBiped[selected] then
			ply.CSGOHands:SetParent(ply.CSGOPMHands)
			ply.CSGOHands:AddEffects(EF_BONEMERGE)
		end

		ply.CSGOHands:DrawModel()
	else
		self.UseHands = true

		if not vm:LookupBone("ValveBiped.Bip01_R_Hand") then
			ply.CSGOPMHands:SetPos(vm:GetPos())
			ply.CSGOPMHands:SetAngles(vm:GetAngles())
			ply.CSGOPMHands:AddEffects(EF_BONEMERGE)

			local plyhands = ply:GetHands()
			if IsValid(plyhands) then
				plyhands:SetParent(ply.CSGOPMHands)
				plyhands:AddEffects(EF_BONEMERGE)
				plyhands:DrawModel()
			end
		end
	end
end

function SWEP:SetBodyGroupVM(k, v)
    if isstring(k) then
        local vals = k:Split(" ")
        k = vals[1]
        v = vals[2]
    end

    self.Bodygroups_V[k] = v

    if SERVER then
        self:CallOnClient("SetBodyGroupVM", "" .. k .. " " .. v)
    end
end