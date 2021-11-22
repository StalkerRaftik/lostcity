function team.GetModel(t)
	if not t then
		t = 1
	end

	return (istable(rp.teams[t].model) and rp.teams[t].model[math.random(1, #rp.teams[t].model)] or rp.teams[t].model)
end

function PLAYER:GetJobTable()
	return rp.teams[self:GetJob()]
end

function PLAYER:IsDisguised()
	return (self:GetNetVar('DisguiseTeam') ~= nil)
end

function PLAYER:GetTeamTable()
	return rp.teams[self:Team()] or rp.teams[1]
end

function PLAYER:GetJob()
	return (self:IsDisguised() and self:GetNetVar('DisguiseTeam') or self:Team())
end

function PLAYER:GetJobName()
	return (self:IsDisguised() and team.GetName(self:GetNetVar('DisguiseTeam')) or (self:GetNetVar('job') or team.GetName(self:Team())))
end

function PLAYER:GetJobColor()
	return team.GetColor(self:GetNetVar('DisguiseTeam') or self:Team())
end

function PLAYER:GetSalary()
	return (rp.teams[self:Team()] and (rp.teams[self:Team()].salary == 0 and 0 or rp.teams[self:Team()].salary or 0))
end

function PLAYER:GetDisguiseTime()
	return math.max(math.ceil((self:GetNetVar('DisguiseTime') or CurTime()) - CurTime()), 0)
end

if (CLIENT) then
	CreateConVar("cl_playercolor", "0.24 0.34 0.41", {FCVAR_ARCHIVE, FCVAR_USERINFO, FCVAR_DONTRECORD}, "The value is a Vector - so between 0-1 - not between 0-255")
	CreateConVar("cl_weaponcolor", "0.30 1.80 2.10", {FCVAR_ARCHIVE, FCVAR_USERINFO, FCVAR_DONTRECORD}, "The value is a Vector - so between 0-1 - not between 0-255")
	CreateConVar("cl_playerskin", "0", {FCVAR_ARCHIVE, FCVAR_USERINFO, FCVAR_DONTRECORD}, "The skin to use, if the model has any")
	CreateConVar("cl_playerbodygroups", "0", {FCVAR_ARCHIVE, FCVAR_USERINFO, FCVAR_DONTRECORD}, "The bodygroups to use, if the model has any")
end

-- player class
player_manager.RegisterClass('rp_player', {
	DisplayName = 'RP Player Class',
	GetHandsModel = function(self)
		local name = player_manager.TranslateToPlayerModelName(self.Player:GetModel())

		return player_manager.TranslatePlayerHands(name)
	end,
	Spawn = function(self)
		local col = self.Player:GetInfo('cl_playercolor')
		self.Player:SetPlayerColor(Vector(col))
		local col = self.Player:GetInfo('cl_weaponcolor')
		self.Player:SetWeaponColor(Vector(col))
	end,
	SetModel = function(self)
		local cl_playermodel = self.Player:GetInfo('cl_playermodel')
		local modelname = player_manager.TranslatePlayerModel(cl_playermodel)
		self.Player:SetModel(Model(modelname))
		local skin = self.Player:GetInfoNum('cl_playerskin', 0)
		self.Player:SetSkin(skin)
		local groups = self.Player:GetInfo('cl_playerbodygroups')

		if (groups == nil) then
			groups = ''
		end

		local groups = string.Explode(' ', groups)

		for k = 0, self.Player:GetNumBodyGroups() - 1 do
			self.Player:SetBodygroup(k, tonumber(groups[k + 1]) or 0)
		end
	end,
	TauntCam = TauntCamera(),
	CalcView = function(self, view)
		if (self.TauntCam:CalcView(view, self.Player, self.Player:IsPlayingTaunt())) then return true end
	end,
	CreateMove = function(self, cmd)
		if (self.TauntCam:CreateMove(cmd, self.Player, self.Player:IsPlayingTaunt())) then return true end
	end,
	ShouldDrawLocal = function(self)
		if (self.TauntCam:ShouldDrawLocalPlayer(self.Player, self.Player:IsPlayingTaunt())) then return true end
	end,
	JumpPower = 300,
	DuckSpeed = 0.5,
	WalkSpeed = 200,
	RunSpeed = 350
}, 'player_default')
