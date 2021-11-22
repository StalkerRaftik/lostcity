locations = locations or {}
locations[ "rp_asheville" ] = { -- You can change the map name to whatever you want. Make sure to add new positions for every map you have!
  {
    pos = Vector(-707, 778, 1764),
    ang = Angle(0, -100, 0),
  },
}

CharUpgradeCount = 0

hook.Add( "HUDShouldDraw", "GlideRemoveHUD", function( name )
  if IsValid(prestartpanel) then
    return false
  end
end )

hook.Add( "CalcView", "GlideTest", function()
  if not IsValid(prestartpanel) then return end
  local view = {}
  for k,v in pairs( locations[ game.GetMap() ] ) do
    view.origin = v.pos
    view.angles = v.ang
    view.farz = 15000
    view.drawviewer = true;
    return view
  end
end )

function ToggleLoadingScreen()
  local CharData = LocalPlayer():GetNVar('CharData')

  alpha = 130
  alpha_lerp = 0
  LoadingCharMain = vgui.Create("BFrame")
  LoadingCharMain:SetSize(ScrW(),ScrH())
  LoadingCharMain:SetTitle('')

  LoadingCharMain:SetDraggable(false)
  LoadingCharMain:ShowCloseButton(false)
  LoadingCharMain:MakePopup(true)
  LoadingCharMain.Paint = function( self, w, h )
    alpha_lerp = Lerp(FrameTime()*2,alpha_lerp or 0,alpha or 0) or 0
    local x, y = self:GetPos()
    -- draw.BlurBackground(x, y, w, h, (alpha_lerp), self)
    -- draw.RoundedBox(0,0,0,w,h,Color(90,90,90,alpha_lerp/1.2))
    -- draw.ShadowSimpleText( LocalPlayer():Name()..', Добро пожаловать на Lost City!', 'font_base_big', w/2, h*0.06, Color( 235, 235, 235, alpha_lerp ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    draw.ShadowSimpleText( 'Выбери своего персонажа', 'font_base_big', w/2, h*0.095, Color( 235, 235, 235, alpha_lerp ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    draw.ShadowSimpleText( "Онлайн: " .. player.GetCount() .. "/" .. game.MaxPlayers() .. ' Игроков', 'font_base_24', 8, h - 5, Color( 235, 235, 235, alpha_lerp ), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM )
  end

  local MainPanel = vgui.Create( "DPanel", LoadingCharMain )
  MainPanel:SetSize( LoadingCharMain:GetWide()/1.5, LoadingCharMain:GetTall()*0.7 )
  MainPanel:Center()
  MainPanel.Paint = function(self,w,h)
    local x, y = self:GetPos()
    -- draw.BlurBackground(x, y, w, h, (alpha_lerp), self)
    draw.StencilBlur(self, w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, alpha_lerp))
    surface.SetDrawColor(Color(0,0,0, alpha_lerp))
    surface.DrawOutlinedRect(0, 0, w, h)
    -- draw.RoundedBox(0,0,0,w,h,Color(40,40,40,alpha_lerp*1.8))
  end
  MainPanel:SetWide(MainPanel:GetWide())
  MainPanel:Center()

  local CharPanel = vgui.Create( "DPanel", MainPanel )
  CharPanel:Dock(FILL)
  CharPanel:DockMargin(5,5,5,5)
  CharPanel:SetWide(MainPanel:GetWide())
  CharPanel.Paint = function(self,w,h)
    -- draw.RoundedBox(5,0,0,w,h,Color(30,30,30,alpha_lerp/1.2))
  end

  if #CharData ~= 0 then
    PrintTable(CharData)
    for k, v in pairs(CharData) do
      local PlayButton = CharPanel:Add( "monoButton")
      PlayButton:Dock(LEFT)
      PlayButton:SetText('+')
      PlayButton:DockMargin(5,5,5,5)
      PlayButton:SetWide(CharPanel:GetWide()/3)
      -- PlayButton.PaintOver = function(self, w, h)
      --     surface.SetDrawColor(Color(0,0,0, alpha_lerp))
      --     surface.DrawOutlinedRect(0, 0, w, h)
      -- end

      local character = PlayButton:Add( "monoCharacterModel" )
      character:Dock( FILL )
      character:InvalidateParent( true )
      character:SetChar(v.id, v.job)
      character:SetCharID(v.id)
      character:SetFollower( true )
      character.IsCharacterModel = true
      -- print(v.id)
      character.PaintOver = function(self, w, h)
          draw.ShadowSimpleText( v.Name, 'font_base_24', w/2, h*0.015, Color( 235, 235, 235, alpha_lerp ), 1, 1 )
          draw.ShadowSimpleText( "LVL: "..v.Level.." EXP: "..v.Experience, 'font_base_18', w/2, h*0.044, Color( 235, 235, 235, alpha_lerp ), 1, 1 )
          if v.job then
            draw.ShadowSimpleText( rp.teams[v.job].name, 'font_base_18', w/2, h*0.064, Color( rp.teams[v.job].color.r, rp.teams[v.job].color.g, rp.teams[v.job].color.b, alpha_lerp ), 1, 1 )
          else
            draw.ShadowSimpleText( LocalPlayer():GetJobName(), 'font_base_18', w/2, h*0.064, Color( LocalPlayer():GetJobColor().r, LocalPlayer():GetJobColor().g, LocalPlayer():GetJobColor().b, alpha_lerp ), 1, 1 )
          end
          surface.SetDrawColor(Color(0,0,0, alpha_lerp))
          surface.DrawOutlinedRect(0, 0, w, h)
          if self:IsHovered() then
              draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, alpha_lerp))
              surface.SetDrawColor(Color(0,0,0, alpha_lerp))
              surface.DrawOutlinedRect(0, 0, w, h)
          end
      end
      character.DoClick = function()
        LoadingCharMain:Remove()
        rp.ui.BlackAlphaScreen()
        prestartpanel:Remove()
        net.Start("rp.data.SelectChar")
          net.WriteInt(v.id, 16)
        net.SendToServer()
      end

      local DeleteCharacterBtn = PlayButton:Add( "monoButton")
      DeleteCharacterBtn:Dock(BOTTOM)
      DeleteCharacterBtn:SetText('Удалить персонажа')
      DeleteCharacterBtn:DockMargin(5,5,5,5)
      DeleteCharacterBtn.TimesPressed = 0
      DeleteCharacterBtn.DoClick = function()
        DeleteCharacterBtn.TimesPressed = DeleteCharacterBtn.TimesPressed + 1
        if DeleteCharacterBtn.TimesPressed >= 2 then
          LoadingCharMain:Remove()

          rp.ui.BlackAlphaScreen()
          net.Start("rp.data.DeleteCharacter")
            net.WriteInt(v.id, 16)
          net.SendToServer()
        else
          DeleteCharacterBtn:SetText('Нажмите еще раз для подтверждения')
        end
      end

      local x = 180
      local y = 50
      local z = 60
      local pos_cam = Vector(0,0,0)
      local pos_look = Vector(0,0,0)

      -- fov & distance
      local f = 0
      local base_fov = 0
      local camera_distance = 90

      -- set camera position
      function character:Think()
        pos_cam = Vector(math.sin(x / 120) * camera_distance, math.cos(x / 120) * camera_distance, y)
        pos_look = Vector(0,0,z)

        -- put entity on floor
        local ent = self:GetEntity()
        local mins, maxs = ent:GetModelRenderBounds()
        local mz = math.abs(mins.z)
        ent:SetPos(Vector(0,0, mz ))

      end

      function character:LayoutEntity( ent )
        self:SetCamPos( Lerp( FrameTime() * 10, self:GetCamPos() , pos_cam ) )
        self:SetLookAt( Lerp( FrameTime() * 10, self:GetLookAt(), pos_look ) )
      end
    end
  end
  if not IsValid(NewChar) then
    NewChar = CharPanel:Add( "monoButton")
    NewChar:Dock(FILL)
    NewChar:SetText('Создать персонажа')
    NewChar:DockMargin(5,5,5,5)
    NewChar:SetWide(CharPanel:GetWide()/4)
    NewChar.DoClick = function()
      if #CharData >= 2 + CharUpgradeCount then return end
      LoadingCharMain:Remove()
      CM_OpenNewCharacterGUI()
    end
    NewChar.PaintOver = function(self, w, h)
        surface.SetDrawColor(Color(0,0,0, alpha_lerp))
        surface.DrawOutlinedRect(0, 0, w, h)
    end

    if #CharData >= 2 + CharUpgradeCount then
      NewChar:SetText("")

      OnlyForDonatorsCharPnl = CharPanel:Add("DPanel")
      OnlyForDonatorsCharPnl:Dock(FILL)
      OnlyForDonatorsCharPnl.Paint = function(self, w, h)
          surface.SetDrawColor(Color(200,0,0, alpha_lerp))
          surface.DrawOutlinedRect(0, 0, w, h)
      end

      OnlyForDonatorsChar = OnlyForDonatorsCharPnl:Add( "DLabel")
      OnlyForDonatorsChar:Dock(FILL)
      OnlyForDonatorsChar:DockMargin(10,1,10,5)
      OnlyForDonatorsChar:SetText('Лимит персонажей превышен.\nДоступ к новым персонажам можно купить в донат-меню(F6)')
      OnlyForDonatorsChar:SetFont('rp.ui.24')
      OnlyForDonatorsChar:SetWrap(true)
      OnlyForDonatorsChar:SetAutoStretchVertical( true )
      OnlyForDonatorsChar:SetWide(CharPanel:GetWide()/4)
      OnlyForDonatorsChar.DoClick = function()
      end
    end
  end
end

net.Receive('rp.data.SendCharCountToClient', function()
  CharUpgradeCount = net.ReadInt(8)
end)

net.Receive('rp.charsmenu', function()
  ToggleLoadingScreen()
end)

-- soundStream = true
-- soundStream = nil


net.Receive('OpenMOTD', function()
   prestartpanel = vgui.Create("BFrame")

prestartpanel:SetPos(0, 0)
prestartpanel:SetSize(ScrW(), ScrH())
prestartpanel:MakePopup()
prestartpanel:SetTitle('')
prestartpanel:ShowCloseButton(false)
prestartpanel:SetMouseInputEnabled(true)
prestartpanel:SetKeyboardInputEnabled(true)
prestartpanel.Paint = function(self, w, h)
  surface.SetDrawColor(Color(0,0,0,150))
  surface.DrawRect(-1, -1, ScrW() + 2, ScrH() + 2)
  draw.StencilBlur(self, w, h)
  -- surface.SetDrawColor(color_white)
  -- surface.SetMaterial(load_bg)
  -- surface.DrawTexturedRect(-300, -20, ScrW()*1.2, ScrH()*1.2)

  draw.ShadowSimpleText( 'Lost City', 'font_base_ds', w/2, h*0.3, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

end

-- local buttonpanel = vgui.Create( "DPanel", prestartpanel )
--   -- buttonpanel:Dock(FILL)
--   buttonpanel:DockMargin(5,5,5,5)
--   buttonpanel:SetWide(prestartpanel:GetWide()/2)
--   buttonpanel:SetPos(prestartpanel:GetWide()/2`)
--   buttonpanel.Paint = function(self,w,h)
--     draw.RoundedBox(5,0,0,w,h,Color(30,30,30,200))
--   end

local LoadChar = vgui.Create( "BButton", prestartpanel)
    LoadChar:SetPos(prestartpanel:GetWide()/2.3, prestartpanel:GetTall()/2.5)
    LoadChar:SetWide(prestartpanel:GetWide()/6)
    LoadChar:SetTall(70)
    LoadChar:SetText("")
    LoadChar.DoClick = function()
      RunConsoleCommand("loaddata")
      -- ToggleLoadingScreen()
    end
    LoadChar.Paint = function(self, w, h)
      local col = color_white
      if self:IsHovered() then col = Color(200,200,200) else col = color_white end
      draw.ShadowSimpleText( 'Загрузить персонажа', 'font_base_uglybutton', w/2.3, h/2, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    end

local Create = vgui.Create( "BButton", prestartpanel)
    Create:SetPos(prestartpanel:GetWide()/2.3, prestartpanel:GetTall()/2.2)
    Create:SetWide(prestartpanel:GetWide()/6)
    Create:SetTall(70)
    Create:SetText("")
    Create.DoClick = function()
      RunConsoleCommand("loaddata")
      -- ToggleLoadingScreen()
    end
    Create.Paint = function(self, w, h)
      local col = color_white
      if self:IsHovered() then col = Color(200,200,200) else col = color_white end
      draw.ShadowSimpleText( 'Создать персонажа', 'font_base_uglybutton', w/2.3, h/2, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    end

local Create = vgui.Create( "BButton", prestartpanel)
    Create:SetPos(prestartpanel:GetWide()/2.3, prestartpanel:GetTall()/2)
    Create:SetWide(prestartpanel:GetWide()/6)
    Create:SetTall(70)
    Create:SetText("")
    Create.DoClick = function()
      RunConsoleCommand("disconnect")
    end
    Create.Paint = function(self, w, h)
      if self:IsHovered() then col = Color(200,200,200) else col = color_white end
      draw.ShadowSimpleText( 'Выйти с сервера', 'font_base_uglybutton', w/2.3, h/2, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    end

  timer.Simple(1, function()
    sound.PlayURL("https://gmod-octopus.ru/music/dayz.mp3", "noplay", function(chan, err, str)
      if IsValid(chan) then
        chan:SetVolume(0.5)
        chan:Play()
        soundStream = chan
      end
    end)

    system.FlashWindow()
  end)
end)

-- hook.Add("PostDrawHUD", "LoadingSoundFade", function()
--   if LocalPlayer():GetNVar('CharSelected') == true then 

--     do -- sound stream fadeout
--       hook.Add("Think", "LoadingSoundFade", function()
--         if IsValid(soundStream) then
--           if soundStream:GetVolume() <= 0 then
--             hook.Remove("Think", "LoadingSoundFade")
--             soundStream:Stop()
--             soundStream = nil
--           else
--             soundStream:SetVolume(math.max(0, soundStream:GetVolume() - FrameTime()/5))
--           end
--         else
--           hook.Remove("Think", "LoadingSoundFade")
--         end
--       end)
--     end

--     hook.Remove("PostDrawHUD", "LoadingSoundFade")

--     return
--   end
-- end)  

concommand.Add( "openCharMenu", function()
  -- if IsValid(soundStream) then
    soundStream:Stop()
  --   soundStream = nil
  -- end
 prestartpanel = vgui.Create("BFrame")

prestartpanel:SetPos(0, 0)
prestartpanel:SetSize(ScrW(), ScrH())
prestartpanel:MakePopup()
prestartpanel:SetTitle('')
prestartpanel:ShowCloseButton(false)
prestartpanel:SetMouseInputEnabled(true)
prestartpanel:SetKeyboardInputEnabled(true)
prestartpanel.Paint = function(self, w, h)
  surface.SetDrawColor(Color(0,0,0,150))
  surface.DrawRect(-1, -1, ScrW() + 2, ScrH() + 2)
  draw.StencilBlur(self, w, h)
  -- surface.SetDrawColor(color_white)
  -- surface.SetMaterial(load_bg)
  -- surface.DrawTexturedRect(-300, -20, ScrW()*1.2, ScrH()*1.2)

  draw.ShadowSimpleText( 'Lost City', 'font_base_ds', w/2, h*0.3, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

end

-- local buttonpanel = vgui.Create( "DPanel", prestartpanel )
--   -- buttonpanel:Dock(FILL)
--   buttonpanel:DockMargin(5,5,5,5)
--   buttonpanel:SetWide(prestartpanel:GetWide()/2)
--   buttonpanel:SetPos(prestartpanel:GetWide()/2`)
--   buttonpanel.Paint = function(self,w,h)
--     draw.RoundedBox(5,0,0,w,h,Color(30,30,30,200))
--   end

local LoadChar = vgui.Create( "BButton", prestartpanel)
    LoadChar:SetPos(prestartpanel:GetWide()/2.3, prestartpanel:GetTall()/2.5)
    LoadChar:SetWide(prestartpanel:GetWide()/6)
    LoadChar:SetTall(70)
    LoadChar:SetText("")
    LoadChar.DoClick = function()
      RunConsoleCommand("loaddata")
      -- ToggleLoadingScreen()
    end
    LoadChar.Paint = function(self, w, h)
      local col = color_white
      if self:IsHovered() then col = Color(200,200,200) else col = color_white end
      draw.ShadowSimpleText( 'Загрузить персонажа', 'font_base_uglybutton', w/2.3, h/2, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    end

local Create = vgui.Create( "BButton", prestartpanel)
    Create:SetPos(prestartpanel:GetWide()/2.3, prestartpanel:GetTall()/2.2)
    Create:SetWide(prestartpanel:GetWide()/6)
    Create:SetTall(70)
    Create:SetText("")
    Create.DoClick = function()
      RunConsoleCommand("loaddata")
      -- ToggleLoadingScreen()
    end
    Create.Paint = function(self, w, h)
      local col = color_white
      if self:IsHovered() then col = Color(200,200,200) else col = color_white end
      draw.ShadowSimpleText( 'Создать персонажа', 'font_base_uglybutton', w/2.3, h/2, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    end

local Create = vgui.Create( "BButton", prestartpanel)
    Create:SetPos(prestartpanel:GetWide()/2.3, prestartpanel:GetTall()/2)
    Create:SetWide(prestartpanel:GetWide()/6)
    Create:SetTall(70)
    Create:SetText("")
    Create.DoClick = function()
      RunConsoleCommand("disconnect")
    end
    Create.Paint = function(self, w, h)
      if self:IsHovered() then col = Color(200,200,200) else col = color_white end
      draw.ShadowSimpleText( 'Выйти с сервера', 'font_base_uglybutton', w/2.3, h/2, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
    end

  -- timer.Simple(1, function()
  --   sound.PlayURL("https://gmod-octopus.ru/music/dayz.mp3", "noplay", function(chan, err, str)
  --     if IsValid(chan) then
  --       chan:SetVolume(0.5)
  --       chan:Play()
  --       soundStream = chan
  --     end
  --   end)

    -- system.FlashWindow()
  -- end)
end)
