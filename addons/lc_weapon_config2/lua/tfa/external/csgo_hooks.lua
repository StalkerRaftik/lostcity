csgo_flashtime = 5
csgo_flashfade = 2
csgo_flashdistance = 1280
csgo_flashdistancefade = 1280 - 512

local tab = {
	["$pp_colour_addr"] = 0,
	["$pp_colour_addg"] = 0,
	["$pp_colour_addb"] = 0,
	["$pp_colour_brightness"] = 0.0,
	["$pp_colour_contrast"] = 1.0,
	["$pp_colour_colour"] = 1.0,
	["$pp_colour_mulr"] = 0,
	["$pp_colour_mulg"] = 0,
	["$pp_colour_mulb"] = 0
}

hook.Add("RenderScreenspaceEffects", "TFA_CSGO_FLASHBANG", function()
	local ply = LocalPlayer()
	if not IsValid(ply) then return end
	local flashtime = ply:GetNWFloat("LastFlash", -999)
	local flashdistance = ply:GetNWFloat("FlashDistance", 0)
	local flashfac = ply:GetNWFloat("FlashFactor", 1)
	local distancefac = 1 - math.Clamp((flashdistance - csgo_flashdistance + csgo_flashdistancefade) / csgo_flashdistancefade, 0, 1)
	local intensity = 1 - math.Clamp(((CurTime() - flashtime) / distancefac - csgo_flashtime + csgo_flashfade) / csgo_flashfade, 0, 1)
	intensity = intensity * distancefac
	intensity = intensity * math.Clamp(flashfac + 0.1, 0.35, 1)

	if intensity > 0.01 then
		tab["$pp_colour_brightness"] = math.pow(intensity, 3)
		tab["$pp_colour_colour"] = 1 - intensity * 0.33
		DrawColorModify(tab) --Draws Color Modify effect
		DrawMotionBlur(0.2, intensity, 0.03)
	end
end)

if SERVER then
	util.AddNetworkString("TFA_CSGO_DropMag")
else
	net.Receive("TFA_CSGO_DropMag", function()
		local ent = net.ReadEntity()
		if IsValid(ent) and ent.DropMag then
			ent:DropMag()
		end
	end)
end