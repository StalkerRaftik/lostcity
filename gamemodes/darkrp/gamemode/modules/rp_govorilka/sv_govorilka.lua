util.AddNetworkString( "SayTTS" )

hook.Add( "PlayerSay", "TTSFTW", function( ply, text, team )
    if not team then
        if ply:HasUpgrade("time_govorilka") then
        if string.StartWith(text, "!") or string.StartWith(text, "/") then return end
            net.Start( "SayTTS" )
            net.WriteString( text )
            net.WriteEntity( ply )
            net.Broadcast()
        end
    end
end )	
