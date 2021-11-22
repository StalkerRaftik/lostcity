AddCSLuaFile()
if SERVER then
    AddCSLuaFile("cl_init.lua")
end

/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				Downloading content from workshop
---------------------------------------------------------------------------------------------------------------------------------------------
*/	

/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				Config
---------------------------------------------------------------------------------------------------------------------------------------------
*/

SWEP.hitRequireForStun = 5;
SWEP.stunTime = 4;
SWEP.primaryFireDamage = 10;

SWEP.primaryFireDelay = 0.5;
SWEP.secondaryFireDelay = 2;
/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				Default SWEP config
---------------------------------------------------------------------------------------------------------------------------------------------
*/

SWEP.reloadCooldown = CurTime();
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.Author = ""
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.IconLetter = ""
SWEP.PrintName = "Полицейская Дубинка"
SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.AnimPrefix = "physgun"
SWEP.HoldType ="physgun"
SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Category = "LostCity Edged Weapons" 
SWEP.Slot              =      3
SWEP.SlotPos           =      2


SWEP.UseHands = true;
SWEP.ViewModel = Model("models/drover/baton.mdl");
SWEP.WorldModel = Model("models/drover/w_baton.mdl");

local SwingSound = Sound( "WeaponFrag.Throw" );
local HitSound = Sound( "Flesh.ImpactHard" );



SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""



/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				Initialize
---------------------------------------------------------------------------------------------------------------------------------------------
*/

function SWEP:Initialize()
    self:SetHoldType("melee");
end



function SWEP:SetupShield()

end

/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				Hook Can Drop Weapon
---------------------------------------------------------------------------------------------------------------------------------------------
*/

hook.Add("canDropWeapon", "NoDropPoliceBaton",function(ply, ent)
	if ent:GetClass() == "weapon_policebaton" then
		return false;
	end
end)

/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				Some functions
---------------------------------------------------------------------------------------------------------------------------------------------
*/


SWEP.menuButtons = {};
SWEP.menuButtons[1] = {}
SWEP.menuButtons[1].buttonText = "Выпустить из тюрьмы";
SWEP.menuButtons[1].left = true;
SWEP.menuButtons[1].func = function(owner,ent)
	if owner:GetPos():Distance(ent:GetPos()) > 150 then return end;
	if not ent:isArrested() then return end;
	ent:unArrest(owner);
end


SWEP.menuButtons[2] = {}
SWEP.menuButtons[2].buttonText = "Арестовать";
SWEP.menuButtons[2].left = false;
SWEP.menuButtons[2].func = function(owner,ent)
	if owner:GetPos():Distance(ent:GetPos()) > 150 then return end;
	if ent:isCP() then return end;
    if not IsValid(ent:isHandcuffed()) then DarkRP.notify(owner, 1, 4, "Человек не в наручниках, вы не можете его Арестовать") return end
	if not ent:isArrested() then 
	    ent:Arrest(owner, '')    
	    rp.Notify(ent, NOTIFY_ERROR, rp.Term('ArrestBatonArrested'), owner)
	    rp.Notify(owner, NOTIFY_GREEN, rp.Term('ArrestBatonYouArrested'), ent) 
	end;
end
-- SWEP.menuButtons[2] = {}
-- SWEP.menuButtons[2].buttonText = "Розыск";
-- SWEP.menuButtons[2].left = false;
-- SWEP.menuButtons[2].func = function(owner,ent)

-- end



-- SWEP.menuButtons[4] = {}
-- SWEP.menuButtons[4].buttonText = "Ордер";
-- SWEP.menuButtons[4].left = false;
-- SWEP.menuButtons[4].func = function(owner,ent)

-- end
/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				Reload
---------------------------------------------------------------------------------------------------------------------------------------------
*/

function SWEP:Reload()
	if self.reloadCooldown + 2 > CurTime() then return end;
	self.reloadCooldown = CurTime();
	if CLIENT then return end
	self.Weapon:SendWeaponAnim( ACT_VM_RELOAD);
end	


function SWEP:Draw()
	self:SendWeaponAnim(ACT_VM_DRAW);
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW);
end	

local drawMenu = false;
if CLIENT then
	hook.Add("PlayerBindPress","test1", function(ply,bind,pressed)
		local weap = ply:GetActiveWeapon();
		if weap == nil or weap == NULL or not IsValid(weap) or weap:GetClass() !="weapon_policebaton" then return end;
		if string.find(bind,"+reload") then 
			gui.EnableScreenClicker(true);
			weap.drawMenu = true;			
		end
	end)
	
	hook.Add("KeyRelease","test2",function(ply,key)
		local weap = ply:GetActiveWeapon();
		if weap == nil or weap == NULL or not IsValid(weap) or weap:GetClass() !="weapon_policebaton" then return end;
		if key == IN_RELOAD then
			gui.EnableScreenClicker(false);
			weap.drawMenu = false;
			net.Start("batondrawbut") net.SendToServer();
			
		end
	end)
	



end



/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				Baton Stun / Unstun
---------------------------------------------------------------------------------------------------------------------------------------------
*/
function SWEP:Stun(ply)
	local ang = ply:GetAngles();
	ply:SetEyeAngles(Angle(60,ang.y,ang.r));
	ply:Freeze(true);
	ply.stunnedBaton = true;
	ply:SetNWInt('batonstuntime',CurTime());
	net.Start("batonstunanim") net.WriteEntity(ply) net.WriteBool(true) net.Broadcast();
	timer.Create("unstunbatonstun"..tostring(ply:EntIndex()),self.stunTime,1,function()
		if IsValid(ply) then 
			ply:Freeze(false);
			ply.stunnedBaton = false;
			net.Start("batonstunanim") net.WriteEntity(ply) net.WriteBool(false) net.Broadcast();
		end
	end)
end


/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				Attack Player
---------------------------------------------------------------------------------------------------------------------------------------------
*/

function SWEP:AttackPlayer(ply)
	if not IsValid(ply) or not ply:IsPlayer() then return end;
	self.Owner:EmitSound(Sound("Flesh.ImpactHard"));
	ply:SetVelocity((ply:GetPos() - self:GetOwner():GetPos()) * 2);
	if ply.stunnedBaton == true then return end;
	local hits = ply.hitByBaton or 0;
	local lTime = ply.lastBatonHit or CurTime();
	if CurTime() > lTime + 3 then 
		hits = 0; 
	end
	local numb = 1;
	if ply:isArrested() then numb = 1000 end;
	ply.hitByBaton = hits + numb;
	ply.lastBatonHit = CurTime();
	if hits + numb >= self.hitRequireForStun then
		self:Stun(ply);
	end
end

/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				Attack Entity
---------------------------------------------------------------------------------------------------------------------------------------------
*/

function SWEP:AttackEnt(ent,dmg)
		self.Owner:EmitSound(Sound("physics/wood/wood_box_impact_hard3.wav"));
  --       if FPP and FPP.plyCanTouchEnt(self:GetOwner(), ent, "EntityDamage") then
		-- 	if ent.SeizeReward and not ent.beenSeized and not ent.burningup and self:GetOwner():isCP() and ent.Getowning_ent and self:GetOwner() ~= ent:Getowning_ent() then
		-- 		 self:GetOwner():addMoney(ent.SeizeReward);
		-- 		 DarkRP.notify(self:GetOwner(), 1, 4, DarkRP.getPhrase("you_received_x", DarkRP.formatMoney(ent.SeizeReward), DarkRP.getPhrase("bonus_destroying_entity")));
		-- 		ent.beenSeized = true;
		-- 	 end
  --        ent:TakeDamage(dmg, self:GetOwner(), self);
		-- end
  if ent.SeizeReward and ent.WantReason and self:GetOwner():IsCP() then
    self:GetOwner():EmitSound(Sound("physics/wood/wood_box_impact_hard3.wav"));
    local owner = ent.ItemOwner

    if IsValid(owner) and not ent.ItemOwner:IsWanted() then
      ent.ItemOwner:Wanted(self:GetOwner(), ent.WantReason)
    end

    ent:Remove()
    self:GetOwner():AddMoney(ent.SeizeReward)
    rp.Notify(self:GetOwner(), NOTIFY_GREEN, rp.Term('ArrestBatonBonus'), rp.FormatMoney(ent.SeizeReward))

    return
  end
end
/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				Make Hit
---------------------------------------------------------------------------------------------------------------------------------------------
*/
local entMeta = FindMetaTable("Entity");
function SWEP:MakeHit(dmg)
	self:GetOwner():SetAnimation(PLAYER_ATTACK1);
    if CLIENT then return end;
    local trace = util.QuickTrace(self:GetOwner():EyePos(), self:GetOwner():GetAimVector() * 90, {self:GetOwner()});
    
    if IsValid(trace.Entity) and trace.Entity:GetClass() == "func_breakable_surf" then
        trace.Entity:Fire("Shatter"); 
        return;
    end

	local ent = self:GetOwner():getEyeSightHitEntity(100, 15, fn.FAnd{fp{fn.Neq, self:GetOwner()}, fc{IsValid, entMeta.GetPhysicsObject}});
    if not IsValid(ent) then return end;
    if ent:IsPlayer() and not ent:Alive() then return end;

    

    if ent:IsPlayer() 	then
		self:AttackPlayer(ent);
		if dmg > 0 then
			ent:TakeDamage(dmg, self:GetOwner(), self);
		end
    elseif !ent:IsNPC() or !ent:IsVehicle() then
        self:AttackEnt(ent,dmg);
    end
end

/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				Primary attack
---------------------------------------------------------------------------------------------------------------------------------------------
*/

function SWEP:PrimaryAttack()
	self:SetHoldType("melee");
	self:SetNextPrimaryFire(CurTime() + self.primaryFireDelay);
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK );
	self:GetOwner():EmitSound(SwingSound);
	self:MakeHit(0);
	
end


/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				Secondary attack / Deploy static shield
---------------------------------------------------------------------------------------------------------------------------------------------
*/
function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire(CurTime() + self.secondaryFireDelay);
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK );
	self:GetOwner():EmitSound(SwingSound);
	self:MakeHit(self.primaryFireDamage)
end

/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				Network initialize && Client Receive
---------------------------------------------------------------------------------------------------------------------------------------------
*/

if SERVER then
	util.AddNetworkString("batonstunanim");
	util.AddNetworkString("batonsendfunc");
	util.AddNetworkString("batondrawbut");
	
	
	net.Receive("batonsendfunc",function(leng,ply)
		local id = net.ReadInt(3);
		local enemy = net.ReadEntity();
		if not IsValid(enemy) or not enemy:IsPlayer() or not enemy:Alive() then return end;
		if ply:GetActiveWeapon():GetClass() != "weapon_policebaton" then return end;
		ply:GetActiveWeapon().menuButtons[id].func(ply,enemy);
	end)
	
	net.Receive("batondrawbut",function(leng,ply)
		local enemy = net.ReadEntity();
		if ply:GetActiveWeapon():GetClass() != "weapon_policebaton" then return end;
		ply:GetActiveWeapon():Draw();
	end)
end

if CLIENT then
	net.Receive("batonstunanim",function()
		local ply = net.ReadEntity();
		local enable = net.ReadBool();
		if IsValid(ply) and ply:IsPlayer() and ply:Alive() then
			if enable then
				ply:AnimRestartGesture( GESTURE_SLOT_CUSTOM,ACT_HL2MP_IDLE_SLAM, false);   
			else
				ply:AnimResetGestureSlot(GESTURE_SLOT_CUSTOM );
			end
		end	
	end)	
end


/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				Deploy && Holster && Drop && Remove
---------------------------------------------------------------------------------------------------------------------------------------------
*/




function SWEP:Deploy()
	return true
end

function SWEP:Holster()
	return true;
end


function SWEP:OnDrop()
	return true;
end

function SWEP:OnRemove()
	return true;
end


/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				Draw circles
---------------------------------------------------------------------------------------------------------------------------------------------
*/


/*------------------------------------------------------------------------
Donation for leaks

Qiwi Wallet         4890494419811120 
YandexMoney         410013095053302
WebMoney(WMR)       R235985364414
WebMoney(WMZ)       Z309855690994
------------------------------------------------------------------------*/
