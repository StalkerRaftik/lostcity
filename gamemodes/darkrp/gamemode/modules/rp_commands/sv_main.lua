local colors = rp.chatcolors

-- /*---------------------------------------------------------
--  Shipments
--  ---------------------------------------------------------*/
-- local function DropWeapon(pl)
-- 	local ent = pl:GetActiveWeapon()
-- 	if not IsValid(ent) then
-- 		return 
-- 	end

-- 	local canDrop = hook.Call("CanDropWeapon", GAMEMODE, pl, ent)
-- 	if not canDrop then
-- 		rp.Notify(pl, NOTIFY_ERROR, rp.Term('CannotDropWeapon'))
-- 		return 
-- 	end

-- 	timer.Simple(1, function()
-- 		if IsValid(pl) and IsValid(ent) and ent:GetModel() then
-- 			pl:DropDRPWeapon(ent)
-- 		end
-- 	end)
-- end
-- rp.AddCommand("/drop", DropWeapon)

local function SetPrice(pl, args)
	if args == "" then
		return ""
	end

	local a = tonumber(args)
	if not a then
		return ""
	end

	local tr = util.TraceLine({	
		start = pl:EyePos(),
		endpos = pl:EyePos() + pl:GetAimVector() * 85,
		filter = pl
	})

	if not IsValid(tr.Entity) then rp.Notify(pl, NOTIFY_ERROR, rp.Term('LookAtEntity')) return "" end


	if IsValid(tr.Entity) and tr.Entity.MaxPrice and (tr.Entity.ItemOwner == pl) then
		tr.Entity:Setprice(math.Clamp(a, tr.Entity.MinPrice, tr.Entity.MaxPrice))
	else
		rp.Notify(pl, NOTIFY_ERROR, rp.Term('CannotSetPrice'))
	end

	return ""
end
rp.AddCommand("/price", SetPrice)
rp.AddCommand("/setprice", SetPrice)

local function ChangeKarma(ply, args)
	local info 
	if args == "" then
		rp.Notify(ply, NOTIFY_ERROR, rp.Term('InvalidArg'))
		return ""
	end

	local tableargs = string.Explode(" ", args)
	if #tableargs == 1 then
		rp.Notify(ply, NOTIFY_ERROR, 'Вы не указали количество законопослушности!')
		return ""
	end

	if ply:IsAdmin() then 
		if IsValid(rp.FindPlayer(tableargs[1])) then
			if tonumber(tableargs[2]) ~= nil then
				local ply2 = rp.FindPlayer(tableargs[1])
				ply2:AddKarma(tonumber(tableargs[2]))
				if tonumber(tableargs[2]) < 0 then
					info = 'понизили'
				else
					info = 'повысили'
				end
				rp.Notify(ply2, NOTIFY_ERROR, 'Вам ' .. info .. " законопослушность на " .. tableargs[2])
				rp.Notify(ply, NOTIFY_ERROR, 'Вы ' .. info .. " законопослушность на " .. tableargs[2])
			end
		end
	else
		rp.Notify(ply, NOTIFY_ERROR, 'Нет доступа! Ты не администратор!' )
	end
end

rp.AddCommand("/zakon", ChangeKarma)



-- local function BuyPistol(ply, args)
-- 	if args == "" then
-- 		rp.Notify(ply, NOTIFY_ERROR, rp.Term('InvalidArg'))
-- 		return ""
-- 	end
-- 	if ply:IsArrested() then
-- 		rp.Notify(ply, NOTIFY_ERROR, rp.Term('CannotPurchaseItem'))
-- 		return ""
-- 	end

-- 	local trace = {}
-- 	trace.start = ply:EyePos()
-- 	trace.endpos = trace.start + ply:GetAimVector() * 85
-- 	trace.filter = ply

-- 	local tr = util.TraceLine(trace)

-- 	local class = nil
-- 	local model = nil

-- 	local shipment
-- 	local price = 0
-- 	for k,v in pairs(rp.shipments) do
-- 		if v.seperate and string.lower(v.name) == string.lower(args) and GAMEMODE:CustomObjFitsMap(v) then
-- 			shipment = v
-- 			class = v.entity
-- 			model = v.model
-- 			price = v.pricesep
-- 			local canbuy = false

-- 			if tblEnt.allowed[ply:Team()] then
-- 				canbuy = true
-- 			end

-- 			if v.customCheck and not v.customCheck(ply) then
-- 				rp.Notify(ply, NOTIFY_ERROR, rp.Term(v.CustomCheckFailMsg) or rp.Term('CannotPurchaseItem'))
-- 				return ""
-- 			end

-- 			if not canbuy then
-- 				rp.Notify(ply, NOTIFY_ERROR, rp.Term('CannotPurchaseItem'))
-- 				return ""
-- 			end
-- 		end
-- 	end

-- 	if not class then
-- 		rp.Notify(ply, NOTIFY_ERROR, rp.Term('ItemUnavailable'))
-- 		return ""
-- 	end

-- 	if not ply:CanAfford(price) then
-- 		rp.Notify(ply, NOTIFY_ERROR, rp.Term('CannotAfford'))
-- 		return ""
-- 	end

-- 	local weapon = ents.Create("spawned_weapon")
-- 	weapon:SetModel(model)
-- 	weapon.weaponclass = class
-- 	weapon.ShareGravgun = true
-- 	weapon:SetPos(tr.HitPos)
-- 	weapon.ammoadd = weapons.Get(class) and weapons.Get(class).Primary.DefaultClip
-- 	weapon.nodupe = true
-- 	weapon:Spawn()

-- 	if shipment.onBought then
-- 		shipment.onBought(ply, shipment, weapon)
-- 	end
-- 	hook.Call("playerBoughtPistol", nil, ply, shipment, weapon)

-- 	if IsValid( weapon ) then
-- 		ply:AddMoney(-price)
-- 		rp.Notify(ply, NOTIFY_GREEN, rp.Term('RPItemBought'), args, rp.FormatMoney(price))
-- 	else
-- 		rp.Notify(ply, NOTIFY_ERROR, rp.Term('UnableToItem'))
-- 	end

-- 	return ""
-- end
-- rp.AddCommand("/buy", BuyPistol, 0.2)

-- local function BuyShipment(ply, args)
-- 	if args == "" then
-- 		rp.Notify(ply, NOTIFY_ERROR, rp.Term('InvalidArg'))
-- 		return ""
-- 	end

-- 	if ply.LastShipmentSpawn and ply.LastShipmentSpawn > (CurTime() - 1) then
-- 		rp.Notify(ply, NOTIFY_ERROR, rp.Term('ShipmentCooldown'))
-- 		return ""
-- 	end
-- 	ply.LastShipmentSpawn = CurTime()

-- 	local trace = {}
-- 	trace.start = ply:EyePos()
-- 	trace.endpos = trace.start + ply:GetAimVector() * 85
-- 	trace.filter = ply

-- 	local tr = util.TraceLine(trace)

-- 	if ply:IsArrested() then
-- 		rp.Notify(ply, NOTIFY_ERROR, rp.Term('CannotPurchaseItem'))
-- 		return ""
-- 	end

-- 	local found = false
-- 	local foundKey
-- 	for k,v in pairs(rp.shipments) do
-- 		if string.lower(args) == string.lower(v.name) and not v.noship and GAMEMODE:CustomObjFitsMap(v) then
-- 			found = v
-- 			foundKey = k
-- 			local canbecome = false
-- 			for a,b in pairs(v.allowed) do
-- 				if ply:Team() == b then
-- 					canbecome = true
-- 				end
-- 			end

-- 			if v.customCheck and not v.customCheck(ply) then
-- 				rp.Notify(ply, NOTIFY_ERROR, rp.Term(v.CustomCheckFailMsg) or rp.Term('CannotPurchaseItem'))
-- 				return ""
-- 			end

-- 			if not canbecome then
-- 				rp.Notify(ply, NOTIFY_ERROR, rp.Term('IncorrectJob'))
-- 				return ""
-- 			end
-- 		end
-- 	end
 
-- 	if not found then
-- 		rp.Notify(ply, NOTIFY_ERROR, rp.Term('ItemUnavailable'))
-- 		return ""
-- 	end

-- 	local cost = found.price

-- 	if not ply:CanAfford(cost) then
-- 		rp.Notify(ply, NOTIFY_ERROR, rp.Term('CannotAfford'))
-- 		return ""
-- 	end

-- 	local crate = ents.Create(found.shipmentClass or "spawned_shipment")
	
-- 	crate:SetPos(Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z))
-- 	crate:Spawn()
-- 	if found.shipmodel then
-- 		crate:SetModel(found.shipmodel)
-- 	end
-- 	crate:SetContents(foundKey, found.amount)

-- 	if rp.shipments[foundKey].onBought then
-- 		rp.shipments[foundKey].onBought(ply, rp.shipments[foundKey], weapon)
-- 	end
-- 	hook.Call("playerBoughtShipment", nil, ply, rp.shipments[foundKey], weapon)

-- 	if IsValid( crate ) then
-- 		ply:AddMoney(-cost)
-- 		rp.Notify(ply, NOTIFY_GREEN, rp.Term('RPItemBought'), args, rp.FormatMoney(cost))
		
-- 		hook.Call('PlayerBoughtItem', GAMEMODE, ply, rp.shipments[foundKey].name .. ' Shipment', cost, ply:GetMoney())
-- 	else
-- 		rp.Notify(ply, NOTIFY_ERROR, rp.Term('UnableToItem'))
-- 	end

-- 	return ""
-- end
-- rp.AddCommand("/buyshipment", BuyShipment)

-- local function BuyAmmo(ply, args)
-- 	if args == "" then
-- 		rp.Notify(ply, NOTIFY_ERROR, rp.Term('InvalidArg'))
-- 		return ""
-- 	end

-- 	if ply:IsArrested() then
-- 		rp.Notify(ply, NOTIFY_ERROR, rp.Term('CannotPurchaseItem'))
-- 		return ""
-- 	end

-- 	local found
-- 	for k,v in pairs(rp.ammoTypes) do
-- 		if v.ammoType == args then
-- 			found = v
-- 			break
-- 		end
-- 	end

-- 	if not found or (found.customCheck and not found.customCheck(ply)) then
-- 		rp.Notify(ply, NOTIFY_ERROR, found and rp.Term(found.CustomCheckFailMsg) or rp.Term('ItemUnavailable'))
-- 		return ""
-- 	end

-- 	if not ply:CanAfford(found.price) then
-- 		rp.Notify(ply, NOTIFY_ERROR, rp.Term('CannotAfford'))
-- 		return ""
-- 	end

-- 	rp.Notify(ply, NOTIFY_GREEN, rp.Term('RPItemBought'), found.name, rp.FormatMoney(found.price))
-- 	ply:AddMoney(-found.price)

-- 	ply:GiveAmmo(found.amountGiven, found.ammoType)

-- 	return ""
-- end
-- rp.AddCommand("/buyammo", BuyAmmo, 1)

-- local function BuyHealth(ply)
-- 	local cost = 500

-- 	if not ply:Alive() then
-- 		return ""
-- 	end
-- 	if not ply:CanAfford(cost) then
-- 		rp.Notify(ply, NOTIFY_ERROR, rp.Term('CannotAfford'))
-- 		return ""
-- 	end
-- 	if not rp.teams[ply:Team()] or not rp.teams[ply:Team()].medic then
-- 		local foundMedics = false
-- 		for k,v in pairs(rp.teams) do
-- 			if v.medic and team.NumPlayers(k) > 0 then
-- 				foundMedics = true
-- 				break
-- 			end
-- 		end
-- 		if foundMedics then
-- 			rp.Notify(ply, NOTIFY_ERROR, rp.Term('MedicExists'))
-- 			return ""
-- 		end
-- 	end
-- 	if ply.StartHealth and ply:Health() >= ply.StartHealth then
-- 		rp.Notify(ply, NOTIFY_ERROR, rp.Term('HealthIsFull'))
-- 		return ""
-- 	end
-- 		if ply.NextBuyHealth != nil && ply.NextBuyHealth >= CurTime() then
-- 			rp.Notify(ply, NOTIFY_ERROR, rp.Term('NeedToWait'), math.Round(ply.NextBuyHealth - CurTime(), 0))
-- 		return
-- 	end
-- 	ply.NextBuyHealth = CurTime() + 30
-- 	ply.StartHealth = ply.StartHealth or 100
-- 	ply:AddMoney(-cost)
-- 	rp.Notify(ply, NOTIFY_GREEN, rp.Term('RPItemBought'), 'health', rp.FormatMoney(cost))
-- 	ply:SetHealth(ply.StartHealth)
-- 	return ""
-- end
-- rp.AddCommand("/buyhealth", BuyHealth)

-- local function ChangeJob(ply, args)
-- 	if args == "" then
-- 		rp.Notify(ply, NOTIFY_ERROR, rp.Term('InvalidArg'))
-- 		return ""
-- 	end

-- 	if ply:IsArrested() then
-- 		rp.Notify(ply, NOTIFY_ERROR, rp.Term('CannotJob'))
-- 		return ""
-- 	end

-- 	if ply.LastJob and 10 - (CurTime() - ply.LastJob) >= 0 then
-- 		rp.Notify(ply, NOTIFY_ERROR, rp.Term('NeedToWait'), math.ceil(10 - (CurTime() - ply.LastJob)))
-- 		return ""
-- 	end
-- 	ply.LastJob = CurTime()

-- 	if not ply:Alive() then
-- 		rp.Notify(ply, NOTIFY_ERROR, rp.Term('CannotJob'))
-- 		return ""
-- 	end

-- 	local len = string.len(args)

-- 	if len < 3 then
-- 		rp.Notify(ply, NOTIFY_ERROR, rp.Term('JobLenShort'), 2)
-- 		return ""
-- 	end

-- 	if len > 25 then
-- 		rp.Notify(ply, NOTIFY_ERROR, rp.Term('JobLenLong'), 26)
-- 		return ""
-- 	end

-- 	local canChangeJob, message, replace = hook.Call("canChangeJob", nil, ply, args)
-- 	if canChangeJob == false then
-- 		rp.Notify(ply, NOTIFY_ERROR, rp.Term('CannotJob'))
-- 		return ""
-- 	end

-- 	local job = replace or args
-- 	--rp.NotifyAll(NOTIFY_GENERIC, rp.Term('ChangeJob'), ply, (string.match(job, '^h?[AaEeIiOoUu]') and 'an' or 'a'), job)

-- 	ply:SetNetVar('job', job) 
-- 	return ""
-- end
-- rp.AddCommand("/job", ChangeJob)

-- local function FinishDemote(vote, choice)
-- 	local target = vote.target

-- 	target.IsBeingDemoted = nil
-- 	if choice == 1 then
-- 		target:TeamBan()
-- 		if target:Alive() then
-- 			target:ChangeTeam(rp.DefaultTeam, true)
-- 		else
-- 			target.demotedWhileDead = true
-- 		end

-- 		rp.NotifyAll(NOTIFY_GENERIC, rp.Term('PlayerDemoted'), target)
-- 	else
-- 		rp.NotifyAll(NOTIFY_GENERIC, rp.Term('PlayerNotDemoted'), target)
-- 	end
-- end

-- local function Demote(ply, args)
-- 	local tableargs = string.Explode(" ", args)
-- 	if #tableargs == 1 then
-- 		rp.Notify(ply, NOTIFY_ERROR, rp.Term('DemotionReason'))
-- 		return ""
-- 	end
-- 	local reason = ""
-- 	for i = 2, #tableargs, 1 do
-- 		reason = reason .. " " .. tableargs[i]
-- 	end
-- 	reason = string.sub(reason, 2)
-- 	if string.len(reason) > 99 then
-- 		rp.Notify(ply, NOTIFY_ERROR, rp.Term('DemoteReasonLong'), 100)
-- 		return ""
-- 	end
-- 	local p = rp.FindPlayer(tableargs[1])
-- 	if p == ply then
-- 		rp.Notify(ply, NOTIFY_ERROR, rp.Term('DemoteSelf'))
-- 		return ""
-- 	end

-- 	local canDemote, message = hook.Call("CanDemote", GAMEMODE, ply, p, reason)
-- 	if canDemote == false then
-- 		rp.Notify(ply, NOTIFY_ERROR, rp.Term('UnableToDemote'))
-- 		return ""
-- 	end

-- 	if p then
-- 		if ply:GetTable().LastVoteCop and CurTime() - ply:GetTable().LastVoteCop < 80 then
-- 			rp.Notify(ply, NOTIFY_ERROR, rp.Term('NeedToWait'),  math.ceil(80 - (CurTime() - ply:GetTable().LastVoteCop)))
-- 			return ""
-- 		end
-- 		if not rp.teams[p:Team()] or rp.teams[p:Team()].candemote == false then
-- 			rp.Notify(ply, NOTIFY_ERROR, rp.Term('UnableToDemote'))
-- 		else
-- 			rp.Chat(CHAT_NONE, p, colors.Yellow, '[DEMOTE] ', ply, 'I want to demote you. Reason: ' .. reason)
			
-- 			rp.NotifyAll(NOTIFY_GENERIC, rp.Term('DemotionStarted'), ply, p)
-- 			p.IsBeingDemoted = true

-- 			hook.Call('playerDemotePlayer', GAMEMODE, ply, p, reason)
			
-- 			GAMEMODE.vote:create(p:Nick() .. ":\nDemotion nominee:\n"..reason, "demote", p, 20, FinishDemote,
-- 			{
-- 				[p] = true,
-- 				[ply] = true
-- 			}, function(vote)
-- 				if not IsValid(vote.target) then return end
-- 				vote.target.IsBeingDemoted = nil
-- 			end)
-- 			ply:GetTable().LastVoteCop = CurTime()
-- 		end
-- 		return ""
-- 	else
-- 		rp.Notify(ply, NOTIFY_ERROR, rp.Term('CantFindPlayer'), tostring(args))
-- 		return ""
-- 	end
-- end
-- rp.AddCommand("/demote", Demote)

/*---------------------------------------------------------
Talking
 ---------------------------------------------------------*/

local function Whisper(pl, text, args)
	if text == '' then
		return
	end
	rp.LocalChat(CHAT_LOCAL, pl, 90, colors.White, '[Шёпотом] ', pl, text)
end
rp.AddCommand("/w", Whisper)
rp.AddCommand("/whisper", Whisper)

local function Yell(pl, text, args)	
	if text == '' then
		return
	end
	rp.LocalChat(CHAT_LOCAL, pl, 600, colors.White, '[Крик] ', pl, text)
end
rp.AddCommand("/y", Yell)
rp.AddCommand("/yell", Yell)

local function Me(pl, text, args)
	if text == '' then
		return
	end
	rp.LocalChat(CHAT_NONE, pl, 250, team.GetColor(pl:Team()), pl:RealName() .. ' ', text)
end
rp.AddCommand("/me", Me)

local function OOC(pl, text, args)
	if text == '' then
		return
	end

	if pl:GetNWFloat( "OOCDelay", false ) ~= false and not pl:IsAdmin() then
		if pl:GetNWFloat("OOCDelay") > CurTime() then
			rp.Notify(pl, NOTIFY_ERROR, "Вы не можете писать в OOC еще " .. math.Round(pl:GetNWFloat("OOCDelay")-CurTime()) .. " секунд" )
		else
			rp.GlobalChat(CHAT_NONE, color_white ,"[OOC] ", Color(255, 223, 168), pl:Name() .. '('.. pl:RealName().. '): ', color_white, text)
			pl:SetNWFloat( "OOCDelay", CurTime() + 120 )
		end
	end

	if pl:GetNWFloat( "OOCDelay", false ) == false or pl:IsAdmin() then
		rp.GlobalChat(CHAT_NONE, color_white ,"[OOC] ", Color(255, 223, 168), pl:Name() .. '('.. pl:RealName().. '): ', color_white, text)
		pl:SetNWFloat( "OOCDelay", CurTime() + 120 )
	end

end
rp.AddCommand("//", OOC)
rp.AddCommand("/ooc", OOC)

local function PlayerAdvertise(pl, text, args)
	if text == '' then
		return
	end

	rp.GlobalChat(CHAT_NONE, colors.Red, '[Общая частота] ', pl, text)
	
end
rp.AddCommand("/advert", PlayerAdvertise, 1.5)
rp.AddCommand("/ad", PlayerAdvertise, 1.5)

local function MayorBroadcast(pl, text, args)
	if text == '' or not pl:IsMayor() then
		return
	end
	rp.GlobalChat(CHAT_NONE, colors.Red, '[Broadcast] ', pl, text)
end
rp.AddCommand("/broadcast", MayorBroadcast)
rp.AddCommand("/b", MayorBroadcast)

local function SetRadioChannel(pl, text, args)
	if tonumber(text) == nil or tonumber(text) < 0 or tonumber(text) > 100 then
		rp.Notify(pl, NOTIFY_ERROR, rp.Term('ChannelLimit'))
		return 
	end
	rp.Notify(pl, NOTIFY_GREEN, rp.Term('ChannelSet'), tonumber(text))
	pl.RadioChannel = tonumber(text)
end
rp.AddCommand("/channel", SetRadioChannel)

local function SayThroughRadio(pl, text, args)
	if text == '' then
		return
	elseif not pl.RadioChannel then
		rp.Notify(pl, NOTIFY_ERROR, rp.Term('ChannelNotSet'))
	end

	table.foreach(player.GetAll(), function(_, v)
		if v.RadioChannel and v.RadioChannel == pl.RadioChannel then
			rp.Chat(CHAT_RADIO, v, colors.Grey, '[Channel ' .. v.RadioChannel .. '] ', pl, text)
		end
	end)
end
rp.AddCommand("/radio", SayThroughRadio)
rp.AddCommand("/r", SayThroughRadio)

local function GroupMsg(pl, text, args)
	if text == '' then return end
	rp.groupChat(pl, text)
end
rp.AddCommand("/g", GroupMsg)
rp.AddCommand("/group", GroupMsg)

/*---------------------------------------------------------
 Money
 ---------------------------------------------------------*/
function GiveMoney(ply, ply2, text, args)
	if text == "" then
		rp.Notify(ply, NOTIFY_ERROR, rp.Term('InvalidArg'))
		return ""
	end

	if not tonumber(text[1]) then
		rp.Notify(ply, NOTIFY_ERROR, rp.Term('InvalidArg'))
		return ""
	end

  local ply2 = rp.FindPlayer(text[2])
	if IsValid(ply2) and ply2:IsPlayer() and ply2:GetPos():DistToSqr(ply:GetPos()) < 90000 then
		local amount = math.floor(tonumber(text[1]))

		if amount < 1 then
			rp.Notify(ply, NOTIFY_ERROR, rp.Term('GiveMoneyLimit'))
			return
		end

		if not ply:CanAfford(amount) then
			rp.Notify(ply, NOTIFY_ERROR, rp.Term('CannotAfford'))
			return ""
		end
		
		if not ply:CanAfford(amount) then
			rp.Notify(ply, NOTIFY_ERROR, rp.Term('CannotAfford'))
			return ""
		end
		
		rp.data.PayPlayer(ply, ply2, amount)

		rp.Notify(ply2, NOTIFY_GENERIC, rp.Term('PlayerGaveCash'), ply, rp.FormatMoney(amount))
		rp.Notify(ply, NOTIFY_GENERIC, rp.Term('YouGaveCash'), ply2, rp.FormatMoney(amount))
	else
		rp.Notify(ply, NOTIFY_ERROR, "Вы слишком далеко от игрока, подойдите ближе")
	end
	return ""
end
rp.AddCommand("/give", GiveMoney, 0.2)

local function DropMoney(ply, args)
	if args == "" then
		rp.Notify(ply, NOTIFY_ERROR, rp.Term('InvalidArg'))
		return ""
	end

	if not tonumber(args) then
		rp.Notify(ply, NOTIFY_ERROR, rp.Term('InvalidArg'))
		return ""
	end
	local amount = math.floor(tonumber(args))

	if amount <= 1 then
		rp.Notify(ply, NOTIFY_ERROR, rp.Term('DropMoneyLimit'))
		return ""
	end

	if not ply:CanAfford(amount) then
		rp.Notify(ply, NOTIFY_ERROR, rp.Term('CannotAfford'))
		return ""
	end

	ply:AddMoney(-amount)
	
	hook.Call('PlayerDropRPMoney', GAMEMODE, ply, amount, ply:GetMoney())

	local trace = {}
	trace.start = ply:EyePos()
	trace.endpos = trace.start + ply:GetAimVector() * 85
	trace.filter = ply

	local tr = util.TraceLine(trace)
	rp.SpawnMoney(tr.HitPos, amount)

	return ""
end
rp.AddCommand("/dropmoney", DropMoney, 0.3)
rp.AddCommand("/moneydrop", DropMoney, 0.3)

rp.AddCommand("/demote", function(pl, text, args)
	if not pl:IsAdmin() then return false end
	if args == "" then
		return ""
	end
	local a = args[1]
	local ply2 = rp.FindPlayer(a)
	if IsValid(ply2) then
		ply2:TeamBan()
		ply2:ChangeTeam(1, true)
	else
		DarkRP.notify(pl, 1, 4, "Данный игрок не найден")
	end
end)

rp.AddCommand("/leaderdemote", function(pl, text, args)
	if rp.teams[pl:Team()].leader ~= true and rp.teams[pl:Team()].subleader ~= true then return end
	if args == "" then
		return ""
	end
	local a = args[1]
	local ply2 = rp.FindPlayer(a)
	if rp.teams[ply2:Team()].category ~= rp.teams[pl:Team()].category then return end
	if rp.teams[pl2:Team()].leader == true then return end
	if IsValid(ply2) then
		for k, v in pairs(rp.teams) do
			if v.category == rp.teams[ply2:Team()].category then
				ply2:TeamBan(k, 1800)
			end
		end
		ply2:ChangeTeam(1, true)
		DarkRP.notify(pl, 1, 4, "Вы уволили "..ply2:RPName(true) .. ". Не забудьте удалить игрока из вайтлиста, если это требуется.")
	else
		DarkRP.notify(pl, 1, 4, "Данный игрок не найден")
	end
end)

rp.AddCommand("/id", function(pl, text, args)
	if args == "" then
		return ""
	end
	local a = args[1]
	rp.data.AddFriend(pl, a)
end)

rp.AddCommand("/tpv", function(pl, text, args)
	pl:SetNVar("PlayerTPV", not pl:GetNVar("PlayerTPV"), NETWORK_PROTOCOL_PRIVATE)
end)

-- rp.AddCommand("/loaddata", function(pl, text, args)
-- 	rp.data.LoadPlayer(pl)
-- end)

concommand.Add("loaddata", function( ply, cmd, args )
    rp.data.LoadPlayer(ply)
end)

rp.AddCommand("/buildingmode", function(pl, text, args)
	if pl:IsSurrender() == 1 then return end
	pl:SetNVar("BuildingMode", not pl:GetNVar("BuildingMode"), NETWORK_PROTOCOL_PRIVATE)
	if pl:GetNVar("BuildingMode") == true then
		DarkRP.notify(pl, NOTIFY_GENERIC, 4, "Вы включили режим строительства")
		pl:Give("weapon_physgun")
		pl:Give("gmod_tool")
		pl:SelectWeapon("weapon_physgun")
	else
		DarkRP.notify(pl, 1, 4, "Вы выключили режим строительства")
		pl:StripWeapon("weapon_physgun")
		pl:StripWeapon("gmod_tool")		
	end
end)

/*---------------------------------------------------------
Talking
 ---------------------------------------------------------*/
local function PM(pl, text, args)
	local namepos = string.find(text, " ")
	if not namepos then
		rp.Notify(pl, NOTIFY_ERROR, rp.Term('InvalidArg'))
		return ""
	end

	local name = string.sub(text, 1, namepos - 1)
	local msg = string.sub(text, namepos + 1)
	if msg == "" then
		rp.Notify(pl, NOTIFY_ERROR, rp.Term('InvalidArg'))
		return ""
	end
	local targ = rp.FindPlayer(name)

	if targ then
		--rp.Chat(CHAT_PM, pl, colors.Yellow, '[PM > ' .. targ:Name() .. '] ', pl, msg)
		--rp.Chat(CHAT_PM, targ, colors.Yellow, '[PM] ', pl, msg)
		
		rp.Chat(CHAT_PM, {pl, targ}, colors.Yellow, pl, targ, msg)
		targ.LastPM = pl
	else
		rp.Notify(ply, NOTIFY_ERROR, rp.Term('CantFindPlayer'), tostring(name))
	end

	return ""
end
rp.AddCommand("/pm", PM)

rp.AddCommand("/re", function(pl, text, args)
	local targ = pl.LastPM
	local msg = table.concat(args, ' ')
	if IsValid(targ) then
		--rp.Chat(CHAT_PM, pl, colors.Yellow, '[PM > ' .. targ:Name() .. '] ', pl, msg)
		--rp.Chat(CHAT_PM, targ, colors.Yellow, '[PM] ', pl, msg)
		
		rp.Chat(CHAT_PM, {pl, targ}, colors.Yellow, pl, targ, msg)
		targ.LastPM = pl
	else
		rp.Notify(pl, NOTIFY_ERROR, rp.Term('NoPMResponder'))
	end

end)

rp.AddCommand("/roberry", function(pl, text, args)
	local pl2 = rp.FindPlayer(args[1])
	-- print(pl2)
	-- if pl == pl2 then return end
	if not IsValid(pl2) then return end
	if not pl2:Alive() or not pl:Alive() then return end

	-- if pl2.LastRoberry && pl2.LastRoberry > CurTime() then 
	-- 	DarkRP.notify(pl, 1, 4, "Человека недавно ограбили")
	-- 	return 
	-- end

	if pl2:IsSurrender() ~= 1 then 
		DarkRP.notify(pl, 1, 4, "Человек должен поднять руки, чтобы вы могли его ограбить")
		return 
	end	

	if pl:GetPos():DistToSqr(pl2:GetPos()) > 10000 then
		DarkRP.notify(pl, 1, 4, "Вы находитесь слишком далеко от человека")
		return 
	end	

	pl2.LastRoberry = CurTime() + 600


	-- local HowManyItemsCanRob
	-- if pl2:GetLevel() >= 30 then
	-- 	HowManyItemsCanRob = 4
	-- elseif pl2:GetLevel() >= 20 then
	-- 	HowManyItemsCanRob = 3
	-- elseif pl2:GetLevel() >= 10 then
	-- 	HowManyItemsCanRob = 2
	-- else
	-- 	HowManyItemsCanRob = 1
	-- end

	-- pl.HowManyItemsCanRob = HowManyItemsCanRob

	net.Start("Inventory.StorageLookup")
		net.WriteEntity(pl2)
		net.WriteTable(pl2.inv)
	net.Send(pl)

	-- hook.Add( "rp.inv.RoberryPlayer", "rp.inv.RoberryLimit"..pl:UserID(), function(ply, type, class, count, storage )
	-- 	if not ply == pl then return end
	-- 	if not storage == pl2 then return end
	-- 	pl.HowManyItemsCanRob = pl.HowManyItemsCanRob - 1
	-- 	print(pl.HowManyItemsCanRob)
	-- 	if pl.HowManyItemsCanRob <= 0 then
	-- 		hook.Remove( "rp.inv.RoberryPlayer", "rp.inv.RoberryLimit"..ply:UserID())		
	-- 		net.Start("Inventory.CloseStorage")
	-- 		net.Send(pl)
	-- 	end
	-- end)
end)