AddCSLuaFile()

ENT.Base = "tfa_rustalpha_ammo_editable"

ENT.Type = "anim"
ENT.Category = "TFA Rust Legacy"
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.PrintName = "Flare"

ENT.AmmoTypeSpawn = "yurie_rustalpha_flare"
ENT.AmmoCountSpawn = 4
ENT.AmmoCountMax = 10

DEFINE_BASECLASS(ENT.Base)

function ENT:GiveAmmo(ent)
	local retval = BaseClass.GiveAmmo(self, ent)

	if retval and not ent:HasWeapon("tfa_rustalpha_flare") then
		ent:Give("tfa_rustalpha_flare", true)
	end

	return retval
end
