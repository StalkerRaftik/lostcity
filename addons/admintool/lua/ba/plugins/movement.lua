ba.AddTerm('AdminGoneTo', '# телепортировался к #.')
ba.AddTerm('AdminBring', '# телепортировал # к себе.')
ba.AddTerm('AdminRoomUnset', 'Админ-комната не установлена!')
ba.AddTerm('AdminGoneToAdminRoom', '# has gone to the admin room.')
ba.AddTerm('AdminRoomSet', 'Админ-комната установлена на вашу позицию.')
ba.AddTerm('AdminReturnedSelf', '# вернул себя.')
ba.AddTerm('NoKnownPosition', 'У вас нет прошлой позиции.')
ba.AddTerm('NoKnownPositionPlayer', '# не имеет прошлой позиции!')

-------------------------------------------------
-- Tele
-------------------------------------------------
ba.cmd.Create('Tele', function(pl, args)
	for k, v in ipairs(args.targets) do
		if (not v:Alive()) then
			v:Spawn()
		end

		if v:InVehicle() then
			v:ExitVehicle()
		end

		v:SetBVar('ReturnPos', v:GetPos())

		v:SetPos(util.FindEmptyPos(pl:GetEyeTrace().HitPos))

	end

	ba.notify_staff('# has teleported ' .. ('# '):rep(#args.targets) .. '.', pl, unpack(args.targets))
end)
:AddParam('player_entity_multi', 'targets')
:SetFlag('M')
:SetHelp('Телепортирует к вашей цели/туда, куда вы смотрите')
:SetIcon('icon16/arrow_up.png')
:AddAlias('tp')

-------------------------------------------------
-- ba warp
-------------------------------------------------
ba.cmd.Create('Setwarp', function(pl, args)
	pl.WarpPos = pl:GetPos()
end)
:SetFlag('A')
:SetHelp('Устанавливает точку телепорта на ваше местоположение')

ba.cmd.Create('Warp', function(pl, args)
	if not pl.WarpPos then return end

	for k, v in ipairs(args.targets) do
		v:SetPos(util.FindEmptyPos(pl.WarpPos))
	end

	ba.notify_staff('# телепортировал ' .. ('# '):rep(#args.targets) .. ' на свою точку спавна.', pl, unpack(args.targets))
end)
:AddParam('player_entity_multi', 'targets')
:SetFlag('A')
:SetHelp('Телепортирует цель/цели на вашу варп-точку')
:SetIcon('icon16/arrow_up.png')

-------------------------------------------------
-- Goto
-------------------------------------------------
ba.cmd.Create('Goto', function(pl, args)
	if not pl:Alive() then
		pl:Spawn()
	end
		
	if pl:InVehicle() then
		pl:ExitVehicle()
	end

	pl:SetBVar('ReturnPos', pl:GetPos())

	local pos = util.FindEmptyPos(args.target:GetPos()) 

	pl:SetPos(pos)

	ba.notify_staff(ba.Term('AdminGoneTo'), pl, args.target)
end)
:AddParam('player_entity', 'target')
:SetFlag('M')
:SetHelp('Телепортирует вас к вашей цели')
:SetIcon('icon16/arrow_down.png')

-------------------------------------------------
-- Goto
-------------------------------------------------
ba.cmd.Create('Bring', function(pl, args)
	if not args.target:Alive() then
		args.target:Spawn()
	end
		
	if args.target:InVehicle() then
		args.target:ExitVehicle()
	end

	args.target:SetBVar('ReturnPos', args.target:GetPos())

	local pos = util.FindEmptyPos(pl:GetPos()) 

	args.target:SetPos(pos)

	ba.notify_staff(ba.Term('AdminBring'), pl, args.target)
end)
:AddParam('player_entity', 'target')
:SetFlag('M')
:SetHelp('Телепортирует цель к вам')
:SetIcon('icon16/arrow_down.png')


-------------------------------------------------
-- Sit
-------------------------------------------------
if (SERVER) then
	ba.adminRoom = ba.svar.Get('adminroom') and pon.decode(ba.svar.Get('adminroom'))[1]
	ba.svar.Create('adminroom', nil, false, function(svar, old_value, new_value)
		ba.adminRoom = pon.decode(new_value)[1]
	end)
end

ba.cmd.Create('Sit', function(pl, args)
	if not ba.svar.Get('adminroom') then
		ba.notify_err(pl, ba.Term('AdminRoomUnset'))
		return
	end
		
	if not pl:Alive() then
		pl:Spawn()
	end

	pl:SetBVar('ReturnPos', pl:GetPos())

	local pos = util.FindEmptyPos(ba.adminRoom)

	pl:SetPos(pos)

	ba.notify_staff(ba.Term('AdminGoneToAdminRoom'), pl)
end)
:SetFlag('M')
:SetHelp('Телепортирует вас в админ-комнату')

-------------------------------------------------
-- Set Admin Room
-------------------------------------------------
ba.cmd.Create('SetAdminRoom', function(pl, args)
	ba.svar.Set('adminroom', pon.encode({pl:GetPos()}))
	ba.notify(pl, ba.Term('AdminRoomSet'))
end)
:SetFlag('*')
:SetHelp('Устанавливает админ-комнату на вашу позицию')

-------------------------------------------------
-- Return
-------------------------------------------------
ba.cmd.Create('Return', function(pl, args)
	if (args.targets == nil) then
		if (pl:GetBVar('ReturnPos') ~= nil) then
			if not pl:Alive() then
				pl:Spawn()
			end
			
			local pos = util.FindEmptyPos(pl:GetBVar('ReturnPos'))
			pl:SetPos(pos)

			pl:SetBVar('ReturnPos', nil)

			ba.notify_staff(ba.Term('AdminReturnedSelf'), pl)
		else
			ba.notify_err(pl, ba.Term('NoKnownPosition'))
		end
		return
	end

	for k, v in ipairs(args.targets) do
		if (v:GetBVar('ReturnPos') == nil) then
			ba.notify_err(pl, ba.Term('NoKnownPositionPlayer'), v)
			return
		end

		if not v:Alive() then
			v:Spawn()
		end
			
		if v:InVehicle() then
			v:ExitVehicle()
		end

		local pos = util.FindEmptyPos(v:GetBVar('ReturnPos'))

		v:SetPos(pos)
		v:SetBVar('ReturnPos', nil)
	end

	ba.notify_staff('# has returned ' .. ('# '):rep(#args.targets) .. '.', pl, unpack(args.targets))
end)
:AddParam('player_entity_multi', 'targets', 'optional')
:SetFlag('M')
:SetHelp('Возвращает вас или вашу цель на предыдущую позицию')
:SetIcon('icon16/arrow_down.png')

-------------------------------------------------
-- Player physgun
-------------------------------------------------
if (SERVER) then
	hook.Add('PhysgunPickup', 'ba.PhysgunPickup.PlayerPhysgun', function(pl, ent)
		if ((ba.IsPlayer(ent) and pl:HasAccess('a') and ba.ranks.CanTarget(pl, ent) and ba.canAdmin(pl)) or false) then
			ent:SetMoveType(MOVETYPE_NOCLIP)
			ent:SetBVar('PrePhysFrozen', ent:IsFrozen())
			ent:Freeze(true)
			
			pl:SetBVar('HoldingPlayer', ent)
			return true
		end
	end)

	hook.Add('PhysgunDrop', 'ba.PhysgunDrop.PlayerPhysgun', function(pl, ent)
		if ba.IsPlayer(ent) then
			ent:Freeze(ent:GetBVar('PrePhysFrozen'))
			ent:GetBVar('PrePhysFrozen', nil)
			ent:SetMoveType(MOVETYPE_WALK) 
			
			timer.Simple(0.2, function()
				if (!pl:IsValid()) then return end
				
				pl:SetBVar('HoldingPlayer', nil)
			end)
		end
	end)

	hook.Add('KeyRelease', 'ba.KeyRelease.PlayerPhysgun', function(pl, key)
		if IsValid(pl:GetBVar('HoldingPlayer')) and (key == IN_ATTACK2) then
			pl:ConCommand('ba freeze ' ..  pl:GetBVar('HoldingPlayer'):SteamID())
		end
	end)
end

-------------------------------------------------
-- Noclip
-------------------------------------------------
hook.Add('PlayerNoClip', 'ba.PlayerNoClip', function(pl)
	if (SERVER) and pl:HasAccess('a') then
		return (ba.canAdmin(pl) and (pl:GetBVar('CanNoclip') ~= false) or false)
	elseif (CLIENT) then
		return false
	end
end)