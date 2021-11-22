local BaseClass = baseclass.Get('mhs_weapon_base')


SWEP.PrintName 					= 'Маскировка'
SWEP.Slot 						= 1
SWEP.SlotPos 					= 1
SWEP.DrawAmmo 					= false
SWEP.DrawCrosshair 				= false

SWEP.Author 					= ''
SWEP.Instructions				= 'ПКМ - Открыть маскировку.'
SWEP.Contact 					= ''
SWEP.Purpose 					= ''

SWEP.ViewModel 					= 'models/weapons/v_hands.mdl'
SWEP.WorldModel					= ''

SWEP.ViewModelFOV 				= 62
SWEP.ViewModelFlip 				= false

SWEP.Spawnable 					= false
SWEP.Category 					= 'RP'
SWEP.Primary.ClipSize 			= -1
SWEP.Primary.DefaultClip 		= 0
SWEP.Primary.Automatic 			= false
SWEP.Primary.Ammo 				= ''

SWEP.Secondary.ClipSize 		= -1
SWEP.Secondary.DefaultClip 		= 0
SWEP.Secondary.Automatic 		= false
SWEP.Secondary.Ammo 			= ''

SWEP.CheckTime = 1.2
SWEP.AllowedClass = "player"
SWEP.SoundDelay = 0.5
SWEP.ModelDraw = false
SWEP.lastUsed = 0

SWEP.ViewModel = "models/weapons/c_bugbait.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"

function SWEP:SecondaryAttack()
	return
end

net.Receive('DisguiseToServer', function(len, pl)
	local ent = net.ReadEntity()
	local t = net.ReadInt(8)

	if ent ~= pl.ValidDisguiseEnt then
		return --You've been naughty
	end

	if (pl:Team() == TEAM_ADMIN) then
		return
	end
	
	if IsValid(ent) then
		ent:Remove()
		pl:Disguise(t)
		pl.ValidDisguiseEnt = nil
	end
end)


function SWEP:Deploy()
	self:SetHoldType("normal")
	self:SendWeaponAnim(ACT_VM_DRAW)
end

function SWEP:OnRemove()
	BaseClass.Holster(self)	
end

function SWEP:Holster()
	self:OnRemove()
	return true
end

function SWEP:SecondaryAttack()
  if CLIENT or self.InProgress then return end
  self.Weapon:SetNextSecondaryFire(CurTime() + 0.5)

  net.Start("DisguiseMenu")
  net.Send(self.Owner)
end
