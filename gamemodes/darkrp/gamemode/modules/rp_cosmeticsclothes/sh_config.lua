MsgC(Color(255,0,0), "[Cosmetics]", Color(255,255,255), "Loading files...")
Cosmetics = Cosmetics or {}
Cosmetics.Config = Cosmetics.Config or {}
Cosmetics.Config.Sentences = {}
Cosmetics.Male = Cosmetics.Male or {}
Cosmetics.Male.ListDefaultPM = {}
Cosmetics.Female = Cosmetics.Female or {}
Cosmetics.Female.ListDefaultPM = {}

Cosmetics.Config.CommunityName = "Your Community Name"

Cosmetics.Config.PriceChangingName = 500
Cosmetics.Config.MoneyUnit = "$"

-- Price of the top (empty) and price added per text/img
Cosmetics.Config.EditableTop = 800
Cosmetics.Config.PricePerText = 100
Cosmetics.Config.PricePerImg = 200

-- surgery prices
Cosmetics.Config.PriceToChangeSex = 5000
Cosmetics.Config.PriceToChangeHead = 2500
Cosmetics.Config.PriceToChangeEyes = 1000

-- http://wiki.garrysmod.com/page/Enums/BUTTON_CODE
Cosmetics.Config.KeyInventory = KEY_I

-- Sound in the introduction menu? true = yes, false = no
Cosmetics.Config.HasSound = true
-- upload a .mp3 of your sound and put the link to it here
Cosmetics.Config.IntroSoundURL = "https://s25.onlinevideoconverter.com/download?file=f5e4e4j9d3b1g6"
timer.Simple( 1, function()
-- list of jobs with uniforms, the players will have the models of the job instead of their one.
	-- player in these teams will not keep their heads
Cosmetics.Config.ForbiddenJobs = {	
}

for k,v in pairs(rp.teams) do
	if v.command ~= "citizen" then
		Cosmetics.Config.ForbiddenJobs[k] = true
	end
end
	-- player in these teams will just keep their head but their uniform will change
	-- https://steamcommunity.com/sharedfiles/filedetails/?id=576517817
Cosmetics.Config.ForbiddenJobsWithHeads = {
  -- [TEAM_POLICE] = {
  --   'models/taggart/police01/male_01.mdl',
  --   'models/taggart/police01/male_02.mdl',
  --   'models/taggart/police01/male_03.mdl',
  --   'models/taggart/police01/male_04.mdl',
  --   'models/taggart/police01/male_05.mdl',
  --   'models/taggart/police01/male_06.mdl',
  --   'models/taggart/police01/male_07.mdl',
  --   'models/taggart/police01/male_08.mdl',
  --   'models/taggart/police01/male_09.mdl',
  -- },
  -- [TEAM_POLICE2] = {
  --   'models/taggart/police01/male_01.mdl',
  --   'models/taggart/police01/male_02.mdl',
  --   'models/taggart/police01/male_03.mdl',
  --   'models/taggart/police01/male_04.mdl',
  --   'models/taggart/police01/male_05.mdl',
  --   'models/taggart/police01/male_06.mdl',
  --   'models/taggart/police01/male_07.mdl',
  --   'models/taggart/police01/male_08.mdl',
  --   'models/taggart/police01/male_09.mdl',
  -- },
  -- [TEAM_POLICE3] = {
  --   'models/taggart/police01/male_01.mdl',
  --   'models/taggart/police01/male_02.mdl',
  --   'models/taggart/police01/male_03.mdl',
  --   'models/taggart/police01/male_04.mdl',
  --   'models/taggart/police01/male_05.mdl',
  --   'models/taggart/police01/male_06.mdl',
  --   'models/taggart/police01/male_07.mdl',
  --   'models/taggart/police01/male_08.mdl',
  --   'models/taggart/police01/male_09.mdl',
  -- },
  -- [TEAM_POLICE4] = {
  --   'models/taggart/police01/male_01.mdl',
  --   'models/taggart/police01/male_02.mdl',
  --   'models/taggart/police01/male_03.mdl',
  --   'models/taggart/police01/male_04.mdl',
  --   'models/taggart/police01/male_05.mdl',
  --   'models/taggart/police01/male_06.mdl',
  --   'models/taggart/police01/male_07.mdl',
  --   'models/taggart/police01/male_08.mdl',
  --   'models/taggart/police01/male_09.mdl',
  -- },
  -- [TEAM_POLICE5] = {
  --   'models/taggart/police01/male_01.mdl',
  --   'models/taggart/police01/male_02.mdl',
  --   'models/taggart/police01/male_03.mdl',
  --   'models/taggart/police01/male_04.mdl',
  --   'models/taggart/police01/male_05.mdl',
  --   'models/taggart/police01/male_06.mdl',
  --   'models/taggart/police01/male_07.mdl',
  --   'models/taggart/police01/male_08.mdl',
  --   'models/taggart/police01/male_09.mdl',
  -- },
  -- [TEAM_POLICE6] = {
  --   'models/taggart/police01/male_01.mdl',
  --   'models/taggart/police01/male_02.mdl',
  --   'models/taggart/police01/male_03.mdl',
  --   'models/taggart/police01/male_04.mdl',
  --   'models/taggart/police01/male_05.mdl',
  --   'models/taggart/police01/male_06.mdl',
  --   'models/taggart/police01/male_07.mdl',
  --   'models/taggart/police01/male_08.mdl',
  --   'models/taggart/police01/male_09.mdl',
  -- },
}
end)
-- Usergroups who can use the admin commands ( see the list in the addon description )
Cosmetics.Config.ModGroups = {
	"owner",
	"founder",
	"superadmin",
}

-- DON'T TOUCH THE THINGS BELOW IF YOU DON'T KNOW WHAT YOU'RE DOING

--[[
	FEMALE PART
				--]]

Cosmetics.Female.ListEyesTextures = {
	["amber"] = {
		["r"] = "eyes/eyes/amber_r",
		["l"] = "eyes/eyes/amber_l"
	},
	["blackopal"] = {
		["r"] = "eyes/eyes/blackopal_r",
		["l"] = "eyes/eyes/blackopal_l"
	},
	["blue"] = {
		["r"] = "eyes/eyes/blue_r",
		["l"] = "eyes/eyes/blue_l"
	},
	["brown"] = {
		["r"] = "eyes/eyes/brown_r",
		["l"] = "eyes/eyes/brown_l"
	},
	["emerald"] = {
		["r"] = "eyes/eyes/emerald_r",
		["l"] = "eyes/eyes/emerald_l"
	},
	["granite"] = {
		["r"] = "eyes/eyes/granite_r",
		["l"] = "eyes/eyes/granite_l"
	},
	["hazel"] = {
		["r"] = "eyes/eyes/hazel_r",
		["l"] = "eyes/eyes/hazel_l"
	},
	["ice"] = {
		["r"] = "eyes/eyes/ice_r",
		["l"] = "eyes/eyes/ice_l"
	},
	["sapphire"] = {
		["r"] = "eyes/eyes/sapphire_r",
		["l"] = "eyes/eyes/sapphire_l"
	},
}
--
Cosmetics.Female.ListDefaultPM["models/kerry/player/citizen/female_01.mdl"] = {
	skins = { 0,1,2,3,4 },
	sex = 0,
	name = "female01",
	bodygroupstop = {
		["polo"] = {
			group = {1,0},
			tee = {
				4,
			},
		},
		["jacket"] = {
			group = {1,1},
			tee = {
				5,
			},
		},
		["tee"] = {
			group = {1,2},
			tee = {
				7,
			},
		},
		["suit"] = {
			group = {1,3},
			tee = {
				8,
			},
		},
		["nude"] = {
			group = {1,4},
			tee = {
				6,
			},
		},
	},
	bodygroupsbottom = {
		["pant"] = {
			group = {2,0},
			pant = {
				10,
			},
		},
		["nude"] = {
			group = {2,2},
			pant = {
				6,
			},
		},
		["suit"] = {
			group = {2,1},
			pant = {
				10,
			},
		},
	},
	eyes = {
		["r"] = 2,
		["l"] = 1
	},
}
Cosmetics.Female.ListDefaultPM["models/kerry/player/citizen/female_02.mdl"] = {
	skins = { 0,1,2,3 },
	sex = 0,
	name = "female02",
	bodygroupstop = {
		["polo"] = {
			group = {1,0},
			tee = {
				5,
			},
		},
		["jacket"] = {
			group = {1,1},
			tee = {
				6,
			},
		},
		["tee"] = {
			group = {1,2},
			tee = {
				8,
			},
		},
		["suit"] = {
			group = {1,3},
			tee = {
				9,
			},
		},
		["nude"] = {
			group = {1,4},
			tee = {
				7,
			},
		},
	},
	bodygroupsbottom = {
		["pant"] = {
			group = {2,0},
			pant = {
				11,
			},
		},
		["nude"] = {
			group = {2,2},
			pant = {
				7,
			},
		},
		["suit"] = {
			group = {2,1},
			pant = {
				12,
			},
		},
	},
	eyes = {
		["r"] = 0,
		["l"] = 4
	},
}
Cosmetics.Female.ListDefaultPM["models/kerry/player/citizen/female_03.mdl"] = { -- issue on this model
	skins = { 0,1,2,3,4,5,6 },
	sex = 0,
	name = "female03",
	bodygroupstop = {
		["polo"] = {
			group = {1,0},
			tee = {
				4,
			},
		},
		["jacket"] = {
			group = {1,1},
			tee = {
				5,
			},
		},
		["tee"] = {
			group = {1,2},
			tee = {
				7,
			},
		},
		["suit"] = {
			group = {1,3},
			tee = {
				8,
			},
		},
		["nude"] = {
			group = {1,4},
			tee = {
				6,
			},
		},
	},
	bodygroupsbottom = {
		["pant"] = {
			group = {2,0},
			pant = {
				10,
			},
		},
		["nude"] = {
			group = {2,2},
			pant = {
				6,
			},
		},
		["suit"] = {
			group = {2,1},
			pant = {
				11,
			},
		},
	},
	eyes = {
		["r"] = 3,
		["l"] = 2
	},
}
Cosmetics.Female.ListDefaultPM["models/kerry/player/citizen/female_04.mdl"] = { -- issue on this model
	skins = { 0,1,2,3,4 },
	sex = 0,
	name = "female04",
	bodygroupstop = {
		["polo"] = {
			group = {1,0},
			tee = {
				4,
			},
		},
		["jacket"] = {
			group = {1,1},
			tee = {
				5,
			},
		},
		["tee"] = {
			group = {1,2},
			tee = {
				7,
			},
		},
		["suit"] = {
			group = {1,3},
			tee = {
				8,
			},
		},
		["nude"] = {
			group = {1,4},
			tee = {
				6,
			},
		},
	},
	bodygroupsbottom = {
		["pant"] = {
			group = {2,0},
			pant = {
				11,
			},
		},
		["nude"] = {
			group = {2,2},
			pant = {
				6,
			},
		},
		["suit"] = {
			group = {2,1},
			pant = {
				12,
			},
		},
	},
	eyes = {
		["r"] = 2,
		["l"] = 1
	},
}
Cosmetics.Female.ListDefaultPM["models/kerry/player/citizen/female_05.mdl"] = { -- issue on this model
	skins = { 0,1,2,3,4 },
	sex = 0,
	name = "female05",
	bodygroupstop = {
		["polo"] = {
			group = {1,0},
			tee = {
				4,
			},
		},
		["jacket"] = {
			group = {1,1},
			tee = {
				5,
			},
		},
		["tee"] = {
			group = {1,2},
			tee = {
				7,
			},
		},
		["suit"] = {
			group = {1,3},
			tee = {
				8,
			},
		},
		["nude"] = {
			group = {1,4},
			tee = {
				6,
			},
		},
	},
	bodygroupsbottom = {
		["pant"] = {
			group = {2,0},
			pant = {
				10,
			},
		},
		["nude"] = {
			group = {2,2},
			pant = {
				6,
			},
		},
		["suit"] = {
			group = {2,1},
			pant = {
				11,
			},
		},
	},
	eyes = {
		["r"] = 1,
		["l"] = 2
	},
}
Cosmetics.Female.ListDefaultPM["models/kerry/player/citizen/female_06.mdl"] = { -- issue on this model
	skins = { 0,1,2,3,4,5 },
	sex = 0,
	name = "female06",
	bodygroupstop = {
		["polo"] = {
			group = {1,0},
			tee = {
				4,
			},
		},
		["jacket"] = {
			group = {1,1},
			tee = {
				5,
			},
		},
		["tee"] = {
			group = {1,2},
			tee = {
				7,
			},
		},
		["suit"] = {
			group = {1,3},
			tee = {
				8,
			},
		},
		["nude"] = {
			group = {1,4},
			tee = {
				6,
			},
		},
	},
	bodygroupsbottom = {
		["pant"] = {
			group = {2,0},
			pant = {
				10,
			},
		},
		["nude"] = {
			group = {2,2},
			pant = {
				6,
			},
		},
		["suit"] = {
			group = {2,1},
			pant = {
				11,
			},
		},
	},
	eyes = {
		["r"] = 1,
		["l"] = 2
	},
}

Cosmetics.Female.ListBottoms = {
	["?????????? 1 (??????.)"] = {
		texture = "models/humans/modern/female/sheet_01",
		bodygroup = "pant",
		default = true,
		category = {
			"??????????",
		},
		price = 800,
	},
	["?????????? 2 (??????.)"] = {
		texture = "models/humans/modern/female/sheet_02",
		bodygroup = "pant",
		default = true,
		category = {
			"??????????",
		},
		price = 800,
	},
	["?????????? 3 (??????.)"] = {
		texture = "models/humans/modern/female/sheet_03",
		bodygroup = "pant",
		default = true,
		category = {
			"??????????",
		},
		price = 800,
	},
	["?????????? 4 (??????.)"] = {
		texture = "models/humans/modern/female/sheet_04",
		bodygroup = "pant",
		default = true,
		category = {
			"??????????",
		},
		price = 800,
	},
	["?????????? 5 (??????.)"] = {
		texture = "models/humans/modern/female/sheet_05",
		bodygroup = "pant",
		default = true,
		category = {
			"??????????",
		},
		price = 800,
	},
	["?????????? 6 (??????.)"] = {
		texture = "models/humans/modern/female/sheet_06",
		bodygroup = "pant",
		default = true,
		category = {
			"??????????",
		},
		price = 800,
	},
	["?????????? 7 (??????.)"] = {
		texture = "models/humans/modern/female/sheet_07",
		bodygroup = "pant",
		default = true,
		category = {
			"??????????",
		},
		price = 800,
	},
	["?????????? 8 (??????.)"] = {
		texture = "models/humans/modern/female/sheet_08",
		bodygroup = "pant",
		default = true,
		category = {
			"??????????",
		},
		price = 800,
	},
	["?????????? 9 (??????.)"] = {
		texture = "models/humans/modern/female/sheet_09",
		bodygroup = "pant",
		default = true,
		category = {
			"??????????",
		},
		price = 800,
	},
	["?????????? 10 (??????.)"] = {
		texture = "models/humans/modern/female/sheet_10",
		bodygroup = "pant",
		default = true,
		category = {
			"??????????",
		},
		price = 800,
	},
	["?????????? 11 (??????.)"] = {
		texture = "models/humans/modern/female/sheet_11",
		bodygroup = "pant",
		default = true,
		category = {
			"??????????",
		},
		price = 800,
	},
	["?????????? 12 (??????.)"] = {
		texture = "models/humans/modern/female/sheet_12",
		bodygroup = "pant",
		default = true,
		category = {
			"??????????",
		},
		price = 800,
	},
	["?????????? 13 (??????.)"] = {
		texture = "models/humans/modern/female/sheet_13",
		bodygroup = "pant",
		default = true,
		category = {
			"??????????",
		},
		price = 800,
	},
	["?????????? 14 (??????.)"] = {
		texture = "models/humans/modern/female/sheet_14",
		bodygroup = "pant",
		default = true,
		category = {
			"??????????",
		},
		price = 800,
	},
	["?????????? 15 (??????.)"] = {
		texture = "models/humans/modern/female/sheet_15",
		bodygroup = "pant",
		default = true,
		category = {
			"??????????",
		},
		price = 800,
	},
	
	["???????????? 1 (??????.)"] = {
		texture = "models/citizen/female/leg/suit_sheet2",
		bodygroup = "suit",
		default = false,
		category = {
			"??????????",
			"????????????",
		},
		price = 3000,
	},
}
--
Cosmetics.Female.ListTops = {
	["???????????????? 1 (??????.)"] = {
		texture = "models/humans/modern/female/sheet_01",
		bodygroup = "polo",
		default = true,
		category = {
			"????????-?? ????????????",
			"????????",
		},
		price = 600,
	},
	["???????????????? 2 (??????.)"] = {
		texture = "models/humans/modern/female/sheet_02",
		bodygroup = "polo",
		default = true,
		category = {
			"????????-?? ????????????",
			"????????",
		},
		price = 600,
	},
	["???????????????? 3 (??????.)"] = {
		texture = "models/humans/modern/female/sheet_03",
		bodygroup = "polo",
		default = true,
		category = {
			"????????-?? ????????????",
			"????????",
		},
		price = 600,
	},
	["???????????????? 4 (??????.)"] = {
		texture = "models/humans/modern/female/sheet_04",
		bodygroup = "polo",
		default = true,
		category = {
			"????????-?? ????????????",
			"????????",
		},
		price = 600,
	},
	["???????????????? 5 (??????.)"] = {
		texture = "models/humans/modern/female/sheet_05",
		bodygroup = "polo",
		default = true,
		category = {
			"????????-?? ????????????",
			"????????",
		},
		price = 600,
	},
	["???????????????? 6 (??????.)"] = {
		texture = "models/humans/modern/female/sheet_06",
		bodygroup = "polo",
		default = true,
		category = {
			"????????-?? ????????????",
			"????????",
		},
		price = 600,
	},
	["???????????????? 8 (??????.)"] = {
		texture = "models/humans/modern/female/sheet_08",
		bodygroup = "polo",
		default = true,
		category = {
			"????????-?? ????????????",
			"????????",
		},
		price = 600,
	},
	["???????????????? 9 (??????.)"] = {
		texture = "models/humans/modern/female/sheet_09",
		bodygroup = "polo",
		default = true,
		category = {
			"????????-?? ????????????",
			"????????",
		},
		price = 600,
	},
	["???????????????? 10 (??????.)"] = {
		texture = "models/humans/modern/female/sheet_10",
		bodygroup = "polo",
		default = true,
		category = {
			"????????-?? ????????????",
			"????????",
		},
		price = 600,
	},
	["???????????????? 11 (??????.)"] = {
		texture = "models/humans/modern/female/sheet_11",
		bodygroup = "polo",
		default = true,
		category = {
			"????????-?? ????????????",
			"????????",
		},
		price = 600,
	},
	["???????????????? 12 (??????.)"] = {
		texture = "models/humans/modern/female/sheet_12",
		bodygroup = "polo",
		default = true,
		category = {
			"????????-?? ????????????",
			"????????",
		},
		price = 600,
	},
	["???????????????? 13 (??????.)"] = {
		texture = "models/humans/modern/female/sheet_13",
		bodygroup = "polo",
		default = true,
		category = {
			"????????-?? ????????????",
			"????????",
		},
		price = 600,
	},
	["???????????????? 14 (??????.)"] = {
		texture = "models/humans/modern/female/sheet_14",
		bodygroup = "polo",
		default = true,
		category = {
			"????????-?? ????????????",
			"????????",
		},
		price = 600,
	},
	["???????????????? 15 (??????.)"] = {
		texture = "models/humans/modern/female/sheet_15",
		bodygroup = "polo",
		default = true,
		category = {
			"????????-?? ????????????",
			"????????",
		},
		price = 600,
	},
	["???????????????? 7 (??????.)"] = {
		texture = "models/humans/modern/female/sheet_15",
		bodygroup = "polo",
		default = true,
		category = {
			"????????-?? ????????????",
			"????????",
		},
		price = 600,
	},
	["???????????? 1 (??????.)"] = {
		texture = "models/bloo_ltcom_zel/citizens/prague_civ_rioter_body_col_a",
		bodygroup = "jacket",
		default = false,
		category = {
			"????????????",
		},
		price = 1000,
	},
	["?????????? ?????????? (??????.)"] = {
		texture = "models/bloo_ltcom_zel/citizens/prague_civ_rioter_body_col_b",
		bodygroup = "jacket",
		default = false,
		category = {
			"????????????",
		},
		price = 1000,
	},["???????????? 3 (??????.)"] = {
		texture = "models/bloo_ltcom_zel/citizens/prague_civ_rioter_body_col_c",
		bodygroup = "jacket",
		default = false,
		category = {
			"????????????",
		},
		price = 1000,
	},
	["???????????????? 16 (??????.)"] = {
		texture = "models/citizen/female/body/suit_sheet",
		bodygroup = "suit",
		default = false,
		category = {
			"????????????",
		},
		price = 2000,
	},
	
	["???????????????? 17 (??????.)"] = {
		texture = "models/humans/enhancedshortsleeved/citizen_sheet",
		bodygroup = "tee",
		default = false,
		category = {
			"??????-?? ????????????",
			"????????????????",
		},
		price = 400,
	},
	["???????????????? 18 (??????.)"] = {
		texture = "models/humans/enhancedshortsleeved/citizen_sheet2",
		bodygroup = "tee",
		default = false,
		category = {
			"??????-?? ????????????",
			"????????????????",
		},
		price = 400,
	},
	["???????????????? 19 (??????.)"] = {
		texture = "models/humans/enhancedshortsleeved/citizen_sheet3",
		bodygroup = "tee",
		default = false,
		category = {
			"??????-?? ????????????",
			"????????????????",
		},
		price = 400,
	},
	["???????????????? 20 (??????.)"] = {
		texture = "models/humans/enhancedshortsleeved/citizen_sheet4",
		bodygroup = "tee",
		default = false,
		category = {
			"??????-?? ????????????",
			"????????????????",
		},
		price = 400,
	},
}

Cosmetics.Female.EditableTop = {
	["models/humans/enhancedshortsleeved/citizen_sheet"] = {
		sizex = 70,
		sizey = 120,
		posx = 35,
		posy = 175,
		bodygroup = "tee"
	},
	["models/humans/enhancedshortsleeved/citizen_sheet2"] = {
		sizex = 70,
		sizey = 120,
		posx = 35,
		posy = 175,
		bodygroup = "tee"
	},
	["models/humans/enhancedshortsleeved/citizen_sheet3"] = {
		sizex = 70,
		sizey = 120,
		posx = 35,
		posy = 175,
		bodygroup = "tee"
	},
	["models/humans/enhancedshortsleeved/citizen_sheet4"] = {
		sizex = 70,
		sizey = 120,
		posx = 35,
		posy = 175,
		bodygroup = "tee"
	},
}

--[[
	MALE PART
			  --]]

Cosmetics.Male.ListEyesTextures = {
	["amber"] = {
		["r"] = "eyes/eyes/amber_r",
		["l"] = "eyes/eyes/amber_l"
	},
	["blackopal"] = {
		["r"] = "eyes/eyes/blackopal_r",
		["l"] = "eyes/eyes/blackopal_l"
	},
	["blue"] = {
		["r"] = "eyes/eyes/blue_r",
		["l"] = "eyes/eyes/blue_l"
	},
	["brown"] = {
		["r"] = "eyes/eyes/brown_r",
		["l"] = "eyes/eyes/brown_l"
	},
	["emerald"] = {
		["r"] = "eyes/eyes/emerald_r",
		["l"] = "eyes/eyes/emerald_l"
	},
	["granite"] = {
		["r"] = "eyes/eyes/granite_r",
		["l"] = "eyes/eyes/granite_l"
	},
	["hazel"] = {
		["r"] = "eyes/eyes/hazel_r",
		["l"] = "eyes/eyes/hazel_l"
	},
	["ice"] = {
		["r"] = "eyes/eyes/ice_r",
		["l"] = "eyes/eyes/ice_l"
	},
	["sapphire"] = {
		["r"] = "eyes/eyes/sapphire_r",
		["l"] = "eyes/eyes/sapphire_l"
	},
}
--
Cosmetics.Male.ListDefaultPM["models/kerry/player/citizen/male_09.mdl"] = {
	skins = { 0,1,2,3,4,5,6,7 },
	sex = 1, -- 1 = male, 0 = female
	name = "male09",
	bodygroupstop = {
		["polo"] = {
			group = {1,0},
			tee = {
				4,
			},
		},
		["jacket"] = {
			group = {1,1},
			tee = {
				5,
			},
		},
		["suit"] = {
			group = {1,2},
			tee = {
				6,
			},
		},
		["nude"] = {
			group = {1,4},
			tee = {
				8,
			},
		},
		["tee"] = {
			group = {1,3},
			tee = {
				7,
			},
		},
	},
	bodygroupsbottom = {
		["pant"] = {
			group = {2,0},
			pant = {
				9,
			}
		},
		["nude"] = {
			group = {2,2},
			pant = {
				8,
			},
		},
		["suit"] = {
			group = {2,1},
			pant = {
				12,
			},
		},
	},
	eyes = {
		["r"] = 1,
		["l"] = 2
	},
}
Cosmetics.Male.ListDefaultPM["models/kerry/player/citizen/male_08.mdl"] = {
	skins = { 0,1,2,3,4,5,6,7 },
	sex = 1, -- 1 = male, 0 = female
	name = "male08",
	bodygroupstop = {
		["polo"] = {
			group = {1,0},
			tee = {
				4,
			},
		},
		["jacket"] = {
			group = {1,1},
			tee = {
				5,
			},
		},
		["suit"] = {
			group = {1,2},
			tee = {
				6,
			},
		},
		["nude"] = {
			group = {1,4},
			tee = {
				8,
			},
		},
		["tee"] = {
			group = {1,3},
			tee = {
				7,
			},
		},
	},
	bodygroupsbottom = {
		["pant"] = {
			group = {2,0},
			pant = {
				9,
			}
		},
		["nude"] = {
			group = {2,2},
			pant = {
				8,
			},
		},
		["suit"] = {
			group = {2,1},
			pant = {
				12,
			},
		},
	},
	eyes = {
		["r"] = 2,
		["l"] = 1
	},
}
Cosmetics.Male.ListDefaultPM["models/kerry/player/citizen/male_07.mdl"] = {
	skins = { 0,1,2,3,4,5,6,7 },
	sex = 1, -- 1 = male, 0 = female
	name = "male07",
	bodygroupstop = {
		["polo"] = {
			group = {1,0},
			tee = {
				4,
			},
		},
		["jacket"] = {
			group = {1,1},
			tee = {
				5,
			},
		},
		["suit"] = {
			group = {1,2},
			tee = {
				6,
			},
		},
		["nude"] = {
			group = {1,4},
			tee = {
				8,
			},
		},
		["tee"] = {
			group = {1,3},
			tee = {
				7,
			},
		},
	},
	bodygroupsbottom = {
		["pant"] = {
			group = {2,0},
			pant = {
				9,
			}
		},
		["nude"] = {
			group = {2,2},
			pant = {
				8,
			},
		},
		["suit"] = {
			group = {2,1},
			pant = {
				12,
			},
		},
	},
	eyes = {
		["r"] = 3,
		["l"] = 1
	},
}
Cosmetics.Male.ListDefaultPM["models/kerry/player/citizen/male_06.mdl"] = {
	skins = { 0,1,2,3,4,5,6,7 },
	sex = 1, -- 1 = male, 0 = female
	name = "male06",
	bodygroupstop = {
		["polo"] = {
			group = {1,0},
			tee = {
				4,
			},
		},
		["jacket"] = {
			group = {1,1},
			tee = {
				5,
			},
		},
		["suit"] = {
			group = {1,2},
			tee = {
				6,
			},
		},
		["nude"] = {
			group = {1,4},
			tee = {
				8,
			},
		},
		["tee"] = {
			group = {1,3},
			tee = {
				7,
			},
		},
	},
	bodygroupsbottom = {
		["pant"] = {
			group = {2,0},
			pant = {
				9,
			}
		},
		["nude"] = {
			group = {2,2},
			pant = {
				8,
			},
		},
		["suit"] = {
			group = {2,1},
			pant = {
				13,
			},
		},
	},
	eyes = {
		["r"] = 2,
		["l"] = 3
	},
}
Cosmetics.Male.ListDefaultPM["models/kerry/player/citizen/male_05.mdl"] = {
	skins = { 0,1,2,3,4,5,6,7 },
	sex = 1, -- 1 = male, 0 = female
	name = "male05",
	bodygroupstop = {
		["polo"] = {
			group = {1,0},
			tee = {
				4,
			},
		},
		["jacket"] = {
			group = {1,1},
			tee = {
				5,
			},
		},
		["nude"] = {
			group = {1,4},
			tee = {
				8,
			},
		},
		["suit"] = {
			group = {1,2},
			tee = {
				6,
			},
		},
		["tee"] = {
			group = {1,3},
			tee = {
				7,
			},
		},
	},
	bodygroupsbottom = {
		["pant"] = {
			group = {2,0},
			pant = {
				9,
			}
		},
		["nude"] = {
			group = {2,2},
			pant = {
				8,
			},
		},
		["suit"] = {
			group = {2,1},
			pant = {
				12,
			},
		},
	},
	eyes = {
		["r"] = 2,
		["l"] = 3
	},
}
Cosmetics.Male.ListDefaultPM["models/kerry/player/citizen/male_04.mdl"] = {
	skins = { 0,1,2,3,4,5,6,7 },
	sex = 1, -- 1 = male, 0 = female
	name = "male04",
	bodygroupstop = {
		["polo"] = {
			group = {1,0},
			tee = {
				4,
			},
		},
		["jacket"] = {
			group = {1,1},
			tee = {
				5,
			},
		},
		["suit"] = {
			group = {1,2},
			tee = {
				6,
			},
		},
		["nude"] = {
			group = {1,4},
			tee = {
				8,
			},
		},
		["tee"] = {
			group = {1,3},
			tee = {
				7,
			},
		},
	},
	bodygroupsbottom = {
		["pant"] = {
			group = {2,0},
			pant = {
				9,
			}
		},
		["nude"] = {
			group = {2,2},
			pant = {
				8,
			},
		},
		["suit"] = {
			group = {2,1},
			pant = {
				12,
			},
		},
	},
	eyes = {
		["r"] = 3,
		["l"] = 1
	},
}
Cosmetics.Male.ListDefaultPM["models/kerry/player/citizen/male_03.mdl"] = {
	skins = { 0,1,2,3,4,5,6,7 },
	sex = 1, -- 1 = male, 0 = female
	name = "male03",
	bodygroupstop = {
		["polo"] = {
			group = {1,0},
			tee = {
				4,
			},
		},
		["jacket"] = {
			group = {1,1},
			tee = {
				5,
			},
		},
		["suit"] = {
			group = {1,2},
			tee = {
				6,
			},
		},
		["nude"] = {
			group = {1,4},
			tee = {
				8,
			},
		},
		["tee"] = {
			group = {1,3},
			tee = {
				7,
			},
		},
	},
	bodygroupsbottom = {
		["pant"] = {
			group = {2,0},
			pant = {
				9,
			}
		},
		["nude"] = {
			group = {2,2},
			pant = {
				8,
			},
		},
		["suit"] = {
			group = {2,1},
			pant = {
				12,
			},
		},
	},
	eyes = {
		["r"] = 1,
		["l"] = 2
	},
}
Cosmetics.Male.ListDefaultPM["models/kerry/player/citizen/male_02.mdl"] = {
	skins = { 0,1,2,3,4,5,6,7 },
	sex = 1, -- 1 = male, 0 = female
	name = "male02",
	bodygroupstop = {
		["polo"] = {
			group = {1,0},
			tee = {
				4,
			},
		},
		["jacket"] = {
			group = {1,1},
			tee = {
				5,
			},
		},
		["suit"] = {
			group = {1,2},
			tee = {
				6,
			},
		},
		["nude"] = {
			group = {1,4},
			tee = {
				8,
			},
		},
		["tee"] = {
			group = {1,3},
			tee = {
				7,
			},
		},
	},
	bodygroupsbottom = {
		["pant"] = {
			group = {2,0},
			pant = {
				9,
			}
		},
		["nude"] = {
			group = {2,2},
			pant = {
				8,
			},
		},
		["suit"] = {
			group = {2,1},
			pant = {
				12,
			},
		},
	},
	eyes = {
		["r"] = 2,
		["l"] = 3
	},
}
Cosmetics.Male.ListDefaultPM["models/kerry/player/citizen/male_01.mdl"] = {
	skins = { 0,1,2,3,4,5,6,7 },
	sex = 1, -- 1 = male, 0 = female
	name = "male01",
	bodygroupstop = {
		["polo"] = {
			group = {1,0},
			tee = {
				4,
			},
		},
		["jacket"] = {
			group = {1,1},
			tee = {
				5,
			},
		},
		["suit"] = {
			group = {1,2},
			tee = {
				6,
			},
		},
		["nude"] = {
			group = {1,4},
			tee = {
				8,
			},
		},
		["tee"] = {
			group = {1,3},
			tee = {
				7,
			},
		},
	},
	bodygroupsbottom = {
		["pant"] = {
			group = {2,0},
			pant = {
				9,
			}
		},
		["nude"] = {
			group = {2,2},
			pant = {
				8,
			},
		},
		["suit"] = {
			group = {2,1},
			pant = {
				12,
			},
		},
	},
	eyes = {
		["r"] = 2,
		["l"] = 3
	},
}

Cosmetics.Male.ListBottoms = {
	["?????????? 1 (??????.)"] = {
		texture = "models/citizen/body/citizen_sheet",
		bodygroup = "pant",
		default = true,
		category = {
			"??????????",
		},
		price = 600,
	},
	["?????????? 2 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_01",
		bodygroup = "pant",
		default = true,
		category = {
			"??????????",
		},
		price = 600,
	},
	["?????????? 3 (??????.)"] = {
		texture = "??????????/humans/modern/male/sheet_03",
		bodygroup = "pant",
		default = true,
		category = {
			"??????????",
		},
		price = 600,
	},
	["?????????? 4 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_04",
		bodygroup = "pant",
		default = true,
		category = {
			"??????????",
		},
		price = 600,
	},
	["?????????? 5 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_05",
		bodygroup = "pant",
		default = true,
		category = {
			"??????????",
		},
		price = 600,
	},
	["?????????? 6 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_10",
		bodygroup = "pant",
		default = true,
		category = {
			"??????????",
		},
		price = 600,
	},	
	["?????????? 7 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_11",
		bodygroup = "pant",
		default = true,
		category = {
			"??????????",
		},
		price = 600,
	},	
	["?????????? 8 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_08",
		bodygroup = "pant",
		default = true,
		category = {
			"??????????",
		},
		price = 600,
	},	
	["?????????? 9 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_09",
		bodygroup = "pant",
		default = true,
		category = {
			"??????????",
		},
		price = 600,
	},
	["?????????? 10 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_12",
		bodygroup = "pant",
		default = true,
		category = {
			"??????????",
		},
		price = 600,
	},
	["?????????? 11 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_13",
		bodygroup = "pant",
		default = false,
		category = {
			"??????????",
		},
		price = 600,
	},
	["?????????? 12 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_14",
		bodygroup = "pant",
		default = false,
		category = {
			"??????????",
		},
		price = 600,
	},
	["?????????? 13 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_17",
		bodygroup = "pant",
		default = false,
		category = {
			"??????????",
		},
		price = 600,
	},
	["?????????? 14 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_18",
		bodygroup = "pant",
		default = false,
		category = {
			"??????????",
		},
		price = 600,
	},
	["?????????? 15 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_20",
		bodygroup = "pant",
		default = true,
		category = {
			"??????????",
		},
		price = 600,
	},
	["?????????? 16 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_21",
		bodygroup = "pant",
		default = false,
		category = {
			"??????????",
		},
		price = 600,
	},
	["?????????? 17 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_22",
		bodygroup = "pant",
		default = true,
		category = {
			"??????????",
		},
		price = 600,
	},
	["?????????? 18 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_23",
		bodygroup = "pant",
		default = true,
		category = {
			"??????????",
		},
		price = 600,
	},
	["?????????? 19 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_24",
		bodygroup = "pant",
		default = true,
		category = {
			"??????????",
		},
		price = 600,
	},
	["?????????? 20 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_25",
		bodygroup = "pant",
		default = true,
		category = {
			"??????????",
		},
		price = 600,
	},
	["?????????? 21 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_27",
		bodygroup = "pant",
		default = true,
		category = {
			"??????????",
		},
		price = 600,
	},
	["?????????? 22 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_29",
		bodygroup = "pant",
		default = true,
		category = {
			"??????????",
		},
		price = 600,
	},
	["?????????? 23 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_30",
		bodygroup = "pant",
		default = true,
		category = {
			"??????????",
		},
		price = 600,
	},
	["?????????? 24 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_31",
		bodygroup = "pant",
		default = true,
		category = {
			"??????????",
		},
		price = 600,
	},
	["???????????? 1 (??????.)"] = {
		texture = "models/citizen/leg/lowr_suit_01",
		bodygroup = "suit",
		default = false,
		category = {
			"??????????",
			"????????????",
		},
		price = 1000,
	},
}
--
Cosmetics.Male.ListTops = {
	["???????????????? 25 (??????.)"] = {
		texture = "models/humans/enhancedshortsleeved/citizen_sheet",
		bodygroup = "tee",
		default = false,
		category = {
			"??????-?? ????????????",
			"????????????????",
		},
		price = 400,
	},
	["???????????????? 26 (??????.)"] = {
		texture = "models/humans/enhancedshortsleeved/citizen_sheet2",
		bodygroup = "tee",
		default = false,
		category = {
			"??????-?? ????????????",
			"????????????????",
		},
		price = 400,
	},
	["???????????????? 27 (??????.)"] = {
		texture = "models/humans/enhancedshortsleeved/citizen_sheet3",
		bodygroup = "tee",
		default = false,
		category = {
			"??????-?? ????????????",
			"????????????????",
		},
		price = 400,
	},
	["???????????????? 28 (??????.)"] = {
		texture = "models/humans/enhancedshortsleeved/citizen_sheet4",
		bodygroup = "tee",
		default = false,
		category = {
			"??????-?? ????????????",
			"????????????????",
		},
		price = 400,
	},
	["???????????????? 1 (??????.)"] = {
		texture = "models/citizen/body/citizen_sheet",
		bodygroup = "polo",
		default = true,
		category = {
			"????-?? ????????????",
			"????????????????",
		},
		price = 600,
	},
	["???????????????? 2 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_01",
		bodygroup = "polo",
		default = true,
		category = {
			"????????-?? ????????????",
			"????????????????",
		},
		price = 600,
	},
	["???????????????? 3 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_03",
		bodygroup = "polo",
		default = true,
		category = {
			"????????-?? ????????????",
			"????????????????",
		},
		price = 600,
	},
	["???????????????? 4 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_04",
		bodygroup = "polo",
		default = true,
		category = {
			"????????-?? ????????????",
			"????????????????",
		},
		price = 600,
	},
	["???????????????? 5 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_05",
		bodygroup = "polo",
		default = true,
		category = {
			"????????-?? ????????????",
			"????????????????",
		},
		price = 600,
	},
	["???????????????? 6 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_10",
		bodygroup = "polo",
		default = true,
		category = {
			"????????-?? ????????????",
			"????????????????",
		},
		price = 600,
	},	
	["???????????????? 7 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_11",
		bodygroup = "polo",
		default = true,
		category = {
			"????????-?? ????????????",
			"????????????????",
		},
		price = 600,
	},	
	["???????????????? 8 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_08",
		bodygroup = "polo",
		default = true,
		category = {
			"????????-?? ????????????",
			"????????????????",
		},
		price = 600,
	},	
	["???????????????? 9 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_09",
		bodygroup = "polo",
		default = false,
		category = {
			"????????-?? ????????????",
			"????????????????",
		},
		price = 600,
	},
	["???????????????? 10 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_12",
		bodygroup = "polo",
		default = true,
		category = {
			"????????-?? ????????????",
			"????????????????",
		},
		price = 600,
	},
	["???????????????? 11 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_13",
		bodygroup = "polo",
		default = true,
		category = {
			"????????-?? ????????????",
			"????????????????",
		},
		price = 600,
	},
	["???????????????? 12 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_14",
		bodygroup = "polo",
		default = true,
		category = {
			"????????-?? ????????????",
			"????????????????",
		},
		price = 600,
	},
	["???????????????? 13 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_17",
		bodygroup = "polo",
		default = true,
		category = {
			"????????-?? ????????????",
			"????????????????",
		},
		price = 600,
	},
	["???????????????? 14 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_18",
		bodygroup = "polo",
		default = false,
		category = {
			"????????-?? ????????????",
			"????????????????",
		},
		price = 600,
	},
	["???????????????? 15 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_20",
		bodygroup = "polo",
		default = true,
		category = {
			"????????-?? ????????????",
			"????????????????",
		},
		price = 600,
	},
	["???????????????? 16 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_21",
		bodygroup = "polo",
		default = true,
		category = {
			"????????-?? ????????????",
			"????????????????",
		},
		price = 600,
	},
	["???????????????? 17 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_22",
		bodygroup = "polo",
		default = true,
		category = {
			"????????-?? ????????????",
			"????????????????",
		},
		price = 600,
	},
	["???????????????? 18 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_23",
		bodygroup = "polo",
		default = true,
		category = {
			"????????-?? ????????????",
			"????????????????",
		},
		price = 600,
	},
	["???????????????? 19 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_24",
		bodygroup = "polo",
		default = false,
		category = {
			"????????-?? ????????????",
			"????????????????",
		},
		price = 600,
	},
	["???????????????? 20 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_25",
		bodygroup = "polo",
		default = false,
		category = {
			"????????-?? ????????????",
			"????????????????",
		},
		price = 600,
	},
	["???????????????? 21 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_27",
		bodygroup = "polo",
		default = false,
		category = {
			"????????-?? ????????????",
			"????????????????",
		},
		price = 600,
	},
	["???????????????? 22 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_29",
		bodygroup = "polo",
		default = false,
		category = {
			"????????-?? ????????????",
			"????????????????",
		},
		price = 600,
	},
	["???????????????? 23 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_30",
		bodygroup = "polo",
		default = false,
		category = {
			"????????-?? ????????????",
			"????????????????",
		},
		price = 600,
	},
	["???????????????? 24 (??????.)"] = {
		texture = "models/humans/modern/male/sheet_31",
		bodygroup = "polo",
		default = true,
		category = {
			"????????-?? ????????????",
			"????????????????",
		},
		price = 600,
	},
	["?????????????? ?????????? (??????.)"] = {
		texture = "models/bloo_ltcom_zel/citizens/prague_civ_rioter_body_col_a",
		bodygroup = "jacket",
		default = false,
		category = {
			"????????",
		},
		price = 1000,
	},
	["?????????? ?????????? (??????.)"] = {
		texture = "models/bloo_ltcom_zel/citizens/prague_civ_rioter_body_col_b",
		-- texture = "models/wireframe",
		bodygroup = "jacket",
		default = false,
		category = {
			"????????",
		},
		price = 1000,
	},
	["???????????? 3 (??????.)"] = {
		texture = "models/bloo_ltcom_zel/citizens/prague_civ_rioter_body_col_c",
		bodygroup = "jacket",
		default = false,
		category = {
			"????????",
		},
		price = 1000,
	},
	["???????????? 1 (??????.)"] = {
		texture = "models/citizen/body/suit_sheet",
		bodygroup = "suit",
		default = false,
		category = {
			"????????????",
		},
		price = 2500,
	},
}
Cosmetics.Male.EditableTop = {
	["models/humans/enhancedshortsleeved/citizen_sheet"] = {
		sizex = 68.7,
		sizey = 115.4,
		posx = 32.5 + 1.5,
		posy = 174 + 1.5,
		bodygroup = "tee"
	},
	["models/humans/enhancedshortsleeved/citizen_sheet2"] = {
		sizex = 68.7,
		sizey = 115.4,
		posx = 32.5 + 1.5,
		posy = 174 + 1.5,
		bodygroup = "tee"
	},
	["models/humans/enhancedshortsleeved/citizen_sheet3"] = {
		sizex = 68.7,
		sizey = 115.4,
		posx = 32.5 + 1.5,
		posy = 174 + 1.5,
		bodygroup = "tee"
	},
	["models/humans/enhancedshortsleeved/citizen_sheet4"] = {
		sizex = 68.7,
		sizey = 115.4,
		posx = 32.5 + 1.5,
		posy = 174 + 1.5,
		bodygroup = "tee"
	},
}


function RegisterWears()
for class, v in pairs(Cosmetics.Female.ListBottoms) do
		local ENT = {}
		ENT.Base = "cm_cloth"
		ENT.Type = "anim"
		ENT.PrintName = class
		ENT.WorldModel = "models/props_equipment/sleeping_bag3.mdl"
		ENT.Model = "models/props_equipment/sleeping_bag3.mdl"

		ENT.Category = "????????????"
		ENT.Spawnable = true
		ENT.id = class
		print(class)

		if SERVER then
			function ENT:Initialize()
				self:SetModel( self.WorldModel )
				self:PhysicsInit(SOLID_VPHYSICS)
				self:SetMoveType(MOVETYPE_VPHYSICS)
				self:SetSolid(SOLID_VPHYSICS)
				self:SetUseType(SIMPLE_USE)
				local phys = self:GetPhysicsObject()
				if phys then phys:Wake() end
				print(class)
				self:SetCName(class)
			end
		end
		scripted_ents.Register( ENT, class)	
end
for class, v in pairs(Cosmetics.Female.ListTops) do
		local ENT = {}
		ENT.Base = "cm_cloth"
		ENT.Type = "anim"
		ENT.PrintName = class
		ENT.WorldModel = "models/props_equipment/sleeping_bag3.mdl"
		ENT.Model = "models/props_equipment/sleeping_bag3.mdl"

		ENT.Category = "????????????"
		ENT.Spawnable = true
		ENT.id = class
		print(class)

		if SERVER then
			function ENT:Initialize()
				self:SetModel( self.WorldModel )
				self:PhysicsInit(SOLID_VPHYSICS)
				self:SetMoveType(MOVETYPE_VPHYSICS)
				self:SetSolid(SOLID_VPHYSICS)
				self:SetUseType(SIMPLE_USE)
				local phys = self:GetPhysicsObject()
				if phys then phys:Wake() end
				print(class)
				self:SetCName(class)
			end
		end
		scripted_ents.Register( ENT, class)
end
for class, v in pairs(Cosmetics.Male.ListBottoms) do
		local ENT = {}
		ENT.Base = "cm_cloth"
		ENT.Type = "anim"
		ENT.PrintName = class
		ENT.WorldModel = "models/props_equipment/sleeping_bag3.mdl"
		ENT.Model = "models/props_equipment/sleeping_bag3.mdl"

		ENT.Category = "????????????"
		ENT.Spawnable = true
		ENT.id = class
		print(class)

		if SERVER then
			function ENT:Initialize()
				self:SetModel( self.WorldModel )
				self:PhysicsInit(SOLID_VPHYSICS)
				self:SetMoveType(MOVETYPE_VPHYSICS)
				self:SetSolid(SOLID_VPHYSICS)
				self:SetUseType(SIMPLE_USE)
				local phys = self:GetPhysicsObject()
				if phys then phys:Wake() end
				print(class)
				self:SetCName(class)
			end
		end
		scripted_ents.Register( ENT, class)
end
for class, v in pairs(Cosmetics.Male.ListTops) do	
		local ENT = {}
		ENT.Base = "cm_cloth"
		ENT.Type = "anim"
		ENT.PrintName = class
		ENT.WorldModel = "models/props_equipment/sleeping_bag3.mdl"
		ENT.Model = "models/props_equipment/sleeping_bag3.mdl"

		ENT.Category = "????????????"
		ENT.Spawnable = true
		ENT.id = class
		print(class)

		if SERVER then
			function ENT:Initialize()
				self:SetModel( self.WorldModel )
				self:PhysicsInit(SOLID_VPHYSICS)
				self:SetMoveType(MOVETYPE_VPHYSICS)
				self:SetSolid(SOLID_VPHYSICS)
				self:SetUseType(SIMPLE_USE)
				local phys = self:GetPhysicsObject()
				if phys then phys:Wake() end
				print(class)
				self:SetCName(class)
			end
		end
		scripted_ents.Register( ENT, class)
end
	
end
RegisterWears()