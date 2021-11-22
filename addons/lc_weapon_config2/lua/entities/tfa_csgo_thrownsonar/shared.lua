AddCSLuaFile()

if SERVER then
	util.AddNetworkString("TFA_SONAR_EXPLODE")
end

ENT.Type      = "anim"
ENT.Spawnable = false

ENT.FindRadius = 250

ENT.Model = "models/weapons/tfa_csgo/w_sensorgrenade_thrown.mdl"

function ENT:Initialize()
	if SERVER then
		self:SetModel(self.Model)

		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_NONE)

		local phys = self:GetPhysicsObject()
		if IsValid(phys) then
			phys:Wake()
		end
	end
	self:EmitSound("TFA_CSGO_HEGrenade.Throw")
end

function ENT:Think()
	if CLIENT then
		local CT = CurTime()
		local FT = FrameTime()
		local attach = self:LookupAttachment("Wick")
		local data = self:GetAttachment(attach)
		local attpos,attangs
		attpos = data.Pos
		attangs = data.Ang

		if self:GetNWBool("Fused") then
			ParticleEffect("weapon_sensorgren_beeplight",attpos,attangs,self)
			self.ParticleCreated = true
			self:StopParticles()
			if self.FuseTime then
				if self.FuseTime <= CT then
					if not self.NextBeep then
						self.DetonateTime = CT + 1.5
						self.NextBeep     = 0
					end

					self.NextBeep = self.NextBeep - FT * 6
					self:StopParticles()
					self.ParticleCreated = false

					if self.NextBeep <= 0 and self.ParticleCreated == false then
						self.NextBeep = 1
					end
				end
			else
				self.FuseTime = CT + 0.65
				self:StopParticles()
			end
		end
	end
end

function ENT:Use(activator, caller)
	return false
end

function ENT:OnRemove()
	return false
end

local function EntityFacingFactor(ent1, ent2)
	local dir       = ent2:EyeAngles():Forward()
	local facingdir = (ent1:GetPos() - (ent2.EyePos and ent2:EyePos() or ent2:GetPos())):GetNormalized()
	return (facingdir:Dot(dir) + 1) / 2
end

if SERVER then
	local tr = {}

	function ENT:Detonate()
		local origin = self:GetPos()

		if IsValid(self.Owner) then
			local _ents = ents.FindInSphere(origin, self.FindRadius)
			local tab   = {}

			for k, v in pairs(_ents) do
				if v:IsNPC() or v:IsPlayer() then
					if v ~= self.Owner then
						table.insert(tab, v)
					end
				end
			end

			net.Start("TFA_SONAR_EXPLODE")
			net.WriteTable(tab)
			net.Send(self.Owner)
		end

		tr.start = origin
		tr.mask  = MASK_SOLID

		for k, v in pairs(player.GetAll()) do
			tr.endpos = v:EyePos()
			tr.filter = { self, v, v:GetActiveWeapon() }

			local trace = util.TraceLine(tr)
			if not trace.Hit or trace.Fraction >= 1 or trace.Fraction <= 0 then
				v:SetNWFloat("LastFlash", CurTime() - 4)
				v:SetNWFloat("FlashDistance", tr.endpos:Distance(origin))
				v:SetNWFloat("FlashFactor", EntityFacingFactor(self, v) * 0.5)
			end
		end

		self:EmitSound("TFA_CSGO_Sensor.Detonate")
		
		local explode = ents.Create( "info_particle_system" )
		explode:SetKeyValue( "effect_name", "weapon_sensorgren_detonate" )
		explode:SetOwner( self.Owner )
		explode:SetPos( self:GetPos() )
		explode:Spawn()
		explode:Activate()
		explode:Fire( "start", "", 0 )
		explode:Fire( "kill", "", 30 )
		
		SafeRemoveEntity(self)
	end

	function ENT:Fuse(ent)
		if SERVER then
			self.WeldEnt = constraint.Weld(self, ent, 0, 0, 0, true, false)

			self:EmitSound("TFA_CSGO_Sensor.Activate")
			timer.Simple(3, function()
				if IsValid(self) then
					self:StopParticles()
					self:Detonate()
				end
			end)
		end
	end

	function ENT:PhysicsCollide(data, physObj)
		if not self:GetNWBool("Fused") then
			if data.HitEntity then
				if not (data.HitEntity:IsNPC() or data.HitEntity:IsPlayer()) then
					self:SetNWBool("Fused", true)

					timer.Simple(0, function()
						if IsValid(self) then
							self:EmitSound("TFA_CSGO_Sensor.Land")
							self:Fuse(data.HitEntity)
						end
					end)
				end
			end
		end
		orient_angles(physObj,data)
	end
	
	function orient_angles(obj, data) --this function juts takes in the hitnormal of the collision and rotates the angles accordingly
		if data.HitNormal.z < -.5 then
			return 
		end
		if data.HitNormal.z > .5 then
			obj:SetAngles((data.HitNormal + Vector(-90,0,0) ):Angle())
			return 
		end
		if data.HitNormal.y < -.5 then
			obj:SetAngles((data.HitNormal + Vector(0,0,90) ):Angle())
			return 
		end
		if data.HitNormal.y > .5 then
			obj:SetAngles((data.HitNormal + Vector(0,0,90) ):Angle())
			return 
		end
		if data.HitNormal.x < -.5 then
			obj:SetAngles((data.HitNormal + Vector(0,0,90) ):Angle())
			return 
		end
		if data.HitNormal.x > .5 then
			obj:SetAngles((data.HitNormal + Vector(0,0,90) ):Angle())
			return 
		end
	end
	
end



if CLIENT then

	local tr, col = {}, Color(255, 25, 25)
	local glow = Material("tfa_csgo/sprites/flare_sprite_02")

	function ENT:Draw()
		local ply = LocalPlayer()
		local attach = self:LookupAttachment("Wick")
		local data = self:GetAttachment(attach)
		local attpos,attangs
		attpos = data.Pos
		attangs = data.Ang
		
		self:DrawModel()

		local CT = CurTime()
		
		if self.NextBeep then
			if self.NextBeep > 0 then
				tr.start  = self:GetPos()
				tr.endpos = ply:EyePos()
				tr.mask   = MASK_SOLID
				tr.filter = { self, ply, ply:GetActiveWeapon() }

				local trace    = util.TraceLine(tr)
				local fraction = trace.Fraction

				if self.DetonateTime > CT then
					self:StopParticles()
				end
			end
		end
	end

	local TFA_HaloManager = {}
	TFA_HaloManager.EVENT_NAME = "TFA_SONAR"

	local function TFA_SONAR_CREATE_HALOS(len, ply)
		local _ents = net.ReadTable()

		timer.Simple(0.5, function()
			if istable(_ents) then
				for k, v in pairs(_ents) do
					if IsValid(v) then
						TFA_HaloManager:Add(v, 3)
					end
				end
			end
		end)
	end

	-- Taken from Sakarias88's Intelligent HUD
	local function GetEntityAABB(ent)
		local mins = ent:OBBMins()
		local maxs = ent:OBBMaxs()

		local pos = {
			ent:LocalToWorld(Vector(maxs.x, maxs.y, maxs.z)):ToScreen(),
			ent:LocalToWorld(Vector(maxs.x, mins.y, maxs.z)):ToScreen(),
			ent:LocalToWorld(Vector(maxs.x, maxs.y, mins.z)):ToScreen(),
			ent:LocalToWorld(Vector(maxs.x, mins.y, mins.z)):ToScreen(),
			ent:LocalToWorld(Vector(mins.x, maxs.y, maxs.z)):ToScreen(),
			ent:LocalToWorld(Vector(mins.x, mins.y, maxs.z)):ToScreen(),
			ent:LocalToWorld(Vector(mins.x, maxs.y, mins.z)):ToScreen(),
			ent:LocalToWorld(Vector(mins.x, mins.y, mins.z)):ToScreen()
		}

		local minX = pos[1].x
		local minY = pos[1].y

		local maxX = pos[1].x
		local maxY = pos[1].y

		for k = 2, 8 do
			if pos[k].x > maxX then
				maxX = pos[k].x
			end

			if pos[k].y > maxY then
				maxY = pos[k].y
			end

			if pos[k].x < minX then
				minX = pos[k].x
			end

			if pos[k].y < minY then
				minY = pos[k].y
			end
		end

		return Vector(minX, minY), Vector(maxX, maxY)
	end

	net.Receive("TFA_SONAR_EXPLODE", TFA_SONAR_CREATE_HALOS)

	function TFA_HaloManager:Add(ent, t)
		table.insert(self, {ent = ent, t = CurTime() + t})
		self:Enable()
	end

	local _ents = {}
	local halo_color = Color(255, 0, 0)

	function TFA_HaloManager:Enable()
		local events = hook.GetTable()

		local tab = events["PreDrawHalos"]

		if tab and not tab[self.EVENT_NAME] or not tab then
			hook.Add("PreDrawHalos", self.EVENT_NAME, function()
				self:DrawHalo()
			end)
		end

		local tab = events["PostDrawOpaqueRenderables"]

		if tab and not tab[self.EVENT_NAME] or not tab then
			hook.Add("PostDrawOpaqueRenderables", self.EVENT_NAME, function()
				self:Draw()
			end)
		end
	end

	function TFA_HaloManager:Disable()
		hook.Remove("PreDrawHalos", self.EVENT_NAME)
		hook.Remove("PostDrawOpaqueRenderables", self.EVENT_NAME)
	end

	local mat1 = Material("models/debug/debugwhite")
	function TFA_HaloManager:Draw()
		for k, v in ipairs(self) do
			if not IsValid(v.ent) then self[k] = nil continue end
			render.ClearStencil()
			render.SetStencilEnable(true)

			render.SetStencilWriteMask(255)
			render.SetStencilTestMask(255)
			render.SetStencilReferenceValue(1)

			render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
			render.SetStencilFailOperation(STENCILOPERATION_KEEP)
			render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
			render.SetStencilZFailOperation(STENCILOPERATION_REPLACE)

			v.ent:DrawModel()

			render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)

			local mins, maxs = GetEntityAABB(v.ent)

			cam.Start2D()
				local health    = v.ent:Health()
				local maxHealth = v.ent:GetMaxHealth()

				local mul = math.Clamp(health / maxHealth, 0, 1)

				local x = mins.x
				local y = mins.y + (maxs.y - mins.y) * mul

				local w = maxs.x - x
				local h = maxs.y - y

				surface.SetDrawColor(255, 0, 0, 32)
				surface.DrawRect(x, y, w, h)
			cam.End2D()

			render.SetStencilEnable(false)
		end
	end

	function TFA_HaloManager:DrawHalo()
		local CT = CurTime()

		for i = 1, #_ents do
			_ents[i] = nil
		end

		for k, v in ipairs(self) do
			if (not IsValid(v.ent) or v.ent:Health() <= 0) or v.t <= CT then
				table.remove(self, k)
			else
				table.insert(_ents, v.ent)
			end
		end

		halo.Add(_ents, halo_color, 2, 2, 2, true, true )

		if #self <= 0 then
			self:Disable()
		end
	end
end