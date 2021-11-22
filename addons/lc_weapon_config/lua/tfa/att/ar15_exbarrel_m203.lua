
if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "M203"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "E+Click to select grenade launcher", "20% less vertical recoil", TFA.AttachmentColors["-"], "10% lower base accuracy", "5% lower scoped accuracy", "Marginally slower movespeed" }
ATTACHMENT.Icon = "entities/ins2_att_m203.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "GL"

ATTACHMENT.Ent = "tfa_exp_contact"
ATTACHMENT.Damage = 250
ATTACHMENT.DefaultModel = "models/weapons/tfa_ins2/upgrades/a_projectile_gp25.mdl"
ATTACHMENT.Velocity = 76.5 * 39.370 * 4 / 3 --76.5 M/s * Meters to Inches * Inches to Hammer Units
ATTACHMENT.Ammo = "smg1_grenade"
ATTACHMENT.Automatic = false
ATTACHMENT.ClipSize = 1
ATTACHMENT.DefaultClip = 5
ATTACHMENT.Delay = 0.3
ATTACHMENT.Sound = Sound("weapons/ar2/ar2_altfire.wav")

local defaultbl = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }

local function LerpBoneMods( t, b1, b2 )
	local tbl = table.Copy(b1)
	for k,v in pairs(b2) do
		if not tbl[k] then
			tbl[k] = table.Copy(defaultbl)
		end
		tbl[k].scale = LerpVector( t, tbl[k].scale, v.scale )
		tbl[k].pos = LerpVector( t, tbl[k].pos, v.pos )
		tbl[k].angle = LerpAngle( t, tbl[k].angle, v.angle )
	end
	return tbl	
end

ATTACHMENT.RecoilV = -5
ATTACHMENT.RecoilH = -2.5

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["M203"] = {
			["active"] = true
		},
		["M203 2"] = {
			["active"] = true
		},		
			},
	["Primary"] = {
		["GLSound"] = function(wep,stat)
			return stat or wep:GetStat("Secondary.Sound") or wep:GetStat("Primary.Sound")
		end,
		["KickUp"] = function(wep,stat) return stat * 0.8 end,
		["KickDown"] = function(wep,stat) return stat * 0.8 end,
		["Spread"] = function(wep,stat) return stat * 1.1 end,
		["IronAccuracy"] = function(wep,stat) return stat * 1.05 end
	},
	["Secondary"] = {
		["ClipSize"] = ATTACHMENT.ClipSize,
		["Ammo"] = ATTACHMENT.Ammo
	},
	["IronSightsPos"] = function(wep,val)
		if wep:GLDeployed() then
			return wep.IronSightsPos_M203, true, true
		else
			return val, false, true
		end
	end,
	["IronSightsAng"] = function(wep,val)
		if wep:GLDeployed() then
			return wep.IronSightsAng_M203, true, true
		else
			return val, false, true
		end
	end,
	["MoveSpeed"] = function(wep,stat) return stat * 0.975 end,
	["IronSightsMoveSpeed"] = function(wep,stat) return stat * 0.975 end,
	["Animations"] = {
		--[[
		["reload_silenced"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			["value"] = "reload_dm_quick"
		},
		]]--
		["reload"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			["value"] = "reload_dm_tac"
		},
		["reload_empty"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			["value"] = "reload_dm_empty"
		},
		["reload_quick"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			["value"] = "reload_dm_quick"
		},
		["reload_quick_empty"] = {
			["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
			["value"] = "reload_dm_quick_empty"
		}
	},		
	["ViewModelBoneMods"] = function(wep,tbl)
		if wep.M203BoneMods then
			wep.GripFactor = wep.GripFactor or 0
			local CanGrip = true
			if wep.GripBadActivities and wep.GripBadActivities[ wep:GetLastActivity() ] and wep:VMIV() then
				local cyc = wep.OwnerViewModel:GetCycle()
				if cyc > wep.GripBadActivities[ wep:GetLastActivity() ][1] and cyc < wep.GripBadActivities[ wep:GetLastActivity() ][2] then
					CanGrip = false
				end
			end
			wep.GripFactor = math.Approach( wep.GripFactor, CanGrip and 1 or 0, ( ( CanGrip and 1 or 0 ) - wep.GripFactor ) * TFA.FrameTime() * ( wep.GripLerpSpeed or 20 ) )
			return LerpBoneMods( wep.GripFactor, tbl, wep.M203BoneMods )
		end
end			
}

local function SetVel( ent, vel )
	ent:SetVelocity( vel )
	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetVelocity( vel )
	end
end

function ATTACHMENT:Attach( wep )
	wep.SetNW2Bool = wep.SetNW2Bool or wep.SetNWBool
	wep.GetNW2Bool = wep.GetNW2Bool or wep.GetNWBool

	if SERVER and not wep.HasBeenGivenGLAmmo then
		wep:SetClip2( math.Clamp( self.DefaultClip,0,1 ) )
		wep.Owner:GiveAmmo( math.max( self.DefaultClip - 1, 0 ), self.Ammo )
		wep.HasBeenGivenGLAmmo = 1
	end

	wep:SetNW2Bool("GLDeployed",false)

	function wep:GLDeployed()
		return wep:GetNW2Bool("GLDeployed")
	end

	wep.PrimaryAttackOld_GL = wep.PrimaryAttackOld_GL or wep.PrimaryAttack
	wep.PrimaryAttack = function( myself, ... )
		if myself.Owner:KeyPressed( IN_ATTACK ) and myself.Owner:KeyDown( IN_USE ) and TFA.Enum.ReadyStatus[ myself:GetStatus() ] and not myself:GetSprinting() then
			myself:SetNW2Bool("GLDeployed", not myself:GetNW2Bool("GLDeployed") )
		elseif myself.Owner:KeyDown( IN_USE ) then
			return
		elseif myself:GLDeployed() then
			if ( myself.Owner:KeyPressed( IN_ATTACK ) or self.Automatic ) then
				myself:SecondaryAttack( myself, true )
			end
		else
			wep.PrimaryAttackOld_GL( myself, ... )
		end
	end

	wep.Reload_GLOld = wep.Reload_GLOld or wep.Reload
	wep.Reload = function( myself, ... )
		if myself:GLDeployed() then
			return wep.Reload2( myself, ... )
		else
			return wep.Reload_GLOld( myself, ... )
		end
	end

	wep.CompleteReload_GLOld = wep.CompleteReload_GLOld or wep.CompleteReload

	wep.CompleteReload = function( myself, ... )
		if myself:GLDeployed() then
			local maxclip = self.ClipSize
			local curclip = myself:Clip2()
			local amounttoreplace = math.min(maxclip - curclip, myself:Ammo2())
			myself:TakeSecondaryAmmo(amounttoreplace * -1)
			myself:TakeSecondaryAmmo(amounttoreplace, true)
		else
			return wep.CompleteReload_GLOld( myself, ... )
		end
	end	
	
	wep.SecondaryAttack_GLOld = wep.SecondaryAttack_GLOld or wep.SecondaryAttack

	wep.SecondaryAttack = function( myself, gogogo, ... )
		if myself:GLDeployed() then
			if not gogogo then return end
			if CurTime() >  myself:GetNextPrimaryFire() and TFA.Enum.ReadyStatus[ myself:GetStatus() ] and not myself:GetSprinting() then
				myself.LuaShellEject_Old = myself.LuaShellEject
				myself.LuaShellEject = false
				local c1 = myself:Clip1()
				myself:SetClip1( myself:Clip2() )
				myself:ChooseShootAnim( )
				myself:SetClip1( c1 )
				if myself:Clip2() > 0 then
					if SERVER then
						local ent = ents.Create( self.Ent )
						ent:SetOwner( myself.Owner )
						ent:SetPos( myself.Owner:GetShootPos() )
						ent:SetAngles( myself.Owner:EyeAngles() )
						ent:SetModel( myself:GetStat("Primary.ProjectileModel") or self.DefaultModel )
						ent:Spawn()
						ent:Activate()
						ent.Damage = self.Damage
						SetVel( ent, myself.Owner:GetAimVector() * self.Velocity )
					end
					myself:SetNextPrimaryFire( CurTime()  + self.Delay )
					myself:SetClip2( math.max( myself:Clip2() - 1, 0 ) )
					if IsFirstTimePredicted() then
						myself:EmitSound( myself:GetStat("Primary.GLSound") )
					end
					myself.Owner:ViewPunch( Angle( self.RecoilV, self.RecoilH, self.RecoilH / 2 ) )
				end
				myself.LuaShellEject = myself.LuaShellEject_Old
			end
		else
			return wep.SecondaryAttack_GLOld( myself, gogogo, ... )
		end
	end

	if TFA.Enum.ReadyStatus[wep:GetStatus()] then
		wep:ChooseIdleAnim()
		if game.SinglePlayer() then
			wep:CallOnClient("ChooseIdleAnim","")
		end
	end
end

function ATTACHMENT:Detach( wep )

	wep:SetNW2Bool("GLDeployed",false)
	wep.PrimaryAttack = wep.PrimaryAttackOld_GL or wep.PrimaryAttack
	wep.Reload = wep.Reload_GLOld or wep.Reload
	wep.CompleteReload = wep.CompleteReload_GLOld or wep.CompleteReload
	wep.SecondaryAttack = wep.SecondaryAttack_GLOld or wep.SecondaryAttack

	wep.PrimaryAttackOld_GL = nil
	wep.Reload_GLOld = nil
	wep.CompleteReload_GLOld = nil
	wep.SecondaryAttack_GLOld = nil

	if TFA.Enum.ReadyStatus[wep:GetStatus()] then
		wep:ChooseIdleAnim()
		if game.SinglePlayer() then
			wep:CallOnClient("ChooseIdleAnim","")
		end
	end
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
