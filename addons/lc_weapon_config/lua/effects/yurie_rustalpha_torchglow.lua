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

local vec_up = Vector(0, 0, 1)
local render_delay = 1 / 30

function EFFECT:Render()
	if self.NextRenderTime and self.NextRenderTime > CurTime() then return end

	self.NextRenderTime = CurTime() + render_delay

	local angpos = self.TargetEntity:GetAttachment(self.Attachment or 1)

	if not angpos or not angpos.Ang or not angpos.Pos then return end

	local vOffset = angpos.Pos
	local vAngle = angpos.Ang

	local emitter = ParticleEmitter(vOffset, false)

	local flameBig = emitter:Add("effects/yurie_rustalpha/flame" .. math.Rand(1, 3), vOffset + vAngle:Forward() * math.Rand(-8, 8) + vAngle:Up() * math.Rand(-3, 3) + vAngle:Right() * math.Rand(-3, 3))

	if flameBig then
		flameBig:SetColor(255, math.random(127, 191), 0)

		flameBig:SetDieTime(.1)

		flameBig:SetStartAlpha(255)
		flameBig:SetEndAlpha(255)

		local size = math.Rand(2, 3)
		flameBig:SetStartSize(size)
		flameBig:SetEndSize(size)

		flameBig:SetRoll(math.Rand(0, 360))

		flameBig:SetAirResistance(0)

		flameBig:SetVelocity(vec_up * 25)
	end

	local flameSmall = emitter:Add("effects/yurie_rustalpha/flame" .. math.Rand(1, 3), vOffset + vAngle:Forward() * math.Rand(-5, 5) + vAngle:Up() * math.Rand(-2, 2) + vAngle:Right() * math.Rand(-2, 2))

	if flameSmall then
		flameSmall:SetColor(255, 191, 255)

		flameSmall:SetDieTime(.05)

		flameSmall:SetStartAlpha(255)
		flameSmall:SetEndAlpha(255)

		local size = math.Rand(.5, 1.5)
		flameSmall:SetStartSize(size)
		flameSmall:SetEndSize(size)

		flameSmall:SetRoll(math.Rand(0, 360))

		flameSmall:SetAirResistance(0)

		flameSmall:SetVelocity(vec_up * 15)
	end

	emitter:Finish()
end