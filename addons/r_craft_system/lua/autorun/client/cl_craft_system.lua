 local blur = Material("pp/blurscreen", "noclamp")
 function draw.StencilBlur(panel, w, h)
    render.ClearStencil()
    render.SetStencilEnable(true)
    render.SetStencilReferenceValue(1)
    render.SetStencilTestMask(1)
    render.SetStencilWriteMask(1)
    render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER)
    render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
    render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
    render.SetStencilZFailOperation(STENCILOPERATION_REPLACE)
    surface.SetDrawColor(255, 255, 255, 255)
    surface.DrawRect(0, 0, w, h)
    render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
    render.SetStencilFailOperation(STENCILOPERATION_KEEP)
    render.SetStencilPassOperation(STENCILOPERATION_KEEP)
    render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
    surface.SetMaterial(blur)
    surface.SetDrawColor(255, 255, 255, 255)

    for i = 0, 1, 0.33 do
        blur:SetFloat('$blur', 5 * i)
        blur:Recompute()
        render.UpdateScreenEffectTexture()
        local x, y = panel:GetPos()
        surface.DrawTexturedRect(-x, -y, ScrW(), ScrH())
    end

    render.SetStencilEnable(false)
end

function DrawCraftMessage(Text, btnText, parent)
  LocalPlayer():EmitSound("buttons/button10.wav")
  local ErrorMsg
  if parent then
    Msg = vgui.Create('DFrame', parent)
  else 
    Msg = vgui.Create('DFrame')
  end
  
  Msg:SetTitle("")
  Msg:ShowCloseButton(false)
  Msg:SetSize(600,ScrH()*0.5) 
  Msg:SetPos(ScrW()/2-Msg:GetWide()/2, ScrH()/2-Msg:GetTall()/2)
  Msg.Paint = function( self, w, h )
    draw.RoundedBox(5,0,0,w,h, Color(50,50,50,250))
    draw.RoundedBoxEx(5,0,0,w,30, Color(0,0,0,200),true,true,false,false)
    draw.ShadowSimpleText( "", "rp.ui.29", 9, 5, Color(255,1, 71,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
  end

  local ErrorBtn = vgui.Create( "DButton", Msg ) 
  ErrorBtn:SetText( "" )
  ErrorBtn:SetPos( Msg:GetWide()*0.97, 10 ) 
  ErrorBtn:SetSize( 15, 15 )   
  ErrorBtn.Paint = function( self, w, h )   
    draw.ShadowSimpleText( "X", "rp.ui.15", 0, h/2, Color(200,200,200,200), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
  end    
  ErrorBtn.DoClick = function()   
    Msg:Remove()
  end

  SideHelperText = vgui.Create('DLabel', Msg)
  SideHelperText:SetSize(Msg:GetWide()-20,Msg:GetTall()*0.7)
  SideHelperText:SetPos(10,20)   
  SideHelperText:SetWrap(true)
  SideHelperText:SetFont('ui.22')
  SideHelperText:SetText(Text)
  SideHelperText:SetTextColor(Color(230,230,230))


  local Btn = vgui.Create( "DButton", Msg ) 
  Btn:SetText( "" )
  Btn:SetPos( Msg:GetWide()/2-30, Msg:GetTall()-70 ) 
  Btn:SetSize( 60, 50 )   
  Btn.Paint = function( self, w, h )   
  	draw.RoundedBox(5,0, 0,w,h, Color(155,155,155,255))

  end    
  Btn.DoClick = function()   
    Msg:Remove()
  end
end

function draw.CraftingBackground(x, y, w, h, alpha, panel, color_new)
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

function draw.CraftingBackgroundColored(x, y, w, h, color_new)
    draw.RoundedBox(0, x, y, w, h, color_new)

    surface.SetDrawColor(Color(0,0,0))
    surface.DrawOutlinedRect(x, y, w, h)
end

function draw.ShadText(text, font, x, y, color, a_x, a_y)
	draw.SimpleText(text, font, x+1, y+1, Color(0,0,0), a_x, a_y)
	draw.SimpleText(text, font, x, y, color, a_x, a_y)
end

local function MakeInlineDesc(recipe)
	local str = ""
	local parscounter = 0
	for k,v in pairs(recipe) do
		local tbl = {}
		tbl.count = v
		local plamount = LocalPlayer():GetItemCount("entity", k)

		local tbl = Inventory.GetItem("entity", k)
		if not tbl then tbl = Inventory.GetItem("weapon", k) end
		if not tbl then tbl = R_CraftSystem.Recipes[k] end

		if plamount < v then
			str = str.. (tbl and tbl.name or "ERROR_ITEM_NOT_EXIST("..k..")") ..": <color=230,50,50>x"..v.."</color>  "
		else
			str = str.. (tbl and tbl.name or "ERROR_ITEM_NOT_EXIST("..k..")") ..": <color=50,230,50>x"..v.."</color>  "
		end
	end
	return str
end

local strtbl
local function MakeInlineDescByTable(recipe)
	strtbl = {}
	for k,v in pairs(recipe) do
		local tbl = {}
		tbl.count = v
		local plamount = LocalPlayer():GetItemCount("entity", k)

		local tbl = Inventory.GetItem("entity", k)
		if not tbl then tbl = Inventory.GetItem("weapon", k) end
		if not tbl then tbl = R_CraftSystem.Recipes[k] end

		table.insert(strtbl, Color(255,255,255, 230))
		table.insert(strtbl, (tbl and tbl.name or "ERROR_ITEM_NOT_EXIST("..k..")") .. ": ")

		if plamount < v then
			table.insert(strtbl, Color(230,50,50))
		else
			table.insert(strtbl, Color(50,230,50))
		end
		table.insert(strtbl, v)

		table.insert(strtbl, Color(255,255,255, 230))
		table.insert(strtbl, ", ")
	end
	return strtbl
end


local function MakeInlineDescRazbor(item)
	local str = "Вы получите: "
	local parscounter = 0
	for k,v in pairs(R_CraftSystem.Disassembly[item.class].player_get) do
		parscounter = parscounter + 1
		local amounttext
		if istable(v) then
			if v[1] >= 0 then
				amounttext = "от " .. v[1].." "
			else
				amounttext = "от 0 "
			end
			amounttext = amounttext .. "до "..v[2]
		else
			amounttext = v
		end
		str = str..R_CraftSystem.Details[k].name.."<color=50,200,50> ("..amounttext..")</color>  "
		if parscounter >= 4 then
			str = str .. "\n"
			parscounter = 0
		end
	end
	return str
end

local function CanCraftRecipe(recipe)
	local can_craft = true
	for k,v in pairs(recipe) do
		local plamount = LocalPlayer():GetItemCount("entity", k)
		if plamount < v then
			can_craft = false
		end
	end
	return can_craft
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
			R_CraftSystem.HeaderColor)
	end
	pnl.btnUp.Paint = function( self, w, h ) end
	pnl.btnDown.Paint = function( self, w, h ) end
	pnl:SetWide(3)
end

local dframe

local function DrawProgressBar(dframe, CraftingTime, k, parent)
	-- net.Start("EmitCratfSound")
	-- net.WriteEntity(LocalPlayer())
	-- net.SendToServer()


	dframe:Remove()

	-- local barframe = vgui.Create("BFrame", parent)
	-- barframe:MakePopup()
	-- barframe:ShowCloseButton(false)
	-- barframe:SetSize(ScrW()/5, ScrH()/7)
	-- barframe:SetDraggable(false)
	-- barframe:SetTitle("Создание "..R_CraftSystem.Recipes[k].name)
	-- barframe:SetPos(ScrW()/2.5, ScrH()/2.3 )

	-- m_pnlTimeBar = vgui.Create( "DProgress", barframe)
	-- m_pnlTimeBar:SetSize(300,30)
	-- m_pnlTimeBar:Center()
	-- m_pnlTimeBar.Think = function()
	-- 	m_pnlTimeBar:SetFraction( (CurTime() - CraftingTime) / 5 )
	-- end


	net.Start("R_CraftSystem.Craft")
	net.WriteString(k)
	net.SendToServer()

end

local function OpenCategory(base, cat, recipes, rcount)
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
	base.craftinfo.resulttext = "Стоимость: " .. (base.craftinfo.craftcost or 0) .. " м."
	base.craftinfo.resultclr = Color(255,255,255)
	base.craftinfo.Paint = function(slf, w, h)
		if base.craftinfo.crafttbl == nil then return end

		local itemtbl = base.craftinfo.crafttbl
		local craftid = base.craftinfo.craftname

		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 250))

		draw.ShadowSimpleText( itemtbl.name and itemtbl.name or (weapons.GetStored(craftid) and weapons.GetStored(craftid).PrintName) or (R_CraftSystem.Disassembly[itemtbl.Class] and R_CraftSystem.Disassembly[itemtbl.Class].name), "rp.ui.32", w*0.45, 10, Color(255,255, 255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
		draw.ShadowSimpleText( "Описание:", "rp.ui.28", 10, 40, Color(255,255, 255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
		draw.ShadowSimpleText( "Необходимо:", "rp.ui.28", w*0.65, 40, Color(255,255, 255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
		if (base.craftinfo.resulttext != "") then
			draw.ShadowSimpleText( base.craftinfo.resulttext, "rp.ui.22", w*0.45, h-80, base.craftinfo.resultclr, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
		end
		-- local markup_obj = nil
		-- markup_obj = markup.Parse("<font=rp.ui.20>"..MakeInlineDesc(base.craftinfo.crafttbl.recipe).."</font>")
		-- markup_obj:Draw(w*0.55,80,TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

		if not base.craftinfo.weppreview then
			base.craftinfo.weppreview = vgui.Create( "DModelPanel", base.craftinfo )
			base.craftinfo.weppreview:SetPos(0, 100)
			base.craftinfo.weppreview:SetSize(w*0.4,h-100)
			base.craftinfo.weppreview:SetModel( base.craftinfo.crafttbl.model or weapons.GetStored(base.craftinfo.craftname).WorldModel)
			base.craftinfo.weppreview:SetCamPos(Vector(15, 15, 0))
			base.craftinfo.weppreview:SetLookAt(Vector(0, 0, 0))
			base.craftinfo.weppreview:SetAmbientLight(Color(255, 255, 255, 255))
		else
			base.craftinfo.weppreview:SetModel( base.craftinfo.crafttbl.model or weapons.GetStored(base.craftinfo.craftname).WorldModel)
		end
	end
	base.craftinfo.OnClose = function()
		base.craftinfo.crafttbl = nil
		base.craftinfo.craftname = nil
	end


	base.craftinfo.craftText = vgui.Create( "RichText", base.craftinfo )
	base.craftinfo.craftText:SetPos(base.craftinfo:GetWide()*0.5,80)  
	base.craftinfo.craftText:SetSize(base.craftinfo:GetWide()*0.5 - 60,base.craftinfo:GetTall()-60)
	base.craftinfo.craftText:InsertColorChange(255, 255, 255, 255)
	
	function base.craftinfo.craftText:PerformLayout()
		self:SetFontInternal( "rp.ui.22" )
	end
	

	base.craftinfo.desc = vgui.Create('DLabel', base.craftinfo)
	base.craftinfo.desc:SetSize(base.craftinfo:GetWide()*0.4,base.craftinfo:GetTall()-60)
	base.craftinfo.desc:SetPos(10,70)   
	base.craftinfo.desc:SetWrap(true)
	base.craftinfo.desc:SetAutoStretchVertical( true )
	base.craftinfo.desc:SetFont('ui.23')
	base.craftinfo.desc:SetText((base.craftinfo.crafttbl and base.craftinfo.crafttbl.desc) or "")
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
			draw.ShadowSimpleText("Создать", "rp.ui.22", w/2, h/2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		else
			draw.RoundedBox( 10, 0, 0, w, h, Color(138, 40, 1) )
			draw.RoundedBox( 10, 2, 2, w-4, h-4, Color(39,39,39) )
			draw.ShadowSimpleText("Создать", "rp.ui.22", w/2, h/2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
	base.craftinfo.btn.DoClick = function()
		if (CurTime() > base.craftinfo.btn.craftcd) then
			if CanCraftRecipe(base.craftinfo.crafttbl.recipe) then
				base.craftinfo.btn.craftcd = CurTime() + 1.8
				DrawProgressBar(base, CurTime(), base.craftinfo.craftname, base)
			else
				base.craftinfo.btn.craftcd = CurTime() + 1
				base.craftinfo.resulttext = "Не хватает ресурсов!"
				base.craftinfo.resultclr = Color(200,0,0)
				timer.Simple( 1, function() 
					base.craftinfo.resulttext = "Стоимость: " .. base.craftinfo.craftcost .. " м."
					base.craftinfo.resultclr = Color(255,255,255) 
				end)
				surface.PlaySound( "buttons/button15.wav" )
			end
		end
	end




	if not recipes then
		recipes = R_CraftSystem.Recipes

		if cat ~= "Все" then
			recipes = {}
			for k,v in pairs(R_CraftSystem.Recipes) do
				if v.category == cat then
					recipes[k] = v
				end
			end
		end

		if cat == "Разбор" then
			recipes = {}
			rcount = {}
			local inv = LocalPlayer().inv
			local itemsFor
			for k, v in pairs(inv) do
				for class, tbl in pairs(v) do
				for key, itemtbl in pairs(tbl) do
					local itemTable1 = Inventory.GetItem(k, class)
					if !itemTable1 then continue end
					if R_CraftSystem.Disassembly[itemTable1.class] then
						recipes[class] = itemTable1
						rcount[class] = inv[k][class][1].count or 1
					end
				end
				end
			end
		end
	end


	for k,v in SortedPairs(recipes) do
		for i = 1, ((rcount and rcount[k]) or 1) do
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
			base.icon:SetModel( (v.model and v.model) or (weapons.GetStored(k) and weapons.GetStored(k).WorldModel) or  (R_CraftSystem.Disassembly[v.Class] and R_CraftSystem.Disassembly[v.Class].model) or "models/props_borealis/bluebarrel001.mdl")
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
						base.craftinfo.craftcost = GetCraftPrice(base.craftinfo.craftname)
						base.craftinfo.resulttext = "Стоимость: " .. (base.craftinfo.craftcost or 0) .. " м."
						base.craftinfo:SetVisible(true)
						recipetbl = MakeInlineDescByTable(base.craftinfo.crafttbl.recipe)
						if recipetbl then
							base.craftinfo.craftText:SetText("")
							for i = 1, #recipetbl, 2 do
								base.craftinfo.craftText:InsertColorChange(recipetbl[i].r, recipetbl[i].b, recipetbl[i].g, recipetbl[i].a)
								base.craftinfo.craftText:AppendText(recipetbl[i+1])
							end
						end
						-- if CanCraftRecipe(v.recipe) then
						-- 	base.btn_craft.craftcd = CurTime() + 1.8
						-- 	DrawProgressBar(base, CurTime(), k, base)
						-- else
						-- 	--DrawCraftMessage("Текст. ткстТекст. ткстТекст. ткстТекст. ткстТекст. ткстТекст. ткстТекст. ткст", "Скрафтить", base)
						-- 	base.btn_craft.craftcd = CurTime() + 0.3
						-- 	notification.AddLegacy( "У вас не хватает ресурсов.", 1, 4 )
						-- 	surface.PlaySound( "buttons/button15.wav" )
						-- end
					else
						if base.btn_craft.craftcd > CurTime() then return end

						base.btn_craft.craftcd = CurTime() + 0.1
						base['crpanel'..k]:Remove()
						if rcount[k] and rcount[k] > 1 then
							rcount[k] = rcount[k] - 1
						else
							recipes[k] = nil
						end
						net.Start("R_CraftSystem.Disassembly")
						net.WriteString(k)
						net.SendToServer()
						OpenCraftMenu("Разбор", recipes, rcount)
					end
				end
				-- if CanCraftRecipe(v.recipe) then
				-- 	DrawProgressBar(base, CurTime(), k)
				-- else
				-- 	notification.AddLegacy( "У вас не хватает ресурсов.", 1, 4 )
				-- 	surface.PlaySound( "buttons/button15.wav" )
				-- end
			end
		end
	end
end



function DrawProgressBar2(dframe, CraftingTime, k, parent)
	-- net.Start("EmitCratfSound")
	-- net.WriteEntity(LocalPlayer())
	-- net.SendToServer()


	local barframe = vgui.Create("BFrame", parent)
	barframe:MakePopup()
	barframe:ShowCloseButton(false)
	barframe:SetSize(ScrW()/5, ScrH()/7)
	barframe:SetDraggable(false)
	barframe:SetTitle("Разборка "..R_CraftSystem.Disassembly[k].name)
	barframe:SetPos(ScrW()/2.5, ScrH()/2.3 )

	m_pnlTimeBar = vgui.Create( "DProgress", barframe)
	m_pnlTimeBar:SetSize(300,30)
	m_pnlTimeBar:Center()
	m_pnlTimeBar.Think = function()
		m_pnlTimeBar:SetFraction( (CurTime() - CraftingTime) / 1 )
	end

	timer.Simple(1, function()
		barframe:Remove()
		net.Start("R_CraftSystem.Disassembly")
		net.WriteString(k)
		net.SendToServer()
		timer.Simple(0.5, function()
			OpenCraftMenu("Разбор")
		end)
	end)
end


net.Receive("R_CraftSystem.OpenMenu", function()
	OpenCraftMenu("Все")
end)


function OpenCraftMenu(category, recipes, rcount) 
	if IsValid(dframe) then dframe:Remove() end
	
	dframe = vgui.Create("BFrame")
	dframe:SetSize(ScrW()*0.95, ScrH()*0.95)
	dframe:Center()
	dframe:SetTitle("")
	dframe:MakePopup()

	dframe.razbor = dframe:Add("DButton")
	dframe.razbor:SetSize(150, 40)
	dframe.razbor:SetPos(0, 35)
	dframe.razbor:SetText("")
	dframe.razbor.Paint = function(slf, w, h)
		if slf:IsHovered() then
			-- draw.CraftingBackground(0,0,w,h,200)
			draw.CraftingBackgroundColored(0,0,w,h, Color(125,125,125))
			draw.ShadowSimpleText("Разобрать вещи", "rp.ui.22", w/2, h/2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		else
			draw.CraftingBackground(0,0,w,h,100)
			draw.ShadowSimpleText("Разобрать вещи", "rp.ui.22", w/2, h/2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
	dframe.razbor.DoClick = function()
		OpenCategory(dframe, "Разбор")
	end

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

	local cats = R_CraftSystem.Categories

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
	OpenCategory(dframe, category, recipes, rcount)
end

function CloseCraftMenu()
	if IsValid(dframe) then dframe:Remove() end
end