if SERVER then
	AddCSLuaFile()
end

SWEP.PrintName			= "Прибор для анализа крови"
SWEP.ViewModel			= "models/weapons/c_medkit.mdl"
SWEP.WorldModel			= "models/illusion/eftcontainers/gasanalyser.mdl"
SWEP.Spawnable = true
SWEP.AnimPrefix	 		= "rpg"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"
SWEP.HitDistance				= 70


function SWEP:Initialize()
	self:SetHoldType( "normal" )
	self.delay = 0
end

function SWEP:PrimaryAttack()
	if self.delay > CurTime() then return end
	self.delay = CurTime() + 0.3

	local Pos = self.Owner:GetShootPos()
	local Aim = self.Owner:GetAimVector()
	
	local Tr = util.TraceLine{
		start = Pos,
		endpos = Pos+Aim*self.HitDistance,
	}
	
	local ply = Tr.Entity
	local owner = self.Owner

	if CLIENT then return end

	if not ply or not ply:IsPlayer() then 
		DarkRP.notify(owner, 1, 4, "Вам некого сканировать")
		return
	end
	
	

	if owner:HaveItem(INV_ENTITY, "bloodexample_empty") then
		owner:ConCommand( "play buttons/blip1.wav" )
		local func = function(ply)
			owner:RemoveItem(INV_ENTITY, "bloodexample_empty")
			owner:AddItem(INV_ENTITY, "bloodexample_blood")
			owner:ChatPrint("Уровень облучения: " .. (ply.radiation or 0) .. " млЗв")
		end
		owner:StartProgressBar(3, func, "Беру образец крови человека напротив...")
	else
		DarkRP.notify(owner, 1, 4, "У вас нет пустой склянки для проведения анализа!")
		return false
	end
		
	

end

function SWEP:SecondaryAttack()
	if self.delay > CurTime() then return end
	self.delay = CurTime() + 0.3

	
	if CLIENT then return end

	local owner = self.Owner

	if owner:HaveItem(INV_ENTITY, "bloodexample_empty") then
		owner:ConCommand( "play buttons/blip1.wav" )
		local func = function(ply)
			owner:RemoveItem(INV_ENTITY, "bloodexample_empty")
			owner:AddItem(INV_ENTITY, "bloodexample_blood")
			owner:ChatPrint("Уровень облучения: " .. (owner.radiation or 0) .. " млЗв")
		end
		owner:StartProgressBar(3, func, "Беру свой образец крови...")
	else
		DarkRP.notify(owner, 1, 4, "У вас нет пустой склянки для проведения анализа!")
		return false
	end
		
	

end


function SWEP:PreDrawViewModel( vm, pl, wep )
	return true
end