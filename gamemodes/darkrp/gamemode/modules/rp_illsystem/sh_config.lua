rp = rp or {}
rp.Ills = rp.Ills or {}

local Register do
	_Ill = { name = '#NotFound', Start = 0, 
			ThinkRate = -1, NextThink = 0,
			OnThink = function(self, owner, mul)end,
			--RequestHandler = function(...)end,
			OnStart = function(self, owner, mul)end,
			OnFinish = function(self, owner, mul)end,
			Symptoms = {},
			Drugs = {},
			hook = nil,
			hookFunc = function(self, owner, mul)end,
			multiplier = 1, duration = 300,
			latent_period = 0, 
			drugsdelay = 0, drugsEffect = 0,

			staminaSpeedEffect = 1, 
			staminaAmountEffect = 1,
			temperatureEffect = 1,
			foodEfficiencyEffect = 1,
			thirstEfficiencyEffect = 1,
		}
	_Ill.__index = _Ill

	AccessorFunc(_Ill, 'latent_period', 'LatentTime', FORCE_NUMBER) -- Бессимптомное время (откладывает think хук болезни)
	AccessorFunc(_Ill, 'ThinkRate', 'ThinkRate', FORCE_NUMBER) -- Частота проверок
	AccessorFunc(_Ill, 'multiplier', 'Multiplier', FORCE_NUMBER) -- Множитель эффектов
	AccessorFunc(_Ill, 'duration', 'Duration', FORCE_NUMBER) -- Продолжительность
	AccessorFunc(_Ill, 'OnThink', 'OnThink') -- Тик
	AccessorFunc(_Ill, 'OnStart', 'OnStart') -- Функция при начале инфекции
	AccessorFunc(_Ill, 'OnFinish', 'OnFinish') -- Функция при конце инфекции
	AccessorFunc(_Ill, 'hook', 'Hook') -- Хук
	AccessorFunc(_Ill, 'hookFunc', 'HookFunc') -- Функция хука
	AccessorFunc(_Ill, 'Symptoms', 'Symptoms') -- симптомы
	AccessorFunc(_Ill, 'Drugs', 'Drugs') -- Медицина
	AccessorFunc(_Ill, 'drugsdelay', 'DrugsDelay') -- Время перед принятием еще одной дозы лекарства. Может быть передозировка
	AccessorFunc(_Ill, 'drugsEffect', 'DrugsEffect') -- На сколько секунд уменьшится продолжительность болезни

	AccessorFunc(_Ill, 'staminaSpeedEffect', 'StaminaSpeedEffect') -- коэффициент к скорсоти бега
	AccessorFunc(_Ill, 'staminaAmountEffect', 'StaminaAmountEffect') -- коэффициент к количеству стамины
	AccessorFunc(_Ill, 'temperatureEffect', 'TemperatureEffect') -- коэффициент к температуре
	AccessorFunc(_Ill, 'foodEfficiencyEffect', 'FoodEfficiencyEffect') -- коэффициент к питательности еды
	AccessorFunc(_Ill, 'thirstEfficiencyEffect', 'ThirstEfficiencyEffect') -- коэффициент к питательности еды

	function _Ill:Create(name) -- Name should be unique
		--assert(rp.Ills[name] == nil, "That illness name is already reserved!")
		if rp.Ills[name] ~= nil then return rp.Ills[name] end -- ONLY FOR DEVELOPMENT

		local obj = {}
		obj.name = name

		rp.Ills[name] = obj

		setmetatable(obj, self)
		return obj
	end

	function _Ill:Inherit(name)
		assert(rp.Ills[name] ~= nil, 'Ill ' .. name .. " isn't found!" )	

		self = table.Copy(rp.Ills[name])
	end

	function _Ill:CallHandler(ply, HandlerName)
		for name,_ in pairs(ply.Ills) do
			if rp.Ills[name][HandlerName] and isfunction(rp.Ills[name][HandlerName]) then
				return rp.Ills[name][HandlerName](ply)
			end
		end
		return nil
	end

	function _Ill:SetCustomHandler(key, func)
		self[key] = func
	end

	if SERVER then
		function _Ill:SaveDataToDB(pl)
			if not pl.Ills or pl:GetNVar('CharSelected') == 0 then return end

			db:Query('UPDATE rp_illnesses SET data=? WHERE steamid64=? AND charid=?;', util.TableToJSON(pl.Ills), pl:SteamID64(), pl:GetNVar('CurrentChar'))
		end
	end
end

function PLAYER:PrintTimers()
	for name, time in pairs(self.Ills) do
		if timer.Exists(self:SteamID64().."_"..name) then print("Timer found, for "..name..", time before call: "..timer.TimeLeft(self:SteamID64().."_"..name)) end
		if timer.Exists(self:SteamID64().."_"..name.."_think") then print("Think timer found, for "..name..", time before call: "..timer.TimeLeft(self:SteamID64().."_"..name.."_think")) end
	end
end

function PLAYER:ChangeIllTime(name, newtime)
	if not self.Ills or not self.Ills[name] then return end

	if newtime < os.time() then 
		self:RemoveIll(name) 
		return
	end

	if timer.Exists(self:SteamID64().."_"..name) then timer.Remove(self:SteamID64().."_"..name) end
	self.Ills[name].expire = newtime
	timer.Create(self:SteamID64().."_"..name, self.Ills[name], 1, function() 
		if not IsValid(self) then 
			timer.Remove(self:SteamID64().."_"..name)
			return 
		end

		ill.OnFinish(ill, self, ill:GetMultiplier())
		self.Ills[name] = nil
		_Ill:SaveDataToDB(self)
		self:SendIlls()
	end)

	_Ill:SaveDataToDB(self)
	self:SendIlls()
end

function PLAYER:SetIllsFromData(data)
	for name, tbl in pairs(data) do
    	self:SetIll(name, tbl.expire, true)
    end
end

function PLAYER:UseDrug(drug)
	self.DrugData = self.DrugData or {}
	self.IllDrugData = self.IllDrugData or {}

	-- Обработка передозировок
	local DrugWasUsedTooEarly = false
	if self.DrugData[drug] then 
		if CurTime() > self.DrugData[drug].nextuse then 
			self.DrugData[drug].nextuse = CurTime() + 300
			self.DrugData[drug].usecounter = 0
		else 
			DrugWasUsedTooEarly = true
		end
		self.DrugData[drug].usecounter = self.DrugData[drug].usecounter + 1
		if self.DrugData[drug].usecounter >= 5 then
			// ДОДЕЛАТЬ. -- Вызывает передозировку(ломку)
		end
	else
		self.DrugData[drug] = {
			nextuse = CurTime() + 300,
			usecounter = 1,
		}
	end

	local PillHasEffect = false
	for name, time in pairs(self.Ills) do
		if rp.Ills[name].Drugs[drug] == true then
			if DrugWasUsedTooEarly == false then
				PillHasEffect = true
				self.IllDrugData[name] = CurTime() + rp.Ills[name]:GetDrugsDelay()
				self.Ills[name].pillsUsed = self.Ills[name].pillsUsed + 1
				self:ChangeIllTime(name, self.Ills[name].expire - rp.Ills[name]:GetDrugsEffect())
			end
		end
	end
	if PillHasEffect == true then
		timer.Simple( 30, function()
			self:SendSystemMessage("Состояние", 'Вы чувствуете, что симптомы болезни после лекарства немного отступили')
		end)
	elseif not table.IsEmpty(self.Ills) then
		if DrugWasUsedTooEarly == false then
			timer.Simple( 60, function()
				self:SendSystemMessage("Состояние", 'Вы чувствуете, что симптомы болезни после лекарства не отступают. Кажется, это было не то лекарство')
			end)
		else
			timer.Simple( 60, function()
				self:SendSystemMessage("Состояние", 'Вы чувствуете, что симптомы болезни после лекарства отступили, но ваше самочувствие стало хуже. Кажется, я слишком часто принимаю лекарство.')
			end)
		end
	end
end

function PLAYER:SetIll(name, customExpireTime, disableLatent)
	assert( rp.Ills[name] ~= nil, 'Ill ' .. name .. " isn't found!" )
	if self.Ills and self.Ills[name] then return end

	if SERVER then
		self:ShowGuide("Ills")
	end

	local ill = rp.Ills[name]
	local shouldContinue = ill.OnStart(ill, self, ill:GetMultiplier())
	if shouldContinue == false then return end

	local expireTime = customExpireTime and customExpireTime or os.time() + ill:GetDuration()
	if os.time() > expireTime then expireTime = os.time() + 2 end

	self.Ills = self.Ills or {}
	self.Ills[name] = self.Ills[name] or {} 
	self.Ills[name].expire = expireTime
	self.Ills[name].pillsUsed = 0


	self.IllsLatentTime = self.IllsLatentTime or {}
	if disableLatent ~= true and ill:GetLatentTime() > 0 then
		self.IllsLatentTime[name] = CurTime() + ill:GetLatentTime()
	end
	
	self.IllTimers = self.IllTimers or {}
	-- Ill End timer
	if SERVER then
		timer.Create(self:SteamID64().."_"..name, expireTime-os.time(), 1, function() 
			ill.OnFinish(ill, self, ill:GetMultiplier())
			self.Ills[name] = nil
			_Ill:SaveDataToDB(self)
			self:SendIlls()
		end)
	end

	
	if ill:GetThinkRate() >= 0 then
		timer.Create(self:SteamID64().."_"..name.."_think", ill:GetThinkRate(), 0, function() 
			if not self.IllsLatentTime then return end -- Not initialized, skip then

			if self.IllsLatentTime[name] and self.IllsLatentTime[name] > CurTime() then
				return
			elseif self.IllsLatentTime[name] then
				self.IllsLatentTime[name] = nil
			end
			
			ill.OnThink(ill, self, ill:GetMultiplier())
		end)
	end

	if SERVER then 
		_Ill:SaveDataToDB(self) 
		self:SendIlls()
	end
end

function PLAYER:RemoveIll(name, disableNextStage)
	assert(self.Ills[name] ~= nil, "Player don't have such ill as ".. name .. "!" )

	self.Ills = self.Ills or {}

	-- Прогрессия болезни
	if not (disableNextStage == true) then
		local chance = 50
		self.Ills[name].pillsUsed = self.Ills[name].pillsUsed + 1 
		chance = chance / self.Ills[name].pillsUsed

		if math.random(1,100) < chance then
			// Тут будет кастомная функция прогрессии болезней
		end
	end

	self.Ills[name] = nil
	if timer.Exists(self:SteamID64().."_"..name) then timer.Remove(self:SteamID64().."_"..name) end
	if timer.Exists(self:SteamID64().."_"..name.."_think") then timer.Remove(self:SteamID64().."_"..name.."_think") end

	if SERVER then 
		_Ill:SaveDataToDB(self) 
		self:SendIlls()
	end
end


---------------------------------------
--------------CONFIG-------------------
---------------------------------------

rp.Drugs = rp.Drugs or {}

rp.Drugs["efferalgan"] = {
	name = "Эффералган",
	model = "models/codeandmodeling_efferalgan_lucian/codeandmodeling_efferalgan_lucian.mdl",
}
rp.Drugs["tamiflu"] = {
	name = "Таблетка 'Тамифлю'",
	model = "models/fless/pill03fix.mdl",
}
rp.Drugs["amox"] = {
	name = "Таблетка 'Амоксициллин'",
	model = "models/fless/pill02.mdl",
}
rp.Drugs["med_coal"] = {
	name = "Активированный уголь",
	model = "models/zworld_health/somnifere.mdl",
}



-- боль во всем теле - 8% штраф к выносливости,
-- кашель - соответствующий эффект, 
-- морозит - синее покрытие по краям, 
-- отек - трата хп во время движения(маленькое), 
-- слабость - меньше урона с ближнего боя, 5% штраф к скорости
-- дизориентация - эффект флешки пока не вылечишь(может быть тряска экрана)
-- потеря зрения - темный экран
-- сбой сердца - превращается в рагдолл на время, маленький шанс смерти
-- температура - смазанность движений
-- давление - 10% шанс обморока(рагдолла)
-- кашель с скровью - кашель + потеря хп
-- тремор - тряска экрана
-- лихорадка - замерзание потихоньку, тремор
-- потеря голоса - выключение войса и чата
-- боль в желудке - 50% штраф к получению еды
-- обморок - рагдолл игрока
-- обезвоживание - увеличенное уменьшение воды
-- замерзание - шанс заболеть еще чем-то
-- жар - трата воды, усталость
local newIll

-- AccessorFunc(_Ill, 'latent_period', 'LatentTime', FORCE_NUMBER) -- Бессимптомное время
-- AccessorFunc(_Ill, 'multiplier', 'Multiplier', FORCE_NUMBER) -- Множитель эффектов
-- AccessorFunc(_Ill, 'duration', 'Duration', FORCE_NUMBER) -- Продолжительность
-- AccessorFunc(_Ill, 'OnThink', 'OnThink') -- Тик
-- AccessorFunc(_Ill, 'ThinkRate', 'ThinkRate', FORCE_NUMBER) -- Частота проверок
-- AccessorFunc(_Ill, 'OnStart', 'OnStart') -- Функция при начале инфекции
-- AccessorFunc(_Ill, 'OnFinish', 'OnFinish') -- Функция при конце инфекции
-- SetCustomHandler -- ОСНОВНОЙ. Отвечает на запрос от внешних модулей. Для каждой болезни может быть своим
-- AccessorFunc(_Ill, 'hook', 'Hook') -- Хук
-- AccessorFunc(_Ill, 'hookFunc', 'HookFunc') -- Функция хука
-- AccessorFunc(_Ill, 'Symptoms', 'Symptoms') -- симптомы
-- AccessorFunc(_Ill, 'drugsdelay', 'DrugsDelay') -- Время перед принятием еще одной дозы лекарства.
-- AccessorFunc(_Ill, 'drugsEffect', 'DrugsEffect') -- На сколько секунд уменьшится продолжительность болезни

newIll = _Ill:Create("Грипп")
newIll:SetDuration(60*60*6) -- минута * час * кол-во часов
newIll:SetLatentTime(60*10) -- минута * час * кол-во часов
newIll:SetDrugsDelay(60*20) -- минута * час * кол-во часов
newIll:SetDrugsEffect(60*60*2) -- На сколько отступит болезнь 60 сек * длительность суток(в минутах) * дни
newIll:SetSymptoms({
	"кашель(привлекает зомби)",
	"ломота в теле(скорость передвижения -2%)",
	"насморк(уставание при беге +2%)", 
	"боли в горле",
	"слабость(скорость передвижения -2%)",
	"жар(-10% к скорости согревания)",
})
newIll:SetDrugs({
	["efferalgan"] = true,
	["tamiflu"] = true,
})
newIll:SetThinkRate(60)
newIll:OnStart( function(ill, ply, mul)
	if ply.Ills["Грипп"] ~= nil then return false end
end)
newIll:SetOnThink( function(ill, ply, mul)
	if CLIENT then return end

	local coughSounds = {
		'ambient/voices/cough1.wav',
		'ambient/voices/cough2.wav',
		'ambient/voices/cough3.wav',
		'ambient/voices/cough4.wav',
	}
	ply:EmitSound(coughSounds[math.random(1, #coughSounds)], SNDLVL_55dB)

	if ply.Cosmetics[4] then return end 

	local tr = util.TraceLine( util.GetPlayerTrace( ply ) )
	if IsValid(tr.Entity) and tr.Entity:IsPlayer() and ply:GetPos():DistToSqr(tr.Entity:GetPos()) <= 70*70 then 
		local chance = 4
		if math.random(1,chance) == 1 then
			timer.Simple(math.random(1,20), function()
				tr.Entity:SetIll("Грипп")
			end)
		end
	end
end)
newIll:SetOnFinish(function(ill, ply, mul)
	if ply.Ills[ill.name].pillsUsed == 0 then
		ply:SetIll("ОРВИ")
	end
end)
newIll:SetStaminaSpeedEffect(0.96)
newIll:SetStaminaAmountEffect(1.02)
newIll:SetTemperatureEffect(0.9)


newIll = _Ill:Create("ОРВИ")
newIll:SetDuration(60*60*6) -- минута * час * кол-во часов
newIll:SetLatentTime(60*10) -- минута * час * кол-во часов
newIll:SetDrugsDelay(60*20) -- минута * час * кол-во часов
newIll:SetDrugsEffect(60*60*2) -- На сколько отступит болезнь 60 сек * длительность суток(в минутах) * дни
newIll:SetSymptoms({
	"кашель(привлекает зомби)",
	"ломота в теле(скорость передвижения -2%)",
	"насморк(уставание при беге +2%)", 
	"боли в горле",
	"давление(уставание при беге +2%, скорость передвижения -5%)",
	"лихорадка(-10% к скорости согревания)",
	"замерзание(-10% к скорости согревания)"
})
newIll:SetDrugs({
	["efferalgan"] = true,
	["tamiflu"] = true,
})
newIll:SetThinkRate(60)
newIll:SetOnThink( function(ill, ply, mul)
	if CLIENT then return end

	local coughSounds = {
		'ambient/voices/cough1.wav',
		'ambient/voices/cough2.wav',
		'ambient/voices/cough3.wav',
		'ambient/voices/cough4.wav',
	}
	ply:EmitSound(coughSounds[math.random(1, #coughSounds)], SNDLVL_55dB)

	if ply.Cosmetics[4] then return end 

	local tr = util.TraceLine( util.GetPlayerTrace( ply ) )
	if IsValid(tr.Entity) and tr.Entity:IsPlayer() and ply:GetPos():DistToSqr(tr.Entity:GetPos()) <= 70*70 then 
		local chance = 4
		if math.random(1,chance) == 1 then
			timer.Simple(math.random(1,20), function()
				tr.Entity:SetIll("Грипп")
			end)
		end
	end
end)
newIll:SetOnFinish(function(ill, ply, mul)
	if ply.Ills[ill.name].pillsUsed == 0 then
		ply:SetIll("Пневмония")
	end
end)
newIll:SetStaminaSpeedEffect(0.93)
newIll:SetStaminaAmountEffect(1.04)
newIll:SetTemperatureEffect(0.8)


newIll = _Ill:Create("Пневмония")
newIll:SetDuration(60*60*12) -- минута * час * кол-во часов
newIll:SetLatentTime(60*10) -- минута * час * кол-во часов
newIll:SetDrugsDelay(60*60) -- минута * час * кол-во часов
newIll:SetDrugsEffect(60*60*8) -- На сколько отступит болезнь 60 сек * длительность суток(в минутах) * дни
newIll:SetSymptoms({
	"кашель(привлекает зомби)",
	"одышка(скорость передвижения -5%)",
	"тошнота(-25% к питательности еды)",
	"проблемы с дыханием(уставание при беге +30%)",
	"лихорадка(-10% к скорости согревания)",
	"замерзание(-10% к скорости согревания)"
})
newIll:SetDrugs({
	["amox"] = true,
})
newIll:SetThinkRate(60)
newIll:SetOnThink( function(ill, ply, mul)
	if CLIENT then return end

	local coughSounds = {
		'ambient/voices/cough1.wav',
		'ambient/voices/cough2.wav',
		'ambient/voices/cough3.wav',
		'ambient/voices/cough4.wav',
	}
	ply:EmitSound(coughSounds[math.random(1, #coughSounds)], SNDLVL_55dB)

	if ply.Cosmetics[4] then return end 

	local tr = util.TraceLine( util.GetPlayerTrace( ply ) )
	if IsValid(tr.Entity) and tr.Entity:IsPlayer() and ply:GetPos():DistToSqr(tr.Entity:GetPos()) <= 70*70 then 
		local chance = 4
		if math.random(1,chance) == 1 then
			timer.Simple(math.random(1,20), function()
				tr.Entity:SetIll("Грипп")
			end)
		end
	end
end)
newIll:SetStaminaSpeedEffect(0.95)
newIll:SetStaminaAmountEffect(1.30)
newIll:SetTemperatureEffect(0.8)

newIll = _Ill:Create("Отравление")
newIll:SetDuration(60*60)
newIll:SetDrugsEffect(60*10) -- На сколько отступит болезнь 60 сек * длительность суток(в минутах) * дни
newIll:SetSymptoms({
	"боль в животе(скорость передвижения -2%)", 
	"тошнота(-25% к питательности еды)",
	"диарея(-25% к питательности воды)",
})
newIll:SetDrugs({
	["med_coal"] = true,
})
newIll:SetStaminaSpeedEffect(0.98)
newIll:SetFoodEfficiencyEffect(0.75)
newIll:SetThirstEfficiencyEffect(0.75)




---------------------------------------
---------------------------------------
---------------------------------------

function PLAYER:IsUnderRoof()
	local tr = {collisiongroup = COLLISION_GROUP_DEBRIS}
	tr.start = self:GetPos()
	tr.endpos = self:GetPos() + Vector(0,0,200)
	return util.TraceLine( tr ).HitWorld
end

local function RegisterDrugs(class, tbl)

	local ENT = {}
	ENT.Base = "base_gmodentity"
	ENT.Type = "anim"
	ENT.PrintName = tbl.name
	ENT.WorldModel = tbl.model
	ENT.Model = tbl.model

	ENT.Category = "Медикаменты"
	ENT.Spawnable = true

	if SERVER then
		function ENT:Initialize()
			self:SetModel( self.WorldModel )
			self:PhysicsInit(SOLID_VPHYSICS)
			self:SetMoveType(MOVETYPE_VPHYSICS)
			self:SetSolid(SOLID_VPHYSICS)
			self:SetUseType(SIMPLE_USE)
			local phys = self:GetPhysicsObject()
			phys:Wake()
		end

		function ENT:Use(activator, caller)
			activator:UseDrug(class)
			self:Remove()
		end
	end
	scripted_ents.Register( ENT, class )
end

hook.Add( "OnGamemodeLoaded", "rp.Ills.RegisterAllInstances", function()
	for class, tbl in pairs(rp.Drugs) do
		RegisterDrugs(class, tbl)
	end
end)

function PLAYER:IsFireAround()
    return isnumber(self:GetNVar('FireAround')) and self:GetNVar('FireAround') > CurTime() or false
end

function PLAYER:IsClothesWet()
    local info = self:GetNVar("ClothesIsWet")
    return info and not isnumber(info) and info > CurTime()
end