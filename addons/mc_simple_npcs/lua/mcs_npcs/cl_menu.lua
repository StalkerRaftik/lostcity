--  _______               __          _______  __                   __          _______  ______  ______        
-- |   |   |.---.-..----.|  |.-----. |     __||__|.--------..-----.|  |.-----. |    |  ||   __ \|      |.-----.
-- |       ||  _  ||  __| |_||__ --| |__     ||  ||        ||  _  ||  ||  -__| |       ||    __/|   ---||__ --|
-- |__|_|__||___._||____|    |_____| |_______||__||__|__|__||   __||__||_____| |__|____||___|   |______||_____|
--                                                          |__|                                               

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////// Warning! Edit this only if you know what are you doing ///////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

net.Receive("OpenMCSMenu", function()
	npc = net.ReadEntity()
	
	if !IsValid(npc) then return end
	
	local theme = MCS.Spawns[npc:GetUID()].theme
	
	if theme and theme != "Default" and MCS.Themes[theme] then
		
		if MCS.Themes[theme].Menu then
			MCS.Themes[theme].Menu(npc)
		elseif MCS.Themes[theme].Paint then
			MCS.OpenDialogue(npc, theme)
		else
			MCS.OpenDialogue(npc)
		end
	else
		MCS.OpenDialogue(npc)
	end
	
end)

MCS.OpenDialogue = function(npc, theme, test)
	
	if !IsValid(npc) and !test then return end
	
	local testmode = MCS.Config.DebugMode
	
	if test then testmode = true end
	
	// Fonts
	local AnswersFont, NPCFont, AnswersAlign = MCS.Config.AnswersFont, MCS.Config.NPCFont, MCS.Config.AnswersAlign
	// Colors
	local NPCTextColor, TextColor, HighlightColor = MCS.Config.NPCTextColor, MCS.Config.TextColor, MCS.Config.HighlightColor
	// Functions
	local PaintFunction = MCS.PaintFunction
	
	if theme then
		theme = MCS.Themes[theme]
		
		PaintFunction = theme.Paint
		
		if theme.Fonts then
			AnswersFont, NPCFont, AnswersAlign = theme.Fonts[1], theme.Fonts[2], theme.Fonts[3]
		end
		
		if theme.Colors then
			NPCTextColor, TextColor, HighlightColor = theme.Colors.NPCTextColor, theme.Colors.TextColor, theme.Colors.HighlightColor
		end
		
	end
	
	local dialogs = (test and test.dialogs) or MCS.Spawns[npc:GetUID()].dialogs
	
	if !dialogs then return end
	
	local dialog = dialogs[1]
	
	local textt = dialog["Line"]
	if istable(textt) then
		local newtext = ""
		for _, obj in pairs(textt) do
			if isstring(obj) then
				newtext = newtext .. obj
			elseif isfunction(obj) then
				newtext = newtext .. obj(npc) or 0
			end
		end
		textt = newtext
	end

	local time = CurTime()
	local pos, showhint = 0, true
	local fade, fade2 = 0, 0
	
	local subf
	local subl
	
	local mainf = vgui.Create( "DFrame" )
	mainf:SetSize( ScrW(), ScrH() )
	mainf:Center()
	mainf:MakePopup()
	mainf:SetDraggable( false )
	mainf:ShowCloseButton( testmode )
	mainf:SetTitle( "" )
	mainf.OnClose = function()
		if subf then
			subf:OnClose()
		end
		if npc and npc:GetInputLimit() then
			net.Start( "CloseMCSMenu" )
				net.WriteEntity(npc)
			net.SendToServer()
		end
	end
	mainf.Paint = function(self, w, h)
		
		if test then Derma_DrawBackgroundBlur( self, self.startTime ) end
		
		if fade < 255 then
			fade = Lerp(FrameTime() * 3, fade, 255)
		end
		surface.SetFont(AnswersFont)
		local tw, th = surface.GetTextSize((npc and npc:GetNamer()) or test.name)
		
		draw.SimpleTextOutlined( (npc and npc:GetNamer()) or test.name, AnswersFont, w/8, h/2-th-5, NPCTextColor, TEXT_ALIGN_LEFT, 1, 1, Color(0,0,0,100))
			
		if showhint then
			local skipb = TextColor
			skipb.a = 100+math.sin( CurTime()*5)*55
			draw.SimpleTextOutlined( MCS.Config.SkipButton , AnswersFont, w/2, h/2+h/4+10, skipb, TEXT_ALIGN_CENTER, 1, 1, Color(0,0,0,100))
		end
		
		if (!self.NextThing or self.NextThing < CurTime()) and !LocalPlayer():Alive() then
			self.NextThing = CurTime() + 1
			self:Close()
		end
		
	end
	
	local function OpenDialogue(dialog)
		
		if subf then subf:Close() end
		if subl then subl:Remove() end
		fade2, showhint = 0, 0, true
		
		textt = dialog["Line"]
		if istable(textt) then
			local newtext = ""
			for _, obj in pairs(textt) do
				if isstring(obj) then
					newtext = newtext .. obj
				elseif isfunction(obj) then
					newtext = newtext .. tostring(obj(npc)) or 0
				end
			end
			textt = newtext
		end
		time = CurTime()
		pos = 0
		
		local snd
		local textspd = math.Clamp(MCS.Config.TextSpeed, 1, 10)
		
		if dialog["Sound"] then
			snd = CreateSound(LocalPlayer(), dialog["Sound"])
		end
		
		subf = vgui.Create( "DFrame", mainf )
		subf:SetSize( mainf:GetWide()-mainf:GetWide()/4, mainf:GetTall()/4-10 )
		subf:SetPos(mainf:GetWide()/8,mainf:GetTall()/2-10)
		subf:SetDraggable( false )
		subf:ShowCloseButton( false )
		subf:SetTitle( "" )
		subf.OnClose = function()
			if snd then
				snd:Stop()
			end
		end
		subf.Paint = function(self, w, h)
			if pos >= string.len(textt) then
				fade2 = Lerp(FrameTime() * 3, fade2, 255)
				showhint = false
			end
			PaintFunction(self, w, h, fade)
		end
		
		local npctext = vgui.Create( "RichText", subf )
		npctext:Dock(FILL)
		npctext:DockMargin(20,0,0,10)
		npctext.Paint = function(self, w, h)
			self:SetFontInternal( NPCFont  )
			self:SetFGColor( NPCTextColor )

			if (CurTime() > time) and pos < string.len(textt) and fade > 150 then
				pos = pos + 1
				time = CurTime() + textspd/100
				
				if MCSruscheck(string.sub(textt, pos, pos+1)) then
					pos = pos + 1
					local addtext = string.sub(textt, pos-1, pos)
					self:AppendText(addtext)
				else
					
					self:AppendText(string.sub(textt, pos, pos))
				end
				
				
				if input.IsMouseDown( MOUSE_FIRST ) then
					time = CurTime() + 10
					self:AppendText(string.sub(textt, pos+1, string.len(textt)))
					pos = string.len(textt)
					showhint = false
				end
				if snd then
					snd:Play()
				end
			end
			
		end
		
		subl = vgui.Create( "DFrame", mainf )
		subl:SetSize( mainf:GetWide()-mainf:GetWide()/4, mainf:GetTall()/4-10 )
		subl:SetPos(mainf:GetWide()/8,mainf:GetTall()/2+mainf:GetTall()/4-10)
		subl:SetDraggable( false )
		subl:ShowCloseButton( false )
		subl:SetTitle( "" )
		subl.Paint = function( self, w, h ) 
			PaintFunction(self, w, h, fade2)
		end
		
		local slist = vgui.Create( "DScrollPanel", subl )
		slist:SetSize( subl:GetWide()-40, subl:GetTall()-40 )
		slist:SetPos(20,20)
		slist.Paint = function( self, w, h ) end
		slist.VBar.Paint = function( s, w, h ) draw.RoundedBox( 4, 3, 13, 8, h-24, Color(0,0,0,70)) end
		slist.VBar.btnUp.Paint = function( s, w, h ) end
		slist.VBar.btnDown.Paint = function( s, w, h ) end
		slist.VBar.btnGrip.Paint = function( s, w, h )draw.RoundedBox( 4, 5, 0, 4, h+22, Color(0,0,0,70)) end
		
		local function OpenDialogueLine(k, ans)
			
			local ab = vgui.Create( "DButton", bg )
			ab:SetSize( slist:GetWide()-10, 35 )
			ab:Dock(TOP)
			ab:SetText( "" )
			ab:SetFont("rp.ui.30")
			ab:SetTextColor( Color( 255, 255, 255, 255 ) )
			ab.txtclr = Color(255,255,255)
			ab:SetWrap(true)
			ab:SetAutoStretchVertical(true)
			ab.fade = 0
			ab.Paint = function( self, w, h )
				
				if fade2 < 1 then return end
				
				if self.hover then 
					local clr = self.txtclr
					self:SetTextColor(Color(Lerp(FrameTime() * 7, clr.r, 235), Lerp(FrameTime() * 7, clr.g, 140), Lerp(FrameTime() * 7, clr.b, 23)))
					self.txtclr = Color(Lerp(FrameTime() * 7, clr.r, 235), Lerp(FrameTime() * 7, clr.g, 140), Lerp(FrameTime() * 7, clr.b, 23))
				else
					local clr = self.txtclr
					self:SetTextColor(Color(Lerp(FrameTime() * 7, clr.r, 255), Lerp(FrameTime() * 7, clr.g, 255), Lerp(FrameTime() * 7, clr.b, 255)))
					self.txtclr = Color(Lerp(FrameTime() * 7, clr.r, 255), Lerp(FrameTime() * 7, clr.g, 255), Lerp(FrameTime() * 7, clr.b, 255))
				end
				
				local colstn = TextColor
				colstn.a = fade2-self.fade
				local colhgl = HighlightColor
				colhgl.a = self.fade
				
				local x = 0
				
				if AnswersAlign == TEXT_ALIGN_CENTER then
					x = w/2
				elseif AnswersAlign == TEXT_ALIGN_RIGHT then
					x = w
				end
				
				self:SetText( ans[1])

				
			end
			ab.DoClick = function()
				if fade2 > 200 then
					if isnumber(ans[2]) and dialogs[ans[2]] then
						if ans[6] and ans[6]() == true and dialogs[ans[7]] then
							OpenDialogue(dialogs[ans[7]])
						else 
							OpenDialogue(dialogs[ans[2]])
						end
					else
						if MCS.AddonList[ans[2]] and MCS.AddonList[ans[2]]["enabled"] then
							if MCS.AddonList[ans[2]]["function"] then
								MCS.AddonList[ans[2]]["function"]()
							end
							
							if MCS.AddonList[ans[2]]["function_sv"] then
								net.Start( "StartMCSSvFunc" )
									net.WriteString(ans[2])
								net.SendToServer()
							end
						end
						
						mainf:Close()
					end
					
					if ans[3] then
						ans[3](npc)
					end
					
					if npc and npc:GetInputLimit() and ans[5] and isstring(ans[5]) then
						net.Start( "StartMCSAnimation" )
							net.WriteEntity(npc)
							net.WriteString(ans[5])
						net.SendToServer()
					end
					
				end
			end
			ab.OnCursorEntered = function( self ) self.hover = true end 
			ab.OnCursorExited = function( self ) self.hover = false end	
			
			slist:AddItem(ab)

		end
		
		if table.IsEmpty(dialog["Answers"]) then
			OpenDialogueLine(1, {"...", "close"})
		else
			for k,ans in pairs(dialog["Answers"]) do
				
				if ans[4] and !ans[4]() then
					continue
				end
				
				OpenDialogueLine(k, ans)
			end
		end
	end
	
	OpenDialogue(dialogs[1])
	
end
