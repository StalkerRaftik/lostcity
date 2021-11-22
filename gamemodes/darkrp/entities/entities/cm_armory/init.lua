AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()

	self:SetModel(Model("models/props_c17/FurnitureDresser001a.mdl"))
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	-- self:DropToFloor()
	-- self:SetPos(Vector(0,0,150)+self:GetPos())
	local phys = self:GetPhysicsObject()

	if not file.Exists( "christmasgift.txt", "DATA" ) then
		file.Write( "christmasgift.txt", "" )
	end
	
	if phys:IsValid() then
	
		phys:Wake()
		
	end
		
end

function ENT:Use( activator)
	if activator:IsPlayer() and activator:GetEyeTrace().Entity == self then
		if (activator.lastPickup or 0) < CurTime() then

			activator.lastPickup = CurTime() + 0.1
			
			local findply = false

			local f = file.Open( "christmasgift.txt", "r", "DATA" )
				while not f:EndOfFile() do 
					local str = f:ReadLine()
					local find = string.find( str, activator:SteamID64())
					if find ~= nil then
						findply = true
					end
				end
			f:Close()
			
			if findply == true then
				DarkRP.notify(activator, 1, 4, "Вы уже получили новогодний подарок!")
				return
			else
				local f = file.Open( "christmasgift.txt", "a", "DATA" )
					file.Append( "christmasgift.txt", activator:SteamID64() .. "\n" )
				f:Close()

				DarkRP.notify(activator, 1, 10, "Вот ваш новогодний подарок!")
				activator:AddMoney(2021)
				local chance = math.random( 1, 100 )
				if chance <= 75 then
					activator:AddCredits(70)
					DarkRP.notify(activator, 1, 10, "+70 донат-валюты!")
				elseif chance > 75 and chance <= 99 then
					activator:AddCredits(150)
					DarkRP.notify(activator, 1, 10, "+150 донат-валюты!")
				else
					activator:AddCredits(300)
					DarkRP.notify(activator, 1, 10, "+300 донат-валюты!")
				end

				DarkRP.notify(activator, 1, 10, "+2021 монет!")
				DarkRP.notify(activator, 1, 10, "Также загляните в инвентарь!")
				if activator:GetLevel() <= 20 then 
					activator:AddItem(INV_WEAPON, "tfa_remington870")
				elseif activator:GetLevel() <= 40 then
					activator:AddItem(INV_WEAPON, "tfa_spas12")
				elseif activator:GetLevel() <= 60 then
					activator:AddItem(INV_WEAPON, "tfa_f2000")
				elseif activator:GetLevel() > 60 then
					activator:AddItem(INV_WEAPON, "tfa_m98b")
				end
				activator:AddItem(INV_WEAPON, "tfa_coltpython")
				activator:AddItem(INV_HATS, "backpack_pilgrim")
				activator:AddItem(INV_HATS, "helmetmich")
				activator:AddItem(INV_HATS, "pressvest")
				activator:AddItem(INV_HATS, "christmashat")
				
			end
		end
	end
end
