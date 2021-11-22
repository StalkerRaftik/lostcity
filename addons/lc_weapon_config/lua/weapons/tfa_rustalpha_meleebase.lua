SWEP.Base = "tfa_melee_base"

SWEP.SoundMats = {
	[MAT_DEFAULT]		= Sound("YURIE_RUSTALPHA.Melee.ImpactGeneric"),
	[MAT_WOOD]			= Sound("YURIE_RUSTALPHA.Melee.ImpactWood"),
	[MAT_ALIENFLESH]	= Sound("YURIE_RUSTALPHA.Melee.ImpactFlesh"),
	[MAT_BLOODYFLESH]	= Sound("YURIE_RUSTALPHA.Melee.ImpactFlesh"),
	[MAT_FLESH]			= Sound("YURIE_RUSTALPHA.Melee.ImpactFlesh"),
}

DEFINE_BASECLASS(SWEP.Base)

SWEP.SecondaryAttack = function(self) end
SWEP.AltAttack = false

if SERVER and TFA.SendRustHitMarker then
	SWEP.SendHitMarker = TFA.SendRustHitMarker
end

function SWEP:SmackEffect(trace, dmg)
	if self:GetStat("SwingHitAnimation") then
		self:PlaySwing(self:GetStat("SwingHitAnimation"))
	end

	local atk = dmg:GetAttacker()
	local hitent = trace.Entity

	if IsValid(atk) and atk:IsPlayer() and IsValid(hitent) and (hitent:IsPlayer() or hitent:IsNPC() or type(hitent) == "NextBot") then
		self:SendHitMarker(atk, trace, dmg)
	end

	self:EmitSoundNet(self.SoundMats[trace.MatType] or "YURIE_RUSTALPHA.Melee.ImpactGeneric")

	return BaseClass.SmackEffect(self, trace, dmg)
end