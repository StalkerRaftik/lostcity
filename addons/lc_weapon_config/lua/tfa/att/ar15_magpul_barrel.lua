if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Magpul цевье"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "4% меньше вертикальная отдача", "2% меньше горизонтальная отдача"}
ATTACHMENT.Icon = "entities/ar15_att_moe_b.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "MOEB"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["basebarrel"] = {
			["active"] = false
		},
		["magpulbarrel"] = {
			["active"] = true
		}
	},
	["Bodygroups_W"] = {
		[2] = 2
	},
	["Primary"] = {
		["KickUp"] = function(wep,stat) return stat * 0.96 end,
		["KickDown"] = function(wep,stat) return stat * 0.98 end,
		["KickHorizontal"] = function(wep,stat) return stat * 0.98 end,
	},
}

function ATTACHMENT:Attach( wep )
	if TFA.Enum.ReadyStatus[wep:GetStatus()] then
		wep:ChooseIdleAnim()
		if game.SinglePlayer() then
			wep:CallOnClient("ChooseIdleAnim","")
		end
	end
end

function ATTACHMENT:Detach( wep )
	if TFA.Enum.ReadyStatus[wep:GetStatus()] then
		wep:ChooseIdleAnim()
		if game.SinglePlayer() then
			wep:CallOnClient("ChooseIdleAnim","")
		end
	end
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end