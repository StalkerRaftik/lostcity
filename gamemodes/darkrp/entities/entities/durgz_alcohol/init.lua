AddCSLuaFile("shared.lua")
include("shared.lua")


ENT.MODEL = "models/props_junk/garbage_glassbottle001a.mdl"


ENT.LASTINGEFFECT = 45; --how long the high lasts in seconds


local function shouldnt_do_that_shit(pl)
    return pl == NULL or not pl or pl == nil or not pl:GetActiveWeapon() or pl:GetNetworkedFloat("durgz_alcohol_high_end") < CurTime()
end

function ENT:High(activator,caller)
	
	--does random stuff while higH!
	local commands = {"left", "right", "moveleft", "moveright", "attack"}
	local thing = math.random(1,3)
	
	local TRANSITION_TIME = self.TRANSITION_TIME;
	
	for i = 1,thing do
		timer.Simple(math.Rand(5,10), function()
			if activator and activator:GetNetworkedFloat("durgz_alcohol_high_end") - TRANSITION_TIME > CurTime() then
				local cmd = commands[math.random(1, #commands)]
				activator:ConCommand("+"..cmd)
				timer.Simple(1, function()
					activator:ConCommand("-"..cmd)
				end)
			end
		end)
	end
	
	--takes out the pistol and then shoots randomly
	local oldwep = activator:GetActiveWeapon():GetClass()
	


	if not oldwep then return end


	timer.Simple(0.3, function() if shouldnt_do_that_shit(activator) then return end
		activator:ConCommand("+attack")
		timer.Simple(0.1, function() if activator == NULL or not activator or activator == nil then return end
			activator:ConCommand("-attack")
			if oldwep and oldwep != nil and oldwep != NULL and activator:Alive() then
                activator:SelectWeapon(oldwep)
            end
		end)
	end)

end
