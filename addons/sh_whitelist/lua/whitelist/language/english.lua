return {
	-- Common
	player = "Игрок",
	name = "Ник",
	jobs = "Работы",
	job_name = "Название работы",
	events = "Ивенты",
	all = "Все",
	allow = "Разрешено",
	usergroup = "ULX Группа",
	go_back = "Вернуться",

	-- General
	whitelist = "Белый лист",
	select_a_player = "Выбрать игрока",
	job_category = "Категория работ",
	all_jobs_in_category = "Все работы в категории",
	toggle_selected = "Включить выбранные (%d)",
	manage_whitelist_options = "Управлять настройками",
	jobs_in_category = "Работы в категории",
	whitelist_jobs_for_steamid = "Белый лист работ для SteamID",
	whitelist_jobs_for_usergroup = "Белый лист работ для ULX",
	view_saved_whitelists = "Найти пользователя",
	delete_empty_entries = "Удалить пустые записи",

	-- Tooltips
	steamid_tooltip = "Введите SteamID/SteamID64 в белый список вакансий для.",
	usergroup_tooltip = "Введите имя группы пользователей для включения заданий в белый список.",
	saved_tooltip = "Позволяет просматривать белый список SteamID и группы пользователей в базе данных.",
	allow_tooltip = "Должен ли этот игрок/SteamID/пользователь разрешите использовать эту работу?",
	delete_tooltip = "Это действие удаляет все бесполезные записи в базе данных, которые не имеют никаких белых списков заданий.",

	-- Messages
	now_whitelisted_for_x = "Теперь вы находитесь в белом списке для: %s",
	no_longer_whitelisted_for_x = "Вы больше не находитесь в белом списке для: %s",
	no_permission = "У вас нет разрешения на выполнение этого действия.",
	invalid_steamid = "Неизвестный SteamID.",
	no_whitelistable_jobs = "В белом списке вакансий не найдено. Пожалуйста, установите их в whitelist_config.lua",
	not_whitelisted_for_job = "Вы не попали в белый список для этой работы.",
	this_usergroup_cant_be_whitelisted = "Эта группа пользователей не может быть занесена в белый список.",
	booted_from_job_unwhitelisted = "Вы были загружены из %s, так как больше не находитесь в белом списке.",
	database_optimized = "Оптимизированная база данных!",
	already_chosen_faction = "Вы уже выбрали фракцию!",

	-- Logs
	x_changed_whitelist_for_y = "%s изменен статус белого списка %s (%s)",
	x_joined_faction_y = "%s присоединился к фракции %s",

	-- Factions
	choose_your_faction = "Пожалуйста, выберите свою фракцию",
}