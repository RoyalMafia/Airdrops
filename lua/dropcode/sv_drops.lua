--[[

	NET MSG

]]--

util.AddNetworkString( "airdrop_dropadd" )
util.AddNetworkString( "airdrop_drop" )
util.AddNetworkString( "airdrop_notify" )

--[[

	VARS

]]--

droppos = util.JSONToTable( file.Read( "airdrops/"..game.GetMap().."/spawnspos.dat", "DATA" ) )

--[[

	FUNCTIONS

]]--

local function checkPlyRank( ply )
	for i = 1, #dropst.ranks do
		if ply:GetUserGroup() == dropst.ranks[i] then
			return true
		end
	end
end

local function createDrop( pos )
	local npos = pos + Vector( math.random( -200, 200), math.random( -200, 200 ), 1000 )
	local drop = ents.Create( "dropent" )
	if !IsValid( drop ) then return end
	drop:SetPos( npos )
	drop:Spawn()
end

local function spawnDrops()
	net.Start( "airdrop_notify" )
		net.WriteString( "Airdrops have spawned!" )
	net.Broadcast()

	local pos = nil
	for i = 1, dropst.amount do
		pos = droppos[math.random( 1, #droppos )]
		createDrop( pos )
	end
end

--[[

	TIMER

]]--

if !timer.Exists( "airdrop_droprate" ) then
	timer.Create( "airdrop_droprate", dropst.rate*60, 0, function() spawnDrops() end)
end


--[[

	NET RECEIVE

]]--

net.Receive( "airdrop_dropadd", function( len, pl ) 

	if checkPlyRank( pl ) then
		local postable = util.JSONToTable( file.Read( "airdrops/"..game.GetMap().."/spawnspos.dat", "DATA" ) )
		table.insert( postable, net.ReadVector() )
		file.Write( "airdrops/"..game.GetMap().."/spawnspos.dat", util.TableToJSON( postable ) )
	end

end)

net.Receive( "airdrop_drop", function( len, pl ) 

	if checkPlyRank( pl ) then
		spawnDrops()
	end

end)