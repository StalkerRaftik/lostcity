ba.svar 		= ba.svar 			or {}
ba.svar.stored 	= ba.svar.stored 	or {}

net.Receive('ba.svars', function()
	ba.svar.stored = pon.decode(net.ReadString())

	hook.Call('svarsLoaded', ba)
end)

function ba.svar.Get(name)
	return ba.svar.stored[name]
end
