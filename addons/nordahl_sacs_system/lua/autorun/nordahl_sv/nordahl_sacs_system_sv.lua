/* 
- Product of originahl-scripts.com -
Script create by Nordahl you can find here : https://originahl-scripts.com/gmod-scripts/2468/sacs-server-map-optimizer
Profile page of the Creator : https://originahl-scripts.com/profiles/76561198033784269

Gmod Script Market Place : https://originahl-scripts.com/gmod-scripts/page-1

- Do not duplicate or reproduce.
- By buying my scripts you contribute to the creations and the updates
- Dont leak, Lack of recognition fuelled by thanks does not bring food to the table
- Respect my work please

Code Minified with Originahl-Scripts Software : https://originahl-scripts.com/en/help/the-minificaytion-optimisation

The satisfied members who offered the coffee and supported me : https://originahl-scripts.com/en/offer-a-coffee-page-1
*/

local SACS_CONFIG=nordahl_cfg_2468
local ztvo=0.02 -- antivorflow delay, additional time per line. Default value is 0.01 (0 = zero second of delay Too much information is sent your crash server if you have a big list)

local function i_Droit(a)
	return a:IsSuperAdmin()
end

if SACS_CONFIG.USeWorkshopContent==1 then
resource.AddWorkshop("493897275")
end

local function sacsauto_removeent()
local compte=0
for i,o in ipairs(Sacslist)do
if o[1]=="class C_RopeKeyframe" then
o[1]="keyframe_rope"
elseif o[1]=="class C_SpotlightEnd" then
o[1]="spotlight_end"
end 
for _,c in ipairs(ents.FindByClass(o[1]))do
if c.premcheck==nil then
c.premcheck=1
else
c:Remove()
compte=compte+1
end
end
end
print("(Count:"..compte..") entities removed by S.A.C.S")
end

local function abcuauto_removeent()
local compte=0
for i,o in ipairs(Abculist)do
if o[1]=="class C_RopeKeyframe" then
o[1]="keyframe_rope"
elseif o[1]=="class C_SpotlightEnd" then
o[1]="spotlight_end"
end
if o[3]=="0" then
for _,c in ipairs(ents.FindByClass(o[1]))do
c:Remove()
compte=compte+1
end
else
for _,c in ipairs(ents.FindByClass(o[1]))do
if c:GetPos():Distance(Vector(o[3].x,o[3].y,o[3].z))<70 then
c:Remove()
compte=compte+1
end
end
end
end
print("(Count:"..compte..") entities removed by A.B.C.S")
end
local function bucsauto_removeent()
local compte=0
for i,o in ipairs(Abculist)do
if o[1]=="class C_RopeKeyframe" then
o[1]="keyframe_rope"
elseif o[1]=="class C_SpotlightEnd" then
o[1]="spotlight_end"
end
if o[3]=="0" then
for _,c in ipairs(ents.FindByClass(o[1]))do
c:Remove()
compte=compte+1
end
else
for _,c in ipairs(ents.FindByClass(o[1]))do
if c:GetPos():Distance(Vector(o[3].x,o[3].y,o[3].z))<70 then
c:Remove()
compte=compte+1
end
end
end
end
print("(Count:"..compte..") "..o[1].." was removed with Boot Optimizer System")

end

function systemsacswhl1(ply,nom,aze)if !i_Droit(ply) then return end
file.Write("zmodserveroption/systemsacs"..game.GetMap()..".txt",tostring(aze[1]))
gmsacsl=tostring(aze[1])
for k,v in pairs ( player.GetAll() ) do
v:ConCommand("ntsacsys "..tostring(aze[1]))
end
if gmsacsl=="1" then
timer.Create("SACS_by_Nordahl",gmsacsclock,0,function()print("Nordahl S.A.C.S: This is the time to clean.")sacsauto_removeent()end)
else
print("S.A.C.S Is Disabled")
timer.Remove("SACS_by_Nordahl")
end


end
concommand.Add("systemsacswhl1",systemsacswhl1)

function sacsentrem(ply,nom,o)if !i_Droit(ply) then return end
local ton=tonumber(o[2])
local plpos=ply:GetPos()
if o[1]=="class C_RopeKeyframe" then
o[1]="keyframe_rope"
elseif o[1]=="class C_SpotlightEnd" then
o[1]="spotlight_end"
end 
for _,c in ipairs(ents.FindByClass(o[1]))do
local pos = c:GetPos()
local longueur = plpos:Distance( pos )
local longueur=longueur/10
local longueur2=255-longueur
local longueur3=math.Round(longueur/5)
if longueur3==ton then
c:Remove()
end
end
end
concommand.Add("sacsentrem",sacsentrem)


function systembtclup(ply,nom,aze)if !i_Droit(ply) then return end
file.Write("zmodserveroption/gmbtclupl.txt",tostring(aze[1]))
gmbtclupl=tostring(aze[1])
for k,v in pairs ( player.GetAll() ) do
v:ConCommand("ntbtclup "..tostring(aze[1]))
end
if gmbtclupl=="1" then
print("A.B.C.S (Automatic Boot Optimizer) Is Enabled")
else
print("A.B.C.S (Automatic Boot Optimizer) Is Disabled")
end
end
concommand.Add("systembtclup",systembtclup)

function sacsclock(ply,nom,aze)if !i_Droit(ply) then return end
file.Write("zmodserveroption/sacsclock.txt",tostring(aze[1]))
gmsacsclock=tonumber(aze[1])
for k,v in pairs ( player.GetAll() ) do
v:ConCommand("ntsacsclock "..tostring(aze[1]))
end
if gmsacsl=="1" then
timer.Create("SACS_by_Nordahl",gmsacsclock,0,function()print("TIMERCREATE CHANGE FOR: "..gmsacsclock)sacsauto_removeent()end)
end
end
concommand.Add("sacsclock",sacsclock)


if dontreadasecondtime==nil then
dontreadasecondtime=1
Sacslist= Sacslist or {}
local str= file.Read( "sacsdata/sacs"..game.GetMap()..".txt", "DATA" )
if str==nil then
file.CreateDir("sacsdata")
file.Write( "sacsdata/sacs"..game.GetMap()..".txt", "[]" )
else
local tbl = util.JSONToTable( str )
for k,v in pairs(tbl)do
table.insert(Sacslist,v)
end
end
Abculist= Abculist or {}
local str= file.Read( "sacsdata/bcu"..game.GetMap()..".txt", "DATA" )
if str==nil then
file.CreateDir("sacsdata")
file.Write( "sacsdata/bcu"..game.GetMap()..".txt", "[]" )
else
local tbl = util.JSONToTable( str )
for k,v in pairs(tbl)do
table.insert(Abculist,v)
end
end

local files=file.Read("zmodserveroption/systemsacs"..game.GetMap()..".txt", "DATA")
if (!files) then
file.CreateDir("zmodserveroption")
file.Write("zmodserveroption/systemsacs"..game.GetMap()..".txt","0")
gmsacsl="0"
else
gmsacsl=file.Read("zmodserveroption/systemsacs"..game.GetMap()..".txt","DATA")
end

local files=file.Read("zmodserveroption/sacsclock.txt", "DATA")
if (!files) then
file.CreateDir("zmodserveroption")
file.Write("zmodserveroption/sacsclock.txt","1200")
gmsacsclock=1200
else
gmsacsclock=tonumber(file.Read("zmodserveroption/sacsclock.txt","DATA"))
end

local files=file.Read("zmodserveroption/gmbtclupl.txt", "DATA")
if (!files) then
file.CreateDir("zmodserveroption")
file.Write("zmodserveroption/gmbtclupl.txt","0")
gmbtclupl="0"
else
gmbtclupl=file.Read("zmodserveroption/gmbtclupl.txt","DATA")
end

if gmsacsl=="1" then
print("S.A.C.S Is Enabled and set on "..(gmsacsclock/60).." Minutes")
timer.Create("SACS_by_Nordahl",gmsacsclock,0,function()print("Nordahl S.A.C.S: This is the time to clean.")sacsauto_removeent()end)
end



local files=file.Read("zmodserverphyscs/zgmphjyscsz1.txt", "DATA")
if (!files) then
file.CreateDir("zmodserverphyscs")
file.Write("zmodserverphyscs/zgmphjyscsz1.txt","1")
zgmphjyscsz1=1
else
zgmphjyscsz1=tonumber(files)
end
local files=file.Read("zmodserverphyscs/zgmphjyscsz2.txt", "DATA")
if (!files) then
file.CreateDir("zmodserverphyscs")
file.Write("zmodserverphyscs/zgmphjyscsz2.txt","1")
zgmphjyscsz2=1
else
zgmphjyscsz2=tonumber(files)
end
local files=file.Read("zmodserverphyscs/zgmphjyscsz3.txt", "DATA")
if (!files) then
file.CreateDir("zmodserverphyscs")
file.Write("zmodserverphyscs/zgmphjyscsz3.txt","7272")
zgmphjyscsz3=7272
else
zgmphjyscsz3=tonumber(files)
end
local files=file.Read("zmodserverphyscs/zgmphjyscsz4.txt", "DATA")
if (!files) then
file.CreateDir("zmodserverphyscs")
file.Write("zmodserverphyscs/zgmphjyscsz4.txt","50000")
zgmphjyscsz4=50000
else
zgmphjyscsz4=tonumber(files)
end
local files=file.Read("zmodserverphyscs/zgmphjyscsz5.txt", "DATA")
if (!files) then
file.CreateDir("zmodserverphyscs")
file.Write("zmodserverphyscs/zgmphjyscsz5.txt","10")
zgmphjyscsz5=10
else
zgmphjyscsz5=tonumber(files)
end
local files=file.Read("zmodserverphyscs/zgmphjyscsz6.txt", "DATA")
if (!files) then
file.CreateDir("zmodserverphyscs")
file.Write("zmodserverphyscs/zgmphjyscsz6.txt","2500")
zgmphjyscsz6=2500
else
zgmphjyscsz6=tonumber(files)
end
local files=file.Read("zmodserverphyscs/zgmphjyscsz7.txt", "DATA")
if (!files) then
file.CreateDir("zmodserverphyscs")
file.Write("zmodserverphyscs/zgmphjyscsz7.txt","4000")
zgmphjyscsz7=4000
else
zgmphjyscsz7=tonumber(files)
end
local files=file.Read("zmodserverphyscs/zgmphjyscsz8.txt", "DATA")
if (!files) then
file.CreateDir("zmodserverphyscs")
file.Write("zmodserverphyscs/zgmphjyscsz8.txt","10")
zgmphjyscsz8=10
else
zgmphjyscsz8=tonumber(files)
end
local files=file.Read("zmodserverphyscs/zgmphjyscsz9.txt", "DATA")
if (!files) then
file.CreateDir("zmodserverphyscs")
file.Write("zmodserverphyscs/zgmphjyscsz9.txt","2")
zgmphjyscsz9=2
else
zgmphjyscsz9=tonumber(files)
end
local files=file.Read("zmodserverphyscs/zgmphjyscsz10.txt", "DATA")
if (!files) then
file.CreateDir("zmodserverphyscs")
file.Write("zmodserverphyscs/zgmphjyscsz10.txt","-600")
zgmphjyscsz10=-600
else
zgmphjyscsz10=tonumber(files)
end
local files=file.Read("zmodserverphyscs/zgmphjyscsz11.txt", "DATA")
if (!files) then
file.CreateDir("zmodserverphyscs")
file.Write("zmodserverphyscs/zgmphjyscsz11.txt","600")
zgmphjyscsz11=600
else
zgmphjyscsz11=tonumber(files)
end


local function InitPostEntity(a,b)
local Nordahl_reglage = {}
Nordahl_reglage.LookAheadTimeObjectsVsObject=zgmphjyscsz1
Nordahl_reglage.LookAheadTimeObjectsVsWorld=zgmphjyscsz2
Nordahl_reglage.MaxAngularVelocity=zgmphjyscsz3
Nordahl_reglage.MaxCollisionChecksPerTimestep=zgmphjyscsz4
Nordahl_reglage.MaxCollisionsPerObjectPerTimestep=zgmphjyscsz5
Nordahl_reglage.MaxFrictionMass=zgmphjyscsz6
Nordahl_reglage.MaxVelocity=zgmphjyscsz7
Nordahl_reglage.MinFrictionMass=zgmphjyscsz8
physenv.SetPerformanceSettings(Nordahl_reglage)
physenv.SetAirDensity(zgmphjyscsz9)
physenv.SetGravity(Vector(0,0,zgmphjyscsz10))
RunConsoleCommand("sv_gravity",zgmphjyscsz11)

if gmbtclupl=="1" then
print("A.B.C.S (Automatic Boot Optimizer) Is Enabled")
abcuauto_removeent()
else
print("A.B.C.S (Automatic Boot Optimizer) Is Disabled")
end
if b=="sacs_init_to_debug" then
PrintTable(Nordahl_reglage)
end
end
hook.Add("InitPostEntity", "SACS_Init_Post_Ent", InitPostEntity)
concommand.Add("sacs_init_to_debug",InitPostEntity)
end


util.AddNetworkString("SynchAllSacsL")
util.AddNetworkString("SynchAllAbcuL")
util.AddNetworkString("SynchSacsSys")
util.AddNetworkString("SynchAbcuSys")
local function WriteToFile()
file.Write( "sacsdata/sacs"..game.GetMap()..".txt",util.TableToJSON(Sacslist))
MsgN( "[SACS Update Plugin] S.A.C.S List.")
end
local function WriteToFile2()
file.Write( "sacsdata/bcu"..game.GetMap()..".txt",util.TableToJSON(Abculist))
MsgN( "[SACS Update Plugin] A.B.C.S List.")
end
local function SynchSacsSys(classname,id,remove)
net.Start("SynchSacsSys")
net.WriteString(classname)
net.WriteString(id)
net.WriteBit(tobool(remove))
net.Broadcast()
end
local function SynchAbcuSys(classname,id,pos,remove)
net.Start("SynchAbcuSys")
net.WriteString(classname)
net.WriteString(id)
if pos=="0" then
net.WriteString("0")
else
net.WriteString(pos.x.." "..pos.y.." "..pos.z)
end
net.WriteBit(tobool(remove))
net.Broadcast()
end
function SACS.AddSacslist(tbl)
table.insert(Sacslist,tbl)
WriteToFile()
SynchSacsSys(tbl[1],tbl[2])
end
function SACS.AddAbculist(tbl)
table.insert(Abculist,tbl)
WriteToFile2()
SynchAbcuSys(tbl[1],tbl[2],tbl[3])
end
function SACS.RemoveSacsL(classname)
for k,v in pairs(Sacslist)do
if v[1]==classname then
table.remove(Sacslist,k)
WriteToFile()
SynchSacsSys(classname,"",true)
return
end
end
end
function SACS.RemoveAbcuL(classname)
for k,v in pairs(Abculist)do
if v[1]==classname then
table.remove(Abculist,k)
WriteToFile2()
SynchAbcuSys(classname,"",v[3],true)
return
end
end
end
local function RemoveSacsL(ply,cmd,args)
if not i_Droit(ply) or not args[1]then return end
SACS.RemoveSacsL(args[1])
end
concommand.Add("zmoda_remove_sacslist",RemoveSacsL)


local function sacslist_reset(ply,cmd,args)
if i_Droit(ply) then
Sacslist={}
file.Write( "sacsdata/sacs"..game.GetMap()..".txt","[]")
for k,v in pairs(player.GetAll())do
ply:ConCommand("sacslist_resetcl")
end
end
end
concommand.Add("sacslist_reset",sacslist_reset)


local function abculist_reset(ply,cmd,args)
if i_Droit(ply) then
Abculist={}
file.Write( "sacsdata/bcu"..game.GetMap()..".txt","[]")
for k,v in pairs(player.GetAll())do
ply:ConCommand("abculist_resetcl")
end
end
end
concommand.Add("abculist_reset",abculist_reset)


local function RemoveAbcuL(ply,cmd,args)
if not i_Droit(ply) or not args[1]then return end
SACS.RemoveAbcuL(args[1])
end
concommand.Add("zmoda_remove_abculist",RemoveAbcuL)
local function AddSacslist(ply,cmd,args)
if not i_Droit(ply) or not args[1]then return end
SACS.AddSacslist{args[1],ply:Name()}
end
concommand.Add("zmoda_add_insacs",AddSacslist)
local function AddAbculist(ply,cmd,args)
if not i_Droit(ply) or not args[1]then return end
SACS.AddAbculist{args[1],ply:Name(),args[2]}
end
concommand.Add("zmoda_add_inabcu",AddAbculist)
function sacs_removeent(a,b,o)
if i_Droit(a) then
if o[1]==nil then return end
local compte=0
if o[1]=="class C_RopeKeyframe" then
o[1]="keyframe_rope"
elseif o[1]=="class C_SpotlightEnd" then
o[1]="spotlight_end"
end 
for _,c in ipairs(ents.FindByClass(o[1]))do
c:Remove()
compte=compte+1
end
--print("(Count:"..compte..") "..c[1].." was removed with S.A.C.S")
end
end
concommand.Add("sacs_removeent",sacs_removeent)
function sacs_tpe(a,b,c)
if i_Droit(a) then
if c[1]==nil then return end
a:SetPos(Vector(tonumber(c[2]),tonumber(c[3]),tonumber(c[4])))
--print("S.A.C System: You was teleported on "..c[1])
end
end
concommand.Add("sacs_tpe",sacs_tpe)
function sacsmanual_removeent(a,b,c)
if i_Droit(a) then
for i,o in ipairs(Sacslist)do
local compte=0
if o[1]=="class C_RopeKeyframe" then
o[1]="keyframe_rope"
end 
for _,c in ipairs(ents.FindByClass(o[1]))do
c:Remove()
compte=compte+1
end
--print("(Count:"..compte..") "..o[1].." was removed with S.A.C.S")
end
end
end
concommand.Add("sacsmanual_removeent",sacsmanual_removeent)
function abcumanual_removeent(a,b,c)
if i_Droit(a) then
for i,o in ipairs(Abculist)do
local compte=0
if o[1]=="class C_RopeKeyframe" then
o[1]="keyframe_rope"
elseif o[1]=="class C_SpotlightEnd" then
o[1]="spotlight_end"
end
if tostring(o[3])=="0" then
for _,c in ipairs(ents.FindByClass(o[1]))do
c:Remove()
compte=compte+1
end
end
--print("(Count:"..compte..") "..o[1].." was removed with A.B.C.S")
end
end
end
concommand.Add("abcumanual_removeent",abcumanual_removeent)



local function nord_connectw(a)
if i_Droit(a) then
local num2=0
local comptesacs=table.Count(Sacslist)
local compteabcs=table.Count(Abculist)
a:ConCommand("nordphy "..zgmphjyscsz1.." "..zgmphjyscsz2.." "..zgmphjyscsz3.." "..zgmphjyscsz4.." "..zgmphjyscsz5.." "..zgmphjyscsz6.." "..zgmphjyscsz7.." "..zgmphjyscsz8.." "..zgmphjyscsz9.." "..zgmphjyscsz10.." "..zgmphjyscsz11)
a:ConCommand("sacslist_update1 "..tostring(comptesacs).." "..tostring(compteabcs).." "..gmsacsl.." "..tostring(gmsacsclock).." "..gmbtclupl )
for k,v in ipairs(Sacslist)do
num2=num2+ztvo
timer.Simple(num2,function()
net.Start("SynchAllSacsL")
net.WriteString(v[1])
net.WriteString(v[2])
net.Send(a)
end)
end
local num2=0
for k,v in ipairs(Abculist)do
num2=num2+ztvo
timer.Simple(num2,function()
net.Start("SynchAllAbcuL")
net.WriteString(v[1])
net.WriteString(v[2])
if v[3]=="0" then
net.WriteString("0")
else
net.WriteString(v[3].x.." "..v[3].y.." "..v[3].z)
end
net.Send(a)
end)
end
end
end

function SACS.AddCommand( func, name )
local newfunc = function( ply, cmd, args ) 
local target = SACS.GetEntN( args[1] )
if name=="zmoda_goto" or name=="zmoda_bring" then 
else
if not target or not i_Droit(ply) or(ply==target and name=="zmoda_superadmin") then return end 
end
func( ply, cmd, args ) 
end
concommand.Add( name, newfunc )
end

function SACS.GetEntN( entname )
if entname==nil then return end
return entname
end

local function AddSacslistPlayer(ply,cmd,args)
local target=SACS.GetEntN(args[1])
if i_Droit(ply) then
MsgAll("[S.A.C.S Admin Plugin] "..target.." was added in S.A.C.S by ",ply)
SACS.AddSacslist{target,ply:Name()}
end
end
SACS.AddCommand(AddSacslistPlayer,"zmoda_addsacsl")
local function AddAbculistPlayer(ply,cmd,args)
local target=SACS.GetEntN(args[1])
if i_Droit(ply) then
MsgAll("[A.B.C.S Admin Plugin] "..target.." was added in A.B.C.S by ",ply)
SACS.AddAbculist{target,ply:Name(),"0"}
end
end
SACS.AddCommand(AddAbculistPlayer,"zmoda_addabcul")
local function zmoda_addabcu2(ply,cmd,args)
local ent=Entity(args[1])print(ent)
local class=ent:GetClass()
local pos=ent:GetPos()
if i_Droit(ply) then
MsgAll("[A.B.C.S Admin Plugin] "..class.." in the position "..pos.x..","..pos.y..","..pos.z.." was added in A.B.C.S by ",ply)
SACS.AddAbculist{class,ply:Name(),pos}
end
end
concommand.Add("zmoda_addabcu2",zmoda_addabcu2)

local function nord_connect_sacs(a)
local a=a
local idx=a:EntIndex()
if serverguard then
timer.Create("Sacs_bynord1_"..idx,5,1,function()nord_connectw(a)end)
else
nord_connectw(a)
end
end
hook.Add("PlayerInitialSpawn", "nord_connect_sacs", nord_connect_sacs)

function sacs_entcount(a,b,c)
MsgAll("They are on the server "..#ents.GetAll().." entities")
end
concommand.Add("sacs_entcount",sacs_entcount)

local function Default_PHYS_Performance(a)
if i_Droit(a) then
print(a,"Restaured the original physics")
local Nordahl_reglage = {}
Nordahl_reglage.LookAheadTimeObjectsVsObject=1
Nordahl_reglage.LookAheadTimeObjectsVsWorld=1
Nordahl_reglage.MaxAngularVelocity=7272
Nordahl_reglage.MaxCollisionChecksPerTimestep=50000
Nordahl_reglage.MaxCollisionsPerObjectPerTimestep=10
Nordahl_reglage.MaxFrictionMass=2500
Nordahl_reglage.MaxVelocity=4000
Nordahl_reglage.MinFrictionMass=10
physenv.SetPerformanceSettings(Nordahl_reglage)
physenv.SetAirDensity(2)
physenv.SetGravity(Vector(0,0,-600))
RunConsoleCommand("sv_gravity",600)
file.Write("zmodserverphyscs/zgmphjyscsz1.txt","1")
file.Write("zmodserverphyscs/zgmphjyscsz2.txt","1")
file.Write("zmodserverphyscs/zgmphjyscsz3.txt","7272")
file.Write("zmodserverphyscs/zgmphjyscsz4.txt","50000")
file.Write("zmodserverphyscs/zgmphjyscsz5.txt","10")
file.Write("zmodserverphyscs/zgmphjyscsz6.txt","2500")
file.Write("zmodserverphyscs/zgmphjyscsz7.txt","4000")
file.Write("zmodserverphyscs/zgmphjyscsz8.txt","10")
file.Write("zmodserverphyscs/zgmphjyscsz9.txt","2")
file.Write("zmodserverphyscs/zgmphjyscsz10.txt","-600")
file.Write("zmodserverphyscs/zgmphjyscsz11.txt","600")
zgmphjyscsz1=1
zgmphjyscsz2=1
zgmphjyscsz3=7272
zgmphjyscsz4=50000
zgmphjyscsz5=10
zgmphjyscsz6=2500
zgmphjyscsz7=4000
zgmphjyscsz8=10
zgmphjyscsz9=2
zgmphjyscsz10=-600
zgmphjyscsz11=600

for k,v in pairs(player.GetAll())do
if i_Droit(v) then
v:ConCommand("nordphy "..zgmphjyscsz1.." "..zgmphjyscsz2.." "..zgmphjyscsz3.." "..zgmphjyscsz4.." "..zgmphjyscsz5.." "..zgmphjyscsz6.." "..zgmphjyscsz7.." "..zgmphjyscsz8.." "..zgmphjyscsz9.." "..zgmphjyscsz10.." "..zgmphjyscsz11)
end
end
end
end
concommand.Add("Default_PHYS_Performance",Default_PHYS_Performance)

local function Sacs_PHYS_Perf1(a,b,c)local cn=tonumber(c[1])
local spp="1"
if i_Droit(a) then
zgmphjyscsz1=cn
local Nordahl_reglage = {}
Nordahl_reglage.LookAheadTimeObjectsVsObject=cn
physenv.SetPerformanceSettings(Nordahl_reglage)
file.Write("zmodserverphyscs/zgmphjyscsz1.txt",tostring(cn))
for k,v in pairs(player.GetAll())do
if i_Droit(v) then
v:ConCommand("nordphy"..spp.." "..cn)
end
end
end
end
concommand.Add("Sacs_PHYS_Perf1",Sacs_PHYS_Perf1)
local function Sacs_PHYS_Perf2(a,b,c)local cn=tonumber(c[1])
local spp="2"
if i_Droit(a) then
zgmphjyscsz2=cn
local Nordahl_reglage = {}
Nordahl_reglage.LookAheadTimeObjectsVsWorld=cn
physenv.SetPerformanceSettings(Nordahl_reglage)
file.Write("zmodserverphyscs/zgmphjyscsz2.txt",tostring(cn))
for k,v in pairs(player.GetAll())do
if i_Droit(v) then
v:ConCommand("nordphy"..spp.." "..cn)
end
end
end
end
concommand.Add("Sacs_PHYS_Perf2",Sacs_PHYS_Perf2)
local function Sacs_PHYS_Perf3(a,b,c)local cn=tonumber(c[1])
local spp="3"
if i_Droit(a) then
zgmphjyscsz3=cn
local Nordahl_reglage = {}
Nordahl_reglage.MaxAngularVelocity=cn
physenv.SetPerformanceSettings(Nordahl_reglage)
file.Write("zmodserverphyscs/zgmphjyscsz3.txt",tostring(cn))
for k,v in pairs(player.GetAll())do
if i_Droit(v) then
v:ConCommand("nordphy"..spp.." "..cn)
end
end
end
end
concommand.Add("Sacs_PHYS_Perf3",Sacs_PHYS_Perf3)
local function Sacs_PHYS_Perf4(a,b,c)local cn=tonumber(c[1])
local spp="4"
if i_Droit(a) then
zgmphjyscsz4=cn
local Nordahl_reglage = {}
Nordahl_reglage.MaxCollisionChecksPerTimestep=cn
physenv.SetPerformanceSettings(Nordahl_reglage)
file.Write("zmodserverphyscs/zgmphjyscsz4.txt",tostring(cn))
for k,v in pairs(player.GetAll())do
if i_Droit(v) then
v:ConCommand("nordphy"..spp.." "..cn)
end
end
end
end
concommand.Add("Sacs_PHYS_Perf4",Sacs_PHYS_Perf4)
local function Sacs_PHYS_Perf5(a,b,c)local cn=tonumber(c[1])
local spp="5"
if i_Droit(a) then
zgmphjyscsz5=cn
local Nordahl_reglage = {}
Nordahl_reglage.MaxCollisionsPerObjectPerTimestep=cn
physenv.SetPerformanceSettings(Nordahl_reglage)
file.Write("zmodserverphyscs/zgmphjyscsz5.txt",tostring(cn))
for k,v in pairs(player.GetAll())do
if i_Droit(v) then
v:ConCommand("nordphy"..spp.." "..cn)
end
end
end
end
concommand.Add("Sacs_PHYS_Perf5",Sacs_PHYS_Perf5)
local function Sacs_PHYS_Perf6(a,b,c)local cn=tonumber(c[1])
local spp="6"
if i_Droit(a) then
zgmphjyscsz6=cn
local Nordahl_reglage = {}
Nordahl_reglage.MaxFrictionMass=cn
physenv.SetPerformanceSettings(Nordahl_reglage)
file.Write("zmodserverphyscs/zgmphjyscsz6.txt",tostring(cn))
for k,v in pairs(player.GetAll())do
if i_Droit(v) then
v:ConCommand("nordphy"..spp.." "..cn)
end
end
end
end
concommand.Add("Sacs_PHYS_Perf6",Sacs_PHYS_Perf6)
local function Sacs_PHYS_Perf7(a,b,c)local cn=tonumber(c[1])
local spp="7"
if i_Droit(a) then
zgmphjyscsz7=cn
local Nordahl_reglage = {}
Nordahl_reglage.MaxVelocity=cn
physenv.SetPerformanceSettings(Nordahl_reglage)
file.Write("zmodserverphyscs/zgmphjyscsz7.txt",tostring(cn))
for k,v in pairs(player.GetAll())do
if i_Droit(v) then
v:ConCommand("nordphy"..spp.." "..cn)
end
end
end
end
concommand.Add("Sacs_PHYS_Perf7",Sacs_PHYS_Perf7)
local function Sacs_PHYS_Perf8(a,b,c)local cn=tonumber(c[1])
local spp="8"
if i_Droit(a) then
zgmphjyscsz8=cn
local Nordahl_reglage = {}
Nordahl_reglage.MinFrictionMass=cn
physenv.SetPerformanceSettings(Nordahl_reglage)
file.Write("zmodserverphyscs/zgmphjyscsz8.txt",tostring(cn))
for k,v in pairs(player.GetAll())do
if i_Droit(v) then
v:ConCommand("nordphy"..spp.." "..cn)
end
end
end
end
concommand.Add("Sacs_PHYS_Perf8",Sacs_PHYS_Perf8)
local function Sacs_PHYS_Perf9(a,b,c)local cn=tonumber(c[1])
local spp="9"
if i_Droit(a) then
zgmphjyscsz9=cn
physenv.SetAirDensity(cn)
file.Write("zmodserverphyscs/zgmphjyscsz9.txt",tostring(cn))
for k,v in pairs(player.GetAll())do
if i_Droit(v) then
v:ConCommand("nordphy"..spp.." "..cn)
end
end
end
end
concommand.Add("Sacs_PHYS_Perf9",Sacs_PHYS_Perf9)
local function Sacs_PHYS_Perf10(a,b,c)local cn=tonumber(c[1])
local spp="10"
if i_Droit(a) then
zgmphjyscsz10=cn
physenv.SetGravity(Vector(0,0,cn))
file.Write("zmodserverphyscs/zgmphjyscsz10.txt",tostring(cn))
for k,v in pairs(player.GetAll())do
if i_Droit(v) then
v:ConCommand("nordphy"..spp.." "..cn)
end
end
end
end
concommand.Add("Sacs_PHYS_Perf10",Sacs_PHYS_Perf10)
local function Sacs_PHYS_Perf11(a,b,c)local cn=tonumber(c[1])
local spp="11"
if i_Droit(a) then
zgmphjyscsz11=cn
RunConsoleCommand("sv_gravity",cn)
file.Write("zmodserverphyscs/zgmphjyscsz11.txt",tostring(cn))
for k,v in pairs(player.GetAll())do
if i_Droit(v) then
v:ConCommand("nordphy"..spp.." "..cn)
end
end
end
end
concommand.Add("Sacs_PHYS_Perf11",Sacs_PHYS_Perf11)

function sacs_redemarrage(a)
if i_Droit(a) then
RunConsoleCommand("changelevel",game.GetMap())
end
end
concommand.Add("sacs_redemarrage",sacs_redemarrage)

print("Nordahl S.A.C.S System: OK")
print("Nordahl A.B.C.S System: OK")
print("Nordahl P.E.M System: OK")





