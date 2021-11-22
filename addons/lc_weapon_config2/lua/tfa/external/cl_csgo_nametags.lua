TFA.CSGO = TFA.CSGO or {}

surface.CreateFont("TFA_CSGO_Nametag", {
	font = "StratumNo2-Bold",
	size = 25,
	extended = true,
})
surface.CreateFont("TFA_CSGO_Nametag_Small", {
	font = "StratumNo2-Bold",
	size = 17.5,
	extended = true,
})
surface.CreateFont("TFA_CSGO_NamePicker", {
	font = "StratumNo2-Bold",
	size = ScreenScale( 6.5 ),
	extended = true,
})

function TFA.CSGO.ResetNameTags()
	LocalPlayer():SetPData("tfa_csgo_pdata", true)

	hook.Run("TFA_CSGO_ResetNameTags", LocalPlayer())
end

hook.Add( "InitPostEntity", "TFA_CSGO_NAMETAG", function()
	if LocalPlayer():GetPData("tfa_csgo_pdata") == nil then
		TFA.CSGO.ResetNameTags()
	end
end)

hook.Add("TFA_CSGO_ResetNameTags", "TFA_CSGO_NameTags_Default", function(ply)
	ply:SetPData( "tfa_csgo_ak47" .. "_name", "AK-47" )
	ply:SetPData( "tfa_csgo_aug" .. "_name", "AUG" )
	ply:SetPData( "tfa_csgo_awp" .. "_name", "AWP" )
	ply:SetPData( "tfa_csgo_bayonet" .. "_name", "Bayonet" )
	ply:SetPData( "tfa_csgo_bowie" .. "_name", "Bowie Knife" )
	ply:SetPData( "tfa_csgo_butfly" .. "_name", "Butterfly Knife" )
	ply:SetPData( "tfa_csgo_c4" .. "_name", "C4 Explosive" )
	ply:SetPData( "tfa_csgo_cz75" .. "_name", "CZ75-Auto" )
	ply:SetPData( "tfa_csgo_deagle" .. "_name", "Desert Eagle" )
	ply:SetPData( "tfa_csgo_elite" .. "_name", "Dual Berettas" )
	ply:SetPData( "tfa_csgo_falch" .. "_name", "Falchion Knife" )
	ply:SetPData( "tfa_csgo_famas" .. "_name", "FAMAS" )
	ply:SetPData( "tfa_csgo_fiveseven" .. "_name", "Five-SeveN" )
	ply:SetPData( "tfa_csgo_flip" .. "_name", "Flip Knife" )
	ply:SetPData( "tfa_csgo_g3sg1" .. "_name", "G3SG1" )
	ply:SetPData( "tfa_csgo_galil" .. "_name", "Galil AR" )
	ply:SetPData( "tfa_csgo_glock18" .. "_name", "Glock-18" )
	ply:SetPData( "tfa_csgo_gut" .. "_name", "Gut Knife" )
	ply:SetPData( "tfa_csgo_tackni" .. "_name", "Huntsman Knife" )
	ply:SetPData( "tfa_csgo_karam" .. "_name", "Karambit" )
	ply:SetPData( "tfa_csgo_ctknife" .. "_name", "CT Knife" )
	ply:SetPData( "tfa_csgo_knife_classic" .. "_name", "Knife" )
	ply:SetPData( "tfa_csgo_tknife" .. "_name", "T Knife" )
	ply:SetPData( "tfa_csgo_m249" .. "_name", "M249" )
	ply:SetPData( "tfa_csgo_m4a1" .. "_name", "M4A1-S" )
	ply:SetPData( "tfa_csgo_m4a4" .. "_name", "M4A4" )
	ply:SetPData( "tfa_csgo_m9" .. "_name", "M9 Bayonet" )
	ply:SetPData( "tfa_csgo_mac10" .. "_name", "MAC-10" )
	ply:SetPData( "tfa_csgo_mag7" .. "_name", "MAG-7" )
	ply:SetPData( "tfa_csgo_mp5" .. "_name", "MP5" )
	ply:SetPData( "tfa_csgo_mp7" .. "_name", "MP7" )
	ply:SetPData( "tfa_csgo_mp9" .. "_name", "MP9" )
	ply:SetPData( "tfa_csgo_negev" .. "_name", "Negev" )
	ply:SetPData( "tfa_csgo_nova" .. "_name", "Nova" )
	ply:SetPData( "tfa_csgo_p2000" .. "_name", "P2000" )
	ply:SetPData( "tfa_csgo_p250" .. "_name", "P250" )
	ply:SetPData( "tfa_csgo_p90" .. "_name", "P90" )
	ply:SetPData( "tfa_csgo_bizon" .. "_name", "PP Bizon" )
	ply:SetPData( "tfa_csgo_revolver" .. "_name", "R8 Revolver" )
	ply:SetPData( "tfa_csgo_sawedoff" .. "_name", "Sawed Off" )
	ply:SetPData( "tfa_csgo_scar20" .. "_name", "SCAR-20" )
	ply:SetPData( "tfa_csgo_sg556" .. "_name", "SG 553" )
	ply:SetPData( "tfa_csgo_pushkn" .. "_name", "Shadow Daggers" )
	ply:SetPData( "tfa_csgo_ssg08" .. "_name", "SSG 08" )
	ply:SetPData( "tfa_csgo_tec9" .. "_name", "Tec-9" )
	ply:SetPData( "tfa_csgo_ump45" .. "_name", "UMP-45" )
	ply:SetPData( "tfa_csgo_usp" .. "_name", "USP-S" )
	ply:SetPData( "tfa_csgo_xm1014" .. "_name", "XM1014" )
end)

hook.Add("TFA_CSGO_ResetNameTags", "TFA_CSGO_NameTags_Classified", function(ply)
	ply:SetPData( "tfa_csgo_galilar" .. "_name", "Galil AR" )
	ply:SetPData( "tfa_csgo_scar17" .. "_name", "SCAR-17" )
	ply:SetPData( "tfa_csgo_knife_classic" .. "_name", "Knife" )
end)