local rigmdl = "models/weapons/tfa_ins2/c_ins2_pmhands.mdl"
local handsent

local function tryParentHands(hands, vm, ply, wep) -- hey look no more drawmodel
	if not IsValid(vm) or not IsValid(wep) or not wep:IsTFA() then return end

	if not IsValid(handsent) then
		handsent = ClientsideModel(rigmdl)
	end

	if not IsValid(hands) then return end -- Hi Gmod Can Hands ????

	if wep.UseHands and vm:LookupBone("R ForeTwist") and not vm:LookupBone("ValveBiped.Bip01_R_Hand") then -- assuming we are ins2 only skeleton
		handsent:SetParent(vm)
		handsent:SetPos(vm:GetPos())
		handsent:SetAngles(vm:GetAngles())
		handsent:AddEffects(EF_BONEMERGE)
		handsent:AddEffects(EF_BONEMERGE_FASTCULL)
		handsent:InvalidateBoneCache()

		hands:SetParent(handsent)
		hands:AddEffects(EF_BONEMERGE)
		hands:AddEffects(EF_BONEMERGE_FASTCULL)
	end
end

hook.Add("PreDrawPlayerHands", "TFA_INS2_HandsWhatTheFuck", tryParentHands)