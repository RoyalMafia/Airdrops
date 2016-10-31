AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

--[[

	NET STRINGS

]]--

util.AddNetworkString( "airdrop_int" )
util.AddNetworkString( "airdrop_receive" )
util.AddNetworkString( "airdrop_request" )

--[[

	VARS

]]--

local drops            = {}
	  drops.dropentid  = {}
	  drops.droptable  = {}
	  drops.droppos    = {}
	  drops.dropaccess = {}

--[[

	FUNCTIONS

]]--

local function inrange( val1, val2, val3 )
	if val3 <= val1 and val3 >= val2 then
		return true
	else
		return false
	end
end

local function addItem( val, dtable )
	local items = {}

	for i = 1, #dropst.items do
		if dropst.items[i].itemVal == val then
			table.insert( items, dropst.items[i].itemName )
		end
	end

	-- Once we've got all the items lets generate a number which is within the item count
	local toSelect = math.random( 1, #items )

	table.insert( dtable, items[toSelect] )
end

local function generateItems( dtable )
	-- So we're going to have 5 items per drop, so you do the math
	for i = 1, 5 do
		-- Now we want to determine what we'll get using a rand num and select the item from that num
		local itemSel = math.random( 0, 1500 ) -- Nice big number for the chances

		-- Real edgy code right here, could be made better, but cba
		if inrange( 1500, 1400, itemSel ) then
			addItem( 5, dtable )
		elseif inrange( 1499, 1200, itemSel ) then
			addItem( 4, dtable )
		elseif inrange( 1199, 900, itemSel ) then
			addItem( 3, dtable )
		elseif inrange( 899, 500, itemSel ) then
			addItem( 2, dtable )
		elseif inrange( 499, 0, itemSel ) then
			addItem( 1, dtable )
		end
	end
end

local function generateID()
	-- I fucking hate entities, and how they don't have network tables, so I made ids for table shit
    local chars = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","1","2","3","4","5","6","7","8","9","0"}
    local seed = math.randomseed( os.time() + math.random( 0, 2000 ) )
    local idtable = {}

    for i = 1, 24 do
        table.insert( idtable, chars[math.random(1,#chars)] )
    end

    local id = table.concat(idtable, "")
    return id
end

local function checkDrop( dropid )
	if #file.Find( "airdrops/tempdrops/"..dropid..".dat", "DATA" ) == 0 then return false else return true end
end

local function checkItem( dropid, id )
	if id > 5 then return false end
	if #file.Find( "airdrops/tempdrops/"..dropid..".dat", "DATA" ) == 0 then return false end
	local tdroptable = util.JSONToTable( file.Read( "airdrops/tempdrops/"..dropid..".dat", "DATA" ) )
	for i = 1, #tdroptable do
		if tdroptable[i] == tdroptable[id] then
			return true
		end
	end
end

local function removeItem( dropid, id )
	local tdroptable = util.JSONToTable( file.Read( "airdrops/tempdrops/"..dropid..".dat", "DATA" ) )
	for i = 1, #tdroptable do
		if i == id then
			table.remove( tdroptable, i )
			file.Write( "airdrops/tempdrops/"..dropid..".dat", util.TableToJSON( tdroptable ) )
		end
	end
end

local function getItemEnt( item )
	for i = 1, #dropst.items do
		if dropst.items[i].itemName == item then
			return dropst.items[i].itemEnt
		end
	end
end

local function spawnEnt( dropid, id )
	local tdroptable = util.JSONToTable( file.Read( "airdrops/tempdrops/"..dropid..".dat", "DATA" ) )
	local item = ents.Create( getItemEnt( tdroptable[id] ) )
	local droppos = nil
	for i = 1, #drops do
		if drops[i].dropentid == dropid then
			droppos = drops[i].droppos
		end
	end
	-- Don't want to try and spawn nil ents
	if !IsValid( item ) then return end
	item:SetPos( droppos + Vector( math.random( -60, 60 ) , math.random( -60, 60 ), 40 ) )
	item:Spawn()
end

local function getItems( dropid )
	return file.Read( "airdrops/tempdrops/"..dropid..".dat", "DATA" )
end

local function removeDrop( dropid )
	for i = 1, #drops do
		if drops[i].dropentid == dropid then
			table.remove( drops, i )
			return
		end
	end
end

local function checkAccess( dropid )
	for i = 1, #drops do
		if drops[i].dropentid == dropid then
			return drops[i].dropaccess
		end
	end
end

local function setAccess( dropid )
	for i = 1, #drops do
		if drops[i].dropentid == dropid then
			drops[i].dropaccess = true
		end
	end
end

--[[

	ENT THINK

]]--

function ENT:Think()
	if self:Getdropid() != nil then
		for i = 1, #drops do
			if drops[i].dropentid == self:Getdropid() then
				drops[i].droptable = self:Getdropitems()
				drops[i].droppos = self:GetPos()
			end
		end
	end

	if self:Getdroplife() > 0 then
		if CurTime() > self.time + 1 then
			self:Setdroplife( self:Getdroplife() - 1 )
			self.time = CurTime()
		end
	elseif self:Getdroplife() == 0 then
		file.Delete( "airdrops/tempdrops/"..self:Getdropid()..".dat" )
		self:Remove()
	end

	if checkDrop( self:Getdropid() ) and self:Getdropitems() != util.TableToJSON( file.Read( "airdrops/tempdrops/"..self:Getdropid()..".dat", "DATA" ) ) then
		local tdroptable = file.Read( "airdrops/tempdrops/"..self:Getdropid()..".dat", "DATA" )
		self:Setdropitems( tdroptable ) 

		if tdroptable == "[]" then
			self:Remove()
		end
	end
end
 
--[[

	ENT INIT

]]--

function ENT:Initialize()
 
 	self.time = CurTime()
	self:SetModel( "models/Items/ammocrate_ar2.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )
	self:Setdropid( generateID() )
	self:Setdroplife( 300 )
	self.itemtable = {}
 
    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end

	generateItems( self.itemtable )

	local jsonstring = util.TableToJSON(  self.itemtable )
	self:Setdropitems( tostring( jsonstring ) )

	-- This is important for serverside validation
	file.Write( "airdrops/tempdrops/"..self:Getdropid()..".dat", self:Getdropitems() )

	local toInsert = {}
		toInsert.dropentid  = self:Getdropid()
		toInsert.droptable  = self:Getdropitems()
		toInsert.droppos    = self:GetPos()
		toInsert.dropaccess = false
	table.insert( drops, toInsert )

end

--[[

	ENT REMOVE

]]--

function ENT:OnRemove()
	-- Need to remove from table
	removeDrop( self:Getdropid() )

	-- If we're removed we need to delete the temp file we made
	file.Delete( "airdrops/tempdrops/"..self:Getdropid()..".dat" )
end

--[[

	ENT INTERACT

]]--

function ENT:AcceptInput( Name, Activator, Caller )	
	if Name == "Use" and Caller:IsPlayer() then

		setAccess( self:Getdropid() )

		net.Start( "airdrop_int" )
			net.WriteString( self:Getdropid() )
			net.WriteString( self:Getdropitems() )
		net.Send( Caller )
	end
end

--[[

	NET RECEIVE

]]--

net.Receive( "airdrop_receive", function( len, pl ) 
	local cldropid = net.ReadString()
	local id = net.ReadInt( 32 )
	if checkItem( cldropid, id ) and checkAccess( cldropid ) then
		spawnEnt( cldropid, id )
		removeItem( cldropid, id )
	end
end)

net.Receive( "airdrop_request", function( len, pl ) 
	local dropid = net.ReadString()
	if checkDrop( dropid ) then
		net.Start( "airdrop_request" )
			net.WriteString( dropid )
			net.WriteString( getItems( dropid ) )
		net.Send( pl )
	end
end)