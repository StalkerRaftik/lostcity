if not CLIENT then return end

zlm = zlm or {}
zlm.Actions = zlm.Actions or {}

local wMod = ScrW() / 1920
local hMod = ScrH() / 1080

local zlm_NPCInterface = {}
local zlm_NPCInterface_Main = {}

/////////// General
local function zlm_OpenUI()
	if not IsValid(zlm_NPCInterface_panel) then

		zlm_NPCInterface_panel = vgui.Create("zlm_vgui_NPCInterface")
	end
end

local function zlm_CloseUI()
	LocalPlayer().zlm_NPC = nil

	if IsValid(zlm_NPCInterface_panel) then
		zlm_NPCInterface_panel:Remove()
	end
end
///////////

// This closes the shop interface
net.Receive("zlm_NPCInterface_Close", function(len)
	zlm_CloseUI()
end)

// This opens the shop interface
net.Receive("zlm_NPCInterface_Open", function(len)

	LocalPlayer().zlm_NPC = net.ReadEntity()

	zlm_OpenUI()
end)

/////////// Init
function zlm_NPCInterface:Init()
	self:SetSize(300 * wMod, 350 * hMod)
	self:Center()
	self:MakePopup()

	zlm_NPCInterface_Main.Title = vgui.Create("DLabel", self)
	zlm_NPCInterface_Main.Title:SetPos(15 * wMod, -30 * hMod)
	zlm_NPCInterface_Main.Title:SetSize(600 * wMod, 125 * hMod)
	zlm_NPCInterface_Main.Title:SetFont("zlm_vgui_font01")
	zlm_NPCInterface_Main.Title:SetText(zlm.language.General["VehicleShop"])
	zlm_NPCInterface_Main.Title:SetColor(zlm.default_colors["white01"])

	zlm_NPCInterface_Main.close = vgui.Create("DButton", self)
	zlm_NPCInterface_Main.close:SetText("")
	zlm_NPCInterface_Main.close:SetPos(240 * wMod, 10 * hMod)
	zlm_NPCInterface_Main.close:SetSize(50 * wMod, 50 * hMod)
	zlm_NPCInterface_Main.close.DoClick = function()
		zlm_CloseUI()
	end
	zlm_NPCInterface_Main.close.Paint = function(s,w, h)

		draw.RoundedBox(10, 0 , 0, w, h, zlm.default_colors["red02"])
		draw.DrawText("X", "zlm_vgui_font01", 25 * wMod, 10 * hMod, zlm.default_colors["white01"], TEXT_ALIGN_CENTER)

		if s:IsHovered() then
			draw.RoundedBox(10, 0 , 0, w, h, zlm.default_colors["white04"])
		end
	end

	zlm_NPCInterface_Main.BuyTractor = vgui.Create("DButton", self)
	zlm_NPCInterface_Main.BuyTractor:SetText("")
	zlm_NPCInterface_Main.BuyTractor:SetPos(25 * wMod, 75 * hMod)
	zlm_NPCInterface_Main.BuyTractor:SetSize(250 * wMod, 120 * hMod)
	zlm_NPCInterface_Main.BuyTractor.DoClick = function()
		zlm.Actions.Buy(1)
	end
	zlm_NPCInterface_Main.BuyTractor.Paint = function(s,w, h)

		//draw.RoundedBox(10, 0 , 0, w, h, zlm.default_colors["green03"])
		//draw.DrawText("Buy LawnMower", "zlm_vgui_font01", 125 * wMod, 10 * hMod, zlm.default_colors["white01"], TEXT_ALIGN_CENTER)

		surface.SetDrawColor(zlm.default_colors["white01"])
		surface.SetMaterial(zlm.default_materials["zlm_vehicle_tractor"])
		surface.DrawTexturedRect(0, -65 * hMod, w, 250 * hMod)


		if s:IsHovered() then
			surface.SetDrawColor(zlm.default_colors["white04"])
			surface.SetMaterial(zlm.default_materials["zlm_vehicle_tractor_glow"])
			surface.DrawTexturedRect(0, -65 * hMod, w, 250 * hMod)
		end

		draw.DrawText(zlm.config.Currency .. zlm.config.NPC.Shop["lawnmower"], "zlm_vgui_font02", 125 * wMod, 25 * hMod, zlm.default_colors["white01"], TEXT_ALIGN_CENTER)
	end

	zlm_NPCInterface_Main.BuyTrailer = vgui.Create("DButton", self)
	zlm_NPCInterface_Main.BuyTrailer:SetText("")
	zlm_NPCInterface_Main.BuyTrailer:SetPos(25 * wMod, 200 * hMod)
	zlm_NPCInterface_Main.BuyTrailer:SetSize(250 * wMod, 120 * hMod)
	zlm_NPCInterface_Main.BuyTrailer.DoClick = function()
		zlm.Actions.Buy(2)
	end
	zlm_NPCInterface_Main.BuyTrailer.Paint = function(s,w, h)

		//draw.RoundedBox(10, 0 , 0, w, h, zlm.default_colors["green03"])

		surface.SetDrawColor(zlm.default_colors["white01"])
		surface.SetMaterial(zlm.default_materials["zlm_vehicle_trailer"])
		surface.DrawTexturedRect(0, -65 * hMod, w, 250 * hMod)


		if s:IsHovered() then
			surface.SetDrawColor(zlm.default_colors["white04"])
			surface.SetMaterial(zlm.default_materials["zlm_vehicle_trailer_glow"])
			surface.DrawTexturedRect(0, -65 * hMod, w, 250 * hMod)
		end
		draw.DrawText(zlm.config.Currency .. zlm.config.NPC.Shop["trailer"], "zlm_vgui_font02", 125 * wMod, 15 * hMod, zlm.default_colors["white01"], TEXT_ALIGN_CENTER)
	end

end

function zlm_NPCInterface:Paint(w, h)
	draw.RoundedBox(15, 0 , 0, w, h,  zlm.default_colors["grey01"])
end

vgui.Register("zlm_vgui_NPCInterface", zlm_NPCInterface, "Panel")


function zlm.Actions.Buy(productID)
	net.Start("zlm_NPCInterface_Buy")
	net.WriteEntity(LocalPlayer().zlm_NPC)
	net.WriteInt(productID,4)
	net.SendToServer()

	zlm_CloseUI()
end
