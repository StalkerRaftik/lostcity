AddCSLuaFile()

SWEP.PrintName 				= "Underhell Base"
SWEP.Author 				= ""
SWEP.Contact 				= ""
SWEP.Purpose 				= ""
SWEP.Instructions 			= ""
SWEP.Category 				= "LostCity Edged Weapons"
SWEP.UseHands 				= false

SWEP.Spawnable 				= false
SWEP.AdminSpawnable 		= false

SWEP.ViewModelFOV 			= 64
SWEP.ViewModel				= "models/weapons/v_smg_mp5_pg.mdl"
SWEP.WorldModel				= "models/weapons/w_smg_mp5_pg.mdl"

SWEP.AutoSwitchTo			= true		 
SWEP.AutoSwitchFrom			= true

SWEP.Slot 					= 2
SWEP.SlotPos 				= 0

SWEP.HoldType 				= "smg"
SWEP.PassiveAnim			= "passive"
SWEP.FiresUnderwater 		= false
SWEP.Weight 				= 45
SWEP.DrawCrosshair 			= false
SWEP.DrawAmmo 				= false
SWEP.DrawWeaponInfoBox 		= false

SWEP.Primary.ClipSize 		= 30
SWEP.Primary.Ammo 			= "smg1" 
SWEP.Primary.DefaultClip 	= 30
SWEP.Primary.Automatic 		= true

SWEP.Secondary.ClipSize 	= -1 
SWEP.Secondary.Ammo 		= "none" 
SWEP.Secondary.DefaultClip 	= -1     
SWEP.Secondary.Automatic 	= false

SWEP.SwayScale 	= 0
SWEP.BobScale 	= 0

SWEP.SwayPosition = 2


-- Movement
local c_jump = 0
local c_look = 0
local c_move = 0
local c_sight = 0

-- Ironsights
local c_iron = 0

-- Grenades
local c_lob = 0

-- Sway
local c_oang = Angle( 0, 0, 0 )
local c_dang = Angle( 0, 0, 0 )

-- Inspection
local c_iang = Angle( 0, 0, 0 )
local c_ipos = Vector( 0, 0, 0 )

SWEP.IronSightsPos = Vector(-6, -8, -10)
SWEP.IronSightsAng = Vector(20, 40, -60)

SWEP.Inspection = {}

SWEP.LeftBones = {
	["Left_U_Arm"] = Angle(-50,50,-50)
}


function SWEP:GetViewModelPosition(pos, ang)
	local sp,ct,ft,iftp = game.SinglePlayer(),CurTime(),FrameTime(),IsFirstTimePredicted()
	if sp then iftp = true end
	
	local pos,ang = self:Inspect(pos,ang,ct)
	local pos,ang = self:Grenade(pos,ang,ct,ft,iftp)
	local pos,ang = self:Sway(pos,ang,ft,iftp)
	local pos,ang = self:Movement(pos,ang,ct,ft,iftp)
	
	if self.IronSightsPos and self.IronSightsAng then
		pos,ang = self:Sights(pos,ang,ft,iftp)
	end
	
	return pos,ang
end

function SWEP:Inspect(pos, ang, ct)
	if !GetConVar("uh_sv_deploy"):GetBool() then return pos,ang end
	local t = (self:GetNWFloat("DeployTime")-ct)
	if t > 0 then
		if t > 2 then
			local p = math.Clamp((1-(t-2))*2, 0, 1)
			local stage = self.Inspection[1]
			c_iang = LerpAngle( p, Angle(0, 0, 0), stage.ang )
			c_ipos = LerpVector( p, Vector(0, 0, 0), stage.pos )
		elseif t > 1 then
			local p = math.Clamp((1-(t-1))*2, 0, 1)
			local oldstage = self.Inspection[1]
			local stage = self.Inspection[2]
			c_iang = LerpAngle( p, oldstage.ang, stage.ang )
			c_ipos = LerpVector( p, oldstage.pos, stage.pos )
		else
			local p = 1-t
			local stage = self.Inspection[2]
			c_iang = LerpAngle( p, stage.ang, Angle(0, 0, 0) )
			c_ipos = LerpVector( p, stage.pos, Vector(0, 0, 0) )
		end
		
		ang:RotateAroundAxis(ang:Right(), 	c_iang.p)
		ang:RotateAroundAxis(ang:Up(), 		c_iang.y)
		ang:RotateAroundAxis(ang:Forward(), c_iang.r)
		
		pos = pos + ang:Right() * c_ipos.x + ang:Forward() * c_ipos.y + ang:Up() * c_ipos.z
	end
	return pos,ang
end

function SWEP:Grenade(pos, ang, ct, ft, iftp)
	if iftp then
		if self.Owner:GetNWFloat("UH_GrenadeTime") > ct then
			local t = self.Owner:GetNWFloat("UH_GrenadeTime") - ct
			if t > 0.5 then
				c_lob = Lerp( math.Clamp(ft * 6, 0, 1), c_lob or 0, 1)
			else
				c_lob = Lerp( math.Clamp(ft * 6, 0, 1), c_lob or 0, 0)
			end
		else
			c_lob = Lerp( math.Clamp(ft * 6, 0, 1), c_lob or 0, 0)
		end
	end
	
	ang:RotateAroundAxis(ang:Up(), -c_lob*12)
	ang:RotateAroundAxis(ang:Forward(), c_lob*5)
	
	return pos,ang
end

function SWEP:Sights(pos, ang, ft, iftp)
	if iftp then
		c_iron = Lerp(math.min(ft * 10, 1), c_iron or 0, self:GetUHBool("Zooming") and self.Owner:OnGround() and 1 or 0)
	end
	
	local offset = self.IronSightsPos
	
	if self.IronSightsAng then
		ang:RotateAroundAxis(ang:Right(), 	self.IronSightsAng.x * c_iron)
		ang:RotateAroundAxis(ang:Up(), 		self.IronSightsAng.y * c_iron)
		ang:RotateAroundAxis(ang:Forward(), self.IronSightsAng.z * c_iron)
	end
	
	pos = pos + offset.x * c_iron * ang:Right()
	pos = pos + offset.y * c_iron * ang:Forward()
	pos = pos + offset.z * c_iron * ang:Up()
	
	return pos, ang
end

function SWEP:Sway(pos, ang, ft, iftp)
	local sway = GetConVar("uh_vmsway"):GetFloat() or 1.2
	
	if sway == 0 then return pos,ang end
	
    local angdelta = self.Owner:EyeAngles() - c_oang
	
	if angdelta.y >= 180 then
		angdelta.y = angdelta.y - 360
	elseif angdelta.y <= -180 then
		angdelta.y = angdelta.y + 360
	end
	
	angdelta.p = math.Clamp(angdelta.p, -5, 5)
	angdelta.y = math.Clamp(angdelta.y, -5, 5)
	angdelta.r = math.Clamp(angdelta.r, -5, 5)
	
	if self:GetUHBool("Zooming") then
		angdelta = angdelta * 0.05
	end
	
	if iftp then
		local newang = LerpAngle( math.Clamp(ft * 10, 0, 1), c_dang, angdelta )
		c_dang = newang
	end
    c_oang = self.Owner:EyeAngles()
	
	local psway = sway / (self.SwayPosition or 2)
	
	ang:RotateAroundAxis( ang:Right(), -c_dang.p*sway )
	ang:RotateAroundAxis( ang:Up(), c_dang.y*sway )
	ang:RotateAroundAxis( ang:Forward(), c_dang.y*sway )
	
	pos = pos + ang:Right()*c_dang.y*psway + ang:Up()*c_dang.p*psway
	
    return pos,ang
end

function SWEP:Movement(pos, ang, ct, ft, iftp)
	local bob = GetConVar("uh_vmbob"):GetFloat()
	local idle = GetConVar("uh_vmidle"):GetFloat()
	
	if bob == 0 and idle == 0 then return pos,ang end -- No need for a calculator
	
	local move = Vector(self.Owner:GetVelocity().x, self.Owner:GetVelocity().y, 0)
	local movement = move:LengthSqr()
	local movepercent = math.Clamp(movement/self.Owner:GetRunSpeed()^2, 0, 1)
	
	local vel = move:GetNormalized()
	local rd = self.Owner:GetRight():Dot( vel )
	local fd = (self.Owner:GetForward():Dot( vel ) + 1)/2
	
	if iftp then
		local ft8 = math.Clamp(ft * 8, 0, 1)
		
		c_move = Lerp(ft8, c_move or 0, self.Owner:OnGround() and movepercent or 0)
		c_sight = Lerp(ft8, c_sight or 0, self:GetUHBool("Zooming") and self.Owner:OnGround() and 0.15 or 1)
		c_jump = Lerp(ft8, c_jump or 0, self.Owner:GetMoveType() == MOVETYPE_NOCLIP and 0 or math.Clamp(self.Owner:GetVelocity().z/120, -1.5, 1))
		
		if rd > 0.5 then
			c_look = Lerp(math.Clamp(ft * 5, 0, 1), c_look, 5*c_move)
		elseif rd < -0.5 then
			c_look = Lerp(math.Clamp(ft * 5, 0, 1), c_look, -5*c_move)
		else
			c_look = Lerp(math.Clamp(ft * 5, 0, 1), c_look, 0)
		end
	end
	
	pos = pos + ang:Up()*c_jump
	ang.p = ang.p + (c_jump or 0)*2
	ang.r = ang.r + c_look
	
	if bob != 0 and c_move > 0 then
		local p = c_move*c_sight*bob
		pos = pos - ang:Forward()*c_move*c_sight*fd - ang:Up()*0.75*c_move*c_sight
		ang.y = ang.y + math.sin(ct*8.4)*1.95*p
		ang.p = ang.p + math.sin(ct*16.8)*1.2*p
		ang.r = ang.r + math.cos(ct*8.4)*0.3*p
	end
	
	if idle != 0 then
		local p = (1-c_move)*c_sight*idle
		ang.p = ang.p + math.sin(ct*0.5)*1*p
		ang.y = ang.y + math.sin(ct*1)*0.5*p
		ang.r = ang.r + math.sin(ct*2)*0.25*p
	end
	
	return pos,ang
end


function SWEP:FireAnimationEvent(pos, ang, event, name)
	return true -- Fuck the particles.
end

function SWEP:HandleRunning( ct )
	if self:GetUHBool("Running") or self:GetNWInt("FireMode") == 0 then
		self:SetHoldType( self.PassiveAnim )
	else
		self:SetHoldType( self.HoldType )
	end
	
	if !GetConVar("uh_sv_running"):GetBool() then return end
	if self:GetNWInt("FireMode") == 0 then return end
	
	local dist = self.Owner:GetVelocity():LengthSqr()
	
	if self.Owner:KeyDown( IN_SPEED ) and dist > self.Owner:GetWalkSpeed()^2 then
		if !self:GetUHBool("Running") then
			self:SendWeaponAnim( ACT_VM_IDLE )
			self:SendWeaponAnim( ACT_VM_IDLE_TO_LOWERED )
		end
		self:SetUHBool("Running", true)
		self:SetUHBool("Zooming", false)
		
		if self:GetUHBool("Reloading") then
			self:SetUHBool("Reloading", false)
			self.NextReload = ct + 0.5
			if timer.Exists("UHReload_"..self.Owner:SteamID()) then
				timer.Remove( "UHReload_"..self.Owner:SteamID() )
			end
		end
	elseif self:GetUHBool("Running") then
		if self:GetNextPrimaryFire() < ct + 0.5 then
			self:SetNextPrimaryFire( ct + 0.5 )
			self:SetNextSecondaryFire( ct + 0.5 )
		end
		self:SendWeaponAnim( ACT_VM_IDLE_LOWERED )
		self:SendWeaponAnim( ACT_VM_LOWERED_TO_IDLE  )
		self:SetUHBool("Running", false)
	end
end

function SWEP:HandleBones( vm, ct )
	if game.SinglePlayer() or IsFirstTimePredicted() then
		self.c_grenlerp = Lerp( FrameTime() * 5, self.c_grenlerp or 0, (self.Owner:GetNWFloat("UH_ArmTime") > ct or self.Owner:GetNWBool("UH_ArmGone")) and 1 or 0 )
	end
	
	for bone,ang in pairs(self.LeftBones) do
		local bone_id = vm:LookupBone(bone)
		if !bone_id then continue end
		
		vm:ManipulateBoneAngles(bone_id, ang * (self.c_grenlerp or 0))
	end
	
	if self:GetNWBool("Silenced") or self:GetNWFloat("SilenceTime") > ct then
		vm:SetBodygroup(1, 1)
	else
		vm:SetBodygroup(1, 0)
	end
end

function SWEP:HandleHands( vm )
	local skin = math.Clamp(self.Owner:GetInfoNum("uh_hands", 0), -1, 3)
	if skin then
		vm:SetSkin( skin != -1 and skin or 0 )
		if CLIENT and vm.uh_hands != skin then
			vm.uh_hands = skin
			if skin == 0 then
				local handmat = getUHCacheMat( "models/weapons/v_models/hands/v_hands" )
				local newmat = getUHCacheMat( "models/weapons/v_models/hands/v_hands_casual" )
				local oldtex = handmat:GetTexture("$basetexture")
				local newtex = newmat:GetTexture("$basetexture")
				if !cs_oldtex and oldtex != newtex and oldtex:GetName() != newtex:GetName() then
					cs_oldtex = {}
					cs_oldtex.tex = oldtex
					cs_oldtex.detail = handmat:GetTexture("$detail")
					cs_oldtex.blendfactor = handmat:GetFloat("$detailblendfactor") or 0
					cs_oldtex.blendmode = handmat:GetInt("$detailblendmode") or 0
					cs_oldtex.scale = handmat:GetFloat("$detailscale") or 1
				end
				handmat:SetTexture("$basetexture", newtex)
				handmat:SetTexture("$detail", newmat:GetTexture("$detail"))
				handmat:SetFloat("$detailblendfactor", newmat:GetFloat("$detailblendfactor"))
				handmat:SetInt("$detailblendmode", newmat:GetInt("$detailblendmode"))
				handmat:SetFloat("$detailscale", newmat:GetFloat("$detailscale"))
			else
				local handmat = getUHCacheMat( "models/weapons/v_models/hands/v_hands" )
				if cs_oldtex then
					local detail = cs_oldtex.detail
					handmat:SetTexture("$basetexture", cs_oldtex.tex)
					handmat:SetTexture("$detail", detail and !string.find(detail:GetName(), "error") and detail or Material("color"):GetTexture("$basetexture"))
					handmat:SetFloat("$detailblendfactor", cs_oldtex.blendfactor or 0)
					handmat:SetInt("$detailblendmode", cs_oldtex.blendmode or 0)
					handmat:SetFloat("$detailscale", cs_oldtex.scale or 1)
				end
			end
		end
	end
end

function SWEP:Deploy()
	if SERVER then
		if !self.b_ammogiven then
			self.b_ammogiven = true
			if GetConVar("uh_sv_ammo"):GetBool() and self.Primary.ClipSize > 0 then
				self.Owner:GiveAmmo(self.Primary.ClipSize * 5, self.Primary.Ammo, true)
			end
		end
	end
	
	if self.CustomDeploy then
		self:CustomDeploy()
	end
	
	self:SetUHBool("Reloading", false)
	self:SetUHBool("Zooming", false)
	self:SetUHBool("Running", false)
	self:SetNWFloat("ReloadTime", 0)
	self:SetNWFloat("ReloadEndTime", 0)
	self:SendWeaponAnim( ACT_VM_DRAW )
	self.NextReload = CurTime() + 0.5
	self:SetNextPrimaryFire( CurTime() + 1 )
	self:SetNextSecondaryFire( CurTime() + 1 )
	if !self:GetNWBool("FirstTimeDeployed") and GetConVar("uh_sv_deploy"):GetBool() then
		self:SetNWBool("FirstTimeDeployed", true)
		
		local animtime = math.max(3, self.Owner:GetViewModel():SequenceDuration())
		
		self:SetNWFloat("DeployTime", CurTime() + animtime)
		if self.PreCock then
			timer.Simple(animtime - 1.5, function()
				if !IsValid(self) or !IsValid(self.Owner) or !IsValid(self.Owner:GetActiveWeapon()) or self.Owner:GetActiveWeapon() != self then return end
				self.Owner:EmitSound( self.Primary.PumpSound )
				self:SendWeaponAnim( ACT_SHOTGUN_PUMP )
			end)
		end
	end
	return false
end

function SWEP:Holster( wep )
	if !game.SinglePlayer() and !IsFirstTimePredicted() then return true end
	local vm = self.Owner:GetViewModel()
	if IsValid(vm) then
		if IsValid(wep) and string.find(wep:GetClass(), "weapon_uh_base") then
			vm:SetSkin(0)
			if CLIENT and GetConVar("uh_hands"):GetInt() == 0 then
				local handmat = getUHCacheMat( "models/weapons/v_models/hands/v_hands" )
				local v = cs_oldtex
				if v then
					local detail = v.detail
					handmat:SetTexture("$basetexture", v.tex)
					handmat:SetTexture("$detail", detail and !string.find(detail:GetName(), "error") and detail or Material("color"):GetTexture("$basetexture"))
					handmat:SetFloat("$detailblendfactor", v.blendfactor or 0)
					handmat:SetInt("$detailblendmode", v.blendmode or 0)
					handmat:SetFloat("$detailscale", v.scale or 1)
				end
			end
		end
		for bone_id = 0, vm:GetBoneCount() - 1 do
			if string.find(vm:GetBoneName(bone_id), "INVALIDBONE") then continue end
			vm:ManipulateBonePosition(bone_id, Vector(0,0,0))
			vm:ManipulateBoneAngles(bone_id, Angle(0,0,0))
			vm:ManipulateBoneScale(bone_id, Vector(1,1,1))
		end
	end
	self:SetUHBool("Reloading", false)
	self:SetUHBool("Zooming", false)
	self:SetUHBool("Running", false)
	self:SetNWFloat("ReloadTime", 0)
	self:SetNWFloat("ReloadEndTime", 0)
	if self:GetNWInt("FireMode") == 0 then self:SetNWInt("FireMode", 1) end
	if timer.Exists("UHReload_"..self.Owner:SteamID()) then
		timer.Remove( "UHReload_"..self.Owner:SteamID() )
	end
	self.NextReload = CurTime() + 0.5
	self.m_skin = nil
	self.b_reflashlight = nil
	if self.CustomHolster then
		self:CustomHolster( wep )
	end
	return true
end

if SERVER then return end

local v_bobang = Angle(0, 0, 0)
local v_zoom = 0

function SWEP:CalcView( ply, pos, ang, fov )
	if LocalPlayer():ShouldDrawLocalPlayer() then return end
	
	local ft,ct = FrameTime(),CurTime()
	local intensity = GetConVar("uh_viewbob"):GetFloat() or 1
	local p,y = 0,0
	
	if intensity > 0 and self.Owner:OnGround() then
		local vel = self.Owner:GetVelocity()
		local dist = Vector(vel.x, vel.y, 0):LengthSqr()
		local speed = math.Clamp(dist/(self.Owner:GetRunSpeed()^2), 0, 1)
		
		p = -math.sin(ct * 16.8) * intensity * speed
		y = math.sin(ct * 8.4) * intensity * speed
	end
	
	v_bobang = LerpAngle(ft * 8, v_bobang, Angle(p, y, 0))
	v_zoom = Lerp(ft * 5, v_zoom, self:GetUHBool("Zooming") and self.ZoomFov or 0)
	
	return pos, ang + v_bobang, fov - v_zoom
end

local blurmat = Material("pp/blurscreen")
local c_blur = 0

function SWEP:PreDrawViewModel()
	if !GetConVar("uh_blur"):GetBool() then return end
	if self.ScopeBlur and self:GetUHBool("Zooming") or self:GetUHBool("Reloading") or self:GetNWFloat("DeployTime") > CurTime() then
		c_blur = math.Approach( c_blur or 0, 1, FrameTime()*1.25 )
	else
		c_blur = math.Approach( c_blur or 0, 0, FrameTime() )
	end
	
	if c_blur > 0 then
		cam.Start2D()
			surface.SetDrawColor(255,255,255)
			surface.SetMaterial(blurmat)
			
			local b = GetConVar("uh_blur_amount"):GetInt()
			local w,h = ScrW(),ScrH()
			
			for i = 1, b do
				blurmat:SetFloat("$blur", i * c_blur)
				blurmat:Recompute()
				
				render.UpdateScreenEffectTexture()
				
				surface.DrawTexturedRect(0, 0, w, h)
			end
		cam.End2D()
	end
end

function SWEP:HUDShouldDraw( name )
	if GetConVar("uh_hud"):GetBool() and ( name == "CHudAmmo" or name == "CHudSecondaryAmmo" ) then return false end
	return true
end

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
	-- Borders
	y = y + 10
	x = x + 10
	wide = wide - 20
	tall = tall - 20
	
	if self.WorldModel and self.WorldModel != "" then
		if !IsValid(UHWeaponInfo) then
			UHWeaponInfo = ClientsideModel( self.WorldModel, RENDER_GROUP_OPAQUE_ENTITY );
			UHWeaponInfo:SetNoDraw( true );
		else
			UHWeaponInfo:SetModel( self.WorldModel )
			
			local vec = Vector(48,48,48)
			local ang = Vector(-48,-48,-48):Angle()
			
			cam.Start3D( vec, ang, 20, x, y+35, wide, tall, 5, 4096 )
				cam.IgnoreZ( true )
				render.SuppressEngineLighting( true )
				
				render.SetLightingOrigin( self:GetPos() )
				render.ResetModelLighting( 50/255, 50/255, 50/255 )
				render.SetColorModulation( 1, 1, 1 )
				render.SetBlend( alpha/255 )
				
				render.SetModelLighting( 4, 1, 1, 1 )
				
				UHWeaponInfo:SetRenderAngles( Angle( 0, RealTime() * 30 % 360, 0 ) )
				UHWeaponInfo:DrawModel()
				UHWeaponInfo:SetRenderAngles()
				
				render.SetColorModulation( 1, 1, 1 )
				render.SetBlend( 1 )
				render.SuppressEngineLighting( false )
				cam.IgnoreZ( false )
			cam.End3D()
		end
	else
		surface.SetDrawColor( 255, 255, 255, alpha )
		surface.SetTexture( self.WepSelectIcon )

		surface.DrawTexturedRect( x, y,	wide, tall )
	end
	
	if self.Primary.ClipSize > 0 then
		if self:Clip1()/self.Primary.ClipSize > 0.25 then
			draw.SimpleText(self:Clip1().."/"..self.Owner:GetAmmoCount(self.Primary.Ammo), "HudSelectionText", x + wide/2, y + tall - 14, Color(255,230,0,alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
		else
			draw.SimpleText(self:Clip1().."/"..self.Owner:GetAmmoCount(self.Primary.Ammo), "HudSelectionText", x + wide/2, y + tall - 14, Color(255,0,0,alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
		end
	end
end