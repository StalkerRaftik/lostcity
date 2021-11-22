-- Notifications
ba.include_dir 'core/util/notifications'
ba.include_sh 'terms_sh.lua'

-- Data
ba.include_sv 'data_sv.lua'

-- Util
ba.include_dir 'core/util'

-- Player
ba.include_sh 'player_sh.lua'

-- Ranks
ba.include_sh 'ranks/groups_sh.lua'
ba.include_sv 'ranks/groups_sv.lua'
ba.include_sh 'ranks/setup_sh.lua'

-- Commands
ba.include_sh 'commands/commands_sh.lua'
ba.include_sv 'commands/commands_sv.lua'
ba.include_sh 'commands/parser_sh.lua'

-- Bans
ba.include_sv 'bans_sv.lua'

-- UI
ba.include_cl 'ui/main_cl.lua'
ba.include_sh 'ui/main_sh.lua'

-- -- Logging
ba.include_sh 'logging/logs_sh.lua'
ba.include_sv 'logging/logs_sv.lua'
ba.include_cl 'logging/logs_cl.lua'

-- Modules
ba.include_sh 'module_loader.lua'

-- Plugins
ba.include_dir 'plugins'