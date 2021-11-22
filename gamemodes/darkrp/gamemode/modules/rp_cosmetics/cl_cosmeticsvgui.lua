local function removeCosmetic( pPlayer, cosmeticID, bKeepCosmeticData, bIsWep )
	if not IsValid( pPlayer ) then return end

	local sState = bIsWep and "weapon" or "default"
	if not bKeepCosmeticData then
		local iLen
		if bIsWep then
			pPlayer.cosmeticsLenWep = math.max( 0,  ( pPlayer.cosmeticsLenWep or 0 ) - 1 )
			iLen = pPlayer.cosmeticsLenWep
		else
			pPlayer.cosmeticsLen = ( pPlayer.cosmeticsLen or 0 ) - 1
			iLen = pPlayer.cosmeticsLen
		end

		local i = 1
		while i <= iLen + 1 do
			local iUID = pPlayer.cosmetics[ sState ][ i ]
			if iUID == cosmeticID then
				table.remove( pPlayer.cosmetics[ sState ], i )
			else
				i = i + 1
			end
		end
	end

	if not bIsWep and pPlayer == LocalPlayer() then
		pPlayer._cosmetics[ cosmeticID ] = false
	end

	if pPlayer.cosmeticEnts and pPlayer.cosmeticEnts[ sState ] then
		local eCosmetic = pPlayer.cosmeticEnts[ sState ][ cosmeticID ]
		if IsValid( eCosmetic ) then
			SafeRemoveEntity( eCosmetic )
		end

		pPlayer.cosmeticEnts[ sState ][ cosmeticID ] = nil
	end
end

local function clearCosmetics( pPlayer, bKeepCosmeticData )
	if not pPlayer.cosmeticsLen then return end

	if not pPlayer.cosmetics or not pPlayer.cosmetics.default then return end

	for i = 1, pPlayer.cosmeticsLen do
		local iCosmeticUID = pPlayer.cosmetics.default[ i ]
		if not iCosmeticUID then continue end

		removeCosmetic( pPlayer, iCosmeticUID, bKeepCosmeticData )
	end
end

local function deleteCosmetics( pPlayer )
	if not pPlayer.cosmeticEnts then return end

	for _, tCosmetics in pairs( pPlayer.cosmeticEnts ) do
		for _, eCosmetic in pairs( tCosmetics or {} ) do
			SafeRemoveEntity( eCosmetic )
		end
	end
end

local function getCosmeticPosAngOffset( pPlayer, mCosmetic )

	local vCosmeticPos = mCosmetic.pos 
	local aCosmeticAng = mCosmetic.ang

	return vCosmeticPos, aCosmeticAng
end

local function getModelOffset( sModel, sAttachment )
	return Vector( 0, 0, 0 ) 
end

local function getModelOffsetEntity( eEnt, sAttachment )
	local sModel = eEnt:GetModel()

	return getModelOffset( sModel, sAttachment )
end

local function createCosmetic( pPlayer, cosmeticID, bIgnoreGarbageCol, bIsWep )
	local mCosmetic
	mCosmetic = cosmeticID
	if not mCosmetic then return end

	local eCosmetic

	eCosmetic = ClientsideModel( mCosmetic.model )

	if not IsValid( eCosmetic ) then return end
	itemdata = mCosmetic
	cEnt = eCosmetic
	--eCosmetic:SetNoDraw( true )

	if not itemdata.bone then
		local id = pPlayer:LookupAttachment(itemdata.attach or "eyes")
		local aPos = pPlayer:GetAttachment(id)
		
		if not aPos then return end
		
		pos = aPos.Pos
		ang = aPos.Ang
		
	else
		local BoneIndx = pPlayer:LookupBone(itemdata.bone or "ValveBiped.Bip01_Head1")
		if not BoneIndx then print("invalid bone: " .. itemdata.bone) return end
		local BonePos , BoneAng = pPlayer:GetBonePosition( BoneIndx )
		
		pos = BonePos
		ang = BoneAng
		
	end

	local forward, right, up = ang:Forward(), ang:Right(), ang:Up()

	local pos_offset = itemdata.pos * pPlayer:GetModelScale()
	local ang_offset = itemdata.ang

	local mod = Cosmetics.Mod[ pPlayer:GetModel() ]

	--print(mod, ply:GetModel())

	if mod and mod[ cType ] then
		pos_offset = pos_offset + mod[ cType ].pos
		ang_offset = ang_offset + mod[ cType ].ang
	end

	local pos_off = (up*(pos_offset.z or 0)) + (right*(pos_offset.y or 0)) + (forward*(pos_offset.x or 0))

	if itemdata.sine then
		pos_off = pos_off + ((itemdata.bone and forward or up)*( math.sin(CurTime()/2)*4 ))
	end

	if itemdata.circle then
		--pos_off = pos_off - (right*( math.sin(CurTime()*2)*32 )) + (forward*( math.cos(CurTime()*3)*32 ))
	end

	-- todo
	/*if itemdata.animation then
		cEnt:FrameAdvance( RealTime() )
	end*/

	ang:RotateAroundAxis( right, 	ang_offset.p or 0 )
	ang:RotateAroundAxis( forward, 	ang_offset.y or 0 )
	ang:RotateAroundAxis( up, 		ang_offset.r or 0 )
	cEnt:SetRenderOrigin(pos + pos_off)
	cEnt:SetRenderAngles(ang)

	for k,v in pairs(cEnt:GetMaterials()) do
		render.MaterialOverrideByIndex(k-1, nil)
	end

	-- if cos.material then
	-- 	render.ModelMaterialOverride( cos.material )
	-- 	--render.MaterialOverrideByIndex(1, cos.material)
	-- end
	render.ModelMaterialOverride(nil)

	eCosmetic:Spawn()
	eCosmetic.cosmeticID = cosmeticID
	eCosmetic.cosmeticAttachment = sCosmeticAttachment
	eCosmetic.cosmeticAttachmentID = iCosmeticAttachment
	eCosmetic.cosmeticData = mCosmetic
	eCosmetic.cosmeticScale = iCosmeticScale

	pPlayer:CallOnRemove( "PlayerCosmeticClear", function( self )
		clearCosmetics( self, true )
	end )

	return eCosmetic
end

function CosmeticsCreateClientModel( pPos, aAng )
	local pLocalPlayer = LocalPlayer()
	local eClientModel = ClientsideModel( pLocalPlayer:GetModel() )
	eClientModel:SetModelScale( 1, 0 ) 
	if pPos then
		eClientModel:SetPos( pPos )
	end
	if aAng then
		eClientModel:SetAngles( aAng )
	end
	eClientModel:SetSkin( pLocalPlayer:GetSkin() )
	for _, tData in pairs( pLocalPlayer:GetBodyGroups() ) do
		eClientModel:SetBodygroup( tData.id, pLocalPlayer:GetBodygroup( tData.id ) )
	end

	return eClientModel
end

local function cosmeticSetup( eParent, eCosmetic, bIgnoreReparent )
	pPlayer = eParent
	cEnt = eCosmetic

	local tCosmetic = eCosmetic.cosmeticData
	itemdata = tCosmetic
	local pos
	local ang

	local BoneIndx = pPlayer:LookupBone(itemdata.bone or "ValveBiped.Bip01_Head1")
	if not BoneIndx then return end
	local BonePos , BoneAng = pPlayer:GetBonePosition( BoneIndx )
	
	pos = BonePos
	ang = BoneAng
		

	local forward, right, up = ang:Forward(), ang:Right(), ang:Up()

	local pos_offset = itemdata.pos * pPlayer:GetModelScale()
	local ang_offset = itemdata.ang

	local mod = Cosmetics.Mod[ pPlayer:GetModel() ]

	--print(mod, ply:GetModel())

	if mod and mod[ cType ] then
		pos_offset = pos_offset + mod[ cType ].pos
		ang_offset = ang_offset + mod[ cType ].ang
	end

	local pos_off = (up*(pos_offset.z or 0)) + (right*(pos_offset.y or 0)) + (forward*(pos_offset.x or 0))

	if itemdata.sine then
		pos_off = pos_off + ((itemdata.bone and forward or up)*( math.sin(CurTime()/2)*4 ))
	end

	if itemdata.circle then
		--pos_off = pos_off - (right*( math.sin(CurTime()*2)*32 )) + (forward*( math.cos(CurTime()*3)*32 ))
	end

	-- todo
	/*if itemdata.animation then
		cEnt:FrameAdvance( RealTime() )
	end*/

	ang:RotateAroundAxis( right, 	ang_offset.p or 0 )
	ang:RotateAroundAxis( forward, 	ang_offset.y or 0 )
	ang:RotateAroundAxis( up, 		ang_offset.r or 0 )
	cEnt:SetRenderOrigin(pos + pos_off)
	cEnt:SetRenderAngles(ang)
	if itemdata.scale then
		cEnt:SetModelScale(itemdata.scale)
	end

	if itemdata.skin then
		cEnt:SetSkin(itemdata.skin)
	end
	-- cEnt:SetRenderOrigin(pos + pos_off)
	-- cEnt:SetRenderAngles(ang)
end

local ENTITY = FindMetaTable( "Entity" )

function ENTITY:BuildCosmetics( bIgnoreGarbageCol, ply, ShopPreview )
	local CostemicsTable
	local tCosmetics
	if ShopPreview then
		CostemicsTable = ply.CosmeticsPreview
	else
		CostemicsTable = ply.Cosmetics
	end
	local tCosmetics = CostemicsTable
	if not tCosmetics then return end
	for k, v in pairs(tCosmetics) do
		local iCosmeticUID = Cosmetics.Items[ v ]
		if not iCosmeticUID then continue end

		local eCosmetic = createCosmetic( self, iCosmeticUID, bIgnoreGarbageCol )
		self:AddCosmetic( eCosmetic )
	end
end

function ENTITY:BuildCharCosmetics( bIgnoreGarbageCol, data )
	local tCosmetics = data
	if not tCosmetics then return end
	for k, v in pairs(tCosmetics) do
		local iCosmeticUID = Cosmetics.Items[ v ]
		if not iCosmeticUID then continue end

		local eCosmetic = createCosmetic( self, iCosmeticUID, bIgnoreGarbageCol )
		self:AddCosmetic( eCosmetic )
	end
end

function ENTITY:ClearCosmetics()
	if not self.cosmetics then return end
	for k, v in pairs(self.cosmetics) do
		local eCosmetic = self.cosmetics[ k ]
		if IsValid( eCosmetic ) then
			SafeRemoveEntity( eCosmetic )
		end
	end

	self.cosmetics = nil
	self.cosmeticsLen = nil
end
function ENTITY:AddCosmetic( eCosmetic )
	self.cosmeticsLen = ( self.cosmeticsLen or 0 ) + 1

	self.cosmetics = self.cosmetics or {}
	self.cosmetics[ self.cosmeticsLen ] = eCosmetic
end
function ENTITY:RemoveCosmetic( iIndex )
	if not self.cosmetics then return end

	iIndex = iIndex or 1
	if IsValid( self.cosmetics[ iIndex ] ) then
		SafeRemoveEntity( self.cosmetics[ iIndex ] )
		table.remove( self.cosmetics, iIndex )
	end

	self.cosmeticsLen = self.cosmeticsLen - 1
end
function ENTITY:RemoveCosmetics()
	if not self.cosmetics then return end

	for iIndex, eEntity in pairs( self.cosmetics ) do
		if IsValid( eEntity ) then
			SafeRemoveEntity( eEntity )
			table.remove( self.cosmetics, iIndex )
		end
	end

	self.cosmeticsLen = 0
end

function ENTITY:DrawCosmetics()
	if not self.cosmetics then return end
	for k, v in pairs(self.cosmetics) do
		local eCosmetic = self.cosmetics[ k ]
		if not IsValid( eCosmetic ) then
			self:RemoveCosmetic( k )

			return
		end

		cosmeticSetup( self, eCosmetic )

		eCosmetic:DrawModel()
	end
end