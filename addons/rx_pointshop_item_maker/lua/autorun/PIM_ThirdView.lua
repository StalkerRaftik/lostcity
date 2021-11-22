ThirdPerson = {}

if CLIENT then
	hook.Add("CalcView", "PIM ThirdView", function( ply, origin, angles, fov )
		if PIM_EditorPanel and PIM_EditorPanel:IsValid() then
					// =============== PlayerBack Cam

						local Height = PIM_EditorPanel.Height
						local Zoom = PIM_EditorPanel.Zoom
						local CamAngle = PIM_EditorPanel.CamAngle
						
						local offset = Vector(0,0,60)

							origin = ply:GetPos() + CamAngle:Forward() * Zoom + Vector(0,0,Height)
							angles = (ply:GetPos()+Vector(0,0,Height)-origin):Angle()

						return GAMEMODE:CalcView(ply, origin, angles, fov)
					// =============== PlayerBack Cam
		end
	end)
end

if SERVER then

concommand.Add("PIM_DisableTV",function(ply,cmd,args)
	PIM_DisableThirdView(ply)
end)
concommand.Add("PIM_EnableTV",function(ply,cmd,args)
	PIM_EnableThirdView(ply)
end)

function PIM_EnableThirdView( ply )
	local entity = ents.Create("prop_dynamic")
	entity:SetModel("models/props_junk/garbage_metalcan001a.mdl")
	entity:Spawn()
	entity:SetAngles(ply:GetAngles())
	entity:SetMoveType(MOVETYPE_NONE)
	entity:SetColor(0,0,0,0)
	entity:DrawShadow(false)
	entity:SetParent(ply)
	entity:SetPos(ply:GetPos() + Vector(0, 0, 60))
	entity:SetRenderMode(RENDERMODE_NONE)
	entity:SetSolid(SOLID_NONE)
	ply:SetViewEntity(entity)
	ply.PIM_ThirdViewEnt = entity
	ply:SetNWEntity("PIM3ViewEnt",entity)
	ply:Freeze(true)
end

function PIM_DisableThirdView( ply )
	ply:SetViewEntity()
	if ply.PIM_ThirdViewEnt and ply.PIM_ThirdViewEnt:IsValid() then
		ply.PIM_ThirdViewEnt:Remove()
		ply.PIM_ThirdViewEnt = nil
		ply:Freeze(false)
	end	
end

end
