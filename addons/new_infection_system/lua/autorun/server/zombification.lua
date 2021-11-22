CreateConVar("zombification_on", "1", {FCVAR_GAMEDLL})
CreateConVar("zombification_chance", "3", {FCVAR_GAMEDLL})
CreateConVar("zombification_nhi", "0", {FCVAR_GAMEDLL})
CreateConVar("zombification_nhi_chance", "0", {FCVAR_GAMEDLL})
CreateConVar("zombification_ep1", "0", {FCVAR_GAMEDLL})

util.AddNetworkString( "DeadlyZombies_cvar" )

local whitelist = {
	"npc_vj_zss_zombfast2",
	"npc_vj_zss_zombfast4",
	"npc_vj_zss_zombfast5",
	"npc_vj_zss_zombfast6",
	"npc_vj_zss_zombie1",
	"npc_vj_zss_zombie2",
	"npc_vj_zss_zombie3",
	"npc_vj_zss_zombie4",
	"npc_vj_zss_zombie5",
	"npc_vj_zss_zombie6",
	"npc_vj_zss_zombie7",
	"npc_vj_zss_zombie8",
	"npc_vj_zss_zombie9",
	"npc_vj_zss_zombie10",
	"npc_vj_zss_zombie11",
	"npc_vj_zss_zombie12",
	"npc_vj_cof_childq",
	"npc_vj_cof_citalopram",
	"npc_vj_cof_crawler",
	"npc_vj_cof_crazyrunner",
	"npc_vj_cof_croucher",
	"npc_vj_cof_faster",
	"npc_vj_cof_krypandenej",
	"npc_vj_cof_mace",
	"npc_vj_cof_phsycho",
	"npc_vj_cof_sawcrazy",
	"npc_vj_cof_sawrunner",
	"npc_vj_cof_sawer",
	"npc_vj_cof_sewmo",
	"npc_vj_cof_slower1",
	"npc_vj_cof_slower3",
	"npc_vj_cof_slowerstuck",	
	"npc_vj_cof_slowerno",
	"npc_vj_cof_taller",
	"npc_vj_cof_upper",
}

local humans = {
	"npc_alyx",
	"npc_barney",
	"npc_citizen",
	"npc_magnusson",
	"npc_kleiner",
	"npc_mossman",
	"npc_gman",
	"npc_odessa",
	"npc_breen",
	"npc_monk"
}

local combine = "npc_combine_s"

local headcrabs = {
	"npc_headcrab_fast",
	"npc_headcrab",
	"npc_headcrab_black"
}

local canChageTo = {
	"npc_zombie",
	"npc_fastzombie"
}

resource.AddFile("materials/effects/deadlyzombies/zombie_effect.vmt")
resource.AddFile("materials/effects/deadlyzombies/zombie_effect_dx80.vmt")
resource.AddFile("materials/effects/deadlyzombies/zombie_effect_normal.vtf")
resource.AddFile("materials/effects/deadlyzombies/zombie_effect_overlay.vtf")
resource.AddFile("sound/deadlyzombies/stage2_sound.mp3")

function HandleZombieHit(target, dmginfo)
	if GetConVar("zombification_on"):GetInt() == 1 then
		if target:IsPlayer() or table.HasValue(humans, target:GetClass()) or (target:GetClass() == combine and GetConVar("zombification_ep1"):GetInt() == 1) then
			local attacker = dmginfo:GetAttacker()

			if table.HasValue(whitelist, attacker:GetClass()) and !target.infected then
				local chance = GetConVar("zombification_chance"):GetInt()
				local randomnum = math.random(100)

				if randomnum <= chance then
					local infection = ents.Create("zombification_entity")
						infection:SetPos(target:GetPos())
						infection:SetVar("Infected", target)
					infection:Spawn()
					infection:Activate()

					target.infected = true


					if table.HasValue(headcrabs, attacker:GetClass()) then
						attacker:Remove()
					end
				end
			end
		end
	end
end

net.Receive( "DeadlyZombies_cvar", function( length, client )
	if client:IsSuperAdmin() then
		RunConsoleCommand( net.ReadString(), net.ReadFloat() )
	end
end )

hook.Add("EntityTakeDamage", "ZombificationOnHit", HandleZombieHit)