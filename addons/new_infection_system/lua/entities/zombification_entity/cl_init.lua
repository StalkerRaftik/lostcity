include("shared.lua")

local contrast = 0
local interval = 0.5
local soundinterval = 10
local startedSound = false

local sounds = {
	"npc/headcrab/idle3.wav",
	"npc/barnacle/barnacle_digesting1.wav",
	"npc/barnacle/barnacle_digesting2.wav",
	"npc/fast_zombie/idle3.wav",
	"npc/fast_zombie/idle2.wav",
	"npc/fast_zombie/idle1.wav",
	"npc/zombie_poison/pz_call1.wav",
	"ambient/atmosphere/cave_hit1.wav",
	"ambient/atmosphere/cave_hit2.wav",
	"ambient/atmosphere/cave_hit3.wav",
	"ambient/atmosphere/cave_hit4.wav",
	"ambient/atmosphere/cave_hit5.wav",
	"ambient/atmosphere/cave_hit6.wav",
	"ambient/creatures/town_muffled_cry1.wav",
	"ambient/creatures/town_child_scream1.wav",
	"ambient/creatures/town_moan1.wav",
	"ambient/creatures/town_scared_breathing1.wav",
	"ambient/creatures/town_scared_breathing2.wav",
	"ambient/creatures/town_scared_sob1.wav",
	"ambient/creatures/town_scared_sob2.wav",
	"ambient/creatures/town_zombie_call1.wav"
}

function ENT:Draw()
	return false
end

function ENT:Think()
	if LocalPlayer() == self:GetNWEntity("Infected") then
		if self:GetNWBool("2stage") then
			if !startedSound then
				surface.PlaySound("deadlyzombies/stage2_sound.mp3")
				startedSound = true
			end

			if interval <= CurTime() then
				contrast = contrast + 0.003
				interval = CurTime() + 0.5
			end

			if soundinterval <= CurTime() then
				surface.PlaySound( sounds[math.random(#sounds)] )
				soundinterval = CurTime() + 10
			end

			local function Overlay()
				DrawMaterialOverlay( "effects/deadlyzombies/zombie_effect", 0.1 )

				local tab = {}
					tab[ "$pp_colour_addr" ] = 0.1
					tab[ "$pp_colour_addg" ] = 0
					tab[ "$pp_colour_addb" ] = 0
					tab[ "$pp_colour_brightness" ] = 0
					tab[ "$pp_colour_contrast" ] = 1 - contrast
					tab[ "$pp_colour_colour" ] = 1
					tab[ "$pp_colour_mulr" ] = 0
					tab[ "$pp_colour_mulg" ] = 0
					tab[ "$pp_colour_mulb" ] = 0
				DrawColorModify( tab )
 
			end
			hook.Add( "RenderScreenspaceEffects", "Zombieoverlay", Overlay )
		end
	end
end

function ENT:OnRemove()
	if LocalPlayer() == self:GetNWEntity("Infected") then
		hook.Remove("RenderScreenspaceEffects", "Zombieoverlay", Overlay)
		contrast = 0
		startedSound = false
		RunConsoleCommand("stopsound")
	end
end