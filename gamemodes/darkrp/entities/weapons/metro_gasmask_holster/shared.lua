SWEP.Base				= "metro2033_swep_base"


SWEP.Category				= "Metro Gasmask"
SWEP.Author				= "Hobo_Gus"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.PrintName				= "GASMASK HOLSTER"
SWEP.Slot				= 99
SWEP.SlotPos				= 23
SWEP.DrawAmmo				= false
SWEP.DrawWeaponInfoBox			= false
SWEP.BounceWeaponIcon   		= 	false
SWEP.DrawCrosshair			= false
SWEP.AutoSwitchTo			= true
SWEP.AutoSwitchFrom			= true
SWEP.HoldType 				= "normal"

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/metroll/v_gasmask.mdl"
SWEP.WorldModel				= ""
SWEP.ShowWorldModel			= false
SWEP.ShowViewModel = false

SWEP.Spawnable				= false
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false

SWEP.PrimarySound			= Sound("vsv/shoot-1.wav")

SWEP.Primary.Damage = 30
SWEP.Primary.TakeAmmo = -1
SWEP.Primary.ClipSize = 0
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Spread = 1
SWEP.Primary.Cone = 0.4
SWEP.IronCone = .2
SWEP.DefaultCone = 0.4
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Recoil = 1.5
SWEP.Primary.Delay = 0.10
SWEP.Primary.Force = 3

SWEP.IronSights = true
SWEP.Sprint = true

SWEP.DisableMuzzle = 1

SWEP.Tracer = 6
SWEP.CustomTracerName = "Tracer"
SWEP.ShotEffect = "muzzle_riflev2"

--SWEP.SightsPos = Vector(2.7, -4.624, 1.759)
--SWEP.SightsAng = Vector(0, 0, 0)
SWEP.IronSightsPos = Vector(2.7, -4.624, 1.759)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.RunPos = Vector(-1.841, -3.386, 0.708)
SWEP.RunAng = Vector(-7.441, -41.614, 0)
SWEP.HolsterT = false
SWEP.ViewModelBoneMods = {

}

function SWEP:Deploy()
	self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
	self.Owner:EmitSound("gasmask/gasmask_holster_fast.wav")
	self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() )
	self:SetHoldType( self.HoldType )
	self.Primary.Cone = self.DefaultCone
	self.Weapon:SetNWInt("Reloading", CurTime() + self:SequenceDuration() )
	self.Weapon:SetNWString( "AniamtionName", "none" )
	self.Weapon:SetNWString( "PreventNearWall", false )
	--self.Owner:SetNWInt( "breathholdtime_hg", self.BreathHoldingTime )
	self.Owner:ViewPunch( Angle( -5,0,0 ) )
	local ply = self.Owner

	if SERVER then
		self.Owner:SetCanZoom( true )
		self.HolsterT = false
	end

	timer.Simple(0.2, function()
		if self.Weapon == nil then return end
			if SERVER then
				self.Owner:SetNWBool("MetroGasmask", false)
				net.Start( "ClearMask" )
					net.WriteEntity( ply )
				net.Send(self.Owner)




			end
	end)
	timer.Simple(self:SequenceDuration()*0.5, function()
		if self.Weapon == nil then return end
		self:SendWeaponAnim( ACT_VM_HOLSTER )
		timer.Simple(self:SequenceDuration(), function()
			if SERVER then
				self.HolsterT = true
				if self.Owner:GetNWString("gasmask_lastwepon") != nil and self.Owner:HasWeapon(self.Owner:GetNWString("gasmask_lastwepon")) then
					self.Owner:SelectWeapon( self.Owner:GetNWString("gasmask_lastwepon") )
					self.Owner:StripWeapon( "metro_gasmask_holster" )
local type = INV_HATS
		 		local class = "m10"

			 	if ply.ProgressBar then
					DarkRP.notify(ply, 1, 4, "Вы не можете сделать это сейчас!")
					return false
				end

					if type == INV_HATS then
						local data = Cosmetics.Items[class]
						if ply.Cosmetics[data.slot] and ply.Cosmetics[data.slot] == class then
							if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC] == "smershvest" and (ply:GetSpace() > (ply:GetDefaultSpace() - 2)) then DarkRP.notify(ply, 1, 6, "Ваш рюкзак переполнен, вы не можете его снять") return false end
							if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC] == "ukvest" and (ply:GetSpace() > (ply:GetDefaultSpace() - 2)) then DarkRP.notify(ply, 1, 6, "Ваш рюкзак переполнен, вы не можете его снять") return false end
							if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_baselardwild" and (ply:GetSpace() > (ply:GetDefaultSpace() - 5)) then DarkRP.notify(ply, 1, 6, "Ваш рюкзак переполнен, вы не можете его снять") return false end
							if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_blackjack" and (ply:GetSpace() > (ply:GetDefaultSpace() - 7)) then DarkRP.notify(ply, 1, 6, "Ваш рюкзак переполнен, вы не можете его снять") return false end
							if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_molle" and (ply:GetSpace() > (ply:GetDefaultSpace() - 2)) then DarkRP.notify(ply, 1, 6, "Ваш рюкзак переполнен, вы не можете его снять") return false end
							if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_pilgrim" and (ply:GetSpace() > (ply:GetDefaultSpace() - 6)) then DarkRP.notify(ply, 1, 6, "Ваш рюкзак переполнен, вы не можете его снять") return false end
							if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_trizip" and (ply:GetSpace() > (ply:GetDefaultSpace() - 3.5)) then DarkRP.notify(ply, 1, 6, "Ваш рюкзак переполнен, вы не можете его снять") return false end
							if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_pilgrim2a" and (ply:GetSpace() > (ply:GetDefaultSpace() - 6)) then DarkRP.notify(ply, 1, 6, "Ваш рюкзак переполнен, вы не можете его снять") return false end
							if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_pilgrim2b" and (ply:GetSpace() > (ply:GetDefaultSpace() - 6)) then DarkRP.notify(ply, 1, 6, "Ваш рюкзак переполнен, вы не можете его снять") return false end
							if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_pilgrim2c" and (ply:GetSpace() > (ply:GetDefaultSpace() - 6)) then DarkRP.notify(ply, 1, 6, "Ваш рюкзак переполнен, вы не можете его снять") return false end
							if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_citya" and (ply:GetSpace() > (ply:GetDefaultSpace() - 3.2)) then DarkRP.notify(ply, 1, 6, "Ваш рюкзак переполнен, вы не можете его снять") return false end
							if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_cityb" and (ply:GetSpace() > (ply:GetDefaultSpace() - 3.2)) then DarkRP.notify(ply, 1, 6, "Ваш рюкзак переполнен, вы не можете его снять") return false end
							if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_cityc" and (ply:GetSpace() > (ply:GetDefaultSpace() - 3.2)) then DarkRP.notify(ply, 1, 6, "Ваш рюкзак переполнен, вы не можете его снять") return false end
							if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_city2a" and (ply:GetSpace() > (ply:GetDefaultSpace() - 3.2)) then DarkRP.notify(ply, 1, 6, "Ваш рюкзак переполнен, вы не можете его снять") return false end
							if ply.Cosmetics and ply.Cosmetics[COSM_SLOT_MISC2] == "backpack_city2b" and (ply:GetSpace() > (ply:GetDefaultSpace() - 3.2)) then DarkRP.notify(ply, 1, 6, "Ваш рюкзак переполнен, вы не можете его снять") return false end

							net.Start("DoAnimation")
							net.WriteEntity(ply)
							net.WriteFloat(2021)
							net.Broadcast()
							-- DarkRP.notify(ply, 0, 6, "Вы сняли с себя " .. data.name .. ".")

							ply:UnequipCosmetic(class)
							ply:AddItem(INV_HATS, class)
						else
							DarkRP.notify(ply, 1, 6, "На вас не надета эта вещь (" .. class .. ").")
						end
			 		end

				hook.Call( "PlayerUnequipInventory", nil, type, class )
				hook.Run( "PlayerUnequipInventory", ply, type, class )					
				end
			end
		end)
	end)

	timer.Remove( "MMFX"..ply:SteamID() )

	return true
end

function SWEP:Holster()
return self.HolsterT
end

function SWEP:PrimaryAttack()
end