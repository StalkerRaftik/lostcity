ba.AddTerm('EntityNoOwner', 'This entity has no owner.')
ba.AddTerm('CannotUnown', 'You cannot unown this door.')
ba.AddTerm('EntityOwnedBy', '# owns this entity.')
ba.AddTerm('AdminUnownedYourDoor', '# force unowned your door.')
ba.AddTerm('AdminUnownedPlayerDoor', '# force unowned #\'s door.')
ba.AddTerm('AdminChangedYourJob', '# изменил вашу профессию на #.')
ba.AddTerm('AdminChangedPlayerJob', '# выдал игроку # профессию #.')
ba.AddTerm('JobNotFound', 'Работа # не найдена!')
ba.AddTerm('AdminUnwantedYou', '# has force unwanted you.')
ba.AddTerm('AdminUnwantedPlayer', '# has force unwanted #.')
ba.AddTerm('PlayerNotWanted', '# is not wanted!')
ba.AddTerm('AdminUnarrestedYou', '# has force unarrested you.')
ba.AddTerm('AdminUnarrestedPlayer', '# has force unarrested #.')
ba.AddTerm('PlayerNotArrested', '# is not arrested!')
ba.AddTerm('AdminUnwarrantedYou', '# has force unwarranted you.')
ba.AddTerm('AdminUnwarrantedPlayer', '# has force unwarranted #.')
ba.AddTerm('PlayerNotWarranted', '# is not warranted!')
ba.AddTerm('EventInvalid', '# is not a valid event!')
ba.AddTerm('AdminStartedEvent', '# has started a # event for #.')
ba.AddTerm('AdminFrozePlayersProps', '# has frozen #\'s props.')
ba.AddTerm('AdminFrozeAllProps', '# has frozen all props.')
ba.AddTerm('PlayerVoteInvalid', 'No vote for # exists!')
ba.AddTerm('AdminDeniedVote', '# has denied #\'s vote.')
ba.AddTerm('AdminDeniedTeamVote', '# has denied the # vote.')
ba.AddTerm('AdminAddedYourMoney', '# выдал вам # монет.')
ba.AddTerm('AdminAddedMoney', 'Вы выдали # монет #.')
ba.AddTerm('AdminAddedYourCredits', '# has added # credits to your account.')
ba.AddTerm('AdminAddedCredits', 'You have added # credits to #\'s account.')
ba.AddTerm('AdminMovedPlayers', 'Moved # players to the other server.')
ba.AddTerm('PlayerNotFound', 'Couldn\'t find player #.')

-- ba.cmd.Create('Go', function(pl, args)
-- 	local ent = pl:GetEyeTrace().Entity
-- 	if IsValid(ent) and (ent:CPPIGetOwner() or ent.ItemOwner) then
-- 		ba.notify(pl, ba.Term('EntityOwnedBy'), (ent:CPPIGetOwner() or ent.ItemOwner))
-- 	else
-- 		ba.notify_err(pl, ba.Term('EntityNoOwner'))
-- 	end
-- end)
-- :SetFlag('U')
-- :SetHelp('Shows the owner of a prop')

ba.cmd.Create('Setjob', function(pl, args)
	for k, v in ipairs(rp.teams) do
		if string.find(v.name:lower(), args.name:lower()) then
			ba.notify(args.target, ba.Term('AdminChangedYourJob'), pl, v.name)
			ba.notify_staff(ba.Term('AdminChangedPlayerJob'), pl, args.target, v.name)
			if not args.target:Alive() then
				args.target:Spawn()
			end
			args.target:ChangeTeam(k, true)
			args.target:Spawn()
			return
		end
	end
	ba.notify_err(pl, ba.Term('JobNotFound'), args.name)
end)
:AddParam('player_entity', 'target')
:AddParam('string', 'name')
:SetFlag('L')
:SetHelp('Меняет профессию игроку')

ba.cmd.Create('banjob', function(pl, args)
	local time = args.time or 0
	args.target:TeamBan(args.target:GetJob(), time)
	args.target:ChangeTeam(rp.DefaultTeam, true)
end)
:AddParam('player_entity', 'target')
:AddParam('time', 'time')
:SetFlag('A')
:SetHelp('Заблокировать игроку профессию')

ba.cmd.Create('Freeze Props', function(pl, args)
	if IsValid(args.target) then
		ba.notify_staff(ba.Term('AdminFrozePlayersProps'), pl, args.target)
		for k, v in ipairs(ents.GetAll()) do
	        if IsValid(v) and v:IsProp() and (v:CPPIGetOwner() == args.target) then
	            local phys = v:GetPhysicsObject()
	            if IsValid(phys) then
	                phys:EnableMotion(false)
	            end
	            constraint.RemoveAll(v)
	        end
	    end
	else
		ba.notify_staff(ba.Term('AdminFrozeAllProps'), pl)
		for k, v in ipairs(ents.GetAll()) do
	        if IsValid(v) and v:IsProp() then
	            local phys = v:GetPhysicsObject()
	            if IsValid(phys) then
	                phys:EnableMotion(false)
	            end
	            constraint.RemoveAll(v)
	        end
	    end
	end
end)
:AddParam('player_entity', 'target', 'optional')
:SetFlag('A')
:SetHelp('Замораживает все пропы')


