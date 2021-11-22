util.AddNetworkString("LMMPrivKeysAdminMenu")
util.AddNetworkString("LMMPrivKeysDestroyKey")
util.AddNetworkString("LMMPrivKeysGenerateKey")
util.AddNetworkString("LMMPrivKeyGenerateCustomKey")
util.AddNetworkString("LMMPrivKeysUserMenu")
util.AddNetworkString("LMMPrivKeysRedeemKey")

file.CreateDir("lmmprivkeys")

local function SendGUI( ply )
	local files = {}
	for k,v in pairs( file.Find( "lmmprivkeys/*.txt", "DATA" ) ) do
		local contents = file.Read( "lmmprivkeys/" .. v )
		table.insert( files, { v, contents } )
	end

	net.Start("LMMPrivKeysAdminMenu")
		net.WriteTable( files )
	net.Send( ply )
end

hook.Add("PlayerSay", "LMMPrivKeysCommand", function( ply, text, team )
	if (string.sub( text, 1, 10 ) == "/promocode") then
		
		net.Start("LMMPrivKeysUserMenu")
		net.Send( ply )
	
		return ""
	end
  if (string.sub( text, 1, 11 ) == "/apromocode") then
    
    if table.HasValue( lmmprivkeyconfig.AllowedRanks, ply:GetUserGroup() ) then
      SendGUI( ply )
    end
    
    return ""
  end

end)

net.Receive( "LMMPrivKeysDestroyKey", function( len, ply )

	if not table.HasValue( lmmprivkeyconfig.AllowedRanks, ply:GetUserGroup() ) then return end

	local key = net.ReadString()
	file.Delete( "lmmprivkeys/" .. key )
	
	SendGUI( ply )
end )

net.Receive( "LMMPrivKeysGenerateKey", function( len, ply )
	if not table.HasValue( lmmprivkeyconfig.AllowedRanks, ply:GetUserGroup() ) then return end
	
	local rank = net.ReadString()
	
	file.Write( "lmmprivkeys/" .. generateKey() .. ".txt", rank )

	SendGUI( ply )
end )

net.Receive( "LMMPrivKeyGenerateCustomKey", function( len, ply )
	if not table.HasValue( lmmprivkeyconfig.AllowedRanks, ply:GetUserGroup() ) then return end
	
	local rank = net.ReadString()
	local key = net.ReadString()
	
	file.Write( "lmmprivkeys/" .. key .. ".txt", rank )

	timer.Simple(.3, SendGUI( ply ))
end )

function generateKey()

	local str = string.char(math.random(35, 41))
	for i=1, 5 do
		str = str .. string.char(math.random(97, 122))
	end
	for i=1, 5 do
		str = str .. string.char(math.random(63, 91))
	end
	for i=1, 5 do
		str = str .. string.char(math.random(97, 122))
	end	
	for i=1, 3 do
		str = str .. string.char(math.random(48, 57))
	end
	for i=1, 2 do
		str = str .. string.char(math.random(35, 41))
	end	
	
	return str
end

-- hook.Add("Initialize", "lostupdkey.CreateTable", function()
--   db:Query("CREATE TABLE IF NOT EXISTS lostupdkey(steamid VARCHAR(255), data VARCHAR(255) NOT NULL, ID int NOT NULL AUTO_INCREMENT PRIMARY KEY)")
-- end)


net.Receive( "LMMPrivKeysRedeemKey", function( len, ply )
	local key = net.ReadString()

	-- if string.lower(key) == "lostupdate.txt" then
	-- 	db:Query('SELECT `data` FROM `lostupdkey` WHERE `steamid`="' .. ply:SteamID64() .. '";', function(data)
	-- 		if data[1] and data[1].data then
	-- 			DarkRP.notify(ply, 1, 4, "Вы уже использвали данный промокод!")
	-- 			return false
	-- 		else
	-- 			db:Query('INSERT INTO lostupdkey (`steamid`, `data`) VALUES(?, ?);', ply:SteamID64(), true)
	-- 			DarkRP.notify(ply, 1, 4, "Вы получили Игрок+ на месяц!")
	-- 			rp.data.AddUpgradeUID(ply, "igrokplus1mo")			
	-- 			return true
	-- 		end
	-- 	end)
	-- else

		local files = file.Find( "lmmprivkeys/" .. key, "DATA" )

		if files and (#files) > 0 then

			local contents = file.Read( "lmmprivkeys/" .. files[1], "DATA" )
			
		ply:AddCredits( contents )
			
			if lmmprivkeyconfig.RemoveKeyAfterUse then
				file.Delete( "lmmprivkeys/" .. files[1] )
			end

			DarkRP.notify(ply, NOTIFY_GENERIC, 4, "Промокод был активирован! Вы получили: "..contents.." кредитов")
		else
			DarkRP.notify(ply, NOTIFY_ERROR, 4, "Данный промокод недействителен!")
		end
	-- end
end )
