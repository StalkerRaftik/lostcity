rp.Inventory = rp.Inventory or {}

net.Receive("UpdateClientCosmetics", function()
    if not RP_INVENTORY or not RP_INVENTORY.UpdateInventoryMenu then return end
    RP_INVENTORY:UpdateInventoryMenu()
    RP_INVENTORY:SetCharacterModel()
end)

local moneymat = Material("samprp/moreicons/coin_stacks.png", "smooth")
local INVENTORY_UI = {}
local TimeLerp 
local over_time, start_time 
local BACKPACK_ENUM = 10
local SLOTS_ON_ROW = 6

local activeSection

local textHasFocus = false

local ANIM_TIME = 0.5
local INVENTORY_FADE_TIME = ANIM_TIME

local glowMat = Material( "particle/Particle_Glow_04_Additive" )

DEFINE_BASECLASS( "monoFrame" )

function INVENTORY_UI:Init()
    self:MakePopup()
    self:InvalidateParent( true )

    self:ShowCloseButton( false )
    self:SetDraggable( false )
    self:SetTitle( "" )
 
    self.panel = self:Add( "Panel" )
    self.panel:Dock( FILL )
    self.panel:DockMargin( 70, 10, 50, 30 )
    self.panel:InvalidateParent( true )
    self.panel.Paint = function(s,w,h)
        draw.RoundedBox(0,0,0,w,h, Color(50,50,50,50))
        surface.SetDrawColor(Color(100,100,100, 100))
        surface.DrawOutlinedRect(0, 0, w, h)
    end
    self.DisableBlur = true

	hook.Run( "rp.Inventory.OnInventoryOpened", self )
end

function INVENTORY_UI:Fade(bool, callback)
    -- Fade effect
    self:SetAlpha(bool and 0 or 255)
    self:AlphaTo(bool and 255 or 0, INVENTORY_FADE_TIME, 0, callback)

    self.TargetAlpha = bool and 100 or 50
end

function INVENTORY_UI:UpdateEquipment()
    if IsValid( self.headslot ) then self.headslot:Remove() end
    if IsValid(self.eyeslot) then self.eyeslot:Remove() end
    if IsValid(self.mouthslot) then self.mouthslot:Remove() end
    if IsValid(self.maskslot) then self.maskslot:Remove() end
    if IsValid(self.rhandslot) then self.rhandslot:Remove() end
    if IsValid(self.lhandslot) then self.lhandslot:Remove() end
    if IsValid(self.miscslot) then self.miscslot:Remove() end
    if IsValid(self.miscslot2) then self.miscslot2:Remove() end
    if IsValid(self.misc3) then self.misc3:Remove() end
    if IsValid(self.misc4) then self.misc4:Remove() end    
    if IsValid(self.petslot) then self.petslot:Remove() end

    local cosmeticitemhead
    local glowColor
    local cosmeticitemhead
    local cosmeticitemheadid
    local cosmeticitemeyes
    local cosmeticitemeyesid
    local cosmeticitemmouth
    local cosmeticitemmouthid
    local cosmeticitemmask
    local cosmeticitemmaskid
    local cosmeticitemrhand
    local cosmeticitemrhandid
    local cosmeticitemlhand
    local cosmeticitemlhandid
    local cosmeticitemmisc
    local cosmeticitemmiscid
    local cosmeticitemmisc2
    local cosmeticitemmisc2id
    local cosmeticitempet
    local cosmeticitempetid
    local cosmeticitemmisc3
    local cosmeticitemmisc3id   
    local cosmeticitemmisc4
    local cosmeticitemmisc4id       

    local iWeaponSlotSize = 80 
    if LocalPlayer().Cosmetics then 
        for id, cname in pairs(LocalPlayer().Cosmetics) do
            for k, v in pairs(Cosmetics.Items) do
                if istable(cname) then cname = cname.class end
                if cname == k then 
                    if v.slot == 1 then
                        cosmeticitemhead = v
                        cosmeticitemheadid = k
                    elseif v.slot == 2 then
                        cosmeticitemeyes = v
                        cosmeticitemeyesid = k
                    elseif v.slot == 3 then
                        cosmeticitemmouth = v
                        cosmeticitemmouthid = k
                    elseif v.slot == 4 then
                        cosmeticitemmask = v
                        cosmeticitemmaskid = k
                    elseif v.slot == 5 then
                        cosmeticitemrhand = v
                        cosmeticitemrhandid = k
                    elseif v.slot == 6 then
                        cosmeticitemlhand = v
                        cosmeticitemlhandid = k
                    elseif v.slot == 7 then
                        cosmeticitemmisc = v
                        cosmeticitemmiscid = k
                    elseif v.slot == 8 then
                        cosmeticitemmisc2 = v
                        cosmeticitemmisc2id = k
                    elseif v.slot == 9 then
                        cosmeticitempet = v
                        cosmeticitempetid = k
                    elseif v.slot == 10 then
                        cosmeticitemmisc3 = v
                        cosmeticitemmisc3id = k
                    elseif v.slot == 11 then
                        cosmeticitemmisc4 = v
                        cosmeticitemmisc4id = k                    
                    end                   
                end
            end
        end
    end
    
    --Слот головы
    self.headslot = self.panel:Add( "monoPanel" )
    self.headslot:SetSize( iWeaponSlotSize, iWeaponSlotSize )
    self.headslot:SetPos( self.panel:GetWide() - iWeaponSlotSize - 20, 90)
    self.headslot.Paint = function(s,w,h)
        if cosmeticitemhead then
            glowColor = Color( 200, 200, 200, 100 )
        else
            glowColor = Color(50, 50, 50, 170)
        end
        
        draw.RoundedBox(0,0,0,w,h, Color(glowColor.r,glowColor.g,glowColor.b,40))
        draw.OutlinedBox(0, 0, w, h, Color(0,0,0,0), glowColor)
        surface.SetDrawColor( glowColor )
        surface.SetMaterial( glowMat )
        surface.DrawTexturedRect( 0 - ( w*0.3 ), 0 - ( h*0.3 ), w * 3, h * 3 )
        draw.ShadowSimpleText('Голова', 'rp.ui.18', w/2, h*0.1, Color(200,200,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        --draw.OutlinedBox( 0, 0, w, h, 2, s:IsHovered() and rp.col.SUP or rp.col.Background, rp.col.Outline)
    end

    if cosmeticitemhead then
        self.headslot.monoIcon = self.headslot:Add( "monoIcon" )
        self.headslot.monoIcon:SetModel( cosmeticitemhead.model )
        self.headslot.monoIcon.Entity:SetSkin( cosmeticitemhead.skin or 0 )
        self.headslot.monoIcon:Dock( FILL )
        self.headslot.monoIcon.PaintOver = function() end
        self.headslot.monoIcon:SetPos( 0, 0 )
        self.headslot.monoIcon.DoClick = function(this) 
            Menu = DermaMenu( self )
            Menu:SetSkin('core')
            local DropOption = Menu:AddOption( "Снять "..cosmeticitemhead.name )
            DropOption.DoClick = function()
                LocalPlayer():ConCommand("Inventory.Unequip".." "..'hats'.." "..cosmeticitemheadid)
                this:Remove()
            end
            Menu:Open()
        end
    end

    self.eyeslot = self.panel:Add( "monoPanel" )
    self.eyeslot:Dock( NODOCK )
    self.eyeslot:SetSize( iWeaponSlotSize, iWeaponSlotSize )
    self.eyeslot:SetPos( self.panel:GetWide() - iWeaponSlotSize - 20, 90 + 80*1 + 10 )
    self.eyeslot.Paint = function(s,w,h)
        if cosmeticitemeyes then
            glowColor = Color( 200, 200, 200, 100 )
        else
            glowColor = Color(50, 50, 50, 170)
        end
        
        draw.RoundedBox(0,0,0,w,h, Color(glowColor.r,glowColor.g,glowColor.b,40))
        draw.OutlinedBox(0, 0, w, h, Color(0,0,0,0), glowColor)
        surface.SetDrawColor( glowColor )
        surface.SetMaterial( glowMat )
        surface.DrawTexturedRect( 0 - ( w*0.3 ), 0 - ( h*0.3 ), w * 3, h * 3 )
        --draw.OutlinedBox( 0, 0, w, h, 2, s:IsHovered() and rp.col.SUP or rp.col.Background, rp.col.Outline)
        draw.ShadowSimpleText('Глаза', 'rp.ui.18', w/2, h*0.1, Color(200,200,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    if cosmeticitemeyes then
        self.eyeslot.monoIcon = self.eyeslot:Add( "monoIcon" )
        self.eyeslot.monoIcon:SetModel( cosmeticitemeyes.model )
        self.eyeslot.monoIcon.Entity:SetSkin( cosmeticitemeyes.skin or 0 )
        self.eyeslot.monoIcon:Dock( FILL )
        self.eyeslot.monoIcon:DockMargin( 5, 5, 5, 5 )
        self.eyeslot.monoIcon.PaintOver = function() end
        self.eyeslot.monoIcon.DoClick = function(this)
            Menu = DermaMenu( self )
            Menu:SetSkin('core')
            local DropOption = Menu:AddOption( "Снять "..cosmeticitemeyes.name )
            DropOption.DoClick = function()
                LocalPlayer():ConCommand("Inventory.Unequip".." "..'hats'.." "..cosmeticitemeyesid)
                self:UpdateInventoryMenu()
                this:Remove()
            end
            Menu:Open()
        end
    end

    self.mouthslot = self.panel:Add( "monoPanel" )
    self.mouthslot:Dock( NODOCK )
    self.mouthslot:SetSize( iWeaponSlotSize, iWeaponSlotSize )
    self.mouthslot:SetPos( self.panel:GetWide() - iWeaponSlotSize - 20, 90 + (80+10)*2 )
    self.mouthslot.Paint = function(s,w,h)
        if cosmeticitemmouth then
            glowColor = Color( 200, 200, 200, 100 )
        else
            glowColor = Color(50, 50, 50, 170)
        end
        
        draw.RoundedBox(0,0,0,w,h, Color(glowColor.r,glowColor.g,glowColor.b,40))
        draw.OutlinedBox(0, 0, w, h, Color(0,0,0,0), glowColor)
        surface.SetDrawColor( glowColor )
        surface.SetMaterial( glowMat )
        surface.DrawTexturedRect( 0 - ( w*0.3 ), 0 - ( h*0.3 ), w * 3, h * 3 )
        draw.ShadowSimpleText('Рот', 'rp.ui.18', w/2, h*0.1, Color(200,200,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    if cosmeticitemmouth then
        self.mouthslot.monoIcon = self.mouthslot:Add( "monoIcon" )
        self.mouthslot.monoIcon:SetModel( cosmeticitemmouth.model )
        self.mouthslot.monoIcon.Entity:SetSkin( cosmeticitemmouth.skin or 0 )
        self.mouthslot.monoIcon:Dock( FILL )
        self.mouthslot.monoIcon:DockMargin( 5, 5, 5, 5 )
        self.mouthslot.monoIcon.PaintOver = function() end
        self.mouthslot.monoIcon.DoClick = function(this) 
            Menu = DermaMenu( self )
            Menu:SetSkin('core')
            local DropOption = Menu:AddOption( "Снять "..cosmeticitemmouth.name )
            DropOption.DoClick = function()
                LocalPlayer():ConCommand("Inventory.Unequip".." "..'hats'.." "..cosmeticitemmouthid)  
                self:UpdateInventoryMenu()
                this:Remove()
            end
            Menu:Open()
        end
    end

    self.maskslot = self.panel:Add( "monoPanel" )
    self.maskslot:Dock( NODOCK )
    self.maskslot:SetSize( iWeaponSlotSize, iWeaponSlotSize )
    self.maskslot:SetPos( self.panel:GetWide() - iWeaponSlotSize - 20, 90 + (80+10)*3 )
    self.maskslot.Paint = function(s,w,h)
        if cosmeticitemmask then
            glowColor = Color( 200, 200, 200, 100 )
        else
            glowColor = Color(50, 50, 50, 170)
        end
        
        draw.RoundedBox(0,0,0,w,h, Color(glowColor.r,glowColor.g,glowColor.b,40))
        draw.OutlinedBox(0, 0, w, h, Color(0,0,0,0), glowColor)
        surface.SetDrawColor( glowColor )
        surface.SetMaterial( glowMat )
        surface.DrawTexturedRect( 0 - ( w*0.3 ), 0 - ( h*0.3 ), w * 3, h * 3 )
        draw.ShadowSimpleText('Маски', 'rp.ui.18', w/2, h*0.1, Color(200,200,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    if cosmeticitemmask then
        self.maskslot.monoIcon = self.maskslot:Add( "monoIcon" )
        self.maskslot.monoIcon:SetModel( cosmeticitemmask.model )
        self.maskslot.monoIcon.Entity:SetSkin( cosmeticitemmask.skin or 0 )
        self.maskslot.monoIcon:Dock( FILL )
        self.maskslot.monoIcon:DockMargin( 5, 5, 5, 5 )
        self.maskslot.monoIcon.PaintOver = function() end
        self.maskslot.monoIcon.DoClick = function(this) 
            Menu = DermaMenu( self )
            Menu:SetSkin('core')
            local DropOption = Menu:AddOption( "Снять "..cosmeticitemmask.name )
            DropOption.DoClick = function()
                LocalPlayer():ConCommand("Inventory.Unequip".." "..'hats'.." "..cosmeticitemmaskid)
                self.maskslot.monoIcon:Remove()
                self:UpdateInventoryMenu()
                this:Remove()
            end
            Menu:Open()
        end
    end


    self.rhandslot = self.panel:Add( "monoPanel" )
    self.rhandslot:Dock( NODOCK )
    self.rhandslot:SetSize( iWeaponSlotSize, iWeaponSlotSize )
    self.rhandslot:SetPos( self:GetWide() * 0.005, self:GetTall() * 0.55 - ( iWeaponSlotSize / 2 ) )
    self.rhandslot.Paint = function(s,w,h)
        if cosmeticitemrhand then
            glowColor = Color( 200, 200, 200, 100 )
        else
            glowColor = Color(50, 50, 50, 170)
        end
        
        draw.RoundedBox(0,0,0,w,h, Color(glowColor.r,glowColor.g,glowColor.b,40))
        draw.OutlinedBox(0, 0, w, h, Color(0,0,0,0), glowColor)
        surface.SetDrawColor( glowColor )
        surface.SetMaterial( glowMat )
        surface.DrawTexturedRect( 0 - ( w*0.3 ), 0 - ( h*0.3 ), w * 3, h * 3 )
        draw.ShadowSimpleText('Осн. оружие', 'rp.ui.18', w/2, h*0.1, Color(200,200,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    if cosmeticitemrhand then
        self.rhandslot.monoIcon = self.rhandslot:Add( "monoIcon" )
        self.rhandslot.monoIcon:SetModel( cosmeticitemrhand.model )
        self.rhandslot.monoIcon.Entity:SetSkin( cosmeticitemrhand.skin or 0 )
        self.rhandslot.monoIcon:Dock( FILL )
        self.rhandslot.monoIcon:DockMargin( 5, 5, 5, 5 )
        self.rhandslot.monoIcon.PaintOver = function() end
        self.rhandslot.monoIcon.DoClick = function(this) 
            Menu = DermaMenu( self )
            Menu:SetSkin('core')
            local DropOption = Menu:AddOption( "Снять "..cosmeticitemrhand.name )
            DropOption.DoClick = function()
                LocalPlayer():ConCommand("Inventory.Unequipwep".." "..'hats'.." "..cosmeticitemrhandid)
                self:UpdateInventoryMenu()
                this:Remove()
            end
            Menu:Open()
        end
    end

    self.misc3 = self.panel:Add( "monoPanel" )
    self.misc3:Dock( NODOCK )
    self.misc3:SetSize( iWeaponSlotSize, iWeaponSlotSize )
    self.misc3:SetPos( self:GetWide() * 0.005, self:GetTall() * 0.45 - ( iWeaponSlotSize / 2 ) )
    self.misc3.Paint = function(s,w,h)
        if cosmeticitemmisc3 then
            glowColor = Color( 200, 200, 200, 100 )
        else
            glowColor = Color(50, 50, 50, 170)
        end
        
        draw.RoundedBox(0,0,0,w,h, Color(glowColor.r,glowColor.g,glowColor.b,40))
        draw.OutlinedBox(0, 0, w, h, Color(0,0,0,0), glowColor)
        surface.SetDrawColor( glowColor )
        surface.SetMaterial( glowMat )
        surface.DrawTexturedRect( 0 - ( w*0.3 ), 0 - ( h*0.3 ), w * 3, h * 3 )
        draw.ShadowSimpleText('Инструмент', 'rp.ui.18', w/2, h*0.1, Color(200,200,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    if cosmeticitemmisc3 then
        self.misc3.monoIcon = self.misc3:Add( "monoIcon" )
        self.misc3.monoIcon:SetModel( cosmeticitemmisc3.model )
        self.misc3.monoIcon.Entity:SetSkin( cosmeticitemmisc3.skin or 0 )
        self.misc3.monoIcon:Dock( FILL )
        self.misc3.monoIcon:DockMargin( 5, 5, 5, 5 )
        self.misc3.monoIcon.PaintOver = function() end
        self.misc3.monoIcon.DoClick = function(this) 
            Menu = DermaMenu( self )
            Menu:SetSkin('core')
            local DropOption = Menu:AddOption( "Снять "..cosmeticitemmisc3.name )
            DropOption.DoClick = function()
                LocalPlayer():ConCommand("Inventory.Unequipwep".." "..'hats'.." "..cosmeticitemmisc3id)
                self:UpdateInventoryMenu()
                this:Remove()
            end
            Menu:Open()
        end
    end

    self.misc4 = self.panel:Add( "monoPanel" )
    self.misc4:Dock( NODOCK )
    self.misc4:SetSize( iWeaponSlotSize, iWeaponSlotSize )
    self.misc4:SetPos( self:GetWide() * 0.005, self:GetTall() * 0.35 - ( iWeaponSlotSize / 2 ) )
    self.misc4.Paint = function(s,w,h)
        if cosmeticitemmisc4 then
            glowColor = Color( 200, 200, 200, 100 )
        else
            glowColor = Color(50, 50, 50, 170)
        end
        
        draw.RoundedBox(0,0,0,w,h, Color(glowColor.r,glowColor.g,glowColor.b,40))
        draw.OutlinedBox(0, 0, w, h, Color(0,0,0,0), glowColor)
        surface.SetDrawColor( glowColor )
        surface.SetMaterial( glowMat )
        surface.DrawTexturedRect( 0 - ( w*0.3 ), 0 - ( h*0.3 ), w * 3, h * 3 )
        draw.ShadowSimpleText('Инструмент', 'rp.ui.18', w/2, h*0.1, Color(200,200,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    if cosmeticitemmisc4 then
        self.misc4.monoIcon = self.misc4:Add( "monoIcon" )
        self.misc4.monoIcon:SetModel( cosmeticitemmisc4.model )
        self.misc4.monoIcon.Entity:SetSkin( cosmeticitemmisc4.skin or 0 )
        self.misc4.monoIcon:Dock( FILL )
        self.misc4.monoIcon:DockMargin( 5, 5, 5, 5 )
        self.misc4.monoIcon.PaintOver = function() end
        self.misc4.monoIcon.DoClick = function(this) 
            Menu = DermaMenu( self )
            Menu:SetSkin('core')
            local DropOption = Menu:AddOption( "Снять "..cosmeticitemmisc4.name )
            DropOption.DoClick = function()
                LocalPlayer():ConCommand("Inventory.Unequipwep".." "..'hats'.." "..cosmeticitemmisc4id)
                self:UpdateInventoryMenu()
                this:Remove()
            end
            Menu:Open()
        end
    end
    
    self.lhandslot = self.panel:Add( "monoPanel" )
    self.lhandslot:Dock( NODOCK )
    self.lhandslot:SetSize( iWeaponSlotSize, iWeaponSlotSize )
    self.lhandslot:SetPos( self.panel:GetWide() - iWeaponSlotSize - 20, 90 + (80+10)*4 )
    self.lhandslot.Paint = function(s,w,h)
        if cosmeticitemlhand then
            glowColor = Color( 200, 200, 200, 100 )
        else
            glowColor = Color(50, 50, 50, 170)
        end
        
        draw.RoundedBox(0,0,0,w,h, Color(glowColor.r,glowColor.g,glowColor.b,40))
        draw.OutlinedBox(0, 0, w, h, Color(0,0,0,0), glowColor)
        surface.SetDrawColor( glowColor )
        surface.SetMaterial( glowMat )
        surface.DrawTexturedRect( 0 - ( w*0.3 ), 0 - ( h*0.3 ), w * 3, h * 3 )
        draw.ShadowSimpleText('Доп. оружие', 'rp.ui.18', w/2, h*0.1, Color(200,200,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    if cosmeticitemlhand then
        self.lhandslot.monoIcon = self.lhandslot:Add( "monoIcon" )
        self.lhandslot.monoIcon:SetModel( cosmeticitemlhand.model )
        self.lhandslot.monoIcon.Entity:SetSkin( cosmeticitemlhand.skin or 0 )
        self.lhandslot.monoIcon:Dock( FILL )
        self.lhandslot.monoIcon:DockMargin( 5, 5, 5, 5 )
        self.lhandslot.monoIcon.PaintOver = function() end
        self.lhandslot.monoIcon.DoClick = function(this) 
            Menu = DermaMenu( self )
            Menu:SetSkin('core')
            local DropOption = Menu:AddOption( "Снять "..cosmeticitemlhand.name )
            DropOption.DoClick = function()
                LocalPlayer():ConCommand("Inventory.Unequipwep".." "..'hats'.." "..cosmeticitemlhandid)
                self:UpdateInventoryMenu()
                this:Remove()
            end
            Menu:Open()
        end
    end

    self.miscslot = self.panel:Add( "monoPanel" )
    self.miscslot:Dock( NODOCK )
    self.miscslot:SetSize( iWeaponSlotSize, iWeaponSlotSize )
    self.miscslot:SetPos( self:GetWide() * 0.005, self:GetTall() * 0.65 - ( iWeaponSlotSize / 2 ) )
    self.miscslot.Paint = function(s,w,h)
        if cosmeticitemmisc then
            glowColor = Color( 200, 200, 200, 100 )
        else
            glowColor = Color(50, 50, 50, 170)
        end
        
        draw.RoundedBox(0,0,0,w,h, Color(glowColor.r,glowColor.g,glowColor.b,40))
        draw.OutlinedBox(0, 0, w, h, Color(0,0,0,0), glowColor)
        surface.SetDrawColor( glowColor )
        surface.SetMaterial( glowMat )
        surface.DrawTexturedRect( 0 - ( w*0.3 ), 0 - ( h*0.3 ), w * 3, h * 3 )
        draw.ShadowSimpleText('Тело', 'rp.ui.18', w/2, h*0.1, Color(200,200,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    if cosmeticitemmisc then
        self.miscslot.monoIcon = self.miscslot:Add( "monoIcon" )
        self.miscslot.monoIcon:SetModel(cosmeticitemmisc.model)
        self.miscslot.monoIcon.Entity:SetSkin( cosmeticitemmisc.skin or 0 )
        self.miscslot.monoIcon:Dock( FILL )
        self.miscslot.monoIcon:DockMargin( 5, 5, 5, 5 )
        self.miscslot.monoIcon.PaintOver = function() end
        self.miscslot.monoIcon.DoClick = function(this) 
            Menu = DermaMenu( self )
            Menu:SetSkin('core')
            local DropOption = Menu:AddOption( "Снять "..cosmeticitemmisc.name )
            DropOption.DoClick = function()
                LocalPlayer():ConCommand("Inventory.Unequip".." "..'hats'.." "..cosmeticitemmiscid)
                self:UpdateInventoryMenu()
                this:Remove()
            end
            Menu:Open()
        end
    end

    self.miscslot2 = self.panel:Add( "monoPanel" )
    self.miscslot2:Dock( NODOCK )
    self.miscslot2:SetSize( iWeaponSlotSize, iWeaponSlotSize )
    self.miscslot2:SetPos( self.panel:GetWide() - iWeaponSlotSize - 20, 90 + (80+10)*5 )
    self.miscslot2.Paint = function(s,w,h)
        if cosmeticitemmisc2 then
            glowColor = Color( 200, 200, 200, 100 )
        else
            glowColor = Color(50, 50, 50, 170)
        end
        
        draw.RoundedBox(0,0,0,w,h, Color(glowColor.r,glowColor.g,glowColor.b,40))
        draw.OutlinedBox(0, 0, w, h, Color(0,0,0,0), glowColor)
        surface.SetDrawColor( glowColor )
        surface.SetMaterial( glowMat )
        surface.DrawTexturedRect( 0 - ( w*0.3 ), 0 - ( h*0.3 ), w * 3, h * 3 )
        draw.ShadowSimpleText('Спина', 'rp.ui.18', w/2, h*0.1, Color(200,200,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    if cosmeticitemmisc2 then
        self.miscslot2.monoIcon = self.miscslot2:Add( "monoIcon" )
        self.miscslot2.monoIcon:SetModel(cosmeticitemmisc2.model)
        self.miscslot2.monoIcon.Entity:SetSkin( cosmeticitemmisc2.skin or 0 )
        self.miscslot2.monoIcon:Dock( FILL )
        self.miscslot2.monoIcon:DockMargin( 5, 5, 5, 5 )
        self.miscslot2.monoIcon.PaintOver = function() end
        self.miscslot2.monoIcon.DoClick = function(this) 
            Menu = DermaMenu( self )
            Menu:SetSkin('core')
            local DropOption = Menu:AddOption( "Снять "..cosmeticitemmisc2.name )
            DropOption.DoClick = function()
                LocalPlayer():ConCommand("Inventory.Unequip".." "..'hats'.." "..cosmeticitemmisc2id)
                self:UpdateInventoryMenu()
                this:Remove()
            end
            Menu:Open()
        end
    end

    self.petslot = self.panel:Add( "monoPanel" )
    self.petslot:Dock( NODOCK )
    self.petslot:SetSize( iWeaponSlotSize, iWeaponSlotSize )
    self.petslot:SetPos( self:GetWide() * 0.005, self:GetTall() * 0.75 - ( iWeaponSlotSize / 2 ) )
    self.petslot.Paint = function(s,w,h)
        if cosmeticitempet then
            glowColor = Color( 200, 200, 200, 100 )
        else
            glowColor = Color(50, 50, 50, 170)
        end
        
        draw.RoundedBox(0,0,0,w,h, Color(glowColor.r,glowColor.g,glowColor.b,40))
        draw.OutlinedBox(0, 0, w, h, Color(0,0,0,0), glowColor)
        surface.SetDrawColor( glowColor )
        surface.SetMaterial( glowMat )
        surface.DrawTexturedRect( 0 - ( w*0.3 ), 0 - ( h*0.3 ), w * 3, h * 3 )
        draw.ShadowSimpleText('Хол. оружие', 'rp.ui.18', w/2, h*0.1, Color(200,200,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    if cosmeticitempet then
        self.petslot.monoIcon = self.petslot:Add( "monoIcon" )
        self.petslot.monoIcon:SetModel(cosmeticitempet.model)
        self.petslot.monoIcon.Entity:SetSkin( cosmeticitempet.skin or 0 )
        self.petslot.monoIcon:Dock( FILL )
        self.petslot.monoIcon:DockMargin( 5, 5, 5, 5 )
        self.petslot.monoIcon.PaintOver = function() end
        self.petslot.monoIcon.DoClick = function(this)
            Menu = DermaMenu( self )
            Menu:SetSkin('core')
            local DropOption = Menu:AddOption( "Снять "..cosmeticitempet.name)
            DropOption.DoClick = function()
                LocalPlayer():ConCommand("Inventory.Unequipwep".." "..'hats'.." "..cosmeticitempetid)
                self:UpdateInventoryMenu()
                this:Remove()
            end
            Menu:Open()
        end
    end
    hook.Run( "rp.Inventory.OnCosmeticsUpdate", self )
end

-- hook.Add("rp.Inventory.OnCosmeticsUpdate", "InventoryReloadOnCosmetics", function()
--     if IsValid(RP_INVENTORY) then
--         RP_INVENTORY:UpdateInventoryMenu()
--     end
-- end)
    
hook.Add("CosmeticsChanged", "InventoryReloadOnCosmetics2", function()
    if IsValid(RP_INVENTORY) then
        RP_INVENTORY:UpdateInventoryMenu()
    end
end)

function INVENTORY_UI:AddSection( name, icon, callback, canDo, extraData )
    return self.sections:AddSection( name, icon,
        -- callback
        function( panel )
            activeSection = name

            callback( panel )
        end,
        -- canDo
        canDo,
        extraData
    )
end


function INVENTORY_UI:CreateStatusButton( x, y, mIcon, cColor, fCallback )
    local container = self.characterPanel:Add( "Panel" )
    container:SetSize( 186, 32 )
    container:SetPos( x, y )

    local icon = container:Add( "DImage" )
    icon:SetMaterial( mIcon )
    icon:Dock( LEFT )
    icon:SetWide( 32 )

    local text = container:Add( "DLabel" )
    text:Dock( FILL )
    text:SetExpensiveShadow( 1, Color( 0, 0, 0, 150 ) )
    text:SetFont( 'font_base_24' )
    text:SetText( fCallback() )

    container.Paint = function()
        text:SetText( fCallback() )
    end

    return container
end

    local LEFT_ANCHOR = 0
function INVENTORY_UI:DrawStatus()
 
    self:CreateStatusButton( self:GetWide() * 0.01, self:GetTall() / 1.15, moneymat, Color(200,200,200), function()
        return ' '..LocalPlayer():GetMoney()..' + ' ..LocalPlayer():GetSalary() .. ' монет'
    end )

end

function INVENTORY_UI:SetupSections()
    -- if IsValid( self.sections ) then
    --     self.sections:Remove()
    -- end

    self.sectionsOuter = self:Add( "monoPanel" )
    self.sectionsOuter:SetBackground( false )
    self.sectionsOuter:DockMargin( 0, 9, 70, 0 )
    self.sectionsOuter:Dock( RIGHT )
    self.sectionsOuter:SetWide( self:GetWide()/2.5  )
    self.sectionsOuter:InvalidateParent( true )
    local xPos = -self:GetWide()
    self:SetSkin('core')

    -- self.sectionsOuter.origin = select( 1, self.sectionsOuter:GetPos() )
    -- self.sectionsOuter.alpha = 0
    -- self.sectionsOuter.currentX = xPos
    -- self.sectionsOuter:CreateAnimation( ANIM_TIME, {
    --   index = 1,
    --   easing = "inSine",
    --   target = { alpha = 255 },
    --   Think = function(animation, panel)
    --     panel:SetAlpha( panel.alpha )
    --   end
    -- })

    -- self.sectionsOuter:CreateAnimation( ANIM_TIME, {
    --   index = 2,
    --   easing = "inOutSine",
    --   target = { currentX = self.sectionsOuter.origin },
    --   Think = function(animation, panel)
    --     panel:SetPos( panel.currentX, select( 2, panel:GetPos() ) )
    --   end,
    --   OnComplete = function(animation, panel)

    --   end
    -- })
    self.sections = self.sectionsOuter:Add("SPropertySheet")
    self.sections.Paint = function(s,w,h)
      draw.RoundedBox( 0, 2, 2, w, h, Color( 50, 50, 50, 50 ) )
      surface.SetDrawColor(Color(60,60,60))
      surface.DrawOutlinedRect(0, 0, w, h)
    end
    self.sections:SetSize(self.sectionsOuter:GetWide(), self.sectionsOuter:GetTall()/1.036)
    self.sectionsInventory = self.sections:AddSheet( "Инвентарь", vgui.Create("SRPQMenu_Inventory", self), "samprp/emoji/1f392.png").Panel
    self.sectionsHealth = self.sections:AddSheet( "Состояние", vgui.Create("rp.HealthMenu", self), "samprp/moreicons/heart.png").Panel
    --self.sectionsCompendium = self.sections:AddSheet( "Боевой пропуск", vgui.Create("rp.CompendiumMenu", self), "samprp/moreicons/star.png").Panel

    -- self.sectionsQuests = self.sections:AddSheet( "Задания", vgui.Create("rp.QuestsMenu", self), "samprp/moreicons/search2.png").Panel
end

function INVENTORY_UI:UpdateInventoryMenu()
    if IsValid(self) then
        if IsValid(self.sectionsInventory) then 
            self.sectionsInventory:Refresh()
        end
        if IsValid(self.characterPanel) then
            self.characterPanel:Refresh()
            self:UpdateEquipment()
            self.characterPanel:Refresh()
            self:UpdateEquipment()
        end
        if IsValid(self.characterPanelOuter) then
            self.characterPanelOuter:Refresh()
        end
        if IsValid(self.character) then
            self.character:Refresh()
            if IsValid(self.character:GetEntity()) then
                self.character:GetEntity():ClearCosmetics()
                self.character:GetEntity():BuildCosmetics( true, LocalPlayer(), false )
            end
        end
        if IsValid(self.characterPanel) then
            self.characterPanel:Refresh()
        end
        self:UpdateEquipment()
    end
end

function INVENTORY_UI:DrawPlayerCard()


    self.playerCard = self.characterPanel:Add( "monoPanel" )
    self.playerCard:SetPos( 0, 0 )
    self.playerCard:SetSize( self:GetWide()/2, 64 )
    self.playerCard:InvalidateParent( true )

    self.playerCard.Paint = function( this, w, h )

    end

    self.playerName = self.playerCard:Add( "monoHeader" )
    self.playerName:SetFont( 'font_base_24' )
    self.playerName:DockMargin( 4, 4, 0, 0 )
    self.playerName:SetText( LocalPlayer():RPName() )
    self.playerName:SetColor( GAMEMODE.ThemeColor )
    self.playerName:InvalidateParent( true )
    self.playerName:SetContentAlignment( 5 )
    self.playerName:SetTall( 28 )

end

function INVENTORY_UI:Setup()
    local anim_lvl = 0

    self.IsFading = true
    self:Fade(true, function()
        self.IsFading = false
    end)

    self.startTime = CurTime()

    self:InvalidateParent( true )

	self.characterPanelOuter = self.panel:Add( "monoPanel" )
  self.characterPanelOuter:SetBackground( false )
  self.characterPanelOuter:Dock( LEFT )
  self.characterPanelOuter:SetWide( self:GetWide()/2)
  self.characterPanelOuter:InvalidateParent( true )

  self.characterPanel = self.characterPanelOuter:Add( "monoPanel" )
  self.characterPanel:SetBackground( false )
  self.characterPanel:SetSize( self.characterPanelOuter:GetSize() )

	local xPos = - self.characterPanel:GetWide()
	self.characterPanel.origin = select( 1, self.characterPanel:GetPos() )
    self.characterPanel:SetPos( xPos, 0 )

	self.characterPanel:NoClipping( false )

	self.characterPanel:SetAlpha( 255 )

	self.characterPanel.alpha = 0
	self.characterPanel.currentX = xPos

    self.characterPanel:SetPos( self.characterPanel.currentX, 0 )

	self.characterPanel:SetPos( self.characterPanel.origin, select( 2, self.characterPanel:GetPos() ) )

    local pPlayer = LocalPlayer()
    local sCharacterName = pPlayer:Nick()
    local cWhite = Color(200,200,200)

    self.character = self.characterPanel:Add( "monoCharacterModel" )
    self.character:Dock( FILL )
    -- self.character:SetPos(self.characterPanel:GetTall())
    self.character:InvalidateParent( true )
    self.character:SetPlayer( LocalPlayer() )
    self.character:SetFollower( true )
    self.character.IsCharacterModel = true

    self.character.PaintOver = function(this, w, h)
        if LocalPlayer().start_time then
       
            TimeLerp = Lerp(FrameTime() / 1.7, (CurTime()-LocalPlayer().start_time)/(LocalPlayer().over_time-LocalPlayer().start_time)*360, 0)
            ColorLerp = Lerp(FrameTime() / 1.7, (CurTime()-LocalPlayer().start_time)/(LocalPlayer().over_time-LocalPlayer().start_time)*255, 0)
            local ColorPerc = Color(255-(TimeLerp),TimeLerp*3,0)
            local color = ColorAlpha(Color(200,200,200), ColorLerp)
            draw.OctopusArc({x=w/2, y=h/3},360,TimeLerp,30,360,5, color)
            if LocalPlayer().progress_text then
                draw.ShadowSimpleText(LocalPlayer().progress_text, "font_base_18", w/2, h/2.6, color, 1, 1)
            end
        end


        anim_lvl = Lerp(0.05, anim_lvl, LocalPlayer():GetExperience() or 0)

        draw.OutlinedBox(w/1.8, h/1.05, w/3, 22, Color(0,0,0,0), Color(50, 50, 50, 200))

        surface.SetDrawColor(100, 100, 100, 150)

        surface.DrawRect(w/1.8+1.5, h/1.05+1, math.Clamp(100/LocalPlayer():GetNeedExperience() * anim_lvl/100,0,1) * ScrW()/6, 20)

        draw.ShadowSimpleText(LocalPlayer():GetLevel()..' ур.', 'font_base_24', w/1.83, h/1.055, Color(200,200,200),TEXT_ALIGN_RIGHT,TEXT_ALIGN_RIGHT)
        draw.ShadowSimpleText(math.Round(LocalPlayer():GetExperience())..'xp / '..math.Round(LocalPlayer():GetNeedExperience())..'xp', 'font_base_24', w/1.22, h/1.053, Color(200,200,200),TEXT_ALIGN_RIGHT,TEXT_ALIGN_RIGHT)
        draw.ShadowSimpleText((LocalPlayer():GetLevel()+1)..' ур.', 'font_base_24', w/1.055, h/1.055, Color(200,200,200),TEXT_ALIGN_RIGHT,TEXT_ALIGN_RIGHT)
    end

    local mouse = {} -- mouse x, y & clicks

      -- 2d values
      local x = 180
      local y = 50
      local z = 40

      -- camera values
      local pos_cam = Vector(0,0,0)
      local pos_look = Vector(0,0,0)

      -- fov & distance
      local f = 0
      local base_fov = 0
      local camera_distance = 200

      -- set camera position
      function self.character:Think()
        pos_cam = Vector(math.sin(x / 120) * camera_distance, math.cos(x / 120) * camera_distance, y)
        pos_look = Vector(0,0,z)

        -- put entity on floor

        local seqno
        repeat
            seqno = self.Entity:LookupSequence("pose_standing_02")
        until seqno
        self:GetEntity():SetSequence(seqno)

        local ent = self:GetEntity()
        local mins, maxs = ent:GetModelRenderBounds()
        local mz = math.abs(mins.z)
        ent:SetPos(Vector(10,0, mz ))

      end

      -- draw model previews
      function self.character:LayoutEntity( ent )
        self:SetCamPos( Lerp( FrameTime() * 10, self:GetCamPos() , pos_cam ) )
        self:SetLookAt( Lerp( FrameTime() * 10, self:GetLookAt(), pos_look ) )
      end
      -- camera controls

    function self.character:OnMouseWheeled(delta)
      x = x + -delta*20
    end

    self:SetupSections()

    self:DrawPlayerCard()

    self:DrawStatus()
    self:UpdateEquipment()

end

function INVENTORY_UI:SetCharacterModel()
    self.character:SetPlayer( LocalPlayer() )
end

function INVENTORY_UI:Close()
    if self.IsFading then return end

    self.IsFading = true
    self:AlphaTo(0, INVENTORY_FADE_TIME, 0, function()
        self:Remove()
        LocalPlayer():EmitSound("inventory/backpack_close.wav")
    end)
end

local amount, passes = 2, 2

local actionPosX, actionPosY = 168, ScrH() * 0.85

local scrW, scrH = ScrW(), ScrH()
local actionW, actionH = 256, 256
local actionX, actionY = scrW / 2, scrH / 2


function INVENTORY_UI:Paint( w, h )

    draw.RoundedBox(0,0,0,w,h,Color(0, 0, 0, 180))
    draw.StencilBlur(self, w, h)
    draw.StencilBlur(self, w, h)
    draw.StencilBlur(self, w, h)
    -- rp.Interface.DrawBlur( self )
 

    if not LocalPlayer():Alive() then
        self:Close()
    end

    if input.IsKeyDown( KEY_ESCAPE ) then
        self:Close()
    end

  	if input.IsKeyDown( KEY_F4 ) then
        self:Close()
    end

    if input.IsKeyDown( KEY_TAB ) then
        self:Close()
    end

end

function INVENTORY_UI:OnRemove()
	hook.Run( "rp.Inventory.OnInventoryClosed", self )
end

function INVENTORY_UI:OnClose()
    self:Remove()

    textHasFocus = false
end

hook.Add( "OnTextEntryGetFocus", "rp.Inventory", function()
    textHasFocus = true
end )

hook.Add( "OnTextEntryLoseFocus", "rp.Inventory", function()
    textHasFocus = false
end )

vgui.Register("Inventory", INVENTORY_UI, "monoFrame")

if IsValid( Inventory ) then
	Inventory:Remove( )
end

Inventory = Inventory or nil

local function makeInventory(client)
    local frame = vgui.Create("Inventory")
    --frame.client = client or LocalPlayer()

    frame:Setup()
    frame:SetSize(ScrW(), ScrH())
    frame:Center()

    return frame
end

function rp.Inventory:ShowMenu()
	if not IsValid(LocalPlayer()) then return end
	if not LocalPlayer():Alive() then return end
	if LocalPlayer():GetNVar('PlayerDataLoaded') ~= true then return end
    if IsValid(RP_INVENTORY) then
        RP_INVENTORY:Close()
        return
    end

    RP_INVENTORY = makeInventory()
    LocalPlayer():EmitSound("inventory/backpack_open.wav")
end

function rp.Inventory:CloseMenu()
    if IsValid(RP_INVENTORY) then
        RP_INVENTORY:Close()
        return
    end
end


net.Receive("OpenInventory", function(size)
    rp.Inventory:ShowMenu()
end)

GM.ShowSpare2 = function() rp.Inventory:ShowMenu() end
-- GM.ScoreboardShow = function() rp.Inventory:ShowMenu() end
-- GM.ScoreboardHide = function() rp.Inventory:CloseMenu() end
