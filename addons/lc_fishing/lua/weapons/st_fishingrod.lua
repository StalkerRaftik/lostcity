AddCSLuaFile()

SWEP.Category = "LostCity Weapon Other"
SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.PrintName = "Удочка"
SWEP.Base = "weapon_base"
SWEP.Author = "SirMorgen"
SWEP.Purpose = "Go fishing"
SWEP.Instructions = "Left click to cast your line\nRight click to pick bait"
SWEP.ViewModel = "models/weapons/v_stunbaton.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 90
SWEP.Slot = 1
SWEP.Primary.Ammo = nil
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Secondary.Ammo = nil
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Delay = 1
SWEP.UseHands = true
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.HoldType = "revolver"
SWEP.LureType = ""
SWEP.MinDepth = 50 --minimum water depth
SWEP.RoundTraces = 180 --number of traces when checking if there's room to fish
--if you experience bouts of high ping when about to cast a line, reduce this value

SWEP.Cast = false

SWEP.VElements = {
	["roller"] = { type = "Model", model = "", bone = "Bip01 R Hand", rel = "", pos = Vector(6.1, -3.513, 10.185), angle = Angle(0, 15.869, 97.402), size = Vector(0.259, 0.257, 0.155), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["handle"] = { type = "Model", model = "", bone = "Bip01 R Hand", rel = "", pos = Vector(3.513, -0.188, 5.083), angle = Angle(0, 0, -79.876), size = Vector(1.032, 1.032, 1.032), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["pole"] = { type = "Model", model = "models/oldprops/fishing_rod.mdl", bone = "Bip01 R Hand", rel = "", pos = Vector(1.494, -2.497, 1.379), angle = Angle(0, 0, 10.729), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["loop1++"] = { type = "Model", model = "models/props_canal/canal_cap001.mdl", bone = "Bip01 R Hand", rel = "", pos = Vector(5.361, 4.8, 37.986), angle = Angle(-79.343, 129.35, -4.062), size = Vector(0.01, 0.01, 0.01), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["loop1+"] = { type = "Model", model = "models/props_canal/canal_cap001.mdl", bone = "Bip01 R Hand", rel = "", pos = Vector(5.361, 3.184, 29.17), angle = Angle(-79.343, 129.35, -4.062), size = Vector(0.01, 0.01, 0.01), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["loop1"] = { type = "Model", model = "models/props_canal/canal_cap001.mdl", bone = "Bip01 R Hand", rel = "", pos = Vector(5.361, 1.812, 22.122), angle = Angle(-79.343, 129.35, -4.062), size = Vector(0.01, 0.01, 0.01), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["roller"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.527, -0.736, -6.907), angle = Angle(96.779, 32.883, 57.287), size = Vector(0.118, 0.118, 0.065), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["handle"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.122, 0.634, -5.19), angle = Angle(0, 0, 94.656), size = Vector(1.032, 1.032, 1.032), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["pole"] = { type = "Model", model = "models/oldprops/fishing_rod.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.594, 1.5, 2.1), angle = Angle(-180.699, -180.571, 2.451), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.ShowWorldModel = false
SWEP.ViewModelBoneMods = {
	["Dummy14"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}


function SWEP:Think()
	if self:GetOwner():GetActiveWeapon() != self then return end
	if CLIENT then --all of this is just to draw a circle for the client
		local tr = util.TraceLine( { --trace goes from eyes to water surface
			start = LocalPlayer():GetShootPos(),
			endpos = LocalPlayer():GetEyeTrace().HitPos,
			mask = MASK_WATER
		} )
		local qt = util.TraceLine( { --trace goes down from water surface
			start = tr.HitPos + Vector( 0, 0, 0 ),
			endpos = tr.HitPos - Vector( 0, 0, self.MinDepth ),
			mask = ALL_VISIBLE_CONTENTS - CONTENTS_WATER
		} )


	end
end

function SWEP:OnRemove()
	if CLIENT then
		hook.Remove( "PostDrawOpaqueRenderables", "DrawFishingCircle" )
	end
end

function SWEP:Holster()
	if CLIENT then
		hook.Remove( "PostDrawOpaqueRenderables", "DrawFishingCircle" )
	end
	return true
end

function SWEP:Deploy()
	return true
end

--[[-----------------------------------------[[--
    
    Function: Weapon.StartFishing
	Arg: o - The origin of the circle, IE
			where the lure will start.
    Realm: Shared
    Usage: st_fishingrod SWEP.PrimaryAttack
    Called: When the player casts their line
			into the water.

--]]-----------------------------------------]]--

function SWEP:GoFishing( o )
	--apply negative velocity to instantly freeze our target
	--this could maybe go wrong if two people fish at the exact same time
	local vel = self:GetOwner():GetVelocity()
	self:GetOwner():SetVelocity( Vector( -vel.x, -vel.y, -vel.z ) )
	--freeze the player while still accepting movement
	self:GetOwner():SetMoveType( MOVETYPE_NONE )
	--set the angle to freeze at
	self:GetOwner():SetNWAngle( "frozenang", self:GetOwner():EyeAngles() )
	
	--0.25 seconds is approximately the apex of the swing
	timer.Simple( 0.25, function()

		if SERVER then
			local ply = self:GetOwner()
			ply:EmitSound( "stfishing/rod-cast.wav" )
			self.Lure = ents.Create( "st_fishinglure" )
			self.Lure.IntOrigin = o --internal origin
			self.Lure.LureType = self.LureType
			self.Lure:SetPos( self:GetOwner():EyePos() )
			self.Lure:Spawn()
			self.Lure:SetModel( LURE_TYPES[ self.LureType ].model )
			self.Lure:SetModelScale( LURE_TYPES[ self.LureType ].scale )
			if self.LureType == "gumball" then
				self.Lure:SetColor( Color( 251, 185, 199 ) )
			end
			--toss the lure
			constraint.Keepupright( self.Lure, Angle(), 0, 999999 )
			self.Lure:SetOwner( self:GetOwner() )
			local phys = self.Lure:GetPhysicsObject()
			local force = 0.001 * ply.distFromLine + 123.5 --definitely not perfect but it works
			if phys and phys:IsValid() then
				phys:Wake()
				phys:SetVelocity( ( ply:GetAimVector() + ( ply:GetUp() ) ) * force )
			end

		end

	end )

end

function SWEP:PrimaryAttack()
	local ply = self:GetOwner()
	local abort = false

	--if the player is already fishing then abort
	if IsValid( ply:GetNWEntity( "plyLure" ) ) then return end
	if self:GetNWBool( "LineCast", false ) then return end

		--if we haven't selected any lure
		if self.LureType == "" then
			ply:FishMessage( "Купите наживку(ПКМ)!", true )
			abort = true
			return
		end

		--if the player is underwater
		if ply:WaterLevel() >= 2 then
			ply:FishMessage( "Вы не можете ловить рыбу, когда сами в воде!", true )
			abort = true
			return
		end

		local str = util.TraceLine( { --trace goes from eyes to water surface
			start = ply:GetShootPos(),
			endpos = ply:GetEyeTrace().HitPos,
			mask = MASK_WATER
		} )
		--if the player is looking at not a flat floor, that means we're not looking at water
		--i dont know, but it works as intended
		if str.HitNormal ~= Vector( 0, 0, 1 ) then
			ply:FishMessage( "Вы можете ловить рыбу только в воде!", true )
			abort = true
			return
		end

		local sqt = util.TraceLine( { --trace goes down from water surface
			start = str.HitPos,
			endpos = str.HitPos - Vector( 0, 0, self.MinDepth ),
			mask = ALL_VISIBLE_CONTENTS - CONTENTS_WATER
		} )
		--if the water isnt deep enough according to our var
		if sqt.HitPos.z - sqt.StartPos.z > -self.MinDepth then
			ply:FishMessage( "Это место недостаточно глубокое!", true )
			abort = true
			return
		end

		--if we're far away from where we wanna cast
		if ply:GetShootPos():DistToSqr( sqt.HitPos ) > 300000 then
			ply:FishMessage( "Вы слишком далеко!", true )
			abort = true
			return
		end
		ply.distFromLine = ply:GetShootPos():DistToSqr( sqt.HitPos ) --convenience for later
		--trace a whole circle degree-by-degree to see if anything's in the way
		local increment = ( 2 * math.pi ) / self.RoundTraces --one whole circle / how many traces
		for i=1, self.RoundTraces do
			local rt = util.TraceLine( {
				start = str.HitPos,
				endpos = str.HitPos + Vector( math.cos( increment * i ) * 100, math.sin( increment * i ) * 100, 0 )
			} )
			local rt2 = util.TraceLine( {
				start = rt.HitPos,
				endpos = rt.HitPos - Vector( 0, 0, self.MinDepth )
			} )
			if rt.Hit or rt2.Hit then
				ply:FishMessage( "Что-то мешает здесь ловить рыбу", true )
			abort = true
				return
			end
		end
	if not abort then
		self:SendWeaponAnim( ACT_VM_MISSCENTER )
		self:GetOwner():SetNWAngle( "frozenang", self:GetOwner():EyeAngles() )
		self:GetOwner().frozenang = self:GetOwner():EyeAngles()
		self:GetOwner():SetEyeAngles( self:GetOwner().frozenang )
		self.Cast = true --we dont even use this
		self:SetNWBool( "LineCast", true )		
		self:GoFishing( str.HitPos )
	end
end

net.Receive( "SelectLure", function()

	local ent = net.ReadEntity()
	local lure = net.ReadString()

	if DarkRP then
		if !ent:GetOwner():canAfford( LURE_TYPES[ lure ].price ) then 
			ent:GetOwner():FishMessage( "You cannot afford that lure.", true )
		return end
		ent:GetOwner():addMoney( -LURE_TYPES[ lure ].price )
		DarkRP.notify( ent:GetOwner(), 1, 5, "Вы купили наживку за " .. LURE_TYPES[ lure ].price .." монет" )
		ent.LureType = lure
		ent:GetOwner():FishMessage( "Выбрано " .. LURE_TYPES[ lure ].name, false )
	else
		ent.LureType = lure
		ent:GetOwner():FishMessage( "Выбрано " .. LURE_TYPES[ lure ].name .. " lure.", false )
	end

end )

function SWEP:SecondaryAttack()

	if self:GetNWBool( "LineCast", false ) then return end

	if SERVER then
		local tab = self:GetOwner():GetFishTable()
		tab = util.Compress( util.TableToJSON( tab ) )
		net.Start( "OpenLureMenu" )
			net.WriteEntity( self )
			net.WriteData( tab, #tab )
		net.Send( self:GetOwner() )
	end

end

--STFishing-specific code ends here
function SWEP:Initialize()
	self:SetHoldType( self.HoldType )
	self:SetNWBool( "LineCast", false )
	// other initialize code goes here
	if CLIENT then
	
		// Create a new table for every weapon instance
		self.VElements = table.FullCopy( self.VElements )
		self.WElements = table.FullCopy( self.WElements )
		self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )
		self:CreateModels(self.VElements) // create viewmodels
		self:CreateModels(self.WElements) // create worldmodels
		
		// init view model bone build function
		if IsValid(self.Owner) then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)
				
				// Init viewmodel visibility
				if (self.ShowViewModel == nil or self.ShowViewModel) then
					vm:SetColor(Color(255,255,255,255))
				else
					// we set the alpha to 1 instead of 0 because else ViewModelDrawn stops being called
					vm:SetColor(Color(255,255,255,1))
					// ^ stopped working in GMod 13 because you have to do Entity:SetRenderMode(1) for translucency to kick in
					// however for some reason the view model resets to render mode 0 every frame so we just apply a debug material to prevent it from drawing
					vm:SetMaterial("Debug/hsv")			
				end
			end
		end
		
	end
end
function SWEP:Holster()
	
	if CLIENT and IsValid(self.Owner) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end
	
	if IsValid( self ) and IsValid( self:GetOwner() ) and IsValid( self:GetOwner():GetNWEntity( "plyLure" ) ) or IsValid( self:GetOwner() ) and self:GetOwner():GetMoveType() == MOVETYPE_NONE then
		return false
	else return true end
end
function SWEP:OnRemove()
	self:Holster()
end
if CLIENT then
	SWEP.vRenderOrder = nil
	function SWEP:ViewModelDrawn()
		
		local vm = self.Owner:GetViewModel()
		if !IsValid(vm) then return end
		
		if (!self.VElements) then return end
		
		self:UpdateBonePositions(vm)
		if (!self.vRenderOrder) then
			
			// we build a render order because sprites need to be drawn after models
			self.vRenderOrder = {}
			for k, v in pairs( self.VElements ) do
				if (v.type == "Model") then
					table.insert(self.vRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.vRenderOrder, k)
				end
			end
			
		end
		for k, name in ipairs( self.vRenderOrder ) do
		
			local v = self.VElements[name]
			if (!v) then self.vRenderOrder = nil break end
			if (v.hide) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (!v.bone) then continue end
			
			local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
			
			if (!pos) then continue end
			
			if (v.type == "Model" and IsValid(model)) then
				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				model:SetAngles(ang)
				//model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()
			end
			
		end
		
	end
	SWEP.wRenderOrder = nil
	function SWEP:DrawWorldModel()
		
		if (self.ShowWorldModel == nil or self.ShowWorldModel) then
			self:DrawModel()
		end
		
		if (!self.WElements) then return end
		
		if (!self.wRenderOrder) then
			self.wRenderOrder = {}
			for k, v in pairs( self.WElements ) do
				if (v.type == "Model") then
					table.insert(self.wRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.wRenderOrder, k)
				end
			end
		end
		
		if (IsValid(self.Owner)) then
			bone_ent = self.Owner
		else
			// when the weapon is dropped
			bone_ent = self
		end
		
		for k, name in pairs( self.wRenderOrder ) do
		
			local v = self.WElements[name]
			if (!v) then self.wRenderOrder = nil break end
			if (v.hide) then continue end
			
			local pos, ang
			
			if (v.bone) then
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
			else
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
			end
			
			if (!pos) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (v.type == "Model" and IsValid(model)) then
				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				model:SetAngles(ang)
				//model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()
			end
			
		end
		
	end
	function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
		
		local bone, pos, ang
		if (tab.rel and tab.rel != "") then
			
			local v = basetab[tab.rel]
			
			if (!v) then return end
			
			// Technically, if there exists an element with the same name as a bone
			// you can get in an infinite loop. Let's just hope nobody's that stupid.
			pos, ang = self:GetBoneOrientation( basetab, v, ent )
			
			if (!pos) then return end
			
			pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
		else
		
			bone = ent:LookupBone(bone_override or tab.bone)
			if (!bone) then return end
			
			pos, ang = Vector(0,0,0), Angle(0,0,0)
			local m = ent:GetBoneMatrix(bone)
			if (m) then
				pos, ang = m:GetTranslation(), m:GetAngles()
			end
			
			if (IsValid(self.Owner) and self.Owner:IsPlayer() and 
				ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
				ang.r = -ang.r // Fixes mirrored models
			end
		
		end
		
		return pos, ang
	end
	function SWEP:CreateModels( tab )
		if (!tab) then return end
		// Create the clientside models here because Garry says we can't do it in the render hook
		for k, v in pairs( tab ) do
			if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and 
					string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then
				
				v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
				if (IsValid(v.modelEnt)) then
					v.modelEnt:SetPos(self:GetPos())
					v.modelEnt:SetAngles(self:GetAngles())
					v.modelEnt:SetParent(self)
					v.modelEnt:SetNoDraw(true)
					v.createdModel = v.model
				else
					v.modelEnt = nil
				end
				
			elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite) 
				and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then
				
				local name = v.sprite.."-"
				local params = { ["$basetexture"] = v.sprite }
				// make sure we create a unique name based on the selected options
				local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
				for i, j in pairs( tocheck ) do
					if (v[j]) then
						params["$"..j] = 1
						name = name.."1"
					else
						name = name.."0"
					end
				end

				v.createdSprite = v.sprite
				v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)
				
			end
		end
		
	end
	
	local allbones
	local hasGarryFixedBoneScalingYet = false

	function SWEP:UpdateBonePositions(vm)
		
		if self.ViewModelBoneMods then
			
			if (!vm:GetBoneCount()) then return end
			
			// !! WORKAROUND !! //
			// We need to check all model names :/
			local loopthrough = self.ViewModelBoneMods
			if (!hasGarryFixedBoneScalingYet) then
				allbones = {}
				for i=0, vm:GetBoneCount() do
					local bonename = vm:GetBoneName(i)
					if (self.ViewModelBoneMods[bonename]) then 
						allbones[bonename] = self.ViewModelBoneMods[bonename]
					else
						allbones[bonename] = { 
							scale = Vector(1,1,1),
							pos = Vector(0,0,0),
							angle = Angle(0,0,0)
						}
					end
				end
				
				loopthrough = allbones
			end
			// !! ----------- !! //
			
			for k, v in pairs( loopthrough ) do
				local bone = vm:LookupBone(k)
				if (!bone) then continue end
				
				// !! WORKAROUND !! //
				local s = Vector(v.scale.x,v.scale.y,v.scale.z)
				local p = Vector(v.pos.x,v.pos.y,v.pos.z)
				local ms = Vector(1,1,1)
				if (!hasGarryFixedBoneScalingYet) then
					local cur = vm:GetBoneParent(bone)
					while(cur >= 0) do
						local pscale = loopthrough[vm:GetBoneName(cur)].scale
						ms = ms * pscale
						cur = vm:GetBoneParent(cur)
					end
				end
				
				s = s * ms
				// !! ----------- !! //
				
				if vm:GetManipulateBoneScale(bone) != s then
					vm:ManipulateBoneScale( bone, s )
				end
				if vm:GetManipulateBoneAngles(bone) != v.angle then
					vm:ManipulateBoneAngles( bone, v.angle )
				end
				if vm:GetManipulateBonePosition(bone) != p then
					vm:ManipulateBonePosition( bone, p )
				end
			end
		else
			self:ResetBonePositions(vm)
		end
		   
	end
	 
	function SWEP:ResetBonePositions(vm)
		
		if (!vm:GetBoneCount()) then return end
		for i=0, vm:GetBoneCount() do
			vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
			vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
			vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
		end
		
	end

	/**************************
		Global utility code
	**************************/

	// Fully copies the table, meaning all tables inside this table are copied too and so on (normal table.Copy copies only their reference).
	// Does not copy entities of course, only copies their reference.
	// WARNING: do not use on tables that contain themselves somewhere down the line or you'll get an infinite loop
	function table.FullCopy( tab )
		if (!tab) then return nil end
		
		local res = {}
		for k, v in pairs( tab ) do
			if (type(v) == "table") then
				res[k] = table.FullCopy(v) // recursion ho!
			elseif (type(v) == "Vector") then
				res[k] = Vector(v.x, v.y, v.z)
			elseif (type(v) == "Angle") then
				res[k] = Angle(v.p, v.y, v.r)
			else
				res[k] = v
			end
		end
		
		return res
		
	end
	
end