local _, ns = ...

local questMap = ns.questMap
local canvas = questMap.canvas
local state = ns.questLog

local shownQuestID

local function BlizzardQuestID()
	if shownQuestID ~= questMap.questieQuestID then
		return shownQuestID
	end
end

local providers = {}

local function AddProvider(mixin)
	if mixin then
		local provider = CreateFromMixins(mixin)
		canvas:AddDataProvider(provider)
		providers[#providers + 1] = provider
		return provider
	end
end

AddProvider(MapExplorationDataProviderMixin)
AddProvider(FogOfWarFrameMixin and FogOfWarDataProviderMixin)
local blobProvider = AddProvider(QuestBlobDataProviderMixin)
AddProvider(DungeonEntranceDataProviderMixin)
AddProvider(FlightPointDataProviderMixin)

if blobProvider and blobProvider.pin then
	function blobProvider.pin:Refresh()
		self:DrawNone()
		if not self.mapAllowsBlobs then
			return
		end
		local questID = BlizzardQuestID()
		if questID then
			self:TryDrawQuest(questID)
		end
	end
end

local heldProviders = {}
for _, provider in ipairs(providers) do
	local refresh = provider.RefreshAllData
	provider.RefreshAllData = function(self, ...)
		if InCombatLockdown() then
			heldProviders[self] = true
			return
		end
		return refresh(self, ...)
	end
end

function questMap:OnPlayerRegenEnabled()
	for provider in pairs(heldProviders) do
		heldProviders[provider] = nil
		provider:RefreshAllData()
	end
end

local MARKER_TEMPLATE = "WideQuestQuestMarkerPinTemplate"
local MARKER_TEXTURE = "Interface\\GossipFrame\\AvailableQuestIcon"
local MARKER_TEXTURE_COMPLETE = "Interface\\GossipFrame\\ActiveQuestIcon"
local GetNextWaypointForMap = C_QuestLog.GetNextWaypointForMap

local function MarkerPosition(questID, mapID)
	for _, info in ipairs(C_QuestLog.GetQuestsOnMap(mapID) or {}) do
		if info.questID == questID then
			return info.x, info.y
		end
	end
	if GetNextWaypointForMap then
		return GetNextWaypointForMap(questID, mapID)
	end
end

local markerProvider = CreateFromMixins(MapCanvasDataProviderMixin)

function markerProvider:RemoveAllData()
	self:GetMap():RemoveAllPinsByTemplate(MARKER_TEMPLATE)
end

function markerProvider:RefreshAllData()
	self:RemoveAllData()
	local map = self:GetMap()
	local mapID, questID = map:GetMapID(), BlizzardQuestID()
	local x, y
	if mapID and questID then
		x, y = MarkerPosition(questID, mapID)
	end
	if not (x and y) then
		return
	end
	local pin = map:AcquirePin(MARKER_TEMPLATE)
	pin.Texture:SetTexture(ns.IsQuestComplete(questID) and MARKER_TEXTURE_COMPLETE or MARKER_TEXTURE)
	pin:UseFrameLevelType("PIN_FRAME_LEVEL_QUEST_MARKER")
	pin:ApplyFrameLevel()

	pin:SetScalingLimits(1, 1.0, 1.2)
	pin:SetPosition(x, y)
	pin:ApplyCurrentScale()
end

canvas:AddDataProvider(markerProvider)

local levels = canvas:GetPinFrameLevelsManager()
levels:AddFrameLevel("PIN_FRAME_LEVEL_MAP_EXPLORATION")
levels:AddFrameLevel("PIN_FRAME_LEVEL_FOG_OF_WAR")
levels:AddFrameLevel("PIN_FRAME_LEVEL_QUEST_BLOB")
levels:AddFrameLevel("PIN_FRAME_LEVEL_DUNGEON_ENTRANCE")
levels:AddFrameLevel("PIN_FRAME_LEVEL_FLIGHT_POINT")
levels:AddFrameLevel("PIN_FRAME_LEVEL_ACTIVE_QUEST")
levels:AddFrameLevel("PIN_FRAME_LEVEL_QUEST_MARKER")
ns.AddPlayerPinLevel(canvas)

local function ShowQuest(questID)
	shownQuestID = questID
	local mapID = questID and GetQuestUiMapID(questID)
	if not mapID or mapID == 0 then
		mapID = questMap.QuestGiverMapID(questID) or MapUtil.GetDisplayableMapForPlayer()
	end

	if questMap.FollowQuestieQuest(questID, mapID) or not questID then
		canvas:TriggerEvent("ClearFocusedQuestID")
	else
		canvas:TriggerEvent("SetFocusedQuestID", questID)
	end
	if blobProvider and blobProvider.pin then
		blobProvider.pin:Refresh()
	end
	markerProvider:RefreshAllData()
end

function questMap.FollowQuest()
	ShowQuest(state.selectedQuestID)
end

hooksecurefunc(ns, "DisplayQuestDetails", function()
	if state.selectedQuestID ~= shownQuestID then
		ShowQuest(state.selectedQuestID)
	end
	questMap.RequestRefresh()
end)
