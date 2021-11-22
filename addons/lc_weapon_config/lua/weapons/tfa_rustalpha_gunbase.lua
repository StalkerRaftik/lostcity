SWEP.Base = "tfa_gun_base"

SWEP.ViewModelCullDistance = 10

DEFINE_BASECLASS(SWEP.Base)

if SERVER and TFA.SendRustHitMarker then
	SWEP.SendHitMarker = TFA.SendRustHitMarker
end

if CLIENT then
	SWEP.OldClipping = false

	function SWEP:PreDrawViewModel(vm, wep, ply)
		if BaseClass.PreDrawViewModel then
			BaseClass.PreDrawViewModel(self, vm, wep, ply)
		end

		self.OldClipping = render.EnableClipping(true)

		local normal = vm:GetForward()
		local dist = normal:Dot(vm:GetPos()) + self.IronSightsProgress * self:GetStat("ViewModelCullDistance", 10)

		render.PushCustomClipPlane(normal, dist)
	end

	function SWEP:PostDrawViewModel(vm, wep, ply)
		if BaseClass.PostDrawViewModel then
			BaseClass.PostDrawViewModel(self, vm, wep, ply)
		end

		render.PopCustomClipPlane()
		render.EnableClipping(self.OldClipping)
	end
end