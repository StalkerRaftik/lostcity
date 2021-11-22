local ScreenPos = ScrH()/1.09



local Colors = {}

Colors[NOTIFY_GENERIC] = Color(52, 73, 94)

Colors[NOTIFY_ERROR] = Color(52, 73, 94)

Colors[NOTIFY_UNDO] = Color(52, 73, 94)

Colors[NOTIFY_HINT] = Color(52, 73, 94)

Colors[NOTIFY_CLEANUP] = Color(52, 73, 94)

local Icons = {}

Icons[NOTIFY_GENERIC] = Material( "samprp/moreicons/bubble_info.png" )

Icons[NOTIFY_ERROR] = Material( "samprp/moreicons/rhomb_warning.png" )

Icons[NOTIFY_UNDO] = Material( "samprp/moreicons/reset.png" )

Icons[NOTIFY_HINT] = Material( "samprp/moreicons/bubble_info.png" )

Icons[NOTIFY_CLEANUP] = Material( "samprp/moreicons/refresh.png" )




local Notifications = {}

local Theme = {

  BG = Color(0, 0, 0, 220),

  Outline = Color(0, 0, 0, 255),

  Text = Color(255, 255, 255, 255),

}



local function DrawNotification(x, y, w, h, text, icon, col, progress, notif)

  local frac = (notif.time - CurTime()) / (notif.time - notif.start)

  
  
  draw.RoundedBox( 0, x, y, w, h, Color(0, 0, 0, 220))

  draw.SimpleText(text, "rp.ui.21", x + 40, y + h / 2, Theme.Text, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)


  surface.SetDrawColor(Theme.Text)

  surface.SetMaterial(icon)
  
  surface.DrawTexturedRect(x + 8, y + 3, 25, 25)
  
  surface.SetDrawColor(Color(70,70,70,200))
    
  surface.DrawOutlinedRect(x, y, w, h)
    
end



function notification.AddLegacy(text, type, time)

  surface.SetFont("rp.ui.21")

  surface.PlaySound("ui/hint.wav")

  local w = surface.GetTextSize(text) + 20 + 32

  local h = 32

  local x = ScrW()/2

  local y = ScreenPos



  table.insert(Notifications, 1, {

    x = x,

    y = y,

    w = w,

    h = h,



    text = text,

    col = Colors[type],

    icon = Icons[type],

    start = CurTime(),

    time = CurTime() + time,



    progress = false,

  })

  MsgC("\n",color_white,"[",Color(255,150,0),"ОПОВЕЩЕНИЕ",color_white,"] ",color_white, text)

end





function notification.Kill(id)

  for k, v in ipairs(Notifications) do

    if v.id == id then v.time = 0 end

  end

end



hook.Add("HUDPaint", "DrawNotifications", function()

  for k, v in ipairs(Notifications) do

    DrawNotification(math.floor(v.x - v.w/2), math.floor(v.y), v.w, v.h, v.text, v.icon, v.col, v.progress, v)



    v.x = Lerp(FrameTime() * 10, v.x, v.x)

    v.y = Lerp(FrameTime() * 10, v.y, v.time > CurTime() and ScreenPos - (k - 2) * (v.h + 5) or v.y+50)

  end



  for k, v in ipairs(Notifications) do

    if v.time + 5 < CurTime() then

      table.remove(Notifications, k)

    end

  end

end)

