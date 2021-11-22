MCS.Themes["Hollow Knight"] = {}

if SERVER then 

	resource.AddWorkshop( '1932352136' ) -- Content (Fonts and materials)
	return 

end

local NewFont = surface.CreateFont
NewFont( "MCS_HKMain", { font = "Kurale", extended = true, size = 46, antialias = true, weight = 800} )
NewFont( "MCS_HKSub", { font = "Kurale", extended = true, size = 46, antialias = true, weight = 800, outline = true} )
NewFont( "MCS_HKBIG", { font = "Kurale", extended = true, size = 126, antialias = true, weight = 800} )


MCS.Themes["Hollow Knight"].Menu =  function(npc, test)
	
	if !IsValid(npc) and !test then return end
	// Fonts
	local AnswersFont, NPCFont, AnswersAlign = "MCS_HKMain", "MCS_HKSub", TEXT_ALIGN_CENTER
	// Colors
	local NPCTextColor, TextColor, HighlightColor = MCS.Config.NPCTextColor, MCS.Config.TextColor, MCS.Config.HighlightColor
	
	local dialogs = (test and test.dialogs) or MCS.Spawns[npc:GetUID()].dialogs
	
	local dialog = dialogs[1]
	
	local textt = dialog["Line"]
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
	mainf:ShowCloseButton( MCS.Config.DebugMode )
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
		surface.SetFont("MCS_HKBIG")
		local tw, th = surface.GetTextSize((npc and npc:GetNamer()) or test.name)
		
		surface.SetDrawColor(0,0,0,math.Clamp(fade,0,120))
		surface.SetMaterial(Material("gui/center_gradient.vtf"))
		surface.DrawTexturedRect(50,h-120-th/2,tw,th-20)
		
		draw.SimpleTextOutlined( (npc and npc:GetNamer()) or test.name , "MCS_HKBIG", 50, h-130, Color(255,255,255,fade), TEXT_ALIGN_LEFT, 1, 1, Color(0,0,0,fade))
		
		
		surface.SetDrawColor(0,0,0,math.Clamp(fade,0,250))
		surface.SetMaterial(Material("gui/center_gradient.vtf"))
		surface.DrawTexturedRect(w/8,h/8,w-w/4,h/4-10)
		
		
		surface.SetDrawColor(255,255,255,math.Clamp(fade,0,255))
		surface.SetMaterial(Material("mcs_ui/hn_top.png"))
		surface.DrawTexturedRect(w/8+((w-w/4)/2-300),h/8-50,600,80)
		surface.SetMaterial(Material("mcs_ui/hn_but.png"))
		surface.DrawTexturedRect(w/8+((w-w/4)/2-200),h/8+(h/4-40),400,60)
		
		if showhint then
			local skipb = TextColor
			skipb.a = 100+math.sin( CurTime()*5)*55
			draw.SimpleTextOutlined( MCS.Config.SkipButton , AnswersFont, w/2, h/8+(h/4+60), skipb, TEXT_ALIGN_CENTER, 1, 1, Color(0,0,0,100))
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
		time = CurTime()
		pos = 0
		
		local snd
		local textspd = math.Clamp(MCS.Config.TextSpeed, 1, 10)
		
		if dialog["Sound"] then
			snd = CreateSound(LocalPlayer(), dialog["Sound"])
		end
		
		subf = vgui.Create( "DFrame", mainf )
		subf:SetSize( mainf:GetWide()-mainf:GetWide()/4, mainf:GetTall()/4-10 )
		subf:SetPos(mainf:GetWide()/8,mainf:GetTall()/8)
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
		end
		
		local npctext = vgui.Create( "RichText", subf )
		npctext:SetSize( subf:GetWide(), subf:GetTall()-40 )
		npctext:SetPos( 20,20)
		npctext.Paint = function(self, w, h)
			self:SetFontInternal( NPCFont  )
			self:SetFGColor( NPCTextColor )
			
			if (CurTime() > time) and pos < string.len(textt) and fade > 150 then
				pos = pos + 1
				time = CurTime() + FrameTime() * textspd
				
				if MCSruscheck(string.sub(textt, pos, pos+1)) then
					pos = pos + 1
					local addtext = string.sub(textt, pos-1, pos)
					self:AppendText(addtext)
				else
					
					self:AppendText(string.sub(textt, pos, pos))
				end
				
				
				if input.IsMouseDown( MOUSE_FIRST ) then
					time = CurTime() + 10
					pos = string.len(textt)
					self:SetText(textt)
					showhint = false
				end
				if snd then
					snd:Play()
				end
				
			end
			
		end
		
		subl = vgui.Create( "DFrame", mainf )
		subl:SetSize( mainf:GetWide()-mainf:GetWide()/4, mainf:GetTall()/4-60 )
		subl:SetPos(mainf:GetWide()/8,mainf:GetTall()/8+mainf:GetTall()/4+60)
		subl:SetDraggable( false )
		subl:ShowCloseButton( false )
		subl:SetTitle( "" )
		subl.Paint = function( self, w, h ) 
			surface.SetDrawColor(0,0,0,math.Clamp(fade2,0,250))
			surface.SetMaterial(Material("gui/center_gradient.vtf"))
			surface.DrawTexturedRect(0,0,w,h)
		end
		
		local slist = vgui.Create( "DPanelList", subl )
		slist:SetSize( subl:GetWide()-40, subl:GetTall()-40 )
		slist:SetPos(20,20)
		slist:EnableVerticalScrollbar( true )
		slist:EnableHorizontal( false )
		slist:SetSpacing( 5 )
		slist.Paint = function( self, w, h ) end
		slist.VBar.Paint = function( s, w, h ) draw.RoundedBox( 4, 3, 13, 8, h-24, Color(0,0,0,70)) end
		slist.VBar.btnUp.Paint = function( s, w, h ) end
		slist.VBar.btnDown.Paint = function( s, w, h ) end
		slist.VBar.btnGrip.Paint = function( s, w, h )draw.RoundedBox( 4, 5, 0, 4, h+22, Color(0,0,0,70)) end
		
		local function OpenDialogueLine(k, ans)
			
			local ab = vgui.Create( "DButton", bg )
			ab:SetSize( slist:GetWide()-10, 35 )
			ab:SetText( "" )
			ab:SetTextColor( Color( 255, 255, 255, 255 ) )
			ab.fade = 0
			ab.Paint = function( self, w, h )
				
				if fade2 < 1 then return end
				
				if self.hover then 
					self.fade = Lerp(FrameTime() * 3, self.fade, 255)
				else
					self.fade = 0
				end
				
				local x = 0
				
				if AnswersAlign == TEXT_ALIGN_CENTER then
					x = w/2
				elseif AnswersAlign == TEXT_ALIGN_RIGHT then
					x = w
				end
				
				if self.hover then 
					surface.SetFont(AnswersFont)
					local tw, th = surface.GetTextSize(ans[1])
					
					surface.SetDrawColor(255,255,255,math.Clamp(self.fade,0,110))
					surface.SetMaterial(Material("gui/center_gradient.vtf"))
					surface.DrawTexturedRect(w/2-tw/2-24,0,tw+48,h)
					
					surface.SetDrawColor(255,255,255,math.Clamp(self.fade,0,255))
					surface.SetMaterial(Material("mcs_ui/hn_opt.png"))
					surface.DrawTexturedRectRotated(w/2-tw/2-30,h/2,44,35,180)
					surface.DrawTexturedRect(w/2+tw/2+8,0,44,35)
				end
				
				draw.SimpleTextOutlined( ans[1] , AnswersFont, w/2, h/2, Color(255,255,255,fade2), TEXT_ALIGN_CENTER, 1, 1, Color(0,0,0,fade2))
				
			end
			ab.DoClick = function()
				if fade2 > 200 then
					if isnumber(ans[2]) and dialogs[ans[2]] then
						OpenDialogue(dialogs[ans[2]])
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