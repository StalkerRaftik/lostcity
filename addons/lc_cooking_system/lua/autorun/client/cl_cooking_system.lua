
function draw.CookingBackground(x, y, w, h, alpha, panel, color_new)
    if panel then
        draw.StencilBlur(panel, w, h)
    end

    draw.RoundedBox(0, x, y, w, h, Color(0, 0, 0, alpha))

    if color_new then
        draw.RoundedBox(0, 0, 0, w, 25, color_new)
    end

    surface.SetDrawColor(Color(0,0,0))
    surface.DrawOutlinedRect(x, y, w, h)
end

function draw.CookingBackgroundColored(x, y, w, h, color_new)
    draw.RoundedBox(0, x, y, w, h, color_new)

    surface.SetDrawColor(Color(0,0,0))
    surface.DrawOutlinedRect(x, y, w, h)
end

local function MakeInlineDesc(recipe)
  local str = "Рецепт: "
  for k,v in pairs(recipe) do

    local plamount = LocalPlayer():GetItemCount("food", k)
    if plamount == 0 then plamount = LocalPlayer():GetItemCount("entity", k) end

    local tbl = Inventory.GetItem("food", k)
    if (k == "testo") then
      print(tbl)
    end
    if not tbl then 
      tbl = Inventory.GetItem("entity", k)
    end

    if (k == "testo") then
      print(tbl)
    end

    if plamount < v then
      str = str..(tbl and tbl.name or "ERROR_ITEM_NOT_EXIST("..k..")")..": <color=200,50,50>x"..v.."</color>  "
    else
      str = str..(tbl and tbl.name or "ERROR_ITEM_NOT_EXIST("..k..")")..": <color=50,200,50>x"..v.."</color>  "
    end
  end
  return str
end

local function MakeInlineDescRazbor(item)
  local str = "Вы получите: "
  for k,v in pairs(CookingSystem.Disassembly[item.Class].player_get) do
    str = str..CookingSystem.Details[k].name..": <color=50,200,50>x"..v.."</color>  "
  end
  return str
end

local function CanCookRecipe(recipe)
  local can_Cook = true
  for k,v in pairs(recipe) do
    local plamount = LocalPlayer():GetItemCount("entity", k)
    if plamount == 0 then plamount = LocalPlayer():GetItemCount("food", k) end
    if plamount < v then
      can_Cook = false
    end
  end
  return can_Cook
end


local function makeScrollBarPretty(pnl)
  pnl.Paint = function(self, w, h) end
  pnl.btnGrip.Paint = function(self, w, h)
    local extend = pnl:IsChildHovered() or self.Depressed
    draw.RoundedBox(extend and 4 or 2,
      extend and 0 or w / 2 - 2,
      -4,
      extend and w or 4,
      h+8,
      CookingSystem.HeaderColor)
  end
  pnl.btnUp.Paint = function( self, w, h ) end
  pnl.btnDown.Paint = function( self, w, h ) end
  pnl:SetWide(3)
end

local dframe


local function OpenCategory(base, cat)
  if base.scrpnl then base.scrpnl:Remove() end
  if base.craftinfo then base.craftinfo:Remove() end

  base.scrpnl = vgui.Create("DScrollPanel", base)
  base.scrpnl:SetSize(base:GetWide()-160, base:GetTall()-45)
  base.scrpnl:SetPos(150, 35)
  makeScrollBarPretty(base.scrpnl:GetVBar())

  base.layout = vgui.Create("DIconLayout", base.scrpnl)
  base.layout:SetSize( base.scrpnl:GetWide(), base.scrpnl:GetTall())
  base.layout:SetPos( 10, 0 )
  base.layout:SetSpaceY( 5 )
  base.layout:SetSpaceX( 5 )

  base.craftinfo = vgui.Create("DFrame", base)
  base.craftinfo:SetSize(base:GetWide()-160, base:GetTall()/3)
  base.craftinfo:SetPos(161, base:GetTall()-base:GetTall()/3)
  base.craftinfo:SetTitle("")
  base.craftinfo.crafttbl = nil
  base.craftinfo.craftname = nil
  base.craftinfo:SetVisible(false)
  base.craftinfo:SetDraggable(false)
  base.craftinfo:SetDeleteOnClose( false )
  base.craftinfo.resulttext = ""
  base.craftinfo.resultclr = Color(255,255,255)
  base.craftinfo.Paint = function(slf, w, h)
    if base.craftinfo.crafttbl == nil then return end

    draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 250))

    draw.ShadowSimpleText( "Приготовить " .. (base.craftinfo.crafttbl.name or "Неизвестно"), "rp.ui.32", w*0.45, 10, Color(255,255, 255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
    draw.ShadowSimpleText( "Описание:", "rp.ui.28", 10, 40, Color(255,255, 255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
    draw.ShadowSimpleText( "Ингридиенты:", "rp.ui.28", w*0.65, 40, Color(255,255, 255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
    if (base.craftinfo.resulttext != "") then
      draw.ShadowSimpleText( base.craftinfo.resulttext, "rp.ui.22", w*0.45, h-80, base.craftinfo.resultclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
    end
    local markup_obj = nil
    markup_obj = markup.Parse("<font=rp.ui.20>"..MakeInlineDesc(base.craftinfo.crafttbl.recipe).."</font>")
    markup_obj:Draw(w*0.55,80,TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

    if not base.craftinfo.weppreview then
      base.craftinfo.weppreview = vgui.Create( "DModelPanel", base.craftinfo )
      base.craftinfo.weppreview:SetPos(0, 100)
      base.craftinfo.weppreview:SetSize(w*0.4,h-100)
      base.craftinfo.weppreview:SetModel( Inventory.GetItem("entity", base.craftinfo.craftname) and Inventory.GetItem("entity", base.craftinfo.craftname).model or base.craftinfo.craftname)
      base.craftinfo.weppreview:SetCamPos(Vector(15, 15, 8))
      base.craftinfo.weppreview:SetLookAt(Vector(-10, 0, 0))
      base.craftinfo.weppreview:SetAmbientLight(Color(255, 255, 255, 255))
    else
      base.craftinfo.weppreview:SetModel( Inventory.GetItem("entity", base.craftinfo.craftname) and Inventory.GetItem("entity", base.craftinfo.craftname).model or base.craftinfo.craftname)
    end
  end
  base.craftinfo.OnClose = function()
    base.craftinfo.crafttbl = nil
    base.craftinfo.craftname = nil
  end

  base.craftinfo.desc = vgui.Create('DLabel', base.craftinfo)
  base.craftinfo.desc:SetSize(base.craftinfo:GetWide()*0.4,base.craftinfo:GetTall()-60)
  base.craftinfo.desc:SetPos(10,70)   
  base.craftinfo.desc:SetWrap(true)
  base.craftinfo.desc:SetAutoStretchVertical( true )
  base.craftinfo.desc:SetFont('ui.23')
  base.craftinfo.desc:SetText((base.craftinfo.crafttbl and base.craftinfo.crafttbl.desc) or "Описания нет")
  base.craftinfo.desc:SetTextColor(Color(240,240,240))

   -- you can only change colors on playermodels
  --function base.craftinfo.weppreview.Entity:GetPlayerColor() return Vector (1, 0, 0) end --we need to set it to a Vector not a Color, so the values are normal RGB values divided by 255.

  base.craftinfo.btn = vgui.Create('DButton', base.craftinfo)
  base.craftinfo.btn:SetSize(80, 50)
  base.craftinfo.btn:SetPos(base.craftinfo:GetWide()*0.45-40, base.craftinfo:GetTall()-60)
  base.craftinfo.btn:SetText("")
  base.craftinfo.btn.craftcd = 0
  base.craftinfo.btn.Paint = function(slf, w, h)
    if slf:IsHovered() then
      draw.RoundedBox( 10, 0, 0, w, h, Color(255, 72, 0) )
      draw.RoundedBox( 10, 2, 2, w-4, h-4, Color(100,100,100) )
      draw.ShadowSimpleText("Выбрать", "rp.ui.22", w/2, h/2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    else
      draw.RoundedBox( 10, 0, 0, w, h, Color(138, 40, 1) )
      draw.RoundedBox( 10, 2, 2, w-4, h-4, Color(39,39,39) )
      draw.ShadowSimpleText("Выбрать", "rp.ui.22", w/2, h/2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
  end
  base.craftinfo.btn.DoClick = function()
    if (CurTime() > base.craftinfo.btn.craftcd) then
      if CanCookRecipe(base.craftinfo.crafttbl.recipe) then
        base.craftinfo.btn.craftcd = CurTime() + 1.8
        net.Start("CookingSystem.Cook")
          net.WriteString(base.craftinfo.craftname)
          net.WriteEntity(stove)
        net.SendToServer()
        dframe:Close()
      else
        base.craftinfo.btn.craftcd = CurTime() + 1
        base.craftinfo.resulttext = "Не хватает ингридиентов!"
        base.craftinfo.resultclr = Color(200,0,0)
        timer.Simple( 1, function() 
          base.craftinfo.resulttext = ""
          base.craftinfo.resultclr = Color(255,255,255) 
        end)
        surface.PlaySound( "buttons/button15.wav" )
      end
    end
  end

  local recipes = CookingSystem.Recipes

  if cat ~= "Все" then
    recipes = {}
    for k,v in pairs(CookingSystem.Recipes) do
      if v.category == cat then
        recipes[k] = v
      end
    end
  end

  for k,v in pairs(recipes) do
    base['crpanel'..k] = base.layout:Add("monoPanel")
      base['crpanel'..k]:SetSize(base.layout:GetWide(), 80)
      base['crpanel'..k].Paint = function(slf, w, h)
        -- draw.CraftingBackground(0,0,w,h,150)
        draw.CraftingBackgroundColored(0,0,w,h,Color(35,35,35,180))
        surface.SetDrawColor( 100, 100, 100, 255 )
        surface.DrawOutlinedRect( 0, 0, w, h, 1 )

        draw.ShadText(v.name and v.name or (weapons.GetStored(k) and weapons.GetStored(k).PrintName) or (R_CraftSystem.Disassembly[v.Class] and R_CraftSystem.Disassembly[v.Class].name), "rp.ui.32", 130, 10, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        local markup_obj = nil
        if cat == "Разбор" then
          markup_obj = markup.Parse("<font=rp.ui.20>"..MakeInlineDescRazbor(v).."</font>")
        else
          markup_obj = markup.Parse("<font=rp.ui.20>"..MakeInlineDesc(v.recipe).."</font>")
        end
        markup_obj:Draw(130,40,TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
      end

      base.icon = vgui.Create("SpawnIcon", base['crpanel'..k])
      base.icon:SetSize(100, 100)
      base.icon:SetPos(5,0)
      base.icon:SetModel(Inventory.GetItem("entity", k) and Inventory.GetItem("entity", k).model or k)
      base.icon.PaintOver = function() end
      base.icon:SetTooltip(false)

      base.btn_craft = vgui.Create("BButton", base['crpanel'..k])
      base.btn_craft:SetSize(base['crpanel'..k]:GetWide(), base['crpanel'..k]:GetTall())
      base.btn_craft:SetPos(0, 0)
      base.btn_craft:SetText("")
      base.btn_craft.Paint = function(slf, w, h)
        local text = cat == "Разбор" and "Разобрать" or "Создать"
        if slf:IsHovered() then
          draw.CraftingBackground(0,0,w,h,130)
          surface.SetDrawColor( 100, 100, 100, 255 )
          surface.DrawOutlinedRect( 0, 0, w, h, 1 )
          draw.ShadText(text, "font_base_24", w/1.05, h/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
      end
      base.btn_craft.DoClick = function()
      base.btn_craft.craftcd = 0
      if (CurTime() > base.btn_craft.craftcd) then
        if cat ~= "Разбор" then
          base.craftinfo.crafttbl = v
          base.craftinfo.craftname = k
          base.craftinfo.craftcost = 0
          for k,v in pairs(base.craftinfo.crafttbl.recipe) do
            base.craftinfo.craftcost = base.craftinfo.craftcost + v
          end
          base.craftinfo.resulttext = ""
          base.craftinfo:SetVisible(true)
          -- if CanCraftRecipe(v.recipe) then
          --  base.btn_craft.craftcd = CurTime() + 1.8
          --  DrawProgressBar(base, CurTime(), k, base)
          -- else
          --  --DrawCraftMessage("Текст. ткстТекст. ткстТекст. ткстТекст. ткстТекст. ткстТекст. ткстТекст. ткст", "Скрафтить", base)
          --  base.btn_craft.craftcd = CurTime() + 0.3
          --  notification.AddLegacy( "У вас не хватает ресурсов.", 1, 4 )
          --  surface.PlaySound( "buttons/button15.wav" )
          -- end
        else
          base.btn_craft.craftcd = CurTime() + 1.8
          DrawProgressBar2(base, CurTime(), k, base)
        end
      end
      -- if CanCraftRecipe(v.recipe) then
      --  DrawProgressBar(base, CurTime(), k)
      -- else
      --  notification.AddLegacy( "У вас не хватает ресурсов.", 1, 4 )
      --  surface.PlaySound( "buttons/button15.wav" )
      -- end
    end
  end
end


net.Receive("CookingSystem.OpenMenu", function()
  stove = net.ReadEntity()
  if IsValid(dframe) then dframe:Remove() end
  
  dframe = vgui.Create("BFrame")
  dframe:SetSize(ScrW()*0.95, ScrH()*0.95)
  dframe:Center()
  dframe:SetTitle("")
  dframe:MakePopup()

  dframe.sp = vgui.Create("DScrollPanel", dframe)
  dframe.sp:SetSize(150, dframe:GetTall()-75)
  dframe.sp:SetPos(5, 100)
  -- dframe.sp.VBar:SetWide(0)
  makeScrollBarPretty(dframe.sp:GetVBar())

  dframe.dil = vgui.Create("DIconLayout", dframe.sp)
  dframe.dil:SetSize( dframe.sp:GetWide(), dframe.sp:GetTall())
  dframe.dil:SetPos( 0, 0 )
  dframe.dil:SetSpaceY( 5 )
  dframe.dil:SetSpaceX( 5 )

  local cats = CookingSystem.Categories

  for k,v in pairs(cats) do
    dframe.crpanel = dframe.dil:Add("BButton")
    dframe.crpanel:SetSize(dframe.dil:GetWide(), 100)
    dframe.crpanel:SetText("")

    dframe.crpanel.PaintOver = function(slf, w, h)
      if slf:IsHovered() then
        draw.CraftingBackgroundColored(0,0,w,h, v.color)
        draw.DrawNonParsedTextOutlined(v.name, "rp.ui.25", w/2, h/3, color_white, TEXT_ALIGN_CENTER)
      else
        draw.CraftingBackgroundColored(0,0,w,h, v.color)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 155))
        draw.DrawNonParsedTextOutlined(v.name, "rp.ui.25", w/2, h/3, color_white, TEXT_ALIGN_CENTER)
      end
    end
    dframe.crpanel.DoClick = function()
      OpenCategory(dframe, v.name)
    end
  end
  OpenCategory(dframe, "Все")
end)
