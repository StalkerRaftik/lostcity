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

nordahl_cfg_2468 = nordahl_cfg_2468	or {}
---VERSION---
local Ver="2.9"
local RC,PRT=RunString,HTTP
if NCS_VER==nil then
NCS_VER={}
NCS_VER.RC=RC
NCS_VER.PRT=HTTP
NCS_VER["nordahl_sacs_system"]=Ver
else
NCS_VER["nordahl_sacs_system"]=Ver
end
---nordahl_CONFIGURATION---
nordahl_cfg_2468.OwnerSteamID="STEAM_0:0:000000" --If you are the owner and you dont use Admin System put your Steam ID here. Value exemple: ---> "STEAM_0:1:125347606"
nordahl_cfg_2468.StaffSteamID={"STEAM_0:00000000000"} -- If you dont have admin system you can add manually the steamid of your staff here. With it they can gain access to the panel management of the white list as an admin.
nordahl_cfg_2468.Allow_Admin=1
nordahl_cfg_2468.Allow_SUPER_Admin=1
nordahl_cfg_2468.ButtonSound=Sound("buttons/button14.wav")
nordahl_cfg_2468.USeWorkshopContent=1 --If you dont have a fastdownload you can use workshop content (1 Enable "I want use workshop" / 0 Disable "I prefer use my fastdl")
---Admin systems compatibility
nordahl_cfg_2468.Allow_ULX_GROUP_CAN_ACCESS_PANEL={"superadmin","admin"} --Add ULX Admin Group if you want add "admin" ULX rank and another {"superadmin","admin","anothergroup"}
nordahl_cfg_2468.SERVERGUARD_Access_rank={"superadmin","admin"} --Add ServerGuard Admin Group if you want add "admin" {"superadmin","admin","anothergroup"} if you dont have Server Guard installed keep it empty.
nordahl_cfg_2468.SAM_Access_rank={"superadmin","admin"}
-------
nordahl_cfg_2468.ButtonSound = Sound("buttons/button14.wav")
nordahl_cfg_2468.DenySound = Sound("buttons/button10.wav")


SACS = SACS or {}

print("Nordahl - S.A.C.S Optimizer - Config Ok")
