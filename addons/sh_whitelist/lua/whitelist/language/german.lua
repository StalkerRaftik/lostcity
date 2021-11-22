return {
	-- Common
	player = "Spieler",
	name = "Name",
	jobs = "Jobs",
	job_name = "Jobname",
	events = "Events",
	all = "All",
	allow = "Erlauben",
	usergroup = "Benutzergruppe",
	go_back = "Zurückgehen"

	-- General
	whitelist = "Whitelist",
	select_a_player = "Wähle einen Spieler aus",
	job_category = "Jobkategorie",
	all_jobs_in_category = "Alle Jobs in der Kategorie",
	toggle_selected = "Umschalten (%d)",
	manage_whitelist_options = "Verwalte Whitelistoptionen",
	jobs_in_category = "Jobs in der Kategorie",
	whitelist_jobs_for_steamid = "Genehmigte Jobs für SteamID",
	whitelist_jobs_for_usergroup = "Genehmigte Jobs für Spielerkategorie",
	view_saved_whitelists = "Gespeicherte Whitelists ansehen",
	delete_empty_entries = "Leere Einträge löschen",

	-- Tooltips
	steamid_tooltip = "Geben Sie eine SteamID/SteamID64 ein für die Sie Jobs genehmigen möchten.",
	usergroup_tooltip = "Geben Sie den Namen einer Benutzergruppe ein für die Sie Jobs genehmigen möchten.",
	saved_tooltip = "Erlaubt Ihnen die genehmigten SteamIDs und Benutzergruppen in der Datenbank zu sehen.",
	allow_tooltip = "Soll diese(r) Spieler/SteamID/Benutzergruppe die Erlaubnis haben, diesen Job zu benutzen?",
	delete_tooltip = "Dieser Vorgang löscht alle nutzlosen Einträge in der Datenbank welche keine genehmigten Jobs haben.",

	-- Messages
	now_whitelisted_for_x = "Sie haben jetzt Zugang zu: %s",
	no_longer_whitelisted_for_x = "Sie haben keinen Zugang mehr zu: %s",
	no_permission = "Sie haben nicht die Rechte dies zu tun.",
	invalid_steamid = "Ungültige SteamID.",
	no_whitelistable_jobs = "Keine Jobs zum Genehmigen gefunden. Bitte richten Sie welche in whitelist_config.lua ein.",
    not_whitelisted_for_job = "Sie haben keine Genehmigung für diesen Job.",
    this_usergroup_cant_be_whitelisted = "Diese Benutzergruppe kann nicht genehmigt werden.",
	booted_from_job_unwhitelisted = "Sie wurden von %s entfernt da sie keine Genehmigung mehr haben.",
	database_optimized = "Datenbank optimiert!",
	already_chosen_faction = "Sie haben bereits eine Fraktion ausgewählt!",

	-- Logs
	x_changed_whitelist_for_y = "%s änderte den Whiteliststatus von %s (%s)",
	x_joined_faction_y = "%s joined faction %s",

	-- Factions
	choose_your_faction = "Bitte wählen sie Ihre Fraktion",
}