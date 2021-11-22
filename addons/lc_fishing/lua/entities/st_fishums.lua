
AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Fishums"
ENT.Author = "SweptThrone"
ENT.Spawnable = false
ENT.AdminSpawnable = false 
ENT.Category = "STFishing"
ENT.LureType = "gumball"

if SERVER then

    function ENT:Initialize()
        self:SetModel("models/props/CS_militia/fishriver01.mdl") 
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
        self:SetUseType( SIMPLE_USE )
        local phys = self:GetPhysicsObject()
        if phys and phys:IsValid() then
            phys:Wake()
        end
    end

    function ENT:OnRemove()
        timer.Remove( "TurnHead" .. self:EntIndex() )
        timer.Remove( "MoveForward" .. self:EntIndex() )
    end

    function ENT:Use( act, ply )
    end

    function ENT:Think()
        if !IsValid( self:GetOwner():GetNWEntity( "plyLure" ) ) then self:Remove() return end
        if IsValid( self:GetOwner():GetNWEntity( "REELING_IN" ) ) and self:GetOwner():GetNWEntity( "REELING_IN" ) == self then
            self:SetAbsVelocity( Vector( 0, 0, 0 ) )
        return
        end
        if IsValid( self:GetOwner():GetNWEntity( "REELING_IN" ) ) and self:GetOwner():GetNWEntity( "REELING_IN" ) != self then
            self:SetModelScale( 0, 0.5 )
            timer.Create( "Fishrink" .. self:EntIndex(), 0.5, 1, function()
                if IsValid( self ) then
                    self:Remove()
                end
            end )
        return end
        local randseed = math.random( 1, 10 )
        --a ten percent chance as long as we're not turning our head, moving already, or going after a lure, to turn our head
        if randseed == 10 and !timer.Exists( "TurnHead" .. self:EntIndex() ) and !timer.Exists( "MoveForward" .. self:EntIndex() ) and !self.Pursuing then
            self:TurnHead()
        end
        --if the fish is within 25 units of the lure...
        if math.abs( self:GetPos().x - self:GetOwner():GetNWEntity( "plyLure" ):GetPos().x ) <= 25 and math.abs( self:GetPos().y - self:GetOwner():GetNWEntity( "plyLure" ):GetPos().y ) <= 25 then
            --if we're not pursuing already, make us interested
            if !self.Pursuing then
                self.IsInterested = true
            end
        else
            --if we're far from the lure and pursuing, fly away because we're scared
            if self.Pursuing then
                self.Pursuing = false
                self.PursuePos = nil
                self:SetColor( Color( 192, 0, 0 ) )
                self:SetAngles( Angle( 45, math.random( -180, 180 ), 0 ) )
                self:SetAbsVelocity( Vector( 0, 0, 0 ) )
                self:SetAbsVelocity( self:GetForward() * 50 )
                self:SetModelScale( 0, 1 )
                timer.Create( "Fishrink" .. self:EntIndex(), 1, 1, function()
                    if !IsValid( self ) then return end
                    local fishums = ents.Create( "st_fishums" )
                    --yes, this spawns them in a cuboid when the area should be a cylinder
                    --i dont care
                    fishums:SetPos( self.IntOrigin + Vector( math.random( -100, 100 ), math.random( -100, 100 ), math.random( -10, -50 ) ) )
                    fishums:SetAngles( Angle( 0, math.random( -180, 180 ), 0 ) )
                    fishums:SetOwner( self:GetOwner() )
                    fishums:SetModelScale( 0, 0 )
                    fishums.IntOrigin = self.IntOrigin
                    fishums:Spawn()
                    fishums:SetMoveType( MOVETYPE_NOCLIP )
                    fishums:SetModelScale( 2, 1 )
                    self:Remove()
                end )
            end
            self.IsInterested = false
        end
        --if we're interested and lucky, start pursuing
        if self.IsInterested and math.random( 1, 25 ) == 25 then
            timer.Remove( "TurnHead" .. self:EntIndex() )
            timer.Remove( "MoveForward" .. self:EntIndex() )
            self:SetAbsVelocity( Vector( 0, 0, 0 ) )
            timer.Simple( 0, function()
                self.Pursuing = true
                self.PursuePos = self:GetOwner():GetNWEntity( "plyLure" ):GetPos()
                self.IsInterested = false
                self:PointAtEntity( self:GetOwner():GetNWEntity( "plyLure" ) )
                self:SetAbsVelocity( self:GetForward() * 10 )
            end )
        end
        --if we're pursuing, make us green
        if self.Pursuing then
            timer.Remove( "TurnHead" .. self:EntIndex() )
            timer.Remove( "MoveForward" .. self:EntIndex() )
            self:SetColor( Color( 0, 192, 0 ) )
            self:SetAbsVelocity( Vector( 0, 0, 0 ) )
            self:PointAtEntity( self:GetOwner():GetNWEntity( "plyLure" ) )
            self:SetAbsVelocity( self:GetForward() * 10 )
            --self:SetAbsVelocity( Vector( 0, 0, 0 ) )
            --timer.Simple( 0, function()
            --    self:SetVelocity( Vector( 0, 0, 0 ) )
            --end )
            --[[if self.PursuePos != self:GetOwner():GetNWEntity( "plyLure" ):GetPos() then
                self.Pursuing = false
                self.PursuePos = nil
                self:SetColor( Color( 192, 0, 0 ) )
                self:SetAngles( Angle( math.random( -180, 180 ), -45, 0 ) )
                self:SetVelocity( -self:GetVelocity() )
                self:SetVelocity( self:GetForward() * 50 )
                self:SetModelScale( 0, 1 )
                timer.Create( "Fishrink" .. self:EntIndex(), 1, 1, function()
                    local fishums = ents.Create( "st_fishums" )
                    --yes, this spawns them in a cuboid when the area should be a cylinder
                    --i dont care
                    fishums:SetPos( self.IntOrigin + Vector( math.random( -100, 100 ), math.random( -100, 100 ), math.random( -10, -50 ) ) )
                    fishums:SetAngles( Angle( 0, math.random( -180, 180 ), 0 ) )
                    fishums:SetOwner( self:GetOwner() )
                    fishums:SetModelScale( 0, 0 )
                    fishums.IntOrigin = self.IntOrigin
                    fishums:Spawn()
                    fishums:SetMoveType( MOVETYPE_NOCLIP )
                    fishums:SetModelScale( 2, 1 )
                    self:Remove()
                end )  
            end]]
        end
        if self:GetPos():DistToSqr( self:GetOwner():GetNWEntity( "plyLure" ):GetPos() ) <= 25 and !IsValid( self:GetOwner().REELING_IN ) then
            self:GetOwner():SetNWEntity( "REELING_IN", self )

            self:SetAbsVelocity( Vector( 0, 0, 0 ) )

            --self:GetOwner():ChatPrint( "REEL IT IN!" .. self:EntIndex() )
            net.Start( "STFishingMessages" )
                net.WriteString( "award-13.wav" )
                net.WriteBool( false )
            net.Send( self:GetOwner() )

            self:GetOwner().IsPlayerFishing = true
            --self:EmitSound( "award-13.wav" )
            timer.Create( "REELITIN" .. self:GetOwner():EntIndex(), 0.75, 1, function()
                if !IsValid( self ) then return end
                self:GetOwner().IsPlayerFishing = false
                self:GetOwner():SetNWEntity( "REELING_IN", nil )
                self:GetOwner():GetNWEntity( "plyLure" ):Remove()
                self:GetOwner().SpecLure = false
                self:GetOwner():SetMoveType( MOVETYPE_WALK )
                self:GetOwner():GetActiveWeapon().Cast = false
                self:GetOwner():GetActiveWeapon():SetNWBool( "LineCast", false )
                if DarkRP then
                    self:GetOwner():GetActiveWeapon().LureType = ""
                end
                --self:GetOwner():ChatPrint( "YOU FUCKING IDIOT MISSED YOUR CHANCE" )
                net.Start( "STFishingMessages" )
                    net.WriteString( "You were too slow, the fish broke away!" )
                    net.WriteBool( true )
                net.Send( self:GetOwner() )
            end )
        end
    end

    function ENT:MoveForward( dist )
        self:EmitSound( "player/footsteps/wade" .. math.random(1,8) .. ".wav" )
        self:SetVelocity( self:GetForward() * 50 )
        timer.Create( "MoveForward" .. self:EntIndex(), 0.1, dist, function()
            if IsValid( self ) then
                self:SetVelocity( Vector( -self:GetVelocity() * 0.15 ) )
                if self:GetPos():DistToSqr( self.IntOrigin ) >= 14400 then
                    self:SetModelScale( 0, 1 )
                    timer.Create( "Fishrink" .. self:EntIndex(), 1, 1, function()
                        if !IsValid( self ) then return end
                        local fishums = ents.Create( "st_fishums" )
                        --yes, this spawns them in a cuboid when the area should be a cylinder
                        --i dont care
                        fishums:SetPos( self.IntOrigin + Vector( math.random( -100, 100 ), math.random( -100, 100 ), math.random( -10, -50 ) ) )
                        fishums:SetAngles( Angle( 0, math.random( -180, 180 ), 0 ) )
                        fishums:SetOwner( self:GetOwner() )
                        fishums:SetModelScale( 0, 0 )
                        fishums.IntOrigin = self.IntOrigin
                        fishums:Spawn()
                        fishums:SetMoveType( MOVETYPE_NOCLIP )
                        fishums:SetModelScale( 2, 1 )
                        self:Remove()
                    end )
                end
            end
        end )
    end

    function ENT:TurnHead()
        local degrees = math.random( -35, 35 )
        if degrees < 0 then
            timer.Create( "TurnHead" .. self:EntIndex(), 0.1, -degrees, function()
                if IsValid( self ) then
                    self:SetAngles( self:GetAngles() - Angle( 0, 5, 0 ) )
                    if timer.RepsLeft( "TurnHead" .. self:EntIndex() ) == 1 then
                        self:MoveForward( math.random( 40, 60 ) )
                    end
                end
            end )
        elseif degrees > 0 then
            timer.Create( "TurnHead" .. self:EntIndex(), 0.1, degrees, function()
                if IsValid( self ) then
                    self:SetAngles( self:GetAngles() + Angle( 0, 1, 0 ) )
                    if timer.RepsLeft( "TurnHead" .. self:EntIndex() ) == 1 then
                        self:MoveForward( math.random( 40, 60 ) )
                    end
                end
            end )
        end
    end

    function ENT:GravGunPickupAllowed()
        return false
    end

end

if CLIENT then
    
    function ENT:Initialize()
    end

    function ENT:Draw()
        self:DrawModel()
    end

    function ENT:Think()
    end 

end