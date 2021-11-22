AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = 'Редактор / Создатель зомби спавнов'
	SWEP.Slot = 1
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = true
end

SWEP.Author = ""
SWEP.Instructions = 'ЛКМ - Поставить точку, ПКМ - Поставить точку на своём месте, R - Меню'
SWEP.Contact = ""
SWEP.Purpose = ""

SWEP.WorldModel	= ""

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.AnimPrefix	 = "rpg"

SWEP.m_WeaponDeploySpeed = 5

SWEP.UseHands = true

SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Category = "LostCity Weapon Admin"
SWEP.Sound = "doors/door_latch3.wav"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

function SWEP:Initialize()
	self:SetHoldType("normal")
	LocalPlayer().coords = LocalPlayer().coords or {}
	CreateClientConVar( "propertycrearion_name", "0", true, false )
	CreateClientConVar( "propertycrearion_height", "200", true, false )
	CreateClientConVar( "propertycrearion_price", "200", true, false )
end

function SWEP:Holster()
	return true
end

function SWEP:PreDrawViewModel()
	return true
end

if CLIENT then
	function SWEP:DrawHUD()	
		hook.Add("PostDrawOpaqueRenderables", "PostDrawOpaqueLines", function()
		for k, v in pairs(LocalPlayer().coords) do
			cam.Start3D2D(v, Angle(0, 0, 0), 1)
				surface.SetDrawColor(Color( 255, 0, 0, 255 ))
				surface.DrawLine(-10, 0, 10, 0)
				surface.DrawLine(0, -10, 0, 10)
			cam.End3D2D()

			cam.Start3D2D(v-Vector(0, 0.5, 0), Angle(0, 0, -90), 1)
				surface.SetDrawColor(Color( 255, 200, 0, 255 ))
				surface.DrawLine(0, GetConVar("propertycrearion_height"):GetInt(), 0, 0)
			cam.End3D2D()

			cam.Start3D2D(v+Vector(0, 0, GetConVar("propertycrearion_height"):GetInt()), Angle(0, 0, 0), 1)
				surface.SetDrawColor(Color( 255, 0, 0, 255 ))
				surface.DrawLine(-10, 0, 10, 0)
				surface.DrawLine(0, -10, 0, 10)
			cam.End3D2D()

			if LocalPlayer().coords[k + 1] then
				render.DrawLine(v,  LocalPlayer().coords[k + 1], Color( 255, 255, 0, 255 ), true)
				render.DrawLine(v+Vector(0, 0, GetConVar("propertycrearion_height"):GetInt()),  LocalPlayer().coords[k + 1]+Vector(0, 0, GetConVar("propertycrearion_height"):GetInt()), Color( 255, 255, 0, 255 ), true)
			else
				render.DrawLine(v, LocalPlayer().coords[1], Color( 255, 255, 0, 255 ), true)
				render.DrawLine(v+Vector(0, 0, GetConVar("propertycrearion_height"):GetInt()), LocalPlayer().coords[1]+Vector(0, 0, GetConVar("propertycrearion_height"):GetInt()), Color( 255, 255, 0, 255 ), true)
			end
		end
			
		end)
	end
end

function SWEP:PrimaryAttack()
	if not IsFirstTimePredicted() then return end
	if CLIENT then
		print(1)
		table.insert(LocalPlayer().coords, LocalPlayer():GetEyeTrace().HitPos)
	end
end

function SWEP:SecondaryAttack()
	if not IsFirstTimePredicted() then return end
	if CLIENT then
		print(2)
		table.insert(LocalPlayer().coords, LocalPlayer():GetPos())
	end
end

function SWEP:Reload() 
	--LocalPlayer().coords = {}
	if CLIENT then
		if ValidPanel(self.Main) then return false end
		self.Main = vgui.Create( "DFrame" )
		self.Main:Center()
		self.Main:SetSize( 300, 350 )
		self.Main:SetTitle( "Редактирование параметров" )
		self.Main:SetVisible( true )
		self.Main:SetDraggable( true )
		self.Main:ShowCloseButton( true )
		self.Main:MakePopup()


		local NameEntry = vgui.Create( "DTextEntry", self.Main )
		NameEntry:SetSize( self.Main:GetWide()/1.05, 20 )
		NameEntry:SetPos(7,self.Main:GetTall()*0.1)
		NameEntry:SetText( "Введите название" )
		NameEntry.OnEnter = function( self )
			RunConsoleCommand('propertycrearion_price', self:GetValue())
		end

		local HeightSlider = vgui.Create( "DNumSlider", self.Main )
		HeightSlider:SetPos(7,self.Main:GetTall()*0.18)			
		HeightSlider:SetSize( self.Main:GetWide()/1.05, 20 )	
		HeightSlider:SetText( "Высота" )	
		HeightSlider:SetMin( 0 )			
		HeightSlider:SetMax( 10000 )			
		HeightSlider:SetDecimals( 0 )			
		HeightSlider:SetConVar( "propertycrearion_height" ) 

		local CreateButton = vgui.Create( "DButton", self.Main )
		CreateButton:SetPos(7,self.Main:GetTall()*0.32)			
		CreateButton:SetSize( self.Main:GetWide()/1.05, 20 )	
		CreateButton:SetText( "Создать" )	
		CreateButton.DoClick = function()		
			RunConsoleCommand('propertycrearion_name', NameEntry:GetValue())
			RunConsoleCommand('generateproperty')			
		end

		local ResetButton = vgui.Create( "DButton", self.Main )
		ResetButton:SetPos(7,self.Main:GetTall()*0.38)			
		ResetButton:SetSize( self.Main:GetWide()/1.05, 20 )	
		ResetButton:SetText( "Сбросить" )
		ResetButton.DoClick = function()			
			LocalPlayer().coords = {}			
		end		
	end
end
concommand.Add("generateproperty", function( ply, cmd, args )
	local text = [[Properties.PropertyDoorsBuisnes[id] = {
	["price"] = ]]..GetConVar("propertycrearion_price"):GetInt()..[[, 
	["name"] = ]]..GetConVar("propertycrearion_name"):GetString()..[[, 
	height = ]]..GetConVar("propertycrearion_height"):GetInt()..[[, 
	coords = {
]]

	if LocalPlayer().coords then
		for k, v in pairs(LocalPlayer().coords) do
			text = text .. "		["..k.."] = Vector("..v.x..", "..v.y..", "..v.z..")"
			if LocalPlayer().coords[k+1] then
				text = text..[[,
]]
			end
		end
	else
		chat.AddText(Color(255, 0, 0), "You forget to add a point for "..GetConVar("territory_printName"):GetString())
		return
	end


text = text..[[

	}
}
]]
	
	SetClipboardText(text)
	print(text)
end)