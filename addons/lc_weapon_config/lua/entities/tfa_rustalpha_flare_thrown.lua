AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Flare"
ENT.Author = "YuRaNnNzZZ"

ENT.DisableDuplicator = true
ENT.DoNotDuplicate = true

local cv_flaredeath = CreateConVar("sv_tfa_rustalpha_flare_lifetime", 60, {FCVAR_ARCHIVE}, "How long thrown flare will stay before despawning")

-- ENT.DeathTime = 60

ENT.LoopSound = Sound("YURIE_RUSTALPHA.Flare.Loop")

function ENT:Initialize()
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	self:DrawShadow(true)

	local efdata = EffectData()
	efdata:SetEntity(self)
	efdata:SetOrigin(self:GetPos())
	efdata:SetAttachment(self:LookupAttachment("fire") or 1)

	TFA.Effects.Create("yurie_rustalpha_flareglow", efdata)

	if SERVER then
		SafeRemoveEntityDelayed(self, self.DeathTime or cv_flaredeath:GetInt())
	end

	self:EmitSound(self.LoopSound)
end

function ENT:Draw()
	self:DrawModel()
end

if CLIENT then
	function ENT:Think()
		self.DLight = self.DLight or DynamicLight(self:EntIndex(), false)

		if self.DLight then
			self.DLight.pos = self:GetPos()
			self.DLight.r = 255
			self.DLight.g = 0
			self.DLight.b = 0
			self.DLight.decay = 1000
			self.DLight.brightness = 2
			self.DLight.size = math.Rand(240, 272)
			self.DLight.dietime = CurTime() + 1
		end
	end
end

function ENT:OnRemove()
	if self.DLight then
		self.DLight.dietime = -1
	end

	self:StopSound(self.LoopSound)
end

ENT.BounceSound = Sound("YURIE_RUSTALPHA.F1.Bounce")

function ENT:PhysicsCollide(data, phys)
	if data.Speed > 60 then
		self:EmitSound(self.BounceSound)
	end
end