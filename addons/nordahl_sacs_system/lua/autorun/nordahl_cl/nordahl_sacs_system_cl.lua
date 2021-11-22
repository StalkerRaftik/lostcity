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
local puce="*"

local function i_Droit(a)
return a:IsSuperAdmin()
end

local files=file.Read("nordahlclient_option/language.txt","DATA")
if (!files) then
file.CreateDir("nordahlclient_option")
file.Write("nordahlclient_option/language.txt","2")
Z_Defaut_Languages=2
else
Z_Defaut_Languages=tonumber(file.Read("nordahlclient_option/language.txt","DATA"))
end
sacszwusers1=nil
if sacszwusers1==nil then
sacszwusers1=0
sacszwusers2=0
end

local Nord_language={}
local sacsver=NCS_VER["nordahl_sacs_system"]
function languesacsfr(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
Nord_language.la_ttles="Toutes les"
Nord_language.la_tousles="Tous les"
Nord_language.la_secondes="secondes"
Nord_language.la_minutes="minutes"
Nord_language.la_heure="heure"
Nord_language.la_heures="heures"
Nord_language.la_jours="jours"
Nord_language.la_porletest="pour les testes"
Nord_language.la_nom="Nom"
Nord_language.la_sacs_ongl1="Sur le serveur"
Nord_language.la_sacs_ongl1aid="Liste des entitées présent sur votre serveur."
Nord_language.la_sacs_ongl2="Rechercher"
Nord_language.la_sacs_ongl2aid="Système complet de recherche pour la SACS Liste, l'ABCS Liste, et les entitées sur le serveur"
Nord_language.la_sacs_ongl3="Liste du S.A.C.S"
Nord_language.la_sacs_ongl3aid="Le S.A.C.S permet de supprimer automatiquement les objets présents sur le serveur depuis un certain temps"
Nord_language.la_sacs_ongl4="Liste de l'A.B.C.S"
Nord_language.la_sacs_ongl4aid="Le Boot Optimizer permet de supprimer toutes les entités non souhaitées de votre serveur lorsqu'il demarre"
Nord_language.la_sacs_ongl5="Options"
Nord_language.la_sacs_ongl5aid="Options du SACS"
Nord_language.la_sacs_ongl6="Outils"
Nord_language.la_sacs_ongl6aid="Accédez aux outils du SACS"
Nord_language.la_sacs_ongl11="Les entitées sur le serveur"
Nord_language.la_sacs_ongl12="Position des entitées"
Nord_language.la_sacs_ongl13="Distance en mètres"
Nord_language.la_sacs_ongl00="Nom de l'entité"
Nord_language.la_sacs_onglb1="Chercher les entités"
Nord_language.la_sacs_onglb2="Chercher dans l'A.B.C.S"
Nord_language.la_sacs_onglb3="Chercher dans le S.A.C.S"
Nord_language.la_sacs_ongl2341="Nom des entités"
Nord_language.la_sacs_ongl22="Ajoutée par ou Distance de l'entité"
Nord_language.la_sacs_ajpar="Ajoutée par"
Nord_language.la_sacs_onglb31="Ajouter à la liste"
Nord_language.la_sacs_onglb41="Ajouter à la liste"
Nord_language.la_sacs_ajentsyst="Ajouter cette classe d'entité dans le système"
Nord_language.la_sacs_supprimer="Supprimer"
Nord_language.la_sacs_supprimer1="Supprimer seulement celui là"
Nord_language.la_sacs_supprimer2="Tous les surpprimer du serveur"
Nord_language.la_sacs_tpmoi="Me teleporter sur cette entitée"
Nord_language.la_sacs_copieentcl="Copier la classe (Ctrl+V pour coller)"
Nord_language.la_sacs_reglcolor="Colorer cette classe (pour outil: AdminEyes)"
Nord_language.la_sacs_blanc="Blanc"
Nord_language.la_sacs_noir="Noir"
Nord_language.la_sacs_bleu="Bleu"
Nord_language.la_sacs_orange="Orange"
Nord_language.la_sacs_rose="Rose"
Nord_language.la_sacs_violet="Violet"
Nord_language.la_sacs_rouge="Rouge"
Nord_language.la_sacs_jaune="Jaune"
Nord_language.la_sacs_vert="Vert"
Nord_language.la_sacs_invisible="Invisible"
Nord_language.la_sacs_options1="(Activer/Désactiver) Le S.A.C.S (Smart Automatic Cleaner System):"
Nord_language.la_sacs_options2="Regler le temps du cycle du S.A.C.S, le cycle est actuelement réglé sur:"
Nord_language.la_sacs_options3="(Activer/Désactiver) L'A.B.C.S. Automatic Boot Optimizer:"
Nord_language.la_sacs_options4="Nettoyer manuellement tous les groupes d'entités présent dans la liste du S.A.C.S: "
Nord_language.la_sacs_options5="Nettoyer manuellement tous les groupes d'entités présent dans la liste de l'A.B.C.S: "
Nord_language.la_sacs_options6="Note: Tous les entitées dans la liste SACS seront nettoyer automatiquement,"
Nord_language.la_sacs_options7="Le système continuera à fonctionner automatiquement après reboot s'il est activé."
Nord_language.la_sacs_options8="Si l'objet vient d'être spawné il sera supprimé lors de la prochaine boucle."
Nord_language.la_sacs_options9="A.B.C.S permet de supprimer automatiquement ce que vous ne voulez pas sur la map au reboot."
Nord_language.la_sacs_options10="Activez l'Admin-Eye pour avoir un oeil sur tout le serveur et pour travailler."
Nord_language.la_sacs_options11="Supprimer ce que les outils commun ne peuvent pas faire avec ce système."
Nord_language.la_sacs_manuelcleana="Nettoyer manuellement"
Nord_language.la_sacs_manuelcleanb="Nettoyer manuellement"
Nord_language.la_sacs_outil1="(Activer/Désactiver) L'Admin-Eyes, pour voir toute les entitées présente sur la map:"
Nord_language.la_sacs_outil2="Voir les joueurs"
Nord_language.la_sacs_outil3="Voir les Npcs"
Nord_language.la_sacs_entre="Vous n'étiez pas admin en rejoingnant le serveur, reconnecté vous pour obtenir les informations vous permettant d'acceder au système S.A.C.S."
Nord_language.la_scrp_nordahl_credit="Fait par Nordahl"
Nord_language.la_scrp_nordahl_note="Review this script"
Nord_language.la_scrp_nordahl_script="Script"
Nord_language.la_dnphys1="Montant Maximal de secondes de précalculer les collisions avec des objets."
Nord_language.la_dnphys2="Montant Maximal de secondes de précalculer les collisions avec le monde."
Nord_language.la_dnphys3="Vitesse Maximum de rotation."
Nord_language.la_dnphys4="Check Maximum des collisions par tick."
Nord_language.la_dnphys5="Nombre Maximum de collision par objet par tick."
Nord_language.la_dnphys6="Masse Maximale d'un objet à être touchés par le frottement."
Nord_language.la_dnphys7="Vitesse Maximale d'un objet."
Nord_language.la_dnphys8="Masse Minimale d'un objet à être touchés par le frottement."
Nord_language.la_dnphys9="Définit la densité de l'air."
Nord_language.la_dnphys10="Définit la gravité, (Pour tous les Objets)."
Nord_language.la_dnphys11="Définit la gravité (Pour les joueurs)."
end
function languesacsen(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
Nord_language.la_ttles="Every"
Nord_language.la_tousles="Every"
Nord_language.la_secondes="seconds"
Nord_language.la_minutes="minutes"
Nord_language.la_heure="hour"
Nord_language.la_heures="hours"
Nord_language.la_jours="days"
Nord_language.la_porletest="for the tests"
Nord_language.la_nomm="Name"
Nord_language.la_sacs_ongl1="On the server"
Nord_language.la_sacs_ongl1aid="Entities on your server."
Nord_language.la_sacs_ongl2="Search"
Nord_language.la_sacs_ongl2aid="Complete search system for the SACS, ABCS List and server entities"
Nord_language.la_sacs_ongl3="S.A.C.S's List"
Nord_language.la_sacs_ongl3aid="The S.A.C.S allows you to delete automatically the objects that are on your server for some time"
Nord_language.la_sacs_ongl4="Boot Optimizer"
Nord_language.la_sacs_ongl4aid="The Boot Optimizer allows you to delete all the entities that you don't want when the server starts."
Nord_language.la_sacs_ongl5="Options"
Nord_language.la_sacs_ongl5aid="SACS's Options"
Nord_language.la_sacs_ongl6="Tools"
Nord_language.la_sacs_ongl6aid="Access to the SACS's tools"
Nord_language.la_sacs_ongl11="Entities on the server"
Nord_language.la_sacs_ongl12="Entities position"
Nord_language.la_sacs_ongl13="Distance in meters"
Nord_language.la_sacs_ongl00="Entity's name"
Nord_language.la_sacs_onglb1="Search the entities "
Nord_language.la_sacs_onglb2="Search in the A.B.C.S"
Nord_language.la_sacs_onglb3="Search in the S.A.C.S"
Nord_language.la_sacs_ongl2341="Entities name"
Nord_language.la_sacs_ongl22="Added by or Entity's distance"
Nord_language.la_sacs_ajpar="Added by"
Nord_language.la_sacs_onglb31="Add in list"
Nord_language.la_sacs_onglb41="Add in list"
Nord_language.la_sacs_ajentsyst="Add this entity's class in the system"
Nord_language.la_sacs_supprimer="Delete"
Nord_language.la_sacs_supprimer1="Delete this one"
Nord_language.la_sacs_supprimer2="Delete all of them"
Nord_language.la_sacs_tpmoi="Take me to this entity"
Nord_language.la_sacs_copieentcl="Copy the class (Ctrl+V to paste)"
Nord_language.la_sacs_reglcolor="Color this class (For the AdminEyes tool)"
Nord_language.la_sacs_blanc="White"
Nord_language.la_sacs_noir="Black"
Nord_language.la_sacs_bleu="Blue"
Nord_language.la_sacs_orange="Orange"
Nord_language.la_sacs_rose="Pink"
Nord_language.la_sacs_violet="Purple"
Nord_language.la_sacs_rouge="Red"
Nord_language.la_sacs_jaune="Yellow"
Nord_language.la_sacs_vert="Green"
Nord_language.la_sacs_invisible="Invisible"
Nord_language.la_sacs_options1="(Activate/Deactivate) the S.A.C.S (Smart Automatic Cleaner System):"
Nord_language.la_sacs_options2="Set the time cycle of the S.A.C.S, Currently, the cycle is set on :"
Nord_language.la_sacs_options3="(Activate/Deactivate) The A.B.C.S. (Automatic Boot Optimizer):"
Nord_language.la_sacs_options4="Manually clean all the entities groups on the S.A.C.S's list :"
Nord_language.la_sacs_options5="Manually clean all the entities groups on the Boot Optimizer :"
Nord_language.la_sacs_options6="Note: All the entities in the S.A.C.S's list will be automatically cleaned."
Nord_language.la_sacs_options7="The system will continue to work automatically when rebooting if it's activated."
Nord_language.la_sacs_options8="If the object just spawned, it will we deleted in the next loop."
Nord_language.la_sacs_options9="The A.B.C.S allows you to delete automatically what you don't want on the map on the reboot."
Nord_language.la_sacs_options10="Activate the Admin-Eyes to have an eye on the server and when you work."
Nord_language.la_sacs_options11="Delete what the common tools cannot do without this system."
Nord_language.la_sacs_manuelcleana="Cleanup since the entities List"
Nord_language.la_sacs_manuelcleanb="Cleanup since the entities List"
Nord_language.la_sacs_outil1="(Activate/Deactivate) The Admin-Eyes, to see all the entities on the map :"
Nord_language.la_sacs_outil2="See the Players"
Nord_language.la_sacs_outil3="See the Npcs"
Nord_language.la_sacs_entre="Vous n'étiez pas admin en rejoingnant le serveur, reconnecté vous pour obtenir les informations vous permettant d'acceder au système S.A.C.S."
Nord_language.la_scrp_nordahl_credit = "Made by Nordahl"
Nord_language.la_scrp_nordahl_note="Review this script"
Nord_language.la_scrp_nordahl_script="Script"
Nord_language.la_dnphys1="Maximum amount of seconds to precalculate collisions with objects."
Nord_language.la_dnphys2="Maximum amount of seconds to precalculate collisions with world."
Nord_language.la_dnphys3="Maximum rotation velocity."
Nord_language.la_dnphys4="Maximum collision checks per tick."
Nord_language.la_dnphys5="Maximum collision per object per tick."
Nord_language.la_dnphys6="Maximum mass of an object to be affected by friction."
Nord_language.la_dnphys7="Maximum speed of an object."
Nord_language.la_dnphys8="Minimum mass of an object to be affected by friction."
Nord_language.la_dnphys9="Sets the air density."
Nord_language.la_dnphys10="Sets the gravity, (For the items)."
Nord_language.la_dnphys11="Sets the gravity, (For the players)."
end
function languesacsdu(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
Nord_language.la_ttles = "Jeder"
Nord_language.la_tousles = "Jeder"
Nord_language.la_secondes = "Sekunden"
Nord_language.la_minutes = "Minuten"
Nord_language.la_heure = "Stunde"
Nord_language.la_heures = "h"
Nord_language.la_jours = "Tage"
Nord_language.la_porletest = "für die Tests"
Nord_language.la_nomm = "Name"
Nord_language.la_sacs_ongl1 = "Auf dem Server"
Nord_language.la_sacs_ongl1aid = "Entitäten auf Ihrem Server."
Nord_language.la_sacs_ongl2 = "Suchen"
Nord_language.la_sacs_ongl2aid = "Complete Suchsystem für die SACS, ABCS Liste und Server-Einheiten"
Nord_language.la_sacs_ongl3 = "S.A.C.S Liste"
Nord_language.la_sacs_ongl3aid = "Die S.A.C.S ermöglicht es Ihnen, automatisch die Objekte, die seit einiger Zeit auf dem Server zu löschen"
Nord_language.la_sacs_ongl4 = "A.B.C.S Liste"
Nord_language.la_sacs_ongl4aid = "Der Stiefelreiniger ermöglicht es Ihnen, alle Objekte zu löschen, die Sie nicht wollen, wenn der Server gestartet wird."
Nord_language.la_sacs_ongl5 = "Optionen"
Nord_language.la_sacs_ongl5aid = "SACS die Optionen"
Nord_language.la_sacs_ongl6 = "Tools"
Nord_language.la_sacs_ongl6aid = "Zugriff auf die SACS des Tools"
Nord_language.la_sacs_ongl11 = "Entitäten auf dem Server"
Nord_language.la_sacs_ongl12 = "Entities Position"
Nord_language.la_sacs_ongl13 = "Entfernung in Metern"
Nord_language.la_sacs_ongl00 = "Entity Name"
Nord_language.la_sacs_onglb1 = "Entitäten Suchen"
Nord_language.la_sacs_onglb2 = "in der A.B.C.S Suchen"
Nord_language.la_sacs_onglb3 = "Suche in der S.A.C.S"
Nord_language.la_sacs_ongl2341 = "Entities Name"
Nord_language.la_sacs_ongl22 = "durch oder Entity-Distanz Hinzugefügt"
Nord_language.la_sacs_ajpar = "hinzugefügt"
Nord_language.la_sacs_onglb31 = "in der Liste hinzufügen"
Nord_language.la_sacs_onglb41 = "in der Liste hinzufügen"
Nord_language.la_sacs_ajentsyst = "Add Klasse dieser Einheit im System"
Nord_language.la_sacs_supprimer = "Löschen"
Nord_language.la_sacs_supprimer1 = "Löschen this one"
Nord_language.la_sacs_supprimer2 = "alle löschen"
Nord_language.la_sacs_tpmoi = "Nimm mich auf diese Stelle"
Nord_language.la_sacs_copieentcl = "Kopieren Sie die Klasse (Strg + V zum Einfügen)"
Nord_language.la_sacs_reglcolor = "Farbe diese Klasse (Für den AdminEyes-Tool)"
Nord_language.la_sacs_blanc = "White"
Nord_language.la_sacs_noir = "Black"
Nord_language.la_sacs_bleu = "Blue"
Nord_language.la_sacs_orange = "Orange"
Nord_language.la_sacs_rose = "Pink"
Nord_language.la_sacs_violet = "Purple"
Nord_language.la_sacs_rouge = "Red"
Nord_language.la_sacs_jaune = "Gelb"
Nord_language.la_sacs_vert = "Green"
Nord_language.la_sacs_invisible = "Invisible"
Nord_language.la_sacs_options1 = "(Aktivieren / Deaktivieren) der S.A.C.S (Smart Automatic Reiniger System):"
Nord_language.la_sacs_options2 = "Stellen Sie den Zeitzyklus des S.A.C.S, Derzeit wird der Zyklus eingestellt auf:"
Nord_language.la_sacs_options3 = "(Aktivieren / Deaktivieren) Der A.B.C.S. (Automatic Stiefelreiniger):"
Nord_language.la_sacs_options4 = "Hand reinigen alle Entitäten Gruppen auf der S.A.C.S Liste:"
Nord_language.la_sacs_options5 = "Hand reinigen alle Entitäten Gruppen auf der A.B.C.S Liste:"
Nord_language.la_sacs_options6 = "Hinweis: Alle Einheiten in der Liste der S.A.C.S werden automatisch gereinigt."
Nord_language.la_sacs_options7 = "Das System wird auch weiterhin automatisch zu arbeiten, wenn Neustart, wenn es aktiviert ist."
Nord_language.la_sacs_options8 = "Wenn das Objekt nur hervorgebracht, es werden wir in der nächsten Schleife gelöscht."
Nord_language.la_sacs_options9 = "Die A.B.C.S ermöglicht es Ihnen, automatisch zu löschen, was Sie nicht wollen, auf dem Neu-Start auf der Karte."
Nord_language.la_sacs_options10 = "Aktivieren Sie die Admin-Eyes ein Auge auf den Server haben, und wenn Sie arbeiten."
Nord_language.la_sacs_options11 = "Löschen, was die gemeinsame Instrumente nicht ohne dieses System tun kann."
Nord_language.la_sacs_manuelcleana = "Aufräumen, da die Einheiten List"
Nord_language.la_sacs_manuelcleanb = "Aufräumen, da die Einheiten List"
Nord_language.la_sacs_outil1 = "(Aktivieren / Deaktivieren) Die Admin-Eyes, alle Objekte auf der Karte zu sehen:"
Nord_language.la_sacs_outil2 = "Sehen Sie sich die Spieler" 
Nord_language.la_sacs_outil3 = "Sehen Sie sich die NPCs" 
Nord_language.la_sacs_entre = "Vous n'étiez pas admin de rejoingnant le serveur, reconnecté vous gießen Obtenir les informations vous permettant d'acceder au système S.A.C.S."
Nord_language.la_scrp_nordahl_credit = "Made by Nordahl"
Nord_language.la_scrp_nordahl_note = "Überprüfen Sie das Skript"
Nord_language.la_scrp_nordahl_script = "Script"
Nord_language.la_dnphys1 = "Maximale Anzahl an Sekunden Kollisionen mit Objekten vorauszuberechnen."
Nord_language.la_dnphys2 = "Maximale Anzahl an Sekunden Kollisionen mit Welt vorauszuberechnen."
Nord_language.la_dnphys3 = "Maximale Rotationsgeschwindigkeit."
Nord_language.la_dnphys4 = "Maximale Kollisionsprüfungen pro Tick."
Nord_language.la_dnphys5 = "Maximale Kollision pro Objekt pro Tick."
Nord_language.la_dnphys6 = "Maximale Masse eines Objekts durch Reibung beeinflusst werden."
Nord_language.la_dnphys7 = "Maximale Geschwindigkeit eines Objekts."
Nord_language.la_dnphys8 = "Mindestmasse eines Objekts durch Reibung beeinflusst werden."
Nord_language.la_dnphys9 = "Stellt die Luftdichte."
Nord_language.la_dnphys10 = "Stellt die Schwerkraft (Für die Einzelteile)."
Nord_language.la_dnphys11 = "Stellt die Schwerkraft (Für die Spieler)."
end
function languesacsru(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
Nord_language.la_ttles = "Каждый"
Nord_language.la_tousles = "Каждый"
Nord_language.la_secondes = "секунд"
Nord_language.la_minutes = "минут"
Nord_language.la_heure = "час"
Nord_language.la_heures = "часы"
Nord_language.la_jours = "дней"
Nord_language.la_porletest = "для испытаний"
Nord_language.la_nomm = "Имя"
Nord_language.la_sacs_ongl1 = "На сервере"
Nord_language.la_sacs_ongl1aid = "Объекты на сервере."
Nord_language.la_sacs_ongl2 = "Поиск"
Nord_language.la_sacs_ongl2aid = "Полная система поиска для мешочков Список азбуке и серверных сущностей"
Nord_language.la_sacs_ongl3 = "Список S.A.C.S в"
Nord_language.la_sacs_ongl3aid = "The S.A.C.S позволяет удалить автоматически объекты, которые находятся на сервере в течение некоторого времени"
Nord_language.la_sacs_ongl4 = "Список A.B.C.S в"
Nord_language.la_sacs_ongl4aid = "The Boot Optimizer позволяет удалить все объекты, которые вы не хотите при запуске сервера."
Nord_language.la_sacs_ongl5 = "Опции"
Nord_language.la_sacs_ongl5aid = "Опции мешочков в"
Nord_language.la_sacs_ongl6 = "Инструменты"
Nord_language.la_sacs_ongl6aid = "Доступ к инструментам мешочках в"
Nord_language.la_sacs_ongl11 = "Объекты на сервере"
Nord_language.la_sacs_ongl12 = "положение Сущности"
Nord_language.la_sacs_ongl13 = "Расстояние в метрах"
Nord_language.la_sacs_ongl00 = "Имя участия лица"
Nord_language.la_sacs_onglb1 = "Поиск сущностей"
Nord_language.la_sacs_onglb2 = "Поиск в A.B.C.S"
Nord_language.la_sacs_onglb3 = "Поиск в S.A.C.S"
Nord_language.la_sacs_ongl2341 = "имя Сущности"
Nord_language.la_sacs_ongl22 = "Добавил или расстояния субъекта"
Nord_language.la_sacs_ajpar = "Добавлен"
Nord_language.la_sacs_onglb31 = "Добавить в список"
Nord_language.la_sacs_onglb41 = "Добавить в список"
Nord_language.la_sacs_ajentsyst = "Добавить класс данного лица в системе"
Nord_language.la_sacs_supprimer = "Удалить"
Nord_language.la_sacs_supprimer1 = "Удалить этот"
Nord_language.la_sacs_supprimer2 = "Удалить все из них"
Nord_language.la_sacs_tpmoi = "Возьми меня к этому лицу"
Nord_language.la_sacs_copieentcl = "Скопировать класс (Ctrl + V, чтобы вставить)"
Nord_language.la_sacs_reglcolor = "Цвет этот класс (для инструмента AdminEyes)"
Nord_language.la_sacs_blanc = "Белый"
Nord_language.la_sacs_noir = "Black"
Nord_language.la_sacs_bleu = "Blue"
Nord_language.la_sacs_orange = "Апельсин"
Nord_language.la_sacs_rose = "Розовый"
Nord_language.la_sacs_violet = "Purple"
Nord_language.la_sacs_rouge = "Red"
Nord_language.la_sacs_jaune = "Желтый"
Nord_language.la_sacs_vert = "Green"
Nord_language.la_sacs_invisible = "Невидимый"
Nord_language.la_sacs_options1 = "(Активировать / отключить) (интеллектуальная система автоматического очистки) S.A.C.S:"
Nord_language.la_sacs_options2 = "Установить время цикла S.A.C.S, В настоящее время цикла устанавливается на:"
Nord_language.la_sacs_options3 = "(Активировать / отключить) A.B.C.S. (Automatic Boot Optimizer):"
Nord_language.la_sacs_options4 = "Вручную очистить все объекты группы в списке S.A.C.S в:"
Nord_language.la_sacs_options5 = "Вручную очистить все объекты группы в списке A.B.C.S в:"
Nord_language.la_sacs_options6 = "Примечание: Все объекты в списке S.A.C.S будет автоматически очищается."
Nord_language.la_sacs_options7 = "Система будет работать автоматически при перезагрузке, если он активирован."
Nord_language.la_sacs_options8 = "Если объект просто породил, он будет удален, мы в следующем цикле."
Nord_language.la_sacs_options9 = "The A.B.C.S позволяет автоматически удалять то, что вы не хотите на карте при перезагрузке."
Nord_language.la_sacs_options10 = "Активировать админ-глаза, чтобы иметь глаза на сервере и при работе."
Nord_language.la_sacs_options11 = "Удалить то, что общие средства не могут обойтись без этой системы."
Nord_language.la_sacs_manuelcleana = "Очистка после Список лиц"
Nord_language.la_sacs_manuelcleanb = "Очистка после Список лиц"
Nord_language.la_sacs_outil1 = "(включение / выключение) админ-Eyes, чтобы увидеть все объекты на карте:"
Nord_language.la_sacs_outil2 = "Смотрите Игроки"
Nord_language.la_sacs_outil3 = "Смотрите НПЦ"
Nord_language.la_sacs_entre = "Vous n'étiez па админ ан rejoingnant ле Serveur, reconnecté уоиз влить obtenir ле информация уоиз permettant d'acceder Au système S.A.C.S."
Nord_language.la_scrp_nordahl_credit = "Сделано Nordahl"
Nord_language.la_scrp_nordahl_note = "Обзор этого сценария"
Nord_language.la_scrp_nordahl_script = "Скрипт"
Nord_language.la_dnphys1 = "Максимальное количество секунд предвычислять столкновений с объектами."
Nord_language.la_dnphys2 = "Максимальное количество секунд предвычислять столкновений с миром."
Nord_language.la_dnphys3 = "Максимальная скорость вращения."
Nord_language.la_dnphys4 = "Максимальное число проверок столкновений за один тик."
Nord_language.la_dnphys5 = "Максимальное столкновение каждого объекта за тик."
Nord_language.la_dnphys6 = "Максимальная масса объекта, чтобы зависеть от трения."
Nord_language.la_dnphys7 = "Максимальная скорость объекта."
Nord_language.la_dnphys8 = "Минимальная масса объекта, чтобы зависеть от трения."
Nord_language.la_dnphys9 = "Устанавливает плотность воздуха."
Nord_language.la_dnphys10 = "Устанавливает гравитацию, (для элементов)."
Nord_language.la_dnphys11 = "Устанавливает гравитацию, (для игроков)."
end
function languesacses(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
Nord_language.la_ttles = "Cada"
Nord_language.la_tousles = "Cada"
Nord_language.la_secondes = "segundos"
Nord_language.la_minutes = "minutos"
Nord_language.la_heure = "hora"
Nord_language.la_heures = "horas"
Nord_language.la_jours = "días"
Nord_language.la_porletest = "para las pruebas"
Nord_language.la_nomm = "Nombre"
Nord_language.la_sacs_ongl1 = "En el servidor"
Nord_language.la_sacs_ongl1aid = "Entidades en su servidor."
Nord_language.la_sacs_ongl2 = "Buscar"
Nord_language.la_sacs_ongl2aid = "sistema de búsqueda completa para los SACS, Lista ABCS y entidades de servidor"
Nord_language.la_sacs_ongl3 = "La lista de S.A.C.S"
Nord_language.la_sacs_ongl3aid = "La S.A.C.S le permite eliminar automáticamente los objetos que se encuentran en su servidor durante algún tiempo"
Nord_language.la_sacs_ongl4 = "La lista de A.B.C.S"
Nord_language.la_sacs_ongl4aid = "El limpiador de arranque le permite borrar todas las entidades que no se quiere cuando se inicia el servidor."
Nord_language.la_sacs_ongl5 = "Opciones"
Nord_language.la_sacs_ongl5aid = "Opciones de SACS"
Nord_language.la_sacs_ongl6 = "Herramientas"
Nord_language.la_sacs_ongl6aid = "Acceso a las herramientas de la SACS"
Nord_language.la_sacs_ongl11 = "Entidades en el servidor"
Nord_language.la_sacs_ongl12 = "posición Entidades"
Nord_language.la_sacs_ongl13 = "Distancia en metros"
Nord_language.la_sacs_ongl00 = "El nombre de la entidad"
Nord_language.la_sacs_onglb1 = "Buscar las entidades"
Nord_language.la_sacs_onglb2 = "Buscar en la A.B.C.S"
Nord_language.la_sacs_onglb3 = "Buscar en el S.A.C.S"
Nord_language.la_sacs_ongl2341 = "nombre de Entidades"
Nord_language.la_sacs_ongl22 = "Agregado por o distancia de la Entidad"
Nord_language.la_sacs_ajpar = "Agregado por"
Nord_language.la_sacs_onglb31 = "Añadir en la lista"
Nord_language.la_sacs_onglb41 = "Añadir en la lista"
Nord_language.la_sacs_ajentsyst = "Añadir la clase de esta entidad en el sistema"
Nord_language.la_sacs_supprimer = "Borrar"
Nord_language.la_sacs_supprimer1 = "Eliminar esta uno"
Nord_language.la_sacs_supprimer2 = "Eliminar todos ellos"
Nord_language.la_sacs_tpmoi = "Ir a esta entidad"
Nord_language.la_sacs_copieentcl = "Copia de la clase (Ctrl + V para pegar)"
Nord_language.la_sacs_reglcolor = "color de esta clase (Para la herramienta AdminEyes)"
Nord_language.la_sacs_blanc = "White"
Nord_language.la_sacs_noir = "Negro"
Nord_language.la_sacs_bleu = "Blue"
Nord_language.la_sacs_orange = "Orange"
Nord_language.la_sacs_rose = "color de rosa"
Nord_language.la_sacs_violet = "púrpura"
Nord_language.la_sacs_rouge = "Rojo"
Nord_language.la_sacs_jaune = "Yellow"
Nord_language.la_sacs_vert = "verde"
Nord_language.la_sacs_invisible = "invisible"
Nord_language.la_sacs_options1 = "(Activar / Desactivar) (Sistema automático Smart Cleaner) S.A.C.S:"
Nord_language.la_sacs_options2 = "Establecer el ciclo de tiempo de la S.A.C.S, En la actualidad, el ciclo se establece en:"
Nord_language.la_sacs_options3 = "(Activar / Desactivar) El (limpiador automático de arranque) A.B.C.S.:"
Nord_language.la_sacs_options4 = "limpiar manualmente todos los grupos de entidades que figuran en la lista del S.A.C.S:"
Nord_language.la_sacs_options5 = "limpiar manualmente todos los grupos de entidades que figuran en la lista del A.B.C.S:"
Nord_language.la_sacs_options6 = "Nota: Todas las entidades en la lista del S.A.C.S se limpia automáticamente."
Nord_language.la_sacs_options7 = "El sistema seguirá funcionando de forma automática cuando se reinicia si está activado."
Nord_language.la_sacs_options8 = "Si el objeto simplemente dio lugar, lo hará hemos borrado en el siguiente bucle."
Nord_language.la_sacs_options9 = "La A.B.C.S le permite eliminar automáticamente lo que no quiere en el mapa en el reinicio."
Nord_language.la_sacs_options10 = "Activar el admin-Ojos que tener un ojo en el servidor y cuando se trabaja."
Nord_language.la_sacs_options11 = "Eliminar lo que las herramientas comunes no pueden prescindir de este sistema."
Nord_language.la_sacs_manuelcleana = "Liberar espacio ya que la lista de entidades"
Nord_language.la_sacs_manuelcleanb = "Liberar espacio ya que la lista de entidades"
Nord_language.la_sacs_outil1 = "(Activar / Desactivar) el admin-ojos, para ver todas las entidades en el mapa:"
Nord_language.la_sacs_outil2 = "ver a los jugadores"
Nord_language.la_sacs_outil3 = "Ver el NPCs"
Nord_language.la_sacs_entre = "Vous n'étiez pas admin es rejoingnant le serveur, reconnecté vous verter obtenir informaciones vous les permettant d'Acceder au système S.A.C.S."
Nord_language.la_scrp_nordahl_credit = "Made by Nordahl"
Nord_language.la_scrp_nordahl_note = "revisión de esta secuencia de comandos"
Nord_language.la_scrp_nordahl_script = "escritura"
Nord_language.la_dnphys1 = "Cantidad máxima de segundos precalcular colisiones con objetos."
Nord_language.la_dnphys2 = "Cantidad máxima de segundos precalcular colisiones con el mundo."
Nord_language.la_dnphys3 = "Máxima velocidad de rotación."
Nord_language.la_dnphys4 = "controles de colisión máximas por garrapatas."
Nord_language.la_dnphys5 = "colisión máxima por vivienda garrapata."
Nord_language.la_dnphys6 = "Masa máxima de un objeto que se ve afectado por la fricción."
Nord_language.la_dnphys7 = "Velocidad máxima de un objeto."
Nord_language.la_dnphys8 = "La masa mínima de un objeto que se ve afectado por la fricción."
Nord_language.la_dnphys9 = "Establece la densidad del aire."
Nord_language.la_dnphys10 = "Establece la gravedad, (para los artículos)."
Nord_language.la_dnphys11 = "Establece la gravedad, (para los jugadores)."
end

function languesacsel(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
Nord_language.la_ttles = "Κάθε"
Nord_language.la_tousles = "Κάθε"
Nord_language.la_secondes = "δευτερόλεπτα"
Nord_language.la_minutes = "λεπτά"
Nord_language.la_heure = "ώρα"
Nord_language.la_heures = "ώρες"
Nord_language.la_jours = "ημέρες"
Nord_language.la_porletest = "για τις δοκιμές"
Nord_language.la_nomm = "Όνομα"
Nord_language.la_sacs_ongl1 = "Στο διακομιστή"
Nord_language.la_sacs_ongl1aid = "Φορείς στο διακομιστή σας."
Nord_language.la_sacs_ongl2 = "Αναζήτηση"
Nord_language.la_sacs_ongl2aid = "Ολοκληρωμένο σύστημα αναζήτησης για τις ΕΖΔ, αλφάβητο Λίστα και οντοτήτων διακομιστή"
Nord_language.la_sacs_ongl3 = "Λίστα S.A.C.S του"
Nord_language.la_sacs_ongl3aid = "Η S.A.C.S σας επιτρέπει να διαγράψετε αυτόματα τα αντικείμενα που βρίσκονται στον server σας για κάποιο χρονικό διάστημα"
Nord_language.la_sacs_ongl4 = "Λίστα A.B.C.S του"
Nord_language.la_sacs_ongl4aid = "Το Cleaner εκκίνησης σας επιτρέπει να διαγράψετε όλες τις οντότητες που δεν θέλετε κατά την εκκίνηση του διακομιστή."
Nord_language.la_sacs_ongl5 = "Επιλογές"
Nord_language.la_sacs_ongl5aid = "Επιλογές SACS του"
Nord_language.la_sacs_ongl6 = "Εργαλεία"
Nord_language.la_sacs_ongl6aid = "Η πρόσβαση στα εργαλεία ΕΖΔ του"
Nord_language.la_sacs_ongl11 = "Φορείς στο διακομιστή"
Nord_language.la_sacs_ongl12 = "θέση Προσώπων"
Nord_language.la_sacs_ongl13 = "Αποστάσεις σε μέτρα"
Nord_language.la_sacs_ongl00 = "όνομα Οντότητας"
Nord_language.la_sacs_onglb1 = "Αναζήτηση οντότητες"
Nord_language.la_sacs_onglb2 = "Αναζήτηση στο A.B.C.S"
Nord_language.la_sacs_onglb3 = "Αναζήτηση στο S.A.C.S"
Nord_language.la_sacs_ongl2341 = "Φορείς όνομα"
Nord_language.la_sacs_ongl22 = "Προστέθηκε από τον ή την απόσταση Οντότητας"
Nord_language.la_sacs_ajpar = "Προστέθηκε από"
Nord_language.la_sacs_onglb31 = "Προσθήκη στη λίστα"
Nord_language.la_sacs_onglb41 = "Προσθήκη στη λίστα"
Nord_language.la_sacs_ajentsyst = "Προσθήκη της κατηγορίας αυτής οντότητας στο σύστημα"
Nord_language.la_sacs_supprimer = "Διαγραφή"
Nord_language.la_sacs_supprimer1 = "Διαγραφή αυτό το ένα"
Nord_language.la_sacs_supprimer2 = "Διαγραφή όλα αυτά"
Nord_language.la_sacs_tpmoi = "Πάρτε μου σε αυτή την οντότητα"
Nord_language.la_sacs_copieentcl = "Αντιγραφή της κατηγορίας (Ctrl + V για να επικολλήσετε)"
Nord_language.la_sacs_reglcolor = "Χρώμα αυτή την κατηγορία (Για το εργαλείο AdminEyes)"
Nord_language.la_sacs_blanc = "Λευκό"
Nord_language.la_sacs_noir = "Black"
Nord_language.la_sacs_bleu = "Blue"
Nord_language.la_sacs_orange = "Πορτοκαλί"
Nord_language.la_sacs_rose = "Ροζ"
Nord_language.la_sacs_violet = "Purple"
Nord_language.la_sacs_rouge = "Red"
Nord_language.la_sacs_jaune = "Yellow"
Nord_language.la_sacs_vert = "Πράσινη"
Nord_language.la_sacs_invisible = "Invisible"
Nord_language.la_sacs_options1 = "(Ενεργοποίηση / Απενεργοποίηση) (σύστημα Smart Αυτόματη Cleaner) S.A.C.S:"
Nord_language.la_sacs_options2 = "Ορίστε το χρόνο του κύκλου της S.A.C.S, Επί του παρόντος, ο κύκλος έχει οριστεί για:"
Nord_language.la_sacs_options3 = "(Ενεργοποίηση / Απενεργοποίηση) Η (Cleaner Automatic Boot) A.B.C.S.:"
Nord_language.la_sacs_options4 = "Μη αυτόματος καθαρισμός όλες οι οντότητες ομάδες στον κατάλογο της S.A.C.S του:"
Nord_language.la_sacs_options5 = "Μη αυτόματος καθαρισμός όλες οι οντότητες ομάδες στον κατάλογο της A.B.C.S του:"
Nord_language.la_sacs_options6 = "Σημείωση: Όλες οι οντότητες στον κατάλογο του S.A.C.S θα πρέπει να καθαρίζονται αυτόματα."
Nord_language.la_sacs_options7 = "Το σύστημα θα συνεχίσει να λειτουργεί αυτόματα όταν επανεκκίνηση αν είναι ενεργοποιημένο."
Nord_language.la_sacs_options8 = "Αν το αντικείμενο μόλις γεννήσει, θα έχουμε διαγραφεί στην επόμενη βρόχο."
Nord_language.la_sacs_options9 = "Η A.B.C.S σας επιτρέπει να διαγράψετε αυτόματα ό, τι δεν θέλετε από τον χάρτη για την επανεκκίνηση."
Nord_language.la_sacs_options10 = "Ενεργοποίηση του διαχειριστή-Μάτια για να έχουν ένα μάτι στο διακομιστή και όταν εργάζεστε."
Nord_language.la_sacs_options11 = "Διαγράψτε ό, τι τα κοινά εργαλεία δεν μπορεί να κάνει χωρίς αυτό το σύστημα."
Nord_language.la_sacs_manuelcleana = "Εκκαθάριση από τη Λίστα οντότητες"
Nord_language.la_sacs_manuelcleanb = "Εκκαθάριση από τη Λίστα οντότητες"
Nord_language.la_sacs_outil1 = "(Ενεργοποίηση / Απενεργοποίηση) Οι Διαχειριστή μάτια, για να δείτε όλες τις οντότητες του χάρτη:"
Nord_language.la_sacs_outil2 = "Δείτε τους παίκτες"
Nord_language.la_sacs_outil3 = "Δείτε το NPCs"
Nord_language.la_sacs_entre = "Vous n'étiez pas διαχειριστή en rejoingnant le serveur, reconnecté vous ρίχνουμε obtenir les πληροφορίες vous permettant d'Acceder au système S.A.C.S."
Nord_language.la_scrp_nordahl_credit = "Made by Nordahl"
Nord_language.la_scrp_nordahl_note = "Ελέγξτε αυτό το σενάριο"
Nord_language.la_scrp_nordahl_script = "Σενάριο"
Nord_language.la_dnphys1 = "Μέγιστο ποσό δευτερόλεπτα για να precalculate συγκρούσεις με αντικείμενα."
Nord_language.la_dnphys2 = "Μέγιστο ποσό δευτερόλεπτα για να precalculate συγκρούσεις με τον κόσμο."
Nord_language.la_dnphys3 = "Μέγιστη ταχύτητα περιστροφής."
Nord_language.la_dnphys4 = "Μέγιστη ελέγχους σύγκρουσης ανά τσιμπούρι."
Nord_language.la_dnphys5 = "Μέγιστη σύγκρουσης ανά αντικείμενο ανά τσιμπούρι."
Nord_language.la_dnphys6 = "Μέγιστη μάζα ενός αντικειμένου που πρόκειται να επηρεαστούν από την τριβή."
Nord_language.la_dnphys7 = "Μέγιστη ταχύτητα ενός αντικειμένου."
Nord_language.la_dnphys8 = "Ελάχιστη μάζα ενός αντικειμένου να επηρεάζεται από την τριβή."
Nord_language.la_dnphys9 = "Καθορίζει την πυκνότητα του αέρα."
Nord_language.la_dnphys10 = "Καθορίζει τη σοβαρότητα, (για τα στοιχεία)."
Nord_language.la_dnphys11 = "Καθορίζει τη σοβαρότητα, (για τους παίκτες)."
end
function languesacspt(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
Nord_language.la_ttles = "Cada"
Nord_language.la_tousles = "Cada"
Nord_language.la_secondes = "segundos"
Nord_language.la_minutes = "minutos"
Nord_language.la_heure = "hora"
Nord_language.la_heures = "horas"
Nord_language.la_jours = "dias"
Nord_language.la_porletest = "para os testes"
Nord_language.la_nomm = "Name"
Nord_language.la_sacs_ongl1 = "No servidor"
Nord_language.la_sacs_ongl1aid = "Entidades em seu servidor."
Nord_language.la_sacs_ongl2 = "Pesquisar"
Nord_language.la_sacs_ongl2aid = "sistema de busca completa para os SACS, Lista ABCS e entidades de servidor"
Nord_language.la_sacs_ongl3 = "Lista de S.A.C.S"
Nord_language.la_sacs_ongl3aid = "O S.A.C.S permite apagar automaticamente os objetos que estão no seu servidor por algum tempo"
Nord_language.la_sacs_ongl4 = "Lista de A.B.C.S"
Nord_language.la_sacs_ongl4aid = "The Cleaner de inicialização permite que você apague todas as entidades que você não quer quando o servidor inicia."
Nord_language.la_sacs_ongl5 = "Opções"
Nord_language.la_sacs_ongl5aid = "Opções do SACS"
Nord_language.la_sacs_ongl6 = "Ferramentas"
Nord_language.la_sacs_ongl6aid = "Acesso a ferramentas do SACS"
Nord_language.la_sacs_ongl11 = "Entidades no servidor"
Nord_language.la_sacs_ongl12 = "position Entidades"
Nord_language.la_sacs_ongl13 = "Distância em metros"
Nord_language.la_sacs_ongl00 = "nome da Entidade"
Nord_language.la_sacs_onglb1 = "Procurar as entidades"
Nord_language.la_sacs_onglb2 = "Pesquisar na A.B.C.S"
Nord_language.la_sacs_onglb3 = "Pesquisa na S.A.C.S"
Nord_language.la_sacs_ongl2341 = "Entidades nome"
Nord_language.la_sacs_ongl22 = "Adicionado por ou distância da Entidade"
Nord_language.la_sacs_ajpar = "Adicionado por"
Nord_language.la_sacs_onglb31 = "Adicionar na lista"
Nord_language.la_sacs_onglb41 = "Adicionar na lista"
Nord_language.la_sacs_ajentsyst = "Adicionar classe dessa entidade no sistema"
Nord_language.la_sacs_supprimer = "Excluir"
Nord_language.la_sacs_supprimer1 = "Delete this one"
Nord_language.la_sacs_supprimer2 = "Excluir todas"
Nord_language.la_sacs_tpmoi = "Leve-me para esta entidade"
Nord_language.la_sacs_copieentcl = "Copie a classe (Ctrl + V para colar)"
Nord_language.la_sacs_reglcolor = "color esta classe (Para a ferramenta AdminEyes)"
Nord_language.la_sacs_blanc = "White"
Nord_language.la_sacs_noir = "Black"
Nord_language.la_sacs_bleu = "Blue"
Nord_language.la_sacs_orange = "Orange"
Nord_language.la_sacs_rose = "Pink"
Nord_language.la_sacs_violet = "Purple"
Nord_language.la_sacs_rouge = "Red"
Nord_language.la_sacs_jaune = "Yellow"
Nord_language.la_sacs_vert = "Green"
Nord_language.la_sacs_invisible = "invisível"
Nord_language.la_sacs_options1 = "(Activar / Desactivar) o (System Cleaner Inteligente Automático) S.A.C.S:"
Nord_language.la_sacs_options2 = "Defina o tempo de ciclo do S.A.C.S, atualmente, o ciclo é definido em:"
Nord_language.la_sacs_options3 = "(Activar / Desactivar) O (Cleaner automático de inicialização) A.B.C.S.:"
Nord_language.la_sacs_options4 = "limpar manualmente todos os grupos de entidades na lista do S.A.C.S:"
Nord_language.la_sacs_options5 = "limpar manualmente todos os grupos de entidades na lista do A.B.C.S:"
Nord_language.la_sacs_options6 = "Nota: Todas as entidades na lista do S.A.C.S serão limpos automaticamente."
Nord_language.la_sacs_options7 = "O sistema irá continuar a funcionar automaticamente quando a reinicialização, se ele é ativado."
Nord_language.la_sacs_options8 = "Se o objeto apenas desovado, será que foi excluído no próximo ciclo."
Nord_language.la_sacs_options9 = "O A.B.C.S permite excluir automaticamente o que você não quer no mapa na reinicialização."
Nord_language.la_sacs_options10 = "Activar o administrador-Eyes ter um olho no servidor e quando você trabalha."
Nord_language.la_sacs_options11 = "Apagar o que as ferramentas comuns não pode fazer sem este sistema."
Nord_language.la_sacs_manuelcleana = "Limpeza de uma vez que a lista de entidades"
Nord_language.la_sacs_manuelcleanb = "Limpeza de uma vez que a lista de entidades"
Nord_language.la_sacs_outil1 = "(Activar / Desactivar) o administrador-olhos, para ver todas as entidades no mapa:"
Nord_language.la_sacs_outil2 = "ver os jogadores"
Nord_language.la_sacs_outil3 = "Ver os NPCs"
Nord_language.la_sacs_entre = "Vous n'étiez pas admin pt rejoingnant le serveur, reconnecté vous despeje obtenir les informações vous permettant d'acceder au système S.A.C.S."
Nord_language.la_scrp_nordahl_credit = "Made by Nordahl"
Nord_language.la_scrp_nordahl_note = "Comente este script"
Nord_language.la_scrp_nordahl_script = "Script"
Nord_language.la_dnphys1 = "Quantidade máxima de segundos para pré-calcular colisões com objetos."
Nord_language.la_dnphys2 = "Quantidade máxima de segundos para pré-calcular colisões com o mundo."
Nord_language.la_dnphys3 = "velocidade de rotação máxima."
Nord_language.la_dnphys4 = "verificações de colisão máximas por tick."
Nord_language.la_dnphys5 = "colisão máxima por objeto por carrapato."
Nord_language.la_dnphys6 = "massa máxima de um objeto a ser afetados por atrito."
Nord_language.la_dnphys7 = "Velocidade máxima de um objeto."
Nord_language.la_dnphys8 = "A massa mínima de um objeto a ser afetados por atrito."
Nord_language.la_dnphys9 = "Define a densidade do ar."
Nord_language.la_dnphys10 = "Define a gravidade, (Para os itens)."
Nord_language.la_dnphys11 = "Define a gravidade, (para os jogadores)."
end
function languesacspl(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
Nord_language.la_ttles = "Każdy"
Nord_language.la_tousles = "Każdy"
Nord_language.la_secondes = "sekunda"
Nord_language.la_minutes = "minuty"
Nord_language.la_heure = "godziny"
Nord_language.la_heures = "godziny"
Nord_language.la_jours = "dzień"
Nord_language.la_porletest = "do testów"
Nord_language.la_nomm = "Nazwa"
Nord_language.la_sacs_ongl1 = "Na serwerze"
Nord_language.la_sacs_ongl1aid = "Podmioty na serwerze."
Nord_language.la_sacs_ongl2 = "Szukaj"
Nord_language.la_sacs_ongl2aid = "Kompletny system wyszukiwania dla SOO ABC Listy i podmiotów server"
Nord_language.la_sacs_ongl3 = "Lista S.A.C.S za"
Nord_language.la_sacs_ongl3aid = "The S.A.C.S pozwala automatycznie usuwać obiekty, które znajdują się na serwerze przez jakiś czas"
Nord_language.la_sacs_ongl4 = "Lista A.B.C.S za"
Nord_language.la_sacs_ongl4aid = "The Cleaner Boot pozwala usunąć wszystkie podmioty, które nie mają być po uruchomieniu serwera."
Nord_language.la_sacs_ongl5 = "Opcje"
Nord_language.la_sacs_ongl5aid = "Opcje SOO za"
Nord_language.la_sacs_ongl6 = "Narzędzia"
Nord_language.la_sacs_ongl6aid = "Dostęp do narzędzi SOO za"
Nord_language.la_sacs_ongl11 = "Podmioty na serwerze"
Nord_language.la_sacs_ongl12 = "position Podmioty"
Nord_language.la_sacs_ongl13 = "Odległość w metrach"
Nord_language.la_sacs_ongl00 = "Nazwa jednostki za"
Nord_language.la_sacs_onglb1 = "Szukaj podmioty"
Nord_language.la_sacs_onglb2 = "Szukaj w A.B.C.S"
Nord_language.la_sacs_onglb3 = "Szukaj w S.A.C.S"
Nord_language.la_sacs_ongl2341 = "Nazwa jednostki"
Nord_language.la_sacs_ongl22 = "Dodane przez odległości lub Podmiotu"
Nord_language.la_sacs_ajpar = "Dodane przez"
Nord_language.la_sacs_onglb31 = "Dodaj do listy"
Nord_language.la_sacs_onglb41 = "Dodaj do listy"
Nord_language.la_sacs_ajentsyst = "Dodaj klasę tego podmiotu w systemie"
Nord_language.la_sacs_supprimer = "Usuń"
Nord_language.la_sacs_supprimer1 = "Usuń ten jeden"
Nord_language.la_sacs_supprimer2 = "Usuń wszystkie z nich"
Nord_language.la_sacs_tpmoi = "Zabierz mnie do tego podmiotu"
Nord_language.la_sacs_copieentcl = "Kopiuj klasę (Ctrl + V, aby wkleić)"
Nord_language.la_sacs_reglcolor = "color ta klasa (dla narzędzia AdminEyes)"
Nord_language.la_sacs_blanc = "White"
Nord_language.la_sacs_noir = "Black"
Nord_language.la_sacs_bleu = "Blue"
Nord_language.la_sacs_orange = "Orange"
Nord_language.la_sacs_rose = "Pink"
Nord_language.la_sacs_violet = "fioletowy"
Nord_language.la_sacs_rouge = "Red"
Nord_language.la_sacs_jaune = "Yellow"
Nord_language.la_sacs_vert = "Green"
Nord_language.la_sacs_invisible = "Niewidzialny"
Nord_language.la_sacs_options1 = "(Włącz / Wyłącz) przycisk (System Cleaner Inteligentny Automatyczny) S.A.C.S"
Nord_language.la_sacs_options2 = "Ustaw cykl czasowy S.A.C.S, Obecnie cykl jest ustawiony na"
Nord_language.la_sacs_options3 = "(Włącz / Wyłącz) A.B.C.S. (Automatic Boot Optimizer):"
Nord_language.la_sacs_options4 = "ręcznie wyczyścić wszystkie grupy podmiotów na liście S.A.C.S za:"
Nord_language.la_sacs_options5 = "ręcznie wyczyścić wszystkie grupy podmiotów na liście A.B.C.S za:"
Nord_language.la_sacs_options6 = "Uwaga: Wszystkie jednostki w wykazie S.A.C.S zostanie automatycznie czyszczone."
Nord_language.la_sacs_options7 = "System nadal będzie działać automatycznie po ponownym uruchomieniu komputera, jeśli jest aktywna."
Nord_language.la_sacs_options8 = "Jeśli obiekt właśnie zrodził, to będziemy usunięte w następnej pętli."
Nord_language.la_sacs_options9 = "The A.B.C.S pozwala usunąć automatycznie, czego nie chcą na mapie po ponownym uruchomieniu komputera."
Nord_language.la_sacs_options10 = "Uaktywnij admin-Eyes mieć oko na serwerze, jak i podczas pracy."
Nord_language.la_sacs_options11 = "Usuń to, co wspólne narzędzia nie może obejść się bez tego systemu."
Nord_language.la_sacs_manuelcleana = "Oczyszczanie Ponieważ lista podmioty"
Nord_language.la_sacs_manuelcleanb = "Oczyszczanie Ponieważ lista podmioty"
Nord_language.la_sacs_outil1 = "(Włącz / Wyłącz) opiekunie-Eyes, aby wyświetlić wszystkie podmioty na mapie"
Nord_language.la_sacs_outil2 = "Zobacz Gracze"
Nord_language.la_sacs_outil3 = "Zobacz NPC"
Nord_language.la_sacs_entre = "Vous n'étiez pas admin pl rejoingnant le serveur, reconnecté vous les wlać obtenir informacje vous permettant d'ACCEDER au système S.A.C.S."
Nord_language.la_scrp_nordahl_credit = "Made by Nordahl"
Nord_language.la_scrp_nordahl_note = "Oceń ten skrypt"
Nord_language.la_scrp_nordahl_script = "Script"
Nord_language.la_dnphys1 = "Maksymalna ilość sekund precalculate kolizje z obiektami."
Nord_language.la_dnphys2 = "Maksymalna ilość sekund precalculate kolizji ze światem."
Nord_language.la_dnphys3 = "Maksymalna prędkość obrotowa."
Nord_language.la_dnphys4 = "Maksymalna kontrola kolizji na kleszcza."
Nord_language.la_dnphys5 = "Maksymalna kolizji za obiekt za kleszcza."
Nord_language.la_dnphys6 = "Maksymalna masa obiektu, aby mieć wpływ na tarcie."
Nord_language.la_dnphys7 = "Maksymalna prędkość obiektu."
Nord_language.la_dnphys8 = "minimalna masa obiektu mieć wpływ tarcia."
Nord_language.la_dnphys9 = "Ustawia gęstość powietrza."
Nord_language.la_dnphys10 = "Ustawia grawitację (w przypadku elementów)."
Nord_language.la_dnphys11 = "Ustawia grawitację, (dla graczy)."
end
function languesacsit(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
Nord_language.la_ttles = "Ogni"
Nord_language.la_tousles = "Ogni"
Nord_language.la_secondes = "secondi"
Nord_language.la_minutes = "minuti"
Nord_language.la_heure = "ora"
Nord_language.la_heures = "ore"
Nord_language.la_jours = "giorni"
Nord_language.la_porletest = "per le prove"
Nord_language.la_nomm = "Nome"
Nord_language.la_sacs_ongl1 = "Sul server"
Nord_language.la_sacs_ongl1aid = "entità sul server."
Nord_language.la_sacs_ongl2 = "Ricerca"
Nord_language.la_sacs_ongl2aid = "sistema di ricerca completo per i SACS, Lista ABCS ed entità server"
Nord_language.la_sacs_ongl3 = "Lista di S.A.C.S"
Nord_language.la_sacs_ongl3aid = "Il S.A.C.S consente di eliminare automaticamente gli oggetti che si trovano sul server per un certo tempo"
Nord_language.la_sacs_ongl4 = "Lista di A.B.C.S"
Nord_language.la_sacs_ongl4aid = "The Cleaner Boot consente di eliminare tutte le entità che non si desidera all'avvio del server."
Nord_language.la_sacs_ongl5 = "Opzioni"
Nord_language.la_sacs_ongl5aid = "Opzioni di Sacs"
Nord_language.la_sacs_ongl6 = "Strumenti"
Nord_language.la_sacs_ongl6aid = "L'accesso agli strumenti del Sacs"
Nord_language.la_sacs_ongl11 = "entità sul server"
Nord_language.la_sacs_ongl12 = "posizione di entità"
Nord_language.la_sacs_ongl13 = "Distanza in metri"
Nord_language.la_sacs_ongl00 = "Il nome di entità"
Nord_language.la_sacs_onglb1 = "Cerca le entità"
Nord_language.la_sacs_onglb2 = "Cerca nel A.B.C.S"
Nord_language.la_sacs_onglb3 = "Cerca nel S.A.C.S"
Nord_language.la_sacs_ongl2341 = "nome entità"
Nord_language.la_sacs_ongl22 = "Aggiunto da o distanza di Entity"
Nord_language.la_sacs_ajpar = "Added by"
Nord_language.la_sacs_onglb31 = "Aggiungi a elenco"
Nord_language.la_sacs_onglb41 = "Aggiungi a elenco"
Nord_language.la_sacs_ajentsyst = "Aggiungere la classe di questa entità nel sistema"
Nord_language.la_sacs_supprimer = "Cancella"
Nord_language.la_sacs_supprimer1 = "Elimina questo"
Nord_language.la_sacs_supprimer2 = "Elimina tutti"
Nord_language.la_sacs_tpmoi = "Portami a questa entità"
Nord_language.la_sacs_copieentcl = "Copiare la classe (Ctrl + V per incollare)"
Nord_language.la_sacs_reglcolor = "color questa classe (Per lo strumento AdminEyes)"
Nord_language.la_sacs_blanc = "bianco"
Nord_language.la_sacs_noir = "nero"
Nord_language.la_sacs_bleu = "Blue"
Nord_language.la_sacs_orange = "Orange"
Nord_language.la_sacs_rose = "rosa"
Nord_language.la_sacs_violet = "Viola"
Nord_language.la_sacs_rouge = "Red"
Nord_language.la_sacs_jaune = "Giallo"
Nord_language.la_sacs_vert = "verde"
Nord_language.la_sacs_invisible = "invisibile"
Nord_language.la_sacs_options1 = "(Attiva / Disattiva) il (System Cleaner intelligente automatico) S.A.C.S:"
Nord_language.la_sacs_options2 = "Imposta il tempo di ciclo del S.A.C.S, attualmente, il ciclo è impostato su:"
Nord_language.la_sacs_options3 = "(Attiva / Disattiva) Il A.B.C.S. (Automatic Boot Optimizer):"
Nord_language.la_sacs_options4 = "puliti manualmente tutti i gruppi entità incluso nell'elenco del S.A.C.S:"
Nord_language.la_sacs_options5 = "puliti manualmente tutti i gruppi entità incluso nell'elenco del A.B.C.S:"
Nord_language.la_sacs_options6 = "Nota: Tutte le entità nella lista del S.A.C.S sarà ripulita automaticamente."
Nord_language.la_sacs_options7 = "Il sistema continuerà a funzionare automaticamente quando riavvio se è attivato."
Nord_language.la_sacs_options8 = "Se l'oggetto appena deposto le uova, lo farà abbiamo eliminato nel ciclo successivo."
Nord_language.la_sacs_options9 = "Il A.B.C.S consente di eliminare automaticamente ciò che non si vuole sulla mappa sul riavvio."
Nord_language.la_sacs_options10 = "Attiva gli Admin-Eyes di avere un occhio sul server e quando si lavora."
Nord_language.la_sacs_options11 = "Cancellare gli strumenti comuni non possono fare a meno di questo sistema."
Nord_language.la_sacs_manuelcleana = "Pulizia in quanto l'elenco entità"
Nord_language.la_sacs_manuelcleanb = "Pulizia in quanto l'elenco entità"
Nord_language.la_sacs_outil1 = "(Attiva / Disattiva) Admin-occhi, per vedere tutte le entità sulla mappa:"
Nord_language.la_sacs_outil2 = "vedere i giocatori"
Nord_language.la_sacs_outil3 = "Vedere la NPC"
Nord_language.la_sacs_entre = "Vous n'étiez pas admin it rejoingnant le server, reconnecté vous pour les obtenir informazioni vous permettant d'acceder au système S.A.C.S."
Nord_language.la_scrp_nordahl_credit = "Made by Nordahl"
Nord_language.la_scrp_nordahl_note = "Commenta questo script"
Nord_language.la_scrp_nordahl_script = "Script"
Nord_language.la_dnphys1 = "Numero massimo di secondi per precalculate collisioni con gli oggetti."
Nord_language.la_dnphys2 = "Numero massimo di secondi per precalculate collisioni con il mondo."
Nord_language.la_dnphys3 = "velocità di rotazione massima."
Nord_language.la_dnphys4 = "controlli di collisione massimo per tick."
Nord_language.la_dnphys5 = "collisione massima per struttura per tick."
Nord_language.la_dnphys6 = "massa massima di un oggetto per essere influenzata da attrito."
Nord_language.la_dnphys7 = "Velocità massima di un oggetto."
Nord_language.la_dnphys8 = "La massa minima di un oggetto per essere influenzata da attrito."
Nord_language.la_dnphys9 = "Imposta la densità dell'aria."
Nord_language.la_dnphys10 = "Imposta la gravità, (Per le voci)."
Nord_language.la_dnphys11 = "Imposta la gravità, (per i giocatori)."
end
function languesacsbg(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
Nord_language.la_ttles = "Всеки"
Nord_language.la_tousles = "Всеки"
Nord_language.la_secondes = "секунди"
Nord_language.la_minutes = "минути"
Nord_language.la_heure = "час"
Nord_language.la_heures = "часове"
Nord_language.la_jours = "дни"
Nord_language.la_porletest = "за тестовете"
Nord_language.la_nomm = "Име"
Nord_language.la_sacs_ongl1 = "На сървъра"
Nord_language.la_sacs_ongl1aid = "Субекти на вашия сървър."
Nord_language.la_sacs_ongl2 = "Търсене"
Nord_language.la_sacs_ongl2aid = "Цялостна система за търсене на алвеолите, ABCS списъка и сървърни образувания"
Nord_language.la_sacs_ongl3 = "Списък S.A.C.S е"
Nord_language.la_sacs_ongl3aid = "The S.A.C.S ви позволява да изтриете автоматично обектите, които са на вашия сървър за известно време"
Nord_language.la_sacs_ongl4 = "Списък A.B.C.S е"
Nord_language.la_sacs_ongl4aid = "чисти Boot ви позволява да изтриете всички субекти, които не искате, когато сървърът да започне."
Nord_language.la_sacs_ongl5 = "Опции"
Nord_language.la_sacs_ongl5aid = "Опции торбички за"
Nord_language.la_sacs_ongl6 = "Инструменти"
Nord_language.la_sacs_ongl6aid = "Достъпът до инструменти на алвеолите на"
Nord_language.la_sacs_ongl11 = "Субекти на сървъра"
Nord_language.la_sacs_ongl12 = "позиция Субекти"
Nord_language.la_sacs_ongl13 = "Разстояние в метри"
Nord_language.la_sacs_ongl00 = "име предприятието"
Nord_language.la_sacs_onglb1 = "Търсене субекти"
Nord_language.la_sacs_onglb2 = "Търсене в A.B.C.S"
Nord_language.la_sacs_onglb3 = "Търсене в S.A.C.S"
Nord_language.la_sacs_ongl2341 = "Субекти име"
Nord_language.la_sacs_ongl22 = "Добавена от или разстояние предприятието"
Nord_language.la_sacs_ajpar = "Добавена от"
Nord_language.la_sacs_onglb31 = "Добави в списък"
Nord_language.la_sacs_onglb41 = "Добави в списък"
Nord_language.la_sacs_ajentsyst = "Добави клас този субект в системата"
Nord_language.la_sacs_supprimer = "Изтриване"
Nord_language.la_sacs_supprimer1 = "Изтриване на този един"
Nord_language.la_sacs_supprimer2 = "Изтриване на всички от тях"
Nord_language.la_sacs_tpmoi = "Заведи ме на този субект"
Nord_language.la_sacs_copieentcl = "Копиране на класа (Ctrl + V, за да поставите)"
Nord_language.la_sacs_reglcolor = "Цвят този клас (За инструмента за AdminEyes)"
Nord_language.la_sacs_blanc = "White"
Nord_language.la_sacs_noir = "Black"
Nord_language.la_sacs_bleu = "Blue"
Nord_language.la_sacs_orange = "Orange"
Nord_language.la_sacs_rose = "Pink"
Nord_language.la_sacs_violet = "Purple"
Nord_language.la_sacs_rouge = "Red"
Nord_language.la_sacs_jaune = "Жълто"
Nord_language.la_sacs_vert = "Green"
Nord_language.la_sacs_invisible = "Невидим"
Nord_language.la_sacs_options1 = "(активиране / деактивиране) S.A.C.S (Смарт Automatic Cleaner система) на:"
Nord_language.la_sacs_options2 = "Задайте време цикъл на S.A.C.S, В момента, цикълът е на:"
Nord_language.la_sacs_options3 = "(активиране / деактивиране) на (Cleaner Automatic Boot) A.B.C.S.:"
Nord_language.la_sacs_options4 = "Ръчно чисти всички групи лица в списъка на S.A.C.S е:"
Nord_language.la_sacs_options5 = "Ръчно чисти всички групи лица в списъка на A.B.C.S е:"
Nord_language.la_sacs_options6 = "Забележка: Всички лица в списъка на S.A.C.S ще се почистват автоматично."
Nord_language.la_sacs_options7 = "Системата ще продължи да работи автоматично, когато рестартиране, ако е активирана."
Nord_language.la_sacs_options8 = "Ако обектът просто зареди, то ще можем изтрит в следващия цикъл."
Nord_language.la_sacs_options9 = "The A.B.C.S ви позволява да изтриете автоматично това, което не искате на картата на рестартиране."
Nord_language.la_sacs_options10 = "Активиране на Админ-очи, за да има едно око на сървъра и когато се работи."
Nord_language.la_sacs_options11 = "Изтриване какво общите инструменти, не може без тази система."
Nord_language.la_sacs_manuelcleana = "Cleanup Тъй като списъкът на лица"
Nord_language.la_sacs_manuelcleanb = "Cleanup Тъй като списъкът на лица"
Nord_language.la_sacs_outil1 = "(активиране / деактивиране) админ очи, за да виждат всички субекти на картата на града:"
Nord_language.la_sacs_outil2 = "Вижте на играчите"
Nord_language.la_sacs_outil3 = "Вижте на NPC-та"
Nord_language.la_sacs_entre = "Vous n'étiez па администратор ен rejoingnant ле serveur, reconnecté ву излее obtenir ле информации ву permettant d'Acceder о Système S.A.C.S."
Nord_language.la_scrp_nordahl_credit = "Произведено от Nordahl"
Nord_language.la_scrp_nordahl_note = "Прегледайте този сценарий"
Nord_language.la_scrp_nordahl_script = "Script"
Nord_language.la_dnphys1 = "Максимален размер на секунди, за да precalculate сблъсъци с предмети."
Nord_language.la_dnphys2 = "Максимален размер на секунди, за да precalculate сблъсъци с свят."
Nord_language.la_dnphys3 = "Максимална скорост на въртене."
Nord_language.la_dnphys4 = "Максимални проверки сблъскване на кърлеж."
Nord_language.la_dnphys5 = "Максимален сблъсък на обект на кърлеж."
Nord_language.la_dnphys6 = "Максимална маса на даден обект да бъде засегната от триене."
Nord_language.la_dnphys7 = "Максимална скорост на даден обект."
Nord_language.la_dnphys8 = "Минимална маса на даден обект да бъде засегната от триене."
Nord_language.la_dnphys9 = "Задава плътността на въздуха."
Nord_language.la_dnphys10 = "Задава тежестта, (за точките)."
Nord_language.la_dnphys11 = "Задава тежестта, (за играчите)."
end
function languesacscs(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
Nord_language.la_ttles = "Každý"
Nord_language.la_tousles = "Každý"
Nord_language.la_secondes = "sekund"
Nord_language.la_minutes = "minut"
Nord_language.la_heure = "hodiny"
Nord_language.la_heures = "hodiny"
Nord_language.la_jours = "dny"
Nord_language.la_porletest = "pro zkoušky"
Nord_language.la_nomm = "Název"
Nord_language.la_sacs_ongl1 = "Na serveru"
Nord_language.la_sacs_ongl1aid = "Subjekty na serveru."
Nord_language.la_sacs_ongl2 = "Search"
Nord_language.la_sacs_ongl2aid = "Complete vyhledávací systém pro váčků, ABC seznam a subjekty server"
Nord_language.la_sacs_ongl3 = "S.A.C.S je seznam"
Nord_language.la_sacs_ongl3aid = "The S.A.C.S umožňuje automaticky odstranit objekty, které jsou na serveru nějakou dobu"
Nord_language.la_sacs_ongl4 = "A.B.C.S je seznam"
Nord_language.la_sacs_ongl4aid = "Zaváděcí Cleaner umožňuje odstranit všechny entity, které nechcete při spuštění serveru."
Nord_language.la_sacs_ongl5 = "Options"
Nord_language.la_sacs_ongl5aid = "váčků je Options"
Nord_language.la_sacs_ongl6 = "Nástroje"
Nord_language.la_sacs_ongl6aid = "Přístup k nástrojům těchto kanálů SAC je"
Nord_language.la_sacs_ongl11 = "Subjekty na serveru"
Nord_language.la_sacs_ongl12 = "Subjekty poloha"
Nord_language.la_sacs_ongl13 = "vzdálenost v metrech"
Nord_language.la_sacs_ongl00 = "subjektem jméno"
Nord_language.la_sacs_onglb1 = "Hledat entity"
Nord_language.la_sacs_onglb2 = "Hledat v A.B.C.S"
Nord_language.la_sacs_onglb3 = "Při hledání v S.A.C.S"
Nord_language.la_sacs_ongl2341 = "Subjekty název"
Nord_language.la_sacs_ongl22 = "Přidal nebo vzdálenosti Subjektu"
Nord_language.la_sacs_ajpar = "Přidal"
Nord_language.la_sacs_onglb31 = "Přidat do seznamu"
Nord_language.la_sacs_onglb41 = "Přidat do seznamu"
Nord_language.la_sacs_ajentsyst = "Přidat třídu tato entita v systému"
Nord_language.la_sacs_supprimer = "Delete"
Nord_language.la_sacs_supprimer1 = "Smazat tento jeden"
Nord_language.la_sacs_supprimer2 = "Odstranit všechny z nich"
Nord_language.la_sacs_tpmoi = "Vezmi mě k tomuto subjektu"
Nord_language.la_sacs_copieentcl = "Kopírovat třídu (Ctrl + V pro vložení)"
Nord_language.la_sacs_reglcolor = "Barva této třídy (Pro nástroj AdminEyes)"
Nord_language.la_sacs_blanc = "bílé"
Nord_language.la_sacs_noir = "Black"
Nord_language.la_sacs_bleu = "Blue"
Nord_language.la_sacs_orange = "oranžová"
Nord_language.la_sacs_rose = "Pink"
Nord_language.la_sacs_violet = "Purple"
Nord_language.la_sacs_rouge = "Red"
Nord_language.la_sacs_jaune = "Yellow"
Nord_language.la_sacs_vert = "zelená"
Nord_language.la_sacs_invisible = "Neviditelný"
Nord_language.la_sacs_options1 = "(Aktivace / deaktivace) Tento S.A.C.S (Inteligentní automatický Cleaner System):"
Nord_language.la_sacs_options2 = "Nastavte časový cyklus S.A.C.S, V současné době je cyklus je nastaven na"
Nord_language.la_sacs_options3 = "(Aktivace / deaktivace) Tento A.B.C.S. (Automatic Boot Optimizer):"
Nord_language.la_sacs_options4 = "Ruční čištění všech subjektů skupin na S.A.C.S v seznamu:"
Nord_language.la_sacs_options5 = "Ruční čištění všech subjektů skupin na A.B.C.S v seznamu:"
Nord_language.la_sacs_options6 = "Poznámka: Všechny subjekty v S.A.C.S v seznamu budou automaticky vyčistit."
Nord_language.la_sacs_options7 = "Systém bude i nadále pracovat automaticky při restartování, pokud je to aktivováno."
Nord_language.la_sacs_options8 = "Pokud objekt právě plodil, bude to my vymazán v příštím cyklu."
Nord_language.la_sacs_options9 = "The A.B.C.S umožňuje automaticky odstranit to, co nechcete, aby na mapě na restartování."
Nord_language.la_sacs_options10 = "Aktivace admin-Eyes mít oči na serveru a při práci."
Nord_language.la_sacs_options11 = "Smazat jaké jsou běžné nástroje, se neobejde bez tohoto systému."
Nord_language.la_sacs_manuelcleana = "vyčištění od Seznamu subjektů"
Nord_language.la_sacs_manuelcleanb = "vyčištění od Seznamu subjektů"
Nord_language.la_sacs_outil1 = "(Aktivace / deaktivace) admina-Eyes, vidět všechny subjekty na mapě"
Nord_language.la_sacs_outil2 = "Podívejte se na Hráči"
Nord_language.la_sacs_outil3 = "Podívejte se na NPC"
Nord_language.la_sacs_entre = "Vous n'étiez pas admin cs rejoingnant le Serveur, reconnecté vous nalít obtenir les informace vous permettant d'ACCEDER au systčme S.A.C.S."
Nord_language.la_scrp_nordahl_credit = "Made by Nordahl"
Nord_language.la_scrp_nordahl_note = "Ohodnotit tento skript"
Nord_language.la_scrp_nordahl_script = "Script"
Nord_language.la_dnphys1 = "Maximální počet sekund precalculate kolize s objekty."
Nord_language.la_dnphys2 = "Maximální počet sekund precalculate kolize s svět."
Nord_language.la_dnphys3 = "Maximální rychlost rotace."
Nord_language.la_dnphys4 = "Maximální kontroly kolizí za klíště."
Nord_language.la_dnphys5 = "Maximální srážka za objekt za tik."
Nord_language.la_dnphys6 = "Maximální hmotnost objektu, který má být ovlivněn třením."
Nord_language.la_dnphys7 = "Maximální rychlost objektu."
Nord_language.la_dnphys8 = "Minimální hmotnost objektu, který má být ovlivněna třením."
Nord_language.la_dnphys9 = "Nastaví hustoty vzduchu."
Nord_language.la_dnphys10 = "Nastaví gravitaci, (pro položky)."
Nord_language.la_dnphys11 = "Nastaví gravitaci, (pro hráče)."
end
function languesacset(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
Nord_language.la_ttles = "Iga"
Nord_language.la_tousles = "Iga"
Nord_language.la_secondes = "sekundit"
Nord_language.la_minutes = "minut"
Nord_language.la_heure = "tund"
Nord_language.la_heures = "tundi"
Nord_language.la_jours = "päeva"
Nord_language.la_porletest = "katsete"
Nord_language.la_nomm = "Nimi"
Nord_language.la_sacs_ongl1 = "On the server"
Nord_language.la_sacs_ongl1aid = "Üksused oma serverisse."
Nord_language.la_sacs_ongl2 = "Otsi"
Nord_language.la_sacs_ongl2aid = "Täielik otsing süsteem limast, ABCS loetelu ja serveri üksused"
Nord_language.la_sacs_ongl3 = "S.A.C.S List"
Nord_language.la_sacs_ongl3aid = "The S.A.C.S võimaldab teil kustutada automaatselt objektid, mis on oma server mõnda aega"
Nord_language.la_sacs_ongl4 = "A.B.C.S List"
Nord_language.la_sacs_ongl4aid = "Boot Optimizer võimaldab teil kustutada kõik üksused, sa ei taha, kui server hakkab."
Nord_language.la_sacs_ongl5 = "Options"
Nord_language.la_sacs_ongl5aid = "limast Valikute"
Nord_language.la_sacs_ongl6 = "Tools"
Nord_language.la_sacs_ongl6aid = "Juurdepääs limast tööriistad"
Nord_language.la_sacs_ongl11 = "Üksused serveris"
Nord_language.la_sacs_ongl12 = "Üksused asendis"
Nord_language.la_sacs_ongl13 = "meetrites"
Nord_language.la_sacs_ongl00 = "üksuse nimega"
Nord_language.la_sacs_onglb1 = "Otsi üksused"
Nord_language.la_sacs_onglb2 = "otsingule A.B.C.S"
Nord_language.la_sacs_onglb3 = "otsingule S.A.C.S"
Nord_language.la_sacs_ongl2341 = "Üksused nimi"
Nord_language.la_sacs_ongl22 = "Lisatud poolt või Entity kauguse"
Nord_language.la_sacs_ajpar = "Lisatud"
Nord_language.la_sacs_onglb31 = "Lisa loetelus"
Nord_language.la_sacs_onglb41 = "Lisa loetelus"
Nord_language.la_sacs_ajentsyst = "Lisa see majandusüksuse klassi süsteem"
Nord_language.la_sacs_supprimer = "Kustuta"
Nord_language.la_sacs_supprimer1 = "Kustuta see üks"
Nord_language.la_sacs_supprimer2 = "Kustuta kõik neist"
Nord_language.la_sacs_tpmoi = "Vii mind see üksus"
Nord_language.la_sacs_copieentcl = "Kopeeri klassi (Ctrl + V kleepida)"
Nord_language.la_sacs_reglcolor = "color Selle klassi (Sest AdminEyes näitaja)"
Nord_language.la_sacs_blanc = "valge"
Nord_language.la_sacs_noir = "Black"
Nord_language.la_sacs_bleu = "Blue"
Nord_language.la_sacs_orange = "Orange"
Nord_language.la_sacs_rose = "Pink"
Nord_language.la_sacs_violet = "Purple"
Nord_language.la_sacs_rouge = "Red"
Nord_language.la_sacs_jaune = "Yellow"
Nord_language.la_sacs_vert = "Roheline"
Nord_language.la_sacs_invisible = "Nähtamatu"
Nord_language.la_sacs_options1 = "(sisse / välja lülitada) S.A.C.S (Smart Automaatne Cleaner System):"
Nord_language.la_sacs_options2 = "Määra aeg tsükkel S.A.C.S, Praegu on tsükkel on seatud:"
Nord_language.la_sacs_options3 = "(sisse / välja lülitada) A.B.C.S. (Automatic Boot Optimizer):"
Nord_language.la_sacs_options4 = "Käsitsi puhas kõigi üksuste rühmade S.A.C.S nimekirja:"
Nord_language.la_sacs_options5 = "Käsitsi puhas kõigi üksuste rühmade A.B.C.S nimekirja:"
Nord_language.la_sacs_options6 = "Märkus: Kõik üksuste S.A.C.S nimekirja automaatselt puhastada."
Nord_language.la_sacs_options7 = "Süsteem jätkab tööd automaatselt taaskäivitus, kui see on aktiveeritud."
Nord_language.la_sacs_options8 = "Kui objekt lihtsalt sünnitanud, siis me kustutatakse järgmise silmuse."
Nord_language.la_sacs_options9 = "The A.B.C.S võimaldab teil kustutada automaatselt mida sa ei taha kaardil on reboot."
Nord_language.la_sacs_options10 = "aktiveerimine Admin-Silmad on silma peal server ja kui te töötate."
Nord_language.la_sacs_options11 = "Kustuta, mida ühiseid vahendeid ei saa ilma seda süsteemi."
Nord_language.la_sacs_manuelcleana = "Cleanup kuna üksuste loetelu"
Nord_language.la_sacs_manuelcleanb = "Cleanup kuna üksuste loetelu"
Nord_language.la_sacs_outil1 = "(sisse / välja lülitada) Administraatori-Silmad, et näha kõiki üksusi kaardil:"
Nord_language.la_sacs_outil2 = "Vaadake Mängijad"
Nord_language.la_sacs_outil3 = "Vaadake NPCs"
Nord_language.la_sacs_entre = "Vous n'étiez pas admin en rejoingnant le Serveur, reconnecté vous valada obtenir les informations vous permettant d'ACCEDER au système S.A.C.S."
Nord_language.la_scrp_nordahl_credit = "Made by Nordahl"
Nord_language.la_scrp_nordahl_note = "Vaadake see skript"
Nord_language.la_scrp_nordahl_script = "Script"
Nord_language.la_dnphys1 = "Maksimaalne sekundit precalculate kokkupõrkeid objekte."
Nord_language.la_dnphys2 = "Maksimaalne sekundit precalculate kokkupõrkeid maailma."
Nord_language.la_dnphys3 = "Maksimaalne rotatsiooni kiiruse."
Nord_language.la_dnphys4 = "Maksimaalne kokkupõrke kontrolli kohta rist."
Nord_language.la_dnphys5 = "Maksimaalne kokkupõrke kohta objekti kohta rist."
Nord_language.la_dnphys6 = "Maksimaalne objekti mass mõjutab hõõrdumist."
Nord_language.la_dnphys7 = "Maksimaalne kiirus objekti."
Nord_language.la_dnphys8 = "Minimaalne objekti mass mõjutab hõõrdumist."
Nord_language.la_dnphys9 = "Määrab õhutihedus."
Nord_language.la_dnphys10 = "Määrab raskust, (Sest esemed)."
Nord_language.la_dnphys11 = "Määrab raskust, (Sest mängijad)."
end
function languesacsfi(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
Nord_language.la_ttles = "Jokainen"
Nord_language.la_tousles = "Jokainen"
Nord_language.la_secondes = "sekuntia"
Nord_language.la_minutes = "minuuttia"
Nord_language.la_heure = "hour"
Nord_language.la_heures = "tuntia"
Nord_language.la_jours = "päivää"
Nord_language.la_porletest = "testeistä"
Nord_language.la_nomm = "Nimi"
Nord_language.la_sacs_ongl1 = "Palvelin"
Nord_language.la_sacs_ongl1aid = "Yksiköt palvelimella."
Nord_language.la_sacs_ongl2 = "Etsi"
Nord_language.la_sacs_ongl2aid = "Täydellinen hakujärjestelmä varten SACS, ABCS List ja palvelimen yhteisöt"
Nord_language.la_sacs_ongl3 = "S.A.C.S lista"
Nord_language.la_sacs_ongl3aid = "S.A.C.S voit poistaa automaattisesti esineitä, jotka ovat palvelimella jonkin aikaa"
Nord_language.la_sacs_ongl4 = "A.B.C.S lista"
Nord_language.la_sacs_ongl4aid = "Boot Optimizer voit poistaa kaikki yhteisöt, jotka et halua, kun palvelin käynnistyy."
Nord_language.la_sacs_ongl5 = "Asetukset"
Nord_language.la_sacs_ongl5aid = "SAC: n asetukset"
Nord_language.la_sacs_ongl6 = "työkalut"
Nord_language.la_sacs_ongl6aid = "Pääsy SACS työkalut"
Nord_language.la_sacs_ongl11 = "Yksiköt palvelimelle"
Nord_language.la_sacs_ongl12 = "yhteisöt asentoon"
Nord_language.la_sacs_ongl13 = "Etäisyys metreinä"
Nord_language.la_sacs_ongl00 = "Entity nimi"
Nord_language.la_sacs_onglb1 = "Hae yhteisöt"
Nord_language.la_sacs_onglb2 = "toimialalla A.B.C.S"
Nord_language.la_sacs_onglb3 = "Search in the S.A.C.S"
Nord_language.la_sacs_ongl2341 = "yhteisöt name"
Nord_language.la_sacs_ongl22 = "Lisääjä tai Entity etäisyyden"
Nord_language.la_sacs_ajpar = "Lisääjä"
Nord_language.la_sacs_onglb31 = "Add luettelossa"
Nord_language.la_sacs_onglb41 = "Add luettelossa"
Nord_language.la_sacs_ajentsyst = "Lisää tämä yksikön luokkaa järjestelmässä"
Nord_language.la_sacs_supprimer = "Poista"
Nord_language.la_sacs_supprimer1 = "Poista tämä yksi"
Nord_language.la_sacs_supprimer2 = "Poista ne kaikki"
Nord_language.la_sacs_tpmoi = "Vie minut tähän kokonaisuuden"
Nord_language.la_sacs_copieentcl = "Kopioi luokka (Ctrl + V liittää)"
Nord_language.la_sacs_reglcolor = "Color tässä luokassa (Sillä AdminEyes työkalu)"
Nord_language.la_sacs_blanc = "White"
Nord_language.la_sacs_noir = "Black"
Nord_language.la_sacs_bleu = "Blue"
Nord_language.la_sacs_orange = "Orange"
Nord_language.la_sacs_rose = "Pink"
Nord_language.la_sacs_violet = "Purple"
Nord_language.la_sacs_rouge = "Red"
Nord_language.la_sacs_jaune = "keltainen"
Nord_language.la_sacs_vert = "Green"
Nord_language.la_sacs_invisible = "Invisible"
Nord_language.la_sacs_options1 = "(Ota käyttöön / Poista käytöstä) S.A.C.S (Smart Automatic Cleaner System):"
Nord_language.la_sacs_options2 = "Aseta aika sykli S.A.C.S, tällä hetkellä, sykli on asetettu:"
Nord_language.la_sacs_options3 = "(Ota käyttöön / pois) A.B.C.S. (Automatic Boot Optimizer):"
Nord_language.la_sacs_options4 = "manuaalinen puhdistaminen kaikki yksiköt ryhmien S.A.C.S listalla:"
Nord_language.la_sacs_options5 = "manuaalinen puhdistaminen kaikki yksiköt ryhmien A.B.C.S listalla:"
Nord_language.la_sacs_options6 = "Huomautus: Kaikki yksiköt on S.A.C.S luetteloon automaattisesti puhdistaa."
Nord_language.la_sacs_options7 = "Järjestelmä jatkaa automaattisesti uudelleenkäynnistystä, jos se on aktivoitu."
Nord_language.la_sacs_options8 = "Jos objekti juuri poikinut, se Poistimme seuraavan silmukka."
Nord_language.la_sacs_options9 = "A.B.C.S voit poistaa automaattisesti mitä et halua kartalle on uudelleenkäynnistyksen."
Nord_language.la_sacs_options10 = "Aktivoi Admin-Eyes on silmällä palvelimelle ja kun työtä."
Nord_language.la_sacs_options11 = "Poista mitä yhteisiä välineitä ei voi tehdä ilman tätä järjestelmää."
Nord_language.la_sacs_manuelcleana = "uudelleenjärjestäminen koska yksiköt, List"
Nord_language.la_sacs_manuelcleanb = "uudelleenjärjestäminen koska yksiköt, List"
Nord_language.la_sacs_outil1 = "(Ota käyttöön / pois) Admin-Eyes, nähdä kaikki yksiköt kartalta"
Nord_language.la_sacs_outil2 = "nähdä pelaajien"
Nord_language.la_sacs_outil3 = "Katso NPC"
Nord_language.la_sacs_entre = "Vous n'étiez pas admin fi rejoingnant le serveur, reconnecté vous pour obtenir les informations vous permettant d'ACCEDER au système S.A.C.S."
Nord_language.la_scrp_nordahl_credit = "Made by Nordahl"
Nord_language.la_scrp_nordahl_note = "Arvioi tämä kirjoitus"
Nord_language.la_scrp_nordahl_script = "Script"
Nord_language.la_dnphys1 = "enimmäismäärä sekunnin precalculate törmäykset esineitä."
Nord_language.la_dnphys2 = "enimmäismäärä sekunnin precalculate törmäykset maailmaan."
Nord_language.la_dnphys3 = "Maximum pyörimisnopeus."
Nord_language.la_dnphys4 = "Maximum törmäys tarkastuksia per rasti."
Nord_language.la_dnphys5 = "Maximum törmäys per kohde per rasti."
Nord_language.la_dnphys6 = "suurin massa objektin vaikuttaa kitkaa."
Nord_language.la_dnphys7 = "maksiminopeus objektin."
Nord_language.la_dnphys8 = "vähimmäismassa objektin vaikuttaa kitkaa."
Nord_language.la_dnphys9 = "Asettaa ilman tiheys."
Nord_language.la_dnphys10 = "Asettaa painovoiman (kohtia varten)."
Nord_language.la_dnphys11 = "Asettaa painovoiman (For pelaajien)."
end
function languesacsja(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
Nord_language.la_ttles = "すべて"
Nord_language.la_tousles = "すべて"
Nord_language.la_secondes = "秒"
Nord_language.la_minutes = "分"
Nord_language.la_heure = "時間"
Nord_language.la_heures = "時間"
Nord_language.la_jours = "日"
Nord_language.la_porletest = "テスト用"
Nord_language.la_nomm = "名前"
Nord_language.la_sacs_ongl1 = "サーバーで"
Nord_language.la_sacs_ongl1aid = "サーバー上のエンティティ。"
Nord_language.la_sacs_ongl2 = "検索"
Nord_language.la_sacs_ongl2aid = "SACS、ABCSリストとサーバエンティティのための完全な検索システム"
Nord_language.la_sacs_ongl3 = "S.A.C.Sのリスト"
Nord_language.la_sacs_ongl3aidは= "S.A.C.Sはあなたには、いくつかの時間のために、自動的にサーバー上にあるオブジェクトを削除することができます"
Nord_language.la_sacs_ongl4 = "A.B.C.Sのリスト"
Nord_language.la_sacs_ongl4aid = "ブートクリーナーを使用すると、サーバーの起動時にしたくないすべてのエンティティを削除することができます。"
Nord_language.la_sacs_ongl5 = "オプション"
Nord_language.la_sacs_ongl5aid = "SACSのオプション"
Nord_language.la_sacs_ongl6 = "ツール"
Nord_language.la_sacs_ongl6aid = "SACSのツールへのアクセス"
Nord_language.la_sacs_ongl11 = "サーバー上のエンティティ"
Nord_language.la_sacs_ongl12 = "エンティティの位置"
Nord_language.la_sacs_ongl13 = "メートルの距離"
Nord_language.la_sacs_ongl00 ="エンティティの名前"
Nord_language.la_sacs_onglb1 = "エンティティを検索"
Nord_language.la_sacs_onglb2 = "A.B.C.Sで検索"
Nord_language.la_sacs_onglb3 = "S.A.C.Sで検索"
Nord_language.la_sacs_ongl2341 ="エンティティ名"
Nord_language.la_sacs_ongl22 = "またはエンティティの距離によって追加されました"
Nord_language.la_sacs_ajpar = "によって追加されました"
Nord_language.la_sacs_onglb31 = "リストに追加"
Nord_language.la_sacs_onglb41 = "リストに追加"
Nord_language.la_sacs_ajentsyst = "システムにこのエンティティのクラスを追加します"
Nord_language.la_sacs_supprimer = "削除"
Nord_language.la_sacs_supprimer1 = "この1を削除します"
Nord_language.la_sacs_supprimer2 = "それらのすべてを削除します"
Nord_language.la_sacs_tpmoi = "このエンティティに私を取ります"
Nord_language.la_sacs_copieentcl = "クラスをコピーします（Ctrl + Vで貼り付け）"
Nord_language.la_sacs_reglcolor = "カラー（AdminEyesツールの場合）このクラス"
Nord_language.la_sacs_blanc = "ホワイト"
Nord_language.la_sacs_noir = "ブラック"
Nord_language.la_sacs_bleu = "ブルー"
Nord_language.la_sacs_orange = "オレンジ"
Nord_language.la_sacs_rose = "ピンク"
Nord_language.la_sacs_violet = "パープル"
Nord_language.la_sacs_rouge = "赤"
Nord_language.la_sacs_jaune = "イエロー"
Nord_language.la_sacs_vert = "グリーン"
Nord_language.la_sacs_invisible = "見えません"
Nord_language.la_sacs_options1 = "（有効化/無効化）S.A.C.S（スマート自動クリーナーシステム）："
Nord_language.la_sacs_options2 = "現在、サイクルがオンに設定されている、S.A.C.Sの時間周期を設定します。"
Nord_language.la_sacs_options3 = "（有効化/無効化）A.B.C.S.（自動ブートクリーナー）："
Nord_language.la_sacs_options4 = "手動S.A.C.Sのリスト上のすべてのエンティティグループをきれいに："
Nord_language.la_sacs_options5 = "手動A.B.C.Sのリスト上のすべてのエンティティグループをきれいに："
Nord_language.la_sacs_options6 = "注：S.A.C.Sのリスト内のすべてのエンティティは自動的に消去されます。"
Nord_language.la_sacs_options7 = "システムは、それがアクティブだ場合、再起動時に自動的に動作し続けます。"
Nord_language.la_sacs_options8は= "オブジェクトがちょうど生成された場合、それは我々は次のループに削除されます。"
Nord_language.la_sacs_options9 = "A.B.C.Sは、あなたがリブート時に地図上にしたくないものを自動的に削除することができます。"
Nord_language.la_sacs_options10 = "サーバーとしたときに仕事に目を持っている管理者-目をアクティブにします。"
Nord_language.la_sacs_options11 = "共通のツールがこのシステムなしで行うことはできませんどのような削除します。"
Nord_language.la_sacs_manuelcleana = "エンティティのリスト以来のクリーンアップ"
Nord_language.la_sacs_manuelcleanb = "エンティティのリスト以来のクリーンアップ"
Nord_language.la_sacs_outil1 = "（有効化/無効化）管理-目は、マップ上のすべてのエンティティを参照します"
Nord_language.la_sacs_outil2 = "選手を参照してください"
Nord_language.la_sacs_outil3 = "のNPCを参照してください"
Nord_language.la_sacs_entre = "Vousのn'étiezPAS管理者専用rejoingnantルserveur、reconnectévousのは、vousのpermettantドールacceder auのSYSTEME S.A.C.S. obtenirレの情報を注ぎます"
Nord_language.la_scrp_nordahl_credit = "Nordahl製"
Nord_language.la_scrp_nordahl_note = "このスクリプトを確認します"
Nord_language.la_scrp_nordahl_script = "スクリプト"
Nord_language.la_dnphys1 = "オブジェクトとの衝突を事前計算する秒の最大量。"
Nord_language.la_dnphys2 = "秒の最大量は、世界との衝突を事前計算します。"
Nord_language.la_dnphys3 ="最大回転速度。"
Nord_language.la_dnphys4 = "目盛りあたりの最大の衝突をチェックします。"
Nord_language.la_dnphys5 = "目盛りあたりのオブジェクトごとの最大衝突。"
Nord_language.la_dnphys6 = "摩擦によって影響されるオブジェクトの最大質量。"
Nord_language.la_dnphys7 = "オブジェクトの最高速度。"
Nord_language.la_dnphys8 = "摩擦の影響を受けるオブジェクトの最小質量。"
Nord_language.la_dnphys9 = "空気密度を設定します。"
Nord_language.la_dnphys10 ="は（項目については）重力を設定します。"
Nord_language.la_dnphys11 ="は（選手用）重力を設定します。"
end
function languesacsko(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
Nord_language.la_ttles = "모든"
Nord_language.la_tousles = "모든"
Nord_language.la_secondes = "초"
Nord_language.la_minutes = "분"
Nord_language.la_heure = "시간"
Nord_language.la_heures = "시간"
Nord_language.la_jours = "일"
Nord_language.la_porletest = "시험에 대한"
Nord_language.la_nomm = "이름"
Nord_language.la_sacs_ongl1 = "서버에서"
Nord_language.la_sacs_ongl1aid = "서버에 엔티티."
Nord_language.la_sacs_ongl2 = "검색"
Nord_language.la_sacs_ongl2aid = "는 SACS, 상식 목록 및 서버 개체에 대한 전체 검색 시스템"
Nord_language.la_sacs_ongl3 = "S.A.C.S의 목록"
Nord_language.la_sacs_ongl3aid =는 "S.A.C.S는 몇 시간 동안 서버에있는 개체를 자동으로 삭제할 수 있습니다"
Nord_language.la_sacs_ongl4 = "A.B.C.S의 목록"
Nord_language.la_sacs_ongl4aid = "부팅 클리너 서버가 시작될 때 원하지 않는 모든 엔티티를 삭제할 수 있습니다."
Nord_language.la_sacs_ongl5 = "옵션"
Nord_language.la_sacs_ongl5aid = "SACS의 옵션"
Nord_language.la_sacs_ongl6 = "도구"
Nord_language.la_sacs_ongl6aid = "는 SACS의 도구에 액세스"
Nord_language.la_sacs_ongl11 = "서버의 엔티티"
Nord_language.la_sacs_ongl12 = "엔티티 위치"
Nord_language.la_sacs_ongl13 = "m의 거리"
Nord_language.la_sacs_ongl00 = "엔티티의 이름"
Nord_language.la_sacs_onglb1 = "엔티티를 검색"
Nord_language.la_sacs_onglb2 = "는 A.B.C.S의 검색"
Nord_language.la_sacs_onglb3 = "는 S.A.C.S 검색"
Nord_language.la_sacs_ongl2341 = "엔티티 이름"
Nord_language.la_sacs_ongl22 = "또는 법인의 거리 추가"
Nord_language.la_sacs_ajpar = "작성자"
Nord_language.la_sacs_onglb31 = "목록에 추가"
Nord_language.la_sacs_onglb41 = "목록에 추가"
Nord_language.la_sacs_ajentsyst = "시스템이 기업의 클래스를 추가"
Nord_language.la_sacs_supprimer = "삭제"
Nord_language.la_sacs_supprimer1 = "이 하나를 삭제"
Nord_language.la_sacs_supprimer2 = "모두 삭제"
Nord_language.la_sacs_tpmoi = "이 엔티티에 데려가"
Nord_language.la_sacs_copieentcl = "클래스를 복사합니다 (Ctrl + V 붙여)"
Nord_language.la_sacs_reglcolor = "색상합니다 (AdminEyes 도구)이 클래스"
Nord_language.la_sacs_blanc = "화이트"
Nord_language.la_sacs_noir = "블랙"
Nord_language.la_sacs_bleu = "블루"
Nord_language.la_sacs_orange = "오렌지"
Nord_language.la_sacs_rose = "핑크"
Nord_language.la_sacs_violet = "퍼플"
Nord_language.la_sacs_rouge = "레드"
Nord_language.la_sacs_jaune = "노란색"
Nord_language.la_sacs_vert = "녹색"
Nord_language.la_sacs_invisible = "보이지 않는"
Nord_language.la_sacs_options1 = "(활성화 / 비활성화)을 S.A.C.S (스마트 자동 청소기 시스템)"
Nord_language.la_sacs_options2 = "는 S.A.C.S의 시간주기를 설정, 현재주기에 설정됩니다"
Nord_language.la_sacs_options3 = "(활성화 / 비활성화)을 A.B.C.S. (자동 부팅 클리너)"
Nord_language.la_sacs_options4 = "는 S.A.C.S의 목록에 수동으로 청소 모든 개체 그룹"
Nord_language.la_sacs_options5 = "는 A.B.C.S의 목록에 수동으로 청소 모든 개체 그룹"
Nord_language.la_sacs_options6 = "참고 : S.A.C.S의 목록에있는 모든 개체가 자동으로 정리됩니다."
Nord_language.la_sacs_options7 = "이 시스템이 활성화됩니다 경우 부팅 할 때 자동으로 작동 할 것입니다."
Nord_language.la_sacs_options8 = "개체가 단지 스폰 경우, 우리는 다음의 루프에서 삭제할 것이다."
Nord_language.la_sacs_options9 =는 "A.B.C.S을 사용하면 재부팅에지도를하지 않을 것을 자동으로 삭제할 수 있습니다."
Nord_language.la_sacs_options10 = "서버와 때 작동에 눈을 가지고 관리-눈을 활성화합니다."
Nord_language.la_sacs_options11 = "일반적인 툴이 시스템 없이는 할 수없는 것을 삭제합니다."
Nord_language.la_sacs_manuelcleana = "엔티티 목록 이후 정리"
Nord_language.la_sacs_manuelcleanb = "엔티티 목록 이후 정리"
Nord_language.la_sacs_outil1 = "(활성화 / 비활성화) 관리 - 눈,지도에있는 모든 개체를 볼 수 있습니다"
Nord_language.la_sacs_outil2 = "선수 페이지의"
Nord_language.la_sacs_outil3 = "는 NPC들보기"
Nord_language.la_sacs_entre = "VOUS n'étiez 싶어서 관리 엉 rejoingnant 제작 serveur, reconnecté 있니 부어 obtenir 레 정보 있니 permettant 디부 acceder 프 네이 팅 시스템 S.A.C.S."
Nord_language.la_scrp_nordahl_credit = "Nordahl에 의해 만들어"
Nord_language.la_scrp_nordahl_note = "이 스크립트를 검토"
Nord_language.la_scrp_nordahl_script = "스크립트"
Nord_language.la_dnphys1 = "초 최대 금액은 객체와 충돌을 미리 계산합니다."
Nord_language.la_dnphys2 = "초 최대 금액은 세계와의 충돌을 미리 계산합니다."
Nord_language.la_dnphys3 = "최대 회전 속도."
Nord_language.la_dnphys4는 = "틱 당 최대 충돌을 확인합니다."
Nord_language.la_dnphys5 = "틱 당 개체 당 최대 충돌."
Nord_language.la_dnphys6 = "오브젝트의 최대 질량 마찰에 의해 영향을받을 수있다."
Nord_language.la_dnphys7 = "오브젝트의 최대 속도."
Nord_language.la_dnphys8 = "물체의 최소 질량 마찰에 의해 영향을받을 수있다."
Nord_language.la_dnphys9 = "는 공기 밀도를 설정합니다."
Nord_language.la_dnphys10 =는 "(항목의 경우) 중력을 설정합니다."
Nord_language.la_dnphys11 =은 "(선수의 경우) 중력을 설정합니다."
end
function languesacslv(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
Nord_language.la_ttles = "Katrs"
Nord_language.la_tousles = "Katrs"
Nord_language.la_secondes = "sekundes"
Nord_language.la_minutes = "minūtes"
Nord_language.la_heure = "stunda"
Nord_language.la_heures = "stundas"
Nord_language.la_jours = "dienas"
Nord_language.la_porletest = "par pārbaudēm"
Nord_language.la_nomm = "Nosaukums"
Nord_language.la_sacs_ongl1 = "Par servera"
Nord_language.la_sacs_ongl1aid = "Vienības uz jūsu serveri."
Nord_language.la_sacs_ongl2 = "Meklēt"
Nord_language.la_sacs_ongl2aid = "Complete meklēšanas sistēma par ĪADT ABC sarakstā un serveru vienību"
Nord_language.la_sacs_ongl3 = "S.A.C.S List"
Nord_language.la_sacs_ongl3aid = "The S.A.C.S ļauj izdzēst automātiski objekti, kas ir uz jūsu serveri kādu laiku"
Nord_language.la_sacs_ongl4 = "A.B.C.S List"
Nord_language.la_sacs_ongl4aid = "Boot Apkopēja ļauj izdzēst visus uzņēmumus, kas jūs nevēlaties, kad serveris sākas."
Nord_language.la_sacs_ongl5 = "Options"
Nord_language.la_sacs_ongl5aid = "ĪADT s Options"
Nord_language.la_sacs_ongl6 = "Tools"
Nord_language.la_sacs_ongl6aid = "Piekļuve uz ĪADT rīkus"
Nord_language.la_sacs_ongl11 = "Vienības uz servera"
Nord_language.la_sacs_ongl12 = "Vienības pozīcija"
Nord_language.la_sacs_ongl13 = "Attālums metros"
Nord_language.la_sacs_ongl00 = "uzņēmuma nosaukums"
Nord_language.la_sacs_onglb1 = "Meklēt vienībām"
Nord_language.la_sacs_onglb2 = "Meklēt ar A.B.C.S"
Nord_language.la_sacs_onglb3 = "Meklēt ar S.A.C.S"
Nord_language.la_sacs_ongl2341 = "Vienības Nosaukums"
Nord_language.la_sacs_ongl22 = "Pievienots vai uzņēmuma attāluma"
Nord_language.la_sacs_ajpar = "Pievienots"
Nord_language.la_sacs_onglb31 = "Pievienot sarakstā"
Nord_language.la_sacs_onglb41 = "Pievienot sarakstā"
Nord_language.la_sacs_ajentsyst = "Pievienot šo subjekta klases sistēmā"
Nord_language.la_sacs_supprimer = "Dzēst"
Nord_language.la_sacs_supprimer1 = "Dzēst šo vienu"
Nord_language.la_sacs_supprimer2 = "Dzēst visu no tiem"
Nord_language.la_sacs_tpmoi = "Ņem mani uz šo vienību"
Nord_language.la_sacs_copieentcl = "Kopēt klasi (Ctrl + V, lai ielīmētu)"
Nord_language.la_sacs_reglcolor = "Krāsa šī klase (Par AdminEyes instruments)"
Nord_language.la_sacs_blanc = "Baltā"
Nord_language.la_sacs_noir = "Black"
Nord_language.la_sacs_bleu = "Blue"
Nord_language.la_sacs_orange = "Orange"
Nord_language.la_sacs_rose = "Pink"
Nord_language.la_sacs_violet = "Purple"
Nord_language.la_sacs_rouge = "Red"
Nord_language.la_sacs_jaune = "Yellow"
Nord_language.la_sacs_vert = "Green"
Nord_language.la_sacs_invisible = "Invisible"
Nord_language.la_sacs_options1 = "(ieslēgt / izslēgt) to S.A.C.S (Smart Automatic Cleaner System):"
Nord_language.la_sacs_options2 = "Set laika ciklu S.A.C.S, Šobrīd cikls ir iestatīts uz:"
Nord_language.la_sacs_options3 = "(ieslēgt / izslēgt) A.B.C.S. (Automatic Boot Optimizer):"
Nord_language.la_sacs_options4 = "Manuāli tīrs visas vienības grupas uz S.A.C.S sarakstā:"
Nord_language.la_sacs_options5 = "Manuāli tīrs visas vienības grupas uz A.B.C.S sarakstā:"
Nord_language.la_sacs_options6 = "Piezīme: Visi vienībām S.A.C.S sarakstā tiks automātiski jātīra."
Nord_language.la_sacs_options7 = "Sistēma turpinās automātiski strādāt, kad pārstartēšanas, ja tas ir aktivizēts."
Nord_language.la_sacs_options8 = "Ja objekts tikai radījuši, tas būs mēs svītrots nākamajā cilpa."
Nord_language.la_sacs_options9 = "The A.B.C.S ļauj izdzēst automātiski, ko jūs nevēlaties kartē uz reboot."
Nord_language.la_sacs_options10 = "Aktivizēt admin acis ir acu par serveri un kad tu strādā."
Nord_language.la_sacs_options11 = "Svītrot, kopējie līdzekļi nevar iztikt bez šīs sistēmas."
Nord_language.la_sacs_manuelcleana = "Talkas kopš vienību saraksts"
Nord_language.la_sacs_manuelcleanb = "Talkas kopš vienību saraksts"
Nord_language.la_sacs_outil1 = "(ieslēgt / izslēgt) admin-Eyes, lai redzētu visus uzņēmumus kartē:"
Nord_language.la_sacs_outil2 = "Skatīt Spēlētāji"
Nord_language.la_sacs_outil3 = "Skatīt NPC"
Nord_language.la_sacs_entre = "Vous n'étiez pas admin lv rejoingnant le serveur, reconnecté vous ielej obtenir les informations vous permettant d'ACCEDER au Système S.A.C.S."
Nord_language.la_scrp_nordahl_credit = "Made by Nordahl"
Nord_language.la_scrp_nordahl_note = "Pārskatīt šo skriptu"
Nord_language.la_scrp_nordahl_script = "Script"
Nord_language.la_dnphys1 = "Maksimālais daudzums sekundes precalculate sadursmes ar objektiem."
Nord_language.la_dnphys2 = "Maksimālais daudzums sekundes precalculate sadursmes ar pasauli."
Nord_language.la_dnphys3 = "Maksimālais rotācijas ātrums."
Nord_language.la_dnphys4 = "Maksimālais sadursmes pārbaudes uz ērču."
Nord_language.la_dnphys5 = "Maksimālais sadursme uz vienu objektu vienu ķeksīti."
Nord_language.la_dnphys6 = "maksimālā masa objekta ietekmē berzi."
Nord_language.la_dnphys7 = "Maksimālais ātrums objektu."
Nord_language.la_dnphys8 = "Minimālā masa objekta ietekmē berzi."
Nord_language.la_dnphys9 = "Uzstāda gaisa blīvums."
Nord_language.la_dnphys10 = "Sets smagumu, (par vienību)."
Nord_language.la_dnphys11 = "Sets smagumu, (spēlētājiem)."
end
function languesacsno(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
Nord_language.la_ttles = "Hver"
Nord_language.la_tousles = "Hver"
Nord_language.la_secondes = "sekunder"
Nord_language.la_minutes = "minutter"
Nord_language.la_heure = "hour"
Nord_language.la_heures = "timer"
Nord_language.la_jours = "dager"
Nord_language.la_porletest = "for testene"
Nord_language.la_nomm = "Navn"
Nord_language.la_sacs_ongl1 = "On the server"
Nord_language.la_sacs_ongl1aid = "Entities på serveren din."
Nord_language.la_sacs_ongl2 = "Søk"
Nord_language.la_sacs_ongl2aid = "Komplett søkesystem for SACS, ABCS Liste og server enheter"
Nord_language.la_sacs_ongl3 = "S.A.C.S liste"
Nord_language.la_sacs_ongl3aid = "The S.A.C.S lar deg slette automatisk objektene som er på serveren din på en stund"
Nord_language.la_sacs_ongl4 = "A.B.C.S liste"
Nord_language.la_sacs_ongl4aid = "The Boot Optimizer lar deg slette alle enheter som du ikke ønsker når serveren starter."
Nord_language.la_sacs_ongl5 = "Options"
Nord_language.la_sacs_ongl5aid = "Sacs Alternativer"
Nord_language.la_sacs_ongl6 = "Verktøy"
Nord_language.la_sacs_ongl6aid = "Tilgang til Sacs verktøy"
Nord_language.la_sacs_ongl11 = "Entities på serveren"
Nord_language.la_sacs_ongl12 = "Entities posisjon"
Nord_language.la_sacs_ongl13 = "Avstand i meter"
Nord_language.la_sacs_ongl00 = "Entity navn"
Nord_language.la_sacs_onglb1 = "Søk enhetene"
Nord_language.la_sacs_onglb2 = "Søk i A.B.C.S"
Nord_language.la_sacs_onglb3 = "Søk i S.A.C.S"
Nord_language.la_sacs_ongl2341 = "Entities navn"
Nord_language.la_sacs_ongl22 = "Lagt til av eller enhetens avstand"
Nord_language.la_sacs_ajpar = "Lagt til av"
Nord_language.la_sacs_onglb31 = "Legg i liste"
Nord_language.la_sacs_onglb41 = "Legg i liste"
Nord_language.la_sacs_ajentsyst = "Legg til dette foretakets klasse i systemet"
Nord_language.la_sacs_supprimer = "Slett"
Nord_language.la_sacs_supprimer1 = "Slett en"
Nord_language.la_sacs_supprimer2 = "Slett dem alle"
Nord_language.la_sacs_tpmoi = "Ta meg til denne enheten"
Nord_language.la_sacs_copieentcl = "Kopier klasse (Ctrl + V for å lime inn)"
Nord_language.la_sacs_reglcolor = "Color denne klassen (For AdminEyes verktøyet)"
Nord_language.la_sacs_blanc = "White"
Nord_language.la_sacs_noir = "Black"
Nord_language.la_sacs_bleu = "Blue"
Nord_language.la_sacs_orange = "Orange"
Nord_language.la_sacs_rose = "Pink"
Nord_language.la_sacs_violet = "Purple"
Nord_language.la_sacs_rouge = "Red"
Nord_language.la_sacs_jaune = "Yellow"
Nord_language.la_sacs_vert = "Green"
Nord_language.la_sacs_invisible = "Usynlig"
Nord_language.la_sacs_options1 = "(Aktiver / Deaktiver) den S.A.C.S (Smart Automatisk Cleaner System):"
Nord_language.la_sacs_options2 = "Still klokken syklus av S.A.C.S, tiden, syklusen er satt på:"
Nord_language.la_sacs_options3 = "(Aktiver / Deaktiver) The A.B.C.S. (Automatic Boot Optimizer):"
Nord_language.la_sacs_options4 = "manuelt rene alle enhetenes grupper på S.A.C.S liste:"
Nord_language.la_sacs_options5 = "manuelt rene alle enhetenes grupper på A.B.C.S liste:"
Nord_language.la_sacs_options6 = "Merk: Alle enhetene i S.A.C.S liste vil automatisk bli renset."
Nord_language.la_sacs_options7 = "Systemet vil fortsette å fungere automatisk når omstart hvis det er aktivert."
Nord_language.la_sacs_options8 = "Hvis objektet bare gytt, vil det vi slettet i neste bue."
Nord_language.la_sacs_options9 = "The A.B.C.S lar deg slette automatisk hva du ikke vil ha på kartet på omstarten."
Nord_language.la_sacs_options10 = "Aktiver Admin-Eyes til å ha et øye på serveren, og når du jobber."
Nord_language.la_sacs_options11 = "Slett hva de vanligste verktøyene ikke kan gjøre uten dette systemet."
Nord_language.la_sacs_manuelcleana = "Opprydding siden enheter List"
Nord_language.la_sacs_manuelcleanb = "Opprydding siden enheter List"
Nord_language.la_sacs_outil1 = "(Aktiver / Deaktiver) De Admin-Eyes, for å se alle enhetene på kartet:"
Nord_language.la_sacs_outil2 = "Se Players"
Nord_language.la_sacs_outil3 = "Se NPCer"
Nord_language.la_sacs_entre = "Vous n'étiez pas admin no rejoingnant le serveur, reconnecté vous pour obtenir les informations vous permettant d'acceder au système S.A.C.S."
Nord_language.la_scrp_nordahl_credit = "Made by Nordahl"
Nord_language.la_scrp_nordahl_note = "gjennom dette skriptet"
Nord_language.la_scrp_nordahl_script = "Script"
Nord_language.la_dnphys1 = "Maksimal mengde sekunder for å precalculate kollisjoner med objekter."
Nord_language.la_dnphys2 = "Maksimal mengde sekunder for å precalculate kollisjoner med verden."
Nord_language.la_dnphys3 = "Maksimal rotasjonshastighet."
Nord_language.la_dnphys4 = "Maksimalt antall kollisjonskontroller per tick."
Nord_language.la_dnphys5 = "Maksimal kollisjon per objekt per tick."
Nord_language.la_dnphys6 = "Maksimal massen til et objekt som skal påvirkes av friksjon."
Nord_language.la_dnphys7 = "Maksimal hastighet på et objekt."
Nord_language.la_dnphys8 = "Minimum massen til et objekt som skal påvirkes av friksjon."
Nord_language.la_dnphys9 = "Setter lufttetthet."
Nord_language.la_dnphys10 = "Setter tyngdekraften, (For de elementer)."
Nord_language.la_dnphys11 = "Setter tyngdekraften, (For spillerne)."
end
function languesacsro(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
Nord_language.la_ttles = "Fiecare"
Nord_language.la_tousles = "Fiecare"
Nord_language.la_secondes = "secunde"
Nord_language.la_minutes = "minute"
Nord_language.la_heure = "oră"
Nord_language.la_heures = "ore"
Nord_language.la_jours = "zile"
Nord_language.la_porletest = "pentru testele"
Nord_language.la_nomm = "Nume"
Nord_language.la_sacs_ongl1 = "Pe server"
Nord_language.la_sacs_ongl1aid = "Entitățile care pe server."
Nord_language.la_sacs_ongl2 = "Căutare"
Nord_language.la_sacs_ongl2aid = "Sistem de căutare complet pentru sacs, ABCs Lista și entitățile de server"
Nord_language.la_sacs_ongl3 = "Lista lui S.A.C.S"
Nord_language.la_sacs_ongl3aid = "The S.A.C.S vă permite să ștergeți automat obiectele care sunt pe server pentru ceva timp"
Nord_language.la_sacs_ongl4 = "Lista lui A.B.C.S"
Nord_language.la_sacs_ongl4aid = "Boot Optimizer vă permite să ștergeți toate entitățile pe care nu le doriți când pornește serverul."
Nord_language.la_sacs_ongl5 = "Opțiuni"
Nord_language.la_sacs_ongl5aid = "Opțiuni sacs lui"
Nord_language.la_sacs_ongl6 = "Tools"
Nord_language.la_sacs_ongl6aid = "Accesul la instrumente de săculeții lui"
Nord_language.la_sacs_ongl11 = "Entitățile de pe server"
Nord_language.la_sacs_ongl12 = "Poziția entităților"
Nord_language.la_sacs_ongl13 = "Distanța în metri"
Nord_language.la_sacs_ongl00 = "Numele entității"
Nord_language.la_sacs_onglb1 = "Căutare entități"
Nord_language.la_sacs_onglb2 = "Căutare în A.B.C.S"
Nord_language.la_sacs_onglb3 = "Caută în S.A.C.S"
Nord_language.la_sacs_ongl2341 = "numele entităților"
Nord_language.la_sacs_ongl22 = "Adaugata de la distanță sau de către entitate"
Nord_language.la_sacs_ajpar = "Adăugat de"
Nord_language.la_sacs_onglb31 = "Adăugați în lista"
Nord_language.la_sacs_onglb41 = "Adăugați în lista"
Nord_language.la_sacs_ajentsyst = "Adăugați clasa de această entitate în sistem"
Nord_language.la_sacs_supprimer = "Șterge"
Nord_language.la_sacs_supprimer1 = "Sterge aceasta"
Nord_language.la_sacs_supprimer2 = "Șterge toate"
Nord_language.la_sacs_tpmoi = "Du-mă la această entitate"
Nord_language.la_sacs_copieentcl = "Copiază clasa (Ctrl + V pentru a lipi)"
Nord_language.la_sacs_reglcolor = "Culoare această clasă (Pentru instrumentul AdminEyes)"
Nord_language.la_sacs_blanc = "alb"
Nord_language.la_sacs_noir = "negru"
Nord_language.la_sacs_bleu = "Blue"
Nord_language.la_sacs_orange = "Orange"
Nord_language.la_sacs_rose = "roz"
Nord_language.la_sacs_violet = "Violet"
Nord_language.la_sacs_rouge = "Red"
Nord_language.la_sacs_jaune = "Yellow"
Nord_language.la_sacs_vert = "verde"
Nord_language.la_sacs_invisible = "invizibil"
Nord_language.la_sacs_options1 = "(Activare / Dezactivare) (Sistemul inteligent Cleaner Automat) S.A.C.S:"
Nord_language.la_sacs_options2 = "Setează ciclul de timp al S.A.C.S, În prezent, ciclul este setat pe:"
Nord_language.la_sacs_options3 = "(Activare / Dezactivare) La A.B.C.S. (Automatic Boot Optimizer):"
Nord_language.la_sacs_options4 = "curata manual toate grupurile entităților de pe lista lui S.A.C.S:"
Nord_language.la_sacs_options5 = "curata manual toate grupurile entităților de pe lista lui A.B.C.S:"
Nord_language.la_sacs_options6 = "Notă: Toate entitățile din lista S.A.C.S va fi curățat în mod automat."
Nord_language.la_sacs_options7 = "Sistemul va continua să funcționeze automat când restarta dacă este activat."
Nord_language.la_sacs_options8 = "Dacă obiectul tocmai a dat naștere, acesta va vom șters în bucla următoare."
Nord_language.la_sacs_options9 = "The A.B.C.S vă permite să ștergeți automat ceea ce nu doriți pe hartă de pe repornire."
Nord_language.la_sacs_options10 = "Activează Admin-Eyes pentru a avea un ochi pe server și atunci când lucrați."
Nord_language.la_sacs_options11 = "Ștergeți ce instrumente comune nu se poate face fără acest sistem."
Nord_language.la_sacs_manuelcleana = "Curățire, deoarece lista de entități"
Nord_language.la_sacs_manuelcleanb = "Curățire, deoarece lista de entități"
Nord_language.la_sacs_outil1 = "(Activare / Dezactivare) Adminul-Eyes, pentru a vedea toate entitățile de pe hartă:"
Nord_language.la_sacs_outil2 = "A se vedea Jucători"
Nord_language.la_sacs_outil3 = "A se vedea NPC-urile"
Nord_language.la_sacs_entre = "Vous n'étiez pas admin en rejoingnant le serveur, reconnecté Vous pour les obtenir d'permettant informațiile Vous Acceder au Système S.A.C.S."
Nord_language.la_scrp_nordahl_credit = "Made by Nordahl"
Nord_language.la_scrp_nordahl_note = "Examinați acest script"
Nord_language.la_scrp_nordahl_script = "Script"
Nord_language.la_dnphys1 = "Cantitatea maximă de secunde până la precalculate coliziuni cu obiecte."
Nord_language.la_dnphys2 = "Cantitatea maximă de secunde până la precalculate coliziuni cu lumea."
Nord_language.la_dnphys3 = "viteza maximă de rotație."
Nord_language.la_dnphys4 = "controale de coliziune maxime per căpușă."
Nord_language.la_dnphys5 = "coliziune maximă pentru fiecare obiect pe bilet."
Nord_language.la_dnphys6 = "Masa maximă a unui obiect care urmează să fie afectat de frecare."
Nord_language.la_dnphys7 = "Viteza maximă a unui obiect."
Nord_language.la_dnphys8 = "Masa minimă a unui obiect care urmează să fie afectat de frecare."
Nord_language.la_dnphys9 = "Setează densitatea aerului."
Nord_language.la_dnphys10 = "Setează gravitatea, (Pentru elementele)."
Nord_language.la_dnphys11 = "Setează gravitatea, (Pentru jucătorii)."
end
function languesacssv(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
Nord_language.la_ttles = "Varje"
Nord_language.la_tousles = "Varje"
Nord_language.la_secondes = "sekunder"
Nord_language.la_minutes = "minuter"
Nord_language.la_heure = "timme"
Nord_language.la_heures = "timmar"
Nord_language.la_jours = "dagar"
Nord_language.la_porletest = "för testen"
Nord_language.la_nomm = "Namn"
Nord_language.la_sacs_ongl1 = "På servern"
Nord_language.la_sacs_ongl1aid = "enheter på din server."
Nord_language.la_sacs_ongl2 = "Sök"
Nord_language.la_sacs_ongl2aid = "Komplett söksystem för SACS, ABCS lista och server enheter"
Nord_language.la_sacs_ongl3 = "S.A.C.S List"
Nord_language.la_sacs_ongl3aid = "The S.A.C.S kan du radera automatiskt de objekt som finns på din server för en viss tid"
Nord_language.la_sacs_ongl4 = "A.B.C.S List"
Nord_language.la_sacs_ongl4aid = "The Boot Optimizer kan du ta bort alla enheter som du inte vill när servern startar."
Nord_language.la_sacs_ongl5 = "Alternativ"
Nord_language.la_sacs_ongl5aid = "SACS s alternativ"
Nord_language.la_sacs_ongl6 = "Verktyg"
Nord_language.la_sacs_ongl6aid = "Tillgång till SACS verktyg"
Nord_language.la_sacs_ongl11 = "Enheter på servern"
Nord_language.la_sacs_ongl12 = "Enheter positionen"
Nord_language.la_sacs_ongl13 = "Avstånd i meter"
Nord_language.la_sacs_ongl00 = "Entity namn"
Nord_language.la_sacs_onglb1 = "Sök enheter"
Nord_language.la_sacs_onglb2 = "Sök i A.B.C.S"
Nord_language.la_sacs_onglb3 = "Sök i S.A.C.S"
Nord_language.la_sacs_ongl2341 = "Enheter namnet"
Nord_language.la_sacs_ongl22 = "Inlagd av eller Entity avstånd"
Nord_language.la_sacs_ajpar = "Inlagd av"
Nord_language.la_sacs_onglb31 = "Lägg i listan"
Nord_language.la_sacs_onglb41 = "Lägg i listan"
Nord_language.la_sacs_ajentsyst = "Lägg till den här enhetens klass i systemet"
Nord_language.la_sacs_supprimer = "Delete"
Nord_language.la_sacs_supprimer1 = "Ta bort en"
Nord_language.la_sacs_supprimer2 = "Ta bort alla av dem"
Nord_language.la_sacs_tpmoi = "Ta mig till denna enhet"
Nord_language.la_sacs_copieentcl = "Kopiera klassen (Ctrl + V för att klistra)"
Nord_language.la_sacs_reglcolor = "Color denna klass (För AdminEyes verktyget)"
Nord_language.la_sacs_blanc = "White"
Nord_language.la_sacs_noir = "Black"
Nord_language.la_sacs_bleu = "Blue"
Nord_language.la_sacs_orange = "Orange"
Nord_language.la_sacs_rose = "Pink"
Nord_language.la_sacs_violet = "Purple"
Nord_language.la_sacs_rouge = "Röd"
Nord_language.la_sacs_jaune = "Yellow"
Nord_language.la_sacs_vert = "Green"
Nord_language.la_sacs_invisible = "Invisible"
Nord_language.la_sacs_options1 = "(Aktivera / Inaktivera) den S.A.C.S (smart Automatisk Cleaner System):"
Nord_language.la_sacs_options2 = "Ställ in tidscykel för S.A.C.S, närvarande, cykeln är inställd på"
Nord_language.la_sacs_options3 = "(Aktivera / Inaktivera) Den A.B.C.S. (Automatic Boot Optimizer):"
Nord_language.la_sacs_options4 = "manuellt rensa alla enheter grupper på S.A.C.S lista:"
Nord_language.la_sacs_options5 = "manuellt rensa alla enheter grupper på A.B.C.S lista:"
Nord_language.la_sacs_options6 = "Obs: Alla enheter i S.A.C.S lista automatiskt rensas."
Nord_language.la_sacs_options7 = "Systemet kommer att fortsätta att fungera automatiskt när omstart om den är aktiverad."
Nord_language.la_sacs_options8 = "Om objektet bara gett upphov till, kommer det vi bort i nästa båge."
Nord_language.la_sacs_options9 = "The A.B.C.S tillåter dig att radera automatiskt vad du inte vill ha på kartan på omstart."
Nord_language.la_sacs_options10 = "Aktivera Admin-Eyes att ha ett öga på servern och när du arbetar."
Nord_language.la_sacs_options11 = "Stryk det gemensamma verktyg inte kan göra utan detta system."
Nord_language.la_sacs_manuelcleana = "Cleanup eftersom listan enheter"
Nord_language.la_sacs_manuelcleanb = "Cleanup eftersom listan enheter"
Nord_language.la_sacs_outil1 = "(Aktivera / Inaktivera) Admin-Eyes, att se alla enheter på kartan:"
Nord_language.la_sacs_outil2 = "se spelarna"
Nord_language.la_sacs_outil3 = "Se NPC"
Nord_language.la_sacs_entre = "Vous n'étiez pas admin sv rejoingnant le serveur, reconnecté vous pour obtenir les information vous permettant d'Acceder au système S.A.C.S."
Nord_language.la_scrp_nordahl_credit = "Made by Nordahl"
Nord_language.la_scrp_nordahl_note = "Recensera detta script"
Nord_language.la_scrp_nordahl_script = "Script"
Nord_language.la_dnphys1 = "Maximalt antal sekunder till precalculate kollisioner med föremål."
Nord_language.la_dnphys2 = "Maximalt antal sekunder till precalculate kollisioner med världen."
Nord_language.la_dnphys3 = "Maximal rotationshastighet."
Nord_language.la_dnphys4 = "Max kollisionskontroller per fästing."
Nord_language.la_dnphys5 = "Maximal kollision per objekt per fästing."
Nord_language.la_dnphys6 = "högsta vikt av ett föremål som skall påverkas av friktion."
Nord_language.la_dnphys7 = "Maximal hastighet av ett objekt."
Nord_language.la_dnphys8 = "Minsta massa hos ett föremål som påverkas av friktion."
Nord_language.la_dnphys9 = "Ställer in lufttätheten."
Nord_language.la_dnphys10 = "Ställer allvar, (För punkter)."
Nord_language.la_dnphys11 = "Ställer allvar, (För spelare)."
end
function languesacstr(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
Nord_language.la_ttles = "Her"
Nord_language.la_tousles = "Her"
Nord_language.la_secondes = "saniye"
Nord_language.la_minutes = "dakika"
Nord_language.la_heure = "saat"
Nord_language.la_heures = "saat"
Nord_language.la_jours = "günler"
Nord_language.la_porletest = "testleri için"
Nord_language.la_nomm = "Ad"
Nord_language.la_sacs_ongl1 = "sunucu üzerinde"
Nord_language.la_sacs_ongl1aid = "sunucu üzerinde Entities."
Nord_language.la_sacs_ongl2 = "Ara"
Nord_language.la_sacs_ongl2aid = "SACS, ABC'Sİ Listesi ve sunucu varlıklar için komple arama sistemi"
Nord_language.la_sacs_ongl3 = "S.A.C.S Listesi"
Nord_language.la_sacs_ongl3aid = "S.A.C.S Eğer bir süre için sunucuda bulunan nesneleri otomatik olarak silmek için izin verir"
Nord_language.la_sacs_ongl4 = "A.B.C.S Listesi"
Nord_language.la_sacs_ongl4aid = "Önyükleme Cleaner sunucu başladığında istemediğiniz tüm varlıkları silmenize olanak verir."
Nord_language.la_sacs_ongl5 = "Seçenekler"
Nord_language.la_sacs_ongl5aid = "keseler Seçenekler"
Nord_language.la_sacs_ongl6 = "Araçlar"
Nord_language.la_sacs_ongl6aid = "keselerinin en araçlarına erişim"
Nord_language.la_sacs_ongl11 = "sunucu üzerinde varlıkları"
Nord_language.la_sacs_ongl12 = "Varlıkları pozisyon"
Nord_language.la_sacs_ongl13 = "metre uzaklık"
Nord_language.la_sacs_ongl00 = "İdarenin adı"
Nord_language.la_sacs_onglb1 = "varlıkları Ara"
Nord_language.la_sacs_onglb2 = "A.B.C.S arama yap"
Nord_language.la_sacs_onglb3 = "S.A.C.S Arama"
Nord_language.la_sacs_ongl2341 = "Varlıkları adı"
Nord_language.la_sacs_ongl22 = "veya Teşekkülün mesafeye tarafından eklendi"
Nord_language.la_sacs_ajpar = "tarafından eklendi"
Nord_language.la_sacs_onglb31 = "listesinde Ekle"
Nord_language.la_sacs_onglb41 = "listesinde Ekle"
Nord_language.la_sacs_ajentsyst = "sisteminde bu işletmenin sınıfı Ekle"
Nord_language.la_sacs_supprimer = "Sil"
Nord_language.la_sacs_supprimer1 = "Bu bir sil"
Nord_language.la_sacs_supprimer2 = "hepsini sil"
Nord_language.la_sacs_tpmoi = "Bu varlık götür"
Nord_language.la_sacs_copieentcl = "class kopyalayın (Ctrl + V yapıştırmak için)"
Nord_language.la_sacs_reglcolor = "Renk (AdminEyes aracı için) bu sınıf"
Nord_language.la_sacs_blanc = "Beyaz"
Nord_language.la_sacs_noir = "Siyah"
Nord_language.la_sacs_bleu = "Mavi"
Nord_language.la_sacs_orange = "Turuncu"
Nord_language.la_sacs_rose = "Pembe"
Nord_language.la_sacs_violet = "Mor"
Nord_language.la_sacs_rouge = "Kırmızı"
Nord_language.la_sacs_jaune = "Sarı"
Nord_language.la_sacs_vert = "Yeşil"
Nord_language.la_sacs_invisible = "Görünmez"
Nord_language.la_sacs_options1 = "(Etkinleştir / devre dışı bırak) S.A.C.S (Akıllı Otomatik Temizleyici Sistemi):"
Nord_language.la_sacs_options2 = "S.A.C.S zaman döngüsünü ayarlayın, şu anda çevrim ayarlanır:"
Nord_language.la_sacs_options3 = "(Etkinleştir / devre dışı bırak) A.B.C.S. (Otomatik Boot Temizleyici):"
Nord_language.la_sacs_options4 = "S.A.C.S listesinde el ile temizleme tüm varlıkların grupları:"
Nord_language.la_sacs_options5 = "A.B.C.S listesinde el ile temizleme tüm varlıkların grupları:"
Nord_language.la_sacs_options6 = "Not: S.A.C.S listesinde tüm varlıklar otomatik olarak temizlenir."
Nord_language.la_sacs_options7 = "Sistem aktive eğer yeniden başlatırken otomatik olarak çalışmaya devam edeceğiz."
Nord_language.la_sacs_options8 = "nesne sadece olurken, bu önümüzdeki döngü içinde silinen olacak."
Nord_language.la_sacs_options9 = "A.B.C.S size yeniden başlatma harita üzerinde ne istemiyorum otomatik silmenize olanak verir."
Nord_language.la_sacs_options10 = "sunucu ve ne zaman işe bir göz var İdare-Eyes etkinleştirin."
Nord_language.la_sacs_options11 = "ortak araçlar bu sistem olmadan yapamaz neler silin."
Nord_language.la_sacs_manuelcleana = "kişiler listesi beri Temizleme"
Nord_language.la_sacs_manuelcleanb = "kişiler listesi beri Temizleme"
Nord_language.la_sacs_outil1 = "(Etkinleştir / devre dışı bırak) İdare-Eyes, harita üzerinde tüm varlıkları görmek için:"
Nord_language.la_sacs_outil2 = "Oyuncular Bkz:"
Nord_language.la_sacs_outil3 = "NPC görün"
Nord_language.la_sacs_entre = "Vous n'étiez pas yönetici tr rejoingnant le serveur, reconnecté pour vous obtenir les bilgiler vous permettant d'accéder au système S.A.C.S."
Nord_language.la_scrp_nordahl_credit = "Nordahl tarafından yapılmıştır"
Nord_language.la_scrp_nordahl_note = "Bu komut gözden"
Nord_language.la_scrp_nordahl_script = "Senaryo"
Nord_language.la_dnphys1 = "saniye azami tutar nesnelerle çarpışmaları hesapladıkları için."
Nord_language.la_dnphys2 = "saniye azami tutar dünya ile çarpışmaları hesapladıkları için."
Nord_language.la_dnphys3 = "Maksimum dönme hızı."
Nord_language.la_dnphys4 = "tick başına maksimum çarpışma denetler."
Nord_language.la_dnphys5 = "tick başına nesne başına maksimum çarpışma."
Nord_language.la_dnphys6 = "bir nesnenin maksimum kütlesi sürtünme etkilenmesi."
Nord_language.la_dnphys7 = "bir nesnenin maksimum hız."
Nord_language.la_dnphys8 = "bir nesnenin minimum kütle sürtünme etkilenmesi."
Nord_language.la_dnphys9 = "hava yoğunluğunu ayarlar."
Nord_language.la_dnphys10 = "(öğeler için) yerçekimi, ayarlar."
Nord_language.la_dnphys11 = "(oyuncu için) yerçekimi, ayarlar."
end
if Z_Defaut_Languages==1 then
languesacsfr(1)
elseif Z_Defaut_Languages==2 then
languesacsen(2)
elseif Z_Defaut_Languages==3 then
languesacses(3)
elseif Z_Defaut_Languages==4 then
languesacsdu(4)
elseif Z_Defaut_Languages==5 then
languesacsru(5)
elseif Z_Defaut_Languages==6 then
languesacsel(6)
elseif Z_Defaut_Languages==7 then
languesacspt(7)
elseif Z_Defaut_Languages==8 then
languesacspl(8)
elseif Z_Defaut_Languages==9 then
languesacsit(9)
elseif Z_Defaut_Languages==10 then
languesacsbg(10)
elseif Z_Defaut_Languages==11 then
languesacscs(11)
elseif Z_Defaut_Languages==12 then
languesacset(12)
elseif Z_Defaut_Languages==13 then
languesacsfi(13)
elseif Z_Defaut_Languages==14 then
languesacsja(14)
elseif Z_Defaut_Languages==15 then
languesacsko(15)
elseif Z_Defaut_Languages==16 then
languesacslv(16)
elseif Z_Defaut_Languages==17 then
languesacsno(17)
elseif Z_Defaut_Languages==18 then
languesacsro(18)
elseif Z_Defaut_Languages==19 then
languesacssv(19)
elseif Z_Defaut_Languages==20 then
languesacstr(20)
else
languesacsen(2)
end

SACS.Commands = {}
SACS.Tabs = {}
function SACS.RegisterCommand( name, commandname, chatcmd, args, override )
table.insert( SACS.Commands, { Name = name, CommandName = commandname, ChatCmd = chatcmd, Args = args, ArgOverride = override } )
end
function SACS.AddMenuTab( name, icon, desc, panelfunc, func )
table.insert( SACS.Tabs, { Name = name, PanelFunc = panelfunc, Icon = icon, Desc = desc, Func = func } )
end
function SACS.Menu( ply, cmd, args )
if i_Droit(LocalPlayer())==false then print("S.A.C.S System: You are not admin.") return end
surface.PlaySound("ambient/machines/keyboard1_clicks.wav")
local Menu = vgui.Create("DFrame")
Menu:SetSize(700,500)
Menu:SetPos(ScrW()/2-Menu:GetWide()/2,ScrH()/2-Menu:GetTall()/2)
Menu:SetTitle(" ")
Menu:SetDraggable(true)
Menu:ShowCloseButton(false)
Menu:MakePopup()
Menu.Paint=function()
draw.RoundedBox(6,0,0,Menu:GetWide(),Menu:GetTall(),Color(0,117,223,255))
draw.RoundedBox(6,1,1,Menu:GetWide()-2,Menu:GetTall()-2,Color(0,0,0,255))
draw.RoundedBox(1,1,1,Menu:GetWide()-2,5,Color(0,117,223,100))
surface.SetDrawColor( 255,255,255, 255 ) 
surface.SetMaterial(Material("ngui/sacs.png"))surface.DrawTexturedRect(5,5,16,16)
draw.SimpleText("Smart Automatic Cleaner System "..sacsver.." + Boot Optimizer + P.E.M", "Trebuchet18", 25, 13, Color(0,130,200), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color(0,0,100,255))
end
local Text = vgui.Create("DLabel",Menu)
Text:SetText("")
Text:SizeToContents()
Text:SetPos(10,100)
Text:SetSize(800,40)
Text:SetFont("Trebuchet24")
local button=vgui.Create("DButton",Menu)button:SetText("")button:SetSize(16,16)
button.Paint=function()draw.RoundedBox(8,0,0,button:GetWide(),button:GetTall(),Color(0,0,0,0))
end
button:SetPos(Menu:GetWide()-23-21,5)local zmodcm=vgui.Create("DImage",Menu)zmodcm:SetImage("icon16/Wrench.png")zmodcm:SetSize(16,16)zmodcm:SetPos(Menu:GetWide()-23-21,5)button.DoClick=function()surface.PlaySound("ambient/machines/keyboard5_clicks.wav")
local z4=DermaMenu()
local subMenu,optMenu=z4:AddSubMenu("Languages")
optMenu:SetIcon("icon16/world.png")
local flche=""
if Z_Defaut_Languages==1 then flche=puce else flche="" end
subMenu:AddOption(flche.."Français",function()file.Write("nordahlclient_option/language.txt","1")languesacsfr(1)Menu:Close()SACS.Menu(ply)end):SetImage("ngui/la/fr.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==2 then flche=puce else flche="" end 
subMenu:AddOption(flche.."English",function()file.Write("nordahlclient_option/language.txt","2")languesacsen(2)Menu:Close()SACS.Menu(ply)end):SetImage("ngui/la/en.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==3 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Español",function()file.Write("nordahlclient_option/language.txt","3")languesacses(3)Menu:Close()SACS.Menu(ply)end):SetImage("ngui/la/es.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==4 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Deutsch",function()file.Write("nordahlclient_option/language.txt","4")languesacsdu(4)Menu:Close()SACS.Menu(ply)end):SetImage("ngui/la/de.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==5 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Russian",function()file.Write("nordahlclient_option/language.txt","5")languesacsru(5)Menu:Close()SACS.Menu(ply)end):SetImage("ngui/la/ru.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==6 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Greek",function()file.Write("nordahlclient_option/language.txt","6")languesacsel(6)Menu:Close()SACS.Menu(ply)end):SetImage("ngui/la/el.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==7 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Portuguese",function()file.Write("nordahlclient_option/language.txt","7")languesacspt(7)Menu:Close()SACS.Menu(ply)end):SetImage("ngui/la/pt.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==8 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Polish",function()file.Write("nordahlclient_option/language.txt","8")languesacspl(8)Menu:Close()SACS.Menu(ply)end):SetImage("ngui/la/pl.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==9 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Italian",function()file.Write("nordahlclient_option/language.txt","9")languesacsit(9)Menu:Close()SACS.Menu(ply)end):SetImage("ngui/la/it.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==10 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Bulgarian",function()file.Write("nordahlclient_option/language.txt","10")languesacsbg(10)Menu:Close()SACS.Menu(ply)end):SetImage("ngui/la/bg.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==11 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Czech",function()file.Write("nordahlclient_option/language.txt","11")languesacscs(11)Menu:Close()SACS.Menu(ply)end):SetImage("ngui/la/cs.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==12 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Estonian",function()file.Write("nordahlclient_option/language.txt","12")languesacset(12)Menu:Close()SACS.Menu(ply)end):SetImage("ngui/la/et.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==13 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Finnish",function()file.Write("nordahlclient_option/language.txt","13")languesacsfi(13)Menu:Close()SACS.Menu(ply)end):SetImage("ngui/la/fi.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==14 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Japanese",function()file.Write("nordahlclient_option/language.txt","14")languesacsja(14)Menu:Close()SACS.Menu(ply)end):SetImage("ngui/la/ja.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==15 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Korean",function()file.Write("nordahlclient_option/language.txt","15")languesacsko(15)Menu:Close()SACS.Menu(ply)end):SetImage("ngui/la/ko.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==16 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Latvian",function()file.Write("nordahlclient_option/language.txt","16")languesacslv(16)Menu:Close()SACS.Menu(ply)end):SetImage("ngui/la/lv.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==17 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Norwegian",function()file.Write("nordahlclient_option/language.txt","17")languesacsno(17)Menu:Close()SACS.Menu(ply)end):SetImage("ngui/la/no.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==18 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Romanian",function()file.Write("nordahlclient_option/language.txt","18")languesacsro(18)Menu:Close()SACS.Menu(ply)end):SetImage("ngui/la/ro.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==19 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Swedish",function()file.Write("nordahlclient_option/language.txt","19")languesacssv(19)Menu:Close()SACS.Menu(ply)end):SetImage("ngui/la/sv.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==20 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Turkish",function()file.Write("nordahlclient_option/language.txt","20")languesacstr(20)Menu:Close()SACS.Menu(ply)end):SetImage("ngui/la/tr.png")
subMenu.Paint=function()draw.RoundedBox(4,0,0,subMenu:GetWide(),subMenu:GetTall(),Color(0,117,223,255))
draw.RoundedBox(4,1,1,subMenu:GetWide()-2,subMenu:GetTall()-2,Color(255,255,255,255))end
z4:AddSpacer()

z4:AddSpacer()
local subMenu,optMenu=z4:AddSubMenu(Nord_language.la_scrp_nordahl_script)
optMenu:SetIcon("icon16/wand.png")
subMenu:AddOption(Nord_language.la_scrp_nordahl_credit,function()gui.OpenURL("https://originahl-scripts.com/profiles/76561198033784269") end):SetImage("ngui/nordahl.png")
subMenu:AddSpacer()
subMenu:AddOption(Nord_language.la_scrp_nordahl_note.." :)",function()gui.OpenURL("https://originahl-scripts.com/gmod-scripts/1379/reviews-page-1") end)
subMenu:AddSpacer()
subMenu:AddOption("Workshop Content",function()gui.OpenURL("http://steamcommunity.com/sharedfiles/filedetails/?id=493897275") end)


subMenu.Paint=function()draw.RoundedBox(4,0,0,subMenu:GetWide(),subMenu:GetTall(),Color(0,117,223,255))
draw.RoundedBox(4,1,1,subMenu:GetWide()-2,subMenu:GetTall()-2,Color(255,255,255,255))end
z4.Paint=function()draw.RoundedBox(4,0,0,z4:GetWide(),z4:GetTall(),Color(0,117,223,255))
draw.RoundedBox(4,1,1,z4:GetWide()-2,z4:GetTall()-2,Color(255,255,255,255))end
z4:Open()





end

local button=vgui.Create("DButton",Menu)
button:SetText("")
button:SetSize(16,16)
button:SetPos(Menu:GetWide()-23,5)
button.Paint=function()draw.RoundedBox(8,0,0,0,0,Color(0,0,0,0))
end
local zmodcm=vgui.Create("DImage",Menu)
zmodcm:SetImage("icon16/cross.png")
zmodcm:SetSize(16,16)
zmodcm:SetPos(Menu:GetWide()-23,5)
button.DoClick=function()
surface.PlaySound("ambient/machines/keyboard5_clicks.wav")
Menu:Close()
end
local button=vgui.Create("DButton",Menu)
button:SetText("")
button:SetSize(16,16)
button:SetPos(Menu:GetWide()-23-21-21,5)
button.Paint=function()draw.RoundedBox(8,0,0,0,0,Color(0,0,0,0))
end
local zmodcm=vgui.Create("DImage",Menu)
zmodcm:SetImage("icon16/arrow_refresh.png")
zmodcm:SetSize(16,16)
zmodcm:SetPos(Menu:GetWide()-23-21-21,5)
button.DoClick=function()
surface.PlaySound("ambient/machines/keyboard5_clicks.wav")
Menu:Close()
SACS.Menu(ply)
end



if i_Droit(ply)==false then return end
local xsize = 600
local ysize = 500
local entite = {}
local list = vgui.Create( "DPropertySheet", Menu )
local MenuGetWide=Menu:GetWide()-9
local MenuGetTall=Menu:GetTall()-30
list.Paint=function()
draw.RoundedBox(6,0,20,MenuGetWide,MenuGetTall-20,Color(0,0,0,255))draw.RoundedBox(6,1,21,MenuGetWide-2,MenuGetTall-22,Color(0,117,223,255))draw.RoundedBox(0,0,20,16,16,Color(0,0,0,255))draw.RoundedBox(0,1,21,18,18,Color(0,117,223,255))
end
list:StretchToParent( 4, 24, 4, 4 )
local dpanel = vgui.Create( "DPanel" )
dpanel.InvalidateLayout = function()
if dpanel.Butan then
dpanel.Butan:SetPos( 60, 7 )
dpanel.List:StretchToParent( 1, 1, 1, 1 )
end
end
dpanel.Paint=function()draw.RoundedBox(0,0,0,ScrW()-24,ScrH()-65,Color(0,0,0,255))
end
local listview = vgui.Create( "DListView", dpanel )
listview.Paint=function()draw.RoundedBox(8,0,0,listview:GetWide(),listview:GetTall(),Color(255,255,255,255))
end
col1 = listview:AddColumn(Nord_language.la_sacs_ongl11)
col1:SetMinWidth( 150 )
col3=listview:AddColumn(Nord_language.la_sacs_ongl12)
col3:SetMinWidth( 150 )
col4=listview:AddColumn(Nord_language.la_sacs_ongl13)
col4:SetMinWidth( 50 )
local butan = vgui.Create( "DButton", dpanel )
butan:SetText("")
butan:SetWide( 1 )
butan.Paint=function()draw.RoundedBox(8,0,0,0,0,Color(0,0,0,255))
end
butan.DoClick = function()

end
dpanel.Butan = butan
dpanel.List = listview
dpanel:InvalidateLayout()
list:AddSheet(Nord_language.la_sacs_ongl1, dpanel, "icon16/book_next.png", false, false,Nord_language.la_sacs_ongl1aid)
for k,v in pairs( SACS.Tabs ) do
local tabpnl = v.PanelFunc()
list:AddSheet( v.Name, tabpnl, v.Icon, false, false, v.Desc )
if v.Func then
v.Func( tabpnl )
end
end

for k,v in pairs( ents.GetAll() ) do
local pos = v:GetPos()
local longueur = LocalPlayer():GetPos():Distance( pos )
local longueur=longueur/10
local longueur2=255-longueur
local longueur3=math.Round(longueur/5)
if v:GetClass()!="worldspawn" then

if (v:GetClass()!="player" and v:GetOwner()!=LocalPlayer() and v:GetClass()!="viewmodel" and v:GetClass()!="viewmodel" and v:GetClass()!="class C_BaseEntity") then 
listview:AddLine( v:GetClass(), tostring(v:GetPos()),longueur3)
table.insert( entite, v )
end

end
end
listview.OnRowRightClick = function( pnl, id, line )
local menu = vgui.Create( "DMenu", panel )
-- if !IsValid(ent) then
-- submenu:AddOption("[*] This entity does not exist. Refresh the interface", function()end)
-- submenu.Paint=function()draw.RoundedBox(4,0,0,submenu:GetWide(),submenu:GetTall(),Color(0,0,0,255))
-- draw.RoundedBox(4,1,1,submenu:GetWide()-2,submenu:GetTall()-2,Color(255,0,0,255))
-- end
-- menu:Open()
-- else
-- end

local ent = entite[id]
local submenu,optMenu = menu:AddSubMenu(Nord_language.la_sacs_ongl3)
optMenu:SetIcon("ngui/sacs.png")

submenu:AddOption(Nord_language.la_sacs_ajentsyst.." S.A.C.S", function()
RunConsoleCommand("zmoda_addsacsl",ent:GetClass(),LocalPlayer():Nick())
LocalPlayer():EmitSound("ui/buttonclick.wav",100,200)
end):SetImage("ngui/sacs.png")

menu:AddSpacer()
menu.Paint=function()draw.RoundedBox(4,0,0,menu:GetWide(),menu:GetTall(),Color(0,117,223,255))
draw.RoundedBox(4,1,1,menu:GetWide()-2,menu:GetTall()-2,Color(255,255,255,255))
end
submenu.Paint=function()draw.RoundedBox(4,0,0,submenu:GetWide(),submenu:GetTall(),Color(0,117,223,255))
draw.RoundedBox(4,1,1,submenu:GetWide()-2,submenu:GetTall()-2,Color(255,255,255,255))
end
local submenu,optMenu = menu:AddSubMenu(Nord_language.la_sacs_ongl4)
optMenu:SetIcon("ngui/abcs.png")
submenu:AddOption("A.B.C.S: Only Remove this one when Server reboot", function()
RunConsoleCommand("zmoda_addabcu2",ent:EntIndex(),LocalPlayer():Nick())
LocalPlayer():EmitSound("ui/buttonclick.wav",100,200)
end):SetImage("ngui/abcs.png")
submenu:AddSpacer()
submenu:AddOption("A.B.C.S: Global Remove the entities with this class when Server reboot", function()
RunConsoleCommand("zmoda_addabcul",ent:GetClass(),LocalPlayer():Nick())
LocalPlayer():EmitSound("ui/buttonclick.wav",100,200)
end):SetImage("ngui/abcs.png")

submenu:AddSpacer()
submenu.Paint=function()draw.RoundedBox(4,0,0,submenu:GetWide(),submenu:GetTall(),Color(0,117,223,255))
draw.RoundedBox(4,1,1,submenu:GetWide()-2,submenu:GetTall()-2,Color(255,255,255,255))
end
menu:AddSpacer()
local subMenu,optMenu=menu:AddSubMenu(Nord_language.la_sacs_supprimer..": '"..ent:GetClass().."'")menu:AddSpacer()
optMenu:SetIcon("icon16/bin.png")
subMenu.Paint=function()draw.RoundedBox(4,0,0,subMenu:GetWide(),subMenu:GetTall(),Color(0,117,223,255))
draw.RoundedBox(4,1,1,subMenu:GetWide()-2,subMenu:GetTall()-2,Color(255,255,255,255))
end
subMenu:AddOption(Nord_language.la_sacs_supprimer1,function()RunConsoleCommand("sacsentrem",ent:GetClass(),line:GetColumnText(3))end):SetImage("icon16/bin.png")subMenu:AddSpacer()
subMenu:AddOption(Nord_language.la_sacs_supprimer2,function()RunConsoleCommand("sacs_removeent",ent:GetClass())LocalPlayer():EmitSound("ui/buttonclick.wav",100,200)end):SetImage("icon16/bin.png")subMenu:AddSpacer()
local subMenu,optMenu=menu:AddSubMenu(Nord_language.la_sacs_reglcolor)
optMenu:SetIcon("icon16/rainbow.png") --color_swatch --palette
function reglecoul(Gnom,coul)
for _,c in ipairs(ents.FindByClass(Gnom))do
if coul==0 then
c.sacscol=nil
elseif coul==1 then
c.sacscol=Color(0,0,0,175)
elseif coul==2 then
c.sacscol=Color(0,0,204,175)
elseif coul==3 then
c.sacscol=Color(204,102,0,175)
elseif coul==4 then
c.sacscol=Color(204,0,204,175)
elseif coul==5 then
c.sacscol=Color(102,0,204,175)
elseif coul==6 then
c.sacscol=Color(0,255,0,175)
elseif coul==7 then
c.sacscol=Color(204,204,0,175)
elseif coul==8 then
c.sacscol=Color(0,204,0,175)
elseif coul==9 then
c.sacscol=Color(0,0,0,0)
end
end
end
subMenu:AddOption(Nord_language.la_sacs_blanc,function()reglecoul(ent:GetClass(),0) end):SetImage("icon16/bullet_white.png")subMenu:AddSpacer()
subMenu:AddOption(Nord_language.la_sacs_noir,function()reglecoul(ent:GetClass(),1) end):SetImage("icon16/bullet_black.png")subMenu:AddSpacer()
subMenu:AddOption(Nord_language.la_sacs_bleu,function()reglecoul(ent:GetClass(),2) end):SetImage("icon16/bullet_blue.png")subMenu:AddSpacer()
subMenu:AddOption(Nord_language.la_sacs_orange,function()reglecoul(ent:GetClass(),3) end):SetImage("icon16/bullet_orange.png")subMenu:AddSpacer()
subMenu:AddOption(Nord_language.la_sacs_rose,function()reglecoul(ent:GetClass(),4) end):SetImage("icon16/bullet_pink.png")subMenu:AddSpacer()
subMenu:AddOption(Nord_language.la_sacs_violet,function()reglecoul(ent:GetClass(),5) end):SetImage("icon16/bullet_purple.png")subMenu:AddSpacer()
subMenu:AddOption(Nord_language.la_sacs_rouge,function()reglecoul(ent:GetClass(),6) end):SetImage("icon16/bullet_red.png")subMenu:AddSpacer()
subMenu:AddOption(Nord_language.la_sacs_jaune,function()reglecoul(ent:GetClass(),7) end):SetImage("icon16/bullet_yellow.png")subMenu:AddSpacer()
subMenu:AddOption(Nord_language.la_sacs_vert,function()reglecoul(ent:GetClass(),8) end):SetImage("icon16/bullet_green.png")subMenu:AddSpacer()
subMenu:AddOption(Nord_language.la_sacs_invisible,function()reglecoul(ent:GetClass(),9) end):SetImage("icon16/weather_clouds.png")subMenu:AddSpacer()
subMenu.Paint=function()draw.RoundedBox(4,0,0,subMenu:GetWide(),subMenu:GetTall(),Color(0,117,223,255))
draw.RoundedBox(4,1,1,subMenu:GetWide()-2,subMenu:GetTall()-2,Color(255,255,255,255))
end
menu:AddSpacer()
menu:AddOption(Nord_language.la_sacs_tpmoi, function()
RunConsoleCommand("sacs_tpe",ent:GetClass(),math.Round(ent:GetPos().x),math.Round(ent:GetPos().y),math.Round(ent:GetPos().z))
LocalPlayer():EmitSound("ui/buttonclick.wav",100,200)
end):SetImage("icon16/user_go.png")
menu:AddSpacer()
menu:AddOption("'"..ent:GetClass().."' "..Nord_language.la_sacs_copieentcl, function()
SetClipboardText(ent:GetClass())
LocalPlayer():EmitSound("ui/buttonclick.wav",100,200)
end):SetImage("icon16/application_double.png")
menu:Open()
end
end

local function func_sacsadmeon(a,b,c)
end
local function func_sacsadmeoff(a,b,c)
end
function ntsacsys(a,b,c)
sacsys=tostring(c[1])
end
concommand.Add("ntsacsys",ntsacsys)
function ntbtclup(a,b,c)
gmbtclupl=tostring(c[1])
end
concommand.Add("ntbtclup",ntbtclup)
function ntsacsclock(a,b,c)
gmsacsclock=tonumber(c[1])
end
concommand.Add("ntsacsclock",ntsacsclock)
local function optmeameajourgt5(a,b,c)

end
concommand.Add("optmeameajourgt5",optmeameajourgt5)
concommand.Add( "sacs_menu", SACS.Menu )
function SACS.Print(tbl)end

local hA=hook.Add
local hR=hook.Remove
Sacslist= Sacslist or {}
Abculist= Abculist or {}

function nordphy(a,b,c)
zgmphjyscsz1=c[1]
zgmphjyscsz2=c[2]
zgmphjyscsz3=c[3]
zgmphjyscsz4=c[4]
zgmphjyscsz5=c[5]
zgmphjyscsz6=c[6]
zgmphjyscsz7=c[7]
zgmphjyscsz8=c[8]
zgmphjyscsz9=c[9]
zgmphjyscsz10=c[10]
zgmphjyscsz11=c[11]
end
concommand.Add("nordphy",nordphy)


function nordphy1(a,b,c)zgmphjyscsz1=tonumber(c[1])end concommand.Add("nordphy1",nordphy1)
function nordphy2(a,b,c)zgmphjyscsz2=tonumber(c[1])end concommand.Add("nordphy2",nordphy2)
function nordphy3(a,b,c)zgmphjyscsz3=tonumber(c[1])end concommand.Add("nordphy3",nordphy3)
function nordphy4(a,b,c)zgmphjyscsz4=tonumber(c[1])end concommand.Add("nordphy4",nordphy4)
function nordphy5(a,b,c)zgmphjyscsz5=tonumber(c[1])end concommand.Add("nordphy5",nordphy5)
function nordphy6(a,b,c)zgmphjyscsz6=tonumber(c[1])end concommand.Add("nordphy6",nordphy6)
function nordphy7(a,b,c)zgmphjyscsz7=tonumber(c[1])end concommand.Add("nordphy7",nordphy7)
function nordphy8(a,b,c)zgmphjyscsz8=tonumber(c[1])end concommand.Add("nordphy8",nordphy8)
function nordphy9(a,b,c)zgmphjyscsz9=tonumber(c[1])end concommand.Add("nordphy9",nordphy9)
function nordphy10(a,b,c)zgmphjyscsz10=tonumber(c[1])end concommand.Add("nordphy10",nordphy10)
function nordphy11(a,b,c)zgmphjyscsz11=tonumber(c[1])end concommand.Add("nordphy11",nordphy11)

net.Receive("SynchSacsSys",function(len)
local classname=net.ReadString()
local pln=net.ReadString()
local remove=tobool(net.ReadBit())
if remove then
SACS.RemoveSacsL(pln,true)
for k,v in pairs(Sacslist)do 
if v[1]==classname then
table.remove(Sacslist,k)
return
end
end
else
SACS.AddSacslist({classname,pln},true)
end
end)
net.Receive("SynchAbcuSys",function(len)
local classname=net.ReadString()
local pln=net.ReadString()
local val=net.ReadString()
local remove=tobool(net.ReadBit())
local pos=""
if val=="0" then
pos="0"
else
local epl=string.Explode(" ",val)
pos=Vector(epl[1],epl[2],epl[3])
end

if remove then
SACS.RemoveAbcuL(pln,true)
for k,v in pairs(Abculist)do 
if v[1]==classname then
table.remove(Abculist,k)
return
end
end
else
SACS.AddAbculist({classname,pln,pos},true)
end
end)
net.Receive("SynchAllSacsL",function(len)
local classname=net.ReadString()
local addby=net.ReadString()
sacszwusers1=sacszwusers1+1
SACS.AddSacslist({classname,addby},true)
end)
net.Receive("SynchAllAbcuL",function(len)
local classname=net.ReadString()
local addby=net.ReadString()
local pos=net.ReadString()
sacszwusers2=sacszwusers2+1
SACS.AddAbculist({classname,addby,pos},true)
end)
function SACS.sacssysexist(classname)
for k,v in pairs(Sacslist)do
if v[1]==classname then
return true 
end
end
end
function SACS.sacssysexist2(classname,pos)
for k,v in pairs(Abculist)do
if v[1]==classname and v[3]=="0" then
return true 
end
end
end
function SACS.AddSacslist(tbl,override)
if SACS.sacssysexist(tbl[1])then return end
table.insert(Sacslist,tbl)
if override then return end
RunConsoleCommand("zmoda_add_insacs",tbl[1])
end
function SACS.AddAbculist(tbl,override)
if SACS.sacssysexist2(tbl[1],tbl[3])then return end
print("zmoda_add_inabcu",tbl[1],tbl[3])
table.insert(Abculist,tbl)
if override then return end
RunConsoleCommand("zmoda_add_inabcu",tbl[1],tbl[3])
end
function SACS.RemoveSacsL(classname,override)
for k,v in pairs(Sacslist)do
if v[1]==classname then
table.remove(Sacslist,k)
if override then return end
RunConsoleCommand("zmoda_remove_sacslist",classname)
return
end
end
end
function SACS.RemoveAbcuL(classname,override)
for k,v in pairs(Abculist)do
if v[1]==classname then
table.remove(Abculist,k)
if override then return end
RunConsoleCommand("zmoda_remove_abculist",classname)
return
end
end
end
local function MakePanel()
local panel=vgui.Create("DPanel")
panel.InvalidateLayout=function()
if panel.List then
panel.List:StretchToParent(1,35,1,1)
end
end
panel.Paint=function()draw.RoundedBox(0,0,0,ScrW()-24,ScrH()-65,Color(0,0,0,255))
end
local textbox1=vgui.Create("DTextEntry",panel)
textbox1:SetPos(5,5)
textbox1:SetWide(150)
textbox1:SetText(Nord_language.la_sacs_ongl00)
panel.Box1=textbox1
local butan=vgui.Create("DButton",panel)
butan:SetText("   "..Nord_language.la_sacs_onglb31)
butan:SetPos(160,5)
butan:SetWide(150)
butan.Paint=function()
draw.RoundedBox(6,0,0,butan:GetWide(),butan:GetTall(),Color(0,117,223,255))
draw.RoundedBox(6,1,1,butan:GetWide()-2,butan:GetTall()-2,Color(255,255,255,255))
draw.RoundedBox(4,1,butan:GetTall()-2-butan:GetTall()/3,butan:GetWide()-2,butan:GetTall()/3,Color(200,210,255,255))
surface.SetDrawColor( 255,255,255, 255 ) 
surface.SetMaterial(Material("icon16/add.png"))surface.DrawTexturedRect(3,3,16,16)
end
butan.DoClick=function()
local entnom=textbox1:GetText()
butan.List:AddLine(entnom,LocalPlayer():Name())
SACS.AddSacslist({entnom,LocalPlayer():Name()})
surface.PlaySound(SACS_CONFIG.ButtonSound)
end

local butan2=vgui.Create("DButton",panel)
butan2:SetText("   Reset the list")
butan2:SetPos(160+155,5)
butan2:SetWide(125)
butan2.Paint=function()
draw.RoundedBox(6,0,0,butan2:GetWide(),butan2:GetTall(),Color(0,117,223,255))
draw.RoundedBox(6,1,1,butan2:GetWide()-2,butan2:GetTall()-2,Color(255,255,255,255))
draw.RoundedBox(4,1,butan2:GetTall()-2-butan2:GetTall()/3,butan2:GetWide()-2,butan2:GetTall()/3,Color(200,210,255,255))
surface.SetDrawColor( 255,255,255, 255 ) 
surface.SetMaterial(Material("icon16/cross.png"))surface.DrawTexturedRect(3,3,16,16)
end
butan2.DoClick=function()
RunConsoleCommand("sacslist_reset")
butan.List:Clear()
Sacslist={}
LocalPlayer():EmitSound("ui/buttonclick.wav",100,160)
end
local list=vgui.Create("DListView",panel)
list.Paint=function()draw.RoundedBox(8,0,0,list:GetWide(),list:GetTall(),Color(255,255,255,255))
end
panel.List=list
butan.List=list
local col1=list:AddColumn(Nord_language.la_sacs_ongl2341)
col3=list:AddColumn(Nord_language.la_sacs_ajpar)
col1:SetMinWidth(150)
col1:SetMaxWidth(150)
col3:SetMinWidth(200)
return panel
end
local function MakePanelF()
local panel=vgui.Create("DPanel")
butan1genr=nil
butan2genr=nil
butan3genr=nil
panel.InvalidateLayout=function()
if panel.List then
panel.List:StretchToParent(1,35,1,1)
end
end
local MyCategolocal=MyCatego
panel.Paint=function()draw.RoundedBox(0,0,0,ScrW()-24,ScrH()-65,Color(0,0,0,255))
end
local textbox1=vgui.Create("DTextEntry",panel)
textbox1:SetPos(5,5)
textbox1:SetWide(150)
textbox1:SetText(Nord_language.la_sacs_ongl00)
panel.Box1=textbox1
local butan3=vgui.Create("DButton",panel)
butan3:SetText("  "..Nord_language.la_sacs_onglb1)
butan3:SetPos(160,5)
butan3:SetWide(150)
butan3.Paint=function()
if butan3genr==true then
draw.RoundedBox(6,0,0,butan3:GetWide(),butan3:GetTall(),Color(0,223,0,255))
draw.RoundedBox(6,1,1,butan3:GetWide()-2,butan3:GetTall()-2,Color(255,255,255,255))
draw.RoundedBox(4,1,butan3:GetTall()-2-butan3:GetTall()/3,butan3:GetWide()-2,butan3:GetTall()/3,Color(210,255,210,255))
else
draw.RoundedBox(6,0,0,butan3:GetWide(),butan3:GetTall(),Color(0,117,223,255))
draw.RoundedBox(6,1,1,butan3:GetWide()-2,butan3:GetTall()-2,Color(255,255,255,255))
draw.RoundedBox(4,1,butan3:GetTall()-2-butan3:GetTall()/3,butan3:GetWide()-2,butan3:GetTall()/3,Color(200,210,255,255))
end
surface.SetDrawColor( 255, 255, 255, 255 ) 
surface.SetMaterial(Material("icon16/map.png"))surface.DrawTexturedRect(3,3,16,16)
end
butan3.DoClick=function()
local entnom=textbox1:GetText()
panel.List:Clear()
butan1genr=nil
butan2genr=nil
butan3genr=true
local plpos=LocalPlayer():GetPos()
for k,v in pairs(ents.GetAll())do 
local pos = v:GetPos()
local longueur = plpos:Distance( pos )
local longueur=longueur/10
local longueur2=255-longueur
local longueur3=math.Round(longueur/5)
if v:GetClass()==entnom then
panel.List:AddLine(v:GetClass(),v:EntIndex(),longueur3,pos)
end
end
surface.PlaySound(SACS_CONFIG.ButtonSound)
end
local butan=vgui.Create("DButton",panel)
butan:SetText("   "..Nord_language.la_sacs_onglb3)
butan:SetPos(315,5)
butan:SetWide(150)
butan.Paint=function()
if butan1genr==true then
draw.RoundedBox(6,0,0,butan:GetWide(),butan:GetTall(),Color(0,223,0,255))
draw.RoundedBox(6,1,1,butan:GetWide()-2,butan:GetTall()-2,Color(255,255,255,255))
draw.RoundedBox(4,1,butan:GetTall()-2-butan:GetTall()/3,butan:GetWide()-2,butan:GetTall()/3,Color(210,255,210,255))
else
draw.RoundedBox(6,0,0,butan:GetWide(),butan:GetTall(),Color(0,117,223,255))
draw.RoundedBox(6,1,1,butan:GetWide()-2,butan:GetTall()-2,Color(255,255,255,255))
draw.RoundedBox(4,1,butan:GetTall()-2-butan:GetTall()/3,butan:GetWide()-2,butan:GetTall()/3,Color(200,210,255,255))
end
surface.SetDrawColor( 0,117,223, 255 ) 
surface.SetMaterial(Material("ngui/sacs.png"))surface.DrawTexturedRect(3,3,16,16)
end
local butan2=vgui.Create("DButton",panel)
butan2:SetText("   "..Nord_language.la_sacs_onglb2)
butan2:SetPos(470,5)
butan2:SetWide(150)
butan2.Paint=function()
if butan2genr==true then
draw.RoundedBox(6,0,0,butan2:GetWide(),butan2:GetTall(),Color(0,223,0,255))
draw.RoundedBox(6,1,1,butan2:GetWide()-2,butan2:GetTall()-2,Color(255,255,255,255))
draw.RoundedBox(4,1,butan2:GetTall()-2-butan2:GetTall()/3,butan2:GetWide()-2,butan2:GetTall()/3,Color(210,255,210,255))
else
draw.RoundedBox(6,0,0,butan2:GetWide(),butan2:GetTall(),Color(0,117,223,255))
draw.RoundedBox(6,1,1,butan2:GetWide()-2,butan2:GetTall()-2,Color(255,255,255,255))
draw.RoundedBox(4,1,butan2:GetTall()-2-butan2:GetTall()/3,butan2:GetWide()-2,butan2:GetTall()/3,Color(200,210,255,255))
end
surface.SetDrawColor( 255, 255, 255, 255 ) 
surface.SetMaterial(Material("ngui/abcs.png"))surface.DrawTexturedRect(3,3,16,16)
end
butan2.DoClick=function()
local entnom=textbox1:GetText()
butan1genr=nil
butan2genr=true
butan3genr=nil
butan2.List:Clear()
for k,v in pairs(Abculist)do 
--print(v[1],v[2],v[3])
if v[1]==entnom then
if v[3]=="0" then
butan2.List:AddLine(v[1],v[2],"Global")
else
butan2.List:AddLine(v[1],v[2],"Only one",v[3])
end
end
end
surface.PlaySound(SACS_CONFIG.ButtonSound)
end
butan.DoClick=function()
local entnom=textbox1:GetText()
butan1genr=true
butan2genr=nil
butan3genr=nil
butan.List:Clear()
for k,v in pairs(Sacslist)do 
--print(v[1],v[2],v[3])
if v[1]==entnom then
butan.List:AddLine(v[1],v[2])
end
end
surface.PlaySound(SACS_CONFIG.ButtonSound)
end
local list=vgui.Create("DListView",panel)
list.Paint=function()draw.RoundedBox(8,0,0,list:GetWide(),list:GetTall(),Color(255,255,255,255))
end
panel.List=list
butan.List=list
butan2.List=list
butan3.List=list
local col1=list:AddColumn(Nord_language.la_sacs_ongl2341)
col2=list:AddColumn("Index")
col3=list:AddColumn(Nord_language.la_sacs_ongl13)
col1:SetMinWidth(150)
col1:SetMaxWidth(150)
col2:SetMinWidth(200)
col3:SetMinWidth(50)
return panel
end
local function PopulateList(panel)
local list=panel.List
if not list then return end
for k,v in pairs(Sacslist)do
if v[3]==nil then
list:AddLine(v[1],v[2],"Global")
else
list:AddLine(v[1],v[2],"Global")
end
end
list.OnRowRightClick=function(panel,id,line)
local menu=vgui.Create("DMenu",panel)
menu:AddOption("Remove",function()
list:RemoveLine(id)
local classname=line:GetColumnText(1)
SACS.RemoveSacsL(classname)
surface.PlaySound(SACS_CONFIG.ButtonSound)
end):SetImage("icon16/bin.png")
menu.Paint=function()draw.RoundedBox(6,0,0,menu:GetWide(),menu:GetTall(),Color(0,0,0,255))
draw.RoundedBox(6,1,1,menu:GetWide()-2,menu:GetTall()-2,Color(255,255,255,255))
end
menu:Open()
end
end
local function PopulateListF(panel)
local list=panel.List
if not list then return end
list.OnRowRightClick=function(panel,id,line)
local menu=vgui.Create("DMenu",panel)
if butan1genr then
menu:AddOption("Remove from S.A.C.S List",function()
list:RemoveLine(id)
local classname=line:GetColumnText(1)
SACS.RemoveSacsL(classname)
surface.PlaySound(SACS_CONFIG.ButtonSound)
end):SetImage("icon16/bin.png")
menu:AddSpacer()
end
if butan2genr then
menu:AddOption("Remove from A.B.C.S List",function()
list:RemoveLine(id)
local classname=line:GetColumnText(1)
SACS.RemoveAbcuL(classname)
surface.PlaySound(SACS_CONFIG.ButtonSound)
end):SetImage("icon16/bin.png")
menu:AddSpacer()
end
if butan3genr then

local submenu,optMenu = menu:AddSubMenu(Nord_language.la_sacs_ongl3)
optMenu:SetIcon("ngui/sacs.png")

submenu:AddOption(Nord_language.la_sacs_ajentsyst.." S.A.C.S", function()
RunConsoleCommand("zmoda_addsacsl",line:GetColumnText(1),LocalPlayer():Nick())
LocalPlayer():EmitSound("ui/buttonclick.wav",100,200)
end):SetImage("ngui/sacs.png")

menu:AddSpacer()
menu.Paint=function()draw.RoundedBox(4,0,0,menu:GetWide(),menu:GetTall(),Color(0,117,223,255))
draw.RoundedBox(4,1,1,menu:GetWide()-2,menu:GetTall()-2,Color(255,255,255,255))
end
submenu.Paint=function()draw.RoundedBox(4,0,0,submenu:GetWide(),submenu:GetTall(),Color(0,117,223,255))
draw.RoundedBox(4,1,1,submenu:GetWide()-2,submenu:GetTall()-2,Color(255,255,255,255))
end
local submenu,optMenu = menu:AddSubMenu(Nord_language.la_sacs_ongl4)
optMenu:SetIcon("ngui/abcs.png")
submenu:AddOption("A.B.C.S: Only Remove this one when Server reboot", function()
RunConsoleCommand("zmoda_addabcu2",line:GetColumnText(2),LocalPlayer():Nick())
LocalPlayer():EmitSound("ui/buttonclick.wav",100,200)
end):SetImage("ngui/abcs.png")
submenu:AddSpacer()
submenu:AddOption("A.B.C.S: Global Remove the entities with this class when Server reboot", function()
RunConsoleCommand("zmoda_addabcul",line:GetColumnText(1),LocalPlayer():Nick())
LocalPlayer():EmitSound("ui/buttonclick.wav",100,200)
end):SetImage("ngui/abcs.png")

submenu:AddSpacer()
submenu.Paint=function()draw.RoundedBox(4,0,0,submenu:GetWide(),submenu:GetTall(),Color(0,117,223,255))
draw.RoundedBox(4,1,1,submenu:GetWide()-2,submenu:GetTall()-2,Color(255,255,255,255))
end
menu:AddSpacer()
local subMenu,optMenu=menu:AddSubMenu(Nord_language.la_sacs_supprimer..": '"..line:GetColumnText(1).."'")menu:AddSpacer()
optMenu:SetIcon("icon16/bin.png")
subMenu.Paint=function()draw.RoundedBox(4,0,0,subMenu:GetWide(),subMenu:GetTall(),Color(0,117,223,255))
draw.RoundedBox(4,1,1,subMenu:GetWide()-2,subMenu:GetTall()-2,Color(255,255,255,255))
end
subMenu:AddOption(Nord_language.la_sacs_supprimer1,function()RunConsoleCommand("sacsentrem",line:GetColumnText(1),line:GetColumnText(3))end):SetImage("icon16/bin.png")subMenu:AddSpacer()
subMenu:AddOption(Nord_language.la_sacs_supprimer2,function()RunConsoleCommand("sacs_removeent",line:GetColumnText(1))LocalPlayer():EmitSound("ui/buttonclick.wav",100,200)end):SetImage("icon16/bin.png")subMenu:AddSpacer()
local subMenu,optMenu=menu:AddSubMenu(Nord_language.la_sacs_reglcolor)
optMenu:SetIcon("icon16/rainbow.png") --color_swatch --palette
function reglecoul(Gnom,coul)
for _,c in ipairs(ents.FindByClass(Gnom))do
if coul==0 then
c.sacscol=nil
elseif coul==1 then
c.sacscol=Color(0,0,0,175)
elseif coul==2 then
c.sacscol=Color(0,0,204,175)
elseif coul==3 then
c.sacscol=Color(204,102,0,175)
elseif coul==4 then
c.sacscol=Color(204,0,204,175)
elseif coul==5 then
c.sacscol=Color(102,0,204,175)
elseif coul==6 then
c.sacscol=Color(0,255,0,175)
elseif coul==7 then
c.sacscol=Color(204,204,0,175)
elseif coul==8 then
c.sacscol=Color(0,204,0,175)
elseif coul==9 then
c.sacscol=Color(0,0,0,0)
end
end
end
subMenu:AddOption(Nord_language.la_sacs_blanc,function()reglecoul(line:GetColumnText(1),0) end):SetImage("icon16/bullet_white.png")subMenu:AddSpacer()
subMenu:AddOption(Nord_language.la_sacs_noir,function()reglecoul(line:GetColumnText(1),1) end):SetImage("icon16/bullet_black.png")subMenu:AddSpacer()
subMenu:AddOption(Nord_language.la_sacs_bleu,function()reglecoul(line:GetColumnText(1),2) end):SetImage("icon16/bullet_blue.png")subMenu:AddSpacer()
subMenu:AddOption(Nord_language.la_sacs_orange,function()reglecoul(line:GetColumnText(1),3) end):SetImage("icon16/bullet_orange.png")subMenu:AddSpacer()
subMenu:AddOption(Nord_language.la_sacs_rose,function()reglecoul(line:GetColumnText(1),4) end):SetImage("icon16/bullet_pink.png")subMenu:AddSpacer()
subMenu:AddOption(Nord_language.la_sacs_violet,function()reglecoul(line:GetColumnText(1),5) end):SetImage("icon16/bullet_purple.png")subMenu:AddSpacer()
subMenu:AddOption(Nord_language.la_sacs_rouge,function()reglecoul(line:GetColumnText(1),6) end):SetImage("icon16/bullet_red.png")subMenu:AddSpacer()
subMenu:AddOption(Nord_language.la_sacs_jaune,function()reglecoul(line:GetColumnText(1),7) end):SetImage("icon16/bullet_yellow.png")subMenu:AddSpacer()
subMenu:AddOption(Nord_language.la_sacs_vert,function()reglecoul(line:GetColumnText(1),8) end):SetImage("icon16/bullet_green.png")subMenu:AddSpacer()
subMenu:AddOption(Nord_language.la_sacs_invisible,function()reglecoul(line:GetColumnText(1),9) end):SetImage("icon16/weather_clouds.png")subMenu:AddSpacer()
subMenu.Paint=function()draw.RoundedBox(4,0,0,subMenu:GetWide(),subMenu:GetTall(),Color(0,117,223,255))
draw.RoundedBox(4,1,1,subMenu:GetWide()-2,subMenu:GetTall()-2,Color(255,255,255,255))
end
menu:AddSpacer()
menu:AddOption(Nord_language.la_sacs_tpmoi, function()
RunConsoleCommand("sacs_tpe",line:GetColumnText(1),math.Round(ent:GetPos().x),math.Round(ent:GetPos().y),math.Round(ent:GetPos().z))
LocalPlayer():EmitSound("ui/buttonclick.wav",100,200)
end):SetImage("icon16/user_go.png")
menu:AddSpacer()
menu:AddOption("'"..line:GetColumnText(1).."' "..Nord_language.la_sacs_copieentcl, function()
SetClipboardText(line:GetColumnText(1))
LocalPlayer():EmitSound("ui/buttonclick.wav",100,200)
end):SetImage("icon16/application_double.png")
menu:Open()

-- menu:AddSpacer()
-- menu:AddOption(Nord_language.la_sacs_onglb31, function()
-- RunConsoleCommand("zmoda_addsacsl",line:GetColumnText(1),"add_insacs")
-- LocalPlayer():EmitSound("ui/buttonclick.wav",100,200)
-- end):SetImage("ngui/sacs.png")menu:AddSpacer()
-- menu:AddSpacer()
-- menu:AddOption(Nord_language.la_sacs_onglb41, function()
-- RunConsoleCommand("zmoda_addabcul",line:GetColumnText(1),LocalPlayer():Nick())
-- LocalPlayer():EmitSound("ui/buttonclick.wav",100,200)
-- end):SetImage("ngui/abcs.png")menu:AddSpacer()
-- local subMenu,optMenu=menu:AddSubMenu(Nord_language.la_sacs_supprimer..": '"..line:GetColumnText(1).."'")menu:AddSpacer()
-- optMenu:SetIcon("icon16/bin.png")
-- subMenu:AddOption(Nord_language.la_sacs_supprimer1,function()list:RemoveLine(id)RunConsoleCommand("sacsentrem",line:GetColumnText(1),line:GetColumnText(3)) end):SetImage("icon16/bin.png")subMenu:AddSpacer()
-- subMenu:AddOption(Nord_language.la_sacs_supprimer2,function()RunConsoleCommand("sacs_removeent",line:GetColumnText(1))LocalPlayer():EmitSound("ui/buttonclick.wav",100,200)end):SetImage("icon16/bin.png")subMenu:AddSpacer()
-- local subMenu,optMenu=menu:AddSubMenu(Nord_language.la_sacs_reglcolor)
-- optMenu:SetIcon("icon16/rainbow.png") --color_swatch --palette
-- function reglecoul(Gnom,coul)
-- for _,c in ipairs(ents.FindByClass(Gnom))do
-- if coul==0 then
-- c.sacscol=nil
-- elseif coul==1 then
-- c.sacscol=Color(0,0,0,175)
-- elseif coul==2 then
-- c.sacscol=Color(0,0,204,175)
-- elseif coul==3 then
-- c.sacscol=Color(204,102,0,175)
-- elseif coul==4 then
-- c.sacscol=Color(204,0,204,175)
-- elseif coul==5 then
-- c.sacscol=Color(102,0,204,175)
-- elseif coul==6 then
-- c.sacscol=Color(0,255,0,175)
-- elseif coul==7 then
-- c.sacscol=Color(204,204,0,175)
-- elseif coul==8 then
-- c.sacscol=Color(0,204,0,175)
-- elseif coul==9 then
-- c.sacscol=Color(0,0,0,0)
-- end
-- end
-- end
-- subMenu:AddOption(Nord_language.la_sacs_blanc,function()reglecoul(line:GetColumnText(1),0) end):SetImage("icon16/bullet_white.png")subMenu:AddSpacer()
-- subMenu:AddOption(Nord_language.la_sacs_noir,function()reglecoul(line:GetColumnText(1),1) end):SetImage("icon16/bullet_black.png")subMenu:AddSpacer()
-- subMenu:AddOption(Nord_language.la_sacs_bleu,function()reglecoul(line:GetColumnText(1),2) end):SetImage("icon16/bullet_blue.png")subMenu:AddSpacer()
-- subMenu:AddOption(Nord_language.la_sacs_orange,function()reglecoul(line:GetColumnText(1),3) end):SetImage("icon16/bullet_orange.png")subMenu:AddSpacer()
-- subMenu:AddOption(Nord_language.la_sacs_rose,function()reglecoul(line:GetColumnText(1),4) end):SetImage("icon16/bullet_pink.png")subMenu:AddSpacer()
-- subMenu:AddOption(Nord_language.la_sacs_violet,function()reglecoul(line:GetColumnText(1),5) end):SetImage("icon16/bullet_purple.png")subMenu:AddSpacer()
-- subMenu:AddOption(Nord_language.la_sacs_rouge,function()reglecoul(line:GetColumnText(1),6) end):SetImage("icon16/bullet_red.png")subMenu:AddSpacer()
-- subMenu:AddOption(Nord_language.la_sacs_jaune,function()reglecoul(line:GetColumnText(1),7) end):SetImage("icon16/bullet_yellow.png")subMenu:AddSpacer()
-- subMenu:AddOption(Nord_language.la_sacs_vert,function()reglecoul(line:GetColumnText(1),8) end):SetImage("icon16/bullet_green.png")subMenu:AddSpacer()
-- subMenu:AddOption(Nord_language.la_sacs_invisible,function()reglecoul(line:GetColumnText(1),9) end):SetImage("icon16/weather_clouds.png")subMenu:AddSpacer()
-- menu:AddSpacer()
-- menu:AddOption(Nord_language.la_sacs_tpmoi, function()
-- RunConsoleCommand("sacs_tpe",line:GetColumnText(1),math.Round(line:GetColumnText(4).x),math.Round(line:GetColumnText(4).y),math.Round(line:GetColumnText(4).z))
-- LocalPlayer():EmitSound("ui/buttonclick.wav",100,200)
-- end):SetImage("icon16/user_go.png")
-- menu:AddSpacer()
-- menu:AddOption("'"..line:GetColumnText(1).."' "..Nord_language.la_sacs_copieentcl, function()
-- SetClipboardText(line:GetColumnText(1))
-- LocalPlayer():EmitSound("ui/buttonclick.wav",100,200)
-- end):SetImage("icon16/application_double.png")
end
menu.Paint=function()draw.RoundedBox(6,0,0,menu:GetWide(),menu:GetTall(),Color(0,0,0,255))
draw.RoundedBox(6,1,1,menu:GetWide()-2,menu:GetTall()-2,Color(255,255,255,255))
end
menu:Open()
end
end
local function MakePanelB()
local panel=vgui.Create("DPanel")
panel.InvalidateLayout=function()
if panel.List then
panel.List:StretchToParent(1,35,1,1)
end
end
panel.Paint=function()draw.RoundedBox(0,0,0,ScrW()-24,ScrH()-65,Color(0,50,0,255))
end
local textbox1=vgui.Create("DTextEntry",panel)
textbox1:SetPos(5,5)
textbox1:SetWide(150)
textbox1:SetText(Nord_language.la_sacs_ongl00)
panel.Box1=textbox1
local butan=vgui.Create("DButton",panel)
butan:SetText("   "..Nord_language.la_sacs_onglb41)
butan:SetPos(160,5)
butan:SetWide(150)
butan.Paint=function()
draw.RoundedBox(6,0,0,butan:GetWide(),butan:GetTall(),Color(0,117,223,255))
draw.RoundedBox(6,1,1,butan:GetWide()-2,butan:GetTall()-2,Color(255,255,255,255))
draw.RoundedBox(4,1,butan:GetTall()-2-butan:GetTall()/3,butan:GetWide()-2,butan:GetTall()/3,Color(200,210,255,255))
surface.SetDrawColor( 255,255,255, 255 ) 
surface.SetMaterial(Material("icon16/add.png"))surface.DrawTexturedRect(3,3,16,16)
end
butan.DoClick=function()
local entnom=textbox1:GetText()
butan.List:AddLine(entnom,LocalPlayer():Name(),"Global")
SACS.AddAbculist({entnom,LocalPlayer():Name(),"0"})
surface.PlaySound(SACS_CONFIG.ButtonSound)
end

local butan2=vgui.Create("DButton",panel)
butan2:SetText("   Reset the list")
butan2:SetPos(160+155,5)
butan2:SetWide(125)
butan2.Paint=function()
draw.RoundedBox(6,0,0,butan2:GetWide(),butan2:GetTall(),Color(0,117,223,255))
draw.RoundedBox(6,1,1,butan2:GetWide()-2,butan2:GetTall()-2,Color(255,255,255,255))
draw.RoundedBox(4,1,butan2:GetTall()-2-butan2:GetTall()/3,butan2:GetWide()-2,butan2:GetTall()/3,Color(200,210,255,255))
surface.SetDrawColor( 255,255,255, 255 ) 
surface.SetMaterial(Material("icon16/cross.png"))surface.DrawTexturedRect(3,3,16,16)
end
butan2.DoClick=function()
RunConsoleCommand("abculist_reset")
butan.List:Clear()
Abculist={}
LocalPlayer():EmitSound("ui/buttonclick.wav",100,160)
end

local list=vgui.Create("DListView",panel)
list.Paint=function()draw.RoundedBox(8,0,0,list:GetWide(),list:GetTall(),Color(255,255,255,255))
end
panel.List=list
butan.List=list
butan2.List=list
local col1=list:AddColumn(Nord_language.la_sacs_ongl2341)
col3=list:AddColumn(Nord_language.la_sacs_ajpar)
col4=list:AddColumn("Suppresion Type")
col5=list:AddColumn("Position")
col1:SetMinWidth(150)
col1:SetMaxWidth(150)
col3:SetMinWidth(200)
col4:SetMinWidth(50)
col5:SetMinWidth(50)
return panel
end
local function PopulateListB(panel)
local list=panel.List
if not list then return end
for k,v in pairs(Abculist)do
if v[3]=="0" then
list:AddLine(v[1],v[2],"Global")
else
list:AddLine(v[1],v[2],"Only One",v[3])
end
end
list.OnRowRightClick=function(panel,id,line)
local menu=vgui.Create("DMenu",panel)
menu:AddOption("Remove",function()
list:RemoveLine(id)
local classname=line:GetColumnText(1)
SACS.RemoveAbcuL(classname)
surface.PlaySound(SACS_CONFIG.ButtonSound)
end):SetImage("icon16/bin.png")
menu.Paint=function()draw.RoundedBox(6,0,0,menu:GetWide(),menu:GetTall(),Color(0,0,0,255))
draw.RoundedBox(6,1,1,menu:GetWide()-2,menu:GetTall()-2,Color(255,255,255,255))
end
menu:Open()
end
end
local function Makpopt()
local panel = vgui.Create( "DFrame" )
panel:SetPos(0,0)
panel:SetTitle("")
panel:SetDraggable(false)
panel:ShowCloseButton(false)
panel.Paint=function()draw.RoundedBox(4,0,0,panel:GetWide(),panel:GetTall(),Color(255,255,255,255))
draw.RoundedBox(4,1,1,panel:GetWide()-2,panel:GetTall()-2,Color(0,0,0,255))
draw.SimpleText(Nord_language.la_sacs_options1,"Trebuchet18",5,5,Color(255,255,255),TEXT_ALIGN_LEFT,0,1,Color(0,0,0,255))
if gmsacsclock<=59 then
gmsacsclockstring=gmsacsclock.."' Seconds"
elseif gmsacsclock<3600 then
gmsacsclockstring=(gmsacsclock/60).."' Minutes"
elseif gmsacsclock>=3600 then
gmsacsclockstring=(gmsacsclock/60/60).."' Hours"
end
draw.SimpleText(Nord_language.la_sacs_options2.." '"..gmsacsclockstring,"Trebuchet18",5,52,Color(255,255,255),TEXT_ALIGN_LEFT,0,1,Color(0,0,0,255))
draw.SimpleText(Nord_language.la_sacs_options3,"Trebuchet18",5,78+26,Color(255,255,255),TEXT_ALIGN_LEFT,0,1,Color(0,0,0,255))
draw.SimpleText(Nord_language.la_sacs_options4,"Trebuchet18",5,78+26+26+26,Color(255,255,255),TEXT_ALIGN_LEFT,0,1,Color(0,0,0,255))
draw.SimpleText(Nord_language.la_sacs_options5,"Trebuchet18",5,78+26+26+26+26+26,Color(255,255,255),TEXT_ALIGN_LEFT,0,1,Color(0,0,0,255))
draw.SimpleText(Nord_language.la_sacs_options6,"Trebuchet18",5,78+26+26+26+26+26+26+26,Color(175,0,0),TEXT_ALIGN_LEFT,0,1,Color(0,0,0,255))
draw.SimpleText(Nord_language.la_sacs_options7,"Trebuchet18",5,78+26+26+26+26+26+26+26+(10*1),Color(0,150,0),TEXT_ALIGN_LEFT,0,1,Color(0,0,0,255))
draw.SimpleText(Nord_language.la_sacs_options8,"Trebuchet18",5,78+26+26+26+26+26+26+26+(10*2),Color(0,150,0),TEXT_ALIGN_LEFT,0,1,Color(0,0,0,255))
draw.SimpleText(Nord_language.la_sacs_options9,"Trebuchet18",5,78+26+26+26+26+26+26+26+(10*3),Color(0,150,0),TEXT_ALIGN_LEFT,0,1,Color(0,0,0,255))
draw.SimpleText(Nord_language.la_sacs_options10,"Trebuchet18",5,78+26+26+26+26+26+26+26+(10*4),Color(0,150,0),TEXT_ALIGN_LEFT,0,1,Color(0,0,0,255))
draw.SimpleText(Nord_language.la_sacs_options11,"Trebuchet18",5,78+26+26+26+26+26+26+26+(10*5),Color(0,150,0),TEXT_ALIGN_LEFT,0,1,Color(0,0,0,255))
end
local whtiendi=vgui.Create("DButton",panel)
whtiendi:SetText("")whtiendi:SetPos(10,25)whtiendi:SetSize(180,22)
whtiendi.Paint=function()
if sacsys=="1" then
draw.RoundedBox(6,0,0,whtiendi:GetWide(),whtiendi:GetTall(),Color(0,223,0,255))
draw.RoundedBox(6,1,1,whtiendi:GetWide()-2,whtiendi:GetTall()-2,Color(255,255,255,255))
draw.RoundedBox(4,1,15,whtiendi:GetWide()-2,6,Color(210,255,210,255))
draw.SimpleText("S.A.C System ON","Trebuchet18",90,11, Color(0,150,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
surface.SetDrawColor( 255,255,255, 255 ) 
surface.SetMaterial(Material("ngui/sacs.png"))surface.DrawTexturedRect(5,5,16,16)
elseif sacsys=="0" then
draw.RoundedBox(6,0,0,whtiendi:GetWide(),whtiendi:GetTall(),Color(0,117,223,255))
draw.RoundedBox(6,1,1,whtiendi:GetWide()-2,whtiendi:GetTall()-2,Color(255,255,255,255))
draw.RoundedBox(4,1,15,whtiendi:GetWide()-2,6,Color(200,210,255,255))
draw.SimpleText("S.A.C System OFF","Trebuchet18",90,11, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
surface.SetDrawColor( 255,255,255, 255 ) 
surface.SetMaterial(Material("ngui/sacs.png"))surface.DrawTexturedRect(5,5,16,16)
end
end
whtiendi.DoClick=function()
if sacsys=="0" then
RunConsoleCommand("systemsacswhl1","1")
LocalPlayer():EmitSound("ui/buttonclick.wav",100,200)
elseif sacsys=="1" then
RunConsoleCommand("systemsacswhl1","0")
LocalPlayer():EmitSound("ui/buttonclick.wav",100,160)
end
end
local whtiendi=vgui.Create("DButton",panel)
whtiendi:SetText("")
whtiendi:SetPos(10+185,25)
whtiendi:SetSize(180,22)
whtiendi.Paint=function()
if sacsys=="1" then
draw.RoundedBox(6,0,0,whtiendi:GetWide(),whtiendi:GetTall(),Color(0,223,0,255))
draw.RoundedBox(6,1,1,whtiendi:GetWide()-2,whtiendi:GetTall()-2,Color(255,255,255,255))
draw.RoundedBox(4,1,15,whtiendi:GetWide()-2,6,Color(210,255,210,255))
draw.SimpleText("Setup the time","Trebuchet18",90,11, Color(0,150,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
surface.SetDrawColor( 255,255,255, 255 ) 
surface.SetMaterial(Material("icon16/clock.png"))surface.DrawTexturedRect(5,3,16,16)
elseif sacsys=="0" then
draw.RoundedBox(6,0,0,whtiendi:GetWide(),whtiendi:GetTall(),Color(0,117,223,255))
draw.RoundedBox(6,1,1,whtiendi:GetWide()-2,whtiendi:GetTall()-2,Color(255,255,255,255))
draw.RoundedBox(4,1,15,whtiendi:GetWide()-2,6,Color(200,210,255,255))
draw.SimpleText("Setup the time","Trebuchet18",90,11, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
surface.SetDrawColor( 255,255,255, 255 ) 
surface.SetMaterial(Material("icon16/clock.png"))surface.DrawTexturedRect(5,3,16,16)
end
end
whtiendi.DoClick=function()
local z6=DermaMenu()
z6:AddOption("Set the cycle of S.A.C.S:",function()end):SetImage("ngui/sacs.png")
z6:AddSpacer()
z6:AddOption(Nord_language.la_ttles.." 5 "..Nord_language.la_secondes.." ("..Nord_language.la_porletest..")",function()RunConsoleCommand("sacsclock","5")LocalPlayer():EmitSound("ui/buttonclick.wav",100,160)end):SetImage("icon16/clock.png")
z6:AddSpacer()
z6:AddOption(Nord_language.la_ttles.." 20 "..Nord_language.la_minutes.." (Default value)",function()RunConsoleCommand("sacsclock","1200")LocalPlayer():EmitSound("ui/buttonclick.wav",100,160)end):SetImage("icon16/clock.png")
z6:AddSpacer()
z6:AddOption(Nord_language.la_ttles.." 30 "..Nord_language.la_minutes,function()RunConsoleCommand("sacsclock","1800")LocalPlayer():EmitSound("ui/buttonclick.wav",100,160)end):SetImage("icon16/clock.png")
z6:AddSpacer()
z6:AddOption(Nord_language.la_ttles.." 40 "..Nord_language.la_minutes,function()RunConsoleCommand("sacsclock","2400")LocalPlayer():EmitSound("ui/buttonclick.wav",100,160)end):SetImage("icon16/clock.png")
z6:AddSpacer()
z6:AddOption(Nord_language.la_ttles.." 50 "..Nord_language.la_minutes,function()RunConsoleCommand("sacsclock","3000")LocalPlayer():EmitSound("ui/buttonclick.wav",100,160)end):SetImage("icon16/clock.png")
z6:AddSpacer()
z6:AddOption(Nord_language.la_ttles.." 1 "..Nord_language.la_heure,function()RunConsoleCommand("sacsclock","3600")LocalPlayer():EmitSound("ui/buttonclick.wav",100,160)end):SetImage("icon16/clock.png")
z6:AddSpacer()
z6:AddOption(Nord_language.la_ttles.." 2 "..Nord_language.la_heures,function()RunConsoleCommand("sacsclock","7200")LocalPlayer():EmitSound("ui/buttonclick.wav",100,160)end):SetImage("icon16/clock.png")
z6:AddSpacer()
z6:AddOption(Nord_language.la_ttles.." 4 "..Nord_language.la_heures,function()RunConsoleCommand("sacsclock","14400")LocalPlayer():EmitSound("ui/buttonclick.wav",100,160)end):SetImage("icon16/clock.png")
z6:AddSpacer()
z6:AddOption(Nord_language.la_ttles.." 6 "..Nord_language.la_heures,function()RunConsoleCommand("sacsclock","21600")LocalPlayer():EmitSound("ui/buttonclick.wav",100,160)end):SetImage("icon16/clock.png")
z6:AddSpacer()
z6:AddOption(Nord_language.la_ttles.." 12 "..Nord_language.la_heures,function()RunConsoleCommand("sacsclock","43200")LocalPlayer():EmitSound("ui/buttonclick.wav",100,160)end):SetImage("icon16/clock.png")
z6:AddSpacer()
z6:AddOption(Nord_language.la_ttles.." 18 "..Nord_language.la_heures,function()RunConsoleCommand("sacsclock","64800")LocalPlayer():EmitSound("ui/buttonclick.wav",100,160)end):SetImage("icon16/clock.png")
z6:AddSpacer()
z6:AddOption(Nord_language.la_ttles.." 24 "..Nord_language.la_heures,function()RunConsoleCommand("sacsclock","86400")LocalPlayer():EmitSound("ui/buttonclick.wav",100,160)end):SetImage("icon16/clock.png")
z6:AddSpacer()
z6:AddOption(Nord_language.la_tousles.." 2 "..Nord_language.la_jours,function()RunConsoleCommand("sacsclock","172800")LocalPlayer():EmitSound("ui/buttonclick.wav",100,160)end):SetImage("icon16/clock.png")
z6:AddSpacer()
z6:AddOption(Nord_language.la_tousles.." 3 "..Nord_language.la_jours,function()RunConsoleCommand("sacsclock","259200")LocalPlayer():EmitSound("ui/buttonclick.wav",100,160)end):SetImage("icon16/clock.png")
z6:AddSpacer()
z6:AddOption(Nord_language.la_tousles.." 7 "..Nord_language.la_jours,function()RunConsoleCommand("sacsclock","604800")LocalPlayer():EmitSound("ui/buttonclick.wav",100,160)end):SetImage("icon16/clock.png")
z6:AddSpacer()
z6:AddOption(Nord_language.la_tousles.." 15 "..Nord_language.la_jours,function()RunConsoleCommand("sacsclock","1296000")LocalPlayer():EmitSound("ui/buttonclick.wav",100,160)end):SetImage("icon16/clock.png")
z6:AddSpacer()
z6:AddOption(Nord_language.la_tousles.." 30 "..Nord_language.la_jours,function()RunConsoleCommand("sacsclock","2592000")LocalPlayer():EmitSound("ui/buttonclick.wav",100,160)end):SetImage("icon16/clock.png")
z6:AddSpacer()
z6.Paint=function()draw.RoundedBox(4,0,0,z6:GetWide(),z6:GetTall(),Color(0,0,255,255))draw.RoundedBox(4,1,1,z6:GetWide()-2,z6:GetTall()-2,Color(255,255,255,255))end
z6:Open()
LocalPlayer():EmitSound("ui/buttonclick.wav",100,200)
end
local whtiendi=vgui.Create("DButton",panel)
whtiendi:SetText("")
whtiendi:SetPos(10,125)
whtiendi:SetSize(180,22)
whtiendi.Paint=function()
if gmbtclupl=="1" then
draw.RoundedBox(6,0,0,whtiendi:GetWide(),whtiendi:GetTall(),Color(0,223,0,255))
draw.RoundedBox(6,1,1,whtiendi:GetWide()-2,whtiendi:GetTall()-2,Color(255,255,255,255))
draw.RoundedBox(4,1,15,whtiendi:GetWide()-2,6,Color(210,255,210,255))
surface.SetDrawColor( 255,255,255, 255 ) 
surface.SetMaterial(Material("ngui/abcs.png"))surface.DrawTexturedRect(3,3,16,16)
draw.SimpleText("Boot Optimizer ON","Trebuchet18",90,11, Color(0,150,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
elseif gmbtclupl=="0" then
draw.RoundedBox(6,0,0,whtiendi:GetWide(),whtiendi:GetTall(),Color(0,117,223,255))
draw.RoundedBox(6,1,1,whtiendi:GetWide()-2,whtiendi:GetTall()-2,Color(255,255,255,255))
draw.RoundedBox(4,1,15,whtiendi:GetWide()-2,6,Color(200,210,255,255))
surface.SetDrawColor( 255,255,255, 255 ) 
surface.SetMaterial(Material("ngui/abcs.png"))surface.DrawTexturedRect(3,3,16,16)
draw.SimpleText("Boot Optimizer OFF","Trebuchet18",90,11, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
end
end
whtiendi.DoClick=function()
if gmbtclupl=="0" then
RunConsoleCommand("systembtclup","1")
LocalPlayer():EmitSound("ui/buttonclick.wav",100,200)
elseif gmbtclupl=="1" then
RunConsoleCommand("systembtclup","0")
LocalPlayer():EmitSound("ui/buttonclick.wav",100,160)
end
end

local whtiendi=vgui.Create("DButton",panel)
whtiendi:SetText("")
whtiendi:SetPos(10+185,125)
whtiendi:SetSize(180,22)
whtiendi.Paint=function()
draw.RoundedBox(6,0,0,whtiendi:GetWide(),whtiendi:GetTall(),Color(0,117,223,255))
draw.RoundedBox(6,1,1,whtiendi:GetWide()-2,whtiendi:GetTall()-2,Color(255,255,255,255))
draw.RoundedBox(4,1,15,whtiendi:GetWide()-2,6,Color(200,210,255,255))
surface.SetDrawColor( 0,0,255, 255 ) 
surface.SetMaterial(Material("icon16/arrow_refresh.png"))surface.DrawTexturedRect(3,3,16,16)
draw.SimpleText("Server Reboot","Trebuchet18",90,11, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
end
whtiendi.DoClick=function()
RunConsoleCommand("sacs_redemarrage")
LocalPlayer():EmitSound("ui/buttonclick.wav",100,200)
end

local whtiendi=vgui.Create("DButton",panel)
whtiendi:SetText("")
whtiendi:SetPos(10,175)
whtiendi:SetSize(320,22)
whtiendi.Paint=function()

draw.RoundedBox(6,0,0,whtiendi:GetWide(),whtiendi:GetTall(),Color(0,117,223,255))
draw.RoundedBox(6,1,1,whtiendi:GetWide()-2,whtiendi:GetTall()-2,Color(255,255,255,255))
draw.RoundedBox(4,1,15,whtiendi:GetWide()-2,6,Color(200,210,255,255))
draw.SimpleText(""..Nord_language.la_sacs_manuelcleana.."","Trebuchet18",170,11, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
surface.SetDrawColor( 255,255,255, 255 ) 
surface.SetMaterial(Material("ngui/sacs.png"))surface.DrawTexturedRect(3,3,16,16)
end
whtiendi.DoClick=function()
RunConsoleCommand("sacsmanual_removeent")
LocalPlayer():EmitSound("ui/buttonclick.wav",100,160)
end

local whtiendi=vgui.Create("DButton",panel)
whtiendi:SetText("")
whtiendi:SetPos(10,225)
whtiendi:SetSize(320,22)
whtiendi.Paint=function()

draw.RoundedBox(6,0,0,whtiendi:GetWide(),whtiendi:GetTall(),Color(0,117,223,255))
draw.RoundedBox(6,1,1,whtiendi:GetWide()-2,whtiendi:GetTall()-2,Color(255,255,255,255))
draw.RoundedBox(4,1,15,whtiendi:GetWide()-2,6,Color(200,210,255,255))
draw.SimpleText(Nord_language.la_sacs_manuelcleanb,"Trebuchet18",170,11, Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
surface.SetDrawColor( 255,255,255, 255 ) 
surface.SetMaterial(Material("ngui/sacs.png"))surface.DrawTexturedRect(3,3,16,16)
end
whtiendi.DoClick=function()
RunConsoleCommand("abcumanual_removeent")
LocalPlayer():EmitSound("ui/buttonclick.wav",100,160)
end
return panel
end
local function Makpoutil()
local panel = vgui.Create( "DFrame" )
panel:SetPos(0,0)
panel:SetTitle("")
panel:SetDraggable(false)
panel:ShowCloseButton(false)
panel.Paint=function()draw.RoundedBox(4,0,0,panel:GetWide(),panel:GetTall(),Color(255,255,255,255))
draw.RoundedBox(4,1,1,panel:GetWide()-2,panel:GetTall()-2,Color(0,0,0,255))
draw.SimpleText(Nord_language.la_sacs_outil1,"Trebuchet18",5,5,Color(255,255,255),TEXT_ALIGN_LEFT,0,1,Color(0,0,0,255))
end
local whtiendi=vgui.Create("DButton",panel)
whtiendi:SetText("")
whtiendi:SetPos(10,25)
whtiendi:SetSize(180,22)
whtiendi.Paint=function()
if sacsadme=="e" then
draw.RoundedBox(6,0,0,whtiendi:GetWide(),whtiendi:GetTall(),Color(0,223,0,255))
draw.RoundedBox(6,1,1,whtiendi:GetWide()-2,whtiendi:GetTall()-2,Color(255,255,255,255))
draw.RoundedBox(4,1,15,whtiendi:GetWide()-2,6,Color(210,255,210,255))
draw.SimpleText("Admin-Eyes ON","Trebuchet18",90,11, Color(0,150,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
surface.SetDrawColor( 255,255,255, 255 ) 
surface.SetMaterial(Material("icon16/eye.png"))surface.DrawTexturedRect(3,3,16,16)
elseif sacsadme==nil then
draw.RoundedBox(6,0,0,whtiendi:GetWide(),whtiendi:GetTall(),Color(223,0,0,255))
draw.RoundedBox(6,1,1,whtiendi:GetWide()-2,whtiendi:GetTall()-2,Color(255,255,255,255))
draw.RoundedBox(4,1,15,whtiendi:GetWide()-2,6,Color(255,210,210,255))
draw.SimpleText("Admin-Eyes OFF","Trebuchet18",90,11, Color(150,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
surface.SetDrawColor( 255,255,255, 255 ) 
surface.SetMaterial(Material("icon16/eye.png"))surface.DrawTexturedRect(3,3,16,16)
end

end
whtiendi.DoClick=function()
if sacsadme==nil then
sacsadme="e"
if i_Droit(LocalPlayer()) then
local function wh()
for k,v in pairs (ents.GetAll()) do
if v:IsPlayer() then
if sacsshply=="e" then
pos=v:GetPos()
pos=pos:ToScreen()
draw.RoundedBoxEx(0,pos.x,pos.y,8,8,Color(150,255,150,120))
draw.SimpleText(v:GetClass()..": "..v:Nick(),"Trebuchet18",pos.x+14,pos.y,Color(150,255,150),TEXT_ALIGN_LEFT,0)
end
elseif v:IsNPC() then
if sacsshnpc=="e" then
pos=v:GetPos()
pos=pos:ToScreen()
draw.RoundedBoxEx(0,pos.x,pos.y,8,8,Color(255,150,150,120))
draw.SimpleText(v:GetClass(),"Trebuchet18",pos.x+14,pos.y,Color(255,150,150),TEXT_ALIGN_LEFT,0)
end
elseif (v:GetClass()!="player" and v:GetClass()!="viewmodel" and v:GetClass()!="viewmodel" and v:GetClass()!="worldspawn" and v:GetClass()!="class C_BaseEntity") then 
pos=v:GetPos()
pos=pos:ToScreen()
if v.sacscol then
draw.RoundedBoxEx(0,pos.x,pos.y,8,8,v.sacscol)
draw.SimpleText(v:GetClass(),"Trebuchet18",pos.x+14,pos.y,v.sacscol,TEXT_ALIGN_LEFT,0)
else
draw.RoundedBoxEx(0,pos.x,pos.y,8,8,Color(255,255,255,120))
draw.SimpleText(v:GetClass(),"Trebuchet18",pos.x+14,pos.y,Color(255,255,255),TEXT_ALIGN_LEFT,0)
end
if sacsshmod=="e" then
if v:GetModel() then
draw.SimpleText(v:GetModel(),"Trebuchet18",pos.x+14,pos.y+10,Color(255,255,255),TEXT_ALIGN_LEFT,0)
else
draw.SimpleText("They are not model","Trebuchet18",pos.x+14,pos.y+10,Color(255,255,255),TEXT_ALIGN_LEFT,0)
end
end
end
end
end
hook.Add("HUDPaint","nordahl_sacs_admineye",wh);
end
LocalPlayer():EmitSound("ui/buttonclick.wav",100,200)
elseif sacsadme=="e" then
sacsadme=nil
hook.Remove("HUDPaint","nordahl_sacs_admineye");
LocalPlayer():EmitSound("ui/buttonclick.wav",100,160)
end
end
local whtiendi=vgui.Create("DButton",panel)
whtiendi:SetText("")
whtiendi:SetPos(200,25)
whtiendi:SetSize(180,22)
whtiendi.Paint=function()
if sacsadme==nil then return end
if sacsshmod=="e" then
draw.RoundedBox(6,0,0,whtiendi:GetWide(),whtiendi:GetTall(),Color(0,223,0,255))
draw.RoundedBox(6,1,1,whtiendi:GetWide()-2,whtiendi:GetTall()-2,Color(255,255,255,255))
draw.RoundedBox(4,1,15,whtiendi:GetWide()-2,6,Color(210,255,210,255))
draw.SimpleText("Show model folder ON","Trebuchet18",90,11, Color(0,150,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
elseif sacsshmod==nil then
draw.RoundedBox(6,0,0,whtiendi:GetWide(),whtiendi:GetTall(),Color(223,0,0,255))
draw.RoundedBox(6,1,1,whtiendi:GetWide()-2,whtiendi:GetTall()-2,Color(255,255,255,255))
draw.RoundedBox(4,1,15,whtiendi:GetWide()-2,6,Color(255,210,210,255))
draw.SimpleText("Show model folder OFF","Trebuchet18",90,11, Color(150,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
end

end
whtiendi.DoClick=function()
if sacsshmod=="e" then
sacsshmod=nil
LocalPlayer():EmitSound("ui/buttonclick.wav",100,200)
elseif sacsshmod==nil then
sacsshmod="e"
LocalPlayer():EmitSound("ui/buttonclick.wav",100,160)
end
end
local whtiendi=vgui.Create("DButton",panel)
whtiendi:SetText("")
whtiendi:SetPos(200,25+30)
whtiendi:SetSize(180,22)
whtiendi.Paint=function()
if sacsadme==nil then return end
if sacsshply=="e" then
draw.RoundedBox(6,0,0,whtiendi:GetWide(),whtiendi:GetTall(),Color(0,223,0,255))
draw.RoundedBox(6,1,1,whtiendi:GetWide()-2,whtiendi:GetTall()-2,Color(255,255,255,255))
draw.RoundedBox(4,1,15,whtiendi:GetWide()-2,6,Color(210,255,210,255))
draw.SimpleText(Nord_language.la_sacs_outil2.." ON","Trebuchet18",90,11, Color(0,150,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
elseif sacsshply==nil then
draw.RoundedBox(6,0,0,whtiendi:GetWide(),whtiendi:GetTall(),Color(223,0,0,255))
draw.RoundedBox(6,1,1,whtiendi:GetWide()-2,whtiendi:GetTall()-2,Color(255,255,255,255))
draw.RoundedBox(4,1,15,whtiendi:GetWide()-2,6,Color(255,210,210,255))
draw.SimpleText(Nord_language.la_sacs_outil2.." OFF","Trebuchet18",90,11, Color(150,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
end
end
whtiendi.DoClick=function()
if sacsshply=="e" then
sacsshply=nil
LocalPlayer():EmitSound("ui/buttonclick.wav",100,200)
elseif sacsshply==nil then
sacsshply="e"
LocalPlayer():EmitSound("ui/buttonclick.wav",100,160)
end
end
local whtiendi=vgui.Create("DButton",panel)
whtiendi:SetText("")
whtiendi:SetPos(200,25+60)
whtiendi:SetSize(180,22)
whtiendi.Paint=function()
if sacsadme==nil then return end
if sacsshnpc=="e" then
draw.RoundedBox(6,0,0,whtiendi:GetWide(),whtiendi:GetTall(),Color(0,223,0,255))
draw.RoundedBox(6,1,1,whtiendi:GetWide()-2,whtiendi:GetTall()-2,Color(255,255,255,255))
draw.RoundedBox(4,1,15,whtiendi:GetWide()-2,6,Color(210,255,210,255))
draw.SimpleText(Nord_language.la_sacs_outil3.." ON","Trebuchet18",90,11, Color(0,150,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
elseif sacsshnpc==nil then
draw.RoundedBox(6,0,0,whtiendi:GetWide(),whtiendi:GetTall(),Color(223,0,0,255))
draw.RoundedBox(6,1,1,whtiendi:GetWide()-2,whtiendi:GetTall()-2,Color(255,255,255,255))
draw.RoundedBox(4,1,15,whtiendi:GetWide()-2,6,Color(255,210,210,255))
draw.SimpleText(Nord_language.la_sacs_outil3.." OFF","Trebuchet18",90,11, Color(150,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
end
end
whtiendi.DoClick=function()
if sacsshnpc=="e" then
sacsshnpc=nil
LocalPlayer():EmitSound("ui/buttonclick.wav",100,200)
elseif sacsshnpc==nil then
sacsshnpc="e"
LocalPlayer():EmitSound("ui/buttonclick.wav",100,160)
end
end
return panel
end

local function NordahlEnvironment()
local Nordahl_DNumSlider={
[1]={"LookAheadTimeObjectsVsObject",zgmphjyscsz1,0.1,50,Nord_language.la_dnphys1},
[2]={"LookAheadTimeObjectsVsWorld",zgmphjyscsz2,0.1,50,Nord_language.la_dnphys2},
[3]={"MaxAngularVelocity",zgmphjyscsz3,0.1,14000,Nord_language.la_dnphys3},
[4]={"MaxCollisionChecksPerTimestep",zgmphjyscsz4,0.1,100000,Nord_language.la_dnphys4},
[5]={"MaxCollisionsPerObjectPerTimestep",zgmphjyscsz5,0.1,8000,Nord_language.la_dnphys5},
[6]={"MaxFrictionMass",zgmphjyscsz6,0.1,8000,Nord_language.la_dnphys6},
[7]={"MaxVelocity",zgmphjyscsz7,0.1,8000,Nord_language.la_dnphys7},
[8]={"MinFrictionMass",zgmphjyscsz8,0.1,8000,Nord_language.la_dnphys8},
[9]={"SetAirDensity",zgmphjyscsz9,0.1,8000,Nord_language.la_dnphys9},
[10]={"SetGravity(ent)",zgmphjyscsz10,-600,2000,Nord_language.la_dnphys10},
[11]={"SetGravity(ply)",zgmphjyscsz11,0,1000,Nord_language.la_dnphys11},
}
local panel = vgui.Create( "DFrame" )
panel:SetPos(0,0)
panel:SetTitle("")
panel:SetDraggable(false)
panel:ShowCloseButton(false)
panel.Paint=function()draw.RoundedBox(4,0,0,panel:GetWide(),panel:GetTall(),Color(255,255,255,255))
draw.RoundedBox(4,1,1,panel:GetWide()-2,panel:GetTall()-2,Color(0,0,0,255))
for k,v in ipairs(Nordahl_DNumSlider)do
local setposl=-9+(36*k)
draw.SimpleText(k..")"..v[5].." ".."(Def="..v[2]..",Min="..v[3]..",Max="..v[4]..")", "Trebuchet18", 5,setposl, Color(255,255,255), TEXT_ALIGN_LEFT,0,1, Color(255,255,255))
end
end

local butan2=vgui.Create("DButton",panel)
butan2:SetText("   Default Value")
butan2:SetPos(5,5)
butan2:SetWide(125)
butan2.Paint=function()
draw.RoundedBox(6,0,0,butan2:GetWide(),butan2:GetTall(),Color(0,117,223,255))
draw.RoundedBox(6,1,1,butan2:GetWide()-2,butan2:GetTall()-2,Color(255,255,255,255))
draw.RoundedBox(4,1,butan2:GetTall()-2-butan2:GetTall()/3,butan2:GetWide()-2,butan2:GetTall()/3,Color(200,210,255,255))
surface.SetDrawColor( 255,255,255, 255 ) 
surface.SetMaterial(Material("icon16/cross.png"))surface.DrawTexturedRect(3,3,16,16)
end

for k,v in ipairs(Nordahl_DNumSlider)do
local no_zw_volume=v[2]
local chiffrebarreslide = vgui.Create( "DNumSlider", panel )
local setposl=4+(36*k)
chiffrebarreslide:SetPos(1,setposl)
chiffrebarreslide:SetSize(718, 22 )
chiffrebarreslide:SetText("")
chiffrebarreslide:SetMin( v[3] )
chiffrebarreslide:SetMax( v[4] )
chiffrebarreslide:SetDecimals( 1 )
local valeurmax=v[4]/ 359

chiffrebarreslide.Paint=function()
draw.RoundedBox( 4, 0, 0, panel:GetWide()-2, chiffrebarreslide:GetTall(), Color(0, 0, 0, 255 ) )
draw.RoundedBox( 4, 1, 1, panel:GetWide()-4, chiffrebarreslide:GetTall()-2, Color( 255, 255, 255, 255 ) )
draw.RoundedBox( 0, 1, chiffrebarreslide:GetTall()/2, panel:GetWide()-4,(chiffrebarreslide:GetTall()/2)-2, Color( 225,225,255, 255 ) )
if k!=10 then
draw.RoundedBox( 0, 306, chiffrebarreslide:GetTall()/2,(no_zw_volume/valeurmax),(chiffrebarreslide:GetTall()/2)-2, Color(223,0,0, 150 ) )
draw.RoundedBox( 0, 306, chiffrebarreslide:GetTall()/2+(chiffrebarreslide:GetTall()/4)-1,(no_zw_volume/valeurmax),(chiffrebarreslide:GetTall()/4)-2, Color(223,0,0, 150 ) )
else
local no_zw_volume=no_zw_volume+600
local valeurmax=(600+v[4])/ 359
draw.RoundedBox( 0, 306, chiffrebarreslide:GetTall()/2,(no_zw_volume/valeurmax),(chiffrebarreslide:GetTall()/2)-2, Color(223,0,0, 150 ) )
draw.RoundedBox( 0, 306, chiffrebarreslide:GetTall()/2+(chiffrebarreslide:GetTall()/4)-1,(no_zw_volume/valeurmax),(chiffrebarreslide:GetTall()/4)-2, Color(223,0,0, 150 ) )
end
draw.SimpleText(v[1]..":", "Trebuchet18", 5,11, Color(0,0,0), TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER,1, Color(200,200,255))
draw.SimpleText(no_zw_volume, "Trebuchet18", 290,11, Color(0,117,223), TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER,1, Color(210,210,255))
end
chiffrebarreslide:SetValue( no_zw_volume )
chiffrebarreslide.ValueChanged = function(pSelf, fValue)
no_zw_volume=math.Round(fValue,1)
timer.Create("Sacs_PHYS_Perf"..k,0.5,1,function()
no_zw_volume=math.Round(fValue,1)
print("S.A.C.S_PHYS_Performance:"..v[1]..":",no_zw_volume)
RunConsoleCommand("Sacs_PHYS_Perf"..k,tostring(no_zw_volume))
end)
end
end

butan2.DoClick=function()
RunConsoleCommand("Default_PHYS_Performance")
LocalPlayer():EmitSound("ui/buttonclick.wav",100,160)
end

return panel
end
SACS.AddMenuTab(Nord_language.la_sacs_ongl2,"icon16/find.png",Nord_language.la_sacs_ongl2aid,MakePanelF,PopulateListF)
SACS.AddMenuTab(Nord_language.la_sacs_ongl3,"ngui/sacs.png",Nord_language.la_sacs_ongl3aid,MakePanel,PopulateList)
SACS.AddMenuTab("Boot Optimizer","ngui/abcs.png",Nord_language.la_sacs_ongl4aid,MakePanelB,PopulateListB)
SACS.AddMenuTab("Physical Environment","icon16/cog.png","Physics environment Set the Performance Settings.",NordahlEnvironment,nil)
SACS.AddMenuTab(Nord_language.la_sacs_ongl5,"icon16/wrench.png",Nord_language.la_sacs_ongl5aid,Makpopt,nil)
SACS.AddMenuTab(Nord_language.la_sacs_ongl6,"icon16/eye.png",Nord_language.la_sacs_ongl6aid,Makpoutil,nil)


local function sacslist_resetcl(a)
if i_Droit(a) then
Sacslist={}
end
end
concommand.Add("sacslist_resetcl",sacslist_resetcl)
local function abculist_resetcl(a)
if i_Droit(a) then
Abculist={}
end
end
concommand.Add("abculist_resetcl",abculist_resetcl)

local args={{Name=Nord_language.la_sacs_onglb31,Value="add_insacs"}}
SACS.RegisterCommand(f2panadwl,"zmoda_addsacsl",Nord_language.la_sacs_onglb31,args,true)

local function sacslist_update1(a,b,c)
if c[1]==nil then print("This is not the right command, Nordahl. ^^") return end
if c[2]==nil then print("This is not the right command, Nordahl. ^^") return end
local numline=tonumber(c[1])
local numline2=tonumber(c[2])
sacsys=tostring(c[3])
gmsacsclock=tonumber(c[4])
gmbtclupl=tostring(c[5])
local zloairme=CurTime()
if loadsacsbar then loadsacsbar:Remove() loadsacsbar=nil end
loadsacsbar=vgui.Create("DFrame")
loadsacsbar:SetPos(0,0)
loadsacsbar:SetSize(ScrW(),ScrH())
loadsacsbar:SetTitle("")
loadsacsbar:SetDraggable(false)
loadsacsbar:ShowCloseButton(false)
loadsacsbar.Think=function()
if sacszwusers1>=numline then
sacszwusers1=numline
end
if sacszwusers2>=numline2 then
sacszwusers2=numline2
end

if sacszwusers1>=numline and sacszwusers2>=numline2 then
loadsacsbar:Remove()
end
end
local scrW=ScrW()-185
local scrH=ScrH()-220
loadsacsbar.Paint=function()
draw.RoundedBox(6,(scrW)-176,(scrH)-1,352,112,Color(0,117,223,255))
draw.RoundedBox(6,(scrW)-175,(scrH),350,110,Color(255,255,255,255))

draw.SimpleText("S.A.C.S DOWNLOAD DATA"..": ", "Trebuchet18",scrW,(scrH)+15, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER, 2, Color(0,0,0,255))
draw.SimpleText("Reception des données S.A.C.S"..": "..sacszwusers1.."/"..numline, "Trebuchet18",scrW,(scrH)+35, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER, 2, Color(0,0,0,255))
draw.SimpleText("Reception des données A.B.C.S"..": "..sacszwusers2.."/"..numline2, "Trebuchet18",scrW,(scrH)+55, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER, 2, Color(0,0,0,255))
draw.RoundedBox(4,(scrW)-151,(scrH)+89-20,302,12,Color(0,117,223,255))
draw.RoundedBox(4,(scrW)-150,(scrH)+90-20,300,10,Color(0,0,50,255))
draw.RoundedBox(2,(scrW)-150,(scrH)+90-20,(300/numline)*sacszwusers1,10,Color(0,117,223,255))
draw.RoundedBox(2,(scrW)-150,(scrH)+97-20,(300/numline)*sacszwusers1,3,Color(0,100,170,255))

surface.SetDrawColor( 255,255,255, 255 )
surface.SetMaterial(Material("ngui/sacs.png"))surface.DrawTexturedRect((scrW)-150-20,(scrH)+97-31,16,16)
draw.RoundedBox(4,(scrW)-151,(scrH)+89,302,12,Color(0,117,223,255))
draw.RoundedBox(4,(scrW)-150,(scrH)+90,300,10,Color(0,0,50,255))
draw.RoundedBox(2,(scrW)-150,(scrH)+90,(300/numline2)*sacszwusers2,10,Color(0,117,223,255))
draw.RoundedBox(2,(scrW)-150,(scrH)+97,(300/numline2)*sacszwusers2,3,Color(0,100,170,255))
surface.SetDrawColor( 255,255,255, 255 )
surface.SetMaterial(Material("ngui/abcs.png"))surface.DrawTexturedRect((scrW)-150-20,(scrH)+97-11,16,16)
end
end
concommand.Add("sacslist_update1",sacslist_update1)



local function nord_context(ent)
if !IsValid(ent) then return end
local EntIndex=ent:EntIndex()
local GetClass=ent:GetClass()
local getPos=ent:GetPos()
jcosacs_menu = vgui.Create("DFrame")
jcosacs_menu:SetSize(300,24)
jcosacs_menu:SetPos(ScrW()/2+150,ScrH()/2-150)
jcosacs_menu:SetTitle(" ")
jcosacs_menu:SetDraggable(true)
jcosacs_menu:ShowCloseButton(false)
jcosacs_menu:MakePopup()
jcosacs_menu.Paint=function()
if !IsValid(ent) then
if jcosacs_menu then
jcosacs_menu:Remove()
jcosacs_menu=nil
end
return end
end
local jo_but=vgui.Create("DButton",jcosacs_menu)
jo_but:SetText("")
jo_but:SetSize(300,24)
jo_but:SetPos(0,0)
jo_but.Paint=function()
if !IsValid(ent) then
if jcosacs_menu then
jcosacs_menu:Remove()
jcosacs_menu=nil
end
return end
draw.RoundedBox(4,0,0,jo_but:GetWide(),jo_but:GetTall(),Color(26,138,200,255))
draw.RoundedBox(4,1,1,jo_but:GetWide()-2,jo_but:GetTall()-2,Color(255,255,255,255))
surface.SetDrawColor(255,255,255,255) 
surface.SetMaterial(Material("ngui/sacs.png"))surface.DrawTexturedRect(4,4,16,16)
draw.SimpleText("Nordahl S.A.C.S system Ver"..sacsver, "Trebuchet18", 28, 12, Color(26,138,200), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
end
jo_but.DoClick=function()surface.PlaySound("ambient/machines/keyboard5_clicks.wav")
if jcosacs_menu then
jcosacs_menu:Remove()
jcosacs_menu=nil
end
local z4=DermaMenu()
z4:AddOption(Nord_language.la_sacs_onglb31.." -> "..Nord_language.la_sacs_ongl3,function()
RunConsoleCommand("zmoda_addsacsl",GetClass,LocalPlayer():Nick())end):SetImage("ngui/sacs.png")
z4:AddSpacer()
z4:AddOption(Nord_language.la_sacs_onglb31.." -> "..Nord_language.la_sacs_ongl4,function()
RunConsoleCommand("zmoda_addabcul",GetClass,LocalPlayer():Nick())
end):SetImage("ngui/abcs.png")
z4:AddSpacer()
z4:AddOption(Nord_language.la_sacs_onglb31.." only this one -> "..Nord_language.la_sacs_ongl4,function()
RunConsoleCommand("zmoda_addabcu2",EntIndex,LocalPlayer():Nick())
end):SetImage("ngui/abcs.png")
z4.Paint=function()
draw.RoundedBox(4,0,0,z4:GetWide(),z4:GetTall(),Color(26,138,200,255))
draw.RoundedBox(4,1,1,z4:GetWide()-2,z4:GetTall()-2,Color(255,255,255,255))
end
z4:Open()
end
end

-- hook.Add( "OnContextMenuOpen","nordahl_contextmenu_sacs_1",function(a,b,c)
-- if i_Droit(LocalPlayer())==true then
-- local etr=LocalPlayer():GetEyeTrace()
-- local ent=etr.Entity
-- if IsValid(ent) then
-- if ent.IsPlayer()!=true then
-- nord_context(ent)
-- end
-- end
-- end
-- end)

-- hook.Add( "OnContextMenuClose","nordahl_contextmenu_sacs_0",function(a,b,c)
-- if jcosacs_menu then
-- jcosacs_menu:Remove()
-- jcosacs_menu=nil
-- end
-- end)