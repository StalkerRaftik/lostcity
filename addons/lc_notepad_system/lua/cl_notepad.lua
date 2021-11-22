 Notepad.Vguis = Notepad.Vguis or {}
 Notepad.Cache = Notepad.Cache or {}

net.Receive("net_notepad_send",function(ply,len)
 local Ent = net.ReadEntity()
 local Info = net.ReadTable()

  Notepad.Cache.Info = Info
  Notepad.Cache.Ent = Ent
end)

net.Receive("net_notepad_sending",function(ply,len)
 local Info = net.ReadTable()
  Notepad.Cache.Info.Pages[#Notepad.Cache.Info.Pages + 1] = Info
end)

concommand.Add("cl_nt_update_langlue",function()
 Notepad.ActiveLanglue = GetConVar("cl_nt_active_langlue"):GetString()
 print("[NT] Change active langlue on '" .. GetConVar("cl_nt_active_langlue"):GetString()  .. "'")
end)
concommand.Add("cl_nt_print",function() PrintTable(Notepad) end)
concommand.Add("cl_nt_open",function()
 local Ent = Notepad.Cache.Ent
 local Info = Notepad.Cache.Info

 local Langlue = Notepad.Langlues[Notepad.ActiveLanglue]
 local ActivePage = Info.ActivePage
 local ScaleEarse = 6

 local Frame = vgui.Create("BFrame")
  Frame:SetSkin("note")
  Frame:SetSize(ScrW()/2,600)
  Frame:SetTitle(Info.Pages[ActivePage].Title)
  Frame:Center()
  Frame:MakePopup()
  Frame:SetDraggable(false)
  Frame.ID = #Notepad.Vguis + 1

 Notepad.Vguis[Frame.ID] = Frame

 local function SoundSend(MsgID)
  net.Start("net_notepad_sound")
   net.WriteEntity(Ent)
   net.WriteString(MsgID)
   net.SendToServer()
 end

 local TextEntry = vgui.Create("DTextEntry",Frame)
  TextEntry:SetPos(10,60)
  TextEntry:SetSize(Frame:GetWide()-20,Frame:GetTall()/1.13)
  TextEntry:SetFont("font_base_note")
  TextEntry:SetMultiline(true)
  TextEntry:SetVerticalScrollbarEnabled(true)
  TextEntry:SetDisabled(Info.Baked)
  TextEntry.OldValue = ""
  TextEntry.PaintStart = {0,0}
  TextEntry.PaintMode = 0
  TextEntry.MouseX = 0
  TextEntry.MouseY = 0
  TextEntry.PaintValue = false
  TextEntry:SetSkin("note")

  Frame.TextEntry = TextEntry

 function TextEntry:PaintOver(w,h)
  for i,info in pairs(Info.Pages[ActivePage].Paint) do
   surface.SetDrawColor(color_white)
   surface.DrawLine(info[1],info[2],info[3],info[4])
  end

  if input.IsButtonDown(KEY_LSHIFT) then
   surface.DrawCircle(TextEntry.MouseX,TextEntry.MouseY,ScaleEarse,0,0,0,200)
  end

  if not input.IsButtonDown(KEY_LCONTROL) and TextEntry.PaintMode == 1 then TextEntry.PaintStart = {0,0} TextEntry.PaintMode = 0 end
  if not input.IsButtonDown(KEY_LALT) and TextEntry.PaintMode == 2 then TextEntry.PaintStart = {0,0} TextEntry.PaintMode = 0 TextEntry.PaintValue = false end

  if TextEntry.PaintStart[1] == 0 and TextEntry.PaintStart[2] == 0 then return end

   surface.SetDrawColor(Color(255,255,255,200))
   surface.DrawLine(TextEntry.PaintStart[1],TextEntry.PaintStart[2],TextEntry.MouseX,TextEntry.MouseY)
 end

 function TextEntry.OnChange()
  if #TextEntry:GetValue() > #TextEntry.OldValue then SoundSend("write") else SoundSend("earse") end
  TextEntry.OldValue = TextEntry:GetValue()
 end

 local TextEntryTitle = vgui.Create("DTextEntry",Frame)
  TextEntryTitle:SetPos(10,30)
  TextEntryTitle:SetSize(170,40)
  TextEntryTitle:SetFont("rp.ui.20")
  TextEntryTitle:SetSkin("note")
  TextEntryTitle:SetDisabled(Info.Baked)
  TextEntryTitle.OldValue = ""
  Frame.TextEntryTitle = TextEntryTitle
  TextEntryTitle.Paint = function(self, w, h)
    -- draw.ShadowSimpleText( self:GetValue(), "font_base_24", 0, 0, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )
  end

 function TextEntryTitle.OnChange()
  if #TextEntryTitle:GetValue() > #TextEntryTitle.OldValue then SoundSend("write") else SoundSend("earse") end
  TextEntryTitle.OldValue = TextEntryTitle:GetValue()
 end

 local function UpdateInfo()
   TextEntry:SetText(Info.Pages[ActivePage].Content)
   TextEntryTitle:SetText(Info.Pages[ActivePage].Title)
   -- Frame:SetTitle((Langlue and Langlue.Page or ":MISSING:") .. " " .. ActivePage)
   SoundSend("leaf")
 end

 local function SetInfo()
  if Info.Baked then return end
   Info.Pages[ActivePage].Title = TextEntryTitle:GetValue()
   Info.Pages[ActivePage].Content = TextEntry:GetValue()
   net.Start("net_notepad_sending")
    net.WriteEntity(Ent)
    net.WriteInt(ActivePage,5)
    net.WriteTable(Info.Pages[ActivePage])
    net.SendToServer()
 end
 UpdateInfo()

 function Frame:OnClose()
  SetInfo()
  table.RemoveByValue(Notepad.Vguis,Frame)
  if Info.Baked then return end

  net.Start("net_notepad_close")
   net.WriteEntity(Ent)
   net.SendToServer()
 end

 local ButtonNextPage = vgui.Create("BButton",Frame)
  ButtonNextPage:SetPos(Frame:GetWide()/1.054,25)
  ButtonNextPage:SetSize(40,25)
  ButtonNextPage:SetText("→")

 function ButtonNextPage:DoClick()
  if ActivePage == #Info.Pages then return end
  SetInfo()
  ActivePage = ActivePage + 1
  UpdateInfo()
 end

 local ButtonDownPage = vgui.Create("BButton",Frame)
  ButtonDownPage:SetPos(ButtonNextPage:GetPos()/1.05,25)
  ButtonDownPage:SetSize(40,25)
  ButtonDownPage:SetText("←")

 function ButtonDownPage:DoClick()
  if ActivePage == 1 then return end
  SetInfo()
  ActivePage = ActivePage - 1
  UpdateInfo()
 end

 if Info.Baked then return end

 local ButtonBaked = vgui.Create("BButton",Frame)
  ButtonBaked:SetPos(315,25)
  ButtonBaked:SetSize(135,25)
  ButtonBaked:SetText(Langlue and Langlue.Baked or ":MISSING:")

 function ButtonBaked:DoClick()
  SetInfo()
  SoundSend("baked")
  net.Start("net_notepad_baked")
   net.WriteEntity(Ent)
   net.SendToServer()
  Frame:Close()
 end

 local ButtonPaint = vgui.Create("BButton",Frame)
  ButtonPaint:SetPos(180,25)
  ButtonPaint:SetSize(135,25)
  ButtonPaint:SetText(Langlue and Langlue.Paint or ":MISSING:")


  local function ClearLine(x,y)
   for i,info in pairs(Info.Pages[ActivePage].Paint) do
    if Vector(x,y,0):Distance(Vector(info[1],info[2])) <= ScaleEarse or Vector(x,y,0):Distance(Vector(info[3],info[4])) <= ScaleEarse then table.remove(Info.Pages[ActivePage].Paint,i) SoundSend("earse") end

   end
  end


 function ButtonPaint:DoClick()
  if ButtonPaint:GetToggle() then
  	ButtonPaint:SetToggle(false)

  else
  	ButtonPaint:SetToggle(true)
  end

 end

 function TextEntry:OnCursorMoved(x,y)
  TextEntry.MouseX = x
  TextEntry.MouseY = y
  if input.IsButtonDown(KEY_LSHIFT) then ClearLine(x,y) end
 end

 function TextEntry:OnMousePressed(mouse)
  if mouse ~= MOUSE_FIRST or not ButtonPaint:GetToggle() then return end

  TextEntry.PaintMode = input.IsButtonDown(KEY_LCONTROL) and 1 or 0
  TextEntry.PaintMode = TextEntry.PaintMode == 0 and input.IsButtonDown(KEY_LALT) and 2 or TextEntry.PaintMode

  if TextEntry.PaintMode == 0 or (TextEntry.PaintMode == 2 and not TextEntry.PaintValue) then TextEntry.PaintStart = {TextEntry.MouseX,TextEntry.MouseY} TextEntry.PaintValue = true end
  return true
 end

 function TextEntry:OnMouseReleased(mouse)
  if mouse ~= MOUSE_FIRST or not ButtonPaint:GetToggle() then return end
   if Vector(TextEntry.PaintStart[1],TextEntry.PaintStart[2],0):Distance(Vector(TextEntry.MouseX,TextEntry.MouseY,0)) <= 2 then
     TextEntry.PaintStart = {0,0}
     TextEntry.MouseX,TextEntry.MouseY = 0,0
    return
   end

   if TextEntry.PaintMode == 1 then
    if TextEntry.PaintStart[1] == 0 and TextEntry.PaintStart[2] == 0 then TextEntry.PaintStart = {TextEntry.MouseX,TextEntry.MouseY} else
      Info.Pages[ActivePage].Paint[#Info.Pages[ActivePage].Paint + 1] = {TextEntry.PaintStart[1],TextEntry.PaintStart[2],TextEntry.MouseX,TextEntry.MouseY}
      TextEntry.PaintStart = {TextEntry.MouseX,TextEntry.MouseY}
    end
   elseif TextEntry.PaintMode == 2 then
    Info.Pages[ActivePage].Paint[#Info.Pages[ActivePage].Paint + 1] = {TextEntry.PaintStart[1],TextEntry.PaintStart[2],TextEntry.MouseX,TextEntry.MouseY}
   else
    Info.Pages[ActivePage].Paint[#Info.Pages[ActivePage].Paint + 1] = {TextEntry.PaintStart[1],TextEntry.PaintStart[2],TextEntry.MouseX,TextEntry.MouseY}
    TextEntry.PaintStart = {0,0}
    TextEntry.MouseX,TextEntry.MouseY = 0,0
   end

   SoundSend("writeline")
  return true
 end

 local TextEntryPaste = vgui.Create("DTextEntry",Frame)
  TextEntryPaste:SetPos(180,3)
  TextEntryPaste:SetSize(65,20)

 function TextEntryPaste.OnEnter()
  local Count = 1
  local Table = util.JSONToTable(TextEntryPaste:GetValue())
   if not Table then
    print("[NT] Error, Invalid structure JSON Table")
    TextEntryPaste:SetText(Langlue and Langlue.ErrorJSONTable or "Invalid structure JSON Table")
    return
   end

  print("[NT] Send to JSON Table")
  timer.Create("NOTEPAD_SENDING",0.01,#Table.Pages,function()
   if not Ent:IsValid() then return end

   net.Start("net_notepad_sending")
    net.WriteEntity(Ent)
    net.WriteInt(Count,5)
    net.WriteTable(Table.Pages[Count])
    net.SendToServer()

   print("[NT] Send " .. Table.Pages[Count].Title)
   Count = Count + 1
   if Count > #Table.Pages then
    print("[NT] Done.")
    SoundSend("baked")
    net.Start("net_notepad_close")
     net.WriteEntity(Ent)
     net.SendToServer()
   end
  end)

  SoundSend("leaf")
  Frame:Remove()
 end

 local ButtonCopy = vgui.Create("DButton",Frame)
  ButtonCopy:SetPos(245,3)
  ButtonCopy:SetSize(135,20)
  ButtonCopy:SetText(Langlue and Langlue.Copy or ":MISSING:")

 function ButtonCopy.DoClick()
  SetInfo()
  SetClipboardText(util.TableToJSON(Info))
 end

end)

concommand.Add("cl_nt_closeall",function(ply,cmd,args)
 for i,v in pairs(Notepad.Vguis) do v:Remove() end -- кек

 Notepad.Vguis = {}
end)
