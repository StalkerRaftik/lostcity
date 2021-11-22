function PLAYER:GetTemp() 
	return self:GetNVar("Temperature")
end

-- if CLIENT then
-- local center = Vector(-1014,-8175,384)
-- 	function SetSnow( state )
-- 		timer.Destroy("SnowEmitter")
-- 		if IsValid(SnowEmitter) then SnowEmitter:Finish() end
-- 		if not IsValid(LocalPlayer()) then return end
-- 		if not state then return end
-- 		SnowEmitter = SnowEmitter or ParticleEmitter( LocalPlayer():GetPos(), false )
-- 		local radius = 768
-- 		local height = -64
-- 		timer.Create("SnowEmitter", .1, 0, function()

-- 			local ply = LocalPlayer()
-- 			local pos = ply:GetShootPos() + ply:GetVelocity()

-- 			local tr = util.TraceLine({
-- 				start = ply:GetPos(), 
-- 				endpos = ply:GetPos() + Vector(0,0,16384),
-- 				filter = ply
-- 			})
			
-- 			--PrintTable( tr )

-- 			if not tr.HitSky then return end
-- 			if not IsValid(SnowEmitter) then return end
-- 			local part = SnowEmitter:Add( "particle/smokesprites_000" .. math.random(1,9), tr.HitPos + ply:GetVelocity() + Vector( math.random(-radius,radius), math.random(-radius,radius), height) )
-- 			local size = 4
-- 			part:SetColor(255,255,255)
-- 			part:SetAngles( Angle(90, math.random(-180,180),0) )
-- 			part:SetAngleVelocity( Angle( 0, 2500, 2500) )
-- 			part:SetStartAlpha( 225 )
-- 			part:SetVelocity( Vector( math.random(-12,12), math.random(-12,12), -32) )
-- 			part:SetDieTime(15)
-- 			part:SetLifeTime(0)
-- 			part:SetStartSize(size)
-- 			part:SetEndSize(size/2)
-- 			part:SetCollide(true)
-- 			part:SetBounce(0.025)
-- 			part:SetGravity(Vector(0,0,-32))
-- 			part:SetAirResistance(0)
-- 			--part:SetCollideCallback(function(p,hitpos,hitnormal)
-- 			--	if math.random(3) > 1 then
-- 			--		util.Decal("splash.large", hitpos + hitnormal, hitpos - hitnormal )
-- 					--EmitSound( table.Random(cumsounds), part:GetPos(), ply:EntIndex(), CHAN_AUTO, 1, 40, 0, 100)
-- 			--	end
-- 			--end)
-- 			part:SetThinkFunction( function( p )
-- 				p:SetAngles( Angle(90, CurTime() * 10 % 360, CurTime() * 10 % 360 ) )
-- 			end)
-- 		end)
-- 	end

-- 	hook.Add("PlayerIsLoaded", "Snow", function(ply)
-- 		local c = true
-- 		SetSnow( c )
-- 	end)

-- 	local function hookcold(ply)

-- 		if not ply then return end
-- 		if not IsValid(ply) then return end

-- 		local tm = "PlayerCold" .. ply:UniqueID()

-- 		ply.breath = ParticleEmitter( ply:GetShootPos() , false)

-- 		local b = ply.breath

-- 		timer.Create(tm, 3, 0, function()

-- 			if not IsValid(ply) then
-- 				timer.Remove(tm)
-- 				b:Finish()
-- 				return
-- 			end

-- 			if not ply:Alive() or ply:GetNoDraw() == true then return end
-- 			if ply:GetPos():Distance(LocalPlayer():GetPos()) > 1024 then return end

-- 			local tr = util.TraceLine({
-- 				start = ply:GetPos(),
-- 				endpos = ply:GetPos() + Vector(0,0,16384),
-- 				filter = ply
-- 			})

-- 			if not tr.HitSky then return end

-- 			local BoneIndx = ply:LookupBone("ValveBiped.Bip01_Head1")

-- 			for i = 1,4 do
-- 				timer.Simple(i / 8, function()

-- 					if not IsValid(ply) then return end

-- 					local pos = Vector(0,0,0)

-- 					if BoneIndx then
-- 						local BonePos, BoneAng = ply:GetBonePosition(BoneIndx)
-- 						pos = Vector(BonePos.x, BonePos.y, BonePos.z) + BoneAng:Right() * 5 + BoneAng:Forward() * 0
-- 					else
-- 						pos = ply:EyePos() + ply:GetForward() * 2 + ply:GetUp() * -3
-- 					end

-- 					local particle = ply.breath:Add(string.format('particle/smokesprites_00%02d',math.random(7,16)), pos)
-- 					particle:SetVelocity((ply:GetForward() * 10) + (ply:GetVelocity() * 0.9))
-- 					particle:SetDieTime(2.0)
-- 					particle:SetStartAlpha(LocalPlayer():ShouldDrawLocalPlayer() and 30 or 5)
-- 					particle:SetEndAlpha(0)
-- 					particle:SetStartSize(0)
-- 					particle:SetEndSize(math.Rand(4, 7))
-- 					particle:SetRoll(math.Rand(-1, 1))
-- 					particle:SetColor(200, 200, 210)
-- 					particle:SetGravity(Vector(3, 3, 8))
-- 					particle:SetCollide(true)
-- 					particle:SetBounce(0.1)
-- 					particle:SetAirResistance(15)
-- 				end)
-- 			end

-- 		end)
-- 		--end
-- 	end

-- 	for _, ply in pairs(player.GetAll()) do
-- 		hookcold(ply)
-- 	end

	
-- 	hook.Add("OnEntityCreated", "ColdHook", function(ent)
-- 		if IsValid(ent) and ent:IsPlayer() then
-- 			hookcold(ent)
-- 		end
-- 	end)
	
-- end
