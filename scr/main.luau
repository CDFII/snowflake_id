local Snowflake = {}

-- Function defaults
local TextGenDefaultSlice = 1
local AddPrefixBeforeId = true

-- Variables and constants
local UseServerTime = true  	-- Use server time (true) or local time (false)
local EPOCH = 946684800     	-- January 1, 2000 12:00:00 AM GMT/UTC (seconds)
local RandomLenght = 4      	-- How many integrers to include from random generator (max 16) (rounded upwards)
local TextGenUTF8Offset = 65	-- Specifies offset in utf8 alphabet characters (65 = A, 97 = a)

function Snowflake.new(): SnowflakeID
	local currentTime = if UseServerTime then workspace:GetServerTimeNow() else os.time()

	local randomInstance = Random.new()

	local timestamp = math.floor((currentTime - EPOCH) * 1000) -- Convert to milliseconds and adjust for epoch
	local random = math.floor(randomInstance:NextNumber() * 10^RandomLenght)

	local id = `{tostring(timestamp)}{tostring(random)}`
	return {
		ID = id,
		RandomGen = random,
		Timestamp = timestamp,
        HasPrefix = false
	}
end

function Snowflake.AddPrefix(ID: SnowflakeID, Prefix: string, before: boolean?): SnowflakeID
	assert(ID, "ID was not provided or was nil")
	assert(Prefix, "Prefix was not provided or was nil")
	before = before or AddPrefixBeforeId
	
	if before then
		return {
			ID = `{Prefix}{ID.ID}`,
			RandomGen = ID.RandomGen,
			Timestamp = ID.Timestamp,
			HasPrefix = true
		}
	else	
		return {
			ID = `{ID.ID}{Prefix}`,
			RandomGen = ID.RandomGen,
			Timestamp = ID.Timestamp,
			HasPrefix = true
		}
	end
end

function Snowflake.ConvertIntoChars(ID: SnowflakeID, SliceEveryXStep: number?): string
	SliceEveryXStep = SliceEveryXStep or TextGenDefaultSlice -- ID slicing step
	local NewId = ""
	
	for i = 1, #ID.ID, SliceEveryXStep do
		local SlicedPart = ID.ID:sub(i, i + SliceEveryXStep - 1)
		local Char = utf8.char(tonumber(SlicedPart) + TextGenUTF8Offset)
		NewId = NewId .. Char
	end
	
	return NewId
end

-- Type exporting
export type SnowflakeID = {
	ID: string,
	RandomGen: number,
	Timestamp: number,
	HasPrefix: boolean
}

return Snowflake
