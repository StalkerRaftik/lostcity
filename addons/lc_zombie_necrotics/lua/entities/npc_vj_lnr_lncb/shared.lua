ENT.Base 			= "npc_vj_creature_base" 
ENT.Type 			= "ai"
ENT.PrintName 		= "Combine Walker"
ENT.Author 			= "Darkborn & King of Pootis"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "To create an outbreak!"
ENT.Instructions 	= "You've Been Infected...I'm terribly sorry.."
ENT.Category		= "LNR"

if (CLIENT) then
local Name = "Combine"
local LangName = "npc_vj_lnr_lncb"
language.Add(LangName, Name)
killicon.Add(LangName,"vgui/infect_killicon",Color(255,80,0,255))
language.Add("#"..LangName, Name)
killicon.Add("#"..LangName,"vgui/infect_killicon",Color(255,80,0,255))
end