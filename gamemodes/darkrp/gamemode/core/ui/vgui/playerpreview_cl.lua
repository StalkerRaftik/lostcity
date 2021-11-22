
-----------------------------------------------------
local PANEL = {}

function PANEL:Init()
	self:SetMouseInputEnabled(false)
	self:SetFOV(25)
	self:SetModel(LocalPlayer():GetModel())
	self.Entity.GetPlayerColor = function() return LocalPlayer():GetPlayerColor() end
	self.Sequences = {'pose_standing_01', 'pose_standing_02', 'pose_standing_03', 'pose_standing_04'}
	self:FindSequence()
end

function PANEL:LayoutEntity()
	self:RunAnimation()
end

function PANEL:DrawModel()
	self.Entity:DrawModel()
	self.Entity:SetEyeTarget(gui.ScreenToVector(gui.MousePos()))
end

function PANEL:PerformLayout()
	local w, h = self:GetSize()
	local hz = 60

	if IsValid(self.Entity) then
		local headBone = self.Entity:LookupBone('ValveBiped.Bip01_Head1')

		if headBone then
			hz = self.Entity:GetBonePosition(headBone).z
		end
	end

	if hz < 5 then
		hz = 40
	end

	hz = hz * 0.6
	self:SetCamPos(Vector(175, 0, hz))
	self:SetLookAt(Vector(0, 0, hz))
end

function PANEL:FindSequence()
	if IsValid(self.Entity) then
		local seqno
		repeat
			seqno = self.Entity:LookupSequence(self.Sequences[math.random(1, #self.Sequences)])
		until seqno
		self.Entity:SetSequence(seqno)
	end
end

function PANEL:AddSequence(sequence)
	self.Sequences[#self.Sequences + 1] = sequence
end


vgui.Register('rp_playerpreview', PANEL, 'DModelPanel')
