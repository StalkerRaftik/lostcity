if SERVER then

	sound.Add( {
		name = "inventory_search",
		channel = CHAN_AUTO,
		volume = 1.0,
		level = 75,
		pitch = 100,
		sound = "inventory/crate_search.wav"
	} )

	util.AddNetworkString("rp.ProgressBar.Start")
	util.AddNetworkString("rp.ProgressBar.Stop")

	function PLAYER:StartProgressBar(delay, callback, text)
		if not IsValid(self) then return end
		if timer.Exists("ProgressBarTimer"..self:UserID()) then return end
		net.Start("rp.ProgressBar.Start")
		net.WriteFloat(delay)
		if text then
			net.WriteString(text)
		end
		net.Send(self)
		if (text == 'Хм...') or (text == 'Обыскиваю...') or (text == 'Ищу...') or (text == 'Осматриваю...') then
			self:EmitSound( "inventory_search" )
		end
		self.ProgressBar = true
		self.lastprogresposbars = self:GetPos()
		timer.Create("ProgressBarTimer"..self:UserID(), delay, 1, function()
			self:StopProgressBar(callback)
			if (text == 'Хм...') or (text == 'Обыскиваю...') or (text == 'Ищу...') or (text == 'Осматриваю...') then
				self:StopSound("inventory_search")
			end
		end)
	end

	function PLAYER:StopProgressBar(callback)
		if not IsValid(self) then return end
		self.lastprogresposbars = nil
		self.ProgressBar = false
		if timer.Exists("ProgressBarTimer"..self:UserID()) then
			timer.Destroy("ProgressBarTimer"..self:UserID())
		end
		net.Start("rp.ProgressBar.Stop")
		net.Send(self)
		if callback then
			callback(self)
		end
	end

	hook.Add("Think", "CheckPlyProgressPosition", function()
		for k, ply in pairs( player.GetAll() ) do
			if not IsValid( ply ) or not ply:Alive() then continue end
			if not ply.ProgressBar then return false end
			if not ply.lastprogresposbars then return end
			if ply:GetPos():DistToSqr(ply.lastprogresposbars) > 4 then
				-- if (text == 'Хм...') or (text == 'Обыскиваю...') or (text == 'Ищу...') or (text == 'Осматриваю...') then
				ply:StopSound("inventory_search")
				-- end
				ply:StopProgressBar()
			end
		end
	end)

	hook.Add("PlayerDeath", "DoPlayerDeath.RemoveProgressBar", function(ply, attacker, dmg)
		if not IsValid(ply) then return end
		ply.lastprogresposbars = nil
		ply.ProgressBar = false
		if timer.Exists("ProgressBarTimer"..ply:UserID()) then
			timer.Destroy("ProgressBarTimer"..ply:UserID())
		end
		net.Start("rp.ProgressBar.Stop")
		net.Send(ply)
	end)


	hook.Add( "PlayerButtonDown", "RemoveProgressBarByClient", function( ply, button )
		if button ~= KEY_F then return end

		if not IsValid(ply) then return end
		ply.lastprogresposbars = nil
		ply.ProgressBar = false
		if timer.Exists("ProgressBarTimer"..ply:UserID()) then
			timer.Destroy("ProgressBarTimer"..ply:UserID())
		end
		net.Start("rp.ProgressBar.Stop")
		net.Send(ply)
	end)
else
	local over_time, start_time
	net.Receive("rp.ProgressBar.Start", function()
		local delay = net.ReadFloat()
		local text = net.ReadString() or nil
		start_time = CurTime()
		over_time = start_time + delay
		progress_text = text

		LocalPlayer().start_time = start_time
		LocalPlayer().over_time = over_time
		LocalPlayer().progress_text = progress_text
	end)

	net.Receive("rp.ProgressBar.Stop", function()
		start_time = nil
		over_time = nil
		progress_text = nil

		LocalPlayer().start_time = nil
		LocalPlayer().over_time = nil
		LocalPlayer().progress_text = nil
	end)

	local w, h = 400, 50
	local scr_w, scr_h = ScrW(), ScrH()
	local TimeLerp
	hook.Add("HUDPaint", "rp.ProgressBar", function()
		if start_time then
			TimeLerp = Lerp(FrameTime() / 1.7, (CurTime()-start_time)/(over_time-start_time)*360, 0)
			ColorLerp = Lerp(FrameTime() / 1.7, (CurTime()-start_time)/(over_time-start_time)*255, 0)
			local ColorPerc = Color(255-(TimeLerp),TimeLerp*3,0)
			local color = ColorAlpha(color_white, ColorLerp)
			draw.OctopusArc({x=scr_w/2, y=scr_h/1.8},360,TimeLerp,30,360,5, color)
			if progress_text and progress_text ~= nil and progress_text ~= "nil" then
				draw.ShadowSimpleText(progress_text, "rp.ui.20", scr_w/2, scr_h/1.65, color, 1, 1)
				draw.ShadowSimpleText("Нажмите F, чтобы отменить", "rp.ui.16", scr_w/2, scr_h/1.6, color, 1, 1)
			end
		end
	end)
end

