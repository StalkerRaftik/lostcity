if SERVER then
	util.AddNetworkString("NetVars")

	net.Receive("NetVars", function(len, ply)
		local ent = net.ReadEntity()
		local str = net.ReadString()
		if not IsValid(ent) then return end

		if ent:IsPlayer() then

			if str == "" or str == "Cosmetics" then
				ent:NetVars("Cosmetics", ent.Cosmetics, true, ply)
			end

			return
		end
	end)

	local emeta = FindMetaTable("Entity")

	function emeta:NetVars(name, vars, overwrite, scope)

		net.Start("NetVars")
			local send = vars or {}
			net.WriteEntity( self )
			net.WriteString( name )
			net.WriteBool( overwrite == nil and true or overwrite )
			net.WriteTable( send )
		if scope then net.Send( scope ) else net.Broadcast() end

		--print("[NetVars] Sent '" .. name .. "'.")

	end

else

	hook.Add("PlayerFirstInteract", "rp.NetVars", function(ply)

		net.Start("NetVars")
			net.WriteEntity(ply)
			net.WriteString("")
		net.SendToServer()

	end)

	hook.Add("OnEntityCreated", "rp.NetRequest", function(ent)
		if IsValid(ent) and ent:IsPlayer() and ent:GetNWBool("FirstInteract",false) == true then
			net.Start("NetVars")
				net.WriteEntity(ent)
				net.WriteString("")
			net.SendToServer()
		end
	end)

	net.Receive("NetVars", function()
		local ent = net.ReadEntity()
		local str = net.ReadString()
		local overwrite = net.ReadBool()
		local var = net.ReadTable()

		if not var then return end

		if not IsValid(ent) then
			--ErrorNoHalt("Invalid entity for NetVars ('" .. str .. "' for '" .. tostring(ent) .. "')\n")
			--debug.Trace()
			return
		end

		local old = table.Copy( ent[str] or {} )
		local new = table.Copy( var )

		if not ent[str] then ent[str] = {} end

		if overwrite then
			ent[str] = {}
		end

		for k, v in pairs(var) do
			ent[str][k] = v
		end

		hook.Call("NetVars", nil, ent, str, old, new)
	end)

end