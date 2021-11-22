include("shared.lua")

function ENT:Initialize()

	local data = Cosmetics.Items[ self:GetCosmeticType() ]

	if not data then return end

	if data.webmaterial then
		BraxLib.WebModelMaterial( data.webmaterial, { ["$halflambert"] = 1 }, function( mat, path )
			if not IsValid(self) then return end
			self.Mat = mat
		end)
	end

end

function ENT:Draw()

	if self.Mat then render.MaterialOverride( self.Mat ) end

	self:DrawModel()

	if self.Mat then render.MaterialOverride() end

	local sd = hook.Call("ShouldNotDrawTag", nil, self)
	if sd == true then return end

	local data = Cosmetics.Items[ self:GetCosmeticType() ]

	if not data then return end

	--self:DrawBraxInfo("Cosmetic", data.name or "<unknown>", Color(205, 205, 105, 255), Color(255, 255, 255, 255) )

end

function ENT:Think() end