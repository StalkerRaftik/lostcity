if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "5.56x45 mm M995"
ATTACHMENT.ShortName = "" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { 
TFA.Attachments.Colors["="], " 5.56x45 mm M995 armour-piercing M995 cartridge. .",
TFA.Attachments.Colors["+"], "20% lower spread kick", "10% lower recoil", "5% range fall gain", "deals armor damage" ,
TFA.Attachments.Colors["-"], "10% less damage", "20% lower spread recovery" 
}
ATTACHMENT.Icon = "entities/M995ICON.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat * 0.90 end,
		["SpreadIncrement"] = function( wep, stat ) return stat * 0.9 end,
		["SpreadRecovery"] = function( wep, stat ) return stat * 0.8 end,
		["KickUp"] = function( wep, stat ) return stat * 0.9 end,
		["KickDown"] = function( wep, stat ) return stat * 0.9 end,
		["RangeFalloff"] = function( wep, stat ) return stat * 1.05 end
	}
}
 --[[
hook.Add("EntityTakeDamage", "non_penetrative_armor", function(entity, info)
    if not entity:IsPlayer() then return end
    local armor = entity:Armor()
    if armor <= 0 then return end
    local damage = info:GetDamage()
    if damage <= 0 then return end
    local armorRequired = math.min(damage, armor)
    
    entity:SetArmor(armor - armorRequired)
    info:SetDamage(damage - armorRequired)
end)
    --]]
if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
