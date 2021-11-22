local files = {
  "cl_button.lua",
  "cl_fonts.lua",
  "cl_frame.lua",
  "cl_grid.lua",
  "cl_horizontalscroller.lua",
  "cl_icon.lua",
  "cl_label.lua",
  "cl_modelpanel.lua",
  "cl_outlinedlabel.lua",
  "cl_panel.lua",
  "cl_progressbar.lua",
  "cl_scrollpanel.lua",
  "cl_slider.lua",
  "cl_tile.lua",
  "cl_vscrollbar.lua"
}


for k,v in pairs(files) do 
  if CLIENT then
    include(v)
  else
    AddCSLuaFile(v)
  end
end
