-- Jackarunda created this script in October 2015 and he claims no rights to it.
if(SERVER)then
	AddCSLuaFile()
end
if(CLIENT)then
	SWEP.PrintName="Электрошокер [Edged Weapons]"
	SWEP.Slot=2
	SWEP.SlotPos=1
	SWEP.DrawAmmo=false
	SWEP.DrawCrosshair=false
end
if(CLIENT)then SWEP.WepSelectIcon=surface.GetTextureID("vgui/wep_jack_job_drpstungun");SWEP.BounceWeaponIcon=false end
SWEP.Author="J.I. (Fixed By Tomato)"
SWEP.Instructions="Stun people to escape or capture."
SWEP.Contact=""
SWEP.Category = "LostCity Edged Weapons"
SWEP.Purpose=""
SWEP.HoldType="knife"
SWEP.ViewModel="models/weapons/c_taser_pillar.mdl"
SWEP.UseHands=true
SWEP.WorldModel="models/w_taser_pillar.mdl"
SWEP.ViewModelFOV=50
SWEP.ViewModelFlip=false
SWEP.AnimPrefix ="knife"
SWEP.Spawnable=true
SWEP.AdminSpawnable=true
SWEP.Primary.ClipSize=-1
SWEP.Primary.DefaultClip=0
SWEP.Primary.Automatic=true
SWEP.Primary.Ammo=""
SWEP.Secondary.ClipSize=-1
SWEP.Secondary.DefaultClip=0
SWEP.Secondary.Automatic=false
SWEP.Secondary.Ammo=""
SWEP.NextZap=0
function SWEP:SetupDataTables()
	self:NetworkVar("Bool",0,"Zappin")
end
function SWEP:Initialize()
	self:SetZappin(false)
	self:SetWeaponHoldType(self.HoldType)
end
function SWEP:PrimaryAttack()
	if(self:GetZappin())then return end
	if(CLIENT)then
		self:DoAnim("melee")
		self:SetNextPrimaryFire(CurTime()+1.5)
		self.Owner:SetAnimation(PLAYER_ATTACK1)
		return
	end
	self:SetZappin(true)
	self:DoAnim("melee")
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	timer.Simple(.6,function()
		if(IsValid(self))then
			self:SetZappin(false)
		end
	end)
	self:SetNextPrimaryFire(CurTime()+1.5)
end
function SWEP:Think()
	if(CLIENT)then return end
	if(self.NextZap<CurTime())then
		self.NextZap=CurTime()+.04
		if(self:GetZappin())then
			local Zap,Pos,Vec=EffectData(),self.Owner:GetShootPos(),self.Owner:GetAimVector()
			Zap:SetOrigin(Pos+Vec*40+self.Owner:GetRight()*5-self.Owner:GetUp()*4)
			Zap:SetScale(math.Rand(.075,.125))
			util.Effect("eff_jack_job_stunarc",Zap,true,true)
			sound.Play("snd_jack_job_stunarc.wav",self.Owner:GetShootPos(),70,math.random(90,110))
			self:Arc()
		end
	end
end
function SWEP:Arc()
	local Pos,Vec=self.Owner:GetShootPos(),self.Owner:GetAimVector()
	local Tr=util.QuickTrace(Pos,Vec*65,{self.Owner})
	if((Tr.Hit)and(Tr.Entity)and((Tr.Entity:IsPlayer())or(Tr.Entity:IsNPC())))then
		self:Stun(Tr.Entity,Tr.HitPos)
	end
	if(math.random(1,2)==1)then
		local zap=ents.Create("point_tesla")
		zap:SetKeyValue("targetname","teslab")
		zap:SetKeyValue("m_SoundName","")
		zap:SetKeyValue("texture","sprites/physbeam.spr")
		zap:SetKeyValue("m_Color","210 200 255")
		zap:SetKeyValue("m_flRadius","15")
		zap:SetKeyValue("beamcount_min","1")
		zap:SetKeyValue("beamcount_max","2")
		zap:SetKeyValue("thick_min",".1")
		zap:SetKeyValue("thick_max",".2")
		zap:SetKeyValue("lifetime_min",".01")
		zap:SetKeyValue("lifetime_max",".1")
		zap:SetKeyValue("interval_min",".01")
		zap:SetKeyValue("interval_max",".05")
		zap:SetPos(Pos+Vec*40+self.Owner:GetRight()*5-self.Owner:GetUp()*4)
		zap:Spawn()
		zap:Fire("DoSpark","",0)
		zap:Fire("kill","",.1)
	end
end
function SWEP:Stun(target,zapPos)
	if((target:IsPlayer())and(IsValid(target:GetRagdollEntity())))then return end
	local Dmg=DamageInfo()
	Dmg:SetDamageType(DMG_SHOCK)
	Dmg:SetDamagePosition(zapPos)
	Dmg:SetDamageForce(Vector(0,0,1000))
	Dmg:SetDamage(math.random(1,10))
	Dmg:SetAttacker(self.Owner)
	Dmg:SetInflictor(self.Weapon)
	target:TakeDamageInfo(Dmg)
	if((target:IsPlayer())and(target:Alive())and(math.random(1,3)==2))then
		target:CreateRagdoll()
		target:Freeze(true)
		target:SetNoDraw(true)
		target:GetActiveWeapon():SetNoDraw(true)
		--target:SpectateEntity(target:GetRagdollEntity())
		--target:Spectate(OBS_MODE_DEATHCAM)
		target:DrawViewModel(false)
		timer.Simple(math.random(3,6),function()
			if(IsValid(target))then
				local Rag=target:GetRagdollEntity()
				target:Freeze(false)
				target:SetNoDraw(false)
				if(IsValid(target:GetActiveWeapon()))then target:GetActiveWeapon():SetNoDraw(false) end
				--target:UnSpectate()
				--target:Spectate(OBS_MODE_NONE)
				target:DrawViewModel(true)
				if(IsValid(Rag))then
					SafeRemoveEntity(Rag)
				end
			end
		end)
	end
end
function SWEP:Deploy()
	self:SetNextPrimaryFire(CurTime()+1)
	self:DoAnim("draw")
	self:EmitSound("snd_jack_job_capcharge.wav",60,100)
end
function SWEP:SecondaryAttack()
	--
end
function SWEP:DoAnim(anim)
	local VM=self.Owner:GetViewModel()
	VM:SendViewModelMatchingSequence(VM:LookupSequence(anim))
end
if(CLIENT)then
	function SWEP:DrawWorldModel()
		if not(IsValid(self.Owner))then self:DrawModel() return end
		local Pos,Ang=self.Owner:GetBonePosition(self.Owner:LookupBone("ValveBiped.Bip01_R_Hand"))
		if(self.DatWorldModel)then
			if((Pos)and(Ang))then
				self.DatWorldModel:SetRenderOrigin(Pos+Ang:Forward()*4+Ang:Right()*2-Ang:Up()*2)
				Ang:RotateAroundAxis(Ang:Right(),120)
				--Ang:RotateAroundAxis(Ang:Right(),90)
				self.DatWorldModel:SetRenderAngles(Ang)
				self.DatWorldModel:DrawModel()
			end
		else
			self.DatWorldModel=ClientsideModel(self.WorldModel)
			self.DatWorldModel:SetPos(self:GetPos())
			self.DatWorldModel:SetParent(self)
			self.DatWorldModel:SetNoDraw(true)
			self.DatWorldModel:SetModelScale(.5,0)
		end
	end
end