local function httpUrlEncode(text) -- thanks to wiremod
	local ndata = string.gsub(text, "[^%w _~%.%-]", function(str)
		local nstr = string.format("%X", string.byte(str))
		return "%"..((string.len(nstr) == 1) and "0" or "")..nstr
	end)
	return string.gsub(ndata, " ", "+")
end

net.Receive( "SayTTS",  function()
    local text = net.ReadString()
    local ply = net.ReadEntity()
    local voice = ply:GetNVar('Gender') == 1 and "zahar" or "oksana"
    local encode = "http://tts.voicetech.yandex.net/tts?speaker="..voice.."&text=" .. httpUrlEncode(text)
    sound.PlayURL( encode, "noplay 3d", function( sound )
        if IsValid( sound ) then
            if IsValid(ply) then
                ply.TTSStation = sound
                sound:Play()
            end
        end
    end)
end)
	
hook.Add( "Think", "FollowPlayerSoundGovorilka", function()
    for k,v in pairs( player.GetAll() ) do
        if IsValid( v.TTSStation ) then
            v.TTSFFT = v.TTSFFT or {}
            v.TTSStation:SetPos( v:GetPos() )
            v.TTSStation:Set3DFadeDistance(300, 0)
            v.TTSStation:FFT( v.TTSFFT, FFT_512 )
            local state = v.TTSStation:GetState()
            if v.TTSStation:GetPos():Distance( LocalPlayer():GetPos() ) > 800 then
                if state == GMOD_CHANNEL_PLAYING then
                    v.TTSStation:Pause()
                end
            else
                if state == GMOD_CHANNEL_PAUSED or state == GMOD_CHANNEL_STOPPED then
                    if IsValid( v.TTSStation ) then v.TTSStation:Play() end
                end
            end
            if math.Round(v.TTSStation:GetPos():Distance( LocalPlayer():GetPos())) <= 300 then 
                v.TTSStation:SetVolume(0.5)
            else
                v.TTSStation:SetVolume(0.5)
            end
        end
    end
end)