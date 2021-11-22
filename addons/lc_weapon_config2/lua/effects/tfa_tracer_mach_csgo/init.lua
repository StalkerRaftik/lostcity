TRACER_FLAG_USEATTACHMENT       = 0x0002;
SOUND_FROM_WORLD                        = 0;
CHAN_STATIC                                     = 6;

EFFECT.InValid = false;
EFFECT.ParticleName = "weapon_tracers_mach"

function EFFECT:Init( data )	

		self.Position = data:GetStart()
		self.WeaponEnt = data:GetEntity()
		self.WeaponEntOG = self.WeaponEnt
		self.Attachment = data:GetAttachment()
		
		-- Keep the start and end pos - we're going to interpolate between them
		self.StartPos = self:GetTracerShootPos( self.Position, self.WeaponEnt, self.Attachment )
		
        self.EndPos = data:GetOrigin()
		
        util.ParticleTracerEx(self.ParticleName, self.StartPos, self.EndPos, false, self:EntIndex(), self.Attachment)

end

function EFFECT:Think()
 
        return false
 
end

function EFFECT:Render()
		
		if self.InValid then return false end
		
end