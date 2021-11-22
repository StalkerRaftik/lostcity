local ply = FindMetaTable("Player")
local ent = FindMetaTable("Entity")

function DarkRP.formatMoney(t)
	return rp.FormatMoney(t)
end
function DarkRP.textWrap(gs, f, s)
	return string.Wrap(f, gs, s)
end
function DarkRP.setPreferredJobModel(_,model)
	rp.RunCommand('model', model)
end
function ply:getEyeSightHitEntity(searchDistance, hitDistance, filter)
    searchDistance = searchDistance or 100
    hitDistance = (hitDistance or 15) * (hitDistance or 15)

    filter = filter or function(p) return p:IsPlayer() and p ~= self end

    self:LagCompensation(true)

    local shootPos = self:GetShootPos()
    local entities = ents.FindInSphere(shootPos, searchDistance)
    local aimvec = self:GetAimVector()

    local smallestDistance = math.huge
    local foundEnt

    for k, ent in pairs(entities) do
        if not IsValid(ent) or filter(ent) == false then continue end

        local center = ent:GetPos()

        -- project the center vector on the aim vector
        local projected = shootPos + (center - shootPos):Dot(aimvec) * aimvec

        if aimvec:Dot((projected - shootPos):GetNormalized()) < 0 then continue end

        -- the point on the model that has the smallest distance to your line of sight
        local nearestPoint = ent:NearestPoint(projected)
        local distance = nearestPoint:DistToSqr(projected)

        if distance < smallestDistance then
            local trace = {
                start = self:GetShootPos(),
                endpos = nearestPoint,
                filter = {self, ent}
            }
            local traceLine = util.TraceLine(trace)
            if traceLine.Hit then continue end

            smallestDistance = distance
            foundEnt = ent
        end
    end

    self:LagCompensation(false)

    if smallestDistance < hitDistance then
        return foundEnt, math.sqrt(smallestDistance)
    end

    return nil
end

function ply:getDarkRPVar(sd)
	if sd == "job" then
		return self:GetJobName()
	end
	if sd == "HasGunlicense" then
		return self:HasLicense()
	end
	if sd == "Energy" then
		return self:GetHunger()
	end
	if sd == "money" then
		return self:GetMoney()
	end
	if sd == "salary" then
		return self:GetSalary()
	end
	if sd == "channelID" then
		return self:GetNWFloat("channelID",0)
	end
	if sd == "channelName" then
		return self:GetNWString("channelName","")
	end
end

function ply:getJobTable()
	for k,v in pairs(rp.teams) do
		if self:GetJob() == k then
			return v
		end
	end
end
function ply:canAfford(sd)
	if tonumber(self:GetMoney()) >= tonumber(sd) then return true else return false end
end

if SERVER then
	function ply:addMoney(sd)
		self:AddMoney(sd or 1)
	end
	function DarkRP.createMoneyBag(p,a)
		rp.SpawnMoney(p,a)
	end
	function DarkRP.notify(ply,t,ti,te)
		rp.Notify(ply,t,te)
	end


	util.AddNetworkString("DarkRP_Chat")

	function DarkRP.talkToRange(ply, PlayerName, Message, size)
		local ents = ents.FindInSphere(ply:EyePos(), size)
		local col = team.GetColor(ply:Team())
		local filter = {}

		for _, v in ipairs(ents) do
			if v:IsPlayer() then
				table.insert(filter, v)
			end
		end

		if PlayerName == ply:Nick() then PlayerName = "" end -- If it's just normal chat, why not cut down on networking and get the name on the client

		net.Start("DarkRP_Chat")
			net.WriteUInt(col.r, 8)
			net.WriteUInt(col.g, 8)
			net.WriteUInt(col.b, 8)
			net.WriteString(PlayerName)
			net.WriteEntity(ply)
			net.WriteUInt(255, 8)
			net.WriteUInt(255, 8)
			net.WriteUInt(255, 8)
			net.WriteString(Message)
		net.Send(filter)
	end

	function DarkRP.talkToPerson(receiver, col1, text1, col2, text2, sender)
		net.Start("DarkRP_Chat")
			net.WriteUInt(col1.r, 8)
			net.WriteUInt(col1.g, 8)
			net.WriteUInt(col1.b, 8)
			net.WriteString(text1)

			sender = sender or Entity(0)
			net.WriteEntity(sender)

			col2 = col2 or Color(0, 0, 0)
			net.WriteUInt(col2.r, 8)
			net.WriteUInt(col2.g, 8)
			net.WriteUInt(col2.b, 8)
			net.WriteString(text2 or "")
		net.Send(receiver)
	end

end

timer.Simple(1,function()
	RPExtraTeams = rp.teams
	CustomShipments = rp.shipments
end)

if CLIENT then 
local function AddToChat(bits)
    local col1 = Color(net.ReadUInt(8), net.ReadUInt(8), net.ReadUInt(8))

    local prefixText = net.ReadString()
    local ply = net.ReadEntity()
    ply = IsValid(ply) and ply or LocalPlayer()

    if not IsValid(ply) then return end

    if prefixText == "" or not prefixText then
        prefixText = ply:Nick()
        prefixText = prefixText ~= "" and prefixText or ply:SteamName()
    end

    local col2 = Color(net.ReadUInt(8), net.ReadUInt(8), net.ReadUInt(8))

    local text = net.ReadString()
    local shouldShow
    if text and text ~= "" then
        if IsValid(ply) then
            shouldShow = hook.Call("OnPlayerChat", GAMEMODE, ply, text, false, not ply:Alive(), prefixText, col1, col2)
        end

        if shouldShow ~= true then
            -- chat.AddNonParsedText(col1, prefixText, col2, ": " .. text)
			chat.AddText(team.GetColor(ply:GetJob()), ply:RPName(), color_white, ': ', text)
        end
    else
        shouldShow = hook.Call("ChatText", GAMEMODE, "0", prefixText, prefixText, "darkrp")

        if shouldShow ~= true then
            -- chat.AddNonParsedText(col1, prefixText)
			chat.AddText(team.GetColor(ply:GetJob()), ply:RPName(), color_white, ': ', text)
        end
    end
    chat.PlaySound()
end
net.Receive("DarkRP_Chat", AddToChat)
end