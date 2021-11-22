nw.Register 'IsTyping'
	:Write(net.ReadBool)
	:Read(net.WriteBool)
	:SetPlayer()
	
function PLAYER:IsTyping()
	return self:GetNetVar('IsTyping') or false
end

ba.twitchEmotes = { 
	[':?:'] = 'materials/icon16/help.png',
	[':home:'] = 'materials/icon16/house.png',
	[':bomb:'] = 'materials/icon16/bomb.png',
	[':$:'] = 'materials/icon16/money_dollar.png',
	[':usr:'] = 'materials/icon16/user.png',
	[':3'] = 'materials/icon16/emoticon_waii.png',
	[':y:'] = 'materials/icon16/money_yen.png',
	[':o'] = 'materials/icon16/emoticon_surprised.png',
	['>:d'] = 'materials/icon16/emoticon_evilgrin.png',
	[':door:'] = 'materials/icon16/door.png',
	[':s:'] = 'materials/icon16/money_dollar.png',
	[':money:'] = 'materials/icon16/money.png',
	[':cup:'] = 'materials/icon16/cup.png',
	[':tux:'] = 'materials/icon16/tux.png',
	[':up:'] = 'materials/icon16/arrow_up.png',
	[':('] = 'materials/icon16/emoticon_unhappy.png',
	['<3'] = 'materials/icon16/heart.png',
	[';)'] = 'materials/icon16/emoticon_wink.png',
	[':)'] = 'materials/icon16/emoticon_smile.png',
	[':dn:'] = 'materials/icon16/arrow_down.png',
	['-->'] = 'materials/icon16/arrow_right.png',
	[':coins:'] = 'materials/icon16/coins.png',
	[':d'] = 'materials/icon16/emoticon_grin.png',
	[':shield:'] = 'materials/icon16/shield.png',
	[':cake:'] = 'materials/icon16/cake.png',
	[':suit:'] = 'materials/icon16/user_suit.png',
	[':p'] = 'materials/icon16/emoticon_tongue.png',
	[':date:'] = 'materials/icon16/date.png',
	['<--'] = 'materials/icon16/arrow_left.png',
	[':box:'] = 'materials/icon16/box.png',
	[':clock:'] = 'materials/icon16/clock.png',
	[':e:'] = 'materials/icon16/money_euro.png',
	[':!:'] = 'materials/icon16/error.png',
}

for k, v in pairs(ba.twitchEmotes) do
	if (CLIENT) then
		ba.twitchEmotes[k] = Material(v, 'smooth')
	end
end