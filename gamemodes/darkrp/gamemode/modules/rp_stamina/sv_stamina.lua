local staminaRegenRate = 0.17
local staminaSprintCost = 0.1
local staminaJumpCost = 5

local baseRunSpeed = rp.cfg.RunSpeed
local baseWalkSpeed = rp.cfg.WalkSpeed 

function PLAYER:SetStamina( intValue )
	self:SetNVar( "Stamina", math.Clamp( intValue, 0, 100 ), NETWORK_PROTOCOL_PRIVATE)
	self.staminaLastUse = CurTime()
end

local breath = {"lostcity/player/breath_heavy.wav", "lostcity/player/breath_light.wav"}


function MovementHandler(pPlayer, stam)
	local finalRunSpeed = baseRunSpeed
	local finalWalkSpeed = baseWalkSpeed

	if isnumber(stam) then
		if stam < staminaJumpCost then
			pPlayer.canJump = false
			pPlayer:SetJumpPower( 0 )
		elseif not pPlayer.canJump or pPlayer:GetJumpPower() == 0 then
			pPlayer.canJump = true
			pPlayer:SetJumpPower( 160 )
		end

		local isLegBroken = pPlayer:GetNVar("Legbroken")
		local isHandsUp = pPlayer:GetNVar('PlayerSurrender')

		local temperaturePercent = ColdSystem:GetMovespeedPercent(pPlayer)
		local movementBoost = pPlayer:GetNVar("SprintBoost") or 0

		if isHandsUp == 1 or isLegBroken == true then
			finalRunSpeed = finalRunSpeed / 2
 			pPlayer.canSprint = false
 		elseif stam <= 0 or pPlayer:GetThirst() <= 0 then
 			finalRunSpeed = rp.cfg.WalkSpeed
			pPlayer.canSprint = false
		elseif stam <= 10 then
			finalRunSpeed = finalRunSpeed - 100
			pPlayer.canSprint = true
		elseif stam <= 20 then
			finalRunSpeed = finalRunSpeed - 80
			pPlayer.canSprint = true
		elseif stam <= 40 then
			finalRunSpeed = finalRunSpeed - 60
			pPlayer.canSprint = true
		elseif stam <= 80 then
			finalRunSpeed = finalRunSpeed - 40
			pPlayer.canSprint = true
		elseif stam > 80 then
			pPlayer.canSprint = true
  		end

		local illsPercent = 1
		if pPlayer.Ills then 
			for name, _ in pairs(pPlayer.Ills) do
				illsPercent = illsPercent - (1 - rp.Ills[name]:GetStaminaSpeedEffect())
			end
		end

  		finalRunSpeed = (finalRunSpeed + movementBoost) * (temperaturePercent/100) * illsPercent
		if finalRunSpeed < baseWalkSpeed then finalRunSpeed = baseWalkSpeed end
  		pPlayer:SetRunSpeed( finalRunSpeed )
	end
end

timer.Create("StaminaRegenerationTimer", 0.1, 0, function()
	for k, pPlayer in pairs( player.GetAll() ) do
		--print(pPlayer.canSprint, vel, pPlayer:OnGround())

		if not IsValid( pPlayer ) or not pPlayer:Alive() then continue end
		if pPlayer.canSprint == nil then pPlayer.canSprint = true end

		

		-- handle stamina
		local vel = pPlayer:GetVelocity():Length()
		local stam = pPlayer:GetStamina()

		if pPlayer.laststaminabreath == nil then
			pPlayer.laststaminabreath = CurTime()
		end
	
		if stam <= 7 and pPlayer.laststaminabreath < CurTime() then
			pPlayer.laststaminabreath = CurTime() + 1.5
			pPlayer:EmitSound(Sound("lostcity/player/breath_light.wav"), SNDLVL_45dB)
		elseif stam <= 25 and pPlayer.laststaminabreath < CurTime() then
			pPlayer.laststaminabreath = CurTime() + 3
			pPlayer:EmitSound(Sound("lostcity/player/breath_light.wav"), SNDLVL_45dB)
		end

		local AdditionalStaminaCost = 1
		if pPlayer.Ills then 
			for name, _ in pairs(pPlayer.Ills) do
				AdditionalStaminaCost = AdditionalStaminaCost - (1 - rp.Ills[name]:GetStaminaAmountEffect())
			end
		end

		if pPlayer:KeyDown( IN_SPEED ) and vel ~= 0 and pPlayer:OnGround() and pPlayer.canSprint then
			pPlayer:SetStamina(stam - staminaSprintCost * AdditionalStaminaCost)
		elseif stam < 100 then
			local mul = 0
			if pPlayer:OnGround() then 
				mul = 1 
			end

			pPlayer:SetStamina( stam + staminaRegenRate * mul )
		end

		MovementHandler(pPlayer, stam)
	end
end)

hook.Add( "SetupMove", "Stamina_Jump", function( pPlayer, mv, cmd )
	if pPlayer:Alive() and mv:KeyPressed( IN_JUMP ) and pPlayer:OnGround() and pPlayer:GetStamina() >= staminaJumpCost then
		pPlayer:SetStamina(pPlayer:GetStamina() - staminaJumpCost)
	end
end)

hook.Add('PlayerSpawn', 'SetupPlayerStamina', function(ply)
	ply:SetNVar( "Stamina", 100, NETWORK_PROTOCOL_PRIVATE)
	ply.canSprint = true
end)