AddCSLuaFile()

VManip:RegisterAnim("glowstick_deploy", --model sequence name of registered anim *must be unique* fix this yourself
{
["model"]="weapons/c_glowstick.mdl",
["lerp_peak"]=0.75,
["lerp_speed_in"]=0.65,
["lerp_speed_out"]=0.25,
["lerp_curve"]=1.25,
["speed"]=1,
["startcycle"]=0,
["loop"]=false,
["sounds"]={},
["segmented"]=true,
["preventquit"]=true,
["locktoply"]=false,
["cam_angint"]={0,0,0}
--["holdtime"]=nil
}
)

local glowsticking = false

local function GlowstickLightThink()
	local ply = LocalPlayer()
	if ply:Alive() and glowsticking then
		local dlight = DynamicLight( ply:EntIndex() )
		if ( dlight ) then
			dlight.pos = ply:GetShootPos()
			dlight.r = 0
			dlight.g = 255
			dlight.b = 230
			dlight.brightness = 2
			dlight.Decay = 1000
			dlight.Size = 256
			dlight.DieTime = CurTime() + 1
		end
	else
		hook.Remove("Think","GlowstickLight")
	end
end

local function GlowstickIdleSegment(name,cursegment,islast)
	if glowsticking then
		VManip:PlaySegment("idleout")
	else
		VManip:PlaySegment("glowstick_holster",true) --todo add forced segments to base
		hook.Remove("VManipSegmentFinish","GlowstickIdleAnim")
	end
end

local function ToggleGlowstick(ply)
	
	glowsticking = (VManip:GetCurrentAnim() == "glowstick_deploy")
	if glowsticking and VManip:GetSegmentCount()>1 and VManip:GetCurrentSegment() != "glowstick_holster" then
		VManip:SetCycle(1)
		glowsticking = false
	else
		if VManip:PlayAnim("glowstick_deploy") then
			glowsticking = true
			hook.Add("Think","GlowstickLight",GlowstickLightThink)
			hook.Add("VManipSegmentFinish","GlowstickIdleAnim",GlowstickIdleSegment)
		end
	end

end

concommand.Add("useglowstick",ToggleGlowstick)