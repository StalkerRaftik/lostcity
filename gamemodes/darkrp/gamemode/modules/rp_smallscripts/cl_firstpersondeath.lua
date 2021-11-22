hook.Add("CalcView", "FirstPersonDeath", function(pl, pos, ang, fov, nearz, farz)
	local rag = pl:GetNVar("PlayerRagdoll")
	if pl:Alive() or !IsValid(rag) then return end
	local eyeattach = rag:LookupAttachment('eyes')
	if (!eyeattach) then return end
	local eyes = rag:GetAttachment(eyeattach)
	if (!eyes) then return end
	return {origin = eyes.Pos, angles = eyes.Ang, fov = fov}
end)