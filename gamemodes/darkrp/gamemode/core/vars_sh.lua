-- Player Vars
nw.Register'HasGunlicense':Write(net.WriteBool):Read(net.ReadBool):SetPlayer()
nw.Register'Name':Write(net.WriteString):Read(net.ReadString):SetPlayer()
nw.Register'Money':Write(net.WriteUInt, 32):Read(net.ReadUInt, 32)
nw.Register'Karma':Write(net.WriteUInt, 7):Read(net.ReadUInt, 7):SetLocalPlayer()
nw.Register'job':Write(net.WriteString):Read(net.ReadString):SetPlayer()
nw.Register'DisguiseTeam':Write(net.WriteUInt, 6):Read(net.ReadUInt, 6):SetPlayer()
nw.Register'DisguiseTime':Write(net.WriteUInt, 32):Read(net.ReadUInt, 32):SetLocalPlayer()

nw.Register'ShareProps':Write(net.WriteTable):Read(net.ReadTable):SetLocalPlayer()

nw.Register 'PropIsOwned'
	:Write(net.WriteBool)
	:Read(net.ReadBool)
	:Filter(function(self)
		return self:CPPIGetOwner()
	end)

nw.Register 'PropOwner'
	:Write(net.WriteEntity)
	:Read(net.ReadEntity)

	-- :SetNoSync()
nw.Register'Credits':Write(net.WriteUInt, 32):Read(net.ReadUInt, 32):SetLocalPlayer()

nw.Register'Upgrades':Write(function(v)
	net.WriteUInt(#v, 8)

	for k, upgid in ipairs(v) do
		net.WriteUInt(upgid, 8)
	end
end):Read(function()
	local ret = {}

	for i = 1, net.ReadUInt(8) do
		local obj = rp.shop.Get(net.ReadUInt(8))
		ret[obj:GetUID()] = true
	end

	return ret
end)

