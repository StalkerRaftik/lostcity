CookingSystem = CookingSystem or {}

CookingSystem.UsageCooldown = 3

CookingSystem.HeaderColor = Color(100, 100, 100)

/*---------------------------------------------------------------------------
Категории
---------------------------------------------------------------------------*/

CookingSystem.Categories = {}

CookingSystem.Categories[1] = {
  color = Color(30, 30, 30),
  name = "Все",
}

/*---------------------------------------------------------------------------
Рецепты
---------------------------------------------------------------------------*/

CookingSystem.Recipes = {}

CookingSystem.Recipes["models/foodnhouseholditems/egg.mdl"] = {
  name = "Яичница",
  time = 50,
  category = "Все",
  level = 0, -- Уровень готовки
  recipe = {
    ["egg"] = 1,
  },
}
CookingSystem.Recipes["models/foodnhouseholditems/cokopops.mdl"] = {
  name = "Хлопья",
  time = 90,
  category = "Все",
  level = 0, -- Уровень готовки
  recipe = {
    ["testo"] = 1,
    ["egg"] = 1,
    ["models/foodnhouseholditems/corn.mdl"] = 3,  
  },
}
CookingSystem.Recipes["models/foodnhouseholditems/pancakes.mdl"] = {
  name = "Блины",
  time = 120,
  category = "Все",
  level = 0, -- Уровень готовки
  recipe = {
    ["testo"] = 6,
    ["models/foodnhouseholditems/corn.mdl"] = 2,
    ["egg"] = 1,
  },
}
CookingSystem.Recipes["models/foodnhouseholditems/sandwich.mdl"] = {
  name = "Сэндвич",
  time = 90,
  category = "Все",
  level = 0, -- Уровень готовки
  recipe = {
    ["models/foodnhouseholditems/bread_loaf.mdl"] = 1,
    ["models/foodnhouseholditems/steak2.mdl"] = 1,
    ["models/foodnhouseholditems/tomato.mdl"] = 2,
  },
}
CookingSystem.Recipes["models/foodnhouseholditems/hotdog.mdl"] = {
  name = "Сосиска в тесте",
  time = 80,
  category = "Все",
  level = 2, -- Уровень готовки
  recipe = {
    ["models/foodnhouseholditems/bread_loaf.mdl"] = 1,
    ["models/foodnhouseholditems/steak2.mdl"] = 1,
  },
}
CookingSystem.Recipes["models/foodnhouseholditems/meat6.mdl"] = {
  name = "Стейк на углях",
  time = 180,
  category = "Все",
  level = 0, -- Уровень готовки
  recipe = {
    ["models/foodnhouseholditems/steak2.mdl"] = 1,
  },
}
-- CookingSystem.Recipes["models/foodnhouseholditems/chicken_wrap.mdl"] = {
--   name = "Буррито",
--   time = 90,
--   category = "Все",
--   level = 0, -- Уровень готовки
--   recipe = {
--     ["models/foodnhouseholditems/bread_loaf.mdl"] = 4,
--     ["models/foodnhouseholditems/steak2.mdl"] = 2,
--     ["models/foodnhouseholditems/tomato.mdl"] = 3,
--   },
-- }
CookingSystem.Recipes["models/foodnhouseholditems/cookies.mdl"] = {
  name = "Печенье",
  time = 120,
  category = "Все",
  level = 0, -- Уровень готовки
  recipe = {
    ["testo"] = 1,
    ["egg"] = 1,
  },
}
CookingSystem.Recipes["models/foodnhouseholditems/salmon.mdl"] = {
  name = "Жареная рыба",
  time = 120,
  category = "Все",
  level = 0, -- Уровень готовки
  recipe = {
    ["models/foodnhouseholditems/fishsteak.mdl"] = 1,
  },
}
CookingSystem.Recipes["models/foodnhouseholditems/cheesewheel1c.mdl"] = {
  name = "Сыр",
  time = 160,
  category = "Все",
  level = 0, -- Уровень готовки
  recipe = {
    ["models/foodnhouseholditems/milk.mdl"] = 3,
    ["egg"] = 2,
  },
}
CookingSystem.Recipes["models/foodnhouseholditems/turkey2.mdl"] = {
  name = "Курица-грилль",
  time = 140,
  category = "Все",
  level = 0, -- Уровень готовки
  recipe = {
    ["chickenraw"] = 1,
    ["models/foodnhouseholditems/lettuce.mdl"] = 1,
    ["models/foodnhouseholditems/tomato.mdl"] = 3,
  },
}
CookingSystem.Recipes["models/foodnhouseholditems/pie.mdl"] = {
  name = "Шарлотка",
  time = 120,
  category = "Все",
  level = 0, -- Уровень готовки
  recipe = {
    ["models/foodnhouseholditems/apple.mdl"] = 5,
    ["testo"] = 5,
    ["egg"] = 2,
  },
}
CookingSystem.Recipes["med_nastoyka"] = {
  name = "Домашняя настойка",
  time = 90,
  category = "Все",
  level = 0, -- Уровень готовки
  recipe = {
    ["sugar"] = 3,
    ["models/illusion/eftcontainers/waterbottle.mdl"] = 1,
    ["models/foodnhouseholditems/grapes1.mdl"] = 3,
  },
}
CookingSystem.Recipes["testo"] = {
  name = "Тесто",
  time = 30,
  category = "Все",
  level = 0, -- Уровень готовки
  recipe = {
    ["oat"] = 2,
  },
}
CookingSystem.Recipes["models/props_junk/glassjug01.mdl"] = {
  name = "Травяной чай",
  time = 50,
  category = "Все",
  level = 0, -- Уровень готовки
  recipe = {
    ["models/illusion/eftcontainers/waterbottle.mdl"] = 1,
    ["models/foodnhouseholditems/lettuce.mdl"] = 3,
  },
}
CookingSystem.Recipes["models/illusion/eftcontainers/waterbottle.mdl"] = {
  name = "Очистить воду",
  time = 30,
  category = "Все",
  level = 0, -- Уровень готовки
  recipe = {
    ["models/props_junk/garbage_milkcarton001a.mdl"] = 1,
    ["aquafilter"] = 1
  },
}
CookingSystem.Recipes["models/foodnhouseholditems/bread_loaf.mdl"] = {
  name = "Хлеб",
  time = 80,
  category = "Все",
  level = 0, -- Уровень готовки
  recipe = {
    ["testo"] = 5,
  },
}
CookingSystem.Recipes["models/foodnhouseholditems/juice3.mdl"] = {
  name = "Яблочный сок",
  model = "",
  time = 50,
  category = "Все",
  level = 0, -- Уровень готовки
  recipe = {
    ["models/foodnhouseholditems/apple.mdl"] = 2,
    ["models/illusion/eftcontainers/waterbottle.mdl"] = 1,
  },
}
CookingSystem.Recipes["models/foodnhouseholditems/croissant.mdl"] = {
  name = "Круассан",
  time = 90,
  category = "Все",
  level = 5, -- Уровень готовки
  recipe = {
    ["testo"] = 3,
    ["sugar"] = 1,
  },
}
CookingSystem.Recipes["models/foodnhouseholditems/burgergtasa.mdl"] = {
  name = "Двойной бургер",
  time = 160,
  category = "Все",
  level = 8, -- Уровень готовки
  recipe = {
    ["models/foodnhouseholditems/bread_loaf.mdl"] = 1,
    ["models/foodnhouseholditems/lettuce.mdl"] = 1,
    ["ketchup"] = 1,
    ["models/foodnhouseholditems/tomato.mdl"] = 2,
    ["models/foodnhouseholditems/steak2.mdl"] = 1,
  },
}

-- CookingSystem.Recipes["13"] = {
--   name = "Мультиобед",
--   model = "models/foodnhouseholditems/mcdmeal2.mdl",
--   time = 120,
--   category = "Все",
--   level = 10, -- Уровень готовки
--   recipe = {
--     ["myaso"] = 2,
--     ["testo"] = 2,
--     ["ketchup"] = 3,
--     ["listya"] = 2,
--     ["ogurec"] = 1,
--     ["ent_fluid_water"] = 1,
--     ["sugar"] = 1,
--     ["fs_potato"] = 2,  
--   },
-- }

-- CookingSystem.Recipes["14"] = {
--   name = "Упаковкочный обед",
--   model = "models/braxen/tvdinner_contents.mdl",
--   time = 120,
--   category = "Все",
--   level = 12, -- Уровень готовки
--   recipe = {
--     ["myaso"] = 1,
--     ["egg"] = 4, 
--     ["testo"] = 1,
--     ["maslo"] = 1,
--   },
-- }

-- CookingSystem.Recipes["15"] = {
--   name = "Блины",
--   model = "models/foodnhouseholditems/pancakes.mdl",
--   time = 60,
--   category = "Все",
--   level = 8, -- Уровень готовки
--   recipe = {
--     ["egg"] = 2, 
--     ["testo"] = 4,
--     ["maslo"] = 1,
--   },
-- }

-- CookingSystem.Recipes["17"] = {
--   name = "Багет",
--   model = "models/foodnhouseholditems/bagette.mdl",
--   time = 40,
--   category = "Все",
--   level = 7, -- Уровень готовки
--   recipe = {
--     ["testo"] = 3,
--   },
-- }

-- CookingSystem.Recipes["18"] = {
--   name = "Банка газировки(кола)",
--   model = "models/foodnhouseholditems/sodacan01.mdl",
--   time = 30,
--   category = "Все",
--   level = 3, -- Уровень готовки
--   recipe = {
--     ["sugar"] = 1,
--     ["ent_fluid_water"] = 1,
--     ["steel"] = 1,
--   },
-- }

-- CookingSystem.Recipes["19"] = {
--   name = "Банка газировки(пепси)",
--   model = "models/foodnhouseholditems/sodacan04.mdl",
--   time = 30,
--   category = "Все",
--   level = 3, -- Уровень готовки
--   recipe = {
--     ["sugar"] = 1,
--     ["ent_fluid_water"] = 1,
--     ["steel"] = 1,
--   },
-- }

-- CookingSystem.Recipes["20"] = {
--   name = "Банка газировки(спрайт)",
--   model = "models/foodnhouseholditems/sodacan05.mdl",
--   time = 30,
--   category = "Все",
--   level = 3, -- Уровень готовки
--   recipe = {
--     ["sugar"] = 1,
--     ["ent_fluid_water"] = 1,
--     ["steel"] = 1,
--   },
-- }





-- models/foodnhouseholditems/pie.mdl пирог
-- models/foodnhouseholditems/pizzab.mdl охуенная пицца
-- models/foodnhouseholditems/pizzaslice.mdl кусочек пиццы
-- models/foodnhouseholditems/salmon.mdl жареный кусок мяса
-- models/foodnhouseholditems/steak2.mdl жареный стейк
-- models/foodnhouseholditems/sweetroll.mdl сладкий ролл
-- models/foodnhouseholditems/toffifee.mdl тофифи
-- models/foodnhouseholditems/kinderbox.mdl киндеры
-- models/foodnhouseholditems/meat_ribs.mdl жареная баранина
-- models/foodnhouseholditems/bagel3.mdl пончик
-- models/foodnhouseholditems/bagette.mdl багет
-- models/foodnhouseholditems/nutella.mdl нутелл
-- models/foodnhouseholditems/chocorings.mdl чоко кольца
-- models/foodnhouseholditems/lobster2.mdl лобстер
-- models/foodnhouseholditems/coconut_drink.mdl коктейль из кокоса
-- models/dead rising 2/onion_rings.mdl -- луковые кольца
/*---------------------------------------------------------------------------
Детали
---------------------------------------------------------------------------*/
-- ЭТО ОБЯЗАТЕЛЬНО ЗАПОЛНИТЬ
CookingSystem.Details = {}





function CookingSystem:RegisterDetail(class, detail)
  local ENT = {}
  ENT.Base = "base_gmodentity"
  ENT.Type = "anim"
  ENT.PrintName = detail.name
  ENT.WorldModel = detail.model
  ENT.Model = detail.model

  ENT.Category = "Ингридиенты(готовка)"
  ENT.Spawnable = true

  if SERVER then
    function ENT:Initialize()
      self:SetModel( self.WorldModel )
      self:PhysicsInit(SOLID_VPHYSICS)
      self:SetMoveType(MOVETYPE_VPHYSICS)
      self:SetSolid(SOLID_VPHYSICS)
      self:SetUseType(SIMPLE_USE)
      local phys = self:GetPhysicsObject()
      phys:Wake()
    end
  end

  scripted_ents.Register( ENT, class )

  rp.AddEntity(detail.name, {
      ent = class,
      model = detail.model,
      price = 0,
      max = 1,
      cmd = "",
      weight = detail.weight or rp.lootweights[k] or 0.3,
      usable = false,
  })
  -- local k = {
  --  name= v.name,
  --  id = k,
  --  model= v.model,
  --  pos = v.pos,
  --  ang = v.ang,
  --  slot=COSM_SLOT_RHAND,
  --  type = "weapon",
  --  scale=1,
  --  attach = "chest",
  --  price=0,
  -- }
  -- table.insert(Cosmetics.Items, k)
end

timer.Simple(20, function()
  for k,v in pairs(CookingSystem.Details) do
    CookingSystem:RegisterDetail(k, v)
  end
end)