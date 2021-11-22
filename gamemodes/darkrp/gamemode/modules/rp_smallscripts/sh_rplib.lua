rplib = rplib or {}

local pmeta = FindMetaTable("Player")
local emeta = FindMetaTable("Entity")

if CLIENT then
    hook.Add( "Think", "PlayerIsLoaded", function()
        if IsValid( LocalPlayer() ) then
            hook.Remove( "Think", "PlayerIsLoaded" )
            net.Start( "PlayerIsLoaded" )
            net.SendToServer()
            hook.Run( "PlayerIsLoaded" )
        end
    end)
else
    util.AddNetworkString "PlayerIsLoaded"
    net.Receive( "PlayerIsLoaded", function( len, ply )
       hook.Run( "PlayerIsLoaded", ply )
    end)
end

function rplib.FormatDuration(time)
    if time <= 0 then return "Перманент" end
    local tmp = time
    tmp = math.floor(tmp / 60)
    local m = tmp % 60
    tmp = math.floor(tmp / 60)
    local h = tmp % 24
    tmp = math.floor(tmp / 24)
    local d = tmp % 7
    local w = math.floor(tmp / 7)
    local toret = ""

    if w ~= 0 then
        toret = toret .. math.Round(w) .. "н "
    end

    if d ~= 0 and d < 7 then
        toret = toret .. math.Round(d) .. "д "
    end

    if h ~= 0 and h < 24 then
        toret = toret .. math.Round(h) .. "ч "
    end

    if m ~= 0 and m < 60 then
        toret = toret .. math.Round(m) .. "мин "
    end

    return toret
end

function rplib.RandomString( intMin, intMax )
	local s = ""

	if intMax then
		for i = 1, math.random( intMin, intMax ) do
			s = s.. string.char( math.random(48, 126) )
		end
	else
		for i = 1, intMin do
			s = s.. string.char( math.random(48, 126) )
		end
	end

	return s
end

function rplib.VectorInRange( vecCheck, vecMin, vecMax )
	if not vecCheck or not vecMin or not vecMax then return end

	local bOutBounds = false
	if vecCheck.x >= vecMin.x and vecCheck.x <= vecMax.x then else
		bOutBounds = true
	end

	if vecCheck.y >= vecMin.y and vecCheck.y <= vecMax.y then else
		bOutBounds = true
	end

	if vecCheck.z >= vecMin.z and vecCheck.z <= vecMax.z then else
		bOutBounds = true
	end

	return not bOutBounds
end

function rplib.VectorInRangeSet( vecCheck, tblMinMax )
	for k, v in pairs( tblMinMax ) do
		if self:VectorInRange( vecCheck, v.Min, v.Max ) then
			return true
		end
	end

	return false
end

function rplib.AngleInRange( angCheck, angMin, angMax )
	if not angCheck or not angMin or not angMax then return end

	local bOutBounds = false
	if angCheck.p >= angMin.p and angCheck.p <= angMax.p then else
		bOutBounds = true
	end

	if angCheck.y >= angMin.y and angCheck.y <= angMax.y then else
		bOutBounds = true
	end

	if angCheck.r >= angMin.r and angCheck.r <= angMax.r then else
		bOutBounds = true
	end

	return not bOutBounds
end

function rplib.CartesianToSpherical( vecFrom )
	local rho = math.sqrt( vecFrom.x^2 +vecFrom.y^2 +vecFrom.z^2 )
	local theta = math.acos( vecFrom.z /rho )
	local phi = math.atan2( vecFrom.y, vecFrom.x )
	return rho, theta, phi
end

function rplib.SphericalToCartesian( intRho, intTheta, intPhi )
	return Vector(
		intRho *math.sin(intTheta) *math.cos(intPhi),
		intRho *math.sin(intTheta) *math.sin(intPhi),
		intRho *math.cos(intTheta)
	)
end

function rplib.ColorToByte( col )
	return bit.bor(
		bit.lshift( col.r, 16 ),
		bit.lshift( col.g, 8 ),
		col.b,
		bit.lshift( col.a, 24 )
	)
end

function rplib.ByteToColor( int )
	return Color(
		bit.band( bit.rshift(int, 16), 0xff ),
		bit.band( bit.rshift(int, 8), 0xff ),
		bit.band( int, 0xff ),
		bit.band( bit.rshift(int, 24), 0xff )
	)
end

function rplib.EnumToKey( intKeyEnum, intOffset, bChar )
	intKeyEnum = intKeyEnum -intOffset
	if bChar then
		intKeyEnum = string.char( intOffset +intKeyEnum )
	end
	return intKeyEnum
end

function rplib.FormatTime( intTime, bHours )
	local time = os.date( "!*t", intTime ) or { min = 0, sec = 0 }
	if time.sec < 10 then
		time.sec = "0".. time.sec
	end

	if not bHours then
		return ("%s:%s"):format( time.min, time.sec )
	else
		if time.min < 10 then
			time.min = "0".. time.min
		end
		return ("%s:%s:%s"):format( time.hour +(time.day >1 and (time.day-1) *24 or 0), time.min, time.sec )
	end
end

local function r(n) return math.Round(n, 0) end
function FindEntityPositions(class)
  for k, v in pairs(ents.GetAll()) do
    if v:GetClass() == class then
      print('Vector(' .. r(v:GetPos().x) .. ', ' .. r(v:GetPos().y) .. ', ' .. r(v:GetPos().z) ..'),' )
      print('Angle(' .. r(v:GetAngles().x) .. ', ' .. r(v:GetAngles().y) .. ', ' .. r(v:GetAngles().z) ..'),' )
    end
  end
end

timer.Simple( .1, function()
	weapons.GetStored( 'gmod_tool' ).ShootSound = Sound( 'ambient/weather/rain_drip4.wav' )
end)

function util.Base64Decode( data )
	local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
	if !data then return end
	data = string.gsub(data, '[^'..b..'=]', '')
	return (data:gsub('.', function(x)
		if (x == '=') then return '' end
		local r,f='',(b:find(x)-1)
		for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 && '1' || '0') end
		return r;
	end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
		if (#x ~= 8) then return '' end
		local c=0
		for i=1,8 do c=c+(x:sub(i,i)=='1' && 2^(8-i) || 0) end
		return string.char(c)
	end))
end

function rplib.Timestamp(t,s)
	local timestamp = t - os.time()
	local d = 0
	local h = 0
	local m = 0
	local s = 0

	if timestamp > 0 then
		d = math.floor(timestamp / 60 / 60 / 24)
		h = math.floor((timestamp / 60 / 60) % 24)
		m = math.floor(timestamp / 60 % 60)
		s = math.floor(timestamp % 60)
	end

	if s then
		f = s .. "s"
		if m > 0 then f = m .. "m, " .. f end
		if h > 0 then f = h .. "h, " .. f end
		if d > 0 then f = d .. "d, " .. f end
		return f
	end

	return d .. "d, " .. h .. "h, " .. m .. "m, " .. s .. "s"
end
string.lpad = function(str, len, char)
	if char == nil then char = ' ' end
	return str .. string.rep(char, len - #str)
end

string.rpad = function(str, len, char)
	if char == nil then char = ' ' end
	return string.rep(char, len - #str) .. str
end
function rplib.SafeStr( str )

	local pattern = "[^0-9a-zA-Z%s]+"; -- regex pattern

	local clean = tostring( str );

	local first, last = string.find( str, pattern );

	if( first != nil and last != nil ) then

		clean = string.gsub( clean, pattern, "" ); -- remove bad sequences

	end

	return clean;

end