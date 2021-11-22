local files, _ = file.Find('ba/core/ui/vgui/*.lua', 'LUA')
for k, v in ipairs(files) do
	ba.include_cl('vgui/' .. v)
end

local cmd = ba.cmd.Create('Menu')
cmd:RunOnClient(function(args)
	ba.ui.OpenMenu()
end)
cmd:SetHelp('Opens the quick menu')