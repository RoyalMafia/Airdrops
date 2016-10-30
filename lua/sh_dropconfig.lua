--[[---------------------------------------------------
		
  /$$$$$$                       /$$$$$$  /$$          
 /$$__  $$                     /$$__  $$|__/          
| $$  \__/  /$$$$$$  /$$$$$$$ | $$  \__/ /$$  /$$$$$$ 
| $$       /$$__  $$| $$__  $$| $$$$    | $$ /$$__  $$
| $$      | $$  \ $$| $$  \ $$| $$_/    | $$| $$  \ $$
| $$    $$| $$  | $$| $$  | $$| $$      | $$| $$  | $$
|  $$$$$$/|  $$$$$$/| $$  | $$| $$      | $$|  $$$$$$$
 \______/  \______/ |__/  |__/|__/      |__/ \____  $$
                                             /$$  \ $$
                                            |  $$$$$$/
                                             \______/ 

--]]---------------------------------------------------

--[[------------------------------------------
		
	Vars

--]]------------------------------------------

-- Values for the drop shizzle
dropst       = {}

-- How often the drops happen
dropst.rate  = 30 -- Done in minutes

--[[ 
	Allow the messy table
	
	For itemName it can be anything, or just left blank to use the default
	entity name.

	For itemVals  5 - 1, 5 = rare 1 = common, they are the drop chances etc.

	For itemEnt that's the entity that you want it to use for the item, so make
	sure that it's the correct entity or it won't work.
]]--

dropst.items = {}

-- Drop spawn positions, done in-game, stored in a file
dropst.pos   = util.JSONToTable( file.Read( "airdrops/"..game.GetMap().."/spawnspos.dat", "DATA" ) )

-- The ranks which can add / remove drop positions
dropst.ranks = { "superadmin", "owner", "coowner", "founder" }
