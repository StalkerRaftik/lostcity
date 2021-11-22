TFA.RUSTALPHA = TFA.RUSTALPHA or {}

if SERVER then
	util.AddNetworkString("tfaRustHitmarker")

	local penetration_hitmarker_cvar = GetConVar("sv_tfa_penetration_hitmarker")
	function TFA.SendRustHitMarker(self, ply, traceres, dmginfo)
		if not penetration_hitmarker_cvar:GetBool() then return end
		if not IsValid(ply) or not ply:IsPlayer() then return end

		-- local shots = dmginfo:GetInflictor():GetStat("Primary.NumShots")
		-- if shots and shots > 1 then
			net.Start("tfaRustHitmarker")
			net.WriteVector(traceres.HitPos)
			net.Send(ply)
		-- end
	end

	return
end

local markers = {}

local enabledcvar, solidtimecvar, fadetimecvar
local c = Color(255, 255, 255, 255)
local spr = Material("vgui/tfa_rustalpha/hitnotification.png", "smooth")

net.Receive("tfaRustHitmarker", function()
	local marker = {}
	marker.pos = net.ReadVector()
	marker.time = CurTime()

	table.insert(markers, marker)
end)

hook.Add("HUDPaint", "tfaDrawRustHitmarker", function()
	if not enabledcvar then
		enabledcvar = GetConVar("cl_tfa_hud_hitmarker_enabled")
	end

	if enabledcvar and enabledcvar:GetBool() then
		if not solidtimecvar then
			solidtimecvar = GetConVar("cl_tfa_hud_hitmarker_solidtime")
		end

		if not fadetimecvar then
			fadetimecvar = GetConVar("cl_tfa_hud_hitmarker_fadetime")
		end

		local solidtime = solidtimecvar:GetFloat()
		local fadetime = math.max(fadetimecvar:GetFloat(), 0.001)

		local sprh = ScrH() * 0.05

		for k, v in pairs(markers) do
			if not v.pos or not v.time then
				markers[k] = nil
				continue
			end

			local alpha = math.Clamp(v.time - CurTime() + solidtime + fadetime, 0, fadetime) / fadetime
			c.a = alpha * 191

			if alpha > 0 then
				local pos = v.pos:ToScreen()

				if pos.visible then
					surface.SetDrawColor(c)
					surface.SetMaterial(spr)
					surface.DrawTexturedRect(pos.x - sprh * .5, pos.y - sprh * .5, sprh, sprh)
				end
			else
				markers[k] = nil
			end
		end
	end
end)