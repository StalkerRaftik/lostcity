AddCSLuaFile()

game.AddParticles("particles/zlm_mowing.pcf")
PrecacheParticleSystem("zlm_mowe")
PrecacheParticleSystem("zlm_unload")
PrecacheParticleSystem("zlm_mowing")
PrecacheParticleSystem("zlm_collect")
PrecacheParticleSystem("zlm_grassroll_load")

game.AddParticles("particles/zlm_selling.pcf")
PrecacheParticleSystem("zlm_sell")

game.AddParticles("particles/zlm_machine.pcf")
PrecacheParticleSystem("zlm_spinair")
PrecacheParticleSystem("zlm_suckair")

util.PrecacheModel("models/zerochain/props_lawnmower/zlm_grasspile.mdl")
util.PrecacheModel("models/zerochain/props_lawnmower/zlm_grassroll.mdl")
