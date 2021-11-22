local function DeadlyZombiesSettings(CPanel)
	local on = CPanel:AddControl( "CheckBox", { Label = "Enabled", Command = "zombification_on" } )
	local nhi = CPanel:AddControl( "CheckBox", { Label = "Infection by standing near someone infected", Command = "zombification_nhi" } )
	local ep1 = CPanel:AddControl( "CheckBox", { Label = "Enable zombine (EP1 required!)", Command = "zombification_ep1" } )
	local chance = CPanel:NumSlider( "Zombification Chance", "", 0, 100, 0 )
	local nhi_chance = CPanel:NumSlider( "Air Zombification Chance", "", 0, 100, 0 )

	ep1.OnChange = function( panel, bVal ) 
		if( LocalPlayer():IsSuperAdmin()) then
			if( ( bVal and 1 or 0 ) == cvars.Number( "zombification_ep1" ) ) then return end

			net.Start( "DeadlyZombies_cvar" );
				net.WriteString( "zombification_ep1" );
				net.WriteFloat( bVal and 1 or 0 );
			net.SendToServer();
		end
	end

	nhi.OnChange = function( panel, bVal ) 
		if( LocalPlayer():IsSuperAdmin()) then
			if( ( bVal and 1 or 0 ) == cvars.Number( "zombification_nhi" ) ) then return end

			net.Start( "DeadlyZombies_cvar" );
				net.WriteString( "zombification_nhi" );
				net.WriteFloat( bVal and 1 or 0 );
			net.SendToServer();
		end
	end

	on.OnChange = function( panel, bVal ) 
		if( LocalPlayer():IsSuperAdmin()) then
			if( ( bVal and 1 or 0 ) == cvars.Number( "zombification_on" ) ) then return end

			net.Start( "DeadlyZombies_cvar" );
				net.WriteString( "zombification_on" );
				net.WriteFloat( bVal and 1 or 0 );
			net.SendToServer();
		end
	end

	chance.OnValueChanged = function( panel, val )
		if( LocalPlayer():IsSuperAdmin() ) then
			net.Start( "DeadlyZombies_cvar" );
				net.WriteString( "zombification_chance" );
				net.WriteFloat( math.Round( tonumber( val ) ) );
			net.SendToServer();
		end
	end

	nhi_chance.OnValueChanged = function( panel, val )
		if( LocalPlayer():IsSuperAdmin() ) then
			net.Start( "DeadlyZombies_cvar" );
				net.WriteString( "zombification_nhi_chance" );
				net.WriteFloat( math.Round( tonumber( val ) ) );
			net.SendToServer();
		end
	end

	timer.Simple( 0.1, function() 
		chance:SetValue(80)
		nhi_chance:SetValue(10)
	end)
end

hook.Add( "PopulateToolMenu", "PopulateDeadlyZombiesCategory", function()
	spawnmenu.AddToolMenuOption( "Utilities", "DeadlyZombies", "DeadlyZombiesSettings", "Settings", "", "", DeadlyZombiesSettings );
end)

hook.Add( "AddToolMenuCategories", "CreateDeadlyZombiesCategories", function()
	spawnmenu.AddToolCategory( "Utilities", "DeadlyZombies", "Deadly Zombies" );
end)