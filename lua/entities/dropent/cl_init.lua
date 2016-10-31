include( 'shared.lua' )

surface.CreateFont("rylfont1", {font = "Arial",size = 60,weight = 600,blursize = 0,scanlines = 0,antialias = false});

--[[

	VARS

]]--

local menuOpen  = false
local itemtable = {}
local dropid = {}

--[[

	ENT DRAW
	
]]--

function ENT:Draw()
	self:DrawModel()

	local Pos = self:GetPos()
	local Ang = self:GetAngles()
	local Dist = (Pos - LocalPlayer():GetPos()):Length()

	Ang:RotateAroundAxis(Ang:Up(), 90)
	Ang:RotateAroundAxis(Ang:Forward(), 90)	

	cam.Start3D2D(Pos + Ang:Up() * 16.2, Ang, 0.11)
		draw.SimpleText( "Airdrop", "rylfont1", 0, -60, Color( 255, 255, 255 ), 1, 1 ) 
		draw.SimpleText( "Time left "..string.FormattedTime( self:Getdroplife(), "%02i:%02i" ), "DermaLarge", 0, 0, Color( 255, 255, 255 ), 1, 1 )
	cam.End3D2D()

	Ang:RotateAroundAxis(Ang:Up(), 0)
	Ang:RotateAroundAxis(Ang:Forward(), 0)
	Ang:RotateAroundAxis(Ang:Right(), 180 )

	cam.Start3D2D(Pos + Ang:Up() * 16.2, Ang, 0.11)
		draw.SimpleText( "Airdrop", "rylfont1", 0, -60, Color( 255, 255, 255 ), 1, 1 ) 
		draw.SimpleText( "Time left "..string.FormattedTime( self:Getdroplife(), "%02i:%02i" ), "DermaLarge", 0, 0, Color( 255, 255, 255 ), 1, 1 )
	cam.End3D2D()
end

--[[

	FUNCTIONS

]]--

local function getItemVal( item )
	for i = 1, #dropst.items do
		if dropst.items[i].itemName == item then
			return dropst.items[i].itemVal
		end
	end
end

local function getItemName( item )
	for i = 1, #dropst.items do
		if dropst.items[i].itemName == item then
			return dropst.items[i].itemNiceName
		end
	end
end

local function getItemID( item )
	for i = 1, #dropst.items do
		if dropst.items[i].itemName == item then
			return dropst.items[i].itemName
		end
	end
end

local function updateItems( dropid )
	net.Start( "airdrop_request" )
		net.WriteString( dropid )
	net.SendToServer()
end

net.Receive( "airdrop_request", function( len )
	local id = net.ReadString() 
	local items = util.JSONToTable( net.ReadString() )
	if id == dropid then
		itemtable = items
	end
end)

--[[ 

	EDGY MENU

]]--

local function dropmenu( id, items )
	itemtable = items
	dropid = id
	if menuOpen then return end

	menuOpen = true

	local im = vgui.Create( "DFrame" )
	im:SetSize( 530, 135 )
	im:Center()
	im:MakePopup()
	im:SetDraggable( false )
	im:ShowCloseButton( false )
	im:SetTitle( "" )

	function im:Paint( w,h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 20,20,20 ) )
		draw.RoundedBox( 0, 0, 0, w, 25, Color( 240, 70, 70 ) )

		draw.SimpleText( "Airdrop Inventory", "Trebuchet24", 5, 12.5, Color( 0, 0, 0, 100 ), 0, 1 )
	end

	function im:Think()
		if #itemtable == 0 then
			im:Close()
		end
	end

	local clbtn = vgui.Create( "DButton", im)
	clbtn:SetText( "" )
	clbtn:SetPos( im:GetWide() - 25, 0 )
	clbtn:SetSize( 25, 25 )

	function clbtn:Paint(w, h)
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 150 ) )

		if clbtn:IsHovered() then
			draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 255, 10 ) )
		end

		draw.SimpleText( "X", "Trebuchet24", w / 2, h / 2, Color( 0, 0, 0, 100 ), 1, 1 )
	end

	function clbtn:DoClick()
		menuOpen = false
		im:Close()
	end

	local il = vgui.Create( "DIconLayout", im )
	il:SetSize( im:GetWide() - 10, 100 )
	il:SetPos( 5, 30 )
	il:SetSpaceX( 5 )
	il:SetSpaceY( 0 )

	for i = 1, #itemtable do
		local id = il:Add( "DButton" )
		id:SetSize( 100, 100 )
		id:SetText( "" )

		function id:Paint( w,h )
			if itemtable[i] == nil then return end

			local col = dropst.cols[ getItemVal( itemtable[i] ) ]
			local val = dropst.vals[ getItemVal( itemtable[i] ) ]
			draw.RoundedBox( 0, 0, 0, w, h, col )

			if id:IsHovered() then
				draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 255, 50 ) )
			end

			draw.SimpleText( val, "Trebuchet18", w / 2, 10, Color( 0, 0, 0, 150 ), 1, 1 )
			draw.SimpleText( getItemName( itemtable[i] ) or "nil" , "Trebuchet18", w / 2, h - 10, Color( 0, 0, 0, 150 ), 1, 1 )
			draw.SimpleText( "Click to drop", "Trebuchet18", w / 2, h / 2, Color( 0, 0, 0, 150 ), 1, 1 )

		end

		function id:DoClick()
			net.Start( "airdrop_receive" )
				net.WriteString( dropid )
				net.WriteInt( i, 32 )
				net.WriteString( getItemID( itemtable[i] ) )
			net.SendToServer()

			if #itemtable == 1 then
				menuOpen = false
				im:Close()
			else
				updateItems( dropid )
			end
		end
	end
end

net.Receive( "airdrop_int", function( len ) 
	local rdropid = net.ReadString()
	local itemtable = util.JSONToTable( net.ReadString() )
	dropmenu( rdropid, itemtable )
end)