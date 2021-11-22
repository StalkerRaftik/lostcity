ba.AddTerm('AbuseAdminUnjailedPlayer', '# разджайлил #.')
ba.AddTerm('AbuseAdminJailedPlayer', '# посадил в джайл #.')
ba.AddTerm('AbusePlayerNotAlive', '# мертв!')
ba.AddTerm('AbuseAdminSlainPlayer', '# убил #.')

/*-------------------------------------------------
-- Jail
-------------------------------------------------
local jailPeices = {
	{pos = Vector(23,-84,-40),		ang = Angle(90,90,0)},
	{pos = Vector(23,-176.1,-40),	ang = Angle(90,90,0)},
    {pos = Vector(44,-152,-40),		ang = Angle(90,0,0)},
    {pos = Vector(-48.6,-152,-40),	ang = Angle(90,0,0)},
    {pos = Vector(23,-152,-64),		ang = Angle(0,0,0)},
    {pos = Vector(23,-152,28.1),	ang = Angle(0,0,0)},
}

local cmd = ba.cmd.Create('Jail', function(pl, args)
	if not args.target:Alive() then
		args.target:Spawn()
	end
		
	if args.target:InVehicle() then
		args.target:ExitVehicle()
	end

	if args.target:GetBVar('JailProps') then
		for k, v in ipairs(args.target:GetBVar('JailProps')) do 
			if IsValid(v) then
				v:Remove()
			end
		end
		args.target:GodDisable()
		args.target:SetBVar('CanNoclip', nil)
		args.target:SetBVar('JailProps', nil)
		args.target:SetBVar('JailPos', nil)

		for k, v in ipairs(args.target:GetBVar('PreJailWeps' or {})) do
			args.target:Give(v)
		end

		ba.notify_staff(ba.Term('AbuseAdminUnjailedPlayer'), pl, args.target)
		return
	end
	
	local pos = util.FindEmptyPos(pl:GetEyeTrace().HitPos)

	local weps = {}
	for _, wep in ipairs(args.target:GetWeapons()) do
		weps[#weps + 1] = wep:GetClass()
	end
	args.target:SetBVar('CanNoclip', false)
	args.target:SetBVar('PreJailWeps', weps)
	args.target:SetBVar('JailPos', args.target:GetPos())

	args.target:SetMoveType(MOVETYPE_WALK)
	args.target:StripWeapons()
	args.target:GodEnable()
	args.target:SetPos(pos + Vector(0,0,5))

	local jailprops = {}
	for k, v in ipairs(jailPeices) do
		local ent = ents.Create('prop_physics')
		ent:SetPos(pos + v.pos + Vector(0,125,65))
		ent:SetAngles(v.ang)
		ent:SetModel('models/props_phx/construct/windows/window2x2.mdl')
		ent:SetColor(Color(255,0,0,50))
		ent:SetMoveType(MOVETYPE_NONE)
		ent:Spawn()
		ent:Activate()
		ent:GetPhysicsObject():EnableMotion(false)
		
		jailprops[#jailprops + 1] = ent
	end

	args.target:SetBVar('JailProps', jailprops)

	ba.notify_staff(ba.Term('AbuseAdminJailedPlayer'), pl, args.target)
end)
cmd:AddParam('player_entity', 'target')
cmd:SetFlag('S')
cmd:SetHelp('Сажает/освобождает выбранного игрока из джайла')

hook.Add('PlayerSpawn', 'ba.jail.PlayerSpawn', function(pl)
	if (pl:GetBVar('JailPos') ~= nil) then
		pl:SetPos(pl:GetBVar('JailPos'))
		pl:GodEnable()
		pl:StripWeapons()
	end
end)

hook.Add('PlayerDisconnected', 'ba.jail.PlayerDisconnected', function(pl)
	local props = pl:GetBVar('JailProps')
	if (props ~= nil) then
		for k, v in ipairs(props) do
			if IsValid(v) then
				v:Remove()
			end
		end
	end
end)

hook.Add('playerCanRunCommand', 'ba.jail.playerCanRunCommand', function(pl)
	if (pl:GetBVar('JailPos') ~= nil) and not pl:HasAccess('*') then
		return false, 'Вы в джайле! Вы не можете использовать команды!'
	end
end)*/

-------------------------------------------------
-- Slay
-------------------------------------------------
ba.cmd.Create('Slay', function(pl, args)
	if not args.target:Alive() then
		ba.notify_err(pl, ba.Term('AbusePlayerNotAlive'), args.target)
		return
	end

	args.target:SetVelocity(Vector(0, 0, 2048))
	timer.Simple(0.2, function()	
		local effect = EffectData()
		effect:SetOrigin(args.target:GetPos())
		effect:SetMagnitude(512)
		effect:SetScale(128)
		util.Effect('Explosion', effect)
		args.target:Kill()
	end)

	ba.notify_staff(ba.Term('AbuseAdminSlainPlayer'), pl, args.target)
end)
:AddParam('player_entity', 'target')
:SetFlag('A')
:SetHelp('Убивает выбранного игрока')
:SetIcon('icon16/bomb.png')