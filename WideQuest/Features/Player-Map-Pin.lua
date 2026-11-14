local _, ns = ...

local PLAYER_TEMPLATE = "WideQuestPlayerPinTemplate"

local PLAYER_LEVEL = "PIN_FRAME_LEVEL_WIDEQUEST_PLAYER"
local INTERVAL = 0.03

local function PlayerMapPosition(mapID)
	local hereBeDragons = ns.questie.HereBeDragons()
	if hereBeDragons then
		local x, y, instance = ns.questie.PlayerPosition()
		if x and ns.IsReadable(x, y, instance) then
			local mapX, mapY = hereBeDragons:GetZoneCoordinatesFromWorldInstance(x, y, instance, mapID, true)
			if mapX and mapY then
				return mapX, mapY
			end
		end
	end
	local position = C_Map.GetPlayerMapPosition(mapID, "player")
	if position then
		local x, y = position:GetXY()
		if ns.IsReadable(x, y) then
			return x, y
		end
	end
end

local function PlacePlayer(pin)
	local mapID = pin:GetMap():GetMapID()
	local x, y
	if mapID then
		x, y = PlayerMapPosition(mapID)
	end
	local facing = GetPlayerFacing()
	if not (x and y) or x < 0 or x > 1 or y < 0 or y > 1 or not (facing and ns.IsReadable(facing)) then
		pin.Arrow:Hide()
		return
	end
	pin:SetPosition(x, y)
	pin.Arrow:SetRotation(facing)
	pin.Arrow:Show()
end

local function OnUpdate(pin, elapsed)
	pin.sinceMove = (pin.sinceMove or 0) + elapsed
	if pin.sinceMove >= INTERVAL then
		pin.sinceMove = 0
		PlacePlayer(pin)
	end
end

local providerMixin = CreateFromMixins(MapCanvasDataProviderMixin)

function providerMixin:RemoveAllData()
	self:GetMap():RemoveAllPinsByTemplate(PLAYER_TEMPLATE)
end

function providerMixin:RefreshAllData()
	self:RemoveAllData()
	local pin = self:GetMap():AcquirePin(PLAYER_TEMPLATE)
	pin:UseFrameLevelType(PLAYER_LEVEL)
	pin:ApplyFrameLevel()
	pin:SetScript("OnUpdate", OnUpdate)
	PlacePlayer(pin)
	pin:ApplyCurrentScale()
end

function ns.AddPlayerPinLevel(map)
	map:GetPinFrameLevelsManager():AddFrameLevel(PLAYER_LEVEL)
end

function ns.AddPlayerPin(map)
	map:AddDataProvider(CreateFromMixins(providerMixin))
end
