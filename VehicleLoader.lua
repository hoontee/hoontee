local VehicleLoader = {} local Global, Modules, Remotes, Print, Warn, Trace, New

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Helper Variables
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local PI = math.pi
local ROTATIONS = {
	CFrame.Angles(0,		0,		0		),
	CFrame.Angles(PI/2,		0,		0		),
	CFrame.Angles(PI,		0,		0		),
	CFrame.Angles(-PI/2,	0,		0		),
	CFrame.Angles(0,		PI/2,	0		),
	CFrame.Angles(PI/2,		PI/2,	0		),
	CFrame.Angles(PI,		PI/2,	0		),
	CFrame.Angles(-PI/2,	PI/2,	0		),
	CFrame.Angles(0,		PI,		0		),
	CFrame.Angles(PI/2,		PI,		0		),
	CFrame.Angles(PI,		PI,		0		),
	CFrame.Angles(-PI/2,	PI,		0		),
	CFrame.Angles(0,		-PI/2,	0		),
	CFrame.Angles(PI/2,		-PI/2,	0		),
	CFrame.Angles(PI,		-PI/2,	0		),
	CFrame.Angles(-PI/2,	-PI/2,	0		),
	CFrame.Angles(0,		0,		PI/2	),
	CFrame.Angles(PI/2,		0,		PI/2	),
	CFrame.Angles(PI,		0,		PI/2	),
	CFrame.Angles(-PI/2,	0,		PI/2	),
	CFrame.Angles(0,		PI/2,	PI/2	),
	CFrame.Angles(PI/2,		PI/2,	PI/2	),
	CFrame.Angles(PI,		PI/2,	PI/2	),
	CFrame.Angles(-PI/2,	PI/2,	PI/2	),
	CFrame.Angles(0,		PI,		PI/2	),
	CFrame.Angles(PI/2,		PI,		PI/2	),
	CFrame.Angles(PI,		PI,		PI/2	),
	CFrame.Angles(-PI/2,	PI,		PI/2	),
	CFrame.Angles(0,		-PI/2,	PI/2	),
	CFrame.Angles(PI/2,		-PI/2,	PI/2	),
	CFrame.Angles(PI,		-PI/2,	PI/2	),
	CFrame.Angles(-PI/2,	-PI/2,	PI/2	),
	CFrame.Angles(0,		0,		PI		),
	CFrame.Angles(PI/2,		0,		PI		),
	CFrame.Angles(PI,		0,		PI		),
	CFrame.Angles(-PI/2,	0,		PI		),
	CFrame.Angles(0,		PI/2,	PI		),
	CFrame.Angles(PI/2,		PI/2,	PI		),
	CFrame.Angles(PI,		PI/2,	PI		),
	CFrame.Angles(-PI/2,	PI/2,	PI		),
	CFrame.Angles(0,		PI,		PI		),
	CFrame.Angles(PI/2,		PI,		PI		),
	CFrame.Angles(PI,		PI,		PI		),
	CFrame.Angles(-PI/2,	PI,		PI		),
	CFrame.Angles(0,		-PI/2,	PI		),
	CFrame.Angles(PI/2,		-PI/2,	PI		),
	CFrame.Angles(PI,		-PI/2,	PI		),
	CFrame.Angles(-PI/2,	-PI/2,	PI		),
	CFrame.Angles(0,		0,		-PI/2	),
	CFrame.Angles(PI/2,		0,		-PI/2	),
	CFrame.Angles(PI,		0,		-PI/2	),
	CFrame.Angles(-PI/2,	0,		-PI/2	),
	CFrame.Angles(0,		PI/2,	-PI/2	),
	CFrame.Angles(PI/2,		PI/2,	-PI/2	),
	CFrame.Angles(PI,		PI/2,	-PI/2	),
	CFrame.Angles(-PI/2,	PI/2,	-PI/2	),
	CFrame.Angles(0,		PI,		-PI/2	),
	CFrame.Angles(PI/2,		PI,		-PI/2	),
	CFrame.Angles(PI,		PI,		-PI/2	),
	CFrame.Angles(-PI/2,	PI,		-PI/2	),
	CFrame.Angles(0,		-PI/2,	-PI/2	),
	CFrame.Angles(PI/2,		-PI/2,	-PI/2	),
	CFrame.Angles(PI,		-PI/2,	-PI/2	),
	CFrame.Angles(-PI/2,	-PI/2,	-PI/2	),
}
local B85_ENCODE_TABLE = {
	"0", "1", "2", "3", "4",
	"5", "6", "7", "8", "9",
	"A", "B", "C", "D", "E",
	"F", "G", "H", "I", "J",
	"K", "L", "M", "N", "O",
	"P", "Q", "R", "S", "T",
	"U", "V", "W", "X", "Y",
	"Z", "a", "b", "c", "d",
	"e", "f", "g", "h", "i",
	"j", "k", "l", "m", "n",
	"o", "p", "q", "r", "s",
	"t", "u", "v", "w", "x",
	"y", "z", "!", "#", "$",
	"%", "&", "(", ")", "*",
	"+", "-", ";", "<", "=",
	">", "?", "@", "^", "_",
	"`", "{", "|", "}", "~",
}
local B85_DECODE_TABLE = {
	[ 48]= 0, [ 49]= 1, [ 50]= 2, [ 51]= 3, [ 52]= 4,
	[ 53]= 5, [ 54]= 6, [ 55]= 7, [ 56]= 8, [ 57]= 9,
	[ 65]=10, [ 66]=11, [ 67]=12, [ 68]=13, [ 69]=14,
	[ 70]=15, [ 71]=16, [ 72]=17, [ 73]=18, [ 74]=19,
	[ 75]=20, [ 76]=21, [ 77]=22, [ 78]=23, [ 79]=24,
	[ 80]=25, [ 81]=26, [ 82]=27, [ 83]=28, [ 84]=29,
	[ 85]=30, [ 86]=31, [ 87]=32, [ 88]=33, [ 89]=34,
	[ 90]=35, [ 97]=36, [ 98]=37, [ 99]=38, [100]=39,
	[101]=40, [102]=41, [103]=42, [104]=43, [105]=44,
	[106]=45, [107]=46, [108]=47, [109]=48, [110]=49,
	[111]=50, [112]=51, [113]=52, [114]=53, [115]=54,
	[116]=55, [117]=56, [118]=57, [119]=58, [120]=59,
	[121]=60, [122]=61, [ 33]=62, [ 35]=63, [ 36]=64,
	[ 37]=65, [ 38]=66, [ 40]=67, [ 41]=68, [ 42]=69,
	[ 43]=70, [ 45]=71, [ 59]=72, [ 60]=73, [ 61]=74,
	[ 62]=75, [ 63]=76, [ 64]=77, [ 94]=78, [ 95]=79,
	[ 96]=80, [123]=81, [124]=82, [125]=83, [126]=84,
}
local B85_PART_LENGTH = 2
local B85_POSITION_LENGTH = 3
local B85_ROTATION_LENGTH = 1
local B85_COLOR_LENGTH = 1
local B85_TOTAL_LENGTH = 5

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VehicleLoader Variables
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

VehicleLoader.VoxelScale = 2
VehicleLoader.VehicleExtents = 24

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Helper Functions
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function XYZToInt(X: number, Y: number, Z: number, Size: number): number
	return X * Size * Size + Y * Size + Z
end

local function IntToB85(Int: number, Length: number): string
	if Int >= 85 ^ Length then error(("%i exceeds maximum value of %i"):format(Int, 85 ^ Length - 1)) end

	local Digits = ""

	while Int > 0 do
		Digits = B85_ENCODE_TABLE[Int % 85 + 1] .. Digits
		Int = math.floor(Int / 85)
	end

	return ("0"):rep(Length - #Digits) .. Digits
end

local function B85ToInt(B85: string): number
	local Int = 0
	local Length = #B85

	for Index = Length, 1, -1 do
		Int += B85_DECODE_TABLE[B85:sub(Index, Index):byte()] * math.pow(85, Length - Index)
	end

	return Int
end

local function IntToXYZ(Int: number, Size: number): number
	local Z = Int % Size
	local Y = (Int - Z) / Size % Size
	local X = (Int - Z) / Size / Size - Y / Size

	return X, Y, Z
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Module Functions
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function VehicleLoader.WorldToGrid(Position: Vector3): Vector3
	local Result = Position / VehicleLoader.VoxelScale + Vector3.new(VehicleLoader.VehicleExtents / 2, -1, VehicleLoader.VehicleExtents / 2)
	return Vector3.new(math.clamp(math.round(Result.X), 0, VehicleLoader.VehicleExtents), math.clamp(math.round(Result.Y), 0, VehicleLoader.VehicleExtents), math.clamp(math.round(Result.Z), 0, VehicleLoader.VehicleExtents))
end

function VehicleLoader.GridToWorld(Position: Vector3): Vector3
	return (Position - Vector3.new(VehicleLoader.VehicleExtents / 2, -1, VehicleLoader.VehicleExtents / 2)) * VehicleLoader.VoxelScale
end

function VehicleLoader:Unpack(Data: string): {{}}
	if type(Data) ~= "string" then error("Data is not a string") end

	local Vehicle = {}
	local Begin = 1

	while true do
		local End = Data:find(" ", Begin, true)
		local PartTable = Data:sub(Begin, (End or 0) - 1)
		local PartId = B85ToInt(PartTable:sub(1, B85_PART_LENGTH))

		Vehicle[PartId] = {}

		for Index = 0, (#PartTable - B85_PART_LENGTH) / B85_TOTAL_LENGTH - 1 do
			local PlacementBegin = B85_PART_LENGTH + Index * B85_TOTAL_LENGTH + 1
			local Placement = PartTable:sub(PlacementBegin, PlacementBegin + B85_TOTAL_LENGTH - 1)

			table.insert(Vehicle[PartId], {
				Position = Vector3.new(IntToXYZ(B85ToInt(Placement:sub(1, B85_POSITION_LENGTH)), VehicleLoader.VehicleExtents)),
				Rotation = B85ToInt(Placement:sub(B85_POSITION_LENGTH + 1, B85_POSITION_LENGTH + B85_ROTATION_LENGTH)),
				Color = B85ToInt(Placement:sub(B85_POSITION_LENGTH + B85_ROTATION_LENGTH + 1, -1))
			})
		end

		if End then
			Begin = End + 1
		else
			Print("Unpacked", Vehicle)
			return Vehicle
		end
	end
end

function VehicleLoader:Pack(Vehicle: {{any}}): string
	if type(Vehicle) ~= "table" then error("Vehicle is not a table") end

	local B85 = ""

	for PartId, Placements in Vehicle do
		B85 ..= " " .. IntToB85(PartId, B85_PART_LENGTH)
		for _, Placement in Placements do
			B85 ..= IntToB85(XYZToInt(Placement.Position.X, Placement.Position.Y, Placement.Position.Z, VehicleLoader.VehicleExtents), B85_POSITION_LENGTH)
			B85 ..= IntToB85(Placement.Rotation, B85_ROTATION_LENGTH)
			B85 ..= IntToB85(Placement.Color, B85_COLOR_LENGTH)
		end
	end

	Print("Packed", B85:sub(2, -1))
	return B85:sub(2, -1) -- Remove extra space
end

function VehicleLoader:Insert(Data: string): Model
	local Vehicle = VehicleLoader:Unpack(Data)
	local VehicleModel = New.Instance("Model", nil, "Vehicle")

	for PartId, Placements in Vehicle do
		for _, Placement in Placements do
			local NewPart = Modules.Shared.Parts[PartId].Model:Clone()
			NewPart.Color = Modules.Shared.PartColors[Placement.Color]
			NewPart.CFrame = CFrame.new(VehicleLoader.GridToWorld(Placement.Position)) * ROTATIONS[Placement.Rotation + 1]
			NewPart:SetAttribute("Position", Placement.Position)
			NewPart:SetAttribute("Rotation", Placement.Rotation)
			NewPart.Parent = VehicleModel
		end
	end

	return VehicleModel
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

return function(...) Global, Modules, Remotes, Print, Warn, Trace, New = ... return VehicleLoader end
