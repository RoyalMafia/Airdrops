--[[

	LOAD LUA FILES

]]--

if SERVER then
	include 'dropcode/cl_addpos.lua'
	AddCSLuaFile 'dropcode/cl_addpos.lua'

	include 'sh_dropconfig.lua'
	AddCSLuaFile 'sh_dropconfig.lua'

	include 'dropcode/sv_setupdirs.lua'
	include 'dropcode/sv_drops.lua'

	if #file.Find( "airdrops/"..game.GetMap().."/spawnspos.dat", "DATA" ) == 0 then
		file.Write( "airdrops/"..game.GetMap().."/spawnspos.dat", "[]" )
	end
end

if CLIENT then
	include 'dropcode/cl_addpos.lua'

	include 'sh_dropconfig.lua'
end

