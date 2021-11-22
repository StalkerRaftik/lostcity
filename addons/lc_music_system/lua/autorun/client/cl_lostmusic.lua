local lostvolume = 30
local IsMusicOn = true

local function LostMusic()

	if ( !IsValid(LocalPlayer()) ) or ( IsMusicOn == false )  then
		timer.Simple(5,LostMusic)
	return end

	if !musicoff then
		musicoff = false
	end

	local mp3choice = math.random(1,29)

	if musicoff == false then
		musicoff = true
		if mp3choice == 1 then
			LocalPlayer():EmitSound("lostmusic/1.mp3",lostvolume,100)
			timer.Simple(28+(math.random(30,60)),function()musicoff = false LostMusic() end)
		elseif mp3choice==2 then
			LocalPlayer():EmitSound("lostmusic/2.mp3",lostvolume,100)
			timer.Simple(20+(math.random(30,60)),function()musicoff = false LostMusic() end)
		elseif mp3choice==3 then
			LocalPlayer():EmitSound("lostmusic/3.mp3",lostvolume,100)
			timer.Simple(14+(math.random(30,60)),function()musicoff = false LostMusic() end)
		elseif mp3choice==4 then
			LocalPlayer():EmitSound("lostmusic/4.mp3",lostvolume,100)
			timer.Simple(14+(math.random(30,60)),function()musicoff = false LostMusic() end)
		elseif mp3choice==5 then
			LocalPlayer():EmitSound("lostmusic/5.mp3",lostvolume,100) 
			timer.Simple(90+(math.random(90,120)),function()musicoff = false LostMusic() end)
		elseif mp3choice==6 then
			LocalPlayer():EmitSound("lostmusic/6.mp3",lostvolume,100)
			timer.Simple(15+(math.random(30,60)),function()musicoff = false LostMusic() end)
		elseif mp3choice==7 then
			LocalPlayer():EmitSound("lostmusic/9.mp3",lostvolume,100)
			timer.Simple(17+(math.random(30,60)),function()musicoff = false LostMusic() end)
		elseif mp3choice==8 then
			LocalPlayer():EmitSound("lostmusic/10.mp3",lostvolume,100)
			timer.Simple(23+(math.random(30,60)),function()musicoff = false LostMusic() end)
		elseif mp3choice==9 then
			LocalPlayer():EmitSound("lostmusic/11.mp3",lostvolume,100)
			timer.Simple(18+(math.random(30,60)),function()musicoff = false LostMusic() end)
		elseif mp3choice==10 then
			LocalPlayer():EmitSound("lostmusic/12.mp3",lostvolume,100)
			timer.Simple(26+(math.random(30,60)),function()musicoff = false LostMusic() end)
		elseif mp3choice==11 then
			LocalPlayer():EmitSound("lostmusic/14.mp3",lostvolume,100)
			timer.Simple(15+(math.random(30,60)),function()musicoff = false LostMusic() end)
		elseif mp3choice==12 then
			LocalPlayer():EmitSound("lostmusic/15.mp3",lostvolume,100)
			timer.Simple(16+(math.random(30,60)),function()musicoff = false LostMusic() end)
		elseif mp3choice==13 then
			LocalPlayer():EmitSound("lostmusic/17.mp3",lostvolume,100)
			timer.Simple(16+(math.random(30,60)),function()musicoff = false LostMusic() end)
		elseif mp3choice==14 then
			LocalPlayer():EmitSound("lostmusic/18.mp3",lostvolume,100)
			timer.Simple(12+(math.random(30,60)),function()musicoff = false LostMusic() end)
		elseif mp3choice==15 then
			LocalPlayer():EmitSound("lostmusic/20.mp3",lostvolume,100)
			timer.Simple(24+(math.random(45,60)),function()musicoff = false LostMusic() end)
		elseif mp3choice==16 then
			LocalPlayer():EmitSound("lostmusic/22.mp3",lostvolume,100)
			timer.Simple(31+(math.random(45,60)),function()musicoff = false LostMusic() end)
		elseif mp3choice==17 then
			LocalPlayer():EmitSound("lostmusic/23.mp3",lostvolume,100)
			timer.Simple(14+(math.random(30,60)),function()musicoff = false LostMusic() end)
		elseif mp3choice==18 then
			LocalPlayer():EmitSound("lostmusic/24.mp3",lostvolume,100)
			timer.Simple(184+(math.random(60,85)),function()musicoff = false LostMusic() end)
		elseif mp3choice==19 then
			LocalPlayer():EmitSound("lostmusic/25.mp3",lostvolume,100)
			timer.Simple(201+(math.random(120,210)),function()musicoff = false LostMusic() end)
		elseif mp3choice==20 then
			LocalPlayer():EmitSound("lostmusic/27.mp3",lostvolume,100)
			timer.Simple(70+(math.random(70,135)),function()musicoff = false LostMusic() end)
		elseif mp3choice==21 then
			LocalPlayer():EmitSound("lostmusic/28.mp3",lostvolume,100)
			timer.Simple(52+(math.random(60,140)),function()musicoff = false LostMusic() end)
		elseif mp3choice==22 then
			LocalPlayer():EmitSound("lostmusic/29.mp3",lostvolume,100)
			timer.Simple(238+(math.random(250,320)),function()musicoff = false LostMusic() end)
		elseif mp3choice==23 then
			LocalPlayer():EmitSound("lostmusic/30.mp3",lostvolume,100)
			timer.Simple(249+(math.random(260,300)),function()musicoff = false LostMusic() end)
		elseif mp3choice==24 then
			LocalPlayer():EmitSound("lostmusic/31.mp3",lostvolume,100)
			timer.Simple(236+(math.random(260,300)),function()musicoff = false LostMusic() end)
		elseif mp3choice==25 then
			LocalPlayer():EmitSound("lostmusic/32.mp3",lostvolume,100)
			timer.Simple(300+(math.random(260,300)),function()musicoff = false LostMusic() end)
		elseif mp3choice==26 then
			LocalPlayer():EmitSound("lostmusic/33.mp3",lostvolume,100)
			timer.Simple(98+(math.random(120,180)),function()musicoff = false LostMusic() end)
		elseif mp3choice==27 then
			LocalPlayer():EmitSound("lostmusic/34.mp3",lostvolume,100)
			timer.Simple(128+(math.random(260,300)),function()musicoff = false LostMusic() end)
		elseif mp3choice==28 then
			LocalPlayer():EmitSound("lostmusic/35.mp3",lostvolume,100)
			timer.Simple(240+(math.random(260,300)),function()musicoff = false LostMusic() end)
		elseif mp3choice==29 then
			LocalPlayer():EmitSound("lostmusic/36.mp3",lostvolume,100)
			timer.Simple(89+(math.random(130,180)),function()musicoff = false LostMusic() end)
		end
	end

end
timer.Simple(15,LostMusic)

function MusicOnOff()
	if IsMusicOn == true then
		IsMusicOn = false
		RunConsoleCommand("stopsound")
		musicoff = false
	elseif IsMusicOn == false then
		IsMusicOn = true
		LostMusic()
	end
end
concommand.Add("lost_music_onoff",MusicOnOff)