local PANEL = {}

AccessorFunc(PANEL,"Icon","Icon")

function PANEL:Init()
	self:SetFOV( 1 )
	self:SetAnimated( false )
end

function PANEL:SetModel( strModelName )
	-- Note - there's no real need to delete the old
	-- entity, it will get garbage collected, but this is nicer.
	if IsValid( self.Entity ) then
		self.Entity:Remove()
		self.Entity = nil
	end

	-- Note: Not in menu dll
	if !ClientsideModel then return end

	self.Entity = ClientsideModel( strModelName, RENDERGROUP_OTHER )
	if !IsValid( self.Entity ) then return end

	self.Entity:SetNoDraw( true )
	self.Entity:SetIK( false )
	
	local iSeq = self.Entity:LookupSequence( "walk_all" )
	if iSeq <= 0 then iSeq = self.Entity:LookupSequence( "WalkUnarmed_all" ) end
	if iSeq <= 0 then iSeq = self.Entity:LookupSequence( "walk_all_moderate" ) end

	if iSeq > 0 then self.Entity:ResetSequence( iSeq ) end
	self.Entity:FrameAdvance( FrameTime() )
	
	self:CenterCamera()
end

function PANEL:SetSkin(id)
	self.Entity:SetSkin(id)
end

function PANEL:CenterCamera( dist )
	if not IsValid( self.Entity ) then return end
	local PrevMins, PrevMaxs = self.Entity:GetRenderBounds()
	self:SetLookAt( ( PrevMaxs + PrevMins ) / 2 )
	self.dist = PrevMins:Distance( PrevMaxs ) * ( dist or .5 )
end

function PANEL:SetIcon( i )
	if isstring( i ) then
		self.Icon = Material( i, "smooth unlitgeneric" )
	elseif type( i ) == "IMaterial" then
		self.Icon = i
	end
end

local tbl = {
	type = "3D",
	ortho = {}
}

function PANEL:Paint( w, h )
	local icon = self:GetIcon()
	if icon then
		surface.SetMaterial( self.mat )
		surface.SetDrawColor( self.colColor )
		surface.DrawTexturedRect( 0, 0, w, h )
		
	elseif IsValid( self.Entity ) then
		local x, y = self:LocalToScreen( 0, 0 )

		self:LayoutEntity( self.Entity )

		local ang = self.aLookAngle
		if not ang then
			ang = ( self.vLookatPos - self.vCamPos ):Angle()
		end
		
		tbl.x = x
		tbl.y = y
		tbl.w = w
		tbl.h = h
		tbl.origin = self.vCamPos
		tbl.angles = ang
		tbl.zfar = self.FarZ
		local posi = self.dist * math.min( w / h, h / w )
		local nega = - posi
		tbl.ortho.top = nega
		tbl.ortho.bottom = posi
		tbl.ortho.left = nega
		tbl.ortho.right = posi

		cam.Start( tbl )
		render.SuppressEngineLighting( true )
		
        render.SetLightingOrigin( self.Entity:GetPos() )
        render.ResetModelLighting( self.colAmbientLight.r / 255, self.colAmbientLight.g / 255, self.colAmbientLight.b / 255 )
		local colModel = self.Entity:GetColor()
        render.SetColorModulation( self.colColor.r * colModel.r / 65025, self.colColor.g * colModel.g / 65025, self.colColor.b * colModel.b / 65025 )
        render.SetBlend( ( self:GetAlpha() / 255 ) * ( self.colColor.a / 255 ) )

        for i = 0, 6 do
            local col = self.DirectionalLight[ i ]
            if col then
                render.SetModelLighting( i, col.r / 255, col.g / 255, col.b / 255 )
            end
        end
        
        self:DrawModel()
        
		
		render.SuppressEngineLighting( false )
		cam.End3D()
	end

	self.LastPaint = RealTime()
end

function PANEL:LayoutEntity()

end

function PANEL:GenerateExample( ClassName, PropertySheet, Width, Height )
	local ctrl = vgui.Create( ClassName )
	ctrl:SetSize( 300, 300 )
	ctrl:SetModel( "models/props_junk/PlasticCrate01a.mdl" )

	PropertySheet:AddSheet( ClassName, ctrl, nil, true, true )

end

derma.DefineControl( "monoIcon", "A DModelPanel which can be a white-overlaid model or an icon.", PANEL, "DModelPanel" )

local PANEL = {}

AccessorFunc(PANEL,"Icon","Icon")

function PANEL:Init()
	self:SetFOV( 1 )
	self:SetAnimated( false )
end

function PANEL:SetModel( strModelName )
	-- Note - there's no real need to delete the old
	-- entity, it will get garbage collected, but this is nicer.
	if IsValid( self.Entity ) then
		self.Entity:Remove()
		self.Entity = nil
	end

	-- Note: Not in menu dll
	if !ClientsideModel then return end

	self.Entity = ClientsideModel( strModelName, RENDERGROUP_OTHER )
	if !IsValid( self.Entity ) then return end

	self.Entity:SetNoDraw( true )
	self.Entity:SetIK( false )
	
	local iSeq = self.Entity:LookupSequence( "walk_all" )
	if iSeq <= 0 then iSeq = self.Entity:LookupSequence( "WalkUnarmed_all" ) end
	if iSeq <= 0 then iSeq = self.Entity:LookupSequence( "walk_all_moderate" ) end

	if iSeq > 0 then self.Entity:ResetSequence( iSeq ) end
	self.Entity:FrameAdvance( FrameTime() )
	
	self:CenterCamera()
end

function PANEL:CenterCamera( dist )
	if not IsValid( self.Entity ) then return end
	local PrevMins, PrevMaxs = self.Entity:GetRenderBounds()
	self:SetLookAt( ( PrevMaxs + PrevMins ) / 2 )
	self.dist = PrevMins:Distance( PrevMaxs ) * ( dist or .5 )
end

function PANEL:SetIcon( i )
	if isstring( i ) then
		self.Icon = Material( i, "smooth unlitgeneric" )
	elseif type( i ) == "IMaterial" then
		self.Icon = i
	end
end

local tbl = {
	type = "3D",
	ortho = {}
}

function PANEL:Paint( w, h )

	local icon = self:GetIcon()
	if icon then
		surface.SetMaterial( self.mat )
		surface.SetDrawColor( self.colColor )
		surface.DrawTexturedRect( 0, 0, w, h )
		
	elseif IsValid( self.Entity ) then
		local x, y = self:LocalToScreen( 0, 0 )

		self:LayoutEntity( self.Entity )

		local ang = self.aLookAngle
		if not ang then
			ang = ( self.vLookatPos - self.vCamPos ):Angle()
		end
		
		tbl.x = x
		tbl.y = y
		tbl.w = w
		tbl.h = h
		tbl.origin = self.vCamPos
		tbl.angles = ang
		tbl.zfar = self.FarZ
		local posi = self.dist * math.min( w / h, h / w )
		local nega = - posi
		tbl.ortho.top = nega
		tbl.ortho.bottom = posi
		tbl.ortho.left = nega
		tbl.ortho.right = posi

		cam.Start( tbl )
		render.SuppressEngineLighting( true )
		
        render.SetLightingOrigin( self.Entity:GetPos() )
        render.ResetModelLighting( self.colAmbientLight.r / 255, self.colAmbientLight.g / 255, self.colAmbientLight.b / 255 )
		local colModel = self.Entity:GetColor()
        render.SetColorModulation( self.colColor.r * colModel.r / 65025, self.colColor.g * colModel.g / 65025, self.colColor.b * colModel.b / 65025 )
        render.SetBlend( ( self:GetAlpha() / 255 ) * ( self.colColor.a / 255 ) )

        for i = 0, 6 do
            local col = self.DirectionalLight[ i ]
            if col then
                render.SetModelLighting( i, col.r / 255, col.g / 255, col.b / 255 )
            end
        end
        
        self:DrawModel()
        
		
		render.SuppressEngineLighting( false )
		cam.End3D()
	end

	self.LastPaint = RealTime()
end

function PANEL:LayoutEntity()

end

function PANEL:GenerateExample( ClassName, PropertySheet, Width, Height )
	local ctrl = vgui.Create( ClassName )
	ctrl:SetSize( 300, 300 )
	ctrl:SetModel( "models/props_junk/PlasticCrate01a.mdl" )

	PropertySheet:AddSheet( ClassName, ctrl, nil, true, true )

end

derma.DefineControl( "monoIcon", "A DModelPanel which can be a white-overlaid model or an icon.", PANEL, "DModelPanel" )

local PANEL = {}

local glowMat = Material( "particle/Particle_Glow_04_Additive" )

AccessorFunc(PANEL,"Icon","Icon")

function PANEL:Init()
	self:SetFOV( 1 )
	self:SetAnimated( false )
end

function PANEL:SetModel( strModelName )
	-- Note - there's no real need to delete the old
	-- entity, it will get garbage collected, but this is nicer.
	if IsValid( self.Entity ) then
		self.Entity:Remove()
		self.Entity = nil
	end

	-- Note: Not in menu dll
	if !ClientsideModel then return end

	self.Entity = ClientsideModel( strModelName, RENDERGROUP_OTHER )
	if !IsValid( self.Entity ) then return end

	self.Entity:SetNoDraw( true )
	self.Entity:SetIK( false )
	
	local iSeq = self.Entity:LookupSequence( "walk_all" )
	if iSeq <= 0 then iSeq = self.Entity:LookupSequence( "WalkUnarmed_all" ) end
	if iSeq <= 0 then iSeq = self.Entity:LookupSequence( "walk_all_moderate" ) end

	if iSeq > 0 then self.Entity:ResetSequence( iSeq ) end
	self.Entity:FrameAdvance( FrameTime() )
	
	self:CenterCamera()
end

function PANEL:CenterCamera( dist )
	if not IsValid( self.Entity ) then return end
	local PrevMins, PrevMaxs = self.Entity:GetRenderBounds()
	self:SetLookAt( ( PrevMaxs + PrevMins ) / 2 )
	self.dist = PrevMins:Distance( PrevMaxs ) * ( dist or .5 )
end

function PANEL:SetIcon( i )
	if isstring( i ) then
		self.Icon = Material( i, "smooth unlitgeneric" )
	elseif type( i ) == "IMaterial" then
		self.Icon = i
	end
end

function PANEL:SetColor( color )
	self.glowColor = color
end

function PANEL:SetSkin( id )
	self.Entity:SetSkin(id)
end

local tbl = {
	type = "3D",
	ortho = {}
}

function PANEL:Paint( w, h )

    local glowColor = self.glowColor or Color( 100,100,100 )

	draw.RoundedBox(0,0,0,w,h, Color(60, 60, 60,80))

	draw.OutlinedBox(0, 0, w, h, Color(255, 255, 255, 0), self.glowColor or Color(200, 200, 200, 50))

	surface.SetDrawColor( glowColor )
	surface.SetMaterial( glowMat )
	surface.DrawTexturedRect( 0 - ( w / 3 ), 0 - ( h / 3 ), w * 3, h * 3 )

    surface.SetDrawColor( Color( glowColor.r, glowColor.g, glowColor.b, 50 ) )
    surface.SetMaterial( glowMat )
    surface.DrawTexturedRect( ( 0 - ( w / 3 ) ) , ( 0 - ( h / 3 ) ) , ( w * 3 ) , ( h * 3 ) )

	local icon = self:GetIcon()
	if icon then
		surface.SetMaterial( icon )
		surface.SetDrawColor( self.colColor )
		surface.DrawTexturedRect( 0, 0, w, h )
		
	elseif IsValid( self.Entity ) then
		local x, y = self:LocalToScreen( 0, 0 )

		self:LayoutEntity( self.Entity )

		local ang = self.aLookAngle
		if not ang then
			ang = ( self.vLookatPos - self.vCamPos ):Angle()
		end
		
		tbl.x = x
		tbl.y = y
		tbl.w = w
		tbl.h = h
		tbl.origin = self.vCamPos
		tbl.angles = ang
		tbl.zfar = self.FarZ
		local posi = self.dist * math.min( w / h, h / w )
		local nega = - posi
		tbl.ortho.top = nega
		tbl.ortho.bottom = posi
		tbl.ortho.left = nega
		tbl.ortho.right = posi

		cam.Start( tbl )
		render.SuppressEngineLighting( true )
		
        render.SetLightingOrigin( self.Entity:GetPos() )
        render.ResetModelLighting( self.colAmbientLight.r / 255, self.colAmbientLight.g / 255, self.colAmbientLight.b / 255 )
		local colModel = self.Entity:GetColor()
        render.SetColorModulation( self.colColor.r * colModel.r / 65025, self.colColor.g * colModel.g / 65025, self.colColor.b * colModel.b / 65025 )
        render.SetBlend( ( self:GetAlpha() / 255 ) * ( self.colColor.a / 255 ) )

        for i = 0, 6 do
            local col = self.DirectionalLight[ i ]
            if col then
                render.SetModelLighting( i, col.r / 255, col.g / 255, col.b / 255 )
            end
        end
        
        self:DrawModel()
        
		
		render.SuppressEngineLighting( false )
		cam.End3D()
	end

	self.LastPaint = RealTime()
end

function PANEL:LayoutEntity()

end


derma.DefineControl( "rp.itemmodel", "A DModelPanel which can be a white-overlaid model or an icon.", PANEL, "DModelPanel" )


