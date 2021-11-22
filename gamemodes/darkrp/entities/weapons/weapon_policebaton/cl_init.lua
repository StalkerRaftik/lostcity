include("shared.lua")	
/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				DrawCircles
---------------------------------------------------------------------------------------------------------------------------------------------
*/
local selectedItem = 0;
local simpleEnemy = false;
local lastDraw = CurTime()-5;
local attime = 0.5;
function SWEP:DrawCircles(sx,sy,id)
		if not self.drawMenu then return end;
		if lastDraw + attime > CurTime() then return end;
		local circleTable;
		local w = 20;
		local h = w;
		
		if !circleTable then
			circleTable = {};
			for k = 0, 30 do
				local vx, vy = math.cos((math.pi * 2) * k / 30), math.sin((math.pi * 2) * k /30);
				table.insert(circleTable, {x=sx+w*vx, y=sy+h*vy});
			end
		end
	
		local mx, my = gui.MousePos();
		
		local p1 = (sx-mx)*(sx-mx);
		local p2 = (sy-my)*(sy-my);
		local d = math.sqrt(p1 + p2);
		col = Color(15,50,55,180);
		local textColor = Color(255,255,255,255);
		if d<=w then 
			col = Color(50,150,50,200); 
			selectedItem = id;
			textColor = Color(220,225,125,255);
		elseif id == selectedItem then
			selectedItem = 0;
		end
		surface.SetDrawColor(col);
		surface.DrawPoly(circleTable);
		
		surface.SetFont( "font_base_24" );
		
		surface.SetTextColor( 2, 2, 2, 255 );
		
		local text = self.menuButtons[id].buttonText;
		if self.menuButtons[id].left then
			surface.SetTextPos(sx-w - surface.GetTextSize(text)- 10,sy-20);
			surface.DrawText(text);
			surface.SetTextPos(sx-w - surface.GetTextSize(text)- 10,sy-22);
			surface.SetTextColor( textColor );
			surface.DrawText(text);
		else
			surface.SetTextPos(sx+w+10,sy-15);
			surface.DrawText(text);
			surface.SetTextPos(sx+w+10,sy-17);
			surface.SetTextColor( textColor );
			surface.DrawText(text);
		end
		
end

/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				GUIMousePressed
---------------------------------------------------------------------------------------------------------------------------------------------
*/

hook.Add("GUIMousePressed","ChoiseCircle",function(mouseCode,aimVector)
	if mouseCode == MOUSE_LEFT then
		if lastDraw + attime > CurTime() then return end;
		if selectedItem != 0 and simpleEnemy == false then
			surface.PlaySound("buttons/lightswitch2.wav");
		end
		if selectedItem != 0 and simpleEnemy != false then
			lastDraw = CurTime();
			if selectedItem == 1 or selectedItem == 2 then 
				net.Start("batonsendfunc") net.WriteInt(selectedItem,3) net.WriteEntity(simpleEnemy) net.SendToServer();
			else
				local weap = LocalPlayer():GetActiveWeapon();
				if weap:GetClass() != "weapon_policebaton" then return end;
				local warn = "wanted";
				if selectedItem == 4 then
					warn = "warrant";
				end
			end
		end
	end
end)

/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				Find Enemy
---------------------------------------------------------------------------------------------------------------------------------------------
*/

function SWEP:FindEnemy()
	local enemy = false;
	local enemyTable = {};
	local shootPos = LocalPlayer():GetShootPos();
	local aimVec = LocalPlayer():GetAimVector();
	for k,v in pairs(player.GetAll()) do 
		local hisPos = v:GetShootPos();
		if hisPos:DistToSqr(shootPos) < 320000 then
            local pos =  hisPos - shootPos;
            local unitPos = pos:GetNormalized();
            if unitPos:Dot(aimVec) > 0.99 then
                local trace = util.QuickTrace(shootPos, pos, LocalPlayer());
                if trace.Hit and trace.Entity ~= v then break end;
				table.insert(enemyTable,v);
            end
		end	
	end
	
	local dist = 999999;
	
	for k,v in pairs(enemyTable) do
		local curDist = v:GetPos():Distance(LocalPlayer():GetPos());
		if  curDist < dist then
			dist = curDist;
			enemy = v;
		end
	end

	local traceEnt = LocalPlayer():GetEyeTrace().Entity;
	if IsValid(traceEnt) and traceEnt:IsPlayer() then
		enemy = traceEnt;
	end

	return enemy;
end

/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				Draw Hud
---------------------------------------------------------------------------------------------------------------------------------------------
*/
local function isVisible(enemy)
	if enemy == LocalPlayer() then return false end;
	if LocalPlayer():GetShootPos():Distance(enemy:GetPos()) > 1500 then return false end;
	local trdata = {};
	trdata.start = LocalPlayer():GetShootPos();
	trdata.endpos = enemy:GetPos() +Vector(0,0,40);
	trdata.mask = CONTENTS_SOLID;
	trdata.filter = LocalPlayer();
	local res = util.TraceLine(trdata);
	if res.Hit then return false end;
	return true;
end

/* 
---------------------------------------------------------------------------------------------------------------------------------------------
				Draw Hud
---------------------------------------------------------------------------------------------------------------------------------------------
*/
function SWEP:DrawHUD()
	
	if lastDraw + attime > CurTime() then return end; 
	draw.NoTexture()
	local scrW,scrH = ScrW(), ScrH();
	local sx, sy = scrW / 2 - 50, scrH / 2;
	 self:DrawCircles(sx,sy,1);
	 sx, sy = scrW / 2 + 50, scrH / 2;
	 self:DrawCircles(sx,sy,2);

	
	if self.drawMenu then
		simpleEnemy = self:FindEnemy();
		if simpleEnemy != false then
			surface.SetFont( "font_base_24" );
			surface.SetTextColor( 2, 2, 2, 255 );
			target = "Дверь";
			if simpleEnemy:IsPlayer()  then
				target = simpleEnemy:Nick();
			end
			local text = "Цель: "..target;
			surface.SetTextPos(ScrW()/2 - surface.GetTextSize(text)/2,ScrH()/2 - 120);
			surface.DrawText(text);
			surface.SetTextColor( 255, 255, 255, 255 );
			surface.SetTextPos(ScrW()/2 - surface.GetTextSize(text)/2,ScrH()/2 - 122);
			surface.DrawText(text);
		end	
	end
 
	for k,v in pairs(player.GetAll()) do 
		if v:GetNWInt("batonstuntime",0) + self.stunTime > CurTime() then
			if isVisible(v) then 
				local ang = (LocalPlayer():EyePos() - v:EyePos()):Angle();
				ang.p = 0;
				cam.Start3D();
				cam.Start3D2D( v:EyePos() + LocalPlayer():GetRight()*-20 - Vector(0,0,10), ang + Angle(0,90,90), 0.15 );
					draw.ShadowSimpleText("Зажмите R для взаимодействия!", "font_base_18",40,0, Color(255,255,255));
						
				cam.End3D2D();
				cam.End3D();		
			end
		end	 
	end 	
end
