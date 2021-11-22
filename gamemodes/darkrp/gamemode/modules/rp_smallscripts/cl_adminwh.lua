local next = next
local math = math
local draw = draw
local surface = surface
local string = string
local table = table
local player = player
local Vector = Vector
local LocalPlayer = LocalPlayer
local Color = Color
local PLAYER = FindMetaTable("Player")

AdminEsp = {}
AdminEsp.Drawables = {}
local AdminEsp = _G.AdminEsp

AdminEsp.Enabled = CreateClientConVar("AdminEsp_enabled", "0", true, false)
AdminEsp.Compact = CreateClientConVar("AdminEsp_compact", "0", true, false)
AdminEsp.PixVis = CreateClientConVar("AdminEsp_pixvis", "1", true, false)
AdminEsp.Spec = CreateClientConVar("AdminEsp_spectators", "0", true, false)
AdminEsp.Ents = CreateClientConVar("AdminEsp_ents", "0", true, false)
AdminEsp.Players = CreateClientConVar("AdminEsp_players", "1", true, false)
AdminEsp.Limit = CreateClientConVar("AdminEsp_limit", "0", true, false)
AdminEsp.IntEnabled = AdminEsp.IntEnabled or false --aha

local empty = {}

AdminEsp.Profiles = {
	player = function(e)
		if e == LocalPlayer() then return end
		if AdminEsp.Spec:GetBool() == false and e:Team() == TEAM_SPECTATOR then return end

		if not e.AdminEsp_PixVis then
			e.AdminEsp_PixVis = util.GetPixelVisibleHandle()
		end

		return {
			ent = e,
			name = e:RPName(true),
			color = team.GetColor(e:Team()),
			info = not AdminEsp.Compact:GetBool() and {
				"Здоровье: " .. e:Health(),
				(e:Armor() > 0 and "Броня: " .. e:Armor()) or nil,
				"Дистанция: " .. math.floor(e:GetPos():Distance(LocalPlayer():GetPos())),
			
				--[[
				(e.DarkRPVars and
					(
						(e.DarkRPVars.money and e.DarkRPVars.salary and e.DarkRPVars.salary > 0
							and Format("Money: %s (+%d)",string.Comma(e.DarkRPVars.money),e.DarkRPVars.salary) 
						)
							or
						(e.DarkRPVars.money and "Money: " .. string.Comma(e.DarkRPVars.money))
					)
				) or nil,
				]]
			} or empty,
		}
	end,

	["money_printer*"] = function(e)
		if not e.AdminEsp_PixVis then
			e.AdminEsp_PixVis = util.GetPixelVisibleHandle()
		end

		return {
			ent = e,
			color = Color(255, 0, 0),
			info = empty
		}
	end,

	["spawned_*"] = "money_printer*",

	ttt_c4 = KARMA and function(e)
		local t = math.max(0, e:GetExplodeTime() - CurTime())
		--AdminEsp.DrawInfo(e,{},"Bomb",Color(255,0,0),t)
		return {
			ent = e,
			name = "Bomb",
			info = empty,
			color = Color(255, 0, 0),
			lbl = t,
		}
	end or nil,

	prop_ragdoll = KARMA and function(e)
		if CORPSE then
			if not e.AdminEsp_PixVis then
				e.AdminEsp_PixVis = util.GetPixelVisibleHandle()
			end

			if e.NoTarget then
				return
			end

			local pl = CORPSE.GetPlayerNick(e,false)
			local found = CORPSE.GetFound(e, false)

			return {
				ent = e,
				name = found and pl or "Unknown body",
				color = found and Color(128, 0, 0) or Color(255,128,0),
				info = empty,
			}
		end
	end or nil,
}

for c, f in pairs(AdminEsp.Profiles) do
	if isstring(f) then
		AdminEsp.Profiles[c] = AdminEsp.Profiles[f]
	end
end

function AdminEsp.DrawInfo(e, info, name, col, lbl)
	local wpos

	if e:LookupAttachment("eyes") ~= 0 then
		wpos = (e:GetAttachment(e:LookupAttachment("eyes")).Pos + Vector(0,0,5))
	else
		wpos = e:GetPos()
	end

	local pos = wpos:ToScreen()
	pos.x = math.floor(pos.x)
	pos.y = math.floor(pos.y)

	if not pos.visible then return end

	if AdminEsp.PixVis:GetBool() and e.AdminEsp_PixVis then
		local visibility = util.PixelVisible(wpos, 4, e.AdminEsp_PixVis)

		surface.SetAlphaMultiplier(math.max(0.2, visibility))
	end

	surface.SetFont "DermaDefault"
	local w,h = surface.GetTextSize(name or (e:IsPlayer() and e:Name()) or e:GetClass())
	local infoheight = #info * h

	if e:IsPlayer() and e:GetFriendStatus() == "friend" then
		draw.SimpleText("[F]","DermaDefault",pos.x-h,pos.y - infoheight - h - 1,Color(255,255,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
	end
	draw.RoundedBox(
		4, pos.x, pos.y - infoheight - h - 1, w + 7, h + 1,
		col or (e:IsPlayer() and team.GetColor(e:Team())) or Color(128,128,128)
	)
	draw.SimpleText(
		name or (e:IsPlayer() and e:Name()) or e:GetClass(),"DermaDefault",
		pos.x + 5,pos.y - infoheight - h, color_black, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	draw.SimpleText(
		name or (e:IsPlayer() and e:Name()) or e:GetClass(),"DermaDefault",
		pos.x + 4,pos.y - infoheight - h - 1, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP
	)

	if lbl or e:IsPlayer() then
		draw.SimpleText(
			"— " .. (lbl or (e:IsPlayer() and team.GetName(e:Team()))),"DermaDefault",
			pos.x + 10 + w, pos.y - infoheight - h, color_black, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP
		)
		draw.SimpleText(
			"— " .. (lbl or (e:IsPlayer() and team.GetName(e:Team()))),"DermaDefault",
			pos.x + 9 + w, pos.y - infoheight - h - 1, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP
		)
	end

	local i = 0

	for k, v in pairs(info) do
		i = i + 1 -- because using k will mess it up
		local ew,eh = surface.GetTextSize(v)
		surface.SetDrawColor(0, 0, 0, 128)
		surface.DrawRect(pos.x, pos.y - infoheight + (i - 1) * (h + 1), ew, eh + 1)
		draw.SimpleText(v, "DermaDefault", pos.x, pos.y + 1 - infoheight + (i-1) * (h + 1), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	end

	surface.SetAlphaMultiplier(1)
end

hook.Add("Tick", "ESP", function()
	if AdminEsp.IntEnabled and AdminEsp.Enabled:GetBool() then
		for k in next, AdminEsp.Drawables do
			AdminEsp.Drawables[k] = nil
		end

		if not IsValid(LocalPlayer()) then
			return
		end

		if not LocalPlayer():IsSuperAdmin() then
			return
		end

		local pos = LocalPlayer():GetPos()

		if AdminEsp.Players:GetBool() then
			for k, e in pairs(player.GetAll()) do
				local ret = AdminEsp.Profiles.player(e)
				if ret then
					table.insert(AdminEsp.Drawables, ret)
				end
			end
		end

		if AdminEsp.Ents:GetBool() then
			for c, f in pairs(AdminEsp.Profiles) do
				if c == "player" then continue end

				for k, v in pairs(ents.FindByClass(c)) do
					local ret = f(v)
					if ret then
						table.insert(AdminEsp.Drawables, ret)
					end
				end
			end
		end

		table.sort(AdminEsp.Drawables, function(a, b) return a.ent:GetPos():Distance(pos) > b.ent:GetPos():Distance(pos) end)
	end
end)

local function dodraw(v)
	AdminEsp.DrawInfo(
		v.ent,
		v.info,
		v.name,
		(v.ent.IsTraitor and v.ent:IsTraitor() and Color(255, 0, 0))
			or
		(v.ent.IsDetective and v.ent:IsDetective() and Color(0, 0, 255))
			or
		v.color,
		v.lbl
	)
end

hook.Add("HUDPaint", "ESP", function()
	if AdminEsp.IntEnabled and AdminEsp.Enabled:GetBool() then
		local z = AdminEsp.Limit:GetInt()

		if z > 0 then
			local m = #AdminEsp.Drawables

			for k, v in pairs(AdminEsp.Drawables) do
				if (m - k) >= z then continue end

				if IsValid(v.ent) then
					dodraw(v)
				end
			end
		else
			for k, v in pairs(AdminEsp.Drawables) do
				if IsValid(v.ent) then
					dodraw(v)
				end
			end
		end
	end
end)

hook.Add("KeyPress", "AdminEsp_ShowItUp", function() -- AAAAAAAA LAAAAG CRAAAASH, ah nope
	AdminEsp.IntEnabled = true
	hook.Remove("KeyPress","AdminEsp_ShowItUp")
end)