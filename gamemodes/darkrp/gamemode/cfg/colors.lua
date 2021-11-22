color_white = Color(255,255,255)
rp.col = {
	core 		= Color(50, 60, 69, 200),

	-- Misc
	Black 		= Color(0,0,0),
	White 		= Color(200,200,200),
	Red 		= Color(245,0,0),
	Orange 		= Color(245,120,0),
	Purple 		= Color(180,50,200),
	Green 		= Color(50,200,50),
	Grey 		= Color(150,150,150),
	Yellow 		= Color(255,255,51),
	Pink 		= Color(245,120,120),

	-- Chat
	OOC 		= Color(100,255,150),
	-- UI 
	Background 		= Color(0,0,0,230),
	Outline 		= Color(190,190,190,200),
	Highlight 		= Color(255,255,255,125),
	Button 			= Color(120,120,120),
	ButtonHovered	= Color(51,128,255),
}

-- Chat Colors
rp.chatcolors = {}
for k, v in pairs(rp.col) do
	local count = #rp.chatcolors + 1
	rp.chatcolors[k] = count
	rp.chatcolors[count] = v
end

color_white = Color(255,255,255)
