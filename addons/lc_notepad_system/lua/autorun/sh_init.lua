 Notepad = Notepad or {}
 Notepad.Langlues = {}
 Notepad.Sounds = {
  write = {"physics/cardboard/cardboard_notepad_write1.wav","physics/cardboard/cardboard_notepad_write2.wav","physics/cardboard/cardboard_notepad_write3.wav","physics/cardboard/cardboard_notepad_write4.wav","physics/cardboard/cardboard_notepad_write5.wav"},
  writeline = {"physics/cardboard/cardboard_notepad_writeline1.wav","physics/cardboard/cardboard_notepad_writeline2.wav","physics/cardboard/cardboard_notepad_writeline3.wav","physics/cardboard/cardboard_notepad_writeline4.wav","physics/cardboard/cardboard_notepad_writeline5.wav"},  
  earse = {"physics/cardboard/cardboard_notepad_erase1.wav","physics/cardboard/cardboard_notepad_erase2.wav"},  
  leaf = {"physics/cardboard/cardboard_notepad_leaf1.wav","physics/cardboard/cardboard_notepad_leaf2.wav"},  
  baked = {"physics/cardboard/cardboard_notepad_baked1.wav"},
 }
 
if SERVER then
 CreateConVar("sv_nt_netlimitspam","0",FCVAR_GAMEDLL,"Limit net message in second") -- хуета
 AddCSLuaFile("cl_notepad.lua")

 for i, f in pairs(file.Find("autorun/langlues/*", "LUA")) do
  AddCSLuaFile("autorun/langlues/" .. f)
  print("[NT] Add langlue '" .. f .. "'")
 end

 include("sv_notepad.lua")
else
 CreateConVar("cl_nt_active_langlue","ru",FCVAR_CLIENTDLL,"Active langlue")
  Notepad.ActiveLanglue = GetConVar("cl_nt_active_langlue"):GetString()
  
 for i, f in pairs(file.Find("autorun/langlues/*", "LUA")) do
  include("autorun/langlues/" .. f)
  print("[NT] Add langlue '" .. f .. "'")  
 end  

 include("cl_notepad.lua")
end