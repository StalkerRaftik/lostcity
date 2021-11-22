-- net.Receive("rp.Quests.DoAction", function(len, ply)
--     local action = rp.Quests.List[LocalPlayer():GetActiveQuest()].states[LocalPlayer():GetQuestState()].action
--     action(LocalPlayer())
-- end)

-- local currenttask = Material("seo/hud/current_task_icon.png", "noclamp smooth")
-- local x, y, w, h = ScrW(), ScrH(), ScrW(), ScrH()
-- hook.Add("HUDPaint", "rp.Quests.HUD", function()
--     local quest = LocalPlayer():GetActiveQuest()
--     local queststate = quest and string.Wrap('rp.ui.19', LocalPlayer():GetQuestStateName(), w / 6)
--     do -- quest
--         if quest ~= nil then
--             NoPanelBlur(x/1.26, y*0.01, w/5, h*0.085 + (#queststate * 15), 5, 2)
--             draw.RoundedBoxOutlined( 2, x/1.26, y*0.01, w/5, h*0.085 + (#queststate * 15), Color(20, 20, 20, 150), Color(50,50,50,150) )
--             surface.SetMaterial(currenttask)
--             surface.SetDrawColor(color_white)
--             surface.DrawTexturedRect(x/1.05, y*0.02, ba.ScreenScale(60), ba.ScreenScale(60))
--             draw.ShadowSimpleText(rp.Quests.GetQuestName(quest), 'font_base_24', x/1.25, y*0.015, Color(243,152,97), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
--             draw.ShadowSimpleText('Основное задание ↓', 'rp.ui.20', x/1.25, y*0.042, Color(220,220,220), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
--             draw.ShadowSimpleText('●', 'rp.ui.18', x/1.25, y*0.075, Color(0,255,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
--             for k, v in ipairs(queststate) do
--                 draw.ShadowSimpleText(v, 'rp.ui.19', x/1.24, y*0.054 + (k * 18), Color(200,200,200), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
--             end
--             -- draw.ShadowSimpleText(queststate, 'rp.ui.19', x/1.24, y*0.07, Color(220,220,220), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT)
--         end
--     end
-- end)

-- net.Receive("rp.Quests.Finish", function(len, ply)
--     local success = Material('seo/events/success_bg.png', 'noclamp smooth')
--     local reward_bg = Material('seo/events/reward_item_bg.png', 'noclamp smooth')
--     local moneyicon = Material("samprp/moreicons/money_pack.png", "noclamp smooth")
--     local xpicon = Material("seo/hud/icon_exp.png", "noclamp smooth")
--     local x, y = ScrW(), ScrH()
--     local alpha = 0
--     local alpha2 = 255
--     local close = false
--     local rewards = rp.Quests.List[LocalPlayer():GetActiveQuest()].reward

--     surface.PlaySound( "sfx/level_up.wav" )

--     hook.Add("HUDPaint", "rp.Quests.Finish", function()
--         if close and alpha < 1 then return end
--         if not close then
--             alpha = Lerp(.008, alpha, 255)
--         end
        
--         NoPanelBlur(0, 0, x, y, 5, 2)
--         draw.RoundedBox(0, 0, 0, x, y, Color(0,0,0,alpha*0.5))
--         surface.SetMaterial(success)
--         surface.SetDrawColor(Color(255,255,255,alpha*0.9))
--         surface.DrawTexturedRect(0, 0, x, y/1.05)
        

--         draw.SimpleText("ЗАДАНИЕ ВЫПОЛНЕНО", "font_base_84", x/2-1, y*0.2-1, Color(0,0,0, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
--         draw.SimpleText("ЗАДАНИЕ ВЫПОЛНЕНО", "font_base_84", x/2, y*0.2, Color(0,255,0, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
--         draw.SimpleText("ВАША НАГРАДА", "font_base_54", x/2-1, y/1.5-1, Color(0,0,0, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
--         draw.SimpleText("ВАША НАГРАДА", "font_base_54", x/2, y/1.5, Color(243,152,97, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
--         if table.Count(rewards) == 2 then
--             surface.SetMaterial(reward_bg)
--             surface.SetDrawColor(Color(255,255,255,alpha))
--             surface.DrawTexturedRect(x/1.92, y/1.4, ba.ScreenScale(128), ba.ScreenScale(128))    
                
--             draw.SimpleText(rewards[1].name, "font_base_24", x/1.8, y/1.3-1, Color(0,0,0, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
--             draw.SimpleText(rewards[1].name, "font_base_24", x/1.8, y/1.3, Color(0,255,0, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)	    	
                            
--             surface.SetMaterial(reward_bg)
--             surface.SetDrawColor(Color(255,255,255,alpha))
--             surface.DrawTexturedRect(x/2.5, y/1.4, ba.ScreenScale(128), ba.ScreenScale(128))

--             draw.SimpleText(rewards[2].name, "font_base_24", x/2.3, y/1.3-1, Color(0,0,0, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
--             draw.SimpleText(rewards[2].name, "font_base_24", x/2.3, y/1.3, Color(0,255,0, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)	    		    	
--         elseif table.Count(rewards) == 1 then
--             -- surface.SetMaterial(moneyicon)
--             -- surface.SetDrawColor(Color(255,255,255,alpha))
--             -- surface.DrawTexturedRect(x/1.92, y/1.4, ba.ScreenScale(128), ba.ScreenScale(128))    	
--         end
        
--         timer.Simple(6, function()
--             close = true
--             alpha = Lerp(.008, alpha, 0)
--         end)
--     end)
-- end)


-- local PANEL = {}
-- local accept = Material("seorp/moreicons/badge_approve.png")
-- local deny = Material("seorp/moreicons/cross.png")

-- function PANEL:Init()
--     local dg = surface.GetTextureID("vgui/gradient-u")
--     local gradient = Material("gui/gradient")

--     self.tasks = self:Add( "monoPanel" )
--     self.tasks:Dock(FILL)
--     self.tasks:Clear()

--     self.taskname = self.tasks:Add( "DLabel")
--     self.taskname:Dock(TOP)
--     self.taskname:DockPadding(5,5,5,5)
--     self.taskname:DockMargin(5,5,5,5)
--     self.taskname:SetText("Выберите желаемое задание и нажмите на крестик слева, чтобы начать его выполнение. После выполнения задания вы получите награду, задание изменит значок на галочку.")
--     self.taskname:SetWrap(true)
--     self.taskname:SetFont("font_base_24")
--     self.taskname:SetContentAlignment(7)
--     self.taskname:SetTall(100)
--     self.taskname.Paint = function( self, w, h )
--         surface.SetDrawColor(30, 30, 30, 70)
--         surface.DrawRect(0, 0, w, h)
--     end


--     self.tasksscroll = vgui.Create( "SRP_ScrollPanel", self.tasks ) 
--     self.tasksscroll:Dock( FILL )
--     self.tasksscroll:DockMargin(0,10,0,0)
--     self.tasksscroll.sbar = self.tasksscroll:GetVBar()
--     self.tasksscroll.sbar.Paint = function( self, w, h ) draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150)) end
--     self.tasksscroll.sbar.btnUp.Paint = function( self, w, h ) end
--     self.tasksscroll.sbar.btnDown.Paint = function( self, w, h ) end
--     self.tasksscroll.sbar.btnGrip.Paint = function( self, w, h ) draw.RoundedBox(0, 0, 0, w, h, Color(200, 200, 200, 150)) end
-- 	self.tasksscroll.Paint = function( self, w, h )
--         surface.SetDrawColor(30, 30, 30, 70)
--         surface.DrawRect(0, 0, w, h)
--     end

--     for k, v in pairs( rp.Quests.List ) do
--         if LocalPlayer():GetQuestDone(k) then continue end
--         local task = self.tasksscroll:Add( "monoButton")
--         task:Dock(TOP)
--         task:DockPadding(5,0,5,5)
--         task:DockMargin(5,5,5,5)
--         task:SetTall(60)
--         task:SetText('')

--         local taskbutton = task:Add( "monoImage")
--         taskbutton:Dock(LEFT)
--         taskbutton:DockPadding(5,0,5,5)
--         taskbutton:DockMargin(5,5,5,5)
--         taskbutton:SetTall(60)
--         taskbutton:SetColor(color_white)
--         taskbutton:SetImage(LocalPlayer():GetQuestDone(k) and accept or deny)
--         taskbutton.DoClick = function()
--             RunConsoleCommand("rp", "selectquest", k)
--         end

--         local taskname = task:Add( "DLabel")
--         taskname:Dock(LEFT)
--         taskname:DockPadding(5,5,5,5)
--         taskname:DockMargin(5,5,5,5)
--         taskname:SetText(v.name)
--         taskname:SetFont("font_base_24")
--         taskname:SizeToContents()

--         local progress = task:Add( "DLabel")
--         progress:Dock(RIGHT)
--         progress:DockPadding(5,5,5,5)
--         progress:DockMargin(5,5,5,5)
--         progress:SetText(LocalPlayer():GetQuestState(k).." / "..GetQuestStatesCount(k))
--         progress:SetFont("font_base_24")
--         progress:SizeToContents()

--         local progressbar = task:Add( "ZProgressbar")
--         progressbar:Dock(FILL)
--         progressbar:DockMargin(16, 16, 0, 16)
--         progressbar:SetProgress((LocalPlayer():GetQuestState(k) / GetQuestStatesCount(k)) * 100)

--         progressbar.lerp = 0

--         progressbar.Paint = function(self, w, h)

--         self.lerp = Lerp( 100 * FrameTime(), self.lerp, self:GetProgress() )

--         surface.SetDrawColor( Color(50, 50, 50, 150) )
--         surface.DrawRect(0,0, w, h)

--         -- the bar itself
--         surface.SetDrawColor( Color(90, 190, 90, 150) )
--         surface.DrawRect(0,0, w * self:GetProgress() - 2, h)

--         -- shading
--         surface.SetDrawColor( Color(0, 0, 0, 40) )
--         surface.DrawRect(0,h/2, w  , h/2)

    
--     end
--   end
-- end

-- function PANEL:PerformLayout(w, h)
--   -- if IsValid(self.skillbtn) then
--   --   self.skillbtn:SetSize(self.skill:GetSize())
--   -- end
-- end

-- vgui.Register('rp.QuestsMenu', PANEL, 'monoPanel')

