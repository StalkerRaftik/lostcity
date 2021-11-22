/**
* Database configuration
**/

RP_MySQLConfig = RP_MySQLConfig or {}

if table.IsEmpty(RP_MySQLConfig) then
	RP_MySQLConfig.EnableMySQL = true
	RP_MySQLConfig.Host = "37.230.210.224"
	RP_MySQLConfig.Username = "admin_lostcity"
	RP_MySQLConfig.Password = "kirill953944"
	RP_MySQLConfig.Database_name = "admin_lostcity"
	RP_MySQLConfig.Database_port = 3306
	RP_MySQLConfig.Preferred_module = "tmysql4"
	RP_MySQLConfig.MultiStatements = false
end


-- Which database mode to use.
-- Available modes: mysqloo, sqlite
SH_WHITELIST.DatabaseMode = "sqlite"

-- If mysqloo is enabled above, the login info for the MySQL server.
-- The tables will be created automatically.
SH_WHITELIST.DatabaseConfig = {
	host = RP_MySQLConfig.Host,
	user = RP_MySQLConfig.Username,
	password = RP_MySQLConfig.Password,
	database = RP_MySQLConfig.Database_name,
	port = 3306,
}