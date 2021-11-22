include("sh_init.lua")

surface.CreateFont("3d2d",{font = "Tahoma",size = 130,weight = 1700,shadow = true, antialias = true})
surface.CreateFont("Trebuchet22", {size = 22,weight = 500,antialias = true,shadow = false,font = "Sans"})

-- timer.Create("CleanBodys", 60, 0, function()
-- 	RunConsoleCommand("r_cleardecals")
-- 	for k, v in ipairs(ents.FindByClass("class C_ClientRagdoll")) do
-- 		v:Remove()
-- 	end
-- 	for k, v in ipairs(ents.FindByClass("class C_PhysPropClientside")) do
-- 		v:Remove()
-- 	end
-- end)

-- RunConsoleCommand('cl_drawmonitors', '0')

-- hook('InitPostEntity', function()
--   LocalPlayer():ConCommand('stopsound; cl_updaterate 32; cl_cmdrate 32; cl_interp_ratio 2; cl_interp 0; cl_tree_sway_dir .5 .5; snd_restart')
-- end)


local GUIToggled = false
local mouseX, mouseY = ScrW() / 2, ScrH() / 2
function GM:ShowSpare1()
	if not LocalPlayer():IsValid() then return end
	GUIToggled = not GUIToggled

	if GUIToggled then
		gui.SetMousePos(mouseX, mouseY)
	else
		mouseX, mouseY = gui.MousePos()
	end
	gui.EnableScreenClicker(GUIToggled)
end

local FKeyBinds = {
	["gm_showhelp"] = "ShowHelp",
	-- ["gm_showteam"] = "ShowTeam",
	["gm_showspare1"] = "ShowSpare1",
	["gm_showspare2"] = "ShowSpare2"
}

function GM:PlayerBindPress(ply, bind, pressed)
	if not LocalPlayer():IsValid() then return end
	local bnd = string.match(string.lower(bind), "gm_[a-z]+[12]?")
	if bnd and FKeyBinds[bnd] and GAMEMODE[FKeyBinds[bnd]] then
		GAMEMODE[FKeyBinds[bnd]](GAMEMODE)
	end
	return
end

local curStep = 0
timer.Create("rp.Announcements.timer",120,0,function()
  curStep = curStep + 1

  if (not rp.cfg.Announcements[curStep]) then 
    curStep = 1
  end
  local msg = rp.cfg.Announcements[curStep]

  chat.AddText(color_white, "[", Color(255,150,0), "ИНФОРМАЦИЯ", color_white, "] ", color_white, msg)
  chat.PlaySound()
end)
