// Эти функции нигде не используются. Тестовый модуль. Пусть будет на будущее

function rp.SetLightType(light, pattern)
	engine.LightStyle( light, pattern)

	for k,v in pairs(player.GetAll()) do
		v:SendLua("render.RedownloadAllLightmaps( false, false )")
	end
end

function TurnNightLightning(bool)
	if bool == nil then return end
	if bool == true then
		for k,v in pairs(player.GetAll()) do
			v:SendLua([[ColorEffect = 1]])
		end
	elseif bool == false then
		for k,v in pairs(player.GetAll()) do
			v:SendLua([[ColorEffect = 0]])
		end
	end
end