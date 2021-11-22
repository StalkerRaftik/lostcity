if SERVER then
	AddCSLuaFile()
end

SWEP.PrintName			= "Пустые руки/ключи"
SWEP.ViewModel			= "models/weapons/c_medkit.mdl"
SWEP.WorldModel			= ""

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

local bell = {
	sound = Sound('ambient/alarms/warningbell1.wav'),
	delay = 10
}

local knock = {
	sound = Sound('physics/wood/wood_crate_impact_hard2.wav'),
	delay = 5
}

local LockDoor
local CarLockDoor

function SWEP:Initialize()
	self:SetHoldType( "normal" )

	self.Time = 0
	self.Range = 150

	PrimarySound = {
		Sound('npc/metropolice/gear1.wav'),
		Sound('npc/metropolice/gear2.wav'),
		Sound('npc/metropolice/gear3.wav'),
		Sound('npc/metropolice/gear4.wav'),
		Sound('npc/metropolice/gear5.wav'),
		Sound('npc/metropolice/gear6.wav')
	}

end

function SWEP:Deploy()
	if timer.Exists("KeyHands") then timer.Remove("KeyHands") end -- Fucking SWEP function order
	if not self.UseHands then self.UseHands = true end
	timer.Create("KeyHands", 1, 1, function() self.UseHands = false end)
end

function SWEP:Think()
	if self.Drag and (not self.Owner:KeyDown(IN_ATTACK) or not IsValid(self.Drag.Entity)) then
		self.Drag = nil
	end
  if self.Drag then
    self:SetHoldType( "magic" )
  else
    self:SetHoldType( "normal" )
  end
end

local knocksound = Sound('physics/wood/wood_crate_impact_hard2.wav')
function SWEP:PrimaryAttack()
	local Pos = self.Owner:GetShootPos()
	local Aim = self.Owner:GetAimVector()
	local ply = self.Owner

	local Tr = util.TraceLine{
		start = Pos,
		endpos = Pos +Aim *self.Range/2,
		filter = player.GetAll(),
	}

	local HitEnt = Tr.Entity

	if SERVER then
		if not self.Drag and IsValid( HitEnt ) then
			if HitEnt:IsVehicle() and HitEnt.__WCDOwner == self.Owner and (HitEnt.TrunkLocked ~= true or HitEnt.Locked ~= true) then
				local vPosition = Vector( HitEnt:OBBCenter()[1], HitEnt:OBBMins()[2], 10 )
				vPosition = HitEnt:LocalToWorld( vPosition)
				if (ply:GetPos():DistToSqr(vPosition) <= 2000) then
					HitEnt.TrunkLocked = true
					ply:SendSystemMessage("Замок багажника", 'Вы закрыли багажник')
					net.Start("DoAnimation")
					net.WriteEntity(ply)
					net.WriteFloat(ACT_GMOD_GESTURE_ITEM_PLACE)
					net.Broadcast()
					ply:EmitSound(PrimarySound[math.random(1,6)])
					HitEnt:SetNVar("TrunkLocked", true, NETWORK_PROTOCOL_PUBLIC)
				elseif HitEnt.Locked == false then
					HitEnt.Locked = true
					ply:SendSystemMessage("Замок", 'Вы закрыли машину')
					net.Start("DoAnimation")
					net.WriteEntity(ply)
					net.WriteFloat(ACT_GMOD_GESTURE_ITEM_PLACE)
					net.Broadcast()
					ply:EmitSound(PrimarySound[math.random(1,6)])
				end
			elseif HitEnt:DoorGetGroup() ~= nil then
				if HitEnt.Locked == false and self.Owner:GetFraction() ~= nil and self.Owner:GetFraction().Name == HitEnt:DoorGetGroup() then
					HitEnt:DoorLock(true)
					ply:SendSystemMessage("Замок", 'Вы закрыли дверь')
					net.Start("DoAnimation")
					net.WriteEntity(ply)
					net.WriteFloat(ACT_GMOD_GESTURE_ITEM_PLACE)
					net.Broadcast()
					ply:EmitSound(PrimarySound[math.random(1,6)])

				elseif (self.Owner:GetFraction() == nil or ply:GetFraction().Name ~= HitEnt:DoorGetGroup()) and (not HitEnt.NextKnock or HitEnt.NextKnock <= CurTime()) then
					self.Owner:EmitSound(knocksound, 100, math.random(90, 110))
					HitEnt.NextKnock = CurTime() + 0.4
					net.Start("DoAnimation")
					net.WriteEntity(ply)
					net.WriteFloat(ACT_HL2MP_GESTURE_RANGE_ATTACK_FIST)
					net.Broadcast()
				end
			end
			-- return
		end
	end

	if self.Drag then
		HitEnt = self.Drag.Entity
	else
		if not IsValid( HitEnt ) or HitEnt:GetMoveType() ~= MOVETYPE_VPHYSICS or
		HitEnt:IsVehicle() or HitEnt:GetNWBool( "NoDrag", false ) or
	    HitEnt:GetModel() == "models/braxen/wall_door.mdl" or
		HitEnt.BlockDrag or
		IsValid( HitEnt:GetParent() ) then
			return
		end

		if not self.Drag then
			self.Drag = {
				OffPos = HitEnt:WorldToLocal(Tr.HitPos),
				Entity = HitEnt,
				Fraction = Tr.Fraction,
			}
		end
	end



	if CLIENT or not IsValid( HitEnt ) then return end

	local Phys = HitEnt:GetPhysicsObject()

	if IsValid( Phys ) then
		local Pos2 = Pos +Aim *self.Range *self.Drag.Fraction
		local OffPos = HitEnt:LocalToWorld( self.Drag.OffPos )
		local Dif = Pos2 -OffPos
		local Nom = (Dif:GetNormal() *math.min(1, Dif:Length() /100) *500 -Phys:GetVelocity()) *Phys:GetMass()

		Phys:ApplyForceOffset( Nom, OffPos )
		Phys:AddAngleVelocity( -Phys:GetAngleVelocity() /4 )
	end

end


function SWEP:SecondaryAttack()
	local Pos = self.Owner:GetShootPos()
	local Aim = self.Owner:GetAimVector()
	local ply = self.Owner

	local Tr = util.TraceLine{
		start = Pos,
		endpos = Pos +Aim *self.Range/2,
		filter = player.GetAll(),
	}

	local HitEnt = Tr.Entity
	if SERVER then
		if IsValid( HitEnt ) then
			if HitEnt:IsVehicle() and HitEnt.__WCDOwner == self.Owner and (HitEnt.TrunkLocked ~= false or HitEnt.Locked ~= false) then
				local vPosition = Vector( HitEnt:OBBCenter()[1], HitEnt:OBBMins()[2], 10 )
				vPosition = HitEnt:LocalToWorld( vPosition)
				if (ply:GetPos():DistToSqr(vPosition) <= 2000) then
					HitEnt.TrunkLocked = false
					ply:SendSystemMessage("Замок багажника", 'Вы открыли багажник')
					net.Start("DoAnimation")
					net.WriteEntity(ply)
					net.WriteFloat(ACT_GMOD_GESTURE_ITEM_PLACE)
					net.Broadcast()
					ply:EmitSound(PrimarySound[math.random(1,6)])
					HitEnt:SetNVar("TrunkLocked", false, NETWORK_PROTOCOL_PUBLIC)
				elseif HitEnt.Locked == true then
					HitEnt.Locked = false
					ply:SendSystemMessage("Замок", 'Вы открыли машину')
					net.Start("DoAnimation")
					net.WriteEntity(ply)
					net.WriteFloat(ACT_GMOD_GESTURE_ITEM_PLACE)
					net.Broadcast()
					ply:EmitSound(PrimarySound[math.random(1,6)])					
				end
			elseif HitEnt.Locked == true and HitEnt:DoorGetGroup() ~= nil and ply:GetFraction() ~= nil and ply:GetFraction().Name == HitEnt:DoorGetGroup() then
				HitEnt:DoorLock(false)
				ply:SendSystemMessage("Замок", 'Вы открыли дверь')
				net.Start("DoAnimation")
				net.WriteEntity(ply)
				net.WriteFloat(ACT_GMOD_GESTURE_ITEM_PLACE)
				net.Broadcast()
				ply:EmitSound(PrimarySound[math.random(1,6)])
			end
			return
		end
	end
	-- if CLIENT then return end
	-- if IsValid( self.Owner:GetVehicle() ) then return end
end

if CLIENT then
	local x, y = ScrW() /2, ScrH() /2
	local MainCol = Color( 255, 255, 255, 255 )
	local Col = Color( 255, 255, 255, 255 )

	function SWEP:DrawHUD()
		if IsValid( self.Owner:GetVehicle() ) then return end
		local Pos = self.Owner:GetShootPos()
		local Aim = self.Owner:GetAimVector()

		local Tr = util.TraceLine{
			start = Pos,
			endpos = Pos +Aim *self.Range,
			filter = player.GetAll(),
		}

		local HitEnt = Tr.Entity
		if IsValid( HitEnt ) and
			not self.rDag and
			not HitEnt:IsVehicle() and
			not IsValid( HitEnt:GetParent() ) and
      not string.StartWith(HitEnt:GetClass(), "prop_") and
	  not HitEnt:GetClass() == "models/props/generic/corpses01.mdl" and
      not HitEnt:GetModel() == "models/braxen/wall_door.mdl" and
      not string.StartWith(HitEnt:GetClass(), "ent_bank") and
			not HitEnt:GetNWBool( "NoDrag", false ) then

			self.Time = math.min( 1, self.Time +2 *FrameTime() )
		else
			self.Time = math.max( 0, self.Time -2 *FrameTime() )
		end

    if self.Time > 0 then
      LocalPlayer().HandInteract = true
    else
      LocalPlayer().HandInteract = false
    end
		if self.Drag then
      LocalPlayer().Draging = true
    else
      LocalPlayer().Draging = false
    end
    local drawPos = util.TraceLine{
      start = LocalPlayer():GetShootPos(),
      endpos = LocalPlayer():GetShootPos() +(LocalPlayer():GetAimVector() *9e9),
      filter = LocalPlayer(),
      mask = MASK_SHOT,
    }.HitPos:ToScreen()
    if self.Drag and IsValid( self.Drag.Entity ) then
      local Pos2 = drawPos
      local OffPos = self.Drag.Entity:LocalToWorld( self.Drag.OffPos )
      -- local Dif = Pos2 -OffPos

      local A = OffPos:ToScreen()
      local B = Pos2

      surface.DrawRect( A.x -2, A.y -2, 4, 4, MainCol )
      surface.DrawRect( B.x -2, B.y -2, 4, 4, MainCol )
      surface.DrawLine( A.x, A.y, B.x, B.y, MainCol )
    end
	end
end

function SWEP:OnRemove()
	if timer.Exists("KeyHands") then timer.Remove("KeyHands") end

	if not IsValid(self.Owner) then return end

	local vm = self.Owner:GetViewModel()
	if IsValid(vm) then vm:SetMaterial("") end
end


function SWEP:PreDrawViewModel( vm, pl, wep )
	return true
end