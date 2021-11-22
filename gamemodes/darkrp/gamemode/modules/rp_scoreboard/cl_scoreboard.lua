local function timeToStr( time )
  local tmp = time
  local s = tmp % 60
  tmp = math.floor( tmp / 60 )
  local m = tmp % 60
  tmp = math.floor( tmp / 60 )
  local h = tmp % 24
  tmp = math.floor( tmp / 24 )
  local d = tmp % 7
  local w = math.floor( tmp / 7 )

  return string.format( "%02iн %iд %02iч %02iмин %02iсек", w, d, h, m, s )
end

local Main = nil
local HeightLine = 36

local mat_sa = Material('samprp/icons/hammer.png', 'noclamp smooth')
local mat_ga = Material('samprp/icons/hammer.png', 'noclamp smooth')
local mat_a4 = Material('samprp/moreicons/gradcap.png', 'noclamp smooth')
local mat_a3 = Material('samprp/icons/shield.png', 'noclamp smooth')
local mat_a2 = Material('samprp/icons/star.png', 'noclamp smooth')
local mat_a1 = Material('samprp/icons/wrench.png', 'noclamp smooth')
local mat_adminstajer = Material('icons/case.png', 'noclamp smooth')
local mat_iventologgl = Material('samprp/moreicons/cogs2.png', 'noclamp smooth')
local mat_iventologst = Material('samprp/moreicons/cog.png', 'noclamp smooth')
local mat_iventolog = Material('samprp/moreicons/cogs.png', 'noclamp smooth')
local mat_sponsor = Material('samprp/moreicons/crown.png', 'noclamp smooth')
local mat_userplus = Material('samprp/moreicons/man_madd.png', 'noclamp smooth')
local mat_user = Material('samprp/moreicons/man_m.png', 'noclamp smooth')
local mat_vip = Material('samprp/moreicons/heart.png', 'noclamp smooth')
local mat_premium = Material('samprp/moreicons/gift_coin.png', 'noclamp smooth')
local mat_tux = Material('icon16/tux.png', 'noclamp smooth')
local mat_manageradmin = Material('samprp/icons/case.png', 'noclamp smooth')
local mat_globalmanager = Material('samprp/icons/database.png', 'noclamp smooth')

local tblIconsGroups = {
  ['sudoroot'] = { col = Color(255,255,255), icon = mat_tux, name = "Основатель" },
  ['root'] = { col = Color(255,255,255), icon = mat_tux, name = "Основатель" },
  ['globalmanager'] = { col = Color(255,255,255), icon = mat_globalmanager, name = "Глобальный менеджер администрации" },
  ['collegemanager'] = { col = Color(255,0,0), icon = mat_manageradmin, name = "Заведующий колледжем персонала" },
  ['globaladmin'] = { col = Color(255,255,255), icon = mat_ga, name = "Гл. Админ" },
  ['superadmin'] = { col = Color(255,255,255), icon = mat_sa, name = "Гл. Админ" },
  ['rpcuratorleader'] = { col = Color(255,255,255), icon = mat_iventologgl, name = "Главный РП-куратор" },
  ['rpcurator'] = { col = Color(255,255,255), icon = mat_iventolog, name = "РП-куратор" },
  ['juniorrpcurator'] = { col = Color(255,255,255), icon = mat_iventolog, name = "РП-куратор стажёр" },
  ['admin3lvl'] = { col = Color(255,255,255), icon = mat_a3, name = "Админ 3 ур." },
  ['admin2lvl'] = { col = Color(255,255,255), icon = mat_a2, name = "Админ 2 ур." },
  ['admin1lvl'] = { col = Color(255,255,255), icon = mat_a1, name = "Админ 1 ур." },
  ['adminstajer'] = { col = Color(255,255,255), icon = mat_adminstajer, name = "Админ-стажёр" },
  ['spy'] = { col = Color(255,255,255), icon = mat_user, name = "Игрок" },
  ['vip'] = { col = Color(255,255,255), icon = mat_vip, name = "V.I.P" },
  ['premium'] = { col = Color(255,255,255), icon = mat_premium, name = "Premium" },
  ['sponsor'] = { col = Color(255,255,255), icon = mat_sponsor, name = "Спонсор" },
  ['igrokplus'] = { col = Color(255,255,255), icon = mat_userplus, name = "Игрок+" },  
  ['user'] = { col = Color(255,255,255), icon = mat_user, name = "Игрок" }
}

function ScoreboardOpen()
  if ( !IsValid(Main) ) then
    alpha = 0
    alpha_lerp = 0
    LocalPlayer().Scoreboard = true
    Main = vgui.Create("DFrame")
    Main:SetSize(ScrW(),ScrH())
    Main:SetPos((ScrW()-Main:GetWide())/2,(ScrH()-Main:GetTall())/2)
    Main:SetTitle('')


    Main:SetDraggable(false)
    Main:ShowCloseButton(false)
    Main.Paint = function( self, w, h )
      alpha = 230
      alpha_lerp = Lerp(FrameTime()*2,alpha_lerp or 0,alpha or 0) or 0
      local x, y = self:GetPos()
      draw.BlurBackground(x, y, w, h, (alpha_lerp/100), self)
      draw.RoundedBox(0,0,0,w,h,Color(30,30,30,alpha_lerp/1.2))
      draw.ShadowSimpleText( GetHostName(), 'font_base', w/1.95, h*0.04, Color( 235, 235, 235, alpha_lerp ), 1, 1 )
      draw.ShadowSimpleText( "Онлайн: " .. player.GetCount() .. "/" .. game.MaxPlayers() .. ' игроков и '..#ba.GetStaff().." Администраторов", 'font_base_24', w/2, h*0.07, Color( 235, 235, 235, alpha_lerp ), 1, 1 )
    end

    local Scroll = vgui.Create("SRP_ScrollPanel",Main)
    -- Scroll:MoveTo(Main:GetWide()/3.6,Main:GetTall()/12,0.4,0)
    Scroll:SetSize(Main:GetWide()/2,Main:GetTall()/1.2)
    -- Scroll:SetPos(Main:GetWide()/3.6,Main:GetTall())
    Scroll:SetPos(Main:GetWide()/4,Main:GetTall()/12,0.4,0)

    Scroll.sbar = Scroll:GetVBar()
    Scroll.sbar.Paint = function( self, w, h ) draw.RoundedBox(6, 0, 0, w/1.8, h, Color(0, 0, 0, 150, alpha_lerp)) end
    Scroll.sbar.btnUp.Paint = function( self, w, h ) end
    Scroll.sbar.btnDown.Paint = function( self, w, h ) end
    Scroll.sbar.btnGrip.Paint = function( self, w, h ) draw.RoundedBox(14, 0, 0, w/1.8, h, Color(245, 245, 245, 150, alpha_lerp)) end

    local Players = player.GetAll()
    for k, v in pairs(Players) do
      local button_hover = {}
      if not v or not IsValid(v) then continue end

      local pName = LocalPlayer():IsAdmin() and v:RPName(true) or v:RPName()
    local pJob = v:GetJobName() or ""
    local pColor = v:GetJobColor() or Color(240,240,240, alpha_lerp)

      local PlayerPanel = vgui.Create("DPanel",Scroll)
      PlayerPanel:SetSize(Scroll:GetWide(),HeightLine)
      PlayerPanel:SetPos(0,((HeightLine+2)*k)-HeightLine)
      PlayerPanel.Paint = function( self, w, h )
        w = w - 16
        local col = Color(0, 0, 0, 150, alpha_lerp)
        if button_hover and button_hover[k] then
          col = Color(40, 40, 40, 150, alpha_lerp)
        end
        draw.RoundedBox(0, 0, 0, w, h, col)
        surface.SetDrawColor(Color(60,60,60))
        surface.DrawOutlinedRect(0, 0, w, h)
        draw.ShadowSimpleText(pName, "font_base_24", HeightLine+2, h*.15, Color(240,240,240, alpha_lerp), 0, 0)
        surface.SetFont('font_base_24')
        local w_name, h_name = surface.GetTextSize(pName)

        local col = Color(109,204,80, alpha_lerp)

        local steamname = ""

        if IsValid(v) and v:IsPlayer() then
          steamname = v:Name() or ""
        else
          steamname = "BOT"
        end


        draw.ShadowSimpleText(pJob, "font_base_18", w/2, h/2, Color(pColor.r,pColor.g,pColor.b, alpha_lerp), 1, 1)

        if LocalPlayer():IsAdmin() and button_hover and button_hover[k] then
          draw.ShadowSimpleText(steamname, "font_base_18", w-w/1.06 + w_name, h/4, Color(200,200,200, alpha_lerp), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
        end

        surface.SetFont('font_base_18')
    if v:IsSponsor() and v:GetRank() == "user" then
      local name = "Спонсор"
      local name_w = 0
      if button_hover and button_hover[k] then
        name_w, _ = surface.GetTextSize(name)
        draw.ShadowSimpleText(name, "font_base_18", w-30, h/4, Color(245,245,245), TEXT_ALIGN_RIGHT, TEXT_ALIGN_RIGHT)
      end        
      surface.SetMaterial(mat_sponsor)
      surface.SetDrawColor(color_white)
      surface.DrawTexturedRect(w-24,h/4,16,16)  
    elseif v:IsPremium() and v:GetRank() == "user" then
      local name = "Premium"
      local name_w = 0
      if button_hover and button_hover[k] then
        name_w, _ = surface.GetTextSize(name)
        draw.ShadowSimpleText(name, "font_base_18", w-30, h/4, Color(245,245,245), TEXT_ALIGN_RIGHT, TEXT_ALIGN_RIGHT)
      end        
      surface.SetMaterial(mat_premium)
      surface.SetDrawColor(color_white)
      surface.DrawTexturedRect(w-24,h/4,16,16)               
    elseif v:IsVIP() and v:GetRank() == "user" then
      local name = "V.I.P"
      local name_w = 0
      if button_hover and button_hover[k] then
        name_w, _ = surface.GetTextSize(name)
        draw.ShadowSimpleText(name, "font_base_18", w-30, h/4, Color(245,245,245), TEXT_ALIGN_RIGHT, TEXT_ALIGN_RIGHT)
      end        
      surface.SetMaterial(mat_vip)
      surface.SetDrawColor(color_white)
      surface.DrawTexturedRect(w-24,h/4,16,16)
    elseif v:IsIgrokPlus() and v:GetRank() == "user" then
      local name = "Игрок +"
      local name_w = 0
      if button_hover and button_hover[k] then
        name_w, _ = surface.GetTextSize(name)
        draw.ShadowSimpleText(name, "font_base_18", w-30, h/4, Color(245,245,245), TEXT_ALIGN_RIGHT, TEXT_ALIGN_RIGHT)
      end        
      surface.SetMaterial(mat_userplus)
      surface.SetDrawColor(color_white)
      surface.DrawTexturedRect(w-24,h/4,16,16)                                    
    else
      for group, tbl in pairs(tblIconsGroups) do
        if v:GetRank() == group then
          local name = tblIconsGroups[v:GetRank()].name
          local name_w = 0
          if button_hover and button_hover[k] then
            name_w, _ = surface.GetTextSize(name)
            draw.ShadowSimpleText(name, "font_base_18", w-30, h/4, Color(245,245,245), TEXT_ALIGN_RIGHT, TEXT_ALIGN_RIGHT)
          end
          surface.SetMaterial(tbl.icon)
          surface.SetDrawColor(tbl.col)
          surface.DrawTexturedRect(w-24,h/4,16,16)
        end
      end
          
        end
      end
      local Avatar = vgui.Create( "AvatarImage", PlayerPanel )
      Avatar:SetSize( HeightLine-1, HeightLine-2 )
      Avatar:SetPos( 1, 1 )
      Avatar:SetPlayer( v, 64 )

      local Button = vgui.Create("DButton",PlayerPanel)
      Button:SetSize(PlayerPanel:GetWide(),PlayerPanel:GetTall())
      Button:SetText('')
      Button:SetPos(0,0)
      Button.Paint = function( self, w, h )
        button_hover[k] = Button:IsHovered()
      end

      Button.DoClick = function()
        if not v or not IsValid(v) then return end
        local bNoAccess = true
        local menu = DermaMenu();
        menu:SetSkin('core')
        menu:AddOption("С нами уже: "..timeToStr( v:GetPlayTime()), function() end)
        menu:AddOption("Открыть профиль Steam", function()
          v:ShowProfile()
        end):SetIcon("icon16/group_link.png");
        menu:AddSpacer()
        menu:AddOption("Скопировать SteamID", function()
          SetClipboardText(v:SteamID() or "");
        end):SetIcon("icon16/page_copy.png");
        menu:AddOption("Скопировать SteamID64", function()
          SetClipboardText(v:SteamID64() or "");
        end):SetIcon("icon16/page_copy.png");
        menu:AddOption("Скопировать ник", function()
          SetClipboardText(v:Name() or "");
        end):SetIcon("icon16/page_copy.png");

     
        menu:Open();
      end
    end
  end
end

function ScoreboardClose()
  if IsValid(Main) then
    Main:Close()
    LocalPlayer().Scoreboard = false
  end
end

function GM:ScoreboardShow()
if not IsValid(LocalPlayer()) then return end
if not LocalPlayer():Alive() then return end
-- if LocalPlayer().intro then return end
if LocalPlayer():GetNVar('PlayerDataLoaded') ~= true then return end
-- if LocalPlayer():GetNVar('CheckRulesAnswers') ~= true then return end

  ScoreboardOpen()

  if IsValid(Main) then
    Main:Show()
    Main:MakePopup()
    Main:SetKeyboardInputEnabled(false)
  end
end

function GM:ScoreboardHide()
  if IsValid(Main) then
    ScoreboardClose()
  end
end
