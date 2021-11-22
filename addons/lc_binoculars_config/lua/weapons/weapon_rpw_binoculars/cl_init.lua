include( "shared.lua" )

language.Add("weapon_rpw_binoculars", "Binoculars")

surface.CreateFont( "rangefinder", {
	font = "TargetID",
	extended = false,
	size = 32,
	weight = 600,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

SWEP.PrintName 				= "Бинокль"
SWEP.Slot 					= 0
SWEP.SlotPos 				= 1
SWEP.DrawAmmo 				= false
SWEP.DrawCrosshair 			= false
SWEP.ViewModelFlip 			= false

SWEP.WepSelectIcon 			= surface.GetTextureID("vgui/swepicons/weapon_rpw_binoculars")
SWEP.DrawWeaponInfoBox		= false
SWEP.BounceWeaponIcon 		= false 

SWEP.ViewModelFOV			= 65

function SWEP:DrawHUD()
	if (self.Zoom_InZoom) then
		local mat_bino_overlay = Material( "vgui/hud/rpw_binoculars_overlay" )
		local w = ScrW()
		local h = ScrH()
		surface.SetMaterial( mat_bino_overlay )
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawTexturedRect( 0 ,-(w-h)/2 ,w ,w )
		

		
		surface.SetFont( "rangefinder" )
		surface.SetTextColor( 255, 255, 255, 255 )
		
		local zoom = math.ceil(90/self.Owner:GetFOV())
		
		surface.SetTextPos( (w*0.775), (h/2) + 16 )
		surface.DrawText( "Кратность: "..zoom.."x" )
	end
end

function SWEP:AdjustMouseSensitivity()
	if (self.Zoom_InZoom) then
		local zoom = 90/self.Owner:GetFOV()
		local adjustedsens = 1 / zoom
		return adjustedsens
	end
end


