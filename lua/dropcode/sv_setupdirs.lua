--[[------------------------------------------

	Directory Check

--]]------------------------------------------

function createDir( filename, directory )
	if !file.IsDir( filename, directory ) then
		file.CreateDir( "airdrops" )
	end
end

if !file.IsDir( "airdrops", "DATA" ) then
	-- Haven't found the directory, need to create it
	createDir( "airdrops", "DATA" )

	-- Now check to see if we have created it
	if file.IsDir( "airdrops", "DATA" ) then
		-- If it completed, do nothing
		print("[Airdrops] Directory creation complete!")
	else
		-- If it failed, lets retry.
		print("[Airdrops] Directory creation failed, trying again!" )
		createDir( "airdrops", "DATA" )
	end
else
	-- Gotta create / check for the relevant directory to the map
	print("[Airdrops] Directory exists, doing nothing!" )

	if !file.IsDir( "airdrops/"..game.GetMap(), "DATA" ) then
		print("[Airdrops] Creating POS directory.")
		file.CreateDir( "airdrops/"..game.GetMap() )
	else
		print("[Airdrops] POS directory already exists for this map, doing nothing!")
	end

	if !file.IsDir( "airdrops/tempdrops", "DATA" ) then
		print("[Airdrops Creating temp drop directory.")
		file.CreateDir( "airdrops/tempdrops" )
	else
		print("[Airdrops] Tempdrops directory already exists, doing nothing!")
	end
end
