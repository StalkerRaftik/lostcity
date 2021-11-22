AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()

  self:SetModel(self.Model)

  self:PhysicsInit( SOLID_VPHYSICS )
  self:SetUseType( SIMPLE_USE )
    local phys = self:GetPhysicsObject()
    if phys then phys:Wake() end
  --
  self:SetPages(self.StartPages)
  --
  self.NextUse = 0
  self.NextLoaded = 0
  self.NextSound = 0
  self:SetHealth(25)
  --

  if self.JSONKEY then 
   self.Pages = util.JSONToTable(self.JSONKEY)
  else
   self.Pages = {
    Title = "Блокнот",
    Pages = {},   
    ActivePage = 1,
    Baked = false,
   }

   for i = 1,self:GetPages()  do
    self.Pages.Pages[i] = {
     Title = "Страница " .. i,
     Content = "Пустая страница",
     Paint = {}
    }
   end
  end


end

function ENT:SetBakedInfo(title, content)
  self.Pages.Pages[1].Title = title
  self.Pages.Pages[1].Content = content
  self.Pages.Baked = true
end

function ENT:Think() 
 if not self:GetWriter():IsValid() or not self:GetWriter():Alive() then self:SetWriter(nil) return end
 self:NextThink(CurTime() + 1)
end

function ENT:OnTakeDamage(dmg)
 self:SetHealth(self:Health() - dmg:GetDamage())
 if self:Health() <= 0 then 
  local Prop = ents.Create("prop_physics")
   Prop:SetModel(self:GetModel())
   Prop:SetPos(self:GetPos())
   Prop:SetAngles(self:GetAngles())
   Prop:Spawn()
   Prop:TakePhysicsDamage(dmg)
   Prop:SetColor(Color(100,100,100))
   sound.Play("Wood.Break",Prop:GetPos())

  SafeRemoveEntityDelayed(Prop,math.random(10,20))
  self:Remove()
  return
 end

 self:TakePhysicsDamage(dmg)
end

function ENT:PhysicsCollide(data,phys)
  if data.Speed > 50 then self:EmitSound(Sound("Wood_Box.ImpactSoft")) end

  if self:GetWriter():IsValid() or self.NextLoaded > CurTime() then return end

 local Ent = data.HitEntity 
 if Ent:GetClass() == "ent_notpead_page" and self:GetPages() + 1 <= self.LimitPages then
  sound.Play(Sound(Notepad.Sounds["leaf"][math.random(1,#Notepad.Sounds["leaf"])]),Ent:GetPos())
  Ent:Remove()
  self.NextLoaded = CurTime() + 1
  self:SetPages(self:GetPages() + 1)
  self.Pages.Pages[self:GetPages()] = {
    Title = "Страница " .. self:GetPages(),
    Content = "Пустая страница",
    Paint = {}
  }

 end

end

function ENT:Use(ply)
if self.NextUse > CurTime() or self:GetWriter():IsValid() then return end
 self.NextUse = CurTime() + 2
 
 if not self.Pages.Baked then self:SetWriter(ply) end

 net.Start("net_notepad_send")
  net.WriteEntity(self.Entity)
  net.WriteTable({
   Title = self.Pages.Title,
   Baked = self.Pages.Baked,
   ActivePage = self.Pages.ActivePage,
   Pages = {},
  })
  net.Send(ply)
 ---

 local Count = 1
 timer.Create("NOTEPAD_SENDING_" .. self.Entity:EntIndex(),0.01,#self.Pages.Pages,function()
  if not self.Entity:IsValid() then return end

  net.Start("net_notepad_sending")
   net.WriteTable(self.Pages.Pages[Count])
   net.Send(ply)

  if Count == #self.Pages.Pages then ply:ConCommand("cl_nt_open") else Count = Count + 1 end
 end)

end
