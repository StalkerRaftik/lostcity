rp = rp or {
	cfg = {},
}

DarkRP = DarkRP or {}

PLAYER = FindMetaTable'Player'
ENTITY = FindMetaTable'Entity'
VECTOR = FindMetaTable'Vector'

if (SERVER) then
	require'mysql'
else
	require'cvar'
	require'wmat'
end

require'nw'
require'pon'
require'pcolor'
require'xfn'
rp.include_sv = (SERVER) and include or function() end
rp.include_cl = (SERVER) and AddCSLuaFile or include

rp.include_sh = function(f)
	rp.include_sv(f)
	rp.include_cl(f)
end

rp.include = function(f)
	if string.find(f, '_sv.lua') then
		rp.include_sv(f)
	elseif string.find(f, '_cl.lua') then
		rp.include_cl(f)
	else
		rp.include_sh(f)
	end
end

rp.include_dir = function(dir, recursive)
	local fol = GM.FolderName .. '/gamemode/' .. dir .. '/'
	local files, folders = file.Find(fol .. '*', 'LUA')

	for _, f in ipairs(files) do
		rp.include(fol .. f)
	end

	if (recursive ~= false) then
		for _, f in ipairs(folders) do
			rp.include_dir(dir .. '/' .. f)
		end
	end
end

function rp.LoadModules(dir) -- Depruciated
  local fol = GM.FolderName ..'/gamemode/' .. dir .. '/'
  local _, folders = file.Find(fol .. '*', 'LUA')
  for _, folder in ipairs(folders) do
    local files, _ = file.Find(fol .. folder .. '/sh_*.lua', 'LUA')
    for _, File in ipairs(files) do
      rp.include_sh(fol .. folder .. '/' .. File)
    end
    local files, _ = file.Find(fol .. folder .. '/sv_*.lua', 'LUA')
    for _, File in ipairs(files) do
      rp.include_sv(fol .. folder .. '/' .. File)
    end
    local files, _ = file.Find(fol .. folder .. '/cl_*.lua', 'LUA')
    for _, File in ipairs(files) do
      rp.include_cl(fol .. folder .. '/' .. File)
    end
  end
end

GM.Name = 'DarkRP'
GM.Author = ''
GM.Website = ''
rp.include_sv'db.lua'
rp.include_sh'cfg/cfg.lua'
rp.include_sh'cfg/colors.lua'
rp.include_dir 'libs'
rp.include_dir 'libs/optimizations'
rp.include_dir'util'
rp.include_dir('core', false)
rp.include_dir'core/sandbox'
rp.include_dir('core/chat', false)
rp.include_dir'core/player'
rp.include_dir'core/credits'
rp.include_dir'core/ui'
rp.include_dir('core/prop_protect', false)
rp.include_dir('core/makethings', false)
rp.include_dir 'core/menus' 
rp.include_dir'core/doors'
rp.include_sh'cfg/jobs.lua'
rp.LoadModules('modules') --Depricated
rp.include_sh'cfg/entities.lua'
rp.include_sh'cfg/upgrades.lua'
rp.include_sh'cfg/terms.lua'
rp.include_sv'cfg/limits.lua'


for k, v in pairs(rp.Foods) do
  util.PrecacheModel(v.model)
end

for k, v in pairs(Cosmetics.Items) do
  util.PrecacheModel(v.model)
end

print([[




  Lost City (New Update)
  Credits: 
  -----------------------------------------
  Code by Octopus Project dev. team
  - gmod-octopus.ru
  - steamcommunity.com/groups/octopus-project
  - steamcommunity.com/id/kirussell/
  - discord.gg/ngHafFe
  - @kirussell#9151
  -----------------------------------------




  
]])

hook.Run("rp.GamemodeLoaded")

function GM:CanPlayerSuicide( pPlayer )
	return false
end

function GM:PlayerFootstep( pPlayer )
	if pPlayer:Crouching() or not pPlayer:Alive() then
		return true
	end
end