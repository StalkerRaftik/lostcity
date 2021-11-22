net.Receive('ShowLevelUPGreets', function()
	local int = net.ReadUInt(32)
	local enum = net.ReadUInt(8)
	-- ply:ShowLevelUPGreets(int)
	ExpGained(int, enum)
end)

local anim = 0
-- function PLAYER:ShowLevelUPGreets(int)
-- -- 
-- end


local enumsCooldown = {}

local earned = 0
local earned_job = 0
local bar = 350
local del = 0
local bAlpha = 0
local disableCounter = false
local expW = 0
local expJ = 0
local levelup = false
local lAlpha = 0
local lastEnum = LVL_MSG_ENUM.NONE
local w, h = ScrW(), ScrH()
local LvlBar = FADE_STAGE_NONE
local LvlBarText = FADE_STAGE_NONE
local ProgressAlpha = 0
function ExpGained(amount, enum)
	if enumsCooldown[enum] and enumsCooldown[enum] > CurTime() then return end
	enumsCooldown[enum] = CurTime() + 180

	earned = amount
	lastEnum = enum
	LvlBar = FADE_STAGE_IN
	LvlBarText = FADE_STAGE_IN
	ProgressAlpha = 0
end


hook.Add("HUDPaint", "ShowExpBar", function()
	if not LocalPlayer():Alive() then return end
	
	local LvlBarW = w*0.2
	local LvlBarH = w*0.007


	if LvlBar != FADE_STAGE_NONE then
		local newLvlPercent = LocalPlayer():GetExperience() / LocalPlayer():GetNeedExperience()
		ProgressAlpha = Lerp(FrameTime()*5, ProgressAlpha, 1)
		LvlBar = FadeInOut("LvlBar", function(Alpha) 
			surface.SetDrawColor(0,0,0,150 * Alpha)
			surface.DrawRect(w/2 - LvlBarW/2, h*0.1, LvlBarW, LvlBarH)

			surface.SetDrawColor(255,255,255, 160 * Alpha)
			surface.DrawRect(w/2 - LvlBarW/2, h*0.1, LvlBarW * newLvlPercent * ProgressAlpha, LvlBarH)
			
			surface.SetDrawColor(255,255,255,255 * Alpha)
			surface.DrawOutlinedRect( w/2 - LvlBarW/2, h*0.1, LvlBarW, LvlBarH, 1)
		end, 3, 2.5, 3)
	end

	if LvlBarText != FADE_STAGE_NONE then
		LvlBarText = FadeInOut("LvlBarText", function(Alpha) 
			local lvlmsg = "+ ".. earned .." очков опыта" .. lvlEnumsDef[lastEnum] .. "."	
			draw.ShadowSimpleText( lvlmsg, "rp.ui.24", w/2, h*0.1/1.2, Color(255,255,255,200 * Alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end, 2.5, 2, 2.5)
	end

	

	-- if (earned > 0) then
	-- 	if (not disableCounter) then
	-- 		if (del <= CurTime()) then
	-- 			disableCounter = true
	-- 		end
	-- 	elseif (bAlpha <= 0) then
	-- 		earned = 0
	-- 	end

	-- 	bAlpha = Lerp(FrameTime() * 4, bAlpha, disableCounter and -1 or 256)

	-- 	if (earned > 0) then
	-- 		surface.SetFont("font_base_24")
	-- 		expW, _ = surface.GetTextSize("+" .. earned .. "xp")
	-- 		draw.SimpleText("+" .. earned .. "xp", "font_base_24", ScrW() - bar + 4, 100, Color(235, 235, 235, 255 * (bAlpha / 255)), TEXT_ALIGN_LEFT)
	-- 	end
	-- end
end)
