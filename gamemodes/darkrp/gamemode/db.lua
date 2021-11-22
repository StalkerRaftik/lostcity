rp._Stats   = mysql(RP_MySQLConfig.Host,RP_MySQLConfig.Username, RP_MySQLConfig.Password, RP_MySQLConfig.Database_name, RP_MySQLConfig.Database_port)
rp._Credits = mysql(RP_MySQLConfig.Host,RP_MySQLConfig.Username, RP_MySQLConfig.Password, RP_MySQLConfig.Database_name, RP_MySQLConfig.Database_port)

-- БЫЛО ПЕРЕНЕСЕНО В ADMINTOOL(data_sv.lua)
-- RP_MySQLConfig = {}
-- RP_MySQLConfig.EnableMySQL = true
-- RP_MySQLConfig.Host = "37.230.210.224"
-- RP_MySQLConfig.Username = "admin_lcdev"
-- RP_MySQLConfig.Password = "kirill953944"
-- RP_MySQLConfig.Database_name = "admin_lcdev"
-- RP_MySQLConfig.Database_port = 8083
-- RP_MySQLConfig.Preferred_module = "tmysql4"
-- RP_MySQLConfig.MultiStatements = false
