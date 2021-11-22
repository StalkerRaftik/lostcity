local blur = Material("pp/blurscreen")
function DrawBlurPanelKits(panel, amount)
  local x, y = panel:LocalToScreen(0, 0)
  local scrW, scrH = ScrW(), ScrH()
  surface.SetDrawColor(255, 255, 255)
  surface.SetMaterial(blur)
  for i = 1, 3 do
    blur:SetFloat("$blur", (i / 3) * (amount or 6))
    blur:Recompute()
    render.UpdateScreenEffectTexture()
    surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
  end
  draw.RoundedBox(0,0,0,panel:GetWide(),panel:GetTall(),Color(0,0,0,150))
end

function DrawErrorMessage(errorText, parent)
  LocalPlayer():EmitSound("buttons/button10.wav")
  local ErrorMsg
  if parent then
    ErrorMsg = vgui.Create('DFrame', parent)
  else 
    ErrorMsg = vgui.Create('DFrame')
  end
  
  ErrorMsg:SetTitle("")
  ErrorMsg:ShowCloseButton(false)
  ErrorMsg:SetSize(600,ScrH()*0.5) 
  ErrorMsg:SetPos(ScrW()/2-ErrorMsg:GetWide()/2, ScrH()/2-ErrorMsg:GetTall()/2)
  ErrorMsg.Paint = function( self, w, h )

    draw.RoundedBox(5,0,0,w,h, Color(50,50,50,250))
    draw.RoundedBoxEx(5,0,0,w,30, Color(0,0,0,200),true,true,false,false)
    draw.ShadowSimpleText( "Ошибка!", "rp.ui.29", 9, 5, Color(255,1, 71,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
  end

  SideHelperText = vgui.Create('DLabel', ErrorMsg)
  SideHelperText:SetSize(ErrorMsg:GetWide()-20,ErrorMsg:GetTall()*0.7)
  SideHelperText:SetPos(10,20)   
  SideHelperText:SetWrap(true)
  SideHelperText:SetFont('ui.22')
  SideHelperText:SetText(errorText)
  SideHelperText:SetTextColor(Color(230,230,230))


  local ErrorBtn = vgui.Create( "DButton", ErrorMsg ) 
  ErrorBtn:SetText( "" )
  ErrorBtn:SetPos( ErrorMsg:GetWide()*0.97, 10 ) 
  ErrorBtn:SetSize( 15, 15 )   
  ErrorBtn.Paint = function( self, w, h )   
    draw.ShadowSimpleText( "X", "rp.ui.15", 0, h/2, Color(200,200,200,200), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
  end    
  ErrorBtn.DoClick = function()   
    ErrorMsg:Remove()
  end
end

function DrawBlurPanelSGKits(panel, amount)
  local x, y = panel:LocalToScreen(0, 0)
  local scrW, scrH = ScrW(), ScrH()
  surface.SetDrawColor(255, 255, 255)
  surface.SetMaterial(blur)
  for i = 1, 3 do
    blur:SetFloat("$blur", (i / 3) * (amount or 6))
    blur:Recompute()
    render.UpdateScreenEffectTexture()
    surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
  end
end

function KitsFormatTimeNice(t,s)
  local timestamp = t - os.time()
  local d = 0
  local h = 0
  local m = 0
  local s = 0

  if timestamp > 0 then
    d = math.floor(timestamp / 60 / 60 / 24)
    h = math.floor((timestamp / 60 / 60) % 24)
    m = math.floor(timestamp / 60 % 60)
    s = math.floor(timestamp % 60)
  end

  if s then
    f = ""
    if m > 0 then f = " и " .. m .. " минут." .. f end
    if h > 0 then f = h .. " часов" .. f end
    if d > 0 then f = d .. " дней " .. f end
    return f
  end

  return d .. "дн., " .. h .. "ч. и " .. m .. "минут"
end

function draw.ShadowSimpleTextKits( text, font, x, y, color, xalign, yalign )
  draw.SimpleText(text, font, x+1, y+1, Color(0,0,0,190), xalign, yalign)
  draw.SimpleText(text, font, x, y, color, xalign, yalign)
end

function draw.ShadowTextKits(text, font, x, y, colortext, colorshadow, dist, xalign, yalign)
  draw.SimpleText(text, font, x + dist, y + dist, colorshadow, xalign, yalign)
  draw.SimpleText(text, font, x, y, colortext, xalign, yalign)
end

local Main, Menu, SideHelper
local time = CurTime() + 1

function KitsMenu()
  if ValidPanel(Main) then
    Main:Close()
    if ValidPanel(SideHelper) then
      SideHelper:Close()
    end
    return
  end
  if ValidPanel(Menu) then
    Menu:Remove()
    SideHelper:Close()
    return
  end

  SideHelper = vgui.Create('DFrame')
  SideHelper:SetPos(ScrW()*0.03, ScrH()/2.5)                
  SideHelper:SetSize(ScrW()/4,ScrH()/2.5)   
  SideHelper:ShowCloseButton(false)
  SideHelper:SetDraggable(false)
  SideHelper:SetTitle('')
  SideHelper.Paint = function( self, w, h )
    alpha = 220
    alpha_lerp = Lerp(FrameTime()*2,alpha_lerp or 0,alpha or 0) or 0
    local x, y = self:GetPos()
    draw.RoundedBox(0,0,0,w,h,Color(200,200,200,20))
    DrawBlurPanelKits(self,6)
    draw.RoundedBox(3,0,0,w,h*0.15,Color(0,0,0,200))
    draw.ShadowSimpleText( "Как работают донат наборы?", "rp.ui.26", w/2, h*0.03, Color(245,245,245,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
  end

  SideHelperText = vgui.Create('DLabel', SideHelper)
  SideHelperText:SetSize(SideHelper:GetWide()-5,SideHelper:GetTall()-SideHelper:GetTall()*0.15)
  SideHelperText:SetPos(10,SideHelper:GetTall()*0.15)   
  SideHelperText:SetWrap(true)
  SideHelperText:SetFont('ui.22')
  SideHelperText:SetText('$ Донат наборы продаются отдельно в нашем донат-меню(Кнопка "F6")\n\n▶ Наборы разделены по группам. Каждую группу можно использовать лишь раз в сутки.\n\n? Например, если вы активируете набор из группы "Обычные", то второй набор из этой же группы вы сможете активировать только через 24 часа.\n  Но вам всё еще будут доступны наборы из других групп.')
  SideHelperText:SetTextColor(Color(230,230,230))

  local SHelperButton = vgui.Create( "DButton", SideHelper ) 
  SHelperButton:SetText( "" )
  SHelperButton:SetPos( SideHelper:GetWide()*0.97, 10 ) 
  SHelperButton:SetSize( 15, 15 )   
  SHelperButton.Paint = function( self, w, h )   
    draw.ShadowSimpleText( "X", "rp.ui.15", 0, h/2, Color(200,200,200,200), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
  end    
  SHelperButton.DoClick = function()   
    SideHelper:Close()
  end


  Main = vgui.Create('DFrame')
  Main:SetSize(ScrW()/2.3,ScrH()/1.1)
  Main:Center()
  Main:MakePopup()
  Main:ShowCloseButton(false)
  Main:SetDraggable(false)
  Main:SetTitle('')
  Main.Paint = function( self, w, h )
    alpha = 220
    alpha_lerp = Lerp(FrameTime()*2,alpha_lerp or 0,alpha or 0) or 0
    local x, y = self:GetPos()

    DrawBlurPanelKits(self,13)
    draw.RoundedBox(0,0,0,w,h/32, Color(0,0,0,200))
    draw.ShadowSimpleText( "Донат наборы", "rp.ui.27", Main:GetWide()/2, Main:GetTall()*0.017, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
  end

  local DButton1 = vgui.Create( "DButton", Main ) 
  DButton1:SetText( "" )
  DButton1:SetPos( Main:GetWide()*0.98, 8 ) 
  DButton1:SetSize( 15, 15 )   
  DButton1.Paint = function( self, w, h )   
    draw.ShadowSimpleText( "X", "rp.ui.15", 0, h/2, Color(200,200,200,200), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
  end    
  DButton1.DoClick = function()   
    Main:Close()
    SideHelper:Remove()
  end

  local spanel = vgui.Create('DCategoryList', Main)
  spanel:SetSize(Main:GetWide()/1.01,Main:GetTall() - Main:GetTall()/30)
  spanel:SetPos(5, Main:GetTall()/30)
  spanel.Paint = function( self, w, h )
    --draw.RoundedBox(0, 0, 0, w*0.98, h, Color(0,0,0, 100))
  end
  spanel.sbar = spanel:GetVBar()   
  spanel.sbar.Paint = function( self, w, h )
  end
  spanel.sbar.btnUp.Paint = function( self, w, h ) end
  spanel.sbar.btnDown.Paint = function( self, w, h ) end
  spanel.sbar.btnGrip.Paint = function( self, w, h ) draw.RoundedBox(30, w/4, 0, w/2, h, Color(245, 245, 245, 200)) end


  for z, types in pairs(rp.Kits.Config) do

    local k = spanel:Add( "" )

    local rpanel = vgui.Create('DPanel')
    rpanel.Paint = function( self, w, h ) end

    for index, kit in pairs(types) do



        local pnlItem = vgui.Create('DPanel',rpanel)
        pnlItem:SetSize(spanel:GetWide()*0.97,200)
        pnlItem:Dock(TOP)
        pnlItem:DockMargin(0,20,0,0)
        pnlItem.Paint = function(self, w, h) end

        local DropButton = vgui.Create("DButton",pnlItem)
        DropButton:SetSize(pnlItem:GetWide(),pnlItem:GetTall())
        DropButton:SetText("")

        -- ФУНКЦИЯ КНОПКИ
        local ButtonFunction = function()
          if LocalPlayer():GetNWInt("AllowedToUse"..z.."KitsTime") >= os.time() or ( kit.Upgrade and not LocalPlayer():AllowedToUseKit(kit) ) or (kit.Level and kit.Level > LocalPlayer():GetLevel()) and not ValidPanel(ErrorMsg) then
            LocalPlayer():EmitSound("buttons/button10.wav")
            local ErrorMsg = vgui.Create('DFrame', Main)
            ErrorMsg:SetTitle("")
            ErrorMsg:ShowCloseButton(false)
            ErrorMsg:SetSize(Main:GetWide()*0.65,Main:GetTall()*0.2) 
            ErrorMsg:SetPos(Main:GetWide()*0.17, Main:GetTall()/3)
            ErrorMsg.Paint = function( self, w, h )

              draw.RoundedBox(5,0,0,w,h, Color(50,50,50,250))
              draw.RoundedBoxEx(5,0,0,w,h*0.18, Color(0,0,0,200),true,true,false,false)
              draw.ShadowSimpleText( "Ошибка!", "rp.ui.29", 9, 5, Color(255,1, 71,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )

              if LocalPlayer():GetNWInt("AllowedToUse"..z.."KitsTime") >= os.time() then
                draw.ShadowSimpleText( "Наборы этой группы еще перезаряжаются!", "rp.ui.24", 10, ErrorMsg:GetTall()*0.35, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
                draw.ShadowSimpleText( "Они будут доступны через ".. KitsFormatTimeNice(LocalPlayer():GetNWInt("AllowedToUse"..z.."KitsTime")), "rp.ui.24", 10, ErrorMsg:GetTall()*0.5, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
              elseif kit.Upgrade and not LocalPlayer():AllowedToUseKit(kit) then
                draw.ShadowSimpleText( "Вами не куплен данный набор(Клавиша 'F6' ▶ 'Наборы')!", "rp.ui.24", 10, ErrorMsg:GetTall()*0.5, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
              elseif kit.Level > LocalPlayer():GetLevel() then
                draw.ShadowSimpleText( "Ваш уровень недостаточно высок для этого набора!", "rp.ui.24", 10, ErrorMsg:GetTall()*0.5, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
              else
                draw.ShadowSimpleText( "Непредвиденная ошибка! Сообщите о ней администратору!", "rp.ui.24", 10, ErrorMsg:GetTall()*0.5, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
              end
            end

            local ErrorBtn = vgui.Create( "DButton", ErrorMsg ) 
            ErrorBtn:SetText( "" )
            ErrorBtn:SetPos( ErrorMsg:GetWide()*0.97, 10 ) 
            ErrorBtn:SetSize( 15, 15 )   
            ErrorBtn.Paint = function( self, w, h )   
              draw.ShadowSimpleText( "X", "rp.ui.15", 0, h/2, Color(200,200,200,200), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
            end    
            ErrorBtn.DoClick = function()   
              ErrorMsg:Remove()
            end

          else
            net.Start("GiveKit")
            net.WriteString(kit.Name)
            net.SendToServer()
            Main:Close()
            SideHelper:Close()
          end
        end

        local kiticon = vgui.Create("SpawnIcon", DropButton)
        kiticon:SetSize( DropButton:GetWide()*0.5, DropButton:GetTall() )
        kiticon:SetPos( DropButton:GetWide()*0.7, DropButton:GetTall()*0.129 )
        kiticon:SetModel(kit.model or "models/props_borealis/bluebarrel001.mdl")
        kiticon.PaintOver = function() end
        kiticon:SetTooltip(false)
        kiticon.DoClick = ButtonFunction

        local KitDescription = vgui.Create('DLabel', DropButton)
        KitDescription:SetSize(DropButton:GetWide()*0.75,DropButton:GetTall()) 
        KitDescription:SetPos(5, 10)
        KitDescription:SetWrap(true)
        KitDescription:SetFont('rp.ui.23')
        KitDescription:SetText(kit.Description)
        KitDescription:SetTextColor(Color(255,255,255))

        DropButton.Paint = function(self, w, h)
          local col = Color(80, 80, 80, 80)
          if self:IsHovered() then
            col = Color(120, 120, 120, 80)
          end
          draw.RoundedBox(5, 0, 0, w, h, col)
          draw.RoundedBoxEx(5, 0, 0, w, h/8, Color(100+kit.color.r/4, 100+kit.color.g/5, 100+kit.color.b/5, 200), true,true,false,false)
          draw.ShadowSimpleText(kit.Name, "rp.ui.26", w/2, h*0.06, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
          if kit.Level then 
            draw.ShadowSimpleText('['..kit.Level..' ур.]', "rp.ui.22", w*0.99, h*0.06, Color(255,150, 150,255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
          end
          -- if LocalPlayer():GetNWInt("AllowedToUse"..z.."KitsTime") >= os.time() then
          --   draw.ShadowSimpleText('' KitsFormatTimeNice(LocalPlayer():GetNWInt("AllowedToUse"..z.."KitsTime")), "rp.ui.23", 5, h*0.9, Color(200,200,200,200), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
          -- else
          --   draw.ShadowSimpleTextKits(txt, "font_base_24", w/2, h/1.15, col2, 1, 0)
          -- end
        end

        DropButton.DoClick = ButtonFunction

        

    end

    k.Paint = function( self, w, h )
        if LocalPlayer():GetNWInt("AllowedToUse"..z.."KitsTime") >= os.time() then
          draw.RoundedBox(10, 0, 0, w*0.995, 35, Color(176,0,0,150))
          draw.ShadowSimpleTextKits(rp.Kits.NiceNames[z].name .. "[Перезаряжаются еще " .. KitsFormatTimeNice(LocalPlayer():GetNWInt("AllowedToUse"..z.."KitsTime")) .. "]", "rp.ui.30", w/2, 17, color_white, 1, 1)
        else
          draw.RoundedBox(10, 0, 0, w*0.995, 35, rp.Kits.NiceNames[z].color)
          draw.ShadowSimpleTextKits(rp.Kits.NiceNames[z].name, "rp.ui.32", w/2, 17, color_white, 1, 1)
        end
    end

    -- Разделитель типов китов
    if not (rp.Kits.NiceNames[z].last == true) then 
      local EmptySpace = vgui.Create('DPanel',rpanel)
      EmptySpace:SetSize(rpanel:GetWide(),30)
      EmptySpace:Dock(TOP)
      EmptySpace.Paint = function( self, w, h ) end
    end

    k:SetContents( rpanel )
    spanel:InvalidateLayout( true )
  end

end

hook.Add("Think", "KitsMenuThink", function()
  if input.IsKeyDown(KEY_F2) and time <= CurTime() then
    time = CurTime() + 0.3
    KitsMenu()
  end
end)
