AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()

  self:SetModel("models/props_junk/garbage_newspaper001a.mdl")
  self:SetModelScale(0.5,0)
  --
  self:PhysicsInit( SOLID_VPHYSICS )
  self:SetUseType( SIMPLE_USE )
    local phys = self:GetPhysicsObject()
    if phys then phys:Wake() end
  --
  self.NextUse = 0
  self:SetHealth(25)
  --

end

function ENT:PhysicsCollide(data,phys)
  if data.Speed > 50 then self:EmitSound(Sound("Cardboard.ImpactSoft")) end
end


function ENT:OnTakeDamage(dmg)
 self:SetHealth(self:Health() - dmg:GetDamage())
 if self:Health() <= 0 then 
  local Prop = ents.Create("prop_physics")
   Prop:SetModel(self:GetModel())
   Prop:SetPos(self:GetPos())
   Prop:SetAngles(self:GetAngles())
   Prop:Spawn()
   Prop:SetModelScale(0.5,0)
   Prop:TakePhysicsDamage(dmg)
   Prop:SetColor(Color(100,100,100))
   sound.Play("Cardboard.Break",Prop:GetPos())

  SafeRemoveEntityDelayed(Prop,math.random(10,20))
  self:Remove()
  return
 end

 self:TakePhysicsDamage(dmg)
end

function ENT:Use(ply)
  if ply:IsPlayerHolding() then return end
 ply:PickupObject(self.Entity)
 
end
