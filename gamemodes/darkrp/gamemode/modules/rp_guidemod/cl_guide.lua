-----------------------------------------------------
-------------            VGUI         ---------------
-----------------------------------------------------

local PANEL = {}

function PANEL:Paint( w, h)

	surface.SetDrawColor( Color(0, 0, 0, 100) )
  	surface.DrawRect(0,0, w, h)
  	draw.BlurBackground(0, 0, w, h, 100, self, Color(0,0,0, 100))

  	
end

function PANEL:PaintOver( w, h)
	surface.SetDrawColor( 255, 123, 0)
	surface.DrawOutlinedRect( 0, 0, w, h, 1 )
end

function PANEL:SetText(text)
	self.text:AppendText(text)
end

function PANEL:SetHeader(text)
	self.header.text = text
end

function PANEL:Init()

    self.header = self:Add("monoPanel")
    self.header:Dock(TOP)
    self.header:SetHeight(40)
    self.header.text = "Подсказка"
    -- header:SetTextColor(Color(255, 123, 0))
    -- header:SetFont("rp.ui.24")
    -- header:SetText("Подсказка")
    function self.header:PaintOver( w, h )
    	draw.SimpleText(self.text, "rp.ui.28", w/2, 20, Color(255, 123, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0, 150))
	end

	self.footer = self:Add("monoPanel")
    self.footer:Dock(BOTTOM)
    self.footer:SetHeight(40)
    -- header:SetTextColor(Color(255, 123, 0))
    -- header:SetFont("rp.ui.24")
    -- header:SetText("Подсказка")
    function self.footer:PaintOver( w, h )
    	surface.SetDrawColor( Color(0, 0, 0, 220) )
  		surface.DrawRect(0,0, w, h)
    	draw.SimpleText("Нажмите 'Enter', чтобы закрыть это окно", "rp.ui.20", w-5, h/2, Color(255, 123, 0, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 1, Color(0,0,0, 150))
	end


    self.text = self:Add("RichText")
    self.text:Dock(FILL)
    self.text:DockMargin(5,0,5,5)
	self.text:InsertColorChange(255, 255, 255, 200)
	
    

	function self.text:PerformLayout()
		self:SetFontInternal( "rp.ui.24" )
		self:SetBGColor( Color( 0,0,0,150 ) )
	end
end



-- function PANEL:PerformLayout()
-- 	self:SetWide(self:GetParent():GetWide())
-- 	self:SetTall(self:GetParent():GetTall())
-- end

vgui.Register('rp.Guide', PANEL, 'monoPanel')



hook.Add( "PlayerButtonDown", "CloseHelpButton", function( ply, button )
	if button ~= KEY_ENTER then return end

	if HelpBox and IsValid(HelpBox) then
		hook.Call( "GuideMenuOnClose", nil, HelpBox.name )
		HelpBox:Remove()
	end
end)

function CreateHelpBox(headerText, mainText, name)

	if HelpBox and IsValid(HelpBox) then
		HelpBox:Remove()
	end

	HelpBox = vgui.Create("rp.Guide")
    HelpBox:SetSize(ScrW()*0.2,ScrH()*0.5)
	HelpBox:SetPos(ScrW()*0.8 - 10,ScrH()*0.1)
	HelpBox:SetHeader(headerText)
	HelpBox:SetText(mainText)
	HelpBox.name = name

end



-----------------------------------------------------
------------        Работа с файлом      ------------
-----------------------------------------------------



if not file.Exists( "LostCity_HelpData.txt", "DATA" ) then 
	file.Append( "LostCity_HelpData.txt", "")
end


function AddUniqueData(fname, key, value)
	local f = file.Open(fname, "r", "DATA")
		local foundExactData = false
		while not f:EndOfFile() do 
			local Line = f:ReadLine()
			if not Line or Line == nil then Line = "" end
			local LineData = string.Explode( " ", Line )

			print(LineData[1] .. ", " .. key)
			if LineData[1] == key then
				foundExactData = true
			end
		end
	f:Close()

	if not foundExactData then
		local f = file.Open(fname, "a", "DATA")
			f:Write(key .. " " .. value .. "\n")
		f:Close()
	end
end

function GetData(fname, key)
	local f = file.Open(fname, "r", "DATA")
		local foundExactData = false
		while not f:EndOfFile() do 
			local Line = f:ReadLine()
			if not Line or Line == nil then Line = "" end
			local LineData = string.Explode( " ", Line )

			if LineData[1] == key then
				return (LineData[2] and LineData[2] or LineData[1])
			end
		end
	f:Close()
	return nil
end


-----------------------------------------------------
-----------  Приемник серверных хуков   -------------
-----------------------------------------------------

net.Receive("SendGuideToClient", function()
	local name = net.ReadString()

	if GetData("LostCity_HelpData.txt", name) ~= nil then return end

	CreateHelpBox(rp.GuideCfg[name].header, rp.GuideCfg[name].main, name)
	AddUniqueData("LostCity_HelpData.txt", name, "true")
end)
	


