TOOL.Category		= "Construction" -- Name of the category
TOOL.Name			= "#Tool.door.listname"		 -- Name to display
TOOL.Command		= nil			 -- Command on click (nil for default)
TOOL.ConfigName		= ""			 -- Config file name (nil for default)
--Welcome to the new door sTool! We here at Darkstorm Servers will continue to support this addon long after SOH has left. He did some great work, however, this addon is essential for
--the GMOD community


-- TOOL.ClientConVar[ "class" ] = "prop_dynamic"
-- TOOL.ClientConVar[ "model" ] = "models/props_combine/combine_door01.mdl"
TOOL.ClientConVar[ "open" ] = "38"
TOOL.ClientConVar[ "close" ] = "39"
TOOL.ClientConVar[ "autoclose" ] = "0"
TOOL.ClientConVar[ "closetime" ] = "5"
-- TOOL.ClientConVar[ "hardware" ] = "0"
TOOL.ClientConVar[ "skin" ] = "1"
TOOL.ClientConVar[ "lock" ] = "1"
// added so workshop would let me upload lolo xD



TOOL.ClientConVar["index"] = "7"

local DoorTypes = {
	{name = "Combine Door", folder = true},
		{name = "Tall", class = "prop_dynamic", model = "models/props_combine/combine_door01.mdl"},
		{name = "Big", class = "prop_dynamic", model = "models/combine_gate_Vehicle.mdl"},
		{name = "Small", class = "prop_dynamic", model = "models/combine_gate_citizen.mdl"},
	{folderend = true},
			
	{name = "Door", folder = true},
		{name = "No Handle", hardware = "0", class = "prop_door_rotating", model = "models/props_c17/door01_left.mdl"},
		{name = "Lever", hardware = "1", class = "prop_door_rotating", model = "models/props_c17/door01_left.mdl"},
		{name = "Pushbar", hardware = "2", class = "prop_door_rotating", model = "models/props_c17/door01_left.mdl"},
	{folderend = true},

	{name = "Iron Door", folder = true},
		{name = "No Handle", hardware = "0", class = "prop_door_rotating", model = "models/props_doors/door03_slotted_left.mdl"},
		{name = "Lever", hardware = "1", class = "prop_door_rotating", model = "models/props_doors/door03_slotted_left.mdl"},
		{name = "Pushbar", hardware = "2", class = "prop_door_rotating", model = "models/props_doors/door03_slotted_left.mdl"},
	{folderend = true},

	{name = "Slim Door", folder = true},
		{name = "No Handle", hardware = "0", class = "prop_door_rotating", model = "models/props_c17/door02_double.mdl"},
		{name = "Lever", hardware = "1", class = "prop_door_rotating", model = "models/props_c17/door02_double.mdl"},
	{folderend = true},

	{name = "Elevator Doors", folder = true},
		{name = "Elevator Door", class = "prop_dynamic", model = "models/props_lab/elevatordoor.mdl"},
		{name = "Small Elevator Door", class = "prop_dynamic", model = "models/boreas/bunker/elevatordoor_resized.mdl"},
	{folderend = true},
	
	{name = "Kleiner's Lab Blast Door", class = "prop_dynamic", model = "models/props_doors/doorKLab01.mdl"},
	
	{name = "Beta Doors (These aren't fully functional yet)", folder = true},
		{name = "Ship Door", hardware = "0", class = "prop_door_rotating", model = "models/props_borealis/borealis_door001a.mdl"},
		{name = "Jail Door", hardware = "0", class = "prop_door_rotating", model = "models/props_c17/gate_door01a.mdl"},
		{name = "Heavy Door", class = "prop_dynamic", model = "models/props_wasteland/prison_heavydoor001a.mdl"},
		{name = "Fridge Top Door", hardware = "0", class = "prop_door_rotating", model = "models/props_interiors/refrigeratorDoor02a.mdl"},
		{name = "Fridge Bottom Door", hardware = "0", class = "prop_door_rotating", model = "models/props_interiors/refrigeratorDoor01a.mdl"},
		{name = "Fridge Bottom Door", hardware = "0", class = "prop_door_rotating", model = "models/props_interiors/refrigeratorDoor01a.mdl"},
	{folderend = true},
	
}

local function checkIfValidModel(model)
	local validModel = false
	for k,v in pairs(DoorTypes) do
		if (!v.model) then continue end
		if (string.lower(v.model) == string.lower(tostring(model))) then validModel = true break end
	end
	if (!validModel) then return false end
	return true
end


/*
local function SetDoor( Player, Entity, Data )
	if ( Data.Hardware ) then Entity:SetKeyValue( "renderfx", Data.RenderFX ) end
	if ( Data.Autoclose ) then Entity:SetKeyValue( "renderfx", Data.RenderFX ) end
	if ( Data.Lock ) then Entity:SetKeyValue( "renderfx", Data.RenderFX ) end
	if ( Data.Autoclose ) then Entity:SetKeyValue( "renderfx", Data.RenderFX ) end

	if ( SERVER ) then
		duplicator.StoreEntityModifier( Entity, "door", Data )
	end
	
end
duplicator.RegisterEntityModifier( "door", SetDoor )
*/

if CLIENT then
	language.Add( "Tool.door.name", "New Door Tool" )
	language.Add( "Tool.door.cpanelname", "New Door Tool - Last Updated: 7/22/2020" )
	language.Add( "Tool.door.desc", "Spawn a functional door." )
	language.Add( "Tool.door.longdesc", "~The New Door Tool~\nLast Updated: 7/22/2020 \n\n© Darkstorm Servers 2020. \nhttps://darkstorm.cc \nA part of the Garry's Mod community since 2014.\n\nGmod-specific Bugs:\n-Savegames do not cooperate \n-You cannot weld doors" )
	language.Add( "Tool.door.0", "Left click to spawn a door." )
	language.Add( "Tool.door.listname", "Door Tool" )

	language.Add( "Undone_door", "Undone Door" )
	language.Add( "Cleanup_door", "Door" )
	language.Add( "SBoxLimit_doors", "Max doors reached!" )
	language.Add( "Cleaned_door", "Cleaned up all doors." )
end

if SERVER then
	if !ConVarExists("sbox_maxdoors") then CreateConVar("sbox_maxdoors", 16, {FCVAR_NOTIFY}) end

	cleanup.Register("doors")
	duplicator.RegisterEntityClass( "prop_dynamic", function( ply, data )
		PrintTable( data )
		duplicator.GenericDuplicatorFunction( ply, data )
	end, "Data" )
	duplicator.RegisterEntityClass( "prop_door_rotating", function( ply, data )
		PrintTable( data )
		duplicator.GenericDuplicatorFunction( ply, data )
	end, "Data" )
	
	local Doors = {}
	local function Save( save )
		saverestore.WriteTable( Doors, save )
	end
	local function Restore( restore )
		Doors = saverestore.ReadTable( restore )
	end
	saverestore.AddSaveHook( "Doors", Save )
	saverestore.AddRestoreHook( "Doors", Restore )

	function openDoor(ply, ent, autoclose, closetime)
		if !IsValid(ent) then return end
		ent:Fire("setanimation", "open", "0")
		if autoclose == 1 then ent:Fire("setanimation", "close", closetime) end
	end

	function closeDoor(ply, ent)
		if not ent:IsValid() then return end
		ent:Fire("setanimation", "close", "0")
	end
	numpad.Register("door_open", openDoor) 
	numpad.Register("door_close", closeDoor)
	
	function makeDoor(ply, trace, ang, model, open, close, autoclose, closetime, class, hardware, skin, lock)
		if (!ply:CheckLimit("doors")) then return nil end
		
		
		
		local ent = ents.Create(class)
		ent:SetModel(model)
		
		local BBMin = ent:OBBMins()
		local pos = Vector(trace.HitPos.X,trace.HitPos.Y,trace.HitPos.Z - (trace.HitNormal.z * BBMin.z) )
		
		ent:SetSkin(skin)
		ent:SetPos(pos)
		ent:SetAngles(Angle(0, ang.Yaw, 0))
		
		if tostring(class) == "prop_dynamic" then
			ent:SetKeyValue("solid", "6")
			ent:SetKeyValue("MinAnimTime", "1")
			ent:SetKeyValue("MaxAnimTime", "5")
		elseif tostring(class) == "prop_door_rotating" then
			ent:SetKeyValue("hardware", hardware)
			ent:SetKeyValue("distance", "90")
			ent:SetKeyValue("speed", "100")
			ent:SetKeyValue("returndelay", "-1")
			ent:SetKeyValue("spawnflags", "8192")
			ent:SetKeyValue("forceclosed", "0")
			if (lock == 1) then
				ent:Fire("lock", "", 0)
			else
				ent:Fire("unlock", "", 0)
			end
		else
			return
		end

		ent:Spawn()
		ent:Activate()
		
		local chip
		if WireLib then
		//	chip = ents.Create("gmod_door_gate")
		//		chip:SetPos(trace.HitPos)
		//		chip:SetAngles(Angle(0, 0, 0))
		//		chip:SetDoorEnt(ent)
		//		chip:Spawn()
		end

		numpad.OnDown(ply, open, "door_open", ent, autoclose, closetime)			
		if tostring(class) != "prop_door_rotating" then
			numpad.OnDown(ply, close, "door_close", ent, autoclose, closetime)	
		end
		
		ply:AddCount("doors", ent)
		ply:AddCleanup("doors", ent)
		if IsValid(chip) then
			ply:AddCleanup("doors", chip)
		end
		
		local index = ply:UniqueID()
		Doors[index] = Doors[index] or {}
		ent.hardware = hardware
		ent.openkey = open
		ent.closekey = close
		ent.autoclose = autoclose
		table.insert(Doors[index], ent)
		
		undo.Create("Door")
			undo.AddEntity(ent)
			undo.SetPlayer(ply)
		undo.Finish()
	end
end

function TOOL:LeftClick( tr )
	if CLIENT then return true end

	
	local open = self:GetClientNumber("open")
	local close = self:GetClientNumber("close") 
	local ply = self:GetOwner()
	local ang = ply:GetAimVector():Angle()
	local autoclose = self:GetClientNumber("autoclose") 
	local closetime = self:GetClientNumber("closetime") 
	local skin = self:GetClientNumber("skin")
	local lock = self:GetClientNumber("lock")
	
	local door = DoorTypes[self:GetClientNumber("index")]
	if (!door or door.folder or door.folderend) then return false end
	local hardware = door.hardware
	local model = door.model
	local class = door.class
	
	if (!self:GetSWEP():CheckLimit("doors")) then return false end

	if !util.IsValidModel(model) then return end
	makeDoor(ply, tr, ang, model, open, close, autoclose, closetime, class, hardware, skin, lock)
	
	return true
end

local Header
local Skin
local NoSkin
function TOOL:UpdateSkinCount()
	if !Skin then return end
	if (!DoorTypes[tonumber(self:GetClientInfo("index"))] or !DoorTypes[tonumber(self:GetClientInfo("index"))].model) then return end
	local num = NumModelSkins(DoorTypes[tonumber(self:GetClientInfo("index"))].model) - 1
	if num == 0 then
		NoSkin:SetVisible(true)
		Skin:SetVisible(false)
		return
	else
		NoSkin:SetVisible(false)
		Skin:SetVisible(true)
	end
	Skin:SetMax(num)
	//Skin:SetValue(0)
end

function TOOL.BuildCPanel( CPanel )
	Header = CPanel:AddControl( "Header", { Text = "#Tool.door.name", Description	= "#Tool.door.longdesc" }  )

	local Tree = vgui.Create("DTree")
	Tree:SetPos(2, 2)
	Tree:SetSize(Header:GetWide() - 4, 250)
	Tree:SetIndentSize(0)

	local Folder
	for k,v in pairs(DoorTypes) do
		local node
		if v.folder then
			Folder = Tree:AddNode(v.name)
			Folder.Icon:SetImage("icon16/door.png")
			function Folder:InternalDoClick() end
			function Folder:DoClick() return false end

			local FolderLabel = Folder.Label
			function FolderLabel:UpdateColours(skin) return self:SetTextStyleColor(Color(161, 161, 161)) end

			continue
		end
		if v.folderend then Folder = nil continue end

		if Folder then
			node = Folder:AddNode(v.name)
			node.Icon:SetImage("icon16/bullet_blue.png")
		else
			node = Tree:AddNode(v.name)
			node.Icon:SetImage("icon16/door.png")
		end

		function node:DoClick()
			RunConsoleCommand("door_index", k)

		end
	end
	CPanel:AddItem(Tree)

	CPanel:AddControl( "Numpad", {
						Label = "#Door Open",
						Label2 = "#Door Close",
						Command = "door_open",
						Command2 = "door_close",
						ButtonSize = 22})

	CPanel:AddControl("Slider", { 
						Label	= "Auto-Close Delay",
						Type	= "Float",
						Min		= 0,
						Max		= 100,
						Command = "door_closetime"})

	CPanel:AddControl("Checkbox", {
						Label = "Auto-Close",
						Command = "door_autoclose"})

	CPanel:AddControl("Checkbox", {
						Label = "Lock door on spawn?",
						Command = "door_lock"})

	Skin = vgui.Create("DNumSlider")
	Skin:SetWide(CPanel:GetWide())
	Skin:SetText("Skin")
	Skin:SetMin(0)
	Skin:SetMax(20)
	Skin:SetValue(0)
	Skin:SetDecimals(0)
	Skin:SetConVar("door_skin")
	Skin.Label:SetColor(Color(0,0,0))
	CPanel:AddItem(Skin)

	NoSkin = vgui.Create("DLabel")
	NoSkin:SetParent(Skin)
	NoSkin:SetText("No skins for model.")
	NoSkin:SetColor(Color(0,0,0))
	NoSkin:SizeToContentsX()
	NoSkin:SetPos((NoSkin:GetParent():GetWide()/2 - NoSkin:GetWide()/2), 0)
	NoSkin:SetVisible(true)
end

function TOOL:MakeGhostEntity( model, pos, angle )
	util.PrecacheModel( model )

	-- We do ghosting serverside in single player
	-- It's done clientside in multiplayer
	if (SERVER && !game.SinglePlayer()) then return end
	if (CLIENT && game.SinglePlayer()) then return end

	-- Release the old ghost entity
	self:ReleaseGhostEntity()

	-- Check for invalid model
	if (!util.IsValidModel( model )) then return end
	
	if (CLIENT) then
		self.GhostEntity = ents.CreateClientProp(model)
	else
		if (util.IsValidRagdoll(model)) then
			self.GhostEntity = ents.Create("prop_dynamic")
		else
			self.GhostEntity = ents.Create("prop_physics")
		end
	end

	-- If there's too many entities we might not spawn..
	if (!self.GhostEntity:IsValid()) then
		self.GhostEntity = nil
		return
	end

	self.GhostEntity:SetModel( model )
	self.GhostEntity:SetPos( pos )
	self.GhostEntity:SetAngles( angle )
	self.GhostEntity:Spawn()
	
	self.GhostEntity:SetSolid( SOLID_VPHYSICS );
	self.GhostEntity:SetMoveType( MOVETYPE_NONE )
	self.GhostEntity:SetNotSolid( true );
	self.GhostEntity:SetRenderMode( RENDERMODE_TRANSALPHA )
	self.GhostEntity:SetColor( Color( 255, 255, 255, 150 ) )
end

function TOOL:UpdateGhost(ent, ply)
	if !ent then return end
	if !ent:IsValid() then return end
	
	local tr = util.GetPlayerTrace(ply)
	local trace = util.TraceLine(tr)

	if (!trace.Hit) then return end

	local ang = ply:GetAimVector():Angle() 
	local BBMin = ent:OBBMins()
	local pos = Vector(trace.HitPos.X, trace.HitPos.Y, trace.HitPos.Z - (trace.HitNormal.z * BBMin.z))
	local skin = self:GetClientNumber("skin")

	ent:SetSkin(skin)
	ent:SetPos(pos)
	ent:SetAngles(Angle(0, ang.Yaw, 0))
	ent:SetNoDraw(false)
end


function TOOL:Think()
	if (!DoorTypes[tonumber(self:GetClientInfo("index"))] or !DoorTypes[tonumber(self:GetClientInfo("index"))].model) then return end
	if (!self.GhostEntity || !self.GhostEntity:IsValid() || self.GhostEntity:GetModel() != DoorTypes[tonumber(self:GetClientInfo("index"))].model) then
		self:MakeGhostEntity(DoorTypes[tonumber(self:GetClientInfo("index"))].model, Vector(0,0,0), Angle(0,0,0))
		self:UpdateSkinCount()
	end
	
	self:UpdateGhost(self.GhostEntity, self:GetOwner())
end
