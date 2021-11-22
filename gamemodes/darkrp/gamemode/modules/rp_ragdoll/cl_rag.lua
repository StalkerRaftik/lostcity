
local cs_ent
do
  local function cs_ent_apply(self, data)
    self:SetModel(data.model)
    self:SetMaterial(data.material)
    self:SetModelScale(data.scale, 0)
    self:SetSkin(data.skin)

    if data.item.vmatrix then
      self:EnableMatrix('RenderMultiply', data.item.vmatrix)
    end
  end

  local function cs_ent_postdraw(self, data)
    if data.item.vmatrix then
      self:DisableMatrix('RenderMultiply')
    end
  end
  function CosmeticsRagget_csent()
    cs_ent = cs_ent or ClientsideModel('models/props_junk/garbage_plasticbottle003a.mdl', RENDERGROUP_OPAQUE)
    CosmeticsRaggetcs_ent = cs_ent

    cs_ent.noerrcleanse = true

    cs_ent:SetNoDraw(false)
    cs_ent:DrawShadow(false)

    cs_ent.apply = cs_ent.apply or cs_ent_apply
    cs_ent.post_draw = cs_ent.post_draw or cs_ent_postdraw

    return cs_ent
  end
end

function ENTITY:MergeRagdollBones( ent )
	self:SetParent( ent )
	self:SetLocalPos( Vector( 0, 0, 0 ) )
	self:AddEffects( EF_BONEMERGE )

	if (ent and IsValid(ent)) then
		for k = 0, ent:GetBoneCount() - 1 do
			self:FollowBone(ent,k)
		end
	end
end

netstream.Hook("UpdateRagdollClothes", function(data)
  local tblClothes = data.tblClothes
  local eRagdoll = data.eRagdoll
  local pPlayer = data.pPlayer
  pPlayer.eRagdoll = eRagdoll
  pPlayer.eRagdoll.Cosmetics = tblClothes
  eRagdoll.ActiveC = eRagdoll.ActiveC or {}
  eRagdoll.ActiveC[eRagdoll] = eRagdoll.ActiveC[eRagdoll] or {}
  ply = eRagdoll
  if (tblClothes) then
      if not eRagdoll.Cosmetics then return end

      for _, cos in pairs(eRagdoll.Cosmetics) do
        local item = {}

        local itemdata = Cosmetics.Items[cos]

        if not itemdata then continue end

        local scale = itemdata.scale or 1
        if Cosmetics.Mod[eRagdoll:GetModel()] and Cosmetics.Mod[eRagdoll:GetModel()][cos] then
          scale = Cosmetics.Mod[eRagdoll:GetModel()][cos].scale or scale
        end

        item.entity = {model = itemdata.model}
        item.entity.item = item

        item.entity.scale = scale * eRagdoll:GetModelScale()
        item.entity.skin = itemdata.skin or 0

        -- todo
        -- if itemdata.particle then
        --   local tn = "CosmeticEffect" .. eRagdoll:UniqueID() .. cos
        --   item.emitter = ParticleEmitter( item.entity:GetPos(), false )
        --   timer.Create(tn, itemdata.particlespeed, 0, function()
        --     if not IsValid( item.entity ) then timer.Remove(tn) return end

        --     itemdata.particle( item.entity, item.emitter )

        --   end)

        -- end

        if itemdata.matrix then
          item.vmatrix = Matrix()
          item.vmatrix:Scale(itemdata.matrix)
        end

        if itemdata.hide_hair then
          eRagdoll.hide_hair = true
        end

        if itemdata.hide_facialhair then
          eRagdoll.hide_facialhair = true
        end

        if itemdata.hide_head then
          eRagdoll.hide_head = true
        end

        if itemdata.animation then
          item.entity.anim = itemdata.animation
        end

        item.type = cos
        table.insert(eRagdoll.ActiveC[eRagdoll], item)
    end
    if not eRagdoll.ActiveC[eRagdoll] then
      return
    end
    local cEnt = CosmeticsRagget_csent()
    hook.Add("Tick", "UpdateRagdollClothesDrawing", function()
    if not IsValid(eRagdoll) then 
      if IsValid(cEnt) then cEnt:Remove() end
      return false 
    end
    if eRagdoll.ActiveC[eRagdoll] and #eRagdoll.ActiveC[eRagdoll] > 0 then

      

      for _, cos in pairs(eRagdoll.ActiveC[eRagdoll]) do
        cs_ent:apply(cos.entity)

        local cType = cos.type

        --print(ply, cType, cEnt)

        local itemdata = Cosmetics.Items[cType]

        if not itemdata then continue end

        local pos
        local ang

        if not itemdata.bone then
          local id = ply:LookupAttachment(itemdata.attach or "eyes")
          local aPos = ply:GetAttachment(id)
          
          if not aPos then return end
          
          pos = aPos.Pos
          ang = aPos.Ang
          
        else
          local BoneIndx = ply:LookupBone(itemdata.bone or "ValveBiped.Bip01_Head1")
          if not BoneIndx then print("invalid bone: " .. itemdata.bone) return end
          local BonePos , BoneAng = ply:GetBonePosition( BoneIndx )
          
          pos = BonePos
          ang = BoneAng
          
        end

        local forward, right, up = ang:Forward(), ang:Right(), ang:Up()

        local pos_offset = itemdata.pos * ply:GetModelScale()
        local ang_offset = itemdata.ang

        local mod = Cosmetics.Mod[ ply:GetModel() ]

        if mod and mod[ cType ] then
          pos_offset = pos_offset + mod[ cType ].pos
          ang_offset = ang_offset + mod[ cType ].ang
        end

        local pos_off = (up*(pos_offset.z or 0)) + (right*(pos_offset.y or 0)) + (forward*(pos_offset.x or 0))

        ang:RotateAroundAxis( right,  ang_offset.p or 0 )
        ang:RotateAroundAxis( forward,  ang_offset.y or 0 )
        ang:RotateAroundAxis( up,     ang_offset.r or 0 )

        cEnt:SetRenderOrigin(pos + pos_off)
        cEnt:SetRenderAngles(ang)

        cEnt:apply(cos.entity)

        for k,v in pairs(cEnt:GetMaterials()) do
          render.MaterialOverrideByIndex(k-1, nil)
        end

        if cos.material then
          render.ModelMaterialOverride( cos.material )
          render.MaterialOverrideByIndex(1, cos.material)
        end

        cEnt:DrawModel()

        render.ModelMaterialOverride(nil)

        cEnt:post_draw(cos.entity)
      end

    end
  end)
end
end);