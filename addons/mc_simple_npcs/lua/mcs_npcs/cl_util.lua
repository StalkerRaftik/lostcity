--  _______               __          _______  __                   __          _______  ______  ______        
-- |   |   |.---.-..----.|  |.-----. |     __||__|.--------..-----.|  |.-----. |    |  ||   __ \|      |.-----.
-- |       ||  _  ||  __| |_||__ --| |__     ||  ||        ||  _  ||  ||  -__| |       ||    __/|   ---||__ --|
-- |__|_|__||___._||____|    |_____| |_______||__||__|__|__||   __||__||_____| |__|____||___|   |______||_____|
--                                                          |__|                                               

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////// Warning! Edit this only if you know what are you doing ///////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

local defnpc = {
	uid = "uid", 
	name = "Alyx",
	model = "models/alyx.mdl",
	pos = {
		 ["all"] = {Vector(0,0,0), Angle(0,0,0)}
	},
	bgr = {},
	skin = 0,
	uselimit = false,
	theme = "Default",
	namepos = 80,
	sequence = "",
	dialogs = {}
}

local localnpc = table.Copy(defnpc)

MCS.PanelControll = {}

MCS.PanelControll.AddHeader = function(panel, header, h) 

	local label = vgui.Create( "DLabel" )
	label:SetFont( "MCS_Arial16"  )
	label:SetText( header )
	label:SetAutoStretchVertical( true )
	
	panel:AddItem(label)
end

MCS.PanelControll.AddTextEntry = function(parent, header, h, value, func) 
	
	local panel = vgui.Create( "DPanel" )
	panel:SetSize( parent:GetWide(), h )
	panel.Paint = function() end
	
	local label = vgui.Create( "DLabel", panel )
	label:SetFont( "MCS_Arial16"  )
	label:SetPos( 0, 0 )
	label:SetSize( parent:GetWide()/4, h )
	label:SetTextColor(  color_white )
	label:SetText( header )
	label:SetAutoStretchVertical( true )
	
	local textentry = vgui.Create( "DTextEntry", panel )
	textentry:SetPos( parent:GetWide()/4+5, 0 )
	textentry:SetSize( parent:GetWide()-parent:GetWide()/4-5, h )
	textentry:SetText( value or "" )
	textentry:SetUpdateOnType( true )
	function textentry:OnValueChange( value )
		if func then func(value) end
	end
	parent:AddItem(panel)
	
	return textentry
end

MCS.PanelControll.AddCheckBox = function(parent, header, h, value, func) 
	
	local panel = vgui.Create( "DPanel" )
	panel:SetSize( parent:GetWide(), h )
	panel.Paint = function() end
	
	local DermaCheckbox = vgui.Create("DCheckBoxLabel", panel )
	DermaCheckbox:SetPos( 0, 0 )
	DermaCheckbox:SetSize( parent:GetWide()-30, h )
	DermaCheckbox:SetText( header )	
	DermaCheckbox:SetValue( value )
	DermaCheckbox:SetFont( "MCS_Arial16"  )
	DermaCheckbox:SetTextColor( color_white )
	function DermaCheckbox:OnChange( value )
		if func then func(value) end
	end
		
	parent:AddItem(panel)
	
	return DermaCheckbox
end

MCS.PanelControll.AddThemeSelect = function(parent, header, h, value, func) 
	
	local panel = vgui.Create( "DPanel" )
	panel:SetSize( parent:GetWide(), h )
	panel.Paint = function() end
	
	local label = vgui.Create( "DLabel", panel )
	label:SetFont( "MCS_Arial16"  )
	label:SetPos( 0, 0 )
	label:SetSize( parent:GetWide()/4, h )
	label:SetTextColor(  color_white )
	label:SetText( header )
	label:SetAutoStretchVertical( true )
	
	local combobox = vgui.Create( "DComboBox", panel )
	combobox:SetPos( parent:GetWide()/4+5, 0 )
	combobox:SetSize( parent:GetWide()-parent:GetWide()/4-5, h )
	combobox:SetValue( value )
	combobox:AddChoice( "Default" )
	for k,v in pairs(MCS.Themes) do
		combobox:AddChoice( k )
	end
	combobox.OnSelect = function( _, _, value )
		if func then func(value) end
	end

	parent:AddItem(panel)
	
	return combobox
end

MCS.PanelControll.AddNumberScroll = function(parent, header, h, value, func) 
	
	local panel = vgui.Create( "DPanel" )
	panel:SetSize( parent:GetWide(), h )
	panel.Paint = function() end
	
	local label = vgui.Create( "DLabel", panel )
	label:SetFont( "MCS_Arial16"  )
	label:SetPos( 0, 0 )
	label:SetSize( parent:GetWide()/4, h )
	label:SetTextColor(  color_white )
	label:SetText( header )
	label:SetAutoStretchVertical( true )
	
	local NumSlider = vgui.Create( "DNumSlider",panel )
	NumSlider:SetPos( parent:GetWide()/4+5, 0 )
	NumSlider:SetSize( parent:GetWide()-parent:GetWide()/4-5, h )
	NumSlider:SetText( "" )
	NumSlider:SetTall( 20 )
	NumSlider:SetDecimals( 0 )
	NumSlider:SetMax( 300 )
	NumSlider:SetValue( value or 30 )
	NumSlider.type = "skin"
	NumSlider.OnValueChanged = function(x, value) 
		if func then func(value) end
	end

	parent:AddItem(panel)
	
	return NumSlider
end

MCS.PanelControll.ModelFrame = function(parent, header, model) 
	
	if !model then
		model = "models/Humans/Group01/Male_01.mdl"
	end
	
	local aframe, icon, modelentry, animation, ab, GebuildSkinMenu, skinmenu
	local modelsize = 280
	
	if ScrH() > 1000 then  modelsize = 500 end
	
	local panel = vgui.Create( "DPanel" )
	panel:SetSize( parent:GetWide(), modelsize )
	panel.Paint = function() end
	
	local label = vgui.Create( "DLabel", panel )
	label:SetFont( "MCS_Arial16"  )
	label:SetPos( 0, 0 )
	label:SetSize( parent:GetWide()/4, 20 )
	label:SetTextColor(  color_white )
	label:SetText( "Model:" )
	label:SetAutoStretchVertical( true )
	
	local label = vgui.Create( "DLabel", panel )
	label:SetFont( "MCS_Arial16"  )
	label:SetPos( 0, 20 )
	label:SetSize( parent:GetWide()-parent:GetWide()/3, 20 )
	label:SetTextColor(  color_white )
	label:SetText( "Drag model to rotate, double click to zoom" )
	label:SetAutoStretchVertical( true )
	
	local label = vgui.Create( "DLabel", panel )
	label:SetFont( "MCS_Arial16"  )
	label:SetPos( 0, 45 )
	label:SetSize( 60, 20 )
	label:SetTextColor(  color_white )
	label:SetText( "Animation" )
	label:SetAutoStretchVertical( true )
	
	icon = vgui.Create( "DModelPanel", panel )
	icon:SetSize( parent:GetWide()/3, modelsize - 30 )
	icon:SetPos( parent:GetWide()-parent:GetWide()/3, 25 )
	icon:SetFOV( 35 )
	icon:SetCamPos( Vector( 0, 0, 0 ) )
	icon:SetDirectionalLight( BOX_RIGHT, Color( 255, 160, 80, 255 ) )
	icon:SetDirectionalLight( BOX_LEFT, Color( 80, 160, 255, 255 ) )
	icon:SetAmbientLight( Vector( -64, -64, -64 ) )
	icon:SetAnimated( true )
	icon.Angles = Angle( 0, 0, 0 )
	icon:SetLookAt( Vector( -100, 0, -22 ) )
	icon:SetModel( model )
	icon.Entity:ResetSequence( localnpc.sequence or "idle" )
	icon.Entity:SetPos( Vector( -100, 0, -61 ) )
	function icon:DragMousePress()
		self.PressX, self.PressY = gui.MousePos()
		self.Pressed = true
	end
	function icon:DoDoubleClick()
		if icon:GetFOV() < 10 then
			icon:SetFOV( 40 )
		else
			icon:SetFOV( icon:GetFOV() - 5 )
		end
	end
	function icon:DragMouseRelease() self.Pressed = false end

	function icon:LayoutEntity( ent )
		if ( self.bAnimated ) then self:RunAnimation() end

		if ( self.Pressed ) then
			local mx, my = gui.MousePos()
			self.Angles = self.Angles - Angle( 0, ( self.PressX or mx ) - mx, 0 )

			self.PressX, self.PressY = gui.MousePos()
		end

		ent:SetAngles( self.Angles )
	end
	
	parent:AddItem(panel)
	
	
	modelentry = vgui.Create( "DTextEntry", panel )
	modelentry:SetPos( parent:GetWide()/4+5, 0 )
	modelentry:SetSize( parent:GetWide()-parent:GetWide()/4-5, 20 )
	modelentry:SetText( model )
	modelentry:SetUpdateOnType( true )
	function modelentry:OnValueChange( value )
			icon:SetModel( value )
			icon.Entity:ResetSequence( "idle" )
			animation:SetText("idle")
			icon.Entity:SetPos( Vector( -100, 0, -61 ) )
			GebuildSkinMenu()
			localnpc.model = value
			localnpc.skin = 1
			localnpc.bgr = {}
	end
	
	animation = vgui.Create( "DTextEntry", panel )
	animation:SetPos( 60, 45 )
	animation:SetSize( parent:GetWide()/4, 20 )
	animation:SetText( localnpc.sequence or "idle" )
	animation:SetUpdateOnType( true )
	function animation:OnValueChange( value )
		local iSeq = icon.Entity:LookupSequence( value )
		if ( iSeq > 0 ) then icon.Entity:ResetSequence( iSeq ) end
		localnpc.sequence = string.lower(value)
	end
	
	ab = vgui.Create("DButton", panel )
	ab:SetSize( 55, 20 )
	ab:SetPos( 60+parent:GetWide()/4, 45 )
	ab:SetText( "Get Anim." )	
	ab.DoClick = function()
		if !ValidPanel(aframe) then
			aframe = MCS.PanelControll.AnimationMenu(panel, animation, icon.Entity, true)
		end
	end
	
	local skinmenu = vgui.Create( "DPanelList", panel )
	skinmenu:SetSize( panel:GetWide()-panel:GetWide()/3, panel:GetTall() - 80 )
	skinmenu:SetPos( 0, 80 )
	skinmenu:EnableVerticalScrollbar( true )
	skinmenu:EnableHorizontal( false )
	skinmenu:SetSpacing(1)
	skinmenu.Paint = function() end
	
	GebuildSkinMenu = function()
		skinmenu:Clear()
		
		local nskins = icon.Entity:SkinCount() - 1
		if ( nskins > 0 ) then
			local skins = vgui.Create( "DNumSlider" )
			skins:Dock( TOP )
			skins:SetText( "Skin" )
			skins:SetTall( 20 )
			skins:SetDecimals( 0 )
			skins:SetMax( nskins )
			skins:SetValue( localnpc.skin or 1 )
			skins.type = "skin"
			skins.OnValueChanged = function(x, value) 
				icon.Entity:SetSkin( value )
				localnpc.skin = value
			end
			skinmenu:AddItem( skins )
		end
		
		for k = 0, icon.Entity:GetNumBodyGroups() - 1 do
			if ( icon.Entity:GetBodygroupCount( k ) <= 1 ) then continue end
			local bgroup = vgui.Create( "DNumSlider" )
			bgroup:Dock( TOP )
			bgroup:SetText(icon.Entity:GetBodygroupName( k ))
			bgroup:SetTall( 20 )
			bgroup:SetDecimals( 0 )
			bgroup.type = "bgroup"
			bgroup.typenum = k
			bgroup:SetMax( icon.Entity:GetBodygroupCount( k ) - 1 )
			bgroup:SetValue( localnpc.bgr[k] or 0 )
			bgroup.OnValueChanged = function(x, value) 
				icon.Entity:SetBodygroup( k, value )
				localnpc.bgr[k] = value
			end
			skinmenu:AddItem( bgroup )
			
		end
		
	end
	
	if localnpc.bgr then
		for k,v in pairs(localnpc.bgr) do
			icon.Entity:SetBodygroup( k, v )
		end
	end
	
	icon.Entity:SetSkin( localnpc.skin or 1 )
	
	
	GebuildSkinMenu()
	
	return icon.Entity
end

MCS.PanelControll.AnimationMenu = function(parent, te, ent, setanim)
	
	local mx, my = gui.MousePos()
	
	local frame = vgui.Create( "DFrame" )
	frame:SetSize( 300, 400 )
	frame:SetPos( mx-300, my )
	frame:SetDraggable( true )
	frame:ShowCloseButton( true )
	frame:MakePopup()
	frame:SetTitle( "Animations List" )
	frame.StartT = CurTime() + 2
	frame.Think = function(self)
		if !ValidPanel(parent) or (!self:HasFocus() and self.StartT < CurTime() ) then
			self:Close()
		end
	end
	
	local AnimList = vgui.Create( "DListView", frame )
	AnimList:AddColumn( "name" )
	AnimList:Dock( FILL )
	AnimList:SetMultiSelect( false )
	AnimList:SetHideHeaders( true )
	
	for k, v in SortedPairsByValue( ent:GetSequenceList() or {} ) do

		local line = AnimList:AddLine( string.lower( v ) )
		
		line.OnSelect = function()
			
			if te then
				te:SetValue( string.lower( v ) )
			end
			
			if setanim then
				ent:ResetSequence( v )
				ent:SetCycle( 0 )
				localnpc.sequence = string.lower(v)
			end
			
		end

	end
	
	return frame
	
end

MCS.PanelControll.FileOpen = function(parent, func)
	
	local mx, my = gui.MousePos()
	
	local frame = vgui.Create( "DFrame" )
	frame:SetSize( 300, 400 )
	frame:SetPos( mx, my )
	frame:MakePopup()
	frame:SetTitle( "File List" )
	frame.StartT = CurTime() + 2
	frame.Think = function(self)
		if !ValidPanel(parent) or (!self:HasFocus() and self.StartT < CurTime() ) then
			self:Close()
		end
	end
	
	local FileList = vgui.Create( "DListView", frame )
	FileList:AddColumn( "File name" )
	FileList:Dock( FILL )
	FileList:SetMultiSelect( false )
	FileList:SetHideHeaders( false )
	local files, dir = file.Find( "mac_npc/*", "DATA" )
	for k, v in pairs( files ) do

		local line = FileList:AddLine( v )
		
		line.OnSelect = function()
			
			jsontable = file.Read( "mac_npc/"..v, "DATA" )
			localnpc = util.JSONToTable(jsontable)
			frame:Close()
			func()
			
		end

	end
	
	return frame
	
end

MCS.PanelControll.PosSelect = function(parent)
	
	local FRebuild
	
	local posmenu = vgui.Create( "DPanelList", parent )
	posmenu:SetSize( parent:GetWide(), 100 )
	posmenu:EnableVerticalScrollbar( true )
	posmenu:EnableHorizontal( false )
	posmenu:SetSpacing(1)
	posmenu.Paint = function() end
	
	local function EditPosFrame(parent, data)
	
		local mx, my = gui.MousePos()
		
		local newdata = table.Copy(data)
		
		local frame = vgui.Create( "DFrame" )
		frame:SetSize( 400, 80 )
		frame:SetPos( mx, my )
		frame:MakePopup()
		frame:SetTitle( "Pos. edit" )
		frame.Think = function(self)
			if !ValidPanel(parent) then
				self:Close()
			end
		end
		
		local label = vgui.Create( "DLabel", frame )
		label:SetFont( "MCS_Arial16"  )
		label:SetPos( 5, 30 )
		label:SetSize( 30, 20 )
		label:SetTextColor(  color_white )
		label:SetText( "Vec:" )
		label:SetAutoStretchVertical( true )
		
		for i=0,2 do 
			local map = vgui.Create( "DTextEntry", frame )
			map:SetPos( 40+i*81, 30 )
			map:SetSize( 80, 20 )
			map:SetText( data[1][i+1] )
			map:SetUpdateOnType( true )
			function map:OnValueChange( value )
				newdata[1][i+1] = value
			end
		end
		
		local label = vgui.Create( "DLabel", frame )
		label:SetFont( "MCS_Arial16"  )
		label:SetPos( 5, 55 )
		label:SetSize( 30, 20 )
		label:SetTextColor(  color_white )
		label:SetText( "Ang:" )
		label:SetAutoStretchVertical( true )
		
		for i=0,2 do 
			local map = vgui.Create( "DTextEntry", frame )
			map:SetPos( 40+i*81, 55 )
			map:SetSize( 80, 20 )
			map:SetText( data[2][i+1] )
			map:SetUpdateOnType( true )
			function map:OnValueChange( value )
				newdata[2][i+1] = value
			end
		end
		
		local b = vgui.Create("DButton", frame)
		b:SetSize( 58, 20 )
		b:SetPos( 282, 30 )
		b:SetText( "Player Pos" )	
		b.DoClick = function()
			local pos = LocalPlayer():GetPos()
			local ang = LocalPlayer():EyeAngles()
			data[1] = pos
			data[2] = Angle(0,ang.y,0)
			frame:Close()
			FRebuild()
		end
		
		local b = vgui.Create("DButton", frame)
		b:SetSize( 58, 20 )
		b:SetPos( 340, 30 )
		b:SetText( "Ent Pos" )	
		b.DoClick = function()
			local TraceEnt = LocalPlayer():GetEyeTrace().Entity
			if (TraceEnt:IsValid()) then
				local pos = TraceEnt:GetPos()
				local ang = TraceEnt:GetAngles()
				data[1] = pos
				data[2] = ang
				frame:Close()
				FRebuild()
			end
		end
		
		local b = vgui.Create("DButton", frame)
		b:SetSize( 116, 20 )
		b:SetPos( 282, 55 )
		b:SetText( "Save" )	
		b.DoClick = function()
			data = newdata
			frame:Close()
			FRebuild()
		end
		
	end
	
	FRebuild = function()
		posmenu:Clear()
		local b = vgui.Create("DButton")
		b:SetSize( posmenu:GetWide(), 20 )
		b:SetText( "Add Map" )	
		b.DoClick = function()
			if localnpc.pos[string.lower(game.GetMap())] then
				localnpc.pos["map_name_"..table.Count(localnpc.pos) + 1] = {Vector(0,0,0), Angle(0,0,0)}
			else
				localnpc.pos[string.lower(game.GetMap())] = {Vector(0,0,0), Angle(0,0,0)}
			end
			FRebuild()
		end
		posmenu:AddItem(b)
		
		local pw = parent:GetWide()
		
		for k,v in pairs(localnpc.pos) do
			local panel = vgui.Create( "DPanel" )
			panel:SetSize( pw, 20 )
			panel.Paint = function() end
			
			local label = vgui.Create( "DLabel", panel )
			label:SetFont( "MCS_Arial16"  )
			label:SetPos( pw/4+5, 0 )
			label:SetSize( pw/2, 20 )
			label:SetTextColor(  color_white )
			label:SetText( "Vec:"..v[1].x..", "..v[1].y..", "..v[1].z.." Ang:"..v[2].p..", "..v[2].y..", "..v[2].r )
			label:SetAutoStretchVertical( true )
			posmenu:AddItem(panel)
			
			local map = vgui.Create( "DTextEntry", panel )
			map:SetPos( 0, 0 )
			map:SetSize( pw/4, 20 )
			map:SetText( k )
			map.lastchange = 0
			function map:OnValueChange( value )
				if value != k and map.lastchange < CurTime() then
					localnpc.pos[value] = localnpc.pos[k]
					localnpc.pos[k] = nil
					map.lastchange = CurTime() + 1
					FRebuild()
				end		
			end
			function map:OnFocusChanged(gained )
				if !gained then
					map:OnEnter()
				end
			end
			
		
			local b = vgui.Create("DButton", panel)
			b:SetSize( pw/10, 20 )
			b:SetPos( pw-(pw/10)*2, 0 )
			b:SetText( "Edit" )	
			b.DoClick = function()
				EditPosFrame(panel, localnpc.pos[k])
			end
			
			local b = vgui.Create("DButton", panel)
			b:SetSize( pw/10, 20 )
			b:SetPos( pw-pw/10, 0 )
			b:SetText( "Remove" )	
			b.DoClick = function()
				localnpc.pos[k] = nil
				FRebuild()
			end
			
		end
		
	end
	
	FRebuild()
	
	parent:AddItem(posmenu)
	return posmenu
	
end

net.Receive("OpenMCSSetupMenu", function()
	
	if !LocalPlayer():IsSuperAdmin() then return end
	
	local RebuidAllFrames, RebuildDialogueFrame, RebuildNPCFrame, localmodel
	
	local function AutoSave() 
		file.Write("mac_npc/autosave.txt", util.TableToJSON(localnpc))
	end
	
	if !file.Exists( "mac_npc", "DATA" ) then
		file.CreateDir( "mac_npc" )
	end
	
	if file.Exists( "mac_npc/autosave.txt", "DATA" ) then
		jsontable = file.Read( "mac_npc/autosave.txt", "DATA" )
		localnpc = util.JSONToTable(jsontable)
	end

	local MainM = vgui.Create( "DFrame" )
	MainM:SetSize( ScrW()-300, ScrH()-50 )
	MainM:Center()
	MainM:MakePopup()
	MainM:SetDraggable( false )
	MainM:ShowCloseButton( true )
	MainM:SetTitle( "Simple NPCs Setup Menu" )
	MainM.OnClose = function()
		AutoSave() 
	end
	MainM.Paint = function(self, w, h)
		draw.RoundedBox( 0, 1, 1, w, h, Color( 55, 55, 55, 255))
		MCS.Frame(0,0,w,h,15,Color(155,155,155, 255),Color(255,255,255, 255))
		draw.RoundedBox( 0, 1, 1, w, 25, Color( 0, 0, 0, 200)) 
		draw.SimpleText( "NPC Setup", "MCS_Arial16", 10, 50, Color(255,255,255), TEXT_ALIGN_LEFT )
		draw.SimpleText( "Dialogue Setup", "MCS_Arial16", w/2+5, 50, Color(255,255,255), TEXT_ALIGN_LEFT )
	end
	
	local MenuBar = vgui.Create( "DMenuBar", MainM )
	MenuBar:DockMargin( -3, -6, -3, 0 )
	local oframe
	
	local M1 = MenuBar:AddMenu( "File" )
	M1:AddOption( "New", function() localnpc = table.Copy(defnpc) RebuidAllFrames() end ):SetIcon( "icon16/page_white_go.png" )
	M1:AddOption( "Open", function() 
		if !ValidPanel(oframe) then
			oframe = MCS.PanelControll.FileOpen(MainM, function() RebuidAllFrames() end)
		end
	end ):SetIcon( "icon16/folder_go.png" )
	M1:AddOption( "Save", function() file.Write("mac_npc/"..localnpc.uid..".txt", util.TableToJSON(localnpc)) end ):SetIcon( "icon16/disk.png" )
	
	local M2 = MenuBar:AddMenu( "Edit" )
	M2:AddOption( "Copy lua code", function() RunConsoleCommand("mcs_generate") end )
	
	local M3 = MenuBar:AddMenu( "Help" )
	M3:AddOption( "Full documentation", function() gui.OpenURL( "https://docs.google.com/document/d/1TCdjXQ7jDGpn0Jukno6yGbcdo29puzzqHZTYteNRcrs/edit?usp=sharing" ) end )
	
	local mw, mh = MainM:GetWide(), MainM:GetTall()
	
	local NPCframe = vgui.Create( "DPanelList", MainM )
	NPCframe:SetSize( mw/2-15, mh-75 )
	NPCframe:SetPos( 10, 70 )
	NPCframe:EnableVerticalScrollbar( true )
	NPCframe:EnableHorizontal( false )
	NPCframe:SetSpacing(3)
	NPCframe.Paint = function(self,w,h)	end
	
	local DGframe = vgui.Create( "DPanelList", MainM )
	DGframe:SetSize( mw/2-15, mh-75 )
	DGframe:SetPos( mw/2+5, 70 )
	DGframe:EnableVerticalScrollbar( true )
	DGframe:EnableHorizontal( false )
	DGframe:SetSpacing(3)
	DGframe.Paint = function(self,w,h) end
	
	RebuildNPCFrame = function()
		NPCframe:Clear()
		MCS.PanelControll.AddHeader(NPCframe, "Unique name must be UNIQUE.\n2 or more NPCs with identical unique name will not work.")
		MCS.PanelControll.AddTextEntry(NPCframe, "Unique name", 20, localnpc.uid, function(value) localnpc.uid = value end)
		MCS.PanelControll.AddHeader(NPCframe, "NPC's name will be shown to players above the NPC and via the dialogue.")
		MCS.PanelControll.AddTextEntry(NPCframe, "NPC's name", 20, localnpc.name, function(value) localnpc.name = value end)
		MCS.PanelControll.AddHeader(NPCframe, "NPC's name position can be useful if you use bigger or smaller model than the standat player models.")
		MCS.PanelControll.AddNumberScroll(NPCframe, "NPC's name position", 20, localnpc.namepos, function(value) localnpc.namepos = math.Round(value) end)
		MCS.PanelControll.AddCheckBox(NPCframe, "Allow only one player to speak to the npc at the same time", 20, localnpc.uselimit or false, function(value) localnpc.uselimit = value RebuildDialogueFrame() end)
		MCS.PanelControll.AddThemeSelect(NPCframe, "Dialogue theme", 20, localnpc.theme or "Default", function(value) localnpc.theme = value end)
		localmodel = MCS.PanelControll.ModelFrame(NPCframe, "Model", localnpc.model)
		MCS.PanelControll.PosSelect(NPCframe)
		
		local b = vgui.Create("DButton")
		b:SetSize( NPCframe:GetWide()-10, 30 )
		b:SetText( "Copy to Clipboard and Close" )	
		b.DoClick = function()
			RunConsoleCommand("mcs_generate")
			MainM:Close()
		end
		NPCframe:AddItem(b)
	end
	local function AddDialogue()
		table.insert(localnpc.dialogs, { ["Line"] = "", ["Sound"] = "", ["Answers"] = { {"", "close", nil, nil, ""}}, })
		RebuildDialogueFrame()
	end	
	RebuidAllFrames = function()
		RebuildDialogueFrame()
		RebuildNPCFrame()
	end
	
	RebuildDialogueFrame = function()
		DGframe:Clear()
		
		local b = vgui.Create("DButton")
		b:SetSize( DGframe:GetWide()-10, 25 )
		b:SetText( "Add Line" )	
		b.DoClick = function()
			AddDialogue()
		end
		DGframe:AddItem(b)
		
		for k,v in pairs(localnpc.dialogs) do 
			local wide = DGframe:GetWide()-10
			
			local sf = vgui.Create( "DPanel" )
			sf:SetSize( wide, 95 + (25 * table.Count(v["Answers"])) )
			
			local dl = vgui.Create( "DLabel", sf )
			dl:SetPos( 5, 5 ) 
			dl:SetSize( wide, 15 )
			dl:SetDark( 1 )
			dl:SetText( "ID: "..k )
			
			local dl = vgui.Create( "DLabel", sf )
			dl:SetPos( 5, 47 ) 
			dl:SetSize( 35, 20 )
			dl:SetDark( 1 )
			dl:SetText( "Sound:" )
			
			if k != 1 then
				local b = vgui.Create("DButton", sf )
				b:SetSize( 15, 15 )
				b:SetPos( sf:GetWide()-20, 3 )
				b:SetText( "X" )	
				b.DoClick = function()
					table.remove(localnpc.dialogs, k)
					sf:Remove()
				end
			end
			
			local te = vgui.Create( "DTextEntry", sf )
			te:SetPos( 5, 25 )
			te:SetSize( sf:GetWide()-10, 20 )
			te:SetText( localnpc.dialogs[k]["Line"] )
			te:SetUpdateOnType( true )
			function te:OnValueChange( value )
				localnpc.dialogs[k]["Line"] = value
			end
			
			local te = vgui.Create( "DTextEntry", sf )
			te:SetPos( 40, 47 )
			te:SetSize( sf:GetWide()-45, 20 )
			te:SetText( localnpc.dialogs[k]["Sound"] )
			te:SetUpdateOnType( true )
			function te:OnValueChange( value )
				localnpc.dialogs[k]["Sound"] = value
			end
			
			local b = vgui.Create("DButton", sf )
			b:SetPos( 5, 69 )
			b:SetSize( sf:GetWide()-10, 20 )
			b:SetText( "Add Answer" )	
			b.DoClick = function()
				table.insert(v["Answers"], {"", "close"})
				RebuildDialogueFrame()
			end
			
			for c,a in pairs(v["Answers"]) do
				local te = vgui.Create( "DTextEntry", sf )
				te:SetPos( 5, 92 + ((c-1) * 25) )
				te:SetSize( sf:GetWide()/2, 20 )
				te:SetText( a[1] )
				te:SetUpdateOnType( true )
				function te:OnValueChange( value )
					a[1] = value
				end
				
				local cb = vgui.Create( "DButton", sf )
				cb:SetPos(  sf:GetWide()/2+5, 92 + ((c-1) * 25) )
				cb:SetSize( sf:GetWide()/8-10, 20 )
				cb:SetText( a[2] )
				cb.DoClick = function()
					local cdmenu = DermaMenu()
					for i=1,#localnpc.dialogs do
						cdmenu:AddOption( "#"..i, function() a[2] = i cb:SetText( i ) end )
					end
					cdmenu:AddOption( "close", function() a[2] = "close" cb:SetText( "close" ) end )
					
					local cdsub = cdmenu:AddSubMenu( "Supportet addons:" )
					for id, addon in pairs(MCS.AddonList) do
						if addon["enabled"] then
							cdsub:AddOption( id, function() a[2] = '"'..id..'"' cb:SetText( a[2] ) end )
						end
					end
					cdmenu:Open()
				end	
				
				local b = vgui.Create("DButton", sf )
				b:SetPos(  sf:GetWide()/2+sf:GetWide()/8-5, 92 + ((c-1) * 25) )
				b:SetSize( sf:GetWide()/8-10, 20 )
				b:SetText( "Del" )	
				b.DoClick = function()
					table.remove(v["Answers"], c)
					RebuildDialogueFrame()
				end	
				
				if localnpc.uselimit then
				
					local te = vgui.Create( "DTextEntry", sf )
					te:SetPos( sf:GetWide()/2+(sf:GetWide()/8)*2-15, 92 + ((c-1) * 25) )
					te:SetSize( sf:GetWide()/8-5, 20 )
					te:SetText( a[5] or "" )
					te:SetUpdateOnType( true )
					function te:OnValueChange( value )
						a[5] = value
					end
					
					local aframe
					ab = vgui.Create("DButton", sf )
					ab:SetPos( sf:GetWide()/2+(sf:GetWide()/8)*3-20, 92 + ((c-1) * 25) )
					ab:SetSize( sf:GetWide()/8-10, 20 )
					ab:SetText( "Get Anim." )	
					ab.DoClick = function()
						if !ValidPanel(aframe) then
							aframe = MCS.PanelControll.AnimationMenu(sf, te, localmodel, false)
						end
					end
	
				end
				
			end
				
			DGframe:AddItem(sf)
		end
		
		local b = vgui.Create("DButton")
		b:SetSize( DGframe:GetWide()-10, 25 )
		b:SetText( "Test the dialogue" )	
		b.DoClick = function()
			if localnpc.theme and localnpc.theme != "Default" and MCS.Themes[localnpc.theme] then
				if MCS.Themes[localnpc.theme].Menu then
					MCS.Themes[localnpc.theme].Menu(nil, localnpc)
				elseif MCS.Themes[localnpc.theme].Paint then
					MCS.OpenDialogue(nil, localnpc.theme, localnpc)
				else
					MCS.OpenDialogue(nil, nil, localnpc)
				end
			else
				MCS.OpenDialogue(nil, nil, localnpc)
			end
			
		end
		DGframe:AddItem(b)
		
		
	end
	
	RebuidAllFrames()
end)

concommand.Add("mcs_generate", function( ply, cmd, args )

	if MCS.Spawns[localnpc.uid] then
		chat.AddText(Color(255, 0, 0), "Unique name is already used!")
	end
	
	if !localnpc then return end
	
	local uselimit_bool = "false"
	
	if localnpc.uselimit then uselimit_bool = "true" end
	
	local text = [[MCS.Spawns["]]..localnpc.uid..[["] = {
	name = "]]..localnpc.name..[[",
	model = "]]..localnpc.model..[[",
	namepos = ]]..localnpc.namepos..[[,
	theme = "]]..localnpc.theme..[[",
	pos = {
]]
	
	for k, v in pairs(localnpc.pos) do
		text = text..[[		["]]..k..[["] = { Vector(]]..v[1].x..[[,]]..v[1].y..[[,]]..v[1].z..[[ ), Angle(]]..v[2].p..[[,]]..v[2].y..[[,]]..v[2].r..[[ )},
]]
	end

	text = text..[[	},
	sequence = "]]..localnpc.sequence..[[",
	uselimit = ]]..uselimit_bool..[[,
]]

	if localnpc.skin then
		text = text..[[	skin = ]]..localnpc.skin..[[,
]]
	end
	
	if localnpc.bgr then
		text = text..[[	bgr = {]]
		
		for k, v in pairs(localnpc.bgr) do
			text = text.."["..k.."] = "..v..","
		end
		
		text = text..[[},
]]

	end
	
text = text..[[	dialogs = {
]]
	
	
	for k, v in pairs(localnpc.dialogs) do
		text = text..[[		[]]..k..[[] = {
			["Line"] = "]]..v["Line"]..[[",
			["Sound"] = "]]..v["Sound"]..[[",
			["Answers"] = {
]]
		for _, a in pairs(v["Answers"]) do
			local at = a[2]
			local an = a[5] or ""
			if at == "close" then at = '"close"' end
			if an != "" then an = ' nil, nil, "'..an..'"' end
			text = text..[[
				{"]]..a[1]..[[", ]]..at..[[,]]..an..[[},
]]
		end
		text = text..[[
			},
		},
]]
	end
	
	text = text..[[	}
}]]
	
	SetClipboardText(text)
	
end)