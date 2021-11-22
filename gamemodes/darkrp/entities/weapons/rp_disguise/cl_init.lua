include("shared.lua")
SWEP.PrintName = "Маскировка"
SWEP.Slot = 1
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.FrameVisible = false

SWEP.ViewModelFOV = 40
SWEP.UseHands 				= false

SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false

SWEP.VElements = {
	["suitcase"] = { type = "Model", model = "models/weapons/w_suitcase_passenger.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.37, 5.307, 2.947), angle = Angle(-45.89, 77.601, 180), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
//SWEP.VElements = {
//	["suitcase"] = { type = "Model", model = "models/weapons/w_suitcase_passenger.mdl", bone = "ValveBiped.cube2", rel = "", pos = Vector(0, -0.977, -0.08), angle = Angle(3.855, -19.458, -94.402), size = Vector(0.755, 0.755, 0.755), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
//}
SWEP.WElements = {
	["suitcase"] = { type = "Model", model = "models/weapons/w_suitcase_passenger.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.683, -0.08, 0), angle = Angle(106.708, 0, 0), size = Vector(0.903, 0.903, 0.903), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}


function SWEP:PrimaryAttack()
	return
end

function SWEP:SecondaryAttack()

	return
end

function rp.DisguiseMenu()

	local fr = ui.Create('ui_frame', function(self, p)
		self:SetSize(ScrW() * 0.65, ScrH() * 0.6)
		self:SetTitle('Маскировка')
		self:Center()
		self:MakePopup()
	end)

	ui.Create('rp_jobslist', function(self, p)
		self:SetPos(5, 25)
		self:SetSize(p:GetWide() - 10, p:GetTall() - 30)

		self.DoClick = function()
				net.Start('PlayerDisguise')
				net.WriteInt(self.job.team, 8)
				net.SendToServer()
		end
	end, fr)
end

net.Receive('DisguiseMenu', rp.DisguiseMenu)