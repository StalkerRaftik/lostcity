if (SERVER) then
  util.AddNetworkString('_AntiCrash')

  timer.Create('AntiCrash', 5, 0, function()
    net.Start('_AntiCrash')
    net.Broadcast()
  end) 
elseif (CLIENT) then
  local color_white = Color(255,255,255)
  local color_red = Color(255,0,0)
  local color_black = Color(0,0,0)

  local NextReTry = false
  local IsCrashed = false
  local ReconnectTime = 0
  local Crash_Frame

  local function StartAutoconect()
    ReconnectTime = CurTime() + 40

    if IsValid(Crash_Frame) then Crash_Frame:Remove() end

    Crash_Frame = ui.Create('DFrame')
    Crash_Frame:SetSize(ScrW(), ScrH())
    Crash_Frame:SetPos(0, 0)
    Crash_Frame:SetTitle('')
    Crash_Frame:ShowCloseButton(false)
    function Crash_Frame:Paint(w, h)
      local delta = math.Clamp(ReconnectTime - CurTime(), 1, 40)

      draw.RoundedBoxOutlined( 2, 0, 0, w, h, Color(50, 50, 50, 200), Color(50,50,50,150) )

      draw.ShadowSimpleText('Упс, кажется сервер не отвечает', 'rp.ui.40', w/2, h/3, color_white, TEXT_ALIGN_CENTER)
      draw.ShadowSimpleText("Переподключение через: "..math.ceil(delta), 'rp.ui.40', w/2, h/2, delta % 1 < 0.2 and color_red or color_white, TEXT_ALIGN_CENTER)
    end
  end

  net.Receive('_AntiCrash', function()
    NextReTry = CurTime() + 10
    IsCrashed = false
    if IsValid(Crash_Frame) then
      Crash_Frame:Remove()
    end
  end)

  hook.Add('Think', 'AntiCrash.Think', function()
    if NextReTry and (not IsCrashed) and (NextReTry < CurTime()) then
      IsCrashed = true
      StartAutoconect()
    elseif IsCrashed and (ReconnectTime <= CurTime()) then
        RunConsoleCommand('retry')
    end
  end)

  hook.Add('InitPostEntity', 'AntiCrash.InitPostEntity', function()
    RunConsoleCommand('cl_timeout', 9999)
  end)
end
