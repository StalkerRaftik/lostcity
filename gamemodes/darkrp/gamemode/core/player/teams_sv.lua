util.AddNetworkString('PlayerDisguise')

function PLAYER:Disguise(t, time)
	if not self:Alive() then return end
	self:SetNetVar('DisguiseTeam', t)
	if self:GetNetVar('job') then
		self:SetNetVar('job', nil)
	end
	self:SetModel(team.GetModel(t))
	rp.Notify(self, NOTIFY_GREEN, rp.Term('NowDisguised'), rp.teams[t].name)
	hook.Call('playerDisguised', GAMEMODE, self, self:Team(), t)
end

function PLAYER:UnDisguise()
	timer.Destroy('Disguise_' .. self:UniqueID())

	self:SetNetVar('DisguiseTeam', nil)
	self:SetModel(team.GetModel(self:Team()))
	rp.Notify(self, NOTIFY_RED, "Ваша маскировка закончилась!")
	-- self:SetNetVar('DisguiseTime', nil)
end

hook('OnPlayerChangedTeam', 'Disguise.OnPlayerChangedTeam', function(pl, prevTeam, t)
	if pl:IsDisguised() then
		pl:UnDisguise()
	end
end)

net('PlayerDisguise', function(len, pl)
	local t = net.ReadInt(8)
	if (rp.teams[pl:Team()].candisguise) and not (rp.teams[t].admin == 1) then
		if pl:IsDisguised() or (pl.NextDisguise and pl.NextDisguise > CurTime()) then 
			rp.Notify(pl, NOTIFY_ERROR, rp.Term('DisguiseLimit'), math.ceil((pl.NextDisguise - CurTime())/60))
			return 
		end
		pl:Disguise(t)
		pl.NextDisguise = CurTime() + 300
	end
end)

hook('PlayerDeath', 'teams.PlayerDeath', function(pl)
	if pl:IsDisguised() then
		pl:UnDisguise()
	end
end)

hook.Add( "EntityTakeDamage", "Disguise.EntityTakeDamage", function( target, dmginfo )
    local ply = target
    if IsValid(ply) and ply:IsPlayer() and ply:IsDisguised() then
		rp.Notify(self, NOTIFY_RED, "Вы получили урон, ваша маскировка сбросилась!")
        ply:UnDisguise()
    end
end )