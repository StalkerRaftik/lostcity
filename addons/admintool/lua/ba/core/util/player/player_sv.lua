-- Chat Mute
function PLAYER:ChatMute(time, callback)
	self:SetBVar('ChatMuted', true)
	self:Timer('ChatMuted', time, 1, function()
		self:UnChatMute()
		if callback then callback() end
	end)
end

function PLAYER:UnChatMute()
	self:SetBVar('ChatMuted', nil)
	self:DestroyTimer('ChatMuted')
end

function PLAYER:IsChatMuted()
	return (self:GetBVar('ChatMuted') == true)
end

hook.Add('PlayerSay', 'ba.ChatMute.PlayerSay', function(pl)
	if pl:IsChatMuted() then return '' end
end)

hook.Add('PlayerCanUseAdminChat', 'ba.Mute.PlayerCanUseAdminChat', function(pl)
	if pl:IsChatMuted() then 
		return false
	end
end)


-- Voice Mute
function PLAYER:VoiceMute(time, callback)
	self:SetBVar('VoiceMuted', true)
	self:Timer('VoiceMuted', time, 1, function()
		self:UnVoiceMute()
		if callback then callback() end
	end)
end

function PLAYER:UnVoiceMute()
	self:SetBVar('VoiceMuted', nil)
	self:DestroyTimer('VoiceMuted')
end

function PLAYER:IsVoiceMuted()
	return (self:GetBVar('VoiceMuted') == true)
end

hook.Add('PlayerCanHearPlayersVoice', 'ba.Mute.PlayerCanHearPlayersVoice', function(listener, talker)
	if talker:IsVoiceMuted() then return false, false end
end)


-- HashID
function PLAYER:HashID()
	if (not self:GetBVar('HashID')) then
		local hashid = sha2.hash256(self:SteamID64() .. 'SuperSecretKey')
		self:SetBVar('HashID', hashid)
		return hashid
	end
	return self:GetBVar('HashID')
end

function PLAYER:NiceIP()
	if (not self._NiceIP) then 
		self._NiceIP = string.StripPort(self:IPAddress())
	end
	return self._NiceIP
end