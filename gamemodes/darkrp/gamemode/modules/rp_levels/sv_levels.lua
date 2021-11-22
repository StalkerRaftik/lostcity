util.AddNetworkString('ShowLevelUPGreets')

function SetOfflineLevel(lvl, sid)
	db:Query( "UPDATE `player_data` SET Level = '" .. lvl .. "' WHERE SteamID = '" .. sid .. "'" )
end


function PLAYER:SetLevel(intCount)
	intCount = math.floor(intCount)

	self:SavePlayerData('Level',intCount)
	self:SetNVar('Level',intCount,NETWORK_PROTOCOL_PUBLIC)

	DarkRP.notify(self, 1, 4, "Ваш уровень вырос! Теперь вы "..self:GetNVar('Level').." уровня.")

	-- self:EmitSound('garrysmod/save_load'..math.random(4)..'.wav')
	---self:EmitSound('ui/achievement_earned.wav')
end

function PLAYER:AddLevel(intCount)   
	intCount = self:GetLevel() + intCount
	self:SetLevel(intCount)
end

function PLAYER:GetDonatorMultiplier()
	if self:IsIgrokPlus() then
		return ExpBoostForDonators["igrokplus"]
	end

	if self:IsVIP() then
		return ExpBoostForDonators["vip"] 
	end

	if self:IsPremium() then
		return ExpBoostForDonators["premium"]
	end

	if self:IsSponsor() then
		return ExpBoostForDonators["sponsor"]
	end
end

function PLAYER:SetExperience(intCount)
	intCount = math.floor(intCount)
	
	self:SavePlayerData('Experience',intCount)
	self:SetNVar('Experience',intCount,NETWORK_PROTOCOL_PUBLIC)

	self:isPassedLevel()
end

function PLAYER:AddExperience(intCount1, msgEnum, ingoreDonateMultiplier)
	if ingoreDonateMultiplier == true then
		intCount1 = intCount1 * self:GetDonatorMultiplier()
	end

	msgEnum = msgEnum or LVL_MSG_ENUM.NONE
	intCount2 = self:GetExperience() + intCount1
	self:SetExperience(intCount2)

	net.Start("ShowLevelUPGreets")
	net.WriteUInt(intCount1, 32)
	net.WriteUInt(msgEnum, 8)
	net.Send(self)
end

function PLAYER:isPassedLevel()
	if (self:GetExperience() >= self:GetNeedExperience()) then
		self:SetExperience(0)
		self:AddLevel(1)
	end
end

rp.Exp_Cfg = {
	Lawnmovering = 10,
	Fishing = 5,

	PlayingOnServer = 17,
}
// Crafting and cooking exps are in them

local ExpBoostForDonators = {
	['vip'] = 1.25, --получают 150% бонусного опытаа
	['igrokplus']  = 1.1, --получают 120% бонусного опытаа
	['premium'] = 1.5, --получают 170% бонусного опытаа
	['sponsor']  = 2, --получают 200% бонусного опытаа
}

local HowManyExpGive = {}
HowManyExpGive.Standart = 15 // Опыт за убийство стандартного NPC
HowManyExpGive.NPCList = {}

HowManyExpGive.NPCList["npc_vj_cof_child"] = {
	Exp = 25,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_cof_citalopram"] = {
	Exp = 26,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_cof_crawler"] = {
	Exp = 20,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_cof_crazyrunner"] = {
	Exp = 28,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_cof_croucher"] = {
	Exp = 22,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_cof_faster"] = {
	Exp = 25,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_cof_krypandenej"] = {
	Exp = 20,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_cof_mace"] = {
	Exp = 90,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_cof_phsycho"] = {
	Exp = 27,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_cof_sawcrazy"] = {
	Exp = 35,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_cof_sawrunner"] = {
	Exp = 120,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_cof_sawer"] = {
	Exp = 70,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_cof_sewmo"] = {
	Exp = 25,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_cof_slower1"] = {
	Exp = 20,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_cof_slower3"] = {
	Exp = 22,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_cof_slowerstuck"] = {
	Exp = 25,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_cof_slowerno"] = {
	Exp = 22,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_cof_taller"] = {
	Exp = 100,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_cof_upper"] = {
	Exp = 23,	-- Колво экспы за убийство
}

HowManyExpGive.NPCList["npc_vj_l4d_com_m_fallsur"] = {
	Exp = 20,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_l4d_com_m_mudmen"] = {
	Exp = 25,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_l4d_com_m_riot"] = {
	Exp = 60,	-- Колво экспы за убийство
}

HowManyExpGive.NPCList["npc_vj_lnr_infbomber"] = {
	Exp = 60,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_lnr_walbomber"] = {
	Exp = 60,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_lnr_butcher"] = {
	Exp = 30,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_lnr_butcher_chainsaw"] = {
	Exp = 40,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_lnr_brute"] = {
	Exp = 30,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_lnr_fatso"] = {
	Exp = 30,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_lnr_hazinf"] = {
	Exp = 25,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_lnr_hazwal"] = {
	Exp = 25,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_lnr_flamzom"] = {
	Exp = 30,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_lnr_ravager"] = {
	Exp = 20,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_lnr_nh2_secinf"] = {
	Exp = 60,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_lnr_nh2_secshield"] = {
	Exp = 60,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_lnr_nh2_sec"] = {
	Exp = 55,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_lnr_sentry"] = {
	Exp = 30,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_lnr_eleczom"] = {
	Exp = 30,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_lnr_spitter"] = {
	Exp = 20,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_lnr_spitter"] = {
	Exp = 30,	-- Колво экспы за убийство
}
HowManyExpGive.NPCList["npc_vj_lnr_shambler"] = {
	Exp = 20,	-- Колво экспы за убийство
}

hook.Add("OnNPCKilled", "GiveUsExp", function(npc, ply, at)
	if(npc and npc:IsValid() and npc:IsNPC() and ply and ply:IsValid() and ply:IsPlayer()) then -- Существуют ли NPC и Player
		local enum = LVL_MSG_ENUM.NPC
		local HowManyNpcGiveUsExp
		if ( HowManyExpGive.NPCList[npc:GetClass()] ) then  --Есть ли этот зомби в NPCList
			local NPC = HowManyExpGive.NPCList[npc:GetClass()]
			enum = LVL_MSG_ENUM.SPECIALNPC
			HowManyNpcGiveUsExp = NPC.Exp
		else
			HowManyNpcGiveUsExp = HowManyExpGive.Standart
		end

		if rp.Zones:InsideSafeZone(ply:GetPos()) or rp.Zones:InsideSafeZone(npc:GetPos()) then
			// 1/3 от опыта, если убийство рядом с гринзоной
			HowManyNpcGiveUsExp = HowManyNpcGiveUsExp / 3 
		end

		ply:AddExperience(HowManyNpcGiveUsExp, enum)
	end
end)



timer.Create("LevelTimer",600,0,function()
	for _, v in ipairs(player.GetAll()) do
		if not IsValid(v) or not v:Alive() then continue end

		local HowManyNpcGiveUsExp = rp.Exp_Cfg["PlayingOnServer"]

		v:AddExperience(HowManyNpcGiveUsExp, LVL_MSG_ENUM.PLAYING) -- Базовое кол-во опыта для зомби не NPCList
		-- TODO: notify
		-- print(expCount..' > '..v:Name())
	end
end)
