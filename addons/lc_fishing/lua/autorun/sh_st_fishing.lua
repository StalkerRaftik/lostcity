AddCSLuaFile()

--const rarity colors
FISH_RARITY_COLORS = {
    ["обычная"] = Color( 175, 175, 175 ),
    ["необычная"] = Color( 135, 199, 255 ),
    ["редкая"] = Color( 17, 85, 221 ),
    ["очень редкая"] = Color( 136, 71, 255 ),
    ["мифическая"] = Color( 211, 44, 230 ),
    ["легендарная"] = Color( 235, 75, 75 )
}

--convenience function to print messages to chat
local plyMeta = FindMetaTable( "Player" )
function plyMeta:FishMessage( str, bErr )
    bErr = bErr or false
    if SERVER then
        net.Start( "STFishingMessages" )
            net.WriteString( str )
            net.WriteBool( bErr )
        net.Send( self )
    elseif CLIENT then
        return
    end
end

--[[-----------------------------------------[[--
    
    Function: Player.StartFishing
    Arg: lureEnt - The lure the player will
            manipulate.
    Realm: Shared
    Usage: st_fishinglure ENT.Think
    Called: When the player's lure hits the
            water, meaning when we should
            start controlling the lure and
            go fishing.

--]]-----------------------------------------]]--
function plyMeta:StartFishing()
    --make a water splash where it hits
    local fed = EffectData()
    fed:SetOrigin( self:GetNWEntity( "plyLure" ):GetPos() )
    fed:SetScale( 3 )
    util.Effect( "watersplash", fed )
    --possibly deprecated var
    self.SpecLure = true
    --set the lure's position to the center of the circle
    self:GetNWEntity( "plyLure" ):SetPos( self:GetNWEntity( "plyLure" ).IntOrigin )
    --set up the lure's model
    if self:GetNWEntity( "plyLure" ).LureType == "carrot" then
        self:GetNWEntity( "plyLure" ):SetAngles( Angle( 0, 0, 90 ) )
    end
    self:GetNWEntity( "plyLure" ):SetModelScale( LURE_TYPES[ self:GetNWEntity( "plyLure" ).LureType ].scale )
    if self:GetNWEntity( "plyLure" ).LureType == "gumball" then
        self:GetNWEntity( "plyLure" ):SetColor( Color( 251, 185, 199 ) )
    end
    --send a net to set our view on the lure
    timer.Simple( 0, function()
        net.Start( "StartUsingLure" )
            net.WriteVector( self:GetNWEntity( "plyLure" ).IntOrigin )
        net.Send( self )
    end )
    --StartCommand takes our mouse input to move the lure
    hook.Add( "StartCommand", "MoveTheLureAround" .. self:EntIndex(), function( ply, cmd )
        if ply == self then
            if !IsValid( self:GetNWEntity( "plyLure" ) ) or IsValid( ply:GetNWEntity( "REELING_IN" ) ) then
                --is this a hack?
                hook.Remove( "StartCommand", "MoveTheLureAround" .. self:EntIndex() )
                return
            end
            local dx, dy = cmd:GetMouseX(), cmd:GetMouseY()
            --test collision with the edge of the circle
            local nextPos = self:GetNWEntity( "plyLure" ):GetPos() + Vector( ( dx + dy/2 ) / 250, ( -dy + dx/2 ) / 250, 0 )
            local diff = nextPos - self:GetNWEntity( "plyLure" ):GetPos()
            if nextPos:DistToSqr( self:GetNWEntity( "plyLure" ).IntOrigin ) <= 10000 then 
                self:GetNWEntity( "plyLure" ):SetPos(self:GetNWEntity( "plyLure" ):GetPos() + Vector( ( dx + dy/2 ) / 250, ( -dy + dx/2 ) / 250, 0 ) )
            end
            --shit way to simulate movement
            --revise this later
            self:GetNWEntity( "plyLure" ):SetAngles( self:GetNWEntity( "plyLure" ):GetAngles() + Angle( 0, ( diff.x ) * 10, 0 ) ) --whatever
        end
    end )

    --spawn some fishes to catch
    if SERVER then
        timer.Create( "FishSpawn" .. self:EntIndex(), 3, 3, function()
            if self:GetActiveWeapon():GetNWBool( "LineCast" ) and !IsValid( self:GetNWEntity( "REELING_IN" ) ) and IsValid( self:GetNWEntity( "plyLure" ) ) then
                local fishums = ents.Create( "st_fishums" )
                --yes, this spawns them in a cuboid when the area should be a cylinder
                --i dont care
                fishums:SetPos( self:GetNWEntity( "plyLure" ).IntOrigin + Vector( math.random( -100, 100 ), math.random( -100, 100 ), math.random( -10, -50 ) ) )
                fishums:SetAngles( Angle( 0, math.random( -180, 180 ), 0 ) )
                fishums:SetOwner( self )
                fishums:SetModelScale( 0, 0 )
                fishums.IntOrigin = self:GetNWEntity( "plyLure" ).IntOrigin
                fishums:Spawn()
                fishums:SetMoveType( MOVETYPE_NOCLIP )
                fishums:SetModelScale( 2, 1 )
            end
        end )
    end

end

if SERVER then

    util.AddNetworkString( "STFishingMessages" ) --chat messages | sv-cl
    util.AddNetworkString( "StartUsingLure" ) --calcview | sv-cl
    util.AddNetworkString( "OpenLureMenu" ) --open lure menu | sv-cl
    util.AddNetworkString( "SelectLure" ) --select lure | cl-sv
    util.AddNetworkString( "ReelTheFishIn" ) --play the reeling game | sv-cl
    util.AddNetworkString( "GotAFishDude" ) --get a fuckin fish | cl-sv
    util.AddNetworkString( "FishCaughtChatMessage" ) --tell you what fish you got | sv-cl
    util.AddNetworkString( "FishingRodTransaction" ) --sell fish | cl-sv
    util.AddNetworkString( "CutFish" ) --sell fish | cl-sv

    hook.Add( "PlayerDisconnected", "GetRidOfFishAndLures", function( ply )
    
        if IsValid( ply:GetNWEntity( "plyLure" ) ) then ply:GetNWEntity( "plyLure" ):Remove() end
        for k,v in pairs( ents.FindByClass( "st_fishums" ) ) do
            if v:GetOwner() == ply then
                v:Remove()
             end
        end

    end )

    hook.Add( "PlayerDeath", "UnFishIfDie", function( vic, wep, atk )
    
        vic.SpecLure = false
        vic:SetMoveType( MOVETYPE_WALK )
        if IsValid( vic:GetNWEntity( "plyLure" ) ) then vic:GetNWEntity( "plyLure" ):Remove() end
        vic:SetNWBool( "PLAYING_FISHING", false )
        vic:GetActiveWeapon().Cast = false
        vic:GetActiveWeapon():SetNWBool( "LineCast", false )
        for k,v in pairs( ents.FindByClass( "st_fishums" ) ) do
            if v:GetOwner() == vic then
                v:Remove()
             end
        end

    end )

    --i refuse to believe that there's no better way to do this
    --if you know of a better way, let me know immedately at
    --discord.sweptthr.one or sweptthrone971@gmail.com
    hook.Add( "Initialize", "SetupCleanFishTable", function()
        db:Query( [[CREATE TABLE IF NOT EXISTS st_fish_table( SteamID TEXT, 
                    anchovy INT,
                    angelfish INT,
                    anglerfish INT,
                    arapaima INT,
                    arowana INT,
                    ayu INT,
                    barracuda INT,
                    barramundi INT,
                    bass INT,
                    betta INT,
                    bitterling INT,
                    blobfish INT,
                    blue_marlin INT,
                    carp INT,
                    catfish INT,
                    cod INT,
                    coelacanth INT,
                    eel INT,
                    flying_fish INT,
                    frogfish INT,
                    goby INT,
                    goldfish INT,
                    grouper INT,
                    guitarfish INT,
                    guppy INT,
                    halibut INT,
                    humphead_wrasse INT,
                    japanese_perch INT,
                    lamprey INT,
                    loach INT,
                    lungfish INT,
                    mackerel INT,
                    mantaray INT,
                    minnow INT,
                    mullet INT,
                    neon_tetra INT,
                    oarfish INT,
                    parrot_fish INT,
                    pike INT,
                    piranha INT,
                    pollock INT,
                    remora INT,
                    rockfish INT,
                    sardine INT,
                    sculpin INT,
                    sheephead INT,
                    siamese_tigerfish INT,
                    snakehead INT,
                    snapper INT,
                    sockeye_salmon INT,
                    stickleback INT,
                    sunfish INT,
                    surgeon_fish INT,
                    tiger_fish INT,
                    trout INT,
                    tuna INT )]] )
        MsgC( Color( 0, 128, 255 ), "[STFishing] Successfully initialized an empty st_fish_table table!\n" )
    end )

    hook.Add( "PlayerInitialSpawn", "AssignFishTable", function( ply )
        ply.sidStr  = game.SinglePlayer() and "me" or ply:SteamID64()
        db:Query( [[SELECT * FROM st_fish_table WHERE SteamID = ']] .. ply.sidStr .. "'", function(data) 
        	if not data[1] then
	            db:Query( [[INSERT INTO st_fish_table( SteamID,
	                        anchovy,
	                        angelfish,
	                        anglerfish,
	                        arapaima,
	                        arowana,
	                        ayu,
	                        barracuda,
	                        barramundi,
	                        bass,
	                        betta,
	                        bitterling,
	                        blobfish,
	                        blue_marlin,
	                        carp,
	                        catfish,
	                        cod,
	                        coelacanth,
	                        eel,
	                        flying_fish,
	                        frogfish,
	                        goby,
	                        goldfish,
	                        grouper,
	                        guitarfish,
	                        guppy,
	                        halibut,
	                        humphead_wrasse,
	                        japanese_perch,
	                        lamprey,
	                        loach,
	                        lungfish,
	                        mackerel,
	                        mantaray,
	                        minnow,
	                        mullet,
	                        neon_tetra,
	                        oarfish,
	                        parrot_fish,
	                        pike,
	                        piranha,
	                        pollock,
	                        remora,
	                        rockfish,
	                        sardine,
	                        sculpin,
	                        sheephead,
	                        siamese_tigerfish,
	                        snakehead,
	                        snapper,
	                        sockeye_salmon,
	                        stickleback,
	                        sunfish,
	                        surgeon_fish,
	                        tiger_fish,
	                        trout,
	                        tuna ) VALUES( ']] .. ply.sidStr .. "', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 )" )
	            MsgC( Color( 0, 128, 255 ), "[STFishing] Added a new record for " .. ply:Name() .. "!\n" )
        	end
    	end)
        
        db:Query( [[SELECT * FROM st_fish_table WHERE SteamID = ']] .. ply.sidStr .. "'", function(data)
        	ply.fishTable = data
        end)
        MsgC( Color( 0, 128, 255 ), "[STFishing] Assigned fish table to " .. ply:Name() .. "!\n" )
    end )

    function plyMeta:GetFishTable()
        self.sidStr = game.SinglePlayer() and "me" or self:SteamID64()
        db:Query( [[SELECT * FROM st_fish_table WHERE SteamID = ']] .. self.sidStr .. "'", function(data) 
        	self.fishTable = data
    	end)
    	for k,v in pairs(self.fishTable[1]) do
    		if v == 0 then
    			self.fishTable[1][k] = nil
    		end
    	end
    	return self.fishTable[1]
    end

    function plyMeta:SetFishValue( fish, val )
        val = val or 0
        self.sidStr = game.SinglePlayer() and "me" or self:SteamID64()
        local tab = self:GetFishTable()
        tab.fish = val
        db:Query( "UPDATE st_fish_table SET SteamID = '" .. self.sidStr .. "', " .. fish .. " = " .. val .. " WHERE SteamID = '" .. self.sidStr .. "'" )
    end

    function plyMeta:AddFishValue( fish, num )
        num = num or 1
        self.sidStr = game.SinglePlayer() and "me" or self:SteamID64()
        local tab = self:GetFishTable()
        if not tab[fish] then tab[fish] = 0 end
        tab[fish] = tab[fish] + num
        db:Query( "UPDATE st_fish_table SET SteamID = '" .. self.sidStr .. "', " .. fish .. " = " .. tab[fish] .. " WHERE SteamID = '" .. self.sidStr .. "'" )
    end

    net.Receive( "FishingRodTransaction", function( len, ply )
        local fsh = net.ReadString()

        if tonumber( ply:GetFishTable()[ fsh ] ) > 0 then
            ply:AddFishValue( fsh, -1 )
            if DarkRP then
                
                local rar = FISH_TYPES[ fsh ].rarity
                local mone = 0
                if rar == "обычная" then
                    mone = 20
                elseif rar == "необычная" then
                    mone = 40
                elseif rar == "редкая" then
                    mone = 60
                elseif rar == "очень редкая" then
                    mone = 100
                elseif rar == "мифическая" then
                    mone = 500
                else
                    mone = 1000
                end

                ply:addMoney( mone )
                DarkRP.notify( ply, 0, 5, "Вы продали " .. FISH_TYPES[ fsh ].name .. " за " .. DarkRP.formatMoney( mone ) )

            else
                ply:FishMessage( "You sold a " .. FISH_TYPES[ fsh ].name .. "!", false )
            end
        end
    end )

    net.Receive( "CutFish", function( len, ply )
    	local fsh = net.ReadString()
    	if not ply:GetFishTable()[ fsh ] or tonumber( ply:GetFishTable()[ fsh ] ) <= 0 then return end
        ply:AddFishValue( fsh, -1 )


    	local rar = FISH_TYPES[ fsh ].rarity
        local rawamnt = 0
        if rar == "обычная" then
            rawamnt = 3
        elseif rar == "необычная" then
            rawamnt = 9
        elseif rar == "редкая" then
            rawamnt = 15
        elseif rar == "очень редкая" then
            rawamnt = 20
        elseif rar == "мифическая" then
            rawamnt = 30
        else
            rawamnt = 40
        end

        ply:AddItem(INV_FOOD, "models/foodnhouseholditems/fishsteak.mdl", rawamnt)
        DarkRP.notify( ply, 0, 5, "Вы разделали " .. FISH_TYPES[ fsh ].name)
    end )

    local function PickRewards( ply, rar )
        local validFishRewards = {}
        for k,v in pairs( FISH_TYPES ) do
            if v.rarity == rar then
                table.insert( validFishRewards, k )
            end
        end
        if validFishRewards == {} then
            for k,v in pairs( FISH_TYPES ) do
                table.insert( validFishRewards, k )
            end
        end
        for k,v in pairs( validFishRewards ) do
            if LURE_TYPES[ ply:GetNWEntity( "plyLure" ).LureType ].blacklist[ v ] then
                table.RemoveByValue( validFishRewards, v )
            end
        end
        return table.Random( validFishRewards )
    end

    net.Receive( "GotAFishDude", function( len, ply )
        local result = net.ReadBool()
        local diff = net.ReadInt( 4 )
        if ply.IsPlayerFishing != true then
            DarkRP.notify( ply, 0, 5, "Произошла ошибка!")
            return
        end
        ply.IsPlayerFishing = false
        if not result then
            for k,v in pairs( ents.FindByClass( "st_fishums" ) ) do
                if v:GetOwner() == ply and v.Pursuing then
                    v.Pursuing = false
                    v.PursuePos = nil
                    v:SetColor( Color( 192, 0, 0 ) )
                    v:SetAngles( Angle( 45, math.random( -180, 180 ), 0 ) )
                    v:SetAbsVelocity( Vector( 0, 0, 0 ) )
                    v:SetAbsVelocity( v:GetForward() * 50 )
                    v:SetModelScale( 0, 1 )
                    timer.Create( "Fishrink" .. v:EntIndex(), 1, 1, function()
                    if !IsValid( v ) then return end
                        v:Remove()
                    end )
                end
            end
        else
            local rarityResult = math.random( 1, 100 )
            local reward
            if rarityResult <= 50 then
                reward = PickRewards( ply, "обычная" )
            elseif rarityResult <= 75 then
                reward = PickRewards( ply, "необычная" )
            elseif rarityResult <= 90 then
                reward = PickRewards( ply, "редкая" )
            elseif rarityResult <= 96 then
                reward = PickRewards( ply, "очень редкая" )
            elseif rarityResult <= 99 then
                reward = PickRewards( ply, "мифическая" )
            elseif rarityResult == 100 then
                reward = PickRewards( ply, "легендарная" )
            else
                print( "That's literally impossible." )
            end

            ply:AddFishValue( reward )
            ply:AddExperience(rp.Exp_Cfg["Fishing"], LVL_MSG_ENUM.CRAFT)
            net.Start( "FishCaughtChatMessage" )
                net.WriteString( reward )
            net.Send( ply )
            --print( "You caught a " .. FISH_TYPES[ reward ].rarity .. " " .. FISH_TYPES[ reward ].name )
        end

        ply.SpecLure = false
        ply:SetMoveType( MOVETYPE_WALK )
        ply:GetNWEntity( "plyLure" ):Remove()
        ply:SetNWBool( "PLAYING_FISHING", false )
        ply:GetActiveWeapon().Cast = false
        ply:GetActiveWeapon():SetNWBool( "LineCast", false )
        if DarkRP then
            ply:GetActiveWeapon().LureType = ""
        end
        for k,v in pairs( ents.FindByClass( "st_fishums" ) ) do
            if v:GetOwner() == ply then
                v:Remove()
            end
        end

    end )

end

hook.Add( "KeyPress", "QuitLure", function( ply, key )
    if IsValid( ply:GetNWEntity( "plyLure" ) ) then
        --make a neat water splash effect when you click with a lure out
        --it just looks nice
        if key == IN_ATTACK then
            if IsValid( ply:GetNWEntity( "REELING_IN" ) ) and !ply:GetNWBool( "PLAYING_FISHING" ) then
                if SERVER then
                    ply:GetNWEntity( "REELING_IN" ):EmitSound( "npc/headcrab/headbite.wav", 75, 200 )
                    --ply:GetNWEntity( "plyLure" ):SetMoveType( MOVETYPE_NONE )
                    --ply:ChatPrint( "YOU REELED IT IN!" )
                    timer.Remove( "REELITIN" .. ply:EntIndex() )
                    ply:SetNWBool( "PLAYING_FISHING", true )
                    ply:ScreenFade( SCREENFADE.IN, Color( 255, 255, 128 ), 0.25, 0 )
                    net.Start( "ReelTheFishIn" )
                        net.WriteInt( math.random( 1, 6 ), 4 )
                    net.Send( ply )
                end
            else
                local ed = EffectData()
                ed:SetOrigin( ply:GetNWEntity( "plyLure" ):GetPos() )
                ed:SetScale( 1 )
                util.Effect( "watersplash", ed )

                if SERVER then
                    for k,v in pairs( ents.FindByClass( "st_fishums" ) ) do
                        if v:GetOwner() == ply and v.Pursuing then
                            v.Pursuing = false
                            v.PursuePos = nil
                            v:SetColor( Color( 192, 0, 0 ) )
                            v:SetAngles( Angle( 45, math.random( -180, 180 ), 0 ) )
                            v:SetAbsVelocity( Vector( 0, 0, 0 ) )
                            v:SetAbsVelocity( v:GetForward() * 50 )
                            v:SetModelScale( 0, 1 )
                            timer.Create( "Fishrink" .. v:EntIndex(), 1, 1, function()
                                if !IsValid( v ) then return end
                                local fishums = ents.Create( "st_fishums" )
                                --yes, this spawns them in a cuboid when the area should be a cylinder
                                --i dont care
                                fishums:SetPos( v.IntOrigin + Vector( math.random( -100, 100 ), math.random( -100, 100 ), math.random( -10, -50 ) ) )
                                fishums:SetAngles( Angle( 0, math.random( -180, 180 ), 0 ) )
                                fishums:SetOwner( v:GetOwner() )
                                fishums:SetModelScale( 0, 0 )
                                fishums.IntOrigin = v.IntOrigin
                                fishums:Spawn()
                                fishums:SetMoveType( MOVETYPE_NOCLIP )
                                fishums:SetModelScale( 2, 1 )
                                v:Remove()
                            end )
                        end
                    end
                end

            end
        end
        --quit fishing, because thats how TU does it
        if key == IN_DUCK then  
            ply.SpecLure = false
            ply:SetMoveType( MOVETYPE_WALK )
            if SERVER then
                ply:GetNWEntity( "plyLure" ):Remove()
                ply:SetNWBool( "PLAYING_FISHING", false )
                ply:GetActiveWeapon().Cast = false
                ply:GetActiveWeapon():SetNWBool( "LineCast", false )
                for k,v in pairs( ents.FindByClass( "st_fishums" ) ) do
                    if v:GetOwner() == ply then
                        v:Remove()
                    end
                end
            end
        end
    end
end )

if CLIENT then
    local diffLookups = { 4, 3.5, 3.25, 3, 2.75, 2.5 }
    local diffTxt = { "Очень легко", "легко", "средне", "сложно", "очень сложно", "невыносимо сложно" }
    local diffCol = {
        Color( 0, 255, 0 ),
        Color( 128, 255, 0 ),
        Color( 255, 255, 0 ),
        Color( 255, 128, 0 ),
        Color( 255, 0, 0 ),
        Color( 192, 0, 64 )
    }

    --create fonts
    --i better have included the font
    surface.CreateFont( "FishWindow", {
        font = "Freestyle Script",
        size = 32,
        weight = 500
    } )

    surface.CreateFont( "FishHUD", {
        font = "Hurry Up",
        size = 32,
        weight = 200
    } )

    surface.CreateFont( "LureButton", {
        font = "Arial",
        size = 16,
        weight = 100
    } )

    surface.CreateFont( "LureHeader", {
        font = "Arial",
        size = 32,
        weight = 2000
    } )

    net.Receive( "FishCaughtChatMessage", function()
        local fish = net.ReadString()

        chat.AddText( Color( 0, 255, 0 ), "[STFishing] ", color_white, "Вы поймали ", FISH_RARITY_COLORS[ FISH_TYPES[ fish ].rarity ], string.upper( FISH_TYPES[ fish ].rarity ), " ", FISH_TYPES[ fish ].name, color_white, "!" )
    end )

    net.Receive( "OpenLureMenu", function( len )
            local ent = net.ReadEntity()
            local tab = net.ReadData( len )
            tab = util.JSONToTable( util.Decompress( tab ) )

            local LureMenu = vgui.Create( "DFrame" )
            LureMenu:SetPos( 0, 0 )
            LureMenu:SetSize( 600, 400 )
            LureMenu:SetTitle( "" )
            LureMenu:SetVisible( true )
            LureMenu:SetDraggable( false )
            LureMenu:ShowCloseButton( false )
            LureMenu:MakePopup()
            LureMenu:Center()
            LureMenu.Paint = function( self, w, h )
                draw.RoundedBox( 0, 0, 0, w, h, Color( 54, 20, 18, 255 ) )
                draw.SimpleText( "Рыбацкий рюкзак", "rp.ui.40", 5, 2 )
                surface.SetDrawColor( 255, 255, 255, 128 )
                surface.DrawLine( 300, 40, 300, 380 )
            end

            local CloseButton = vgui.Create( "DButton", LureMenu )
            CloseButton:SetPos( 560, 0 )
            CloseButton:SetSize( 40, 20 )
            CloseButton:SetText( "X" )
            CloseButton:SetTextColor(Color(255,255,255))
            CloseButton.DoClick = function( self )
                LureMenu:Close()
            end
            CloseButton.Paint = function( self, w, h )
                if CloseButton:IsHovered() then
                    draw.RoundedBox( 0, 0, 0, w, h, Color( 128, 0, 0, 255 ) )
                else
                    draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 0, 0, 255 ) )
                end
                surface.SetDrawColor( color_black )
            end

            local LureLabel = vgui.Create( "DLabel", LureMenu )
            LureLabel:SetFont( "rp.ui.40" )
            LureLabel:SetText( "Наживка" )
            LureLabel:SetTextColor( Color( 255, 255, 255 ) )
            LureLabel:SetPos( 402, 55 )
            LureLabel:SizeToContents()

            local LureLabel = vgui.Create( "DLabel", LureMenu )
            LureLabel:SetFont( "rp.ui.40" )
            LureLabel:SetText( "Рыба" )
            LureLabel:SetTextColor( Color( 255, 255, 255 ) )
            LureLabel:SetPos( 120, 55 )
            LureLabel:SizeToContents()

            local LureGrid = vgui.Create( "DGrid", LureMenu )
            LureGrid:SetPos( 315, 90 )
            LureGrid:SetSize( 280, 340 )
            LureGrid:SetCols( 3 )
            LureGrid:SetColWide( 90 )
            LureGrid:SetRowHeight( 90 )

            for k,v in pairs( LURE_TYPES ) do
                local lureBut = vgui.Create( "DModelPanel" )
                lureBut:SetSize( 90, 90 )
                lureBut:SetModel( v.model )
                if DarkRP then
                    lureBut:SetText( v.name .. " $" .. v.price )
                else
                    lureBut:SetText( v.name )
                end
                lureBut:SetTooltip( v.desc )
                lureBut:SetContentAlignment( 2 )
                lureBut:SetFont( "LureButton" )
                lureBut:SetLookAt( lureBut:GetEntity():GetPos() )
                lureBut:SetFOV( 20 )
                lureBut:GetEntity():SetAngles( Angle( 0, 0, 0 ) )
                lureBut:GetEntity():SetModelScale( v.scale * 2 )
                lureBut.InternalValue = k
                function lureBut:LayoutEntity( ent )
                end

                lureBut.PaintOver = function( self, w, h )
                    if lureBut:IsHovered() then
                        if DarkRP then
                            self:SetText( "м." .. v.price )
                        end
                        surface.SetDrawColor( 255, 255, 0 )
                        surface.DrawOutlinedRect( 1, 1, w - 2, h - 2 )
                        surface.DrawOutlinedRect( 2, 2, w - 4, h - 4 )
                        self:SetTextColor( Color( 255, 255, 255 ) )
                    else
                        if DarkRP then
                            self:SetText( v.name )
                        end
                        surface.SetDrawColor( 255, 255, 0 )
                        self:SetTextColor( Color( 255, 255, 255 ) )
                    end
                    surface.DrawOutlinedRect( 0, 0, w, h )
                end
                lureBut.DoClick = function( self )
                    net.Start( "SelectLure" )
                        net.WriteEntity( ent )
                        net.WriteString( k )
                    net.SendToServer()
                    LureMenu:Close()
                end

                LureGrid:AddItem( lureBut )
            end

            local FishScroller = vgui.Create( "DScrollPanel", LureMenu )
            FishScroller:SetPos( 10, 90 )
            FishScroller:SetSize( 285, 270 )
            function FishScroller:Paint( w, h )
                surface.SetDrawColor( 255, 255, 0 )
                surface.DrawOutlinedRect( 0, 0, w, h )
            end

            local FishGrid = FishScroller:Add( "DGrid" )
            FishGrid:SetSize( 280, 340 )
            FishGrid:SetCols( 3 )
            FishGrid:SetColWide( 90 )
            FishGrid:SetRowHeight( 90 )

            for k,v in pairs( tab ) do
                if k == "SteamID" or v == "0" then continue end
                local fishBut = vgui.Create( "DModelPanel" )
                fishBut:SetSize( 90, 90 )
                fishBut:SetModel( FISH_TYPES[k].model )
                fishBut:SetText( v .. " " )
                fishBut:SetTooltip( FISH_TYPES[k].name )
                fishBut:SetContentAlignment( 3 )
                fishBut:SetFont( "LureButton" )
                fishBut:SetLookAt( fishBut:GetEntity():GetPos() )
                fishBut:SetFOV( 20 )
                fishBut:GetEntity():SetAngles( Angle( 0, 0, 0 ) )
                function fishBut:LayoutEntity( ent )
                end
                function fishBut:DoClick()

                    local SellMenu = DermaMenu()
                    local sellBut = SellMenu:AddOption( "Продать 1 " .. FISH_TYPES[k].name )
                    local inspBut = SellMenu:AddOption( "Рассмотреть " .. FISH_TYPES[k].name )
                    local cutBut = SellMenu:AddOption( "Разделать " .. FISH_TYPES[k].name )
                    SellMenu:Open()
                    function sellBut:DoClick()
                        net.Start( "FishingRodTransaction" )
                            net.WriteString( k )
                        net.SendToServer()
                        LureMenu:Close()
                    end
                    function inspBut:DoClick()
                        notification.AddLegacy( FISH_TYPES[k].name .. " это " .. FISH_TYPES[k].rarity .. " рыба.  У вас их " .. v .. ".", NOTIFY_GENERIC, 5 )
                    end
                    function cutBut:DoClick()
                        net.Start( "CutFish" )
                            net.WriteString( k )
                        net.SendToServer()
                        LureMenu:Close()
                    end
                end
                fishBut.PaintOver = function( self, w, h )
                    if fishBut:IsHovered() then
                        surface.SetDrawColor( FISH_RARITY_COLORS[ FISH_TYPES[k].rarity ] )
                        surface.DrawOutlinedRect( 1, 1, w - 2, h - 2 )
                        surface.DrawOutlinedRect( 2, 2, w - 4, h - 4 )
                        self:SetTextColor( Color( 255, 255, 255 ) )
                    else
                        surface.SetDrawColor( FISH_RARITY_COLORS[ FISH_TYPES[k].rarity ] )
                        self:SetTextColor( Color( 255, 255, 255 ) )
                    end
                    surface.DrawOutlinedRect( 0, 0, w, h )
                end

                FishGrid:AddItem( fishBut )
            end

        end )

    net.Receive( "ReelTheFishin", function()
        local difficulty = net.ReadInt( 4 )
        --local diffLookups = { 3, 2.75, 2.5, 2.25, 2, 1.5 }

        local musicToPlay = CreateSound( LocalPlayer(), "stfishing/fish-diff-" .. difficulty .. ".wav" )

        local randRad = math.Rand( 0, 2 * math.pi )
        local fishPosX, fishPosY = 137 * math.cos( randRad ) + 200, 137 * math.sin( randRad ) + 200
        local failState = 60
        local nextWinState = 0
        timer.Create( "DecreaseValue" .. LocalPlayer():EntIndex(), 0.1, 0, function()
            if failState <= 0 then timer.Remove( "DecreaseValue" .. LocalPlayer():EntIndex() ) end
            --failState = failState - 2
            failState = failState - 2
        end )
        local function RestartMovementIndicatorTimer( callbac )
            timer.Create( "MoveFishIndicator" .. LocalPlayer():EntIndex(), 0.1, 0, function()
                randRad = randRad + math.Rand( -0.05, 0.05 )
            end )
            callbac()
        end
        local function MoveIndicatorSomewhereDifferect()
            timer.Create( "MoveSomewhereElse" .. LocalPlayer():EntIndex(), math.Rand( 2, 5 ), 1, function()
                randRad = math.Rand( 0, 2 * math.pi )
                RestartMovementIndicatorTimer( MoveIndicatorSomewhereDifferect )
            end )
        end
        RestartMovementIndicatorTimer( MoveIndicatorSomewhereDifferect )
        
        musicToPlay:Play()
        local CatchWindow = vgui.Create( "DFrame" )
        CatchWindow:SetPos( 0, 0 )
        CatchWindow:SetSize( 400, 400 )
        CatchWindow:SetTitle( "" )
        CatchWindow:SetVisible( true )
        CatchWindow:SetDraggable( false )
        CatchWindow:ShowCloseButton( false )
        CatchWindow:MakePopup()
        CatchWindow:Center()
        CatchWindow.Think = function( self )
            if failState <= 0 then
                CatchWindow:Close()
                timer.Remove( "MoveFishIndicator" .. LocalPlayer():EntIndex() )
                timer.Remove( "MoveSomewhereElse" .. LocalPlayer():EntIndex() )
                PrintLocalFishingMessage( "Вы не смогли поймать рыбу, она ускользнула!", true )
                musicToPlay:Stop()
                surface.PlaySound( "stfishing/loser.wav" )
                net.Start( "GotAFishDude" )
                    net.WriteBool( false )
                    net.WriteInt( 0, 4 )
                net.SendToServer()
            end
            if failState >= 120 then
                CatchWindow:Close()
                timer.Remove( "MoveFishIndicator" .. LocalPlayer():EntIndex() )
                timer.Remove( "MoveSomewhereElse" .. LocalPlayer():EntIndex() )
                musicToPlay:Stop()
                surface.PlaySound( "stfishing/winner.wav" )
                net.Start( "GotAFishDude" )
                    net.WriteBool( true )
                    net.WriteInt( difficulty, 4 )
                net.SendToServer()
            end
        end
        CatchWindow.Paint = function( self, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, Color( 54, 20, 18, 0 ) )
            surface.SetFont( "FishHUD" )
            if difficulty == 6 then
                draw.SimpleText( "Лови её! - " .. diffTxt[ difficulty ], "FishHUD", math.random( 197, 203 ) - surface.GetTextSize( "Лови её! - " .. diffTxt[ difficulty ] )/2, math.random( -1, 6 ), diffCol[ difficulty ] )
            else
                draw.SimpleText( "Лови её! - " .. diffTxt[ difficulty ], "FishHUD", 200 - surface.GetTextSize( "Лови её! - " .. diffTxt[ difficulty ] )/2, 2, diffCol[ difficulty ] )
            end
            surface.SetDrawColor( HSVToColor( failState, 1, 0.75 ) )
            draw.NoTexture()
            draw.CircleFishing( 200, 200, 150, 50 )
            surface.SetDrawColor( 0, 0, 0, 255 )
            draw.CircleFishing( 200, 200, 125, 50 )
            local mx, my = self:CursorPos()
            local cx, cy = mx - 200, -( my - 200 )
            draw.NoTexture()
            surface.SetDrawColor( 255, 255, 255, 255 )
            local distMult = 150 / math.Distance( 200, 200, mx, my )
            local trigX, trigY = cx * distMult / 150, cy * distMult / 150
            local endPointX, endPointY = 200 + cx * distMult, 200 + cy * -distMult
            --print( trigX, trigY )
            if cx == 0 and cy == 0 then
                endPointX, endPointY = 200, 200
            end
            surface.DrawLine( 200, 200, endPointX, endPointY )
            --200, 200 = 0, 0
            --200, 62 =  0, 1
            --200, 337 = 0, -1
            --337, 200 = 1, 0
            --62, 200 = -1, 0
            if math.Distance( fishPosX, fishPosY, endPointX, endPointY ) >= 18 then
                surface.SetDrawColor( color_white )
            else
                surface.SetDrawColor( Color( 0, 128, 255 ) )
                if nextWinState < CurTime() then
                    failState = failState + diffLookups[ difficulty ]
                    nextWinState = CurTime() + 0.1
                end
            end
            
            fishPosX = Lerp( 30 * FrameTime(), fishPosX, 137 * math.cos( randRad ) + 200 )
            fishPosY = Lerp( 30 * FrameTime(), fishPosY, 137 * math.sin( randRad ) + 200 )
            draw.CircleFishing( fishPosX, fishPosY, 12, 20 )

        end
    end )

    local OPEN_CHOMP = Material( "stfishing/teeth_open.png" )
    local CLOSED_CHOMP = Material( "stfishing/teeth_closed.png" )
    local LEFT_CLICK = Material( "gui/lmb.png" )
    local EMPTY_KEY = Material( "gui/key.png" )

    hook.Add( "HUDPaint", "DrawChompers", function()
        if IsValid( LocalPlayer():GetNWEntity( "REELING_IN" ) ) and !LocalPlayer():GetNWBool( "PLAYING_FISHING" ) then
            surface.SetDrawColor( 255, 255, 255, 255 )
            surface.SetMaterial( OPEN_CHOMP )
            surface.DrawTexturedRect( ScrW()/2 - 64, ScrH()/2 - 64, 128, 128 )

            surface.SetMaterial( LEFT_CLICK )
            surface.DrawTexturedRect( ScrW()/2 - 32, ScrH()/2 + 64, 64, 64 )
        end

        if LocalPlayer():GetNWBool( "PLAYING_FISHING" ) then
            surface.SetDrawColor( 255, 255, 255, 255 )
            surface.SetMaterial( CLOSED_CHOMP )
            surface.DrawTexturedRect( ScrW()/2 - 64, ScrH()/2 - 64, 128, 128 )
        end

        if IsValid( LocalPlayer():GetNWEntity( "plyLure" ) ) then
            surface.SetDrawColor( 255, 255, 255, 255 )
            surface.SetMaterial( EMPTY_KEY )
            surface.DrawTexturedRect( 30, ScrH() - 174, 64, 32 )

            surface.SetFont( "Trebuchet18" )
            surface.SetTextColor( 0, 0, 0 )
            surface.SetTextPos( 45, ScrH() - 165 )
            surface.DrawText( "CTRL" )

            surface.SetFont( "rp.ui.18" )
            surface.SetTextColor( 255, 255, 255 )
            surface.SetTextPos( 105, ScrH() - 165 )
            surface.DrawText( "Закончить рыбалку" )
        end 
    end )

    --kind of a hack
    hook.Add( "Think", "PreventLookingWhenLure", function()
        if IsValid( LocalPlayer():GetNWEntity( "plyLure" ) ) or ( LocalPlayer():GetActiveWeapon():GetNWBool( "LineCast", false ) and LocalPlayer():GetActiveWeapon():GetClass() == "st_fishingrod" ) then
            LocalPlayer():SetEyeAngles( LocalPlayer():GetNWAngle( "frozenang" ) )
        end
    end )

    --print messages in chat
    --very basic
    local t = 0

    function PrintLocalFishingMessage( txt, bErr )

        if txt == "award-13.wav" then
            surface.PlaySound( "stfishing/" .. txt )
        return end

        hook.Add( "HUDPaint", "FishingHudMSG", function()
            t = math.Clamp( t + 120/(1/FrameTime()), 0, 255 )
            surface.SetFont( "FishHUD" )
            draw.SimpleTextOutlined( txt, "FishHUD", ScrW()/2 - surface.GetTextSize( txt )/2, ScrH()*0.6, Color( ( bErr and 192 or 0 ), ( bErr and 0 or 192 ), 0, t ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color( ( bErr and 96 or 0 ), ( bErr and 0 or 96 ), 0, t ) )
        end )

        timer.Create( "fishingmsgtimeout", 3, 1, function()
            hook.Remove( "HUDPaint", "FishingHudMSG" )
            hook.Add( "HUDPaint", "FishingHudMSG", function()
                t = math.Clamp( t - 120/(1/FrameTime()), 0, 255 )
                surface.SetFont( "FishHUD" )
                draw.SimpleTextOutlined( txt, "FishHUD", ScrW()/2 - surface.GetTextSize( txt )/2, ScrH()*0.6, Color( ( bErr and 192 or 0 ), ( bErr and 0 or 192 ), 0, t ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color( ( bErr and 96 or 0 ), ( bErr and 0 or 96 ), 0, t ) )
            end )
            timer.Create( "fadeouttimeout", 2.125, 1, function()
                hook.Remove( "HUDPaint", "FishingHudMSG" ) 
            end)
        end )

    end

    net.Receive( "STFishingMessages", function( len, ply )
        local txt = net.ReadString()
        local bErr = net.ReadBool()

        PrintLocalFishingMessage( txt, bErr )
    end )

    --just for CalcView
    net.Receive( "StartUsingLure", function( len, ply )
        local origin = net.ReadVector()

        --draw a light blue circle where we can move our lure
        hook.Add( "PostDrawOpaqueRenderables", "DrawFishingCircleCL", function()
            if IsValid( LocalPlayer():GetNWEntity( "plyLure" ) ) then
                cam.Start3D2D( origin, Angle( 0, 0, 0 ), 1 )
                    surface.SetDrawColor( 0, 128, 255, 32 )
                    draw.NoTexture()
                    draw.CircleFishing( 0, 0, 100, 50 )
                cam.End3D2D()
            end
        end )

        --focus camera on the lure
        --it's really bad to hard-code the camera position
        --fuck it dude
        hook.Add( "CalcView", "ModifyLure", function( ply, pos, ang, fov )
            if IsValid( LocalPlayer():GetNWEntity( "plyLure" ) ) then

                local View = {}
                View.origin = LocalPlayer():GetNWEntity( "plyLure" ):GetPos() + Vector( 48, -96, 48 )
                View.angles = Angle( 20, 120, 0 )
                View.fov = fov
                View.drawviewer = true
                return View
            end
        end )

    end )

    --convenience function
    --credit: http://wiki.garrysmod.com/page/surface/DrawPoly
    function draw.CircleFishing( x, y, radius, seg )
        local cir = {}

        table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
        for i = 0, seg do
            local a = math.rad( ( i / seg ) * -360 )
            table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
        end

        local a = math.rad( 0 ) -- This is needed for non absolute segment counts
        table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

        surface.DrawPoly( cir )
    end

end