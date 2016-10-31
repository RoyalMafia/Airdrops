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

-- How many to drop
dropst.amount = 10

--[[ 
	Allow the messy table
	
	For itemName it can be anything, just needed for the drop selection, must be
	unique. i.e. airdrop_gun1
	For itemNiceName I couldn't be fucked to work out the ents print name via
	string, so just set that to be a nice name for the ent i.e. 'Dank Drugz'
	For itemVals  5 - 1, 5 = rare - 1 = common, they are the drop chances etc.
	For itemEnt that's the entity that you want it to use for the item, so make
	sure that it's the correct entity or it won't work.
]]--

dropst.items = { 
				{
					itemName     = "cwak47",
					itemNiceName = "AK-47",
					itemVal      = 5,
					itemEnt      = "cw_ak74"
				},
				{

					itemName     = "cwar15",
					itemNiceName = "AR-15",
					itemVal      = 5,
					itemEnt      = "cw_ar15"
				},
				{
					itemName     = "cwflash",
					itemNiceName = "Flash Grenade",
					itemVal      = 3,
					itemEnt      = "cw_flash_grenade"
				},
				{
					itemName     = "cwgrenade",
					itemNiceName = "Grenade",
					itemVal      = 4,
					itemEnt      = "cw_frag_grenade"
				},
				{
					itemName     = "cwg3",
					itemNiceName = "G3A3",
					itemVal      = 4,
					itemEnt      = "cw_g3a3"
				},
				{
					itemName     = "cwmp5",
					itemNiceName = "MP5",
					itemVal      = 3,
					itemEnt      = "cw_mp5"
				},
				{
					itemName     = "cwl115",
					itemNiceName = "L115 Sniper",
					itemVal      = 5,
					itemEnt      = "cw_l115"
				},
				{
					itemName     = "cwdeag",
					itemNiceName = "Deagle",
					itemVal      = 2,
					itemEnt      = "cw_deagle"
				},
				{
					itemName     = "cwmr96",
					itemNiceName = "MR96",
					itemVal      = 2,
					itemEnt      = "cw_g3a3"
				},
				{
					itemName     = "cwsmoke",
					itemNiceName = "Smoke Grenade",
					itemVal      = 1,
					itemEnt      = "cw_smoke_grenade"
				},
				{
					itemName     = "cwammosmall",
					itemNiceName = "Small Ammo",
					itemVal      = 1,
					itemEnt      = "cw_ammo_kit_small"
				},
				{
					itemName     = "cwgcratesmall",
					itemNiceName = "Ammo Crate",
					itemVal      = 2,
					itemEnt      = "cw_ammo_crate_regular"
				},
				{
					itemName     = "cwammoreg",
					itemNiceName = "Small Ammo Crate",
					itemVal      = 1,
					itemEnt      = "cw_ammo_kit_regular"
				}
			}

-- The ranks which can add / remove drop positions
dropst.ranks = { "superadmin", "owner", "coowner", "founder" }

-- Colours for each itemVal
-- 1 = Light Gray, 2 = Green, 3 = Blue, 4 = Purple, 5 = Red
dropst.cols  = { Color( 200, 200, 200 ), Color( 100, 255, 100 ), Color( 100, 100, 255 ),  Color( 128, 0, 128 ), Color( 255, 100, 100 )  }

-- item value strings
dropst.vals  = { "Common", "Uncommon", "Unusual", "Rare", "Ultra Rare" }