zlm = zlm || {}
zlm.f = zlm.f || {}

include("zlawnmower/sh/zlm_precache.lua")
AddCSLuaFile("zlawnmower/sh/zlm_precache.lua")
print("[    Zeros LawnMower - Initialize:    ] " .. "zlm_precache.lua")

include("zlawnmower/sh/zlm_tableregi.lua")
AddCSLuaFile("zlawnmower/sh/zlm_tableregi.lua")
print("[    Zeros LawnMower - Initialize:    ] " .. "zlm_tableregi.lua")

local IgnoreFileTable = {
	["zlm_tableregi.lua"] = true,
	["zlm_precache.lua"] = true
}

function zlm.f.LoadAllFiles(fdir)
	local files, dirs = file.Find(fdir .. "*", "LUA")

	for _, afile in ipairs(files) do
		if (string.match(afile, ".lua") and not IgnoreFileTable[afile]) then
			print("[    Zeros LawnMower - Initialize:    ] " .. afile)

			if SERVER then
				AddCSLuaFile(fdir .. afile)
			end

			include(fdir .. afile)
		end
	end

	for _, dir in ipairs(dirs) do
		zlm.f.LoadAllFiles(fdir .. dir .. "/")
	end
end

zlm.f.LoadAllFiles("zlawnmower/")
zlm.f.LoadAllFiles("zlm_languages/")
