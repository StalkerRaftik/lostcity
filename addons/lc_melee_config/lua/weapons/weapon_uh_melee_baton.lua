AddCSLuaFile()

SWEP.PrintName 				= "Полицейская дубинка [Edged Weapons]"
SWEP.Author 				= ""
SWEP.Contact 				= ""
SWEP.Purpose 				= ""
SWEP.Instructions 			= ""
SWEP.Category 				= "LostCity Edged Weapons"
SWEP.UseHands 				= true
SWEP.Base					= "weapon_uh_base_melee"

SWEP.Spawnable				= true
SWEP.AdminSpawnable			= false

SWEP.ViewModelFOV 			= 64
SWEP.ViewModel				= "models/weapons/v_baton_pg.mdl"
SWEP.WorldModel				= "models/weapons/w_baton_pg.mdl"

SWEP.AutoSwitchTo			= true		 
SWEP.AutoSwitchFrom			= true

SWEP.Slot 					= 0
SWEP.SlotPos 				= 0

SWEP.HoldType 				= "melee"
SWEP.FiresUnderwater 		= false
SWEP.Weight 				= 45
SWEP.DrawCrosshair 			= false
SWEP.DrawAmmo 				= false
SWEP.ViewModelFlip			= false
		 						 			  
SWEP.Primary.SwingSound		= Sound( "weapons/uh_baton/baton_swing.wav" )
SWEP.Primary.HitSound		= Sound( "weapons/uh_baton/baton_hitbod"..math.random(1,2)..".wav" )
SWEP.Primary.HitWorldSound	= Sound( "weapons/uh_baton/baton_hitworld"..math.random(1,2)..".wav" )
SWEP.Primary.MinDamage		= 15
SWEP.Primary.MaxDamage		= 19
SWEP.Primary.Force			= 800
SWEP.Primary.HurtTime		= 0.2
SWEP.Primary.Delay			= 0.5
SWEP.Primary.Recoil			= Angle(-3,-3,0)
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= ""
SWEP.Primary.Anim			= ACT_VM_MISSCENTER
SWEP.Primary.DamageType		= DMG_CLUB

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= ""