local ADDON_NAME, ns = ...

local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")

local EVENTS = {
	{ "ADDON_LOADED", "OnAddonLoaded" },
	{ "QUEST_LOG_UPDATE", "OnQuestLogUpdate" },
	{ "QUEST_WATCH_LIST_CHANGED", "OnQuestWatchListChanged" },
	{ "QUEST_ACCEPTED", "OnQuestAccepted" },
	{ "QUEST_REMOVED", "OnQuestRemoved" },
	{ "QUEST_TURNED_IN", "OnQuestTurnedIn" },
	{ "UNIT_QUEST_LOG_CHANGED", "OnUnitQuestLogChanged" },
	{ "GROUP_ROSTER_UPDATE", "OnGroupRosterUpdate" },
	{ "PLAYER_LEVEL_UP", "OnPlayerLevelUp" },
	{ "ZONE_CHANGED_NEW_AREA", "OnZoneChangedNewArea" },
	{ "PLAYER_REGEN_DISABLED", "OnPlayerRegenDisabled" },
	{ "PLAYER_REGEN_ENABLED", "OnPlayerRegenEnabled" },
	{ "UPDATE_BINDINGS", "OnUpdateBindings" },
	{ "QUEST_LOG_UPDATE", "OnQuestLogUpdate", "questie" },
	{ "PLAYER_REGEN_ENABLED", "OnPlayerRegenEnabled", "questMap" },
	{ "PLAYER_REGEN_ENABLED", "OnPlayerRegenEnabled", "shareNeeds" },
	{ "PLAYER_REGEN_ENABLED", "OnPlayerRegenEnabled", "questLogWindow" },
	{ "BAG_UPDATE_DELAYED", "OnBagUpdateDelayed", "zoneInfo" },
	{ "QUEST_ACCEPTED", "OnQuestAccepted", "zoneInfo" },
	{ "QUEST_REMOVED", "OnQuestRemoved", "zoneInfo" },
	{ "QUEST_TURNED_IN", "OnQuestTurnedIn", "zoneInfo" },
	{ "PLAYER_LEVEL_UP", "OnPlayerLevelUp", "zoneInfo" },
	{ "SKILL_LINES_CHANGED", "OnSkillLinesChanged", "zoneInfo" },
	{ "GET_ITEM_INFO_RECEIVED", "OnGetItemInfoReceived", "zoneInfo" },
	{ "GROUP_ROSTER_UPDATE", "OnGroupRosterUpdate", "zoneInfo" },
	{ "UNIT_QUEST_LOG_CHANGED", "OnUnitQuestLogChanged", "zoneInfo" },
}

local EVENT_HANDLERS = {}
for _, event in ipairs(EVENTS) do
	EVENT_HANDLERS[event[1]] = EVENT_HANDLERS[event[1]] or {}
	table.insert(EVENT_HANDLERS[event[1]], event)
end

local function FindHandler(event)
	local owner = ns
	if event[3] then
		owner = ns[event[3]]
	end
	local handler = owner and owner[event[2]]
	if handler then
		return owner, handler
	end
end

local eventFrame = CreateFrame("Frame")

eventFrame:SetScript("OnEvent", function(_, event, ...)

	for _, row in ipairs(EVENT_HANDLERS[event]) do
		local owner, handler = FindHandler(row)
		if handler then
			securecall(handler, owner, ...)
		end
	end
end)

local function RegisterEvent(event)
	if eventFrame:IsEventRegistered(event) then
		return
	end
	eventFrame:RegisterEvent(event)
end

RegisterEvent("ADDON_LOADED")

local function RegisterLoadedEvents()
	for _, event in ipairs(EVENTS) do
		if event[1] ~= "ADDON_LOADED" and FindHandler(event) then
			RegisterEvent(event[1])
		end
	end
end

function ns.AddWideQuestLogPart(build)
	ns.hasWideQuestLog = true
	build()
end

local function StartWideQuestLog()
	ns.wideQuestLogActive = (ns.hasWideQuestLog and ns.db.profile.enableWideQuestLog) and true or false
end

function ns:ApplyProfile()
	ns.SyncFonts()
	if ns.wideQuestLogActive then
		ns.RefreshQuestLog()
		if ns.hasQuestMap then
			ns.questMap.RequestRefresh()
		end
		if ns.zoneInfo and ns.zoneInfo.Apply then
			ns.zoneInfo.Apply()
		end
	end
	for _, registryName in pairs(ns.OPTIONS_REGISTRY) do
		AceConfigRegistry:NotifyChange(registryName)
	end
end

function ns:OnAddonLoaded(name)
	if name ~= ADDON_NAME then
		return
	end

	ns.db = LibStub("AceDB-3.0"):New(ns.SAVED_VARIABLES_NAME, ns.DATABASE_DEFAULTS, true)

	ns.SyncFonts()
	for _, message in ipairs({ "OnProfileChanged", "OnProfileReset", "OnProfileCopied" }) do
		ns.db.RegisterCallback(ns, message, "ApplyProfile")
	end

	ns.RegisterOptionsPanels()
	RegisterLoadedEvents()

	StartWideQuestLog()
	RegisterLoadedEvents()

	if ns.zoneInfo and ns.zoneInfo.Apply then
		securecall(ns.zoneInfo.Apply)
	end
	if ns.OnDatabaseReady then
		securecall(ns.OnDatabaseReady, ns)
	end
end
