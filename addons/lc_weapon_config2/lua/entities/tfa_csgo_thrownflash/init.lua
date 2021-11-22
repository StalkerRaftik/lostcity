AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	
	self.Entity:SetModel("models/weapons/tfa_csgo/w_eq_flashbang_thrown.mdl")
	
	self:PhysicsInit(SOLID_VPHYSICS)
	--self.Entity:PhysicsInitSphere( ( self:OBBMaxs() - self:OBBMins() ):Length()/4, "metal" )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:DrawShadow( false )
	self.Entity:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	
	self:EmitSound("TFA_CSGO_Flashbang.Throw")
	
	self.timeleft = CurTime() + 2 -- HOW LONG BEFORE EXPLOSION
	
	if SERVER then
		timer.Simple(30,function()
			if IsValid(self) then
				self:Remove()
			end
		end)
	end
	
	self:Think()
end

 function ENT:Think()
	
	if self.timeleft < CurTime() and !self.deactivated then
		self:Explosion()	
	end

	self.Entity:NextThink( CurTime() )
	return true
end

function ENT:EntityFacingFactor( theirent )
	local dir = theirent:EyeAngles():Forward()
	local facingdir = (self:GetPos() - (theirent.GetShootPos and theirent:GetShootPos() or theirent:GetPos())):GetNormalized()
	return (facingdir:Dot(dir)+1)/2
end

function ENT:EntityFacingUs( theirent )
	local dir = theirent:EyeAngles():Forward()
	local facingdir = (self:GetPos()-(theirent.GetShootPos and theirent:GetShootPos() or theirent:GetPos())):GetNormalized()
	if facingdir:Dot(dir)>-0.25 then return true end
end


function ENT:Explosion()
	self:EmitSound("TFA_CSGO_FLASHGRENADE.BOOM")
	local tr = {}
	tr.start = self:GetPos()
	tr.mask = MASK_SOLID
	for k,v in pairs(player.GetAll()) do
		tr.endpos = v:GetShootPos()
		tr.filter = { self, v, v:GetActiveWeapon() }
		local traceres = util.TraceLine(tr)
		if !traceres.Hit or traceres.Fraction>=1 or traceres.Fraction<=0 then
			v:SetNWFloat("LastFlash",CurTime())
			v:SetNWFloat("FlashDistance",v:GetShootPos():Distance(self:GetPos()))
			v:SetNWFloat("FlashFactor",self:EntityFacingFactor(v))
			if v:GetNWFloat("FlashDistance",v:GetShootPos():Distance(self:GetPos())) < 1500 and v:GetNWFloat("FlashFactor",self:EntityFacingFactor(v)) < tr.endpos:Distance(self:GetPos(v)) then
				if v:GetNWFloat("FlashDistance",v:GetShootPos():Distance(self:GetPos())) < 1000 then
					v:SetDSP( 37 , false )
				elseif v:GetNWFloat("FlashDistance",v:GetShootPos():Distance(self:GetPos())) < 800 then
					v:SetDSP( 36 , false )
				elseif v:GetNWFloat("FlashDistance",v:GetShootPos():Distance(self:GetPos())) < 600 then
					v:SetDSP( 35, false )	
				end
			end
		end
	end
	
	for k,v in pairs(ents.FindByClass("npc_*")) do
		if self:EntityFacingUs(v) then
			tr.endpos = v.GetShootPos and v:GetShootPos() or v:GetPos()
			tr.filter = { self, v, v.GetActiveWeapon and v:GetActiveWeapon() or v}
			local traceres = util.TraceLine(tr)
			if !traceres.Hit or traceres.Fraction>=1 or traceres.Fraction<=0 then
				
				local flashdistance = tr.endpos:Distance(self:GetPos())
				local flashtime = CurTime()
				
				local distancefac = ( 1-math.Clamp((flashdistance-csgo_flashdistance+csgo_flashdistancefade)/csgo_flashdistancefade,0,1) )
				local intensity = ( 1-math.Clamp(((CurTime()-flashtime)/distancefac-csgo_flashtime+csgo_flashfade)/csgo_flashfade,0,1) )
				
				if intensity>0.8 then
					if v.ClearSchedule then
						v:ClearSchedule()
					end
					if v.SetEnemy then
						v:SetEnemy(nil)
					end
					if v.AddEntityRelationship and IsValid(self.Owner) then
						local oldrel = v.GetRelationship and v:GetRelationship(self.Owner) or ( ( IsFriendEntityName( v:GetClass() ) and !game.GetMap()=="gm_raid" ) and D_LI or D_HT )
						v:AddEntityRelationship( self.Owner, D_NU, 99)
						timer.Simple(csgo_flashtime/2, function()
							if IsValid(v) and v:IsNPC() and IsValid(self) and IsValid(self.Owner) then
								v:AddEntityRelationship( self.Owner, oldrel, 99)
							end
						end)
					end
					if v.ClearEnemyMemory then
						v:ClearEnemyMemory()
					end
				end
			end
		end
	end
	
	
	
	self.deactivated = true
end

/*---------------------------------------------------------
OnTakeDamage
---------------------------------------------------------*/
function ENT:OnTakeDamage( dmginfo )
end


/*---------------------------------------------------------
Use
---------------------------------------------------------*/
function ENT:Use( activator, caller, type, value )
end


/*---------------------------------------------------------
StartTouch
---------------------------------------------------------*/
function ENT:StartTouch( entity )
end


/*---------------------------------------------------------
EndTouch
---------------------------------------------------------*/
function ENT:EndTouch( entity )
end


/*---------------------------------------------------------
Touch
---------------------------------------------------------*/
function ENT:Touch( entity )
end