if SERVER then
include("r_config.lua")
include("modules/server/legs.lua")
include("modules/client/sounds.lua")
AddCSLuaFile("modules/client/sounds.lua")
AddCSLuaFile("r_config.lua")
resource.AddFile( "content/materials/blood.png" )
end
if CLIENT then
AddCSLuaFile("modules/client/sounds.lua")
include("modules/client/sounds.lua")
AddCSLuaFile("r_config.lua")
end