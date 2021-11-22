TRACER_FLAG_USEATTACHMENT       = 0x0002;
SOUND_FROM_WORLD                        = 0;
CHAN_STATIC                                     = 6;

EFFECT.InValid = false;
EFFECT.ParticleName = "weapon_tracers"

function EFFECT:FindTracer( wep )
	if not IsValid(wep) then
		return "weapon_tracers"
	end

	local ammotype =  (wep.Primary.Ammo or wep:GetPrimaryAmmoType()):lower()
	local guntype = (wep.Type or wep:GetHoldType()):lower()

	if guntype:find("sniper") or ammotype:find("sniper") or guntype:find("dmr") then
		return "weapon_tracers_rifle"
	elseif guntype:find("rifle") or ammotype:find("rifle") then
		return "weapon_tracers_rifle"
	elseif ammotype:find("pist") or guntype:find("pist") then
		return "weapon_tracers_pistol"
	elseif ammotype:find("smg") or guntype:find("smg") then
		return "weapon_tracers_smg"
	elseif ammotype:find("buckshot") or ammotype:find("shotgun") or guntype:find("shot") then
		return "weapon_tracers_shot"
	end
	return "weapon_tracers"
end

function EFFECT:Init( data )	

		self.Position = data:GetStart()
		self.WeaponEnt = data:GetEntity()
		self.WeaponEntOG = self.WeaponEnt
		self.Attachment = data:GetAttachment()
		
		-- Keep the start and end pos - we're going to interpolate between them
		self.StartPos = self:GetTracerShootPos( self.Position, self.WeaponEnt, self.Attachment )
		
        self.EndPos = data:GetOrigin()
		
		self.ParticleName = self:FindTracer(self.WeaponEntOG)
		
        util.ParticleTracerEx(self.ParticleName, self.StartPos, self.EndPos, false, self:EntIndex(), self.Attachment)

end

function EFFECT:Think()
 
        return false
 
end

function EFFECT:Render()
		
		if self.InValid then return false end
		
end