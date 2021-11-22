ba.AddTerm('AdminSentStaffMessage', '# отправил послание администрации серверу: #')

-------------------------------------------------
-- Tellall
-------------------------------------------------
if (CLIENT) then
	local SysTime 	= SysTime
	local timer 	= timer
	local surface 	= surface
	
	local msgQueue	= {}
	local createStaffMessage -- function defined later

	surface.CreateFont('ba.ui.tellall', {font = 'coolvetica',size = 40,weight = 800})

	local PANEL = {}
	 
	function PANEL:Init()
		self.Title = ui.Create('DLabel', self)
		self.Title:SetFont('ba.ui.22')
		self.Title:SetColor(Color(255,0,0))
		self.Title:SetText('Внимание!')
	end

	function PANEL:SetPos(x, y, force, time)
		if (force) then self.BaseClass.SetPos(self, x, y) return end

		self:SetMovement(self.x, x, y, y, time or nil)
		self._StartTime = SysTime()
		self._Movement = 1
	end

	function PANEL:SetMovement(startX, endX, startY, endY, timeOverride)
		self.StartPos = {x = startX, y = startY}
		self.EndPos = {x = endX, y = (endY or startY)}
		self._AnimTime = timeOverride or nil
	end

	function PANEL:Close()
		self:SetMovement(self.x, -self:GetWide(), self.y, self.y)
		self._StartTime = SysTime()
		self._Movement = -1
		timer.Simple(3, function() if (self:IsValid()) then pTheme.Close(self) end if (msgQueue[1]) then createStaffMessage() end end)
	end

	function PANEL:Think()
		if (!self._NoMoves) and (self._Movement != 0) then
			local mul, clamp
			if (self._Movement == 1) then
				clamp = math.Clamp((SysTime() - self._StartTime) / (self._AnimTime or .5), 0, 1)
				mul = math.sin(clamp * (math.pi / 1.418776)) * 1.25
			else
				clamp = math.Clamp((SysTime() - self._StartTime) / (self._AnimTime or .3), 0, 1)
				mul = math.sin((1 - clamp) * (math.pi / 1.418776)) * 1.25
			end
			local x, y
			if (self._Movement == 1) then
				x = self.StartPos.x + (mul * (self.EndPos.x - self.StartPos.x))
				y = self.StartPos.y + (mul * (self.EndPos.y - self.StartPos.y))
			else
				x = self.StartPos.x - (mul * (self.EndPos.x - self.StartPos.x)) + (self.EndPos.x - self.StartPos.x)
				y = self.StartPos.y - (mul * (self.EndPos.y - self.StartPos.y)) + (self.EndPos.y - self.StartPos.y)
			end
			self:SetPos(x, y, true)
			if (clamp == 1) then
				self._AnimTime = nil
				
				if (self._Movement == -1) then
					self:Remove()
				else
					self._Movement = 0
				end
			end
		end
		self:SetCursor('arrow')
	end

	function PANEL:SetMessage(str)
		surface.SetFont('ba.ui.tellall')
		local w = surface.GetTextSize(str) + 20
		local x, y = 10, 25
		local msg
		if w < 200 then
			w = 200
			x = 200/2 - surface.GetTextSize(str)/2
		end
		if w < ScrW() * .8 then
			msg = {str}
		elseif w > ScrW() * .8 then
			w = ScrW() * .8
			msg = string.Wrap('ba.ui.tellall', str, w - 20)
		end
		self:SetSize(w, 35 + #msg * 30)
		self:SetPos(ScrW()/2 - self:GetWide()/2, 100)
		for k, txt in ipairs(msg) do
			local lbl = ui.Create('DLabel', self)
			lbl:SetFont('ba.ui.tellall')
			lbl:SetText(txt)
			lbl:SizeToContents()
			lbl:SetPos(x, y)
			lbl:SetTextColor(Color(255,255,255))
			y = y + lbl:GetTall()
		end
	end

	function PANEL:PerformLayout()
		self.Title:SizeToContents()
		self.Title:SetPos(self:GetWide()/2 - self.Title:GetWide()/2, 4)
		self.Title:SetSize(self.Title:GetWide(), 20)
	end

	local color_black = Color(0,0,0)
	local color_white = Color(255,255,255)
	function PANEL:Paint(w, h)
		draw.OutlinedBox(0, 0,w, h , color_black, color_white)
	end

	derma.DefineControl('ba_msg', 'badmin tellall', PANEL, 'ui_panel')
	
	createStaffMessage = function()
		activeElement = ui.Create('ba_msg', function(self)
			self:SetMessage(table.remove(msgQueue, 1))
		end)
		timer.Simple(10, function()
			activeElement:Close()
		end)
	end

	net.Receive('ba.TellAll', function()
		local str = net.ReadString()
		
		table.insert(msgQueue, str)
		
		if (!IsValid(activeElement)) then
			createStaffMessage()
		end
	end)
end

-------------------------------------------------
-- Tell All
-------------------------------------------------
if (SERVER) then
	util.AddNetworkString('ba.TellAll')
end

ba.cmd.Create('TellAll', function(pl, args)
	net.Start('ba.TellAll')
		net.WriteString(args.message)
	net.Broadcast()
	ba.notify_all(ba.Term('AdminSentStaffMessage'), pl, args.message)
end)
:AddParam('string', 'message')
:SetFlag('A')
:SetHelp('Отправить сообщение всему серверу')