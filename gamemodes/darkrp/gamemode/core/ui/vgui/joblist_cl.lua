local PANEL = {}



function PANEL:Init()
	self:SetText('')
	self:SetTall(30)
end

function PANEL:Paint(w, h)
	draw.OutlinedBox(0, 0, w, h, self.job.color, ui.col.Outline)
	if self:IsHovered() then
		draw.OutlinedBox(0, 0, w, h, self.job.color, (self.job.vip and not LocalPlayer():IsVip()) and ui.col.Gold or ui.col.Hover)
	end

	local x = 60

	draw.ShadowSimpleText(self.job.name, 'font_base_24', x/4, h * 0.5, ui.col.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	draw.ShadowSimpleText(#team.GetPlayers(self.job.team) .. '/' .. ((self.job.max == 0) and '∞' or self.job.max), 'font_base_24', w - 10, h * 0.5, ui.col.White, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

end

function PANEL:PerformLayout()

end

function PANEL:OnCursorEntered()

	self.Parent.job = self.job

	-- local model = cvar.GetValue('TeamModel' .. self.job.name)

	self.Parent.ModelKey = (isnumber(model) and self.job.model[model]) and model or 1

	self.Parent.ModelPath = istable(self.job.model) and self.job.model[self.Parent.ModelKey] or self.job.model

	self.Preview:SetModel(self.Parent.ModelPath)

end



function PANEL:DoClick()

	if self.job.vip and (not LocalPlayer():IsVIP()) then
    Derma_Message( "Данная профессия доступна игрокам со статусом V.I.P", "V.I.P", "Ок")		
    return
	end

	rp.RunCommand('model', self.job.model[self.Parent.ModelKey])



	if self.Parent.DoClick then

		self.Parent.DoClick(self)

		return

	end


	if self.job.vote then
		local command = self.job.command
		rp.RunCommand('vote' .. command)
	else
		rp.RunCommand(self.job.command)
	end
end



function PANEL:SetJob(job)

	self.job = job

	self.job.color = Color(job.color.r, job.color.g, job.color.b, 125)

	self.ModelPath = istable(job.model) and job.model[1] or job.model


end



vgui.Register('rp_jobbutton', PANEL, 'Button')




PANEL = {}



function PANEL:Init()

	self.job = rp.teams[1]

	self.job.color = Color(Color(200,200,200).r, Color(200,200,200).g, Color(200,200,200).b, 125)

 -- self.ModelKey = math.Clamp((cvar.GetValue('TeamModel' .. self.job.name) or 1), 1, #self.job.model)

 self.ModelPath = istable(self.job.model) and self.job.model[self.ModelKey] or self.job.model

	 --rp.RunCommand('model', self.ModelPath)

	 self.JobList = ui.Create('ui_scrollpanel', self)

	self.Info = ui.Create('ui_panel', self)

	self.Info.Paint = function(s, w, h)
		draw.OutlinedBox(0, 0, w, 50, Color(200,200,200), ui.col.Outline)
		draw.ShadowSimpleText(self.job.name.." ["..self.job.salary.."$/3 мин.]", 'font_base_24', w * 0.5, 25, ui.col.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		for k, v in ipairs(string.Wrap('font_base_24', self.job.description, self:GetWide() - 10)) do
			draw.ShadowSimpleText(v, 'font_base_24', 5, 35 + (k * 26), ui.col.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end
	end



	self.Model = vgui.Create('DModelPanel', self)

	self.Model:SetCamPos( Vector( 190, 0, 50 ) )	-- Move cam in front of eyes
	function self.Model:LayoutEntity( Entity ) return end
	self.Model:SetLookAt(Vector(0,0,60))

	self.Model:SetFOV(10)

	local teams = {}

	for k, v in ipairs(rp.teams) do

		if ((not v.customCheck) or v.customCheck(LocalPlayer())) and (k ~= LocalPlayer():Team()) then

			local cat = v.category or 'Гражданские/Другие'

			if (not teams[cat]) then teams[cat] = {} end

			teams[cat][#teams[cat] + 1] = v

		end

	end



	for cat, jobs in SortedPairs(teams) do

		self.JobList:AddItem(ui.Create('DButton', function(self, p)

			self:SetText('')

			self:SetTall(25)

			self:SetDisabled(true)
			self.Paint = function(self, w , h)
				draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150))
				draw.ShadowSimpleText(cat, "font_base_24", w/2, 0.1, color_white, 1, 0)
			end

		end))

		for _, job in ipairs(jobs) do

			local btn = ui.Create('rp_jobbutton')

			btn:SetJob(job)

			btn.Parent 	= self

			btn.Preview = self.Model

			self.JobList:AddItem(btn)

		end

	end

end



function PANEL:PerformLayout()

	self.JobList:SetPos(5, 5)

	self.JobList:SetSize(self:GetWide() * 0.5 - 7.5, self:GetTall() - 10)



	self.Info:SetPos(self:GetWide() * 0.5 + 2.5, 5)

	self.Info:SetSize(self:GetWide() * 0.5 - 7.5, self:GetTall() * 0.5)



	self.Model:SetPos(self:GetWide() * 0.5 + 2.5, self:GetTall() * 0.5)

	self.Model:SetSize(self:GetWide() * 0.5 - 7.5, self:GetTall() * 0.5 - 35)



	--self.BackModel:SetPos(self:GetWide() * 0.75 - 52.5, self:GetTall() - 30)

	--self.BackModel:SetSize(50, 25)



	--self.NextModel:SetPos(self:GetWide() * 0.75 + 2.5, self:GetTall() - 30)

	--self.NextModel:SetSize(50, 25)

end



vgui.Register('rp_jobslist', PANEL, 'Panel')

