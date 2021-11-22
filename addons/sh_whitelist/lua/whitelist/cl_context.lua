-- local easynet = SH_WHITELIST.easynet
-- local function L(...) return SH_WHITELIST:L(...) end

-- properties.Add("sh_whitelist", {
-- 	MenuLabel = "SH Whitelist",
-- 	Order = 999,
-- 	MenuIcon = "icon16/shield.png",

-- 	Filter = function(self, ent, ply)
-- 		if (!IsValid(ent)) then return false end
-- 		if (!ent:IsPlayer()) then return false end
-- 		if (!SH_WHITELIST:CanWhitelist(LocalPlayer())) then return false end

-- 		return true
-- 	end,

-- 	Action = function(self, ent)
-- 		SH_WHITELIST:OpenMenu(ent)
-- 	end,
-- 	MenuOpen = function(data, option, ent, tr)
-- 		option.m_SteamID = ent:SteamID()
-- 		easynet.SendToServer("SH_WHITELIST.ReqWhitelistPlayer", {target = ent})
-- 	end,
-- 	OnCreate = function(self, menu, option)
-- 		menu:AddSpacer()
-- 		local sub = menu:AddSubMenu(L"jobs")

-- 		local opts = {}
-- 		for _, job in pairs (RPExtraTeams) do
-- 			if (SH_WHITELIST:IsWhitelistJob(job) and SH_WHITELIST:CanWhitelist(LocalPlayer(), job.name)) then
-- 				local opt = sub:AddOption(job.name)
-- 				opt:SetIsCheckable(true)
-- 				opt.OnChecked = function(me, b)
-- 					easynet.SendToServer("SH_WHITELIST.WhitelistSteamID", {steamid = option.m_SteamID, jobs = {job.name}, whitelisted = {b}}) -- 76561198059738127
-- 				end
-- 				opt.OnMouseReleased = function(me, mc)
-- 					DButton.OnMouseReleased(me, mc)
-- 					me.m_MenuClicking = false
-- 				end
-- 				table.insert(opts, opt)
-- 			end
-- 		end

-- 		SH_WHITELIST:AddPanelHook("OnPlayerWhitelistReceived", option, function(me, jobs)
-- 			for _, opt in pairs (opts) do
-- 				if (IsValid(opt)) then
-- 					opt:SetChecked(table.HasValue(jobs, opt:GetText()))
-- 				end
-- 			end
-- 		end)
-- 	end,
-- 	Receive = function(self, length, player)
-- 	end
-- })