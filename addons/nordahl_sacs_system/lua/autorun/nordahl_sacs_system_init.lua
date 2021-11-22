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

if SERVER then
AddCSLuaFile("nordahl_cl/nordahl_sacs_system_cl.lua")
include("nordahl_sv/nordahl_sacs_system_sv.lua")
end

if CLIENT then
include("nordahl_cl/nordahl_sacs_system_cl.lua")
end

print("Nordahl - S.A.C.S Optimizer - Init Ok")