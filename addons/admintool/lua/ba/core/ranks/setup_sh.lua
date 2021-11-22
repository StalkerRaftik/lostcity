-- НОВЫЕ РАНГИ ДЕЛАЕМ СВЕРХУ ПО ИНСТРУКЦИИ
-- ba.ranks.Create('Root', 17) После названия вводим ID ранга, важно, чтобы оно не повторялось и было по возрастанию ( рут 17, значит след. ранг 18 и т.п)
	-- :SetImmunity(10000) -- Здесь настраиваешь иммунитет относительно других рангов, просто если цифра будет больше чем у другого ранга, он не сможет на него команды выполнять
	-- :SetFlags('uma') -- тут флаги типа user, moderator, admin, superadmin, бери пример с других рангов
	-- :SetAdmin(true) -- ну это у всех админов

ba.ImmunityNeedToSetRanks = 7500
ba.FlagToHaveAllAccessToSpawnMenu = "S" -- Отсылается к файлам модуля Prop Protection + core_sv.lua(самого даркрп)

ba.ranks.Create('Root', 17)
	:SetImmunity(10000)
	:SetRoot(true)
	
ba.ranks.Create('Sudo Root', 16)
	:SetImmunity(10000)
	:SetRoot(true)

ba.ranks.Create('Global Admin', 15)
	:SetImmunity(9000)
	:SetFlags('umasgdcl')
	:SetGlobal(true)
	:SetSuperAdmin(true)


---------------------
------Вышка----------
---------------------

ba.ranks.Create('Global Manager', 14)
	:SetImmunity(8000)
	:SetFlags('umasdl')
	:SetAdmin(true)

ba.ranks.Create('Spy', 13)
	:SetImmunity(7900)
	:SetFlags('umal')
	:SetAdmin(true)

ba.ranks.Create('College Manager', 12)
	:SetImmunity(7900)
	:SetFlags('umasl')
	:SetAdmin(true)

ba.ranks.Create('Super Admin', 11)
	:SetImmunity(7500)
	:SetFlags('umasdl')
	:SetAdmin(true)

ba.ranks.Create('RP Curator Leader', 10)
	:SetImmunity(7500)
	:SetFlags('umasdl')
	:SetAdmin(true)

ba.ranks.Create('Warden', 9)
	:SetImmunity(7000)
	:SetFlags('uml')
	:SetAdmin(true)

-----------------------
--- Обычные работяги --
-----------------------

ba.ranks.Create('Admin 3 lvl', 8)
	:SetImmunity(6300)
	:SetFlags('umal')
	:SetAdmin(true)

ba.ranks.Create('Admin 2 lvl', 7)
	:SetImmunity(6200)
	:SetFlags('umal')
	:SetAdmin(true)

ba.ranks.Create('Admin 1 lvl', 6)
	:SetImmunity(6100)
	:SetFlags('umal')
	:SetAdmin(true)

ba.ranks.Create('RP Curator', 5)
	:SetImmunity(6100)
	:SetFlags('umasdl')
	:SetAdmin(true)

ba.ranks.Create('Admin Stajer', 4)
	:SetImmunity(6000)
	:SetFlags('uma')
	:SetAdmin(true)

ba.ranks.Create('Junior RP Curator', 3)
	:SetImmunity(6000)
	:SetFlags('umasl')
	:SetAdmin(true)

ba.ranks.Create('FractionLeader', 2)
	:SetImmunity(0)
	:SetFlags('ul')
	:SetVIP(true)

ba.ranks.Create('VIP', 2)
	:SetImmunity(0)
	:SetFlags('uv')
	:SetVIP(true)

ba.ranks.Create('User', 1)
	:SetImmunity(0)
	:SetFlags('u')