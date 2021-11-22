function EFFECT:Init(data)
	self.data = data

	self.TargetEntity = data:GetEntity()
	self.Attachment = data:GetAttachment()

	self.TargetEntityOG = self.TargetEntity

	if IsValid(self.TargetEntityOG.GlowFXCSEnt) then
		self.TargetEntityOG.GlowFXCSEnt.REMOVEME = true
		-- self.TargetEntityOG.GlowFXCSEnt:Remove()
	end

	self.TargetEntityOG.GlowFXCSEnt = self
end

function EFFECT:Think()
	if self.REMOVEME or not IsValid(self.TargetEntityOG) then
		return false
	end

	if self.TargetEntityOG:IsWeapon() and self.TargetEntityOG.IsTFAWeapon then
		local wep = self.TargetEntityOG

		if IsValid(wep:GetOwner()) and wep:GetOwner():IsPlayer() then
			self.TargetEntity = wep:IsFirstPerson() and wep.OwnerViewModel or wep
		end
	end

	local angpos = self.TargetEntity:GetAttachment(self.Attachment or 1)

	if angpos and angpos.Pos then
		self:SetPos(angpos.Pos)
	else
		self:SetPos(self.TargetEntity:GetPos()) -- constantly updating pos to make sure :Render is called
	end

	return true
end

local vec_down = Vector(0, 0, -1)
local render_delay = 1 / 30

function EFFECT:Render()
	if self.NextRenderTime and self.NextRenderTime > CurTime() then return end

	self.NextRenderTime = CurTime() + render_delay

	local angpos = self.TargetEntity:GetAttachment(self.Attachment or 1)

	if not angpos or not angpos.Ang or not angpos.Pos then return end

	local vOffset = angpos.Pos
	local vAngle = angpos.Ang

	local emitter = ParticleEmitter(vOffset, false)

	local flareSprite = emitter:Add("effects/yurie_rustalpha/colorflare", vOffset)

	if self.OldFlareSprite then
		self.OldFlareSprite:SetDieTime(-1)
	end

	self.OldFlareSprite = flareSprite

	if flareSprite then
		flareSprite:SetRoll(math.Rand(0, 360))
		flareSprite:SetRollDelta(math.Rand(1, 4))
		flareSprite:SetStartSize(10)
		flareSprite:SetEndSize(10)
		flareSprite:SetDieTime(.1)
	end

	for i = 0, math.random(2, 4) do
		local particle = emitter:Add("effects/spark", vOffset)

		if particle then
			particle:SetColor(255, 191, 191)

			particle:SetDieTime(.5)

			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)

			particle:SetStartSize(1)
			particle:SetEndSize(0)

			particle:SetRoll(math.Rand(0, 360))
			particle:SetRollDelta( math.Rand(-200, 200))

			particle:SetAirResistance(0)

			particle:SetVelocity(vAngle:Forward() * 50 + vAngle:Right() * math.Rand(-15, 15) + vAngle:Up() * math.Rand(-15, 15))
			particle:SetGravity(vAngle:Forward() * -50 + vec_down * 100)
		end
	end

	local smokeSprite = emitter:Add("particle/particle_noisesphere", vOffset)

	if smokeSprite then
		smokeSprite:SetDieTime(.8)
		smokeSprite:SetStartAlpha(127)
		smokeSprite:SetEndAlpha(0)
		smokeSprite:SetStartSize(2)
		smokeSprite:SetEndSize(4)

		smokeSprite:SetVelocity(Vector(math.Rand(-5, 5), math.Rand(-5, 5), 10))

		smokeSprite:SetColor(127, 127, 127)
	end

	emitter:Finish()
end