util.AddNetworkString("rp.Jobs.OpenMenu")
util.AddNetworkString("SendMyJobSkinToServer")

net.Receive("SendMyJobSkinToServer", function(len, ply)
	local model = net.ReadString()	
	local job = net.ReadUInt(16)

	print(ply:CanUseThisModel(job, model))
	if ply:CanUseThisModel(job, model) then // Donate or not donate
		ply.skinID = model
		UpdateDonateSkinsDB(ply)
	end
	
end)