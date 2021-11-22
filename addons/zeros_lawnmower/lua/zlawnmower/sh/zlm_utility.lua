zlm = zlm or {}
zlm.f = zlm.f or {}
zlm.utility = zlm.utility or {}

if SERVER then

	// Basic notify function
	function zlm.f.Notify(ply, msg, ntfType)
		if DarkRP then
			DarkRP.notify(ply, ntfType, 8, msg)
		else
			ply:ChatPrint(msg)
		end
	end

	// This saves the owners SteamID
	function zlm.f.SetOwnerByID(ent, id)
		ent:SetNWString("zlm_Owner", id)
	end

	// This saves the owners SteamID
	function zlm.f.SetOwner(ent, ply)
		if (IsValid(ply)) then
			ent:SetNWString("zlm_Owner", ply:SteamID())

			if zlm.config.CPPI and CPPI then
				ent:CPPISetOwner(ply)
			end
		else
			ent:SetNWString("zlm_Owner", "world")
		end
	end

	// This function tells us if the player is an Admin
	function zlm.f.IsAdmin(ply)

		if IsValid(ply) and ply:IsPlayer() then

			//xAdmin Support
			if xAdmin then
				return ply:IsAdmin()
			else
				if table.HasValue(zlm.config.AdminRanks, ply:GetUserGroup()) then
					return true
				else
					return false
				end
			end
		else
			return false
		end
	end
end

if (CLIENT) then

	function zlm.f.LerpColor(t, c1, c2)
		local c3 = Color(0, 0, 0)
		c3.r = Lerp(t, c1.r, c2.r)
		c3.g = Lerp(t, c1.g, c2.g)
		c3.b = Lerp(t, c1.b, c2.b)
		c3.a = Lerp(t, c1.a, c2.a)

		return c3
	end

	function zlm.f.stringWrap(str, w, f)
		if not isstring(str) then return end

		if f then
			surface.SetFont(f)
		else
			surface.SetFont("DermaDefault")
		end

		local stre = string.Explode(" ", str)
		local stri = {}
		local ti = 1
		stri[ti] = {}

		for k, v in pairs(stre) do
			local vw, vh = surface.GetTextSize(v)
			local tw, th = surface.GetTextSize(table.concat(stri[ti], ""))

			if tw + vw <= w then
				table.insert(stri[ti], v)
			else
				ti = ti + 1
				stri[ti] = {}
				table.insert(stri[ti], v)
			end
		end

		return stri
	end

	function zlm.f.PlayClientAnimation(ent,anim, speed)
		local sequence = ent:LookupSequence(anim)
		ent:SetCycle(0)
		ent:ResetSequence(sequence)
		ent:SetPlaybackRate(speed)
		ent:SetCycle(0)
	end
end



// This returns the entites owner SteamID
function zlm.f.GetOwnerID(ent)
	return ent:GetNWString("zlm_Owner", "nil")
end

// This returns the owner
function zlm.f.GetOwner(ent)
	if (IsValid(ent)) then
		local id = ent:GetNWString("zlm_Owner", "nil")
		local ply = player.GetBySteamID(id)

		if (IsValid(ply)) then
			return ply
		else
			return false
		end
	else
		return false
	end
end

// This returns true if the input is the owner
function zlm.f.IsOwner(ply, ent)
	if (IsValid(ent)) then
		local id = ent:GetNWString("zlm_Owner", "nil")
		local ply_id = ply:SteamID()

		if (IsValid(ply) and id == ply_id or id == "world") then
			return true
		else
			return false
		end
	else
		return false
	end
end

// This returns true if the player is a admin
function zlm.f.IsAdmin(ply)
	if (IsValid(ply)) then
		if table.HasValue(zlm.config.AdminRanks,ply:GetUserGroup()) then
			return true
		else
			return false
		end
	else
		return false
	end
end

// Used for Debug
function zlm.f.debug(mgs)
	if (zlm.config.Debug) then
		if istable(mgs) then
			print("[    DEBUG    ] Table Start >")
			PrintTable(mgs)
			print("[    DEBUG    ] Table End <")
		else
			print("[    DEBUG    ] " .. mgs)
		end
	end
end

// Checks if the distance between pos01 and pos02 is smaller then dist
function zlm.f.InDistance(pos01, pos02, dist)
	local inDistance = pos01:DistToSqr(pos02) < (dist * dist)
	return  inDistance
end

function zlm.f.table_randomize( t )
	local out = { }

	while #t > 0 do
		table.insert( out, table.remove( t, math.random( #t ) ) )
	end

	return out
end

//Used to fix the Duplication Glitch
function zlm.f.CollisionCooldown(ent)
	if ent.zlm_CollisionCooldown == nil then
		ent.zlm_CollisionCooldown = true

		timer.Simple(0.1,function()
			if IsValid(ent) then
				ent.zlm_CollisionCooldown = false
			end
		end)

		return false
	else
		if ent.zlm_CollisionCooldown then
			return true
		else
			ent.zlm_CollisionCooldown = true

			timer.Simple(0.1,function()
				if IsValid(ent) then
					ent.zlm_CollisionCooldown = false
				end
			end)
			return false
		end
	end
end
