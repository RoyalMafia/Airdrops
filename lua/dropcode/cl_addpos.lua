--[[

	CHAT COMMANDS

]]--

hook.Add( "OnPlayerChat", "AddDropPos", function( ply, strText, bTeam, bDead ) 
	if ply == LocalPlayer() and string.lower( strText ) == "!dropadd" then
		net.Start( "airdrop_dropadd" )
			net.WriteVector( ply:GetEyeTrace().HitPos )
		net.SendToServer()
	elseif ply == LocalPlayer() and string.lower( strText ) == "!forcedrop" then
		net.Start( "airdrop_drop" )
		net.SendToServer()
	end
end)

--[[

	NET RECEIVE

]]--

net.Receive( "airdrop_notify", function( len ) 
	chat.AddText( Color(240,70,70), "[Airdrop] ", Color(255,255,255), net.ReadString() )
end)