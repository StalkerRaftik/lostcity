AddCSLuaFile()

SWEP.PrintName 				= "Underhell Gun Base"
SWEP.Author 				= ""
SWEP.Contact 				= ""
SWEP.Purpose 				= ""
SWEP.Instructions 			= ""
SWEP.Category 				= "LostCity Edged Weapons"
SWEP.UseHands 				= false
SWEP.Base                   = "weapon_uh_base"

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
SWEP.FiresUnderwater 		= false
SWEP.Weight 				= 45
SWEP.DrawCrosshair 			= false
SWEP.DrawAmmo 				= false
SWEP.DrawWeaponInfoBox 		= false
SWEP.SmokeWidth				= 30
SWEP.Chambering				= true

SWEP.NoShell				= false
SWEP.ShellHeat				= 0.8
SWEP.Shell					= "models/weapons/shell_9mm.mdl"

SWEP.FireModes				= {}

SWEP.Primary.Sound          = Sound("weapons/mp5/mp5_fire.wav")
SWEP.Primary.SilSound		= Sound("weapons/mp5/mp5_fire.wav")
SWEP.Primary.ClipSize 		= 30
SWEP.Primary.Ammo 			= "UH_SMG"
SWEP.Primary.DefaultClip 	= 30
SWEP.Primary.MinDamage      = 12
SWEP.Primary.MaxDamage      = 18
SWEP.Primary.Automatic 		= true
SWEP.Primary.TakeAmmo		= 1
SWEP.Primary.Force 			= 15
SWEP.Primary.Spread 		= 0.45
SWEP.Primary.Delay 			= 0.08
SWEP.Primary.NumberofShots 	= 1
SWEP.Primary.MinRecoil 		= -0.6
SWEP.Primary.MaxRecoil		= -1.4

SWEP.Secondary.ClipSize 	= -1 
SWEP.Secondary.Ammo 		= "none" 
SWEP.Secondary.DefaultClip 	= -1     
SWEP.Secondary.Automatic 	= false

SWEP.SwayScale 	= 0
SWEP.BobScale 	= 0

SWEP.ReloadTable = {}

SWEP.IronSightsPos = Vector(-3.701, -6.79, 0.419)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.Inspection = {
	{
		pos = Vector(8, -8, 0),
		ang = Angle(40, 40, 40)
	},
	{
		pos = Vector(-4, -8, -8),
		ang = Angle(20, 40, -60)
	},
}

SWEP.SwayPosition = 2


function SWEP:Initialize()
	util.PrecacheSound(self.Primary.Sound)
	util.PrecacheModel(self.ViewModel)
	util.PrecacheModel(self.WorldModel)
	self:SetWeaponHoldType( self.HoldType )
	self:SetHoldType( self.HoldType )
	self.NextReload = CurTime()
	self:SetNWInt("FireMode", 1)
	
	if CLIENT and self.ScopeTexture then
		local scale = ScrH()/1080
		local quality = {
			256,
			512,
			768,
			1080
		}
		
		local num = math.Clamp(GetConVar("uh_rt_quality"):GetInt(), 1, 4)
		self.RT_Size = quality[num] * scale
		
		self.RenderTarget = GetRenderTarget("UH_SniperScopeRT_"..num, self.RT_Size, self.RT_Size, false)
	end
end

function SWEP:Think()
	local ct = CurTime()
	
	if self:GetUHBool("Zooming") then
		if !self.Owner:OnGround() or self.Owner:GetNWBool("UH_Flare") or self.Owner:GetNWBool("UH_Flashlight") or self.Owner:GetNWFloat("UH_GrenadeTime") > ct then
			self:SetUHBool("Zooming", false)
		end
	end
	
	self:HandleRunning( ct )
	
	if self.Shotgun and self.ReloadShotgun then
		self:ReloadShotgun( ct )
	end
	
	local vm = self.Owner:GetViewModel()
	if IsValid(vm) then
		self:HandleBones( vm, ct )
		self:HandleHands( vm )
	end
	
	if self.CustomThink then
		self:CustomThink( ct )
	end
end

function SWEP:PrimaryAttack()
	if !self:CanPrimaryAttack() then return end
	
	local sp = game.SinglePlayer()
	local iftp = IsFirstTimePredicted()
	
	if SERVER or iftp then
		local mode = self.FireModes[self:GetNWInt("FireMode")]
		if mode and mode.shoot then
			local res = mode.shoot(self.Owner, self)
			if res then return end
		end
		
		if self:GetNWBool("Silenced") then
			self:ShootBullets(self.Owner:GetShootPos(), self.Owner:GetAimVector(), math.Round(math.random(self.Primary.MinDamage,self.Primary.MaxDamage)*0.95), self.Penetration or 2)
		else
			self:ShootBullets(self.Owner:GetShootPos(), self.Owner:GetAimVector(), math.random(self.Primary.MinDamage,self.Primary.MaxDamage), self.Penetration or 2)
		end
	end
	
	local recoil = util.SharedRandom("uh_recoil", self.Primary.MinRecoil, self.Primary.MaxRecoil) * (self:GetUHBool("Zooming") and 0.35 or 1)
	
	if sp or (CLIENT and iftp) then
		if !self:GetNWBool("Silenced") then
			local fx = EffectData()
			fx:SetEntity(self)
			fx:SetOrigin(self.Owner:GetShootPos())
			fx:SetNormal(self.Owner:GetAimVector())
			fx:SetAttachment(self:GetMuzzle())
			util.Effect("uh_muzzle",fx)
		end
		
		self:CreateSmoke( self:GetMuzzle(), self.Primary.Delay + (self.Primary.Automatic and 0.14 or 0.32) )
		
		if !self.NoShell then
			self:CreateShell( self.ShellDelay or 0, self.ShellHeat )
		end
		
		self.Owner:SetEyeAngles( self.Owner:EyeAngles() + Angle( recoil, 0, 0 ) )
	end
	
	self.Owner:ViewPunch( Angle( recoil, 0, 0 ) )
	
	self:SendWeaponAnim( ACT_VM_IDLE )
	self:SendWeaponAnim( self:ShootAnimation() )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self.Owner:MuzzleFlash()
	self:EmitSound( self:GetNWBool("Silenced") and self.Primary.SilSound or self.Primary.Sound, 110, 100, 1, CHAN_WEAPON )
	self:TakePrimaryAmmo(self.Primary.TakeAmmo)
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay ) 
	self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
	
	self.NextReload = CurTime() + 0.5
	
	self:PostShoot()
end

function SWEP:ShootBullets(pos, buldir, dmg, tries)
	if tries <= 0 then return end
	
	local movement = Vector(self.Owner:GetVelocity().x, self.Owner:GetVelocity().y, 0):LengthSqr()
	local movepercent = math.Clamp(movement/self.Owner:GetRunSpeed()^2, 0, 1)
	local move = movepercent*0.1
	
	if self.Owner:OnGround() then
		if self:GetUHBool("Zooming") and self.Owner:Crouching() then
			spread = self.Primary.Spread * 0.18
		elseif self:GetUHBool("Zooming") then
			spread = self.Primary.Spread * 0.26
		elseif self.Owner:Crouching() then
			spread = self.Primary.Spread * 0.34
		else
			spread = self.Primary.Spread * 0.5
		end
	else
		spread = self.Primary.Spread * 0.62
	end
	
	spread = spread + move
	
	local bullet = {}
	bullet.Num = self.Primary.NumberofShots
	bullet.Src = pos
	bullet.Dir = buldir
	bullet.Spread = Vector( spread, spread, 0)
	bullet.Tracer = 1
	bullet.TracerName = "uh_tracer"
	bullet.Force = self.Primary.Force
	bullet.Damage = dmg
	bullet.AmmoType = self.Primary.Ammo
	bullet.Callback = function(attacker, bultrace, dmginfo)
		local mat = bultrace.MatType
		
		if SERVER then
			util.ScreenShake(bultrace.HitPos, 5, 0.1, 0.5, 64)
		end
		
		if bultrace.Hit then
			local dir = bultrace.HitNormal
			
			local tr = {}
			tr.start = bultrace.HitPos - dir*(self.PenetrationDepth or 4)
			tr.endpos = bultrace.HitPos
			tr.filter = self.Owner
			tr.mask = MASK_SHOT
			
			local trace = util.TraceLine(tr)
			
			if !trace.AllSolid and trace.Fraction > 0 and GetConVar("uh_sv_penetration"):GetBool() then
				self:ShootBullets(trace.HitPos, buldir, math.Round(dmg*math.Rand(0.5, 0.6)), tries - 1)
			end
			
			if mat == MAT_METAL or mat == MAT_VENT or mat == MAT_GRATE then
				local fx = EffectData()
				fx:SetOrigin(bultrace.HitPos)
				fx:SetScale(1)
				util.Effect("uh_hitworld",fx)
			end
		end
	end
	
	self.Owner:FireBullets( bullet )
end

function SWEP:ShootGrenade(force)
	if SERVER then
		local ent = ents.Create( "sent_mgl_grenade" )
		ent:SetPos( self.Owner:EyePos() + self.Owner:GetAimVector() * 30 + self.Owner:GetUp() * -10 + (self:GetUHBool("Zooming") and Vector(0,0,0) or self.Owner:GetRight() * 5) )
		ent:SetAngles( self.Owner:GetAngles() )
		ent:Spawn()
		ent:Activate()
		ent.Owner = self.Owner
		local phys = ent:GetPhysicsObject()
		if phys != nil and (phys:IsValid()) then
			phys:ApplyForceCenter(self.Owner:GetAimVector() * force)
		end
	end
end

function SWEP:PostShoot()
end

-- Configurable functions
function SWEP:ShootAnimation()
	return ACT_VM_PRIMARYATTACK
end

function SWEP:GrenadeAnimation()
	return ACT_VM_PRIMARYATTACK
end

function SWEP:GetShellDirection()
	return Angle(30,-90,0)
end


-- Viewmodel functions
function SWEP:GetMuzzle()
	return 1
end

function SWEP:GetDisplay()
	return 1
end

function SWEP:GetShellEject()
	return 2
end

function SWEP:CreateSmoke( att, delay )
	if (delay or 0) > 0 then
		timer.Simple(delay, function()
			if !IsValid(self) or !IsValid(self.Owner) then return end
			local fx = EffectData()
			fx:SetEntity(self)
			fx:SetOrigin(self.Owner:GetShootPos())
			fx:SetRadius(self.SmokeWidth or 20)
			fx:SetAttachment(att)
			util.Effect("uh_smoke",fx)
		end)
	else
		local fx = EffectData()
		fx:SetEntity(self)
		fx:SetOrigin(self.Owner:GetShootPos())
		fx:SetRadius(self.SmokeWidth or 20)
		fx:SetAttachment(att)
		util.Effect("uh_smoke",fx)
	end
end

function SWEP:CreateShell( delay, heat )
	if (delay or 0) > 0 then
		timer.Create("UH_Shell_"..self.Owner:SteamID(), delay, 1, function()
			if !IsValid( self ) or !IsValid(self.Owner) or self.Owner:GetActiveWeapon() != self then return end
			local fx = EffectData()
			fx:SetEntity(self)
			fx:SetOrigin(self.Owner:EyePos())
			fx:SetAttachment(self:GetShellEject())
			fx:SetNormal(self.Owner:GetAimVector())
			fx:SetScale(heat or 1)
			util.Effect("uh_shell", fx)
			
			timer.Simple(0.5, function()
				if !IsValid(self) then return end
				if self.Shotgun then
					self:EmitSound("weapons/underhell/shells/shotgun_shell"..math.random(1,3)..".wav", 65, 100, 0.75, CHAN_USER_BASE)
				else
					self:EmitSound("player/pl_shell"..math.random(1,3)..".wav", 65, 100, 0.75, CHAN_USER_BASE)
				end
			end)
		end)
	else
		local fx = EffectData()
		fx:SetEntity(self)
		fx:SetOrigin(self.Owner:EyePos())
		fx:SetAttachment(self:GetShellEject())
		fx:SetNormal(self.Owner:GetAimVector())
		fx:SetScale(heat or 1)
		util.Effect("uh_shell", fx)
		
		timer.Simple(0.5, function()
			if !IsValid(self) then return end
			if self.Shotgun then
				self:EmitSound("weapons/underhell/shells/shotgun_shell"..math.random(1,3)..".wav", 65, 100, 0.75, CHAN_USER_BASE)
			else
				self:EmitSound("player/pl_shell"..math.random(1,3)..".wav", 65, 100, 0.75, CHAN_USER_BASE)
			end
		end)
	end
end

function SWEP:CanPrimaryAttack()
	if self:GetNWInt("FireMode") == 0 or self:GetNWFloat("DeployTime") > CurTime() or self:GetUHBool("Running") or self:GetUHBool("Reloading") then return false end
	if self:Clip1() <= 0 then
		if !self:GetUHBool("Reloading") then
			self:EmitSound( "Weapon_SMG1.Empty", 75, 100, 1, CHAN_USER_BASE )
		end
		self:SetNextPrimaryFire( CurTime() + 0.4 )
		return false
	end
	return true
end

function SWEP:SecondaryAttack()
	local ct,sp = CurTime(),game.SinglePlayer()
	if self:GetUHBool("Reloading") or self:GetNWFloat("DeployTime") > ct then return end
	if SERVER or IsFirstTimePredicted() then
		if self.Owner:KeyDown( IN_USE ) then
			local mode = self:GetNWInt("FireMode") + 1
			if mode > #self.FireModes then
				mode = 0
			end
			
			local old = self.FireModes[self:GetNWInt("FireMode")]
			if old and old.holster then
				old.holster(self.Owner, self)
				if sp and SERVER then
					net.Start("UH_Select_Fire")
						net.WriteFloat(self:GetNWInt("FireMode"))
						net.WriteBool(false)
					net.Broadcast()
				end
			elseif self:GetNWInt("FireMode") == 0 then
				self:SendWeaponAnim( ACT_VM_LOWERED_TO_IDLE )
			end
			
			local new = self.FireModes[mode]
			if new and new.equip then
				new.equip(self.Owner, self)
				if sp and SERVER then
					net.Start("UH_Select_Fire")
						net.WriteFloat(mode)
						net.WriteBool(true)
					net.Broadcast()
				end
			elseif mode == 0 then
				self:SetUHBool("Running", false)
				self:SetUHBool("Zooming", false)
				self:SendWeaponAnim( ACT_VM_IDLE_TO_LOWERED )
			end
			
			self:SetNextPrimaryFire( ct + 0.5 )
			self:SetNextSecondaryFire( ct + 0.2 )
			
			self:SetNWInt("FireMode", mode)
			if sp and SERVER or CLIENT then
				self.Owner:EmitSound("uh/flashlight.wav", 64, 100, 1, CHAN_USER_BASE)
			end
		elseif self.Owner:OnGround() and self:GetNWInt("FireMode") != 0 and !self.Owner:GetNWBool("UH_Flashlight") and !self.Owner:GetNWBool("UH_Flare") and !self:GetUHBool("Running") then
			local mode = !self:GetUHBool("Zooming")
			self:SetUHBool("Zooming", mode)
			if sp and SERVER or CLIENT then
				if mode then
					self.Owner:EmitSound("weapons/underhell/ironsight_off.wav", 64, 100, 1, CHAN_USER_BASE)
				else
					self.Owner:EmitSound("weapons/underhell/ironsight_on.wav", 65, 100, 1, CHAN_USER_BASE)
				end
			end
			self:SetNextPrimaryFire( ct + 0.1 )
			self:SetNextSecondaryFire( ct + 0.2 )
		end
	end
end

function SWEP:Reload()
	local ct = CurTime()
	
	if self.NextReload < ct and !self:GetUHBool("Running") and !self:GetUHBool("Reloading") and self.Owner:GetNWFloat("GrenadeTime") < ct and self:GetNWFloat("DeployTime") < ct then
		if self:Clip1() < ( self.Chambering and self.Primary.ClipSize + 1 or self.Primary.ClipSize ) and self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 then
			self.Owner:SetAnimation(PLAYER_RELOAD)
			if self:GetNWInt("FireMode") == 0 then self:SetNWInt("FireMode", 1) end
			
			self:PreReload()
			
			if SERVER then
				if self.Owner:GetNWBool("UH_Flashlight") then
					self.Owner:SetNWBool("UH_Flashlight", false)
					self.Owner:SetNWBool("UH_ArmGone", false)
					if !self.IsBolt and !self.IsPump and !self.TwoHanded then
						self.Owner:SetNWFloat("UH_ArmTime", ct + 0.25)
					end
					self.Owner:EmitSound("uh/flashlight.wav")
					
					self.b_reflashlight = true
					
					net.Start("UH_Flashlight")
						net.WriteEntity(self.Owner)
						net.WriteBool(false)
					net.Broadcast()
				elseif self.Owner:GetNWBool("UH_Flare") then
					UHThrowFlare( self.Owner )
					
					self.Owner:SetNWBool("UH_ArmGone", false)
					if !self.IsBolt and !self.IsPump and !self.TwoHanded then
						self.Owner:SetNWFloat("UH_ArmTime", ct + 0.25)
					end
				else
					self.b_reflashlight = nil
				end
			end
			
			self:SendWeaponAnim( ACT_VM_IDLE )
			
			if self.ReloadAnim then
				if type(self.ReloadAnim) == "string" then
					local vm = self.Owner:GetViewModel()
					vm:SendViewModelMatchingSequence(vm:LookupSequence(self.ReloadAnim))
				else
					self:SendWeaponAnim(self.ReloadAnim)
				end
			else
				self:SendWeaponAnim(ACT_VM_RELOAD) -- Now I know why Spy made a custom viewmodel. It's impossible to predict reloading without a custom viewmodel
			end
			
			local AnimTime = self.Owner:GetViewModel():SequenceDuration()
			self.NextReload = ct + AnimTime + 0.5
			self:SetNextPrimaryFire( ct + AnimTime )
			self:SetUHBool("Reloading", true)
			self:SetUHBool("Zooming", false)
			self:SetNWFloat("ReloadTime", AnimTime)
			self:SetNWFloat("ReloadEndTime", ct + AnimTime)
			timer.Create("UHReload_"..self.Owner:SteamID(), AnimTime, 1, function()
				if !IsValid(self) or !self:GetUHBool("Reloading") or !IsValid(self.Owner) or self.Owner:GetActiveWeapon() != self then return end
				
				self:PostReload()
				
				self:SetUHBool("Reloading", false)
				self:SetNWFloat("ReloadTime", 0)
				self:SetNWFloat("ReloadEndTime", 0)
				
				if SERVER then
					if self.Chambering and self:Clip1() > 0 then
						local clip = math.min(self.Owner:GetAmmoCount(self.Primary.Ammo) + self:Clip1(), self.Primary.ClipSize + 1)
						self.Owner:RemoveAmmo(self.Primary.ClipSize + 1 - self:Clip1(), self.Primary.Ammo)
						self:SetClip1( clip )
					else
						local clip = math.min(self.Owner:GetAmmoCount(self.Primary.Ammo) + self:Clip1(), self.Primary.ClipSize)
						self.Owner:RemoveAmmo(self.Primary.ClipSize - self:Clip1(), self.Primary.Ammo)
						self:SetClip1( clip )
					end
					
					if self.b_reflashlight then
						self.b_reflashlight = nil
						self.Owner:SetNWBool("UH_Flashlight", true)
						self.Owner:SetNWBool("UH_ArmGone", true)
						
						net.Start("UH_Flashlight")
							net.WriteEntity(self.Owner)
							net.WriteBool(true)
						net.Broadcast()
					end
				end
			end)
			
			local sp = game.SinglePlayer()
			local iftp = IsFirstTimePredicted()
			
			if (sp and SERVER) or (!sp and CLIENT and iftp) then
				for num,tbl in pairs(self.ReloadTable) do
					if !tbl or !tbl.delay then return end
					timer.Simple(tbl.delay, function()
						if !IsValid(self) or !self:GetUHBool("Reloading") or !IsValid(self.Owner) or self.Owner:GetActiveWeapon() != self then return end
						self.Owner:EmitSound( tbl.sound, 75, 100, 1, CHAN_USER_BASE )
					end)
				end
			end
		end
	end
end

function SWEP:PreReload()
end

function SWEP:PostReload()
end

hook.Add("EntityEmitSound", "UHReloadOverride", function(data)
	local ent = data.Entity
	if !IsValid(ent) then return end
	local wep = ent.GetActiveWeapon and ent:GetActiveWeapon()
	if !IsValid(wep) then return end
	
	--[[if string.find(data.SoundName, "weapon") then
		print(data.SoundName)
	end]]
	
	if wep.SoundChanger and wep.SoundChanger[data.SoundName] != nil then
		if wep.SoundChanger[data.SoundName] == false then
			return false
		else
			data.SoundName = wep.SoundChanger[data.SoundName]
			return true
		end
	end
end)

if SERVER then return end

local devzoom = Material("vgui/scope_lens")

hook.Add("RenderScene", "UHSniperRenderScene", function(origin, angles, fov)
	local wep = LocalPlayer():GetActiveWeapon()
	if IsValid(wep) and string.find(wep.Base or "", "weapon_uh_base") and wep.ScopeTexture then
		if wep:GetUHBool("Zooming") and !wep.ScopeDisabled then
			local size = wep.RT_Size or 512
			render.PushRenderTarget(wep.RenderTarget, 0, 0, size, size)
			
			local ang = LocalPlayer():EyeAngles()
			local pos = LocalPlayer():EyePos()
			
			render.RenderView({
				x = 0,
				y = 0,
				w = size,
				h = size,
				origin = pos,
				angles = ang,
				drawviewmodel = false,
				drawhud = false,
				dopostprocess = false,
				fov = wep.ScopeFov or 8
			})
			
			render.PopRenderTarget()
			
			wep.ScopeTexture:SetTexture("$basetexture", wep.RenderTarget)
		else
			wep.ScopeTexture:SetTexture("$basetexture", devzoom:GetTexture("$basetexture"))
		end
	end
end)

hook.Add("AdjustMouseSensitivity", "UHScopeSensitivity", function()
	local ply = LocalPlayer()
	local wep = ply:GetActiveWeapon()
	if IsValid(wep) and string.find(wep.Base or "", "weapon_uh_base") and wep.ScopeTexture and wep:GetUHBool("Zooming") then
		return wep.Sensitivity
	end
end)

local h_reload = 0
local h_crosshair = 0
local h_use = 0

function SWEP:DrawHUD()
	if !GetConVar("cl_drawhud"):GetBool() or self:GetNWFloat("DeployTime") > CurTime() then return end
	
	local col = Color(GetConVar("uh_hud_r"):GetInt(), GetConVar("uh_hud_g"):GetInt(), GetConVar("uh_hud_b"):GetInt())
	local pos = {x = ScrW()/2, y = ScrH()/2}
	local movement = LocalPlayer():GetVelocity():Length()/10
	local drawply = LocalPlayer():ShouldDrawLocalPlayer()
	if movement > 80 then movement = 80 end
	
	h_reload = math.Approach(h_reload or 0, self:GetUHBool("Reloading") and 1 or 0, FrameTime()*3)
	h_crosshair = math.Approach(h_crosshair or 0, (self:GetNWInt("FireMode") == 0 or self:GetUHBool("Running") or self:GetUHBool("Reloading") or self:GetUHBool("Zooming")) and 0 or 1, FrameTime()*5)
	
	if drawply then
		pos = self.Owner:GetEyeTrace().HitPos:ToScreen()
	end
	
	if (h_crosshair > 0 or drawply) and GetConVar("uh_crosshair"):GetBool() then
		draw.RoundedBox(0, pos.x - 25 - movement, pos.y - 2, 12, 3, Color(0,0,0,200*h_crosshair)) --Left
		draw.RoundedBox(0, pos.x + 12 + movement, pos.y - 2, 12, 3, Color(0,0,0,200*h_crosshair)) --Right
		draw.RoundedBox(0, pos.x - 2, pos.y - 25 - movement, 3, 12, Color(0,0,0,200*h_crosshair)) --Top
		draw.RoundedBox(0, pos.x - 2, pos.y + 12 + movement, 3, 12, Color(0,0,0,200*h_crosshair)) --Bottom
		
		draw.RoundedBox(0, pos.x - 24 - movement, pos.y - 1, 12, 1, Color(255,255,255,255*h_crosshair)) --Left
		draw.RoundedBox(0, pos.x + 11 + movement, pos.y - 1, 12, 1, Color(255,255,255,255*h_crosshair)) --Right
		draw.RoundedBox(0, pos.x - 1, pos.y - 24 - movement, 1, 12, Color(255,255,255,255*h_crosshair)) --Top
		draw.RoundedBox(0, pos.x - 1, pos.y + 11 + movement, 1, 12, Color(255,255,255,255*h_crosshair)) --Bottom
	end
	
	if !GetConVar("uh_hud"):GetBool() then return end
	
	if drawply then
		local att = self:GetAttachment( self:GetDisplay() )
		if att then
			pos = att.Pos:ToScreen()
		end
	else
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			local att = vm:GetAttachment( self:GetDisplay() )
			if att then
				pos = att.Pos:ToScreen()
			end
		end
	end
	
	local clip = self:Clip1()
	local ammotype = self.Primary.Ammo
	local ammocount = self.Owner:GetAmmoCount(ammotype)
	
	local cliptext = "Magazine "..(self.Chambering and clip > self.Primary.ClipSize and (clip-1).." + 1" or clip)
	local ammotext = "Reserved "..ammocount
	local typetext = language.GetPhrase(ammotype.."_ammo")
	
	surface.SetFont("UH_AmmoLarge")
	local textsize = surface.GetTextSize(cliptext)
	
	local x = pos.x - textsize
	local y = pos.y
	local pr = math.Clamp(clip / self.Primary.ClipSize, 0, 1)
	
	draw.SimpleText(cliptext, "UH_AmmoLarge", x - 4, y + 1, Color(0,0,0), TEXT_ALIGN_LEFT)
	draw.SimpleText(cliptext, "UH_AmmoLarge", x - 5, y, Color(255*(1-pr) + col.r*pr,col.g*pr,col.b*pr), TEXT_ALIGN_LEFT)
	
	y = y + 24
	
	if self:GetNWFloat("ReloadEndTime") > CurTime() or h_reload > 0 then
		local p = math.Clamp(1-(self:GetNWFloat("ReloadEndTime")-CurTime())/self:GetNWFloat("ReloadTime"), 0, 1)
		
		draw.RoundedBox(0, x - 2, y + 1, 1, 14, Color(0,0,0,255*h_reload))
		draw.RoundedBox(0, x - 3, y, 1, 14, Color(col.r,col.g,col.b,255*h_reload))
		draw.RoundedBox(0, x - 5 + textsize, y + 1, 1, 14, Color(0,0,0,255*h_reload))
		draw.RoundedBox(0, x - 6 + textsize, y, 1, 14, Color(col.r,col.g,col.b,255*h_reload))
		
		draw.RoundedBox(0, x + 1, y + 3, textsize*p-8, 10, Color(0,0,0,255*h_reload))
		draw.RoundedBox(0, x, y + 2, textsize*p-8, 10, Color(255*(1-p) + col.r*p,col.g*p,col.b*p,255*h_reload))
	end
	
	y = y + h_reload*14 - 2
	
	if ammocount > 0 then
		draw.SimpleText(ammotext, "UH_AmmoSmall", x - 4, y + 1, Color(0,0,0), TEXT_ALIGN_LEFT)
		draw.SimpleText(ammotext, "UH_AmmoSmall", x - 5, y, Color(col.r,col.g,col.b), TEXT_ALIGN_LEFT)
		y = y + 15
	end
	
	draw.SimpleText(typetext, "UH_AmmoSmall", x - 4, y + 1, Color(0,0,0), TEXT_ALIGN_LEFT)
	draw.SimpleText(typetext, "UH_AmmoSmall", x - 5, y, Color(col.r,col.g,col.b), TEXT_ALIGN_LEFT)
	
	y = y + 15
	
	local mode = self:GetNWInt("FireMode")
	if mode == 0 or self.FireModes[mode] then
		local name = self.FireModes[mode] and self.FireModes[mode].name or "Safe"
		draw.SimpleText(name, "UH_AmmoSmall", x - 4, y + 1, Color(0,0,0), TEXT_ALIGN_LEFT)
		draw.SimpleText(name, "UH_AmmoSmall", x - 5, y, Color(col.r,col.g,col.b), TEXT_ALIGN_LEFT)
	end
	
	if GetConVar("uh_sv_grenades"):GetBool() then
		local grenades = self.Owner:GetAmmoCount("UH_Grenade")
		if grenades > 0 and h_reload < 1 then
			local p = 1-h_reload
			draw.SimpleText("Grenades", "UH_AmmoLarge", ScrW()/2 + 1, ScrH() * 0.8 + 1, Color(0,0,0,255*p), TEXT_ALIGN_CENTER)
			draw.SimpleText("Grenades", "UH_AmmoLarge", ScrW()/2, ScrH() * 0.8, Color(col.r,col.g,col.b,255*p), TEXT_ALIGN_CENTER)
			draw.SimpleText("x"..grenades, "UH_AmmoSmall", ScrW()/2 + 1, ScrH() * 0.8 + 23, Color(0,0,0,255*p), TEXT_ALIGN_CENTER)
			draw.SimpleText("x"..grenades, "UH_AmmoSmall", ScrW()/2, ScrH() * 0.8 + 22, Color(col.r,col.g,col.b,255*p), TEXT_ALIGN_CENTER)
		end
	end
end