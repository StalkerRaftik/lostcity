local term = ba.logs.Term

-- Kills
ba.logs.AddTerm('Killed', '#(#) убил #(#) с помощью # #', {
	'Attacker Name',
	'Attacker SteamID',
	[3] = 'Name',
	[4] = 'SteamID',
})

ba.logs.Create 'Убийства'
	:SetColor(Color(200,0,0))
	:Hook('PlayerDeath', function(self, pl, ent, killer)
		if killer:IsPlayer() then
			local w = killer:GetActiveWeapon()
			if w and w:IsValid() then
				wep = w:GetClass()
			else
				wep = "none"
			end	
			self:PlayerLog({pl, killer}, term('Killed'), killer:Name().."("..killer:RPName(true)..")".."("..killer:GetJobName()..")", killer:SteamID(), pl:Name().."("..pl:RPName(true)..")".."("..pl:GetJobName()..")", pl:SteamID(), wep, ((killer:InSpawn() or pl:InSpawn()) and ' in spawn' or ''))
		end
	end)


-- Damage
ba.logs.AddTerm('Damage', '#(#) нанес # урона #(#) с помощью # #', {
	'Attacker Name',
	'Attacker SteamID',
	[4] = 'Name',
	[5] = 'SteamID',
})

ba.logs.Create 'Урон'
	:Hook('EntityTakeDamage', function(self, ent, dmginfo)
		if ent:IsPlayer() and dmginfo:GetAttacker():IsPlayer() then
			local attacker = dmginfo:GetAttacker()
			local w = attacker:GetActiveWeapon()
			if w and w:IsValid() then
				wep = w:GetClass()
			else
				wep = "none"
			end	
			self:Log(term('Damage'), attacker:Name().."("..attacker:RPName(true)..")".."("..attacker:GetJobName()..")", attacker:SteamID(), math.Round(dmginfo:GetDamage(), 0), ent:Name().."("..ent:RPName(true)..")".."("..ent:GetJobName()..")", ent:SteamID(), wep, ((dmginfo:GetAttacker():InSpawn() or ent:InSpawn()) and ' in spawn ' or ''))
		end
	end)


-- Props
ba.logs.AddTerm('Prop', '#(#) заспавнил #', {
	'Name',
	'SteamID',
})

ba.logs.Create 'Пропы'
	:SetColor(Color(50,175,255))
	:Hook('PlayerSpawnProp', function(self, pl, mdl)
		if (not pl:IsJailed()) and (not pl.SpawningDupeProp) then 
			self:PlayerLog(pl, term('Prop'), pl:Name().."("..pl:RPName(true)..")".."("..pl:GetJobName()..")", pl:SteamID(), mdl)
		end
	end)

-- Q-Menu spawn
ba.logs.AddTerm('QmenuSent', '#(#) заспавнил энтити #', {
	'Name',
	'SteamID',
})

ba.logs.AddTerm('QmenuSwep', '#(#) заспавнил оружие #', {
	'Name',
	'SteamID',
})

ba.logs.AddTerm('QmenuGiveSwep', '#(#) выдал оружие #', {
	'Name',
	'SteamID',
})

ba.logs.Create 'Q-Menu'
	:SetColor(Color(50,175,255))
	:Hook('PlayerSpawnSENT', function(self, pl, mdl)
		self:PlayerLog(pl, term('QmenuSent'), pl:Name().."("..pl:RPName(true)..")".."("..pl:GetJobName()..")", pl:SteamID(), mdl)
	end)
	:Hook('PlayerSpawnSWEP', function(self, pl, class, mdl)
		self:PlayerLog(pl, term('QmenuSwep'), pl:Name().."("..pl:RPName(true)..")".."("..pl:GetJobName()..")", pl:SteamID(), class)
	end)
	:Hook('PlayerGiveSWEP', function(self, pl, class, mdl)
		self:PlayerLog(pl, term('QmenuGiveSwep'), pl:Name().."("..pl:RPName(true)..")".."("..pl:GetJobName()..")", pl:SteamID(), class)
	end)


-- Tools
ba.logs.AddTerm('Tool', '#(#) изменил # пренадлежащий #(#) с помощью инстумента #', {
	'Name',
	'SteamID',
})

ba.logs.Create 'Тулган'
	:Hook('PlayerToolEntity', function(self, pl, ent, tool)
		if IsValid(ent) then
			if IsValid(ent:CPPIGetOwner()) then
				self:PlayerLog(pl, term('Tool'), pl:Name().."("..pl:RPName(true)..")".."("..pl:GetJobName()..")", pl:SteamID(), ent:GetClass(), ent:CPPIGetOwner():Name().."("..ent:CPPIGetOwner():RPName(true)..")".."("..ent:CPPIGetOwner():GetJobName()..")", ent:CPPIGetOwner():SteamID(), tool)
			else
				self:PlayerLog(pl, term('Tool'), pl:Name().."("..pl:RPName(true)..")".."("..pl:GetJobName()..")", pl:SteamID(), ent:GetClass(), 'Unknown', 'STEAM:0:0', tool)
			end
		end
	end)


-- Physgun
ba.logs.AddTerm('Physgun', '#(#) зафизганил # пренадлежащий #(#)', {
	'Name',
	'SteamID',
})

ba.logs.Create('Физган', false)
	:Hook('PlayerPhysgunEntity', function(self, pl, ent)
		if IsValid(ent:CPPIGetOwner()) then
			self:PlayerLog(pl, term('Physgun'), pl:Name().."("..pl:RPName(true)..")".."("..pl:GetJobName()..")", pl:SteamID(), ent:GetClass(), ent:CPPIGetOwner():Name().."("..ent:CPPIGetOwner():RPName(true)..")".."("..ent:CPPIGetOwner():GetJobName()..")", ent:CPPIGetOwner():SteamID(), tool)
		else
			self:PlayerLog(pl, term('Physgun'), pl:Name().."("..pl:RPName(true)..")".."("..pl:GetJobName()..")", pl:SteamID(), ent:GetClass(), 'Unknown', 'STEAM:0:0', tool)
		end
	end)


-- Actions
ba.logs.AddTerm('RunRPCommand', '#(#) использовал команду # #', {
	'Name',
	'SteamID',
})

ba.logs.Create 'Команды'
	:Hook('PlayerRunRPCommand', function(self, pl, cmd, args, arg_str)
		if (cmd ~= '/weaponcolor') and (cmd ~= '/playercolor') then
			self:PlayerLog(pl, term('RunRPCommand'), pl:Name().."("..pl:RPName(true)..")".."("..pl:GetJobName()..")", pl:SteamID(), cmd, arg_str)
		end
	end)
	

-- Transactions
ba.logs.AddTerm('DropMoney', '#(#) выбросил $# (Осталось в кошельке: $#)', {
	'Name',
	'SteamID',
})

ba.logs.AddTerm('PickupMoney', '#(#) поднял $# (Осталось в кошельке: $#)', {
	'Name',
	'SteamID',
})

ba.logs.AddTerm('DropCheck', '#(#) dropped a check to #(#) for $# (New wallet: $#)', {
	'Name',
	'SteamID',
	'Target Name',
	'Target SteamID'
})

ba.logs.AddTerm('PickupCheck', '#(#) picked up a check from #(#) for $# (New wallet: $#)', {
	'Name',
	'SteamID',
	'Giver Name',
	'Giver SteamID'
})

ba.logs.AddTerm('VoideCheck', '#(#) voided their check to #(#) for $# (New wallet: $#)', {
	'Name',
	'SteamID',
	'Target Name',
	'Target SteamID'
})

ba.logs.AddTerm('BuyItem', '#(#) bought # for $# (New wallet: $#)', {
	'Name',
	'SteamID',
})

ba.logs.Create 'Деньги'
	:Hook('PlayerDropRPMoney', function(self, pl, amt, newcash)
		self:PlayerLog(pl, term('DropMoney'), pl:Name().."("..pl:RPName(true)..")".."("..pl:GetJobName()..")", pl:SteamID(), amt, newcash)
	end)
	:Hook('PlayerPickupRPMoney', function(self, pl, amt, newcash)
		self:PlayerLog(pl, term('PickupMoney'), pl:Name().."("..pl:RPName(true)..")".."("..pl:GetJobName()..")", pl:SteamID(), amt, newcash)
	end)
	:Hook('PlayerDropRPCheck', function(self, pl, topl, amt, newcash)
		self:PlayerLog(pl, term('DropCheck'), pl:Name().."("..pl:RPName(true)..")".."("..pl:GetJobName()..")", pl:SteamID(), topl:Name().."("..pl:RPName(true)..")".."("..pl:GetJobName()..")", topl:SteamID(), amt, newcash)
	end)
	:Hook('PlayerPickupRPCheck', function(self, pl, frompl, amt, newcash)
		self:PlayerLog(pl, term('PickupCheck'), pl:Name().."("..pl:RPName(true)..")".."("..pl:GetJobName()..")", pl:SteamID(), frompl:Name().."("..pl:RPName(true)..")".."("..pl:GetJobName()..")", frompl:SteamID(), amt, newcash)
	end)
	:Hook('PlayerVoidedRPCheck', function(self, pl, topl, amt, newcash)
		self:PlayerLog(pl, term('VoideCheck'), pl:Name().."("..pl:RPName(true)..")".."("..pl:GetJobName()..")", pl:SteamID(), topl:Name().."("..pl:RPName(true)..")".."("..pl:GetJobName()..")", topl:SteamID(), amt, newcash)
	end)
	:Hook('PlayerBoughtItem', function(self, pl, item, amt, newcash)
		self:PlayerLog(pl, term('BuyItem'), pl:Name().."("..pl:RPName(true)..")".."("..pl:GetJobName()..")", pl:SteamID(), item, amt, newcash)
	end)

--Inventory

ba.logs.AddTerm('Pickup', '#(#) подобрал #(#)', {
	'Player Name',
	'Player SteamID',
	'Item Class',
	'Item Type',
})

ba.logs.AddTerm('AddItem', '#(#) подобрал #(#), количетсво: #', {
	'Player Name',
	'Player SteamID',
	'Item Class',
	'Item Type',
	'Count',
})

ba.logs.AddTerm('AddItemT', '#(#) положил в хранилище #(#), количетсво: #', {
	'Player Name',
	'Player SteamID',
	'Item Class',
	'Item Type',
	'Count',
})

ba.logs.AddTerm('RemoveItem', '#(#) выбросил #(#), количетсво: #', {
	'Player Name',
	'Player SteamID',
	'Item Class',
	'Item Type',
	'Count',
})

ba.logs.AddTerm('RemoveItemT', '#(#) забрал из хранилища #(#), количетсво: #', {
	'Player Name',
	'Player SteamID',
	'Item Class',
	'Item Type',
	'Count',
})

ba.logs.Create 'Инвентарь'
	:SetColor(Color(200,0,0))
	:Hook('rp.inv.Pickup', function(self, pl, type, class, count)
		self:PlayerLog(pl, term('Pickup'), pl:Name().."("..pl:RPName(true)..")".."("..pl:GetJobName()..")", pl:SteamID(), class, type, count)
	end)
	:Hook('rp.inv.AddItem', function(self, pl, type, class, count)
		self:PlayerLog(pl, term('AddItem'), pl:Name().."("..pl:RPName(true)..")".."("..pl:GetJobName()..")", pl:SteamID(), class, type, count)
	end)
	:Hook('rp.inv.DropItem', function(self, pl, type, class, count)
		self:PlayerLog(pl, term('RemoveItem'), pl:Name().."("..pl:RPName(true)..")".."("..pl:GetJobName()..")", pl:SteamID(), class, type, count)
	end)
	:Hook('rp.inv.AddItemT', function(self, pl, type, class, count)
		self:PlayerLog(pl, term('AddItemT'), pl:Name().."("..pl:RPName(true)..")".."("..pl:GetJobName()..")", pl:SteamID(), class, type, count)
	end)
	:Hook('rp.inv.DropItemT', function(self, pl, type, class, count)
		self:PlayerLog(pl, term('RemoveItemT'), pl:Name().."("..pl:RPName(true)..")".."("..pl:GetJobName()..")", pl:SteamID(), class, type, count)
	end)

-- RP
ba.logs.AddTerm('ChangeName', '#(#) changed their RP name to "#"', {
	'Name',
	'SteamID',
})

ba.logs.AddTerm('DemotePlayer', '#(#) has started a demotion vote on #(#) for "#"', {
	'Demoter Name',
	'Demoter SteamID',
	'Name',
	'SteamID',
})

ba.logs.AddTerm('Disguise', '#(#) замаскировался в # , настоящая профессия: #', {
	'Name',
	'SteamID',
})

ba.logs.AddTerm('Chnage', '#(#) изменил свою работу на #, предыдущая профессия: #', {
	'Name',
	'SteamID',
})

ba.logs.AddTerm('HirePlayer', '#(#) has hired #(#)', {
	'Name',
	'SteamID',
	'Employee Name',
	'Employee SteamID',
})

ba.logs.AddTerm('Bailed', '#(#) has bailed #(#) for $#', {
	'Name',
	'SteamID',
	'Target Name',
	'Target SteamID',
})

ba.logs.Create 'Roleplay'
	:SetColor(Color(100,50,20))
	:Hook('playerChangedRPName', function(self, pl, newname)
		self:PlayerLog(pl, term('ChangeName'), pl:Name().."("..pl:RPName(true)..")".."("..pl:GetJobName()..")", pl:SteamID(), newname)
	end)
	:Hook('playerDemotePlayer', function(self,  pl, target, reason)
		self:PlayerLog({pl, target}, term('DemotePlayer'), pl:Name().."("..pl:RPName(true)..")".."("..pl:GetJobName()..")", pl:SteamID(), target:Name(), target:SteamID(), reason)
	end)
	:Hook('playerDisguised', function(self, pl, oldt, newt)
		self:PlayerLog(pl, term('Disguise'), pl:Name().."("..pl:RPName(true)..")".."("..pl:GetJobName()..")", pl:SteamID(), team.GetName(newt), team.GetName(oldt))
	end)
	:Hook('OnPlayerChangedTeam', function(self, pl, oldt, newt)
		self:PlayerLog(pl, term('Chnage'), pl:Name().."("..pl:RPName(true)..")".."("..pl:GetJobName()..")", pl:SteamID(), team.GetName(newt), team.GetName(oldt))
	end)
	:Hook('PlayerHirePlayer', function(self, employer, employee)
		self:PlayerLog({employer, employer}, term('HirePlayer'), employer:Name(), employer:SteamID(), employee:Name(), employee:SteamID())
	end)
	:Hook('PlayerBailPlayer', function(self, pl, targ, cost)
		self:PlayerLog({pl, targ}, term('Bailed'), pl:Name().."("..pl:RPName(true)..")".."("..pl:GetJobName()..")", pl:SteamID(), targ:Name(), targ:SteamID(), cost)
	end)


-- NLR
ba.logs.AddTerm('EnterNLR', '#(#) зашел в нлр зону # секунд спустя', {
	'Name',
	'SteamID',
})

ba.logs.AddTerm('ExitNLR', '#(#) покинул нлр зону # секунд спустя', {
	'Name',
	'SteamID',
})


ba.logs.Create 'NLR'
	:SetColor(Color(255,100,0))
	:Hook('PlayerEnterNLRZone', function(self, pl, time)
		self:PlayerLog(pl, term('EnterNLR'), pl:Name().."("..pl:RPName(true)..")".."("..pl:GetJobName()..")", pl:SteamID(), math.Round(time, 0))
	end)
	:Hook('PlayerLeaveNLRZone', function(self, pl, time)
		self:PlayerLog(pl, term('ExitNLR'), pl:Name().."("..pl:RPName(true)..")".."("..pl:GetJobName()..")", pl:SteamID(), math.Round(time, 0))
	end)



-- Cuffs
ba.logs.AddTerm('OnHandcuffed', '#(#) заковал в наручники #(#)', {
	'Name',
	'SteamID',
	'Name2',
	'SteamID2',
})

ba.logs.AddTerm('OnHandcuffBreak', '#(#) вырвался из наручников #(#)', {
	'Name',
	'SteamID',
	'Name2',
	'SteamID2',	
})

ba.logs.AddTerm('OnHandcuffBreak2', '#(#) вырвался из наручников', {
	'Name',
	'SteamID',
})


ba.logs.Create 'Наручники'
	:SetColor(Color(255,100,0))
	:Hook('OnHandcuffed', function(self, cuffer,cuffed)
		self:PlayerLog(cuffer, term('OnHandcuffed'), cuffer:Name().."("..cuffer:RPName(true)..")".."("..cuffer:GetJobName()..")", cuffer:SteamID(), cuffed:Name().."("..cuffed:RPName(true)..")".."("..cuffed:GetJobName()..")", cuffed:SteamID())
	end)
	:Hook('OnHandcuffBreak', function(self, cuffed,_,mate)
		if (IsValid(mate)) then
			self:PlayerLog(cuffed, term('OnHandcuffBreak'), cuffed:Name().."("..cuffed:RPName(true)..")".."("..cuffed:GetJobName()..")", cuffed:SteamID(), mate:Name().."("..mate:RPName(true)..")".."("..mate:GetJobName()..")", mate:SteamID())
		else
			self:PlayerLog(cuffed, term('OnHandcuffBreak2'), cuffed:Name().."("..cuffed:RPName(true)..")".."("..cuffed:GetJobName()..")", cuffed:SteamID())
		end
	end)