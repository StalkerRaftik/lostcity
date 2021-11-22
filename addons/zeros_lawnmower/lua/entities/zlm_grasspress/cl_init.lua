include("shared.lua")

function ENT:Initialize()
	self.LastGrass = -1
	self.GrassScale = 1
	self.LastState = 0

	self.IsRunning = false
	self.LastRunning = false

	self.TimeStamp = -1

	self.LoopedEffect = false
end

function ENT:Draw()
	self:DrawModel()

	if zlm.f.InDistance(LocalPlayer():GetPos(), self:GetPos(), 300) then
		self:DrawScreenUI()
	end
end

function ENT:DrawScreenUI()
	local Pos = self:GetPos() + self:GetUp() * 49.5 + self:GetRight() * -34
	local Ang = self:GetAngles()
	Ang:RotateAroundAxis(self:GetRight(),90)
	Ang:RotateAroundAxis(self:GetForward(),90)
	Ang:RotateAroundAxis(self:GetUp(),-90)

	cam.Start3D2D(Pos, Ang, 0.1)

		//BG
		draw.RoundedBox(1, -150 , -100, 300, 200,  zlm.default_colors["grey01"])


		//Enable Button
		if self:EnableButton(LocalPlayer()) then
			draw.RoundedBox(5, -145 , -78, 50, 50,  zlm.default_colors["orange01"])
		else
			if self.IsRunning then
				draw.RoundedBox(5, -145, -78, 50, 50, zlm.default_colors["red01"])
			else
				draw.RoundedBox(5, -145, -78, 50, 50, zlm.default_colors["green01"])
			end
		end

		surface.SetDrawColor(zlm.default_colors["black02"])
		surface.SetMaterial(zlm.default_materials["switch"])
		surface.DrawTexturedRect(-140, -73, 40, 40)
		draw.NoTexture()

		if zlm.config.GrassPress.Upgrades.Enabled then

			//Title
			draw.RoundedBox(5, -90 , -78, 234, 50,  zlm.default_colors["white02"])
			draw.SimpleText(zlm.language.General["Storage"] .. ": " .. self:GetGrassCount() .. zlm.config.UoW, "zlm_grasspress_font02", -80, -67, zlm.default_colors["white01"], TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

			//Upgrade Button
			self:DrawUpgrade()

			draw.RoundedBox(5, -145 , -22, 50, 50,  zlm.default_colors["white02"])
			draw.SimpleText(self:GetUpgradeLevel(), "zlm_grasspress_font01", -120, -19, zlm.default_colors["white01"], TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		else
			//Title
			draw.RoundedBox(5, -90 , -78, 234, 50,  zlm.default_colors["white02"])
			draw.SimpleText(zlm.language.General["Storage"] .. ": ", "zlm_grasspress_font02", -80, -67, zlm.default_colors["white01"], TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			draw.SimpleText(self:GetGrassCount() .. zlm.config.UoW, "zlm_grasspress_font02", 0, -12, zlm.default_colors["white01"], TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)


			draw.RoundedBox(5, -145 , -22, 290, 50,  zlm.default_colors["white02"])
		end

		//Progress Bar
		local ts = self:GetProduction_TimeStamp()

		draw.RoundedBox(5, -145 , 35, 290, 50,  zlm.default_colors["white02"])
		if ts ~= -1 then

			//local p_Time = zlm.config.GrassPress.Production_Time - ((zlm.config.GrassPress.Production_Time / zlm.config.GrassPress.Upgrades.Count) * self:GetUpgradeLevel())
			local p_Time
			p_Time = zlm.config.GrassPress.Production_Time - zlm.config.GrassPress.Production_TimeLimit
	        p_Time = (p_Time / zlm.config.GrassPress.Upgrades.Count) * self:GetUpgradeLevel()
	        p_Time =  zlm.config.GrassPress.Production_Time - p_Time

			p_Time = math.Clamp(math.Round(p_Time), zlm.config.GrassPress.Production_TimeLimit, zlm.config.GrassPress.Production_Time)

			local progress = p_Time - (ts - CurTime())
			local width = (290 / p_Time) * progress
			draw.RoundedBox(5, -145 , 35, width, 50,  zlm.default_colors["green02"])
		end

	cam.End3D2D()
end

function ENT:DrawUpgrade()
	if self:GetUpgradeLevel() < zlm.config.GrassPress.Upgrades.Count then

		if self:GetUCooldDown() > CurTime() then

			draw.RoundedBox(5, -90, -22, 234, 50, zlm.default_colors["white02"])
			draw.DrawText(math.Round(self:GetUCooldDown() - CurTime()) .. "s", "zlm_grasspress_font02", 20, -10, zlm.default_colors["white01"], TEXT_ALIGN_CENTER)
		else

			if self:UpgradButton(LocalPlayer()) then
				draw.RoundedBox(5, -90, -22, 234, 50, zlm.default_colors["orange01"])
				draw.SimpleText( zlm.config.Currency .. zlm.config.GrassPress.Upgrades.Price , "zlm_grasspress_font03", 25, -17, zlm.default_colors["white01"], TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			else
				draw.RoundedBox(5, -90, -22, 234, 50, zlm.default_colors["white02"])
				draw.SimpleText(zlm.language.General["UpgradeSpeed"], "zlm_grasspress_font02", 25, -13, zlm.default_colors["white01"], TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			end

		end
	else
		draw.RoundedBox(5, -90, -22, 234, 50, zlm.default_colors["white02"])
		draw.DrawText(zlm.language.General["MaxLevel"], "zlm_grasspress_font02", 20, -10, zlm.default_colors["white01"], TEXT_ALIGN_CENTER)
	end
end



function ENT:DrawTranslucent()
	self:Draw()
end

function ENT:PressSound()

	if self.IsRunning == false then

		if self.IDLESoundObj ~= nil and self.IDLESoundObj:IsPlaying() then
			self.IDLESoundObj:Stop()
		end

		if self.RUNSoundObj ~= nil and self.RUNSoundObj:IsPlaying() then
			self.RUNSoundObj:Stop()
		end

		if self.LoopedEffect == true then
			self:StopParticles()
			self.LoopedEffect = false
		end

		return
	end

	if self.LastState == 0 then
		if self.RUNSoundObj ~= nil and self.RUNSoundObj:IsPlaying() then
			self.RUNSoundObj:Stop()
			self:StopParticles()
		end



		local SoundObj = CreateSound(self, "zlm_grasspress_idle")

		// IDLE SOUND
		if self.IDLESoundObj == nil then
			self.IDLESoundObj = SoundObj
		end

		if self.IDLESoundObj:IsPlaying() == false then

			self.IDLESoundObj:Play()
			self.IDLESoundObj:ChangeVolume(0, 0)
			self.IDLESoundObj:ChangeVolume(GetConVar("zlm_cl_sfx_volume"):GetFloat() * 0.5, 0)
		end

		if self.LoopedEffect == false then

			self:StopParticles()

			// Use attachment point for it
			ParticleEffectAttach( "zlm_spinair", PATTACH_POINT_FOLLOW, self,2 )
			ParticleEffectAttach( "zlm_spinair", PATTACH_POINT_FOLLOW, self,3 )
			ParticleEffectAttach( "zlm_spinair", PATTACH_POINT_FOLLOW, self,4 )

			ParticleEffectAttach( "zlm_suckair", PATTACH_POINT_FOLLOW, self,5 )

			self.LoopedEffect = true
		end
	elseif self.LastState == 1 then

		if self.IDLESoundObj ~= nil and self.IDLESoundObj:IsPlaying() then
			self.IDLESoundObj:Stop()
		end

		local SoundObj = CreateSound(self, "zlm_grasspress_run")

		// Press Sound
		if self.RUNSoundObj == nil then
			self.RUNSoundObj = SoundObj
		end

		if self.RUNSoundObj:IsPlaying() == false then


			self.RUNSoundObj:Play()
			self.RUNSoundObj:ChangeVolume(0, 0)
			self.RUNSoundObj:ChangeVolume(GetConVar("zlm_cl_sfx_volume"):GetFloat(), 0)
		end

		if self.LoopedEffect == false then

			self:StopParticles()


			// Use attachment point for it
			ParticleEffectAttach( "zlm_collect", PATTACH_POINT_FOLLOW, self,5 )

			self.LoopedEffect = true
		end
	else

		if self.LoopedEffect == true then
			self:StopParticles()
			self.LoopedEffect = false
		end

		if self.RUNSoundObj ~= nil and self.RUNSoundObj:IsPlaying() then

			self.RUNSoundObj:Stop()

			local soundData = zlm.f.CatchSound("zlm_tractor_unload")
			EmitSound(soundData.sound, self:GetPos(), self:EntIndex(), CHAN_STATIC, soundData.volume, soundData.lvl, 0, soundData.pitch)
		end
	end
end


function ENT:Think()
	self:SetNextClientThink(CurTime())

	// ClientModel
	if zlm.f.InDistance(LocalPlayer():GetPos(), self:GetPos(), 2000) then

		if self.ClientProps then

			if self.LastGrass ~= self:GetGrassCount() then

				self.LastGrass = self:GetGrassCount()

				if not IsValid(self.ClientProps["GrassPile"]) then
					self:SpawnClientModel_GrassPile()
				end
			end

			if IsValid(self.ClientProps["GrassPile"]) then
				self:UpdateGrass_Visual()
			end

			if IsValid(self.ClientProps["GrassRoll"]) then

				if self:GetProgressState() == 2 then

					local attach = self:GetAttachment(1)
					self.ClientProps["GrassRoll"]:SetPos(attach.Pos)
					self.ClientProps["GrassRoll"]:SetLocalPos(Vector(0,0,0))

					local ang = attach.Ang
					ang:RotateAroundAxis(ang:Up(),90)
					self.ClientProps["GrassRoll"]:SetAngles(ang)

					if self.ClientProps["GrassRoll"]:GetNoDraw() == true then
						self.ClientProps["GrassRoll"]:SetNoDraw(false)
					end
				else
					if self.ClientProps["GrassRoll"]:GetNoDraw() == false then
						self.ClientProps["GrassRoll"]:SetNoDraw(true)
					end
				end
			else
				self:SpawnClientModel_GrassRoll()
			end
		else
			self.ClientProps = {}
		end

		self.IsRunning = self:GetIsRunning()

		self:Update_State()
		self:PressSound()
	else
		self:RemoveClientModels()
		self.LastGrass = -1
		self.GrassScale = -1

		self:StopParticles()
		self.LoopedEffect = false
	end

	return true
end

function ENT:Update_State()
	local currentState = self:GetProgressState()

	if currentState ~= self.LastState or self.IsRunning ~= self.LastRunning then

		self.LastState = currentState
		self.LastRunning = self.IsRunning

		// Reset Effects since the state changed
		self:StopParticles()
		self.LoopedEffect = false

		// Update the animation
		self:Update_Animation()
	end
end

function ENT:Update_Animation()
	if self.LastState == 0 and self.IsRunning == false then
		zlm.f.PlayClientAnimation(self, "idle", 1)
	elseif self.LastState == 1 or (self.LastState == 0 and self.IsRunning == true) then
		zlm.f.PlayClientAnimation(self, "fill", 2)
	elseif self.LastState == 2 then
		zlm.f.PlayClientAnimation(self, "unload", 1)
	end
end

function ENT:UpdateGrass_Visual()
	local newScale = (0.75 / zlm.config.GrassPress.Capacity) * self.LastGrass
	newScale = math.Clamp(newScale,0,0.75)

	if self.GrassScale ~= newScale then

		if self.LastGrass <= 0 then
			self.ClientProps["GrassPile"]:SetNoDraw(true)
		else
			self.ClientProps["GrassPile"]:SetNoDraw(false)
		end

		if newScale > self.GrassScale then

			self.GrassScale = self.GrassScale + 0.5 * FrameTime()
			self.GrassScale = math.Clamp(self.GrassScale, 0, newScale)
		else
			self.GrassScale = self.GrassScale - 0.1 * FrameTime()
			self.GrassScale = math.Clamp(self.GrassScale, 0, 0.75)
		end

		self.ClientProps["GrassPile"]:SetModelScale(self.GrassScale)
	end
end



function ENT:SpawnClientModel_GrassPile()
	local ent = ents.CreateClientProp("models/zerochain/props_lawnmower/zlm_grasspile.mdl")
	ent:SetPos(self:GetPos() +  self:GetForward() * 70)
	ent:SetAngles(self:GetAngles())
	ent:Spawn()
	ent:Activate()
	ent:SetParent(self)
	ent:SetRenderMode(RENDERMODE_NORMAL)
	self.ClientProps["GrassPile"] = ent
end

function ENT:SpawnClientModel_GrassRoll()
	local ent = ents.CreateClientProp("models/zerochain/props_lawnmower/zlm_grassroll.mdl")
	local attach = self:GetAttachment(1)
	if attach then
		ent:SetPos(attach.Pos)
		local ang = attach.Ang
		ang:RotateAroundAxis(ang:Up(),90)
		ent:SetAngles(ang)
		ent:Spawn()
		ent:Activate()
		ent:SetParent(self,1)
		ent:SetNoDraw(true)
		self.ClientProps["GrassRoll"] = ent
	end
end

function ENT:RemoveClientModels()
	if (self.ClientProps and table.Count(self.ClientProps) > 0) then
		for k, v in pairs(self.ClientProps) do
			if IsValid(v) then
				v:Remove()
			end
		end
	end

	self.ClientProps = {}
end

function ENT:OnRemove()
	self:RemoveClientModels()


	if self.IDLESoundObj ~= nil and self.IDLESoundObj:IsPlaying() then
		self.IDLESoundObj:Stop()
	end

	if self.RUNSoundObj ~= nil and self.RUNSoundObj:IsPlaying() then
		self.RUNSoundObj:Stop()
	end

	if self.LoopedEffect == true then
		self:StopParticles()
		self.LoopedEffect = false
	end
end
