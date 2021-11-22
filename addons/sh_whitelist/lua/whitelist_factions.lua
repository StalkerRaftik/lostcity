/**
* Factions configuration
*
* What are factions?
* Factions allow you to let players choose a side with preset jobs when joining your server.
**/

-- Enable factions?
SH_WHITELIST.FactionsEnable = false

-- When should the Faction menu appear?
-- 0: Once, when the player joins for the first time, menu cannot be closed
-- 1: Every join, menu cannot be closed if first time
-- 2: Every spawn, menu cannot be closed if first time
SH_WHITELIST.FactionsFrequency = 0

-- Chat commands for the Faction Menu.
-- ! are automatically replaced by / and inputs are made lowercase for convenience.
SH_WHITELIST.FactionsCommands = {
	["/fc"] = true,
	["/fct"] = true,
	["/faction"] = true,
}

-- Can players change their faction once they've chosen one?
-- Return false to disallow, true to allow.
-- You can check for usergroups and other stuff here.
SH_WHITELIST.FactionsCanChange = function(ply)
	return true
end

-- Should players be unwhitelisted from other factions if they change factions?
SH_WHITELIST.FactionsUnwhitelistRest = true

-- How should the list of factions be displayed?
-- 0: Horizontal list (suitable for few factions)
-- 1: Vertical list (better for numerous factions)
SH_WHITELIST.FactionsLayout = 0

-- Should the background be blurred when the faction menu is open?
SH_WHITELIST.FactionsBackgroundBlur = true

-- Your list of factions!
-- They appear in the order you define them in the table.
SH_WHITELIST.FactionsList = {
	{
		-- The name of your faction.
		Name = "Allies",

		-- The description of your faction, displayed besides the name.
		Description = "The Allies are the good guys and they represent freedom and other good stuff.",

		-- The color of the faction's name in the menu.
		Color = Color(255, 255, 255),

		-- The external URL to your faction's icon. Should be 256x256 ideally.
		IconURL = "https://i.imgur.com/hc1jicM.png",

		-- The list of jobs a player gets whitelisted for by joining this faction.
		-- This list can NOT be empty! Otherwise, the player's data will never get saved, which is required!
		Jobs = {
			"Allied Officer",
			"Allied Sniper",
			"Allied Rifleman",
			"Allied MG",
			"Allied Sapper",
		},

		-- The job the player gets automatically by joining this faction.
		-- Set to blank for no change.
		DefaultJob = "Allied Rifleman",

		-- Chat message to display when joining this faction.
		JoinMessage = "Welcome to the Allied Army! It's time to liberate the rest of Europe!",

		-- Chat message to display to EVERYONE when a player joins this faction.
		-- {player} is replaced by the player's name.
		GlobalJoinMessage = "{player} has joined the Allies!",

		-- Function which determines whether the player can join this faction.
		-- Return false to disallow, true to allow.
		-- You can check for usergroups and other stuff here.
		CanJoin = function(self, ply)
			return true
		end
	},
	{
		Name = "Wehrmacht",
		Description = "The Wehrmacht is an unstoppable war machine with weapons that probably hurt a lot.",
		Color = Color(255, 255, 255),
		IconURL = "https://i.imgur.com/Q2ytCcw.png",
		Jobs = {
			"Wehrmacht Officer",
			"Wehrmacht Sniper",
			"Wehrmacht Rifleman",
			"Wehrmacht MG",
			"Wehrmacht Sapper",
		},
		DefaultJob = "Wehrmacht Rifleman",
		JoinMessage = "Welcome to the Wehrmacht! It's time to push the Allies back!",
		GlobalJoinMessage = "{player} has joined the Wehrmacht!",
		CanJoin = function(self, ply)
			return true
		end
	},
}