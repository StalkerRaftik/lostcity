PLAYER.SteamName = PLAYER.SteamName or PLAYER.Name

local HideNameUnderMask = {"gta_bandana01", "noface", "surgicalmask", "horse", "gasmask", "combine", "gta_owlmask01"}

function PLAYER:RPName(force)
	if not force then
		if CLIENT and LocalPlayer() ~= self and not self:IsBot() and self.Cosmetics and LocalPlayer().Cosmetics and table.HasValue(HideNameUnderMask, self.Cosmetics[COSM_SLOT_MASK]) then
			return "Человек в маске ["..self:UserID().."]"
		end
		if CLIENT and LocalPlayer() ~= self and not self:IsBot() then
			if self:GetNVar("FriendsList") ~= nil and istable(self:GetNVar("FriendsList")) and table.HasValue(self:GetNVar("FriendsList"), LocalPlayer():SteamID64()) or istable(LocalPlayer():GetNVar("FriendsList")) and table.HasValue(LocalPlayer():GetNVar("FriendsList"), self:SteamID64()) then
				return (self:GetNVar('Name') or self:SteamName()).." ["..self:UserID().."]"
			end
		end
		if CLIENT and LocalPlayer() == self then
			return (self:GetNVar('Name') or self:SteamName())
		end
		return "Незнакомец ["..self:UserID().."]"
	else
		return (self:GetNVar('Name') or self:SteamName()).." ["..self:UserID().."]"
	end
	return "Незнакомец ["..self:UserID().."]"
end

-- function PLAYER:Name(force)
-- 	if not force then
-- 		if CLIENT and LocalPlayer() ~= self and not self:IsBot() and self.Cosmetics and LocalPlayer().Cosmetics and table.HasValue(HideNameUnderMask, self.Cosmetics[COSM_SLOT_MASK]) then
-- 			return "Человек в маске ["..self:UserID().."]"
-- 		end
-- 		if CLIENT and LocalPlayer() ~= self and not self:IsBot() then
-- 			if self:GetNVar("FriendsList") ~= nil and istable(self:GetNVar("FriendsList")) and table.HasValue(self:GetNVar("FriendsList"), LocalPlayer():SteamID64()) or table.HasValue(LocalPlayer():GetNVar("FriendsList"), self:SteamID64()) then
-- 				return (self:GetNVar('Name') or self:SteamName()).." ["..self:UserID().."]"
-- 			end
-- 		end
-- 		if CLIENT and LocalPlayer() == self then
-- 			return (self:GetNVar('Name') or self:SteamName())
-- 		end
-- 		return "Незнакомец ["..self:UserID().."]"
-- 	else
-- 		return (self:GetNVar('Name') or self:SteamName()).." ["..self:UserID().."]"
-- 	end
-- 	return "Незнакомец ["..self:UserID().."]"
-- end

function PLAYER:Nick(force)
	if not force then
		if CLIENT and LocalPlayer() ~= self and not self:IsBot() and self.Cosmetics and LocalPlayer().Cosmetics and table.HasValue(HideNameUnderMask, self.Cosmetics[COSM_SLOT_MASK]) then
			return "Человек в маске ["..self:UserID().."]"
		end
		if CLIENT and LocalPlayer() ~= self and not self:IsBot() then
			if self:GetNVar("FriendsList") ~= nil and istable(self:GetNVar("FriendsList")) and table.HasValue(self:GetNVar("FriendsList"), LocalPlayer():SteamID64()) or table.HasValue(LocalPlayer():GetNVar("FriendsList"), self:SteamID64()) then
				return (self:GetNVar('Name') or self:SteamName()).." ["..self:UserID().."]"
			end
		end
		if CLIENT and LocalPlayer() == self then
			return (self:GetNVar('Name') or self:SteamName())
		end
		return "Незнакомец ["..self:UserID().."]"
	else
		return (self:GetNVar('Name') or self:SteamName()).." ["..self:UserID().."]"
	end
	return "Незнакомец ["..self:UserID().."]"
end

function PLAYER:RealName()
	return (self:GetNVar('Name') or self:SteamName()).." ["..self:UserID().."]"
end

PLAYER.Nick 	= PLAYER.Name
PLAYER.GetName 	= PLAYER.Name

function PLAYER:UserID()
	return self:GetNVar('CurrentChar') or 0
end

function PLAYER:GetMoney()
	return self:GetNetVar('Money')
end

function PLAYER:IsVIP()
	return self:IsUserGroup("vip")
end

function PLAYER:GetKarma()
	return self:GetNetVar('Karma')
end

function PLAYER:GetPlayerKarma()
  return self:GetNVar('PlayerKarma')
end

function rp.GetStaff()
	local StaffOnline = {}
	for k, v in pairs( player.GetAll() ) do
		if v:IsAdmin() then
			table.insert(StaffOnline, v)	
		end
	end
	return StaffOnline
end

function PLAYER:IsFriend(ply)	
	if istable(self:GetNVar("FriendsList")) and table.HasValue(self:GetNVar("FriendsList"), ply:SteamID64()) or istable(ply:GetNVar("FriendsList")) and table.HasValue(ply:GetNVar("FriendsList"), self:SteamID64()) then
		return true
	end
	return false
end

local math_floor 	= math.floor
local math_min 		= math.min
function rp.Karma(pl, min, max) -- todo, remove this
	return pl:Karma(min, max)
end

function PLAYER:Karma(min, max)
	return math_floor(min + ((max - min) * (self:GetKarma()/100)))
end

function PLAYER:Wealth(min, max)
	return math_min(math_floor(min + ((max - min) * (self:GetMoney()/25000000))), max)
end

function PLAYER:HasLicense()
	return (self:GetNetVar('HasGunlicense') or self:GetJobTable().hasLicense)
end


