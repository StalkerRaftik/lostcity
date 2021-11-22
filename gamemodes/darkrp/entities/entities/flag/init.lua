AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")


function ENT:Initialize()
	self:SetModel('models/sterling/flag.mdl')
	self:SetNVar("FlagOwner", "Ничей", NETWORK_PROTOCOL_PUBLIC)
	self.activetimer = 0
	self.isCapturing = false
	self.losetick = 0
	self:SetNVar("ConquestTimer", -1, NETWORK_PROTOCOL_PUBLIC)

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:EnableMotion(false)
    end
    constraint.RemoveAll(self)	

end


function ENT:Use(activator)
	if self.activetimer ~= 0 and self.activetimer > CurTime() then return end
	if activator:IsPlayer() or activator:GetEyeTrace().Entity == self then
		self.activetimer = CurTime() + 1
	if activator:getJobTable().category == "Other" then
		activator:SendSystemMessage("Территории", 'Дизорганизованные группы и простые выжившие не способны захватывать территории.')
		return 
	end

		if self.isCapturing == true then  activator:SendSystemMessage("Территории", 'Захват уже идет!') return end
		if self:GetNVar("FlagOwner") == activator:getJobTable().category then activator:SendSystemMessage("Территории", 'Эта территория уже пренадлежит вашей фракции!') return end
		
		local CapturingPlayersMessage = PlayersOnTerritoryAsEntities(self, activator:getJobTable().category) or {}
		
		local IsCaptured = CaptureCheck(self, activator) 
		if IsCaptured ~= false then
			for _,v in pairs(CapturingPlayersMessage) do
				v:SendSystemMessage("Территории", 'Захват начался! Чем больше людей будет внутри территории(есть название территории сверху-слева экрана), тем больше шанс захватить территорию.')
			end
		else return end
		self.isCapturing = true

		self:SetNVar("ConquestTimer", CurTime()+180, NETWORK_PROTOCOL_PUBLIC)
		rp.GlobalChat(CHAT_NONE, Color(255,0,0) ,"[Общая частота] ", Color(128, 128, 128), "Неизвестный", Color(255,255,255), ": " .. activator:getJobTable().category .. " пытается захватить территорию '" .. self.id .. "'!" )

	    timer.Simple( 180, function() 
	        local IsCaptured = false
	        IsCaptured = CaptureCheck(self, activator) 

	        if IsCaptured == true then
	        	local teamcolor = activator:getJobTable().color
	        	self:SetNVar("FlagOwner", activator:getJobTable().category, NETWORK_PROTOCOL_PUBLIC)
	            self:SetColor( Color(teamcolor.r, teamcolor.g, teamcolor.b) )
	            self:SetNVar("ConquestTimer", -1, NETWORK_PROTOCOL_PUBLIC)
	            for k,v in pairs(ents.GetAll()) do
					if v:GetClass() == "conqueststorage" then
						if v.id == self.id then
							v:SetNVar("FlagOwner", activator:getJobTable().category, NETWORK_PROTOCOL_PUBLIC)
						end
					end
				end
				local CapturingPlayersMessage = PlayersOnTerritoryAsEntities(self, activator:getJobTable().category) or {}
				for _,v in pairs(CapturingPlayersMessage) do
					v:SendSystemMessage("Территории", 'Вы захватили территорию!')
				end
            	rp.GlobalChat(CHAT_NONE, Color(255,0,0) ,"[Общая частота] ", Color(128, 128, 128), "Неизвестный", Color(255,255,255), ": " .. activator:getJobTable().category .. " успешно захватил территорию '" .. self.id .. "'." )
	        else
	        	self:SetNVar("ConquestTimer", -1, NETWORK_PROTOCOL_PUBLIC)
				rp.GlobalChat(CHAT_NONE, Color(255,0,0) ,"[Общая частота] ", Color(128, 128, 128), "Неизвестный", Color(255,255,255), ": " .. flag:GetNVar("FlagOwner") .. " смог отбить атаку " .. string.lower( activator:getJobTable().category ) .. " на территорию '" .. flag.id .. "'")
	        end

	        self.isCapturing = false

	    end) 
	end
end

function ENT:OnTakeDamage(dmg)
end


