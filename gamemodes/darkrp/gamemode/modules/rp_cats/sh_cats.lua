if SERVER then function ScrW() return 1920 end function ScrH() return 1080 end end cats = cats or {} cats.config = {}
-- ^
-- | please do not touch these

------------------------------------------------------
-- BASIC CONFIG
------------------------------------------------------

-- positions
cats.config.spawnSize = { 450, 220 } -- size of ticket window
cats.config.spawnPosAdmin = { ScrW() - 500, 50 } -- position of admin ticket panel
cats.config.spawnPosUser = { ScrW() - 500, ScrH() - 250 } -- position of user ticket panel

-- appearance
cats.config.punchCardMode = 'dots' -- 'line', 'dots' or 'columns'
cats.config.punchCardStart = 5 -- first hour of punchcard (typically server restart time in 24 format)

-- rating
cats.config.defaultRating = 3 -- if somehow we timed out ticket rating, which rating it falls back to
cats.config.ratingTimeout = 60 -- after what time in seconds rating will be timed out

-- sound
cats.config.newTicketSound = 'buttons/bell1.wav' -- well, new ticket sound (surprise)

-- language
cats.lang = {
    openTickets = "Открытые жалобы",
    myTicket = "Моя жалоба",
    userDisconnected = "Игрок вышел",
    claimedBy = "Разбирается",
    sendMessage = "Отправить сообщение...",
    typeYourMessage = "Введи сообщение:",
    actions = "Действия",
    action_claim = "Взять жалобу",
    action_unclaim = "Передать жалобу",
    action_goto = "К нему",
    action_bring = "Ко мне",
    action_return = "Вернуть его",
    action_returnself = "Вернуть меня",
    action_copySteamID = "Скопировать SteamID",
    action_close = "Закрыть жалобу",
    error_wait = "Тихо-тихо, куда так разогнался?",
    error_noAccess = "Доступ запрещен",
    error_playerNotFound = "Игрок не найден",
    error_ticketNotEnded = "Жалоба еще не закрыта",
    error_ticketNotFound = "Жалоба не найдена",
    error_ticketEnded = "Жалобу уже закрыли",
    error_ticketNotClaimed = "Жалоба не взята",
    error_ticketAlreadyClaimed = "Жалобу уже взяли",
    error_needToRate = "Ты должен оценить предыдущую жалобу!",
	error_cantCancelHasAdmin = "Ты не можешь отменить жалобу, которую рассматривают!",
    ticketClaimed = "Ты принял жалобу",
    ticketUnclaimed = "Ты передал жалобу",
    ticketClaimedBy = "%s принял твою жалобу",
    ticketUnclaimedBy = "Администратор передал жалобу",
    ticketClosed = "Жалоба закрыта",
    ticketClosedBy = "%s закрыл твою жалобу. Оцени его работу!",
    ticketRatedForAdmin = "Оценка по твоей жалобе: %s",
    ticketRatedForUser = "Ты оценил решение жалобы на %s",
    ticketUserLeft = "Игрок, открывший жалобу, вышел",
    rateAdmin = "Выбери оценку ниже",
    ok = "ОК",
    cancel = "Отмена",
    ticket_noAdmins = "На сервере нет администраторов, но когда кто-нибудь зайдет, они увидят жалобу",
    dow = {"ПН","ВТ","СР","ЧТ","ПТ","СБ","ВС"},
}

------------------------------------------------------
-- ADVANCED SETTINGS (do not edit unless you're a dev)
------------------------------------------------------

cats.config.serverID = "lostcity"
cats.config.getPlayerName = function(ply)
  return ply:RPName(true) .. " (" .. ply:SteamName() .. ")"
end
cats.config.playerCanSeeTicket = function(ply, ticketSteamID)
  return ply:HasFlag("A") or ply:SteamID() == ticketSteamID
end
cats.config.triggerText = function(ply, text)
  if cats.config.playerCanSeeTicket(ply, "") then return false end

  text = text:Trim()
  if text:sub(1,1) == '@' then
      return true, text:sub(2):Trim()
  end

  return false
end
cats.config.notify = function(ply, msg, type, duration)
    -- if IsValid(ply) then
    --     DarkRP.notify(ply, type, duration, msg)
    -- else
        -- ChatAddText(msg)
        ply:ChatPrint(msg)
    -- end
end

-- NOTE: these are clientside
cats.config.commands = {
    { -- bring
        text = cats.lang.action_bring,
        icon = 'user_go',
        click = function(ply)
            RunConsoleCommand('ba', 'bring', ply:SteamID())
        end
    },
    { -- return
        text = cats.lang.action_return,
        icon = 'arrow_undo',
        click = function(ply)
            RunConsoleCommand('ba', 'return', ply:SteamID())
        end
    },
    { -- goto
        text = cats.lang.action_goto,
        icon = 'arrow_right',
        click = function(ply)
            RunConsoleCommand('ba', 'goto', ply:SteamID())
        end
    },
    { -- return self
        text = cats.lang.action_returnself,
        icon = 'arrow_rotate_clockwise',
        click = function(ply)
            RunConsoleCommand('ba', 'return', LocalPlayer():SteamID())
        end
    },
    { -- copy steamID
        text = cats.lang.action_copySteamID,
        icon = 'key_go',
        click = function(ply)
            SetClipboardText( ply:SteamID() )
        end
    },
}

-- | also please do not touch these
-- V
if SERVER then ScrW = nil ScrH = nil end
