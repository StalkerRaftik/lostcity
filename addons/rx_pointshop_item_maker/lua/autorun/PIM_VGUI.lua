PIM_EditorPanel = PIM_EditorPanel or nil
local meta = FindMetaTable("Player");

local Attachments_Common = {
	"eyes",
	"mouth",
	"chest",
	"forward",
	"anim_attachment_RH",
	"anim_attachment_LH"
}

if SERVER then
	util.AddNetworkString( "PIM_PlayerSpawnProp_S2C" )
	hook.Add("PlayerSpawnedProp", "PIM SpawnProp", function(ply,model,ent)
		if ply.PIM_ThirdViewEnt and ply.PIM_ThirdViewEnt:IsValid() then
			net.Start( "PIM_PlayerSpawnProp_S2C" )
				net.WriteTable( {Model=model} )
			net.Send(ply)
			ent:Remove()
		end
	end)
	hook.Add("PlayerSpawnEffect", "PIM SpawnEffect", function(ply,model)
		if ply.PIM_ThirdViewEnt and ply.PIM_ThirdViewEnt:IsValid() then
			net.Start( "PIM_PlayerSpawnProp_S2C" )
				net.WriteTable( {Model=model} )
			net.Send(ply)
			ent:Remove()
		end
	end)
	
end

hook.Add("PostPlayerDraw","PIM_Render Model",function(ply)
	if PIM_EditorPanel and PIM_EditorPanel:IsValid() and PIM_EditorPanel.MainModel then
		
	end
end)

if CLIENT then
	
	
	net.Receive( "PIM_PlayerSpawnProp_S2C", function( len,ply )
		local DATA = net.ReadTable()
		local Model = DATA.Model
		if PIM_EditorPanel and PIM_EditorPanel:IsValid() then
			PIM_EditorPanel:UpdateModel(Model)
		end
	end)
	
	concommand.Add("PIM_OpenEditor",function(ply,cmd,args)
		PIM_OpenEditor()
	end)
	
	function PIM_CloseEditor()
		if PIM_EditorPanel and PIM_EditorPanel:IsValid() then
			if PIM_EditorPanel.MainModel then
				PIM_EditorPanel.MainModel:Remove()
			end
			PIM_EditorPanel:Remove()
		end
		RunConsoleCommand("PIM_DisableTV")
	end
	
	function PIM_OpenEditor()
		PIM_CloseEditor()
		PIM_EditorPanel = vgui.Create("PIM_Editor")
		PIM_EditorPanel:SetSize(ScrW(),ScrH())
		PIM_EditorPanel:Center()
		PIM_EditorPanel:Install()
		PIM_EditorPanel:MakePopup()
		
		RunConsoleCommand("PIM_EnableTV")
	end

local PANEL = {}
function PANEL:Init()
	self.Zoom = 100
	self.Height = 50
	
	self.CamPos = Vector(self.Zoom,0,self.Height)
	self.ViewPos = Vector(0,0,self.Height)
	
	self.CamAngle = (self.ViewPos - self.CamPos):Angle()
	
	self.ItemPrice = 200
	self.ItemName = "Write Item Name here"
	self.ModelPos = Vector(0,0,0)
	self.ModelAngle = Angle(0,0,0)
	self.ModelSize = Vector(1,1,1)
	self.ModelAttachment = nil
	self.ModelBone = nil
	self.ModelMaterial = ""
	self.ModelColor = Color(255,255,255,255)
	
	
	for i=0, LocalPlayer():GetBoneCount() - 1 do
		self.ModelBone = LocalPlayer():GetBoneName(0)
	end
end

function PANEL:PrintCodeToConsole()
	if !self.MainModel then return end
	if !self.ModelAttachment and !self.ModelBone then return end
	
	MsgN("PointShop Item Maker --> Pasting Codes\n\n")
	MsgN("/* ───────────────────────────────────────────────────────────────")
	MsgN("This Item is Created by RocketMania's Pointshop Item Maker")
	MsgN("─────────────────────────────────────────────────────────────── */")
	MsgN("")
	MsgN("ITEM.Name = '" .. self.ItemName .. "'")
	MsgN("ITEM.Price = " .. self.ItemPrice)
	MsgN("ITEM.Model = " .. "'" .. self.MainModel:GetModel() .. "'")
	if self.ModelAttachment then
		MsgN("ITEM.Attachment = " .. "'" .. self.ModelAttachment .. "'")
	else
		MsgN("ITEM.Bone = " .. "'" .. self.ModelBone .. "'")
	end
	
	MsgN("")
	MsgN("function ITEM:OnEquip(ply, modifications)")
	MsgN("\tply:PS_AddClientsideModel(self.ID)")
	MsgN("end")
	
	MsgN("")
	MsgN("function ITEM:OnHolster(ply)")
	MsgN("\tply:PS_RemoveClientsideModel(self.ID)")
	MsgN("end")
	
	MsgN("")
	MsgN("function ITEM:ModifyClientsideModel(ply, model, pos, ang)")
	Msg("\t")	 MsgN("local Size = Vector(" .. self.ModelSize.x .. "," .. self.ModelSize.y .. "," .. self.ModelSize.z .. ")")
	Msg("\t")	 MsgN("local mat = Matrix()")
	Msg("\t")	 MsgN("mat:Scale(Size)")
	Msg("\t")	 MsgN("model:EnableMatrix('RenderMultiply', mat)")
	
	MsgN("")
	Msg("\t")	 MsgN("model:SetMaterial('" .. self.ModelMaterial .. "')")
	
	MsgN("")
	Msg("\t")	 MsgN("local MAngle = Angle(" .. self.ModelAngle.p .. "," .. self.ModelAngle.y .. "," .. self.ModelAngle.r .. ")")
	Msg("\t")	 MsgN("local MPos = Vector(" .. self.ModelPos.x .. "," .. self.ModelPos.y .. "," .. self.ModelPos.z .. ")")
	
	MsgN("")
	Msg("\t")	 MsgN("pos = pos + (ang:Forward() * MPos.x) + (ang:Up() * MPos.z) + (ang:Right() * MPos.y)")
	Msg("\t")	 MsgN("ang:RotateAroundAxis(ang:Forward(), MAngle.p)")
	Msg("\t")	 MsgN("ang:RotateAroundAxis(ang:Up(), MAngle.y)")
	Msg("\t")	 MsgN("ang:RotateAroundAxis(ang:Right(), MAngle.r)")
	
	
	-- SPINNING FX
	if self.ModelSpecial_Spin.Enable == 1 then
		MsgN("")
		local SA = self.ModelDrawingAngle
		Msg("\t")	 MsgN("model.ModelDrawingAngle = model.ModelDrawingAngle or Angle(0,0,0)")
		Msg("\t")	 MsgN("model.ModelDrawingAngle.p = (CurTime() * " .. self.ModelSpecial_Spin.Angle.p .. " *90)")
		Msg("\t")	 MsgN("model.ModelDrawingAngle.y = (CurTime() * " .. self.ModelSpecial_Spin.Angle.y .. " *90)")
		Msg("\t")	 MsgN("model.ModelDrawingAngle.r = (CurTime() * " .. self.ModelSpecial_Spin.Angle.r .. " *90)")
		
		MsgN("")
		Msg("\t")	 MsgN("ang:RotateAroundAxis(ang:Forward(), (model.ModelDrawingAngle.p))")
		Msg("\t")	 MsgN("ang:RotateAroundAxis(ang:Up(), (model.ModelDrawingAngle.y))")
		Msg("\t")	 MsgN("ang:RotateAroundAxis(ang:Right(), (model.ModelDrawingAngle.r))")
	end
	
	-- HALO
	if self.ModelSpecial_Halo.Enable == 1 then
		local HC = self.ModelSpecial_Halo.Color
	MsgN("")
	Msg("\t")	 MsgN("halo.Add( {model},")
	Msg("\t")	 MsgN("Color("..HC.r..","..HC.g..","..HC.b.."),")
	Msg("\t")	 MsgN(self.ModelSpecial_Halo.Size ..",")
	Msg("\t")	 MsgN(self.ModelSpecial_Halo.Size ..",")
	Msg("\t")	 MsgN(1 ..")")
	MsgN("")
	end
	
	
	MsgN("")
	Msg("\t")	 MsgN("return model, pos, ang")
	
	MsgN("end")
	
	MsgN("\n\n")
	MsgN("/* ───────────────────────────────────────────────────────────────")
	MsgN("Item Maker has finished work. Copy to here.")
	MsgN("─────────────────────────────────────────────────────────────── */")
	MsgN("\n\n")
end

function PANEL:UpdateModel(model)
	self.Icon:SetModel(model)
	if g_SpawnMenu and g_SpawnMenu:IsValid() then
		g_SpawnMenu:Close()
	end
	
	if self.MainModel then
		self.MainModel:SetModel(model)
	else
		self.MainModel = ClientsideModel(model,RENDER_GROUP_VIEW_MODEL_OPAQUE)
	end
end

function PANEL:OnMouseWheeled(mc)
	self.Zoom = self.Zoom - mc *5
	self.Zoom = math.min(self.Zoom,500)
	self.Zoom = math.max(self.Zoom,40)
	
	self.CamPos = Vector(math.sin(self.CamAngle.y)*self.Zoom,math.cos(self.CamAngle.y)*self.Zoom,self.Height)
end

function PANEL:Think()
	if !self.Hover then return end
		if input.IsMouseDown(MOUSE_LEFT) then
			if !self.LM then
				self.LM = true
				local MX,MY = gui.MousePos()
				self.LastMousePos_X = MX
				self.LastMousePos_Y = MY
			else
				local CX,CY = gui.MousePos()
				local DX,DY = self.LastMousePos_X-CX,self.LastMousePos_Y-CY
				
				self.CamAngle.y = self.CamAngle.y - DX/20
				
				self.Height = self.Height - DY/30
				self.Height = math.min(self.Height,80)
				self.Height = math.max(self.Height,20)
	
				self.CamPos = Vector(self.Zoom,0,self.Height)
				self.ViewPos = Vector(0,0,self.Height)
				
				self.LastMousePos_X = CX
				self.LastMousePos_Y = CY
				
				self.CamPos = Vector(math.sin(self.CamAngle.y)*self.Zoom,math.cos(self.CamAngle.y)*self.Zoom,self.Height)
			end
		else
			if self.LM then
				self.LM = false
			end
		end
		
		
end

function PANEL:MaterialListView()
	self.MatViewPanel = vgui.Create("DPanel",self.LeftBG)
	self.MatViewPanel:SetPos(0,0)
	self.MatViewPanel:SetSize(self.LeftBG:GetSize())
	self.MatViewPanel.Paint = function(slf)
		draw.RoundedBox(3, 0, 0,slf:GetWide(), slf:GetTall(), Color(120,120,120,255))
		draw.RoundedBox(3, 2, 2,slf:GetWide()-4, slf:GetTall()-4, Color(40,40,40,255))
		
		draw.RoundedBox(3, 2, 2,slf:GetWide()-4, 25, Color(80,80,80,255))
		draw.RoundedBox(3, 3, 3,slf:GetWide()-6, 23, Color(20,20,20,255))
		draw.SimpleText("Material List Viewer", "RXF_CoolVOut_S20", 20,5, Color(255,255,255,255))
	end
	
	self.MatLister = vgui.Create("DPanelList",self.MatViewPanel)
	self.MatLister:SetPos(10,40)
	self.MatLister:SetSize(280,self.LeftBG:GetTall()-120)
	self.MatLister:EnableHorizontal( true )
	self.MatLister:SetPadding( 5 )
	self.MatLister:SetSpacing( 5 )
	self.MatLister:EnableVerticalScrollbar( true )
	self.MatLister:PIM_PaintListBarC( )
	self.MatLister.Paint = function(slf)
		draw.RoundedBox(3, 0, 0,slf:GetWide(), slf:GetTall(), Color(20,20,20,255))
	end
	
	for k,v in pairs(PIM_Mats or {}) do
		local MAT = vgui.Create("DImageButton")
		MAT:SetOnViewMaterial(v, v)
		MAT:SetSize(self.MatLister:GetWide()/3-5, self.MatLister:GetWide()/3-5)
		MAT.DoClick = function(slf)
			self.MatIcon:SetOnViewMaterial(v, v)
			self.ModelMaterial = v
			self.MatViewPanel:Remove()
		end
		MAT.OnCursorEntered = function(slf)
			self.ModelMaterial = v
		end
		self.MatLister:AddItem(MAT)
	end
	
	local BTN = vgui.Create("PIM_DSWButton",self.MatViewPanel)
		BTN:SetTexts("Close Viewer")
		BTN:SetPos(10,self:GetTall()-35)
		BTN:SetSize(280,25)
		BTN.DoClick = function(slf)
			self.MatViewPanel:Remove()
		end
end

function PANEL:AttachmentListView(mode)
	if self.AttachmentViewPanel and self.AttachmentViewPanel:IsValid() then
		self.AttachmentViewPanel:Remove()
	end
	self.AttachmentViewPanel = vgui.Create("DPanel",self.LeftBG)
	self.AttachmentViewPanel:SetPos(0,0)
	self.AttachmentViewPanel:SetSize(self.LeftBG:GetSize())
	self.AttachmentViewPanel.Paint = function(slf)
		draw.RoundedBox(3, 0, 0,slf:GetWide(), slf:GetTall(), Color(120,120,120,255))
		draw.RoundedBox(3, 2, 2,slf:GetWide()-4, slf:GetTall()-4, Color(40,40,40,255))
		
		draw.RoundedBox(3, 2, 2,slf:GetWide()-4, 25, Color(80,80,80,255))
		draw.RoundedBox(3, 3, 3,slf:GetWide()-6, 23, Color(20,20,20,255))
		draw.SimpleText("Attachment List Viewer", "RXF_CoolVOut_S20", 20,5, Color(255,255,255,255))
	end
	
	self.AttachLister = vgui.Create("DPanelList",self.AttachmentViewPanel)
	self.AttachLister:SetPos(10,40)
	self.AttachLister:SetSize(280,self.LeftBG:GetTall()-120)
	self.AttachLister:EnableHorizontal( false )
	self.AttachLister:SetPadding( 5 )
	self.AttachLister:SetSpacing( 5 )
	self.AttachLister:EnableVerticalScrollbar( true )
	self.AttachLister:PIM_PaintListBarC( )
	self.AttachLister.Paint = function(slf)
		draw.RoundedBox(3, 0, 0,slf:GetWide(), slf:GetTall(), Color(20,20,20,255))
	end
	
	local function AddTitle(text)
		local BG = vgui.Create("DPanel")
		BG:SetSize( self.LeftBG:GetWide()-20,24 )
		BG.Paint = function(slf)
			draw.RoundedBox(3, 0, 0,slf:GetWide(), slf:GetTall(), Color(50,50,50,255))
			draw.SimpleText(text, "RXF_CoolVOut_S20", 10,2, Color(255,255,255,255))
		end
		self.AttachLister:AddItem(BG)
	end
	
	if mode == "bone" then
		-- Bone Browser
		AddTitle("Bone Browser")
		
			
		for i=0, LocalPlayer():GetBoneCount() - 1 do
			local bone_id = LocalPlayer():LookupBone(LocalPlayer():GetBoneName(i))
			if bone_id then
			local BTN = vgui.Create("PIM_DSWButton")
				BTN:SetTexts(LocalPlayer():GetBoneName(i))
				BTN:SetSize(self.AttachLister:GetWide()-30,25)
				BTN.DoClick = function(slf)
					self.ModelBone = LocalPlayer():GetBoneName(i)
					self.ModelAttachment = nil
					if self.BoneChooseButton then
						self.BoneChooseButton:SetTexts("Bone : " .. self.ModelBone)
					end
					if self.AttachmentChooseButton then
						self.AttachmentChooseButton:SetTexts("Attachment : " .. "Not Selected")
					end
					self.AttachmentViewPanel:Remove()
				end
				BTN.CursorEnter = function(slf)
					self.ModelBone = LocalPlayer():GetBoneName(i)
					self.ModelAttachment = nil
					if self.BoneChooseButton then
						self.BoneChooseButton:SetTexts("Bone : " .. self.ModelBone)
					end
					if self.AttachmentChooseButton then
						self.AttachmentChooseButton:SetTexts("Attachment : " .. "Not Selected")
					end
				end
				self.AttachLister:AddItem(BTN)
			end
		end
	end
	
	if mode == "attachment" then
		-- Attachment Browser
		AddTitle("Attachment Browser")

	
		for num,db in pairs(LocalPlayer():GetAttachments()) do
			local att_id = LocalPlayer():LookupAttachment(db.name)
			if att_id then
			local BTN = vgui.Create("PIM_DSWButton")
				BTN:SetTexts(db.name)
				BTN:SetSize(self.AttachLister:GetWide()-30,25)
				BTN.DoClick = function(slf)
					self.ModelAttachment = db.name
					self.ModelBone = nil
					if self.BoneChooseButton then
						self.BoneChooseButton:SetTexts("Bone : " .. "Not Selected")
					end
					if self.AttachmentChooseButton then
						self.AttachmentChooseButton:SetTexts("Attachment : " .. db.name)
					end
					self.AttachmentViewPanel:Remove()
				end
				BTN.CursorEnter = function(slf)
					self.ModelAttachment = db.name
					self.ModelBone = nil
					if self.BoneChooseButton then
						self.BoneChooseButton:SetTexts("Bone : " .. "Not Selected")
					end
					if self.AttachmentChooseButton then
						self.AttachmentChooseButton:SetTexts("Attachment : " .. db.name)
					end
				end
				self.AttachLister:AddItem(BTN)
			end
		end
	end
	

	
	
	
	local BTN = vgui.Create("PIM_DSWButton",self.AttachmentViewPanel)
		BTN:SetTexts("Close Viewer")
		BTN:SetPos(10,self:GetTall()-35)
		BTN:SetSize(280,25)
		BTN.DoClick = function(slf)
			self.AttachmentViewPanel:Remove()
		end
end

function PANEL:Install()
	self:ShowCloseButton(false)
	self:SetTitle("")
	self:SetDraggable(false)
	
	self.LeftBG = vgui.Create("DPanel",self)
	self.LeftBG:SetPos(0,0)
	self.LeftBG:SetSize(300,self:GetTall())
	self.LeftBG.Paint = function(slf)
		draw.RoundedBox(3, 0, 0,slf:GetWide(), slf:GetTall(), Color(120,120,120,255))
		draw.RoundedBox(3, 2, 2,slf:GetWide()-4, slf:GetTall()-4, Color(40,40,40,255))
		
		draw.RoundedBox(3, 2, 2,slf:GetWide()-4, 25, Color(80,80,80,255))
		draw.RoundedBox(3, 3, 3,slf:GetWide()-6, 23, Color(20,20,20,255))
		draw.SimpleText("PointShop Item Maker", "RXF_CoolVOut_S20", 20,5, Color(255,255,255,255))
	end
	
	self.Lister = vgui.Create("DPanelList",self.LeftBG)
	self.Lister:SetPos(10,40)
	self.Lister:SetSize(280,self.LeftBG:GetTall()-120)
	self.Lister:EnableHorizontal( false )
	self.Lister:SetPadding( 5 )
	self.Lister:SetSpacing( 5 )
	self.Lister:EnableVerticalScrollbar( true )
	self.Lister:PIM_PaintListBarC( )
	self.Lister.Paint = function(slf)
		draw.RoundedBox(3, 0, 0,slf:GetWide(), slf:GetTall(), Color(20,20,20,255))
	end
	
	local function AddTitle(text)
		local BG = vgui.Create("DPanel")
		BG:SetSize( self.LeftBG:GetWide()-20,24 )
		BG.Paint = function(slf)
			draw.RoundedBox(3, 0, 0,slf:GetWide(), slf:GetTall(), Color(50,50,50,255))
			draw.SimpleText(text, "RXF_CoolVOut_S20", 10,2, Color(255,255,255,255))
		end
		self.Lister:AddItem(BG)
	end
	
	-- PrintName Editor
	AddTitle("PrintName Editor")
		local Namer = vgui.Create("DTextEntry")
		Namer:SetSize( self.LeftBG:GetWide()-20,25 )
		Namer:SetAllowNonAsciiCharacters( true )
		Namer:SetText(self.ItemName)
		Namer.OnTextChanged = function(slf)
			self.ItemName = slf:GetValue()
		end
		self.Lister:AddItem(Namer)
		
	-- Price Editor
	AddTitle("Price Editor")
	local BG = vgui.Create("DPanel")
	BG:SetSize( self.LeftBG:GetWide()-20,50 )
		BG.Paint = function(slf)
			draw.RoundedBox(3, 0, 0,slf:GetWide(), slf:GetTall(), Color(30,30,30,255))
		end
	self.Lister:AddItem(BG)
		local NumSlider = vgui.Create( "PIM_Sliders",BG)
		NumSlider:SetPos( 5,5 )
		NumSlider:SetSize( BG:GetWide()-30,40 )
		NumSlider:SetMin( 0 )
		NumSlider:SetMax( 100000000 )
		NumSlider:SetDemical( 2 )
		NumSlider:SetName( "Price" )
		NumSlider:SetUp(  )
		NumSlider:SetValue(self.ItemPrice)
		NumSlider.OnValueChanged = function(slf,val)
			self.ItemPrice = val
		end
	
	-- Model Selector
	AddTitle("Model Selector")
		local BG = vgui.Create("DPanel")
		BG:SetSize( self.LeftBG:GetWide()-20,80 )
			BG.Paint = function(slf)
				draw.RoundedBox(3, 0, 0,slf:GetWide(), slf:GetTall(), Color(30,30,30,255))
				if self.MainModel and self.MainModel:IsValid() and self.MainModel:GetModel() then
					draw.SimpleText("Model", "RXF_Treb_S25", (slf:GetWide()-70)/2 + 70,10, Color(255,255,255,255),TEXT_ALIGN_CENTER)
					draw.SimpleText("Selected!", "RXF_Treb_S25", (slf:GetWide()-70)/2 + 70,40, Color(255,255,255,255),TEXT_ALIGN_CENTER)
				else
					draw.SimpleText("Plese Select", "RXF_Treb_S25", (slf:GetWide()-70)/2 + 70,10, Color(255,255,255,255),TEXT_ALIGN_CENTER)
					draw.SimpleText("Model", "RXF_Treb_S25", (slf:GetWide()-70)/2 + 70,40, Color(255,255,255,255),TEXT_ALIGN_CENTER)
				end
			end
		self.Lister:AddItem(BG)
		
		self.Icon = vgui.Create("SpawnIcon",BG)
		self.Icon:SetSize(60,60)
		self.Icon:SetPos(10,10)
		self.Icon.DoClick = function(slf)
			if g_SpawnMenu then
				g_SpawnMenu:Open()
			end
		end
		
	-- Material Selector
	AddTitle("Material Selector")
		local BG = vgui.Create("DPanel")
		BG:SetSize( self.LeftBG:GetWide()-20,80 )
			BG.Paint = function(slf)
				draw.RoundedBox(3, 0, 0,slf:GetWide(), slf:GetTall(), Color(30,30,30,255))
				
				if self.MatIcon then
					local PX,PY = self.MatIcon:GetPos()
					local SX,SY = self.MatIcon:GetSize()
					draw.RoundedBox(1, PX, PY,SX, SY, Color(30,255,255,255))
					draw.RoundedBox(1, PX+1,PY+1,SX-2, SY-2, Color(30,30,30,255))
				end
				
				if self.ModelMaterial and self.ModelMaterial != "" then
					draw.SimpleText("Material", "RXF_Treb_S25", (slf:GetWide()-70)/2 + 70,8, Color(255,255,255,255),TEXT_ALIGN_CENTER)
					draw.SimpleText("Selected!", "RXF_Treb_S25", (slf:GetWide()-70)/2 + 70,31, Color(255,255,255,255),TEXT_ALIGN_CENTER)
					draw.SimpleText("Click Button to remove", "RXF_Treb_S18", (slf:GetWide()-70)/2 + 70,60, Color(255,255,255,255),TEXT_ALIGN_CENTER)
				else
					draw.SimpleText("Plese Select", "RXF_Treb_S25", (slf:GetWide()-70)/2 + 70,10, Color(255,255,255,255),TEXT_ALIGN_CENTER)
					draw.SimpleText("Material", "RXF_Treb_S25", (slf:GetWide()-70)/2 + 70,40, Color(255,255,255,255),TEXT_ALIGN_CENTER)
				end
				
			end
		self.Lister:AddItem(BG)
		
		self.MatIcon = vgui.Create("DImageButton",BG)
		self.MatIcon:SetSize(60,60)
		self.MatIcon:SetPos(10,10)
		self.MatIcon.DoClick = function(slf)
			if self.ModelMaterial and self.ModelMaterial == "" then
				self:MaterialListView()
			else
				self.ModelMaterial = ''
			end
			
		end
	
	-- Bone Selector
	AddTitle("Bone&Attachment Selector")
		local BG = vgui.Create("DPanel")
		BG:SetSize( self.LeftBG:GetWide()-20,100 )
			BG.Paint = function(slf)
				draw.RoundedBox(3, 0, 0,slf:GetWide(), slf:GetTall(), Color(30,30,30,255))
				draw.SimpleText("Recommand to use attachments.", "RXF_TrebOut_S20", slf:GetWide()/2,2, Color(255,255,255,255),TEXT_ALIGN_CENTER)
			end
		self.Lister:AddItem(BG)
		
		local BTN = vgui.Create("PIM_DSWButton",BG) self.BoneChooseButton = BTN
			if !self.ModelBone then
				BTN:SetTexts("Bone : Not Selected")
			else
				BTN:SetTexts("Bone : " .. self.ModelBone)
			end
			BTN:SetPos(10,30)
			BTN:SetSize(BG:GetWide()-40,25)
			BTN.DoClick = function(slf)
				self:AttachmentListView("bone")
			end
			
		
		local BTN = vgui.Create("PIM_DSWButton",BG) self.AttachmentChooseButton = BTN
			if !self.ModelAttachment then
				BTN:SetTexts("Attachment : Not Selected")
			else
				BTN:SetTexts("Attachment : " .. self.ModelAttachment)
			end
			BTN:SetPos(10,65)
			BTN:SetSize(BG:GetWide()-40,25)
			BTN.DoClick = function(slf)
				self:AttachmentListView("attachment")
			end
		
			
	-- Position Editor
	AddTitle("Position Editor")
	local BG = vgui.Create("DPanel")
	BG:SetSize( self.LeftBG:GetWide()-20,125 )
		BG.Paint = function(slf)
			draw.RoundedBox(3, 0, 0,slf:GetWide(), slf:GetTall(), Color(30,30,30,255))
		end
	self.Lister:AddItem(BG)
	
		local NumSlider = vgui.Create( "PIM_Sliders",BG)
		NumSlider:SetPos( 10,5 )
		NumSlider:SetSize( BG:GetWide()-30,40 )
		NumSlider:SetMin( -300 )
		NumSlider:SetMax( 300 )
		NumSlider:SetDemical( 2 )
		NumSlider:SetName( "Position X" )
		NumSlider:SetUp(  )
		NumSlider:SetValue(self.ModelPos.x)
		NumSlider.OnValueChanged = function(slf,val)
			self.ModelPos.x = val
		end
	
		local NumSlider = vgui.Create( "PIM_Sliders",BG)
		NumSlider:SetPos( 10,45 )
		NumSlider:SetSize( BG:GetWide()-30,40 )
		NumSlider:SetMin( -300 )
		NumSlider:SetMax( 300 )
		NumSlider:SetDemical( 2 )
		NumSlider:SetName( "Position Y" )
		NumSlider:SetUp(  )
		NumSlider:SetValue(self.ModelPos.y)
		NumSlider.OnValueChanged = function(slf,val)
			self.ModelPos.y = val
		end
	
		local NumSlider = vgui.Create( "PIM_Sliders",BG)
		NumSlider:SetPos( 10,85 )
		NumSlider:SetSize( BG:GetWide()-30,40 )
		NumSlider:SetMin( -300 )
		NumSlider:SetMax( 300 )
		NumSlider:SetDemical( 2 )
		NumSlider:SetName( "Position Z" )
		NumSlider:SetUp(  )
		NumSlider:SetValue(self.ModelPos.z)
		NumSlider.OnValueChanged = function(slf,val)
			self.ModelPos.z = val
		end
	
	-- Angle Editor
	AddTitle("Angle Editor")
	local BG = vgui.Create("DPanel")
	BG:SetSize( self.LeftBG:GetWide()-20,125 )
		BG.Paint = function(slf)
			draw.RoundedBox(3, 0, 0,slf:GetWide(), slf:GetTall(), Color(30,30,30,255))
		end
	self.Lister:AddItem(BG)
	
		local NumSlider = vgui.Create( "PIM_Sliders",BG)
		NumSlider:SetPos( 10,5 )
		NumSlider:SetSize( BG:GetWide()-30,40 )
		NumSlider:SetMin( 0 )
		NumSlider:SetMax( 360 )
		NumSlider:SetDemical( 2 )
		NumSlider:SetName( "Angle P" )
		NumSlider:SetUp(  )
		NumSlider:SetValue(self.ModelAngle.p)
		NumSlider.OnValueChanged = function(slf,val)
			self.ModelAngle.p = val
		end
	
		local NumSlider = vgui.Create( "PIM_Sliders",BG)
		NumSlider:SetPos( 10,45 )
		NumSlider:SetSize( BG:GetWide()-30,40 )
		NumSlider:SetMin( 0 )
		NumSlider:SetMax( 360 )
		NumSlider:SetDemical( 2 )
		NumSlider:SetName( "Angle Y" )
		NumSlider:SetUp(  )
		NumSlider:SetValue(self.ModelAngle.y)
		NumSlider.OnValueChanged = function(slf,val)
			self.ModelAngle.y = val
		end
	
		local NumSlider = vgui.Create( "PIM_Sliders",BG)
		NumSlider:SetPos( 10,85 )
		NumSlider:SetSize( BG:GetWide()-30,40 )
		NumSlider:SetMin( 0 )
		NumSlider:SetMax( 360 )
		NumSlider:SetDemical( 2 )
		NumSlider:SetName( "Angle R" )
		NumSlider:SetUp(  )
		NumSlider:SetValue(self.ModelAngle.r)
		NumSlider.OnValueChanged = function(slf,val)
			self.ModelAngle.r = val
		end
		
		
		
	-- Size Editor
	AddTitle("Size Editor")
	local BG = vgui.Create("DPanel")
	BG:SetSize( self.LeftBG:GetWide()-20,125 )
		BG.Paint = function(slf)
			draw.RoundedBox(3, 0, 0,slf:GetWide(), slf:GetTall(), Color(30,30,30,255))
		end
	self.Lister:AddItem(BG)
	
		local NumSlider = vgui.Create( "PIM_Sliders",BG)
		NumSlider:SetPos( 10,5 )
		NumSlider:SetSize( BG:GetWide()-30,40 )
		NumSlider:SetMin( 0 )
		NumSlider:SetMax( 5 )
		NumSlider:SetDemical( 2 )
		NumSlider:SetName( "Size X" )
		NumSlider:SetUp(  )
		NumSlider:SetValue(self.ModelSize.x)
		NumSlider.OnValueChanged = function(slf,val)
			self.ModelSize.x = val
		end
	
		local NumSlider = vgui.Create( "PIM_Sliders",BG)
		NumSlider:SetPos( 10,45 )
		NumSlider:SetSize( BG:GetWide()-30,40 )
		NumSlider:SetMin( 0 )
		NumSlider:SetMax( 5 )
		NumSlider:SetDemical( 2 )
		NumSlider:SetName( "Size Y" )
		NumSlider:SetUp(  )
		NumSlider:SetValue(self.ModelSize.y)
		NumSlider.OnValueChanged = function(slf,val)
			self.ModelSize.y = val
		end
	
		local NumSlider = vgui.Create( "PIM_Sliders",BG)
		NumSlider:SetPos( 10,85 )
		NumSlider:SetSize( BG:GetWide()-30,40 )
		NumSlider:SetMin( 0 )
		NumSlider:SetMax( 5 )
		NumSlider:SetDemical( 2 )
		NumSlider:SetName( "Size Z" )
		NumSlider:SetUp(  )
		NumSlider:SetValue(self.ModelSize.z)
		NumSlider.OnValueChanged = function(slf,val)
			self.ModelSize.z = val
		end
		
	-- Special : Spinning FX
	self.ModelSpecial_Spin = {}
	self.ModelSpecial_Spin.Enable = 0
	self.ModelSpecial_Spin.Angle = Angle(0,0,0)
	AddTitle("Special - Spinning FX")
		local BG = vgui.Create("DPanel")
		BG:SetSize( self.LeftBG:GetWide()-20,180 )
			BG.Paint = function(slf)
				draw.RoundedBox(3, 0, 0,slf:GetWide(), slf:GetTall(), Color(30,30,30,255))
			end
		self.Lister:AddItem(BG)
		
		local CheckBoxThing = vgui.Create( "DCheckBoxLabel", BG )
		CheckBoxThing:SetPos( 10,10 )
		CheckBoxThing:SetSize( BG:GetWide()-30,20 )
		CheckBoxThing:SetText( "Enable ?" )
		CheckBoxThing:SetChecked( false )
		CheckBoxThing.OnChange = function(slf)
			self.ModelDrawingAngle = Angle(0,0,0)
			if slf:GetChecked() then
				self.ModelSpecial_Spin.Enable = 1
			else
				self.ModelSpecial_Spin.Enable = 0
			end
		end
		
		local NumSlider = vgui.Create( "PIM_Sliders",BG)
		NumSlider:SetPos( 10,40 )
		NumSlider:SetSize( BG:GetWide()-30,40 )
		NumSlider:SetMin( 0 )
		NumSlider:SetMax( 10 )
		NumSlider:SetDemical( 2 )
		NumSlider:SetName( "Angle Speed P" )
		NumSlider:SetUp(  )
		NumSlider:SetValue(self.ModelSpecial_Spin.Angle.p)
		NumSlider.OnValueChanged = function(slf,val)
			self.ModelDrawingAngle = Angle(0,0,0)
			self.ModelSpecial_Spin.Angle.p = val
		end
		
		local NumSlider = vgui.Create( "PIM_Sliders",BG)
		NumSlider:SetPos( 10,80 )
		NumSlider:SetSize( BG:GetWide()-30,40 )
		NumSlider:SetMin( 0 )
		NumSlider:SetMax( 10 )
		NumSlider:SetDemical( 2 )
		NumSlider:SetName( "Angle Speed Y" )
		NumSlider:SetUp(  )
		NumSlider:SetValue(self.ModelSpecial_Spin.Angle.y)
		NumSlider.OnValueChanged = function(slf,val)
			self.ModelDrawingAngle = Angle(0,0,0)
			self.ModelSpecial_Spin.Angle.y = val
		end
		
		local NumSlider = vgui.Create( "PIM_Sliders",BG)
		NumSlider:SetPos( 10,120 )
		NumSlider:SetSize( BG:GetWide()-30,40 )
		NumSlider:SetMin( 0 )
		NumSlider:SetMax( 10 )
		NumSlider:SetDemical( 2 )
		NumSlider:SetName( "Angle Speed R" )
		NumSlider:SetUp(  )
		NumSlider:SetValue(self.ModelSpecial_Spin.Angle.r)
		NumSlider.OnValueChanged = function(slf,val)
			self.ModelDrawingAngle = Angle(0,0,0)
			self.ModelSpecial_Spin.Angle.r = val
		end
		
		
	-- Special : Halo
	self.ModelSpecial_Halo = {}
	self.ModelSpecial_Halo.Enable = 0
	self.ModelSpecial_Halo.Size = 1
	self.ModelSpecial_Halo.Color = Color(255,255,255,255)
	AddTitle("Special - Halo FX")
		local BG = vgui.Create("DPanel")
		BG:SetSize( self.LeftBG:GetWide()-20,300 )
			BG.Paint = function(slf)
				draw.RoundedBox(3, 0, 0,slf:GetWide(), slf:GetTall(), Color(30,30,30,255))
			end
		self.Lister:AddItem(BG)
		
		local CheckBoxThing = vgui.Create( "DCheckBoxLabel", BG )
		CheckBoxThing:SetPos( 10,10 )
		CheckBoxThing:SetSize( BG:GetWide()-20,20 )
		CheckBoxThing:SetText( "Enable ?" )
		CheckBoxThing:SetChecked( false )
		CheckBoxThing.OnChange = function(slf)
			if slf:GetChecked() then
				self.ModelSpecial_Halo.Enable = 1
			else
				self.ModelSpecial_Halo.Enable = 0
			end
		end
		
		local NumSlider = vgui.Create( "PIM_Sliders",BG)
		NumSlider:SetPos( 10,30 )
		NumSlider:SetSize( BG:GetWide()-30,40 )
		NumSlider:SetMin( 0 )
		NumSlider:SetMax( 10 )
		NumSlider:SetDemical( 1 )
		NumSlider:SetName( "Size" )
		NumSlider:SetUp(  )
		NumSlider:SetValue(self.ModelSpecial_Halo.Size)
		NumSlider.OnValueChanged = function(slf,val)
			self.ModelSpecial_Halo.Size = val
		end
		
		local color = vgui.Create( "DColorMixer",BG);
		color:SetSize( BG:GetWide()-30, 220);
		color:SetPos( 10, 70 );
		color:SetColor(Color(255,255,255,255))
		color.ValueChanged = function(slf,col)
			self.ModelSpecial_Halo.Color = col
		end
	
	local BTN = vgui.Create("PIM_DSWButton",self.LeftBG)
		BTN:SetTexts("Copy Itemcode to clipboard")
		BTN:SetPos(10,self:GetTall()-70)
		BTN:SetSize(280,25)
		BTN.DoClick = function(slf)
			self:PrintCodeToConsole()
		end
	
	local BTN = vgui.Create("PIM_DSWButton",self.LeftBG)
		BTN:SetTexts("Close Editor")
		BTN:SetPos(10,self:GetTall()-35)
		BTN:SetSize(280,25)
		BTN.DoClick = function(slf)
			PIM_CloseEditor()
			
		--	PIM_OpenEditor()
		end
end

function PANEL:OnCursorEntered()
	self.Hover = true
end
function PANEL:OnCursorExited()
	self.Hover = false
end


function PANEL:Paint()
		if !self.MainModel then return end
			local Size = self.ModelSize
			
			-- Scaler
				local mat = Matrix()
				mat:Scale(Size)
				self.MainModel:EnableMatrix("RenderMultiply", mat)
				
			-- Mat
				local Material = self.ModelMaterial
				self.MainModel:SetMaterial(Material)
			
			local Pos = Vector(self.ModelPos.x,self.ModelPos.y,self.ModelPos.z)
			Pos = LocalPlayer():GetPos()+Pos
			
			local Ang = Angle(0,0,0)
			local ColorK = self.ModelColor
			
			if self.ModelAttachment then
				local attach_id = LocalPlayer():LookupAttachment(self.ModelAttachment)
				if !attach_id then return end
						
				local attach = LocalPlayer():GetAttachment(attach_id)
						
				if !attach then return end
						
				Pos = attach.Pos
				Ang = attach.Ang
			elseif self.ModelBone then
				local bone_id = LocalPlayer():LookupBone(self.ModelBone)
				if !bone_id then return end
						
				Pos, Ang = LocalPlayer():GetBonePosition(bone_id)
			end
			
			local MAngle = self.ModelAngle
			local MPos = self.ModelPos


			
			self.ModelDrawingAngle = self.ModelDrawingAngle or Angle(0,0,0)
			
			MAngle = self.ModelAngle
			
			Pos = Pos + (Ang:Forward() * MPos.x) + (Ang:Up() * MPos.z) + (Ang:Right() * MPos.y)

			local forward, right, up = Ang:Forward(), Ang:Right(), Ang:Up()

			local pos_offset = MPos * LocalPlayer():GetModelScale()
			local ang_offset = MAngle	

			local pos_off = (up*(pos_offset.z or 0)) + (right*(pos_offset.y or 0)) + (forward*(pos_offset.x or 0))

			Ang:RotateAroundAxis( right, 	ang_offset.p or 0 )
			Ang:RotateAroundAxis( forward, 	ang_offset.y or 0 )
			Ang:RotateAroundAxis( up, 		ang_offset.r or 0 )

			local nPos = Pos + pos_off
		
			self.MainModel:SetMaterial(self.ModelMaterial)
			self.MainModel:SetPos(Pos)
			self.MainModel:SetAngles(Ang)
			self.MainModel:DrawModel()

end

vgui.Register("PIM_Editor",PANEL,"DFrame")

end