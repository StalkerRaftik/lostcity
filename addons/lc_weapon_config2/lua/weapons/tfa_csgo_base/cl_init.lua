include("shared.lua")

local cv_dropmags = GetConVar("cl_tfa_csgo_magdrop") or CreateClientConVar("cl_tfa_csgo_magdrop", "1", true, true, "Drop magazine on weapon reload?")

function SWEP:DropMag()
	if not cv_dropmags or not cv_dropmags:GetBool() then return end

	if not self.MagModel then return end

	local mag = ents.CreateClientProp()

	mag:SetModel(self.MagModel)
	mag:SetMaterial(self:GetMaterial())
	for i = 1, #self:GetMaterials() do
		mag:SetSubMaterial(i - 1, self:GetSubMaterial(i - 1))
	end -- full skin support

	local pos, ang = self:GetPos(), self:GetAngles()

	if self:IsFirstPerson() and self:VMIV() then
		local vm = self.OwnerViewModel
		ang = vm:GetAngles()
		pos = vm:GetPos() - ang:Up() * 8
	end

	mag:SetPos(pos)
	mag:SetAngles(ang)

	mag:PhysicsInit(SOLID_VPHYSICS)
	mag:PhysWake()

	mag:SetMoveType(MOVETYPE_VPHYSICS) -- we call it AFTER physics init

	mag:Spawn()

	SafeRemoveEntityDelayed(mag, 30) -- 30s delay, maybe we should make this changeable with a cvar
end