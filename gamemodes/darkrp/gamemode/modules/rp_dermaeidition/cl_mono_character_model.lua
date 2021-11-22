local CHARACTER_MODEL = { }

function CHARACTER_MODEL:Init()
	self.mx = 0
	self.my = 0
	timer.Simple( .1, function()
		if not IsValid( self ) then return end

		local centerx , centery = self:LocalToScreen( self:GetWide() * .5 , self:GetTall() * .5 )
		input.SetCursorPos( centerx , centery )

		self.mx = centerx
		self.my = centery
	end )

	self.mx = centerx
	self.my = centery
end

function CHARACTER_MODEL:GetBones( bBody )
	local eEnt = self:GetEntity()
	for i = 1 , eEnt:GetBoneCount() do
		local sBone = eEnt:GetBoneName( i )
		if sBone == "ValveBiped.Bip01_Head1" then
			self.HeadID = k
			self.HeadPos, self.HeadAng = eEnt:GetBonePosition( i )

			if not bBody then break end
		end

		if sBone == "ValveBiped.Bip01_Spine1" then
			self.SpineID = i

			if self.HeadID then break end
		end
	end

	if not self.HeadID then
		self.HeadID = -1
	end

	eEnt:SetColor( Color( 255, 255, 255, 255 ) )
end

function CHARACTER_MODEL:Think()
	if self.IsWaitingToBones then
		local eEnt = self:GetEntity()
		if eEnt:GetBoneName( 1 ) == "__INVALIDBONE__" then return end

		self.LayoutEntity = function( this, eLayoutEnt )
			if not self.HeadID then
				self:GetBones( self.follower )
			end

			eLayoutEnt:SetAngles( Angle( 0, 15, 0 ) )

			local rx, ry = self:ScreenToLocal( gui.MouseX(), gui.MouseY() )
			local extraX = ( rx - self:GetWide() / 2 ) / 6
			local extraY = ( ry - self:GetTall() / 2 ) / 6
			eLayoutEnt:SetEyeTarget( Vector( 100 , extraX , 10 - extraY * 1.25 ) )

			if this.HeadID ~= -1 then

				local maxVerticalMovement = math.Clamp( extraY / -4 - 16, -20, 6 )
				local maxHorizontalMovement = math.Clamp( -90 + extraX / 4, -106, -46.5 )

				eLayoutEnt:ManipulateBoneAngles( this.HeadID , this.HeadAng + Angle( 75, maxVerticalMovement, maxHorizontalMovement ) )
			end
		end

		self.IsWaitingToBones = false
	end
end

function CHARACTER_MODEL:SetFollower( bBodyRotation )
	self.follower = bBodyRotation
	self.IsWaitingToBones = true

	self:GetEntity():SetColor( Color( 255, 255, 255, 0 ) )
end

function CHARACTER_MODEL:SetCharID( id )
	self.charid = id
end

function CHARACTER_MODEL:SetPlayer( pPlayer, ShopPreview )
  local charid

  if self.charid then
    charid = self.charid
  else
    charid = LocalPlayer():GetNVar('CurrentChar') or 0
  end

	if not IsValid( pPlayer ) then return end

	local eEnt = CosmeticsCreateClientModel()
	self:SetEntity( eEnt )

	if pPlayer:IsPlayer() then
		if ShopPreview then
			eEnt:BuildCosmetics( true, pPlayer, true )
		else
			eEnt:BuildCosmetics( true, pPlayer, false )
		end
	end

	self.Sequences = {
		'pose_standing_01',
		'pose_standing_02',
	}

	eEnt:SetSequence( table.Random(self.Sequences) )


  local wep = LocalPlayer():GetActiveWeapon()

  if IsValid(wep) then
    local holdtype;
    local ar2 = {"smg", "ar2", "shotgun", "crossbow", "rpg"}

    if wep.GetHoldType and table.HasValue(ar2, wep:GetHoldType()) then
      holdtype = "idle_passive"
    else
      holdtype = "idle_all_01"
    end
    --
    local pose = eEnt:LookupSequence( holdtype )
    eEnt:SetSequence( pose )
  end


  -- print("CHAR ID:"..charid)

  infos = table.Copy(LocalPlayer():CM_GetInfos(charid))
  -- print("KEK"..infos.model)
  if Cosmetics.Config.ForbiddenJobs[LocalPlayer():Team()] or Cosmetics.Config.ForbiddenJobsWithHeads[LocalPlayer():Team()] then
    --eEnt:SetModel(infos.model)
    eEnt:SetModel( rp.teams[LocalPlayer():Team()].model[1] )
  else
    eEnt:SetModel( infos.model )
    local list = Cosmetics.PlayerBottoms[LocalPlayer():SteamID64()][charid] or {}
    for pant, tables in pairs ( list ) do
      local datas
      if infos.sex == 1 then
        datas = Cosmetics.Male.ListDefaultPM[infos.model]
      else
        datas = Cosmetics.Female.ListDefaultPM[infos.model]
      end

      local tindex = datas.bodygroupsbottom[tables.bodygroup].pant
      local bodygroups = {
        datas.bodygroupsbottom[tables.bodygroup].group,
      }

      local ent = eEnt

      for k, v in pairs( bodygroups ) do
        ent:SetBodygroup( v[1], v[2] )
      end

      local pants = pant

      for k, v in pairs( tindex ) do
        ent:SetSubMaterial( v, pants )
      end
    end
    local list = Cosmetics.PlayerTops[LocalPlayer():SteamID64()][charid] or {}
    for iscustom, newlist in pairs ( list ) do
        for tee, tables in pairs ( newlist ) do
  --
        local data
        local datas
        if infos.sex == 1 then
          data = Cosmetics.Male
        else
          data = Cosmetics.Female
        end


        local datas = data.ListDefaultPM[infos.model]

        local tindex
        local bodygroups
        local tbdg

        local bodygroupname

        if tables.id and Cosmetics.Textures and data.EditableTop[Cosmetics.Textures[tables.id].baseTexture] then

          tbdg = data.EditableTop[Cosmetics.Textures[tables.id].baseTexture]

          -- if true then return end
          tindex = datas.bodygroupstop[tbdg.bodygroup].tee

          bodygroups = {
            datas.bodygroupstop[tbdg.bodygroup].group,
          }

          bodygroupname = tbdg.bodygroup

        else
          local t = datas.bodygroupstop[tables.bodygroup]
          tindex =  t.tee
          bodygroups =  {
            datas.bodygroupstop[tables.bodygroup].group,
          }

          bodygroupname = tables.bodygroup

        end

        local ent = eEnt

        for k, v in pairs( bodygroups ) do
          ent:SetBodygroup( v[1], v[2] )
        end

        local tops = tee

        for k, v in pairs( tindex ) do
          if iscustom == "customs" then
            ent:SetSubMaterial( v, "!CM_"..tables.id )
          else
            ent:SetSubMaterial( v, tops )
          end
        end
      end
    end
    local datas
    if infos.sex == 1 then
      datas = Cosmetics.Male.ListDefaultPM[infos.model]
    else
      datas = Cosmetics.Female.ListDefaultPM[infos.model]
    end

    local tindex = datas.bodygroupstop[infos.bodygroups.top].tee
    local pindex = datas.bodygroupsbottom[infos.bodygroups.pant].pant
    local eindex = datas.eyes
    local bodygroups = {
      datas.bodygroupstop[infos.bodygroups.top].group,
      datas.bodygroupsbottom[infos.bodygroups.pant].group
    }
    local skin = infos.skin
    local ent = eEnt
    local pcolor = infos.playerColor
    local tops = infos.teetexture.basetexture
    local pants = infos.panttexture.basetexture
    ent:SetSkin( skin )
    for k, v in pairs( bodygroups ) do
      ent:SetBodygroup( v[1], v[2] )
    end
    for k, v in pairs( tindex ) do
      ent:SetSubMaterial( v, tops )
    end
    for k, v in pairs( pindex ) do
      ent:SetSubMaterial( v, pants )
    end

    ent.GetPlayerColor = function() return pcolor end

    for k, v in pairs( infos.eyestexture ) do

      local matr = v["r"]
      local matl = v["l"]
      local indexr = eindex["r"]
      local indexl = eindex["l"]
      ent:SetSubMaterial( indexr, matr )
      ent:SetSubMaterial( indexl, matl )

    end
  end


	self:SetCamPos( Vector( 80, 0, 80 ) )
	self:SetLookAt( Vector( 0, 0, 38 ) )
	self:SetFOV( 24 )
	self:SetAmbientLight( Color( 20, 150, 255, 255 ) )
	self:SetDirectionalLight( BOX_FRONT, Color( 255, 150, 100 ) )
	self:SetAnimated( false )

	self:SetDirectionalLight( BOX_TOP, Color( 255, 255, 255 ) )
	self:SetDirectionalLight( BOX_FRONT, Color( 200, 200, 200 ) )
	self:SetDirectionalLight( BOX_RIGHT, Color( 100, 100, 100 ) )
	self:SetDirectionalLight( BOX_LEFT, Color( 100, 100, 100 ) )
	self:SetDirectionalLight( BOX_BOTTOM, Color( 100, 100, 100 ) )

end

function CHARACTER_MODEL:SetChar( ID, job )
  local charid = ID
	local eEnt = CosmeticsCreateClientModel()
	self:SetEntity( eEnt )

  for k, v in pairs(LocalPlayer():GetNVar('CharData')) do
    if v.id == charid then
      local cosm = v.cosmetics
      if cosm != nil then
        eEnt:BuildCharCosmetics(true, util.JSONToTable(v.cosmetics))
      end
    end
  end


  eEnt:SetSequence( "idle_all_01" )

  infos = table.Copy(LocalPlayer():CM_GetInfos(ID))

  if Cosmetics.Config.ForbiddenJobs[job] or Cosmetics.Config.ForbiddenJobsWithHeads[job] then
    eEnt:SetModel( rp.teams[job].model[1] )
  else
    eEnt:SetModel( infos.model )
    local list = Cosmetics.PlayerBottoms[LocalPlayer():SteamID64()][charid] or {}
    for pant, tables in pairs ( list ) do
      local datas
      if infos.sex == 1 then
        datas = Cosmetics.Male.ListDefaultPM[infos.model]
      else
        datas = Cosmetics.Female.ListDefaultPM[infos.model]
      end

      local tindex = datas.bodygroupsbottom[tables.bodygroup].pant
      local bodygroups = {
        datas.bodygroupsbottom[tables.bodygroup].group,
      }

      local ent = eEnt

      for k, v in pairs( bodygroups ) do
        ent:SetBodygroup( v[1], v[2] )
      end

      local pants = pant

      for k, v in pairs( tindex ) do
        ent:SetSubMaterial( v, pants )
      end
    end
    local list = Cosmetics.PlayerTops[LocalPlayer():SteamID64()][charid] or {}
    for iscustom, newlist in pairs ( list ) do
        for tee, tables in pairs ( newlist ) do
  --
        local data
        local datas
        if infos.sex == 1 then
          data = Cosmetics.Male
        else
          data = Cosmetics.Female
        end


        local datas = data.ListDefaultPM[infos.model]

        local tindex
        local bodygroups
        local tbdg

        local bodygroupname

        if tables.id and Cosmetics.Textures and data.EditableTop[Cosmetics.Textures[tables.id].baseTexture] then

          tbdg = data.EditableTop[Cosmetics.Textures[tables.id].baseTexture]

          -- if true then return end
          tindex = datas.bodygroupstop[tbdg.bodygroup].tee

          bodygroups = {
            datas.bodygroupstop[tbdg.bodygroup].group,
          }

          bodygroupname = tbdg.bodygroup

        else
          local t = datas.bodygroupstop[tables.bodygroup]
          tindex =  t.tee
          bodygroups =  {
            datas.bodygroupstop[tables.bodygroup].group,
          }

          bodygroupname = tables.bodygroup

        end

        local ent = eEnt

        for k, v in pairs( bodygroups ) do
          ent:SetBodygroup( v[1], v[2] )
        end

        local tops = tee

        for k, v in pairs( tindex ) do
          if iscustom == "customs" then
            ent:SetSubMaterial( v, "!CM_"..tables.id )
          else
            ent:SetSubMaterial( v, tops )
          end
        end
      end
    end
    local datas
    PrintTable(infos)
    if infos.sex == 1 then
      datas = Cosmetics.Male.ListDefaultPM[infos.model]
    else
      datas = Cosmetics.Female.ListDefaultPM[infos.model]
    end

    local tindex = datas.bodygroupstop[infos.bodygroups.top].tee
    local pindex = datas.bodygroupsbottom[infos.bodygroups.pant].pant
    local eindex = datas.eyes
    local bodygroups = {
      datas.bodygroupstop[infos.bodygroups.top].group,
      datas.bodygroupsbottom[infos.bodygroups.pant].group
    }
    local skin = infos.skin
    local ent = eEnt
    local pcolor = infos.playerColor
    local tops = infos.teetexture.basetexture
    local pants = infos.panttexture.basetexture
    ent:SetSkin( skin )
    for k, v in pairs( bodygroups ) do
      ent:SetBodygroup( v[1], v[2] )
    end
    for k, v in pairs( tindex ) do
      ent:SetSubMaterial( v, tops )
    end
    for k, v in pairs( pindex ) do
      ent:SetSubMaterial( v, pants )
    end

    ent.GetPlayerColor = function() return pcolor end

    for k, v in pairs( infos.eyestexture ) do

      local matr = v["r"]
      local matl = v["l"]
      local indexr = eindex["r"]
      local indexl = eindex["l"]
      ent:SetSubMaterial( indexr, matr )
      ent:SetSubMaterial( indexl, matl )

    end
  end

  eEnt:SetSequence( "idle_all_01" )

	self:SetCamPos( Vector( 80, 0, 80 ) )
	self:SetLookAt( Vector( 0, 0, 38 ) )
	self:SetFOV( 24 )
	self:SetAmbientLight( Color( 20, 150, 255, 255 ) )
	self:SetDirectionalLight( BOX_FRONT, Color( 255, 150, 100 ) )
	self:SetAnimated( false )

	self:SetDirectionalLight( BOX_TOP, Color( 255, 255, 255 ) )
	self:SetDirectionalLight( BOX_FRONT, Color( 200, 200, 200 ) )
	self:SetDirectionalLight( BOX_RIGHT, Color( 100, 100, 100 ) )
	self:SetDirectionalLight( BOX_LEFT, Color( 100, 100, 100 ) )
	self:SetDirectionalLight( BOX_BOTTOM, Color( 100, 100, 100 ) )

end

function CHARACTER_MODEL:PostDrawModel()
	local eEnt = self:GetEntity()
	eEnt:DrawModel()
	eEnt:DrawCosmetics()

  local wep = LocalPlayer():GetActiveWeapon()
	local wepEnt

  if IsValid(wep) and not IsValid(wepEnt) then
    wepEnt = ClientsideModel(wep:GetWeaponWorldModel())
    if IsValid(wepEnt) then
      local attachment = eEnt:LookupAttachment("anim_attachment_RH")
      wepEnt:SetParent(eEnt, attachment)
      wepEnt:AddEffects(EF_BONEMERGE)
      wepEnt:SetNoDraw(true)
    end
  elseif IsValid(wep) and IsValid(wepEnt) and wepEnt:GetModel() != wep:GetModel() then
    wepEnt:SetModel(wep:GetModel())
  end

	if IsValid(wep) and IsValid(wepEnt) then
      if wep.IsTFAWeapon and wep.Offset then
          local handBone = eEnt:LookupBone("ValveBiped.Bip01_R_Hand")
          if handBone and wep.Offset.Pos and wep.Offset.Ang then
            local pos, ang
            local mat = eEnt:GetBoneMatrix( handBone )
            if mat then
              pos, ang = mat:GetTranslation(), mat:GetAngles()
            else
              pos, ang = eEnt:GetBonePosition( handBone )
            end
            pos = pos + ang:Forward() * wep.Offset.Pos.Forward + ang:Right() * wep.Offset.Pos.Right + ang:Up() * wep.Offset.Pos.Up
            ang:RotateAroundAxis(ang:Up(), wep.Offset.Ang.Up)
            ang:RotateAroundAxis(ang:Right(), wep.Offset.Ang.Right)
            ang:RotateAroundAxis(ang:Forward(), wep.Offset.Ang.Forward)
            wepEnt:SetRenderOrigin(pos)
            wepEnt:SetRenderAngles(ang)
            wepEnt:SetModelScale(wep.Offset.Scale or 1, 0)
            wepEnt:DrawModel()
        end
			else
				wepEnt:DrawModel()
			end
		elseif IsValid(wepEnt) then
			wepEnt:Remove()
		end
end

function CHARACTER_MODEL:OnRemove()
	local eEnt = self:GetEntity()
	if not IsValid( eEnt ) then return end

    eEnt:ClearCosmetics()
	eEnt:Remove()
end

vgui.Register( "monoCharacterModel" , CHARACTER_MODEL , "DModelPanel" )
