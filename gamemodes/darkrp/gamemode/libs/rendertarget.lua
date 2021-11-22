-------------------------------------------------------------------------------
-- RT Dispatcher by grinchfox Colinsgrove @ nxserv.eu
-------------------------------------------------------------------------------

if SERVER then return end

rendertarget = rendertarget or {}
rendertarget.list = rendertarget.list or {}

local function debugprint( ... )
	if not rendertarget.debug then return end
	print( ... )
end

local function make_handler( rt )
	local h = newproxy(true)
	local mt = getmetatable(h)
	mt.__index = mt
	mt.__gc = function()
		rt.refs = rt.refs -1
		if rt.refs == 0 then
			debugprint("GC'ed "..rt.name)
		else
			debugprint(rt.refs.." refs left for "..rt.name)
		end
	end
	mt.__tostring = function(self)
		return "RenderTarget["..rt.name.."]"
	end
	mt.__eq = function(self, other)
		return other._rt and other._rt == rt
	end
	mt.GetTexture = function(self)
		return rt.texture
	end
	mt._rt = rt
	rt.refs = rt.refs + 1
	return h
end

function rendertarget.Get( w, h, sizemode, depthmode, texflags, rtflags, imageformat )
	if not w or not h then return error"no width and height specified" end
	sizemode = sizemode or RT_SIZE_OFFSCREEN
	depthmode = depthmode or MATERIAL_RT_DEPTH_NONE
	texflags = texflags or 0
	rtflags = rtflags or 0
	imageformat = imageformat or IMAGE_FORMAT_RGBA8888

	--string.format("rt%03x%03x%02x%02x%08x%02x",512,512,RT_SIZE_OFFSCREEN,MATERIAL_RT_DEPTH_NONE,0,CREATERENDERTARGETFLAGS_HDR,IMAGEFORMAT_RGBA8888)
	local params = string.format("%03x%03x%02x%02x%08x%02x",w, h, sizemode, depthmode, texflags, rtflags, imageformat)
	local id = 1
	local list = rendertarget.list[ params ]
	if list then
		for k,v in pairs(rendertarget.list) do
			if v.refs == 0 then
				return make_handler( v )
			end
		end
	else
		list = {}
		rendertarget.list[ params ] = list
	end
	--make new one
	local rt = {}
	local id = table.insert( list, rt )
	rt.params = params
	rt.id = id
	rt.name = "_rt"..params.."_"..id
	rt.refs = 0
	rt.texture = GetRenderTargetEx( rt.name, w, h, sizemode, depthmode, texflags, rtflags, imageformat)
	debugprint( "New RT "..rt.name )
	return make_handler( rt )
end

