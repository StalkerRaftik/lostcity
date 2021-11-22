local color_pink = rp.chatcolors.Pink
local color_red = rp.chatcolors.Red
local color_white = rp.chatcolors.White

local cards = {
	"Ace of Clubs",
	"Two of Clubs",
	"Three of Clubs",
	"Four of Clubs",
	"Five of Clubs",
	"Six of Clubs",
	"Seven of Clubs",
	"Eight of Clubs",
	"Nine of Clubs",
	"Ten of Clubs",
	"Jack of Clubs",
	"Queen of Clubs",
	"King of Clubs",
	"Ace of Diamonds",
	"Two of Diamonds",
	"Three of Diamonds",
	"Four of Diamonds",
	"Five of Diamonds",
	"Six of Diamonds",
	"Seven of Diamonds",
	"Eight of Diamonds",
	"Nine of Diamonds",
	"Ten of Diamonds",
	"Jack of Diamonds",
	"Queen of Diamonds",
	"King of Diamonds",
	"Ace of Hearts",
	"Two of Hearts",
	"Three of Hearts",
	"Four of Hearts",
	"Five of Hearts",
	"Six of Hearts",
	"Seven of Hearts",
	"Eight of Hearts",
	"Nine of Hearts",
	"Ten of Hearts",
	"Jack of Hearts",
	"Queen of Hearts",
	"King of Hearts",
	"Ace of Spades",
	"Two of Spades",
	"Three of Spades",
	"Four of Spades",
	"Five of Spades",
	"Six of Spades",
	"Seven of Spades",
	"Eight of Spades",
	"Nine of Spades",
	"Ten of Spades",
	"Jack of Spades",
	"Queen of Spades",
	"King of Spades"
}

local function RollTheDice(pl, text, args)
	rp.LocalChat(CHAT_NONE, pl, 250, color_red, '[', color_pink, 'ROLL', color_red, '] ', pl:GetJobColor(), pl:RealName(), color_white, ' выбросил ', color_pink, tostring(math.random(100)), color_white, ' из 100.')
end
rp.AddCommand("/roll", RollTheDice)

local function Try(pl, text, args)
	local scolor
	local success
	local rand = math.random(1,2)
	if rand == 1 then 
		success = 'Удачно'
		scolor = rp.chatcolors.Green
	else
		success = 'Неудачно'
		scolor = rp.chatcolors.Red
	end
	rp.LocalChat(CHAT_NONE, pl, 250, pl:GetJobColor(), pl:RealName(), color_white,' ' .. text, ' | ', scolor , success)
end
rp.AddCommand("/try", Try)

local function Do(pl, text, args)
	rp.LocalChat(CHAT_NONE, pl, 250, Color(173, 203, 255), text .. " - (" .. pl:RealName() .. ")")
end
rp.AddCommand("/do", Do)

local function It(pl, text, args)
	rp.LocalChat(CHAT_NONE, pl, 250, Color(209, 117, 255),"*" .. text .. "*" )
end
rp.AddCommand("/it", It)

local function Looc(pl, text, args)
	rp.LocalChat(CHAT_NONE, pl, 250, color_white ,"[LOOC] ", Color(255, 223, 168), pl:Name() .. '('.. pl:RealName() .. '): ', Color(255,255,255), text )
end
rp.AddCommand("/looc", Looc)
rp.AddCommand("/l", Looc)
rp.AddCommand("/", Looc)



local function DoubleDice(pl, text, args)
	rp.LocalChat(CHAT_NONE, pl, 250, color_red, '[', color_pink, 'DICE', color_red, '] ', pl:GetJobColor(), pl:RealName(), color_white, ' получил ', color_pink, tostring(math.random(1, 6)), color_white, ' и ', color_pink, tostring(math.random(1, 6)), color_white, '.')
end
rp.AddCommand("/dice", DoubleDice)

local function RandomCard(pl, text, args)
	rp.LocalChat(CHAT_NONE, pl, 250, color_red, '[', color_pink, 'CARDS', color_red, '] ', pl:GetJobColor(), pl:RealName(), color_white, ' выбросил ', color_pink, table.Random(cards), color_white, '.')
end
rp.AddCommand("/cards", RandomCard)