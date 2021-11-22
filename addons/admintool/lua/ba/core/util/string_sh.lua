ba.str = ba.str or {}

function ba.str.Capital(str)
	return (str:gsub('^%l', string.upper))
end

function ba.str.Quotify(str)
	return '"' .. str .. '"'
end

function ba.str.StartWith(str, value)
	return value:lower():find(str:lower():sub(1, value:len()), nil, true)
end

function ba.str.ExplodeQuotes(str)
	str = ' ' .. str .. ' '
	local res = {}
	local ind = 1
	while (true) do
		local sInd, start = string.find(str, '[^%s]', ind)
		if not sInd then break end
		ind = sInd + 1
		local quoted = str:sub(sInd, sInd):match('["\']') and true or false
		local fInd, finish = string.find(str, quoted and '["\']' or '[%s]', ind)
		if not fInd then break end
		ind = fInd + 1
		local str = str:sub(quoted and sInd + 1 or sInd, fInd - 1)
		res[#res + 1] = str
	end
	return res
end

function ba.str.FormatTime(t)
	if not t then return 'N/A' end
		
	local hours = math.floor(t / 3600)
	local minutes = math.floor((t % 3600) / 60)
	local seconds = math.floor(t - (hours * 3600) - (minutes * 60))
		
	if (minutes < 10) then minutes = '0' .. minutes end
	if (seconds < 10) then seconds = '0' .. seconds end
		
	return (hours .. ':' .. minutes .. ':' .. seconds)
end
