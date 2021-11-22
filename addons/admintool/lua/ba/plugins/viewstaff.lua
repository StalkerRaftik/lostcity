if (SERVER) then
	util.AddNetworkString('ba.ViewStaff')
end

ba.cmd.Create('View Staff', function(pl, args)
	local showRank = pl:HasAccess("M")
	local showDetails = pl:HasAccess("S")
	
	local columns = {}
	columns[1] = {
		Header = 'Name',
		Data = {}
	}
	if (showRank) then
		columns[2] = {
			Header = 'Rank',
			Data = {}
		}
		if (showDetails) then
			columns[3] = {
				Header = 'Status',
				Data = {}
			}
		end
	end
	
	for k, v in ipairs(player.GetAll()) do
		if (v:IsAdmin()) then			
			if (showRank) then
				table.insert(columns[1].Data, {v:Name(), v:SteamID()})
				table.insert(columns[2].Data, v:GetRank())
				
				if (showDetails) then
					local status = (v:IsAFK() and 'AFK ' or 'Idle ') .. ba.str.FormatTime(v:AFKTime())
					
					if (v:GetNetVar('Spectating')) then
						local targ = v:GetObserverTarget()
						
						status = status .. ', Spectating ' .. (IsValid(targ) and targ:NameID() or 'NULL')
					end
					
					table.insert(columns[3].Data, status)
				end
			else
				if (!v:IsAFK()) then
					table.insert(columns[1].Data, {v:Name(), v:SteamID()})
				end
			end
		end
	end
	
	local data = util.Compress(pon.encode(columns))
	local size = data:len()
	
	net.Start('ba.ViewStaff')
		net.WriteUInt(size, 16)
		net.WriteData(data, size)
	net.Send(pl)
end)
:SetHelp('Список всех администраторов на сервере')

if (SERVER) then return end

local fr
net.Receive('ba.ViewStaff', function(len)
	local size = net.ReadUInt(16)
	local columns = pon.decode(util.Decompress(net.ReadData(size)))
	
	if (IsValid(fr)) then fr:Remove() end
	
	fr = ui.Create('ui_frame', function(self)
		self:SetSize(800, 600)
		self:SetTitle("Active Staff")
		self:Center()
		self:MakePopup()
	end)
	
	local list = ui.Create('DListView', function(self, p)
		self:Dock(FILL)
		self:SetSize(p:GetWide(), p:GetTall() - 35)
		self:SetMultiSelect(false)
		self:AddColumn('Name')
		if (columns[2]) then
			self:AddColumn('Rank'):SetFixedWidth(115)
			if (columns[3]) then
				self:AddColumn("Status")
			end
		end
		self:SetHeaderHeight(25)
	end, fr)
	
	list.OnRowSelected = function(parent, line)
		local row 		= list:GetLine(line)
		local log 		= row:GetColumnText(1) .. ' | ' ..  row:GetColumnText(2) .. ' | ' .. row:GetColumnText(3)
		local menu 		= ba.ui.DermaMenu()
		
		menu:AddOption('Copy Line', function() 
			SetClipboardText(log)
			chat.AddText(color_white, 'Copied Line: ' .. log)
		end)

		for k, v in SortedPairs(row.Copy or {}) do
			menu:AddOption('Copy ' .. k, function() 
				SetClipboardText(v)
				LocalPlayer():ChatPrint('Copied ' .. k)
			end)
		end
		menu:Open()
	end
	
	for k, v in ipairs(columns[1].Data) do
		local line = {v[1] .. ' (' .. v[2] .. ')'}
		
		if (columns[2]) then
			line[2] = columns[2].Data[k]
			if (columns[3]) then
				line[3] = columns[3].Data[k]
			end
		end
		
		list:AddLine(unpack(line)).Copy = {SteamID=v[2]}
	end
	
	if (!columns[1].Data[1]) then
		list:AddLine("Никого нет в сети! Пишите в группу vk.com/octopusgmod, если такое случается постоянно")
	end
end)