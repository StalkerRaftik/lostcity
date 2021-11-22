ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Записка"
ENT.Category = "RP"

ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:Use( pActivator, pCaller )
	umsg.Start( "OpenEditDerma", pActivator );
		umsg.Entity(self)
		umsg.Entity(pActivator)
	umsg.End()
end

function ENT:SetupDataTables()
	self:NetworkVar( "String", 0, "Text" );
end

function SaveText( Player, Entity, Data )
	if (SERVER) then
		if (Data.text) then
			Entity:SetText(Data.text)
		end
		duplicator.StoreEntityModifier( Entity, "SignText", Data )
	end
end
duplicator.RegisterEntityModifier( "SignText", SaveText )