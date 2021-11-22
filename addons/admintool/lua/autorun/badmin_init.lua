require 'nw'
require 'xfn'
require 'pon'
require 'pon2'
require 'netstream'
if (CLIENT) then 
	require 'cvar' 
else
	require 'ptmysql'
	require 'sha2'
end

ba 				= ba or {}
PLAYER 			= FindMetaTable('Player')

ba.include_sv 	= (SERVER) and include or function() end
ba.include_cl 	= (SERVER) and AddCSLuaFile or include
ba.include_sh 	= function(path) ba.include_sv(path) ba.include_cl(path) end
ba.include 		= function(f)
	if string.find(f, '_sv.lua') then
		ba.include_sv(f)
	elseif string.find(f, '_cl.lua') then
		ba.include_cl(f)
	else
		ba.include_sh(f)
	end
end
ba.include_dir 	= function(dir)
	local fol = 'ba/' .. dir .. '/'
	local files, folders = file.Find(fol .. '*', 'LUA')
	for _, f in ipairs(files) do
		ba.include(fol .. f)
	end
	for _, f in ipairs(folders) do
		ba.include_dir(dir .. '/' .. f)
	end
end

function ba.print(...)
	return MsgC(Color(0,255,0), '[Admin-Tool] ', Color(255,255,255), ... .. '\n')
end

ba.include_sh('ba/core/core_init.lua')

hook.Call('bAdmin_Loaded', ba)