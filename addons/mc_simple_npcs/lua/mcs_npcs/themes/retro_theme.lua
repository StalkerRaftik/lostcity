MCS.Themes["Retro"] = {}

if SERVER then return end

MCS.Themes["Retro"].Paint = function(self, w, h, fade)
	draw.RoundedBox( 24, 0, 0, w, h, Color( 0, 0, 0, fade)) 
end

local NewFont = surface.CreateFont
NewFont( "MCS_RetroMain", { font = "DPix_8pt", extended = true, size = 32, antialias = true, weight = 800} )
NewFont( "MCS_RetroSub", { font = "DPix_8pt", extended = true, size = 32, antialias = true, weight = 800} )

MCS.Themes["Retro"].Fonts = {"MCS_RetroMain", "MCS_RetroSub", TEXT_ALIGN_CENTER}

MCS.Themes["Retro"].Colors = {
	NPCTextColor = Color(255,255,255),
	TextColor = Color(150,150,150),
	HighlightColor = Color(255,255,255)
}