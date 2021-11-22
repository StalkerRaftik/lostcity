if SERVER then
	AddCSLuaFile ("shared.lua")
	util.AddNetworkString("doorID")
end

if CLIENT then

SWEP.PrintName = "Узнать ID prop'a"
SWEP.Slot = 1
SWEP.SlotPos = 5
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true

end

SWEP.Author = "Kiry"
SWEP.Contact = "N/A" 
SWEP.Purpose = "Узнать ID prop'a."
SWEP.Instructions = [[ 
Нажмите ЛКМ на дверь, чтобы узнать её ID.
Выберете столько дверей, сколько вам необходимо.
Когда вы закончите, нажмите ПКМ и вы увидите все ID дверей, которые выбирали ]]

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.ViewModel = Model("models/weapons/c_pistol.mdl")
SWEP.WorldModel = "models/weapons/w_toolgun.mdl"
SWEP.Category = "LostCity Weapon Admin"

SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.UseHands = true

SWEP.Primary.Ammo = "nil"
SWEP.Primary.DefaultClip = -1
SWEP.Primary.ClipSize = -1
SWEP.Primary.Automatic = false

SWEP.Secondary.Ammo = "nil"
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.Automatic = false

function SWEP:Initialize()
	self.DoorIDs = {}
end

function SWEP:PrimaryAttack()

if SERVER then

local trace = self:GetOwner():GetEyeTrace().Entity
	
	if !table.HasValue(self.DoorIDs, trace:MapCreationID()) then
	
		table.insert(self.DoorIDs, trace:MapCreationID())
		self:GetOwner():ChatPrint("ID добавленно в список!")
	end

end
end 

function SWEP:SecondaryAttack()

if SERVER then
	if table.Count(self.DoorIDs) >= 1 then
		local doorIDs = ""
		for k,v in pairs(self.DoorIDs) do
			
			if k == 1 then
				doorIDs = tostring(v)
			else
				doorIDs = doorIDs..", "..tostring(v)
			end
		end
		self:GetOwner():ChatPrint("{"..doorIDs.."}")
		
		net.Start("doorID")
			net.WriteString("{"..doorIDs.."}")
		net.Send(self:GetOwner())
	end	
	
	self.DoorIDs = {}
end
end

net.Receive("doorID", function()

	local doorIDs = net.ReadString() or ""
	
	SetClipboardText(tostring(doorIDs))
end)