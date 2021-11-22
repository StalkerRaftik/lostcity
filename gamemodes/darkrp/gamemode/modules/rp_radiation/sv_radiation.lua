util.AddNetworkString( "DeployMask" )
util.AddNetworkString( "RemoveMask" )
util.AddNetworkString( "WipeMask" )
util.AddNetworkString( "ClearMask" )
util.AddNetworkString( "WipeMaskHud" )
util.AddNetworkString( "SwapFilter" )
util.AddNetworkString( "AddShitOnScreengasmask" )

util.AddNetworkString( "UseMedkit" )

util.AddNetworkString( "MetroHudCheck" )

sounds = {}

hook.Add("RadiationGasMaskChecker","EntityTakeDamageMetroGasmaskmod",function( ply )
	-- print("CHECK MASK HEALTH")

	-- local class = ply.Cosmetics[4]
	-- local key = 4
	-- local conditionwaste = 1
	-- if key then

	-- 	-- print(ply.Cosmetics[key])

	-- 	if !istable(ply.Cosmetics[key]) then
	-- 		ply.Cosmetics[key] = {
	-- 			class = class,
	-- 			health = 100,
	-- 		}
	-- 	end

	-- 	ply:SavePlayerData("cosmetics", ply.Cosmetics)
	-- 	if not ply.Cosmetics[key].health then ply.Cosmetics[key].health = 100 end
	-- 	ply.Cosmetics[key].health = ply.Cosmetics[key].health - conditionwaste
	-- 	ply:SetNWInt("GasmaskHealth", ply.Cosmetics[key].health)
	-- 	print(ply.Cosmetics[key].health)
	-- 	if ply.Cosmetics[key].health <= 0 then
	-- 		ply.Cosmetics[key] = nil
	-- 		DarkRP.notify(ply, 1, 4, "Ваш противогаз пришёл в негодность")
	-- 	end

	-- 	ply.Cosmetics = ply.CosmeticsData
 --    	ply:NetVars("Cosmetics", ply.Cosmetics, true)
 --    	ply:SavePlayerData("cosmetics", ply.Cosmetics)
	-- end
	if ply:HasGasmask() and not ply:GetNWInt("GasmaskHealth") then ply:SetNWInt("GasmaskHealth", 100 ) end

    if ply:HasGasmask() then
		if ply:GetNWInt("GasmaskHealth") <= 0 then
			ply:RemoveCosmetic(ply.Cosmetics[COSM_SLOT_MASK])
			DarkRP.notify(ply, 1, 4, "Ваш противогаз пришёл в негодность")
        	ply:SetNWInt("GasmaskHealth", 100)
        elseif ply:GetNWInt("GasmaskHealth") > 0 then
			ply:SetNWInt("GasmaskHealth", ply:GetNWInt("GasmaskHealth") - 0.5 )
		end
    end

end)

function PLAYER:SetRadiation(amount)
	self:SetNVar('Radiation', math.Clamp(amount, 0, 10000), NETWORK_PROTOCOL_PRIVATE)
end

hook.Add("PlayerSpawn", "SetSpawnRadiation", function(ply)
	ply:SetRadiation(0)
end)

local raddelay = 0
hook.Add("Think", "DoRadiationDamage", function()
	if raddelay > CurTime() then return end
	raddelay = CurTime() + 10

	for _,ply in pairs(player.GetAll()) do
		if not ply:Alive() then continue end
		// Radiation decreasing
		if not ply.radtime or ply.radtime + 20 < CurTime() and ply:GetRadiation() > 0 then
			if ply.radtime then ply.radtime = nil end

			ply:SetRadiation(ply:GetRadiation() - 10)
			if ply:GetRadiation() < 0 then ply:SetRadiation(0) end
		end

		// Radiation increasing
		local rad = ply:GetRadiation()
		if rad <= 1000 then continue end

		if rad > 1000 then
			ply:TakeRadDamage( 1 + math.floor(rad/1000) )
		end

		if rad > 5000 then ply:Kill() end

		// Radiation emitting
		potentialRad = rad/1000 * 10
		for _,radvictim in pairs(player.GetAll()) do
			if radvictim == ply then continue end
			if ply:GetPos():DistToSqr(radvictim:GetPos()) < 200*200 then
				radvictim:SetRadiation(radvictim:GetRadiation() + potentialRad)
				radvictim.radtime = CurTime()
			end
		end
	end


end)

function PLAYER:TakeRadDamage(dmg)
	self:SetHealth(self:Health() - dmg)
	if self:Health() <= 0 then
		self:Kill()
	end
end


local function DropStuffOnScreen(dist, damage, attacker, types)
	if types == "red" then
			if dist < 100 then
				for i = 1, math.Round(damage/30) do
					net.Start( "AddShitOnScreengasmask" )
						net.WriteString("blooddrop")
					net.Send(attacker)
				end
			end
			if dist < 80 and damage >= 20 then
				for i = 1, math.Round(damage/80) do
					net.Start( "AddShitOnScreengasmask" )
						net.WriteString("bloodsplat")
					net.Send(attacker)
				end
			end
	elseif types == "yellow" then
			if dist < 80 and damage >= 20 then
				for i = 1, math.Round(damage/50) do
					net.Start( "AddShitOnScreengasmask" )
						net.WriteString("ybloodsplat")
					net.Send(attacker)
				end
			end
	end
end

hook.Add("EntityTakeDamage", "EntityTakeDamageMetro", function(trg, dmg)
		if dmg:GetDamage() > 1 and dmg:GetAttacker():IsPlayer() then
			local tr = dmg:GetAttacker():GetEyeTrace()
			local dist = dmg:GetAttacker():GetShootPos():Distance(trg:GetPos())
			local damage = dmg:GetDamage()
			local attacker = dmg:GetAttacker()
			--print(damage)
			if trg:GetBloodColor() == BLOOD_COLOR_RED then
				if attacker:HasGasmask() == true then
					DropStuffOnScreen(dist, damage, attacker, "red")
				end
			elseif trg:GetBloodColor() == BLOOD_COLOR_YELLOW or trg:GetBloodColor() == BLOOD_COLOR_GREEN or trg:GetBloodColor() == BLOOD_COLOR_ZOMBIE or trg:GetBloodColor() == BLOOD_COLOR_ANTLION then
				if attacker:HasGasmask() == true then
					DropStuffOnScreen(dist, damage, attacker, "yellow")
				end
			end
		end
end)

local dmgs = {
	DMG_ACID,
	DMG_POISON,
	DMG_NERVEGAS,
	DMG_RADIATION
}

local function gasCheck(ply)

	if ply:HasGasmask() == true then
		if ply:GetNWInt("FilterDuration") <= 0 and ply:GetNWInt("Filter") >= 1 then
			ply:SetNWInt("Filter", ply:GetNWInt("Filter")-1)
		else
			if ply:GetNWInt("FilterDown") < CurTime() then
				ply:SetNWInt("FilterDuration", ply:GetNWInt("FilterDuration")-1)
				ply:SetNWInt("FilterDown", CurTime() + 1)
				-- print("DAMAGE FILTER")
			end
		end
	end
end

hook.Add( "PlayerPostThink", "PlayerPostThinkGasmaskHandleKeysShitBlyat", function(ply)
	-- local maskhlth = ply:GetNWInt("GasmaskHealth")
	gasCheck(ply)
	-- if maskhlth <= 0 and ply:GetNWBool("MetroGasmask") == true then
	-- 	timer.Remove("MMFX"..ply:SteamID())
	-- 	if not sounds[ply:SteamID()] then return end
	-- 	sounds[ply:SteamID()]:Stop()
	-- 	ply:SetNWBool("MetroGasmask", false)
	-- 	ply:SetNWBool("HasGasmask", false)
	-- 	local wep = ply:GetActiveWeapon()
	-- 	ply:SetNWEntity("gasmask_lastwepon", wep:GetClass())

	-- 	ply:Give("metro_gasmask_holster")
	-- 	ply:SelectWeapon( "metro_gasmask_holster" )
	-- end
end)
function defaultGasmaskVariables(ply)
	ply:SetNWBool("MetroGasmask", false)
	ply:SetNWBool("HasGasmask", false)
	ply:SetNWInt("Filter", -1)
	ply:SetNWInt("FilterDuration", 0)
	ply:SetNWInt("FLBattery", 360)
	ply:SetNWInt("GasmaskHealth", 100)
	ply:SetNWBool("HasNV", false)
	ply:SetNWBool("AdminFilter", false)
end

net.Receive( "DeployMask", function(len, ply)
	if not ply:HaveItem("hats", "m10") then return false end
	if IsValid(ply:GetActiveWeapon()) then
		local wep = ply:GetActiveWeapon():GetClass()
		ply:SetNWString("gasmask_lastwepon", wep)
	end

	ply:Give("metro_gasmask_deploy")
	ply:SelectWeapon( "metro_gasmask_deploy" )
end)

net.Receive( "SwapFilter", function(len, ply)
	if not ply:HaveItem(INV_ENTITY, "rp_gasmaskfilter") then return false end
	if IsValid(ply:GetActiveWeapon()) then
		local wep = ply:GetActiveWeapon():GetClass()
		ply:SetNWString("gasmask_lastwepon", wep)
	end

	ply:Give("metro_gasmask_filter_swap")
	ply:SelectWeapon( "metro_gasmask_filter_swap" )
end)

net.Receive( "WipeMask", function(len, ply)
	if IsValid(ply:GetActiveWeapon()) then
		local wep = ply:GetActiveWeapon():GetClass()
		ply:SetNWString("gasmask_lastwepon", wep)
	end

	ply:Give("metro_gasmask_wipe")
	ply:SelectWeapon( "metro_gasmask_wipe" )
end)

net.Receive( "RemoveMask", function(len, ply)
	timer.Remove("MMFX"..ply:SteamID())
	if sounds[ply:SteamID()] then
		sounds[ply:SteamID()]:Stop()
	end

	if IsValid(ply:GetActiveWeapon()) then
		local wep = ply:GetActiveWeapon():GetClass()
		ply:SetNWString("gasmask_lastwepon", wep)
	end

	ply:Give("metro_gasmask_holster")
	ply:SelectWeapon( "metro_gasmask_holster" )
end)


hook.Add("DoPlayerDeath","DoPlayerDeathMetroModCyka",function( ply, attacker, dmginfo )

	timer.Remove("MMFX"..ply:SteamID())
	if sounds[ply:SteamID()] then
		sounds[ply:SteamID()]:Stop()
	end

end)

hook.Add("PlayerSpawn", "MMPlayerSpawn", function(ply)
	if ply != nil then
		if timer.Exists( "MM"..ply:SteamID() ) then
			timer.Remove("MM"..ply:SteamID())
			sounds[ply:SteamID()]:Stop()
		end
	end
end)
hook.Add("PlayerDisconnected", "MMPlayerLeave", function(ply)
	if ply != nil then
		if timer.Exists( "MM"..ply:SteamID() ) then
			timer.Remove("MM"..ply:SteamID())
			sounds[ply:SteamID()]:Stop()
		end
	end
end)
