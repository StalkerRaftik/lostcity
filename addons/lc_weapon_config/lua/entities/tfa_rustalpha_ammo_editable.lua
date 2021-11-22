AddCSLuaFile()

ENT.Type = "anim"
ENT.Category = "TFA Rust Legacy"
ENT.Spawnable = false
ENT.AdminOnly = true
ENT.PrintName = "Base Editable Ammo Bag"

ENT.Editable = true

-- ENT.AmmoTypeSpawn = "Pistol" -- https://wiki.garrysmod.com/page/Default_Ammo_Types
-- ENT.AmmoCountSpawn = 18 -- Default ammo count that entity will spawn with
-- ENT.AmmoCountMax = 9999 -- Maximum ammo allowed in editor

ENT.Model = "models/weapons/yurie_rustalpha/genericitempickup.mdl"

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "AmmoType", {
		KeyName = "ammotype",
		Edit = {
			order = 1,
			title = "Ammo Type",
			AdminOnly = true,
			type = "Generic",
			waitforenter = true
		}
	})

	self:NetworkVar("Int", 0, "AmmoCount", {
		KeyName = "ammocount",
		Edit = {
			order = 2,
			title = "Ammo Count",
			AdminOnly = true,
			type = "Int",
			min = 1,
			max = self.AmmoCountMax or 9999
		}
	})

end

function ENT:Draw()
	self:DrawModel()
end

function ENT:Initialize()
	self:SetModel(self.Model)

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	self:UseTriggerBounds(true, 12)

	if SERVER then
		self:SetTrigger(true)

		if self.AmmoTypeSpawn then
			self:SetAmmoType(self.AmmoTypeSpawn)
		end

		if self.AmmoCountSpawn then
			self:SetAmmoCount(self.AmmoCountSpawn)
		end
	end

	self:PhysWake()
end

local game_GetAmmoID = game.GetAmmoID
local game_GetAmmoMax = game.GetAmmoMax

function ENT:GiveAmmo(ent)
	if not IsValid(ent) or not ent:IsPlayer() then return false end

	if self:GetAmmoCount() <= 0 then return end
	if self:GetAmmoType() == "" or game_GetAmmoID(self:GetAmmoType()) == -1 then return false end

	if ent:GetAmmoCount(self:GetAmmoType()) >= game_GetAmmoMax(game_GetAmmoID(self:GetAmmoType())) then return false end

	ent:GiveAmmo(self:GetAmmoCount(), self:GetAmmoType())

	return true
end

function ENT:StartTouch(ent)
	if not IsValid(ent) or not ent:IsPlayer() then return end

	if hook.Run("PlayerCanPickupItem", ent, self) == false then return end

	if self:GiveAmmo(ent) then
		SafeRemoveEntity(self)
	end
end