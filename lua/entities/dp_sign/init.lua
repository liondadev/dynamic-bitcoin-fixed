AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props/cs_assault/Billboard.mdl")
    -- NOTE(Livaco): You copied this from somewhere lol. Spacing is different.
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )
    self:PhysicsInit( SOLID_VPHYSICS )
    local phys = self:GetPhysicsObject()
    if ( IsValid( phys ) ) then phys:Wake() end
    self:SetUseType(SIMPLE_USE) -- NOTE(Livaco): No use functions, no need for this to be here.
end