rp.Fractions = rp.Fractions or {}

function GetFractionKit(kitGrade)
	net.Start("rp.Fractions.Network")
		net.WriteUInt(kitGrade, 3)
	net.SendToServer()
end

-- HUD for props, visible for leaders only in building mode
hook.Add("HUDPaint", "rp.Fractions.PropsView", function()
	if LocalPlayer() == nil or LocalPlayer():GetJob() == nil then return end
	if not LocalPlayer():IsCharLoaded() then return end
	if LocalPlayer():GetNVar("BuildingMode") == false then return end

	local fraction = rp.teams[LocalPlayer():GetJob()].category

	if (rp.teams[LocalPlayer():GetJob()].leader == true) or (rp.teams[LocalPlayer():GetJob()].subleader == true) then

		for k, p in pairs(ents.GetAll()) do
			if not IsValid(p) then continue end
				if p:GetClass() != "prop_physics" then continue end
				if fraction and (p:GetNVar("PropFraction") == fraction) then 
					
				local ppos = p:LocalToWorld( p:OBBCenter() )
		
				-- if ppos:DistToSqr(EyePos()) > 300000 then continue end
		
				local pos = ppos:ToScreen()
		
				local mins, maxs = p:OBBMins(), p:OBBMaxs()

				local col 
				--Прорисовывание сетки
				if p:GetNVar('PropFractionSave') == true then
					col = Color(100,255,50)
					draw.ShadowSimpleText( fraction, "font_base_18", pos.x+1, pos.y-15, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
					draw.ShadowSimpleText( "Сохранён", "font_base_18", pos.x, pos.y, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				else
					col = Color(255,50,50)
					draw.ShadowSimpleText( fraction, "font_base_18", pos.x+1, pos.y-15, Color(150,150,150), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
					draw.ShadowSimpleText( "Не сохранён", "font_base_18", pos.x, pos.y, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				end
				cam.Start3D(EyePos(), EyeAngles())
					render.SetBlend( 0.5 )
					render.DrawWireframeBox( p:GetPos(), p:GetAngles(), mins, maxs, col, true)
					render.SetBlend( 1 )
				cam.End3D()
			end
		end
	end
end)

--- C Menu
properties.Add('frPropSave', {
	MenuLabel = 'Сохранить проп для фракции',
	Order = 2003,
	MenuIcon = 'icon16/brick_add.png',
	Filter = function(self, ent, pl)
		if ent:IsPlayer() then return false end
		if (rp.teams[pl:GetJob()].leader == true) or (rp.teams[pl:GetJob()].subleader == true) then return true else return false end
	end,
	Action = function(self, ent)
		if not IsValid(ent) then return end
		rp.RunCommand('savefrprop', ent:EntIndex())
	end
})

properties.Add('frPropUnSave', {
	MenuLabel = 'Отменить сохранение пропа для фракции',
	Order = 2004,
	MenuIcon = 'icon16/brick_edit.png',
	Filter = function(self, ent, pl)
		if ent:IsPlayer() then return false end
		if (rp.teams[pl:GetJob()].leader == true) or (rp.teams[pl:GetJob()].subleader == true) then return true else return false end
	end,
	Action = function(self, ent)
		if not IsValid(ent) then return end
		rp.RunCommand('unsavefrprop', ent:EntIndex())
	end
})

properties.Add('frPropRemove', {
	MenuLabel = 'Удалить проп для фракции',
	Order = 2005,
	MenuIcon = 'icon16/brick_delete.png',
	Filter = function(self, ent, pl)
		if ent:IsPlayer() then return false end
		if (rp.teams[pl:GetJob()].leader == true) or (rp.teams[pl:GetJob()].subleader == true) then return true else return false end
	end,
	Action = function(self, ent)
		if not IsValid(ent) then return end
		rp.RunCommand('removefrprop', ent:EntIndex())
	end
})