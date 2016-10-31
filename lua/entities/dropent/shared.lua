ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName= "Airdrop ENT"
ENT.Category = "Airdrop" 
ENT.Author= "Ryl"
ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
	
	-- I hate entities they're real edgy and annoying
	self:NetworkVar( "String", 1, "dropid" )
	self:NetworkVar( "Int", 2, "droplife" )

end