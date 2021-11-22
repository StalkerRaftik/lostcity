/**
* ОСНОВНЫЕ НАСТРОЙКИ
**/

-- КТО МОЖЕТ ВЫДАВАТЬ ПРОФЕССИИ И КАКИЕ ИМЕННО----
-- Пример:
-- ["Тот кто может выдавать вайтлист"] = {
-- 	"на эту профессию",
-- 	"и на эту",
-- 	"на эту тоже может :)",
-- 	"Сотрудник ППС",
-- },
SH_WHITELIST.WhitelistingJobs = {
	-- ["Шериф “Asheville”"] = {
	-- 	"Лейтенант Департамента",
	-- 	"Сержант Департамента",
	-- 	"Парамедик",
	-- 	"Сотрудник ППС",
	-- },
	-- ["Лейтенант Департамента”"] = {
	-- 	"Сержант Департамента",
	-- 	"Парамедик",
	-- 	"Сотрудник ППС",
	-- },	
	-- ["Биг 'Эйшви'”"] = {
	-- 	"Новитто",
	-- 	"Верфигандо",
	-- 	"Бандито",
	-- },	
	-- ["Глава поместья 'Блэйк'"] = {
	-- 	"Сторож 'Блэйк'",
	-- 	"Фермер 'Блэйк'",
	-- 	"Повар 'Блэйк'",
	-- 	"Боец 'Блэйк'",
	-- 	"Лекарь 'Блэйк'",	
	-- 	"Смотритель 'Блэйк'",				
	-- },		
	-- ["Смотритель 'Блэйк'"] = {
	-- 	"Сторож 'Блэйк'",
	-- 	"Фермер 'Блэйк'",
	-- 	"Повар 'Блэйк'",
	-- 	"Боец 'Блэйк'",
	-- 	"Лекарь 'Блэйк'",					
	-- },		
	-- ["Лидер 'Легиона'"] = {
	-- 	"Адепт",
	-- 	"Стрелок 'Легиона'",
	-- 	"Ночной охотник",				
	-- },	
}

// Автоматизация таблицы вайтлиста по jobs.cfg
hook.Add("OnGamemodeLoaded", "LoadWhitelistFromGamemode", function()
	local idsTbl = {}
	for jobId, jobTable in pairs(rp.teams) do
		if jobTable.leader == true or jobTable.subleader == true then
			SH_WHITELIST.WhitelistingJobs[jobTable.name] = {}
			idsTbl[jobTable.name] = jobId
		end
	end	

	for whitelister, whitelist in pairs(SH_WHITELIST.WhitelistingJobs) do
		local whitelisterTable = rp.teams[idsTbl[whitelister]]
		for jobId, jobTable in pairs(rp.teams) do
			if jobTable.category == whitelisterTable.category then
				if jobTable.leader == true 
				or (jobTable.subleader == true and not whitelisterTable.leader == true) 
				or jobTable.donatejob == true then continue end
				table.insert(whitelist, jobTable.name)
			end
		end
	end
end)


-- То же самое, что выше, но тут указывается ранг, который может выдавать
SH_WHITELIST.WhitelistingUsergroups = {
	-- ["vip_gold"] = {
		-- "7th Company Engineer",
		-- "7th Company Medic",
		-- "7th Company Rifleman",
		-- "7th Company Radio",
	-- },
}

-- Профессии которые будут в вайтлисте
-- Доступные идентификаторы:
-- ИМЕНА. Например: Грузчик	-> Сделает вайтлист напрямую для профессии с названием Грузчик
-- ЦВЕТА. Например: 255 0 0			-> Сделает вайтлист для работ с цветом 255 0 0 (лучше не использовать)
-- КАТЕГОРИЯ. Например: Полицейский департамент		-> Сделает вайтлист для всей категории полиц департамента
SH_WHITELIST.WhitelistedJobs = {
	["Поместье “Блэйк” Округа “Asheville”"] = true,
	["Полицейский департамент “Asheville”"] = true,
	["Бандиты города “Ashville”"] = true,
	["Легион"] = true,
}



---------- ЕСЛИ ВЫ НЕ ПРОГРАММИСТ ИЛИ НЕ ЗНАЕТЕ АНГЛИЙСКИЙ - ДАЛЬШЕ НЕ ТРОГАЙТЕ ----------------------------------








-- Usergroups allowed to administrate the whitelist.
-- They are automatically whitelisted for all jobs if the AdminsBypass option is set to true.
SH_WHITELIST.Usergroups = {
	["sudoroot"] = true,
	["globaladmin"] = true,
	["root"] = true,
	["globalmanager"] = true,
	["rpcuratorleader"] = true,
	["rpcurator"] = true,
}

-- Can non-admins whitelist offline players or usergroups?
SH_WHITELIST.NonAdminsCanWhitelistAll = true

-- Can non-admins whitelist usergroups?
SH_WHITELIST.NonAdminsCanWhitelistUsergroups = false

-- Should admin usergroups (defined above) be automatically whitelisted for all jobs?
SH_WHITELIST.AdminsBypass = true

-- Should players be notified when they are (un)whitelisted for a job?
SH_WHITELIST.NotifyWhitelist = true

-- Should players be booted from their job if they are unwhitelisted from it?
-- They will be switched to GAMEMODE.DefaultTeam, which can be configured in the jobs file.
SH_WHITELIST.UnwhitelistBoot = true

-- Should whitelist changes be logged and printed using ServerLog?
SH_WHITELIST.UseServerLog = true

-- Use libgmodstore?
-- This library is intended to help provide information about updates and support should you run into issues.
-- DISCLAIMER: libgmodstore is NOT maintained by me (Shendow), I am NOT responsible if it causes errors or other issues.
--			   If it does, then disable the option below. You don't need it for the script to work - it only makes life easier.
-- More information here: https://www.gmodstore.com/community/threads/4465-libgmodstore/post-31807#post-3180776561198059738127
SH_WHITELIST.UseLibGModStore = false

-- Use Steam Workshop for the custom content?
-- If false, custom content will be downloaded through FastDL.
SH_WHITELIST.UseWorkshop = true

/**
* Jobs to whitelist configuration
**/



-- Should jobs requiring a vote also require to be whitelisted?
SH_WHITELIST.WhitelistVotes = true

/**
* Command configuration
**/

-- Chat commands which can open the Whitelist menu
-- ! are automatically replaced by / and inputs are made lowercase for convenience.
SH_WHITELIST.MenuCommands = {
	["/wl"] = true,
	["/whitelist"] = true,
	["/whitelists"] = true,
	["!wl"] = true,
	["!whitelist"] = true,
	["!whitelists"] = true,
}

/**
* Advanced configuration
* Edit at your own risk!
**/

SH_WHITELIST.ImageDownloadFolder = "sh_whitelist"

/**
* Theme configuration
**/

-- Width multiplier of the Whitelist window.
SH_WHITELIST.WidthMultiplier = 1.1

-- Height multiplier of the Whitelist window.
SH_WHITELIST.HeightMultiplier = 1.1

-- Font to use for normal text throughout the interface.
SH_WHITELIST.Font = "Circular Std Medium"

-- Font to use for bold text throughout the interface.
SH_WHITELIST.FontBold = "Circular Std Bold"

-- Color sheet. Only modify if you know what you're doing.
SH_WHITELIST.Style = {
	header = Color(150,150,150),
	bg = Color(0,0,0,230),
	inbg = Color(0,0,0,0),

	close_hover = Color(231, 76, 60, 255),
	hover = Color(255, 255, 255, 10, 255),
	hover2 = Color(255, 255, 255, 5, 255),

	text = Color(255, 255, 255, 255),
	text_down = Color(0, 0, 0),
	textentry = Color(44, 62, 80),
	menu = Color(127, 140, 141),

	success = Color(46, 204, 113),
	failure = Color(231, 76, 60),
}

/**
* Language configuration
**/

-- Various strings used throughout the script.
-- Available languages: english, french, german, spanish
-- To add your own language, see the reports/language folder
-- You may need to restart the map after changing the language!
SH_WHITELIST.LanguageName = "english"