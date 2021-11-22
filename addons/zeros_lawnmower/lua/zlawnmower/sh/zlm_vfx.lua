zlm = zlm or {}
zlm.f = zlm.f or {}

if SERVER then
	--Effects
	util.AddNetworkString("zlm_FX")

	function zlm.f.CreateEffectAtPos(effect, position)
		net.Start("zlm_FX")
		net.WriteString(effect)
		net.WriteVector(position)
		net.SendPVS(position)
	end
end

if CLIENT then
	-- Effects
	net.Receive("zlm_FX", function(len)
		local effect = net.ReadString()
		local pos = net.ReadVector()

		if effect and pos then
			ParticleEffect(effect, pos, Angle(0, 0, 0), NULL)
		end
	end)
end
