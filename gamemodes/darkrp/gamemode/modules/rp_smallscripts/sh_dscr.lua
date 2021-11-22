local function respawntime(pl)
	return 50
end

function knockouttimer(pl)
	return 60
end

if SERVER then
	util.AddNetworkString("RespawnTimer")
	hook.Add("PlayerDeath", "RespawnTimer", function(pPlayer)
		pPlayer.deadtime = RealTime()

		net.Start("RespawnTimer")
			net.WriteBool(true)
		net.Send(pPlayer)

	end)

	hook.Add("PlayerDeathThink", "RespawnTimer", function(pPlayer)
		if pPlayer.deadtime and RealTime() - pPlayer.deadtime < respawntime(pPlayer) then
			return false
		end
	end)

	hook.Add("PlayerSpawn", "HideRespawnTimer", function(pPlayer)
		net.Start("RespawnTimer")
			net.WriteBool(false)
		net.Send(pPlayer)
		if pPlayer:GetCanZoom() ~= false then
			pPlayer:SetCanZoom(false)
		end
	end)
end



if CLIENT then
	surface.CreateFont('kek', {font = 'JK_Cold Night for Alligators', size = 90, weight = 500, extended = true, additive = true})	
	local alpha = 0
	local alpha2 = 0
	local skull = Material("lostcity/hud/dscr2.jpg", "noclamp smooth")
	local sizex = 0
	local sizey = 0
	local advices = {
		'Совет №1: Не стоит выживать в одиночку.',
		'Совет №2: Если ваш персонаж сыт и его не одолевает жажда, его здоровье будет постепенно восстанавливаться.',
		'Совет №3: Сломанное оружие можно всегда починить на верстаке.',
		'Совет №4: Бронежилет и шлем могут сломаться от сильных повреждений.',
		'Совет №5: Аптечка не только восстанавливает здоровье и оставливает кровотечение, но еще и лечит перелом.',
		'Совет №6: Если вы повредили ногу, а вылечить её нечем, не волнуйтесь, со временем рана заживёт.',
		'Совет №7: Хлам не бесполезен. С его помощью вы можете создать много полезных вещей на верстаке, которые помогут вам выжить.',
		'Совет №8: Не забывайте продавать ненужные вещи в магазине.',
		'Совет №9: Прежде чем снять рюкзак, удостоверьтесь, что у вас хватает карманов для того, чтобы переложить все вещи из рюкзака в них.',
		'Совет №10: Игрок нарушает правила во время РП? Сначала доиграйте РП-ситуацию, а только потом зовите админа на разборки и выясняйте отношения.',
		'Совет №11: Администратора можно вызвать с помощью команды "@ Помогите!" в чате.',
		'Совет №12: Хотите описать по РП то, что происходит вокруг? Используйте команду /it.',
		'Совет №13: Хотите описать действия своего персонажа по РП? Используйте команду /me.',
		'Совет №14: Нужно что-то сказать по Нон-РП? Не нужно делать это в микроофон, воспользуйтесь командой /looc.',
		'Совет №15: Донат-система существует для того, чтобы игроки могли иметь возможность поддержать создателей сервера материально.',
		'Совет №16: Надоело просто выживать? Вступите в группировку или придумайте уникального персонажа, которого вам будет интересно отыгрывать.',
		'Совет №17: Есть доказательства нарушения правил игроком/администратором? Напишите жалобу в нашу группу ВКонтакте: vk.com/octopusgmod.',
		'Совет №18: Не стоит тратить выносливость понапрасну.',
		-- 'Совет №19: Ренегаты - опасные бандиты. Если вы не в силах им противостоять, лучше не вставайте у них на пути.',
		-- 'Совет №20: Военные - барьер между ренегатами и выжившими. Настоящих военных среди них осталось мало, большинство - неравнодушные выжившие.',
		-- 'Совет №21: Хаос - огромная секта фатнатиков, верящих в обреченность человечества. Для них сжигать людей на костре - обычное дело.',
		-- 'Совет №22: Вознесение - некогда могущественная комунна, практически полностью уничтоженная Хаосом. Церковь - их последний оплот.',
		--'Совет №23: Учёные - последняя надежда человечества. Именно они создают антидоты, помогающие при первой стадии заражения.',
		'Совет №24: Испорченную еду стоит есть только в безысходных ситуациях, иначе лучше купить еду в убежище или найти свежий полуфабрикат.', 
		'Совет №25: Донат может помощь развить вашего персонажа быстрее, получить валюту, вещи или открыть доступ к ВИП-профессиям.',
		'Совет №25: Относитесь к администрации с уважением. Они помогают сохранить РП на сервере и поддерживают культурную игровую атмосферу.',
		--'Совет №26: Нужна передышка, а база далеко? Говорят, что где-то в городе есть небольшое убежище...',
		'Совет №27: Ненужные вещи вы всегда можете сложить на любой дружественной базе.',
	}
	local advice = table.Random(advices)
	net.Receive("RespawnTimer", function()
		if net.ReadBool() then
			local dead = RealTime()

			hook.Add("HUDPaint", "RespawnTimer", function()
				alpha = Lerp(.005, alpha, 255)
				surface.SetDrawColor( 0, 0, 0, alpha*1.05 )
				surface.DrawRect( 0, 0, ScrW(), ScrH() )
				local time = math.Round(respawntime() - RealTime() + dead)
				if alpha >= 253 then
					alpha2 = Lerp(.0005, alpha2, 255)
					surface.SetDrawColor( 255, 255, 255, alpha2*1.05 )
					surface.SetMaterial( skull ) 
					surface.DrawTexturedRect( ScrW()/4, 0-(ScrH()*0.05), ScrW()/2, ScrH() )
					if time > 0 then
						draw.SimpleText(advice, "font_base_hud", ScrW()/1.9, ScrH()/1.02, Color(255,255,255, alpha2*1.05), 1, 1)
						draw.SimpleText("Вы погибли "..(rplib.FormatTime(time)), "kek", ScrW()/1.95, ScrH()/1.1, Color(255,255,255, alpha2*1.05), 1, 1)
					else
						draw.SimpleText("Нажмите любую кнопку для возрождения", "kek", ScrW()/2, ScrH()/1.05, Color(255,255,255, alpha2*1.05), 1, 1)
					end
				end
	
			end)

			

			hook.Add("Think", "RespawnTimerMusic", function()
				if (RealTime() - dead) < 1 then return end

				hook.Remove("Think", "RespawnTimerMusic")

				if LocalPlayer():Alive() then return end
				if not system.HasFocus() then return end
			end)
			system.FlashWindow()
		else
			hook.Remove("HUDPaint", "RespawnTimer")
		end

	end)

-- net.Receive("KnockoutTimer", function()
-- 		if net.ReadBool() then
-- 			local knockout = RealTime()

-- 			hook.Add("HUDPaint", "KnockoutTimer", function()
-- 				if not IsValid( LocalPlayer() ) and not LocalPlayer():Alive() then return false end
-- 				alpha = Lerp(.005, alpha, 255)
-- 				surface.SetDrawColor( 0, 0, 0, alpha*1.05 )
-- 				surface.DrawRect( 0, 0, ScrW(), ScrH() )
-- 				local time = math.Round(knockouttimer() - RealTime() + knockout)
-- 				if alpha >= 253 then
-- 					alpha2 = Lerp(.0005, alpha2, 255)
-- 					-- surface.SetDrawColor( 255, 255, 255, alpha2*1.05 )
-- 					-- surface.SetMaterial( skull ) 
-- 					-- surface.DrawTexturedRect( ScrW()/4, 0-(ScrH()*0.05), ScrW()/2, ScrH() )
-- 					if time > 0 then
-- 						-- draw.SimpleText(advice, "font_base_hud", ScrW()/1.9, ScrH()/1.02, Color(255,255,255, alpha2*1.05), 1, 1)
-- 						draw.SimpleText("Вы потеряли сознание "..(rplib.FormatTime(time)), "kek", ScrW()/1.95, ScrH()/2, Color(255,255,255, alpha2*1.05), 1, 1)
-- 					end
-- 				end
	
-- 			end)

			

-- 			hook.Add("Think", "KnockoutTimerMusic", function()
-- 				if (RealTime() - knockout) < 1 then return end

-- 				hook.Remove("Think", "KnockoutTimerMusic")

-- 				if LocalPlayer():Alive() then return end
-- 				if not system.HasFocus() then return end
-- 			end)
-- 			system.FlashWindow()
-- 		else
-- 			hook.Remove("HUDPaint", "KnockoutTimer")
-- 		end

-- 	end)	
end
