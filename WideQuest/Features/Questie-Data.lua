local _, ns = ...

local questie = {}
ns.questie = questie

local hereBeDragons
function questie.HereBeDragons()
	hereBeDragons = hereBeDragons or ns.QuestieHereBeDragons()
	return hereBeDragons
end

function questie.IsQuestieReady()
	return Questie and Questie.started and questie.HereBeDragons() and true or false
end

local function QueryQuest(QuestieDB, questID, field)
	local ok, value = pcall(QuestieDB.QueryQuestSingle, questID, field)
	return ok and value or nil
end

function questie.QuestLog()
	local log, acceptances = ns.QuestieLogEntries()
	if not acceptances then
		return log or {}
	end
	local quests = {}
	for questID, acceptance in pairs(log) do
		if type(acceptance) == "table" and type(acceptance.quest) == "table" then
			quests[questID] = acceptance.quest
		end
	end
	return quests
end

function questie.IsTakenOrDone(questID, log)
	if log[questID] then
		return true
	end
	local complete = Questie and Questie.db and Questie.db.char and Questie.db.char.complete
	if type(complete) == "table" and complete[questID] then
		return true
	end
	if C_QuestLog and type(C_QuestLog.IsOnQuest) == "function" then
		local ok, on = pcall(C_QuestLog.IsOnQuest, questID)
		if ok and on == true then
			return true
		end
	end
	return false
end

local function QuestLevel(QuestieDB, questID)
	local level = QueryQuest(QuestieDB, questID, "questLevel")
	if level == -1 or type(level) ~= "number" then
		return UnitLevel("player")
	end
	return level
end

function questie.IsTooLow(QuestieDB, questID, setting)
	if setting ~= "green" and setting ~= "yellow" then
		return false
	end
	local below = UnitLevel("player") - QuestLevel(QuestieDB, questID)
	if setting == "yellow" then
		return below > 2
	end
	local QuestieCompat = ns.ImportQuestieModule("QuestieCompat")
	local ok, range = false, nil
	if QuestieCompat and type(QuestieCompat.GetQuestGreenRange) == "function" then
		ok, range = pcall(QuestieCompat.GetQuestGreenRange)
	end
	return ok and type(range) == "number" and below > range or false
end

local INSTANCE_KINDS = { DUNGEON = true, RAID = true }
local instanceQuests = {}

local function QuestieTag(questID)
	local QuestieDB = ns.ImportQuestieModule("QuestieDB")
	if QuestieDB and type(QuestieDB.GetQuestTagInfo) == "function" then
		local ok, tagID = pcall(QuestieDB.GetQuestTagInfo, questID)
		return ok and tagID or nil
	end
end

function questie.IsInstanceQuest(questID)
	if instanceQuests[questID] ~= nil then
		return instanceQuests[questID]
	end
	local tagID = QuestieTag(questID) or ns.GetQuestTagByID(questID)
	if not tagID then
		return false
	end
	local kinds = ns.QUEST_TAG_SUFFIXES or {}
	local found = INSTANCE_KINDS[kinds[tagID]] == true
	instanceQuests[questID] = found
	return found
end

local QUEST_LOG_DELAY = 1
local questLogTimer
function questie:OnQuestLogUpdate()
	if questLogTimer then
		questLogTimer:Cancel()
	end
	questLogTimer = C_Timer.NewTimer(QUEST_LOG_DELAY, function()
		questLogTimer = nil
		wipe(instanceQuests)
	end)
end

function questie.PlayerPosition()
	local hereBeDragons = questie.HereBeDragons()
	if hereBeDragons then
		return hereBeDragons:GetPlayerWorldPosition()
	end
end

local function IsWithinByParents(mapID, zone)
	local current = mapID
	local info = current and C_Map.GetMapInfo(current)
	while info do
		if current == zone then
			return true
		end
		if info.mapType <= Enum.UIMapType.Continent or not (info.parentMapID and info.parentMapID > 0) then
			return false
		end
		current = info.parentMapID
		info = C_Map.GetMapInfo(current)
	end
	return false
end

local CITY_ZONES = {
	[1453] = 1429,
	[1454] = 1411,
	[1455] = 1426,
	[1456] = 1412,
	[1457] = 1438,
	[1458] = 1420,
	[1947] = 1943,
	[1954] = 1941,
	[1955] = 1952,
}

local inZone = {}
function questie.IsInZone(mapID, zone)
	local cache = inZone[zone]
	if not cache then
		cache = {}
		inZone[zone] = cache
	end
	local found = cache[mapID]
	if found == nil then
		found = IsWithinByParents(mapID, zone) or CITY_ZONES[mapID] == zone
		cache[mapID] = found
	end
	return found
end

local index = { position = 0 }
local PREREQUISITE_FIELDS = { "preQuestSingle", "preQuestGroup" }

function questie.FollowUpIndex(QuestieDB, yield)
	if index.done then
		return index.followUps
	end
	if not index.ids then
		local ids = {}
		if type(QuestieDB.QuestPointers) == "table" then
			for questID in pairs(QuestieDB.QuestPointers) do
				if type(questID) == "number" then
					ids[#ids + 1] = questID
				end
			end
		end
		table.sort(ids)
		index.ids, index.followUps = ids, {}
	end
	local ids, followUps = index.ids, index.followUps
	while index.position < #ids do
		index.position = index.position + 1
		local questID = ids[index.position]
		for _, field in ipairs(PREREQUISITE_FIELDS) do
			local before = QueryQuest(QuestieDB, questID, field)
			if type(before) == "table" then
				for _, raw in ipairs(before) do

					local first = type(raw) == "number" and math.abs(raw)
					if first then
						local list = followUps[first]
						if not list then
							list = {}
							followUps[first] = list
						end
						list[#list + 1] = questID
					end
				end
			end
		end
		yield()
	end
	index.done = true
	index.ids = nil
	return followUps
end

local function IsInParty()
	return IsInGroup() and not IsInRaid()
end

local function ShortName(name)
	return Ambiguate(name, "short")
end

local function UnitFullName(unit)
	local first, second = UnitName(unit)
	if not (ns.IsReadable(first) and type(first) == "string") then
		return nil
	end
	if ns.IsReadable(second) and type(second) == "string" and second ~= "" then
		return first .. " " .. second
	end
	return first
end

function questie.HasUnitOnQuest(unit, questID)
	local QuestieComms = ns.ImportQuestieModule("QuestieComms")
	local logs = QuestieComms and QuestieComms.remoteQuestLogs
	local members = type(logs) == "table" and logs[questID]
	local full = type(members) == "table" and UnitFullName(unit)
	if not full then
		return false
	end
	local short = ShortName(full)
	for name in pairs(members) do
		if type(name) == "string" and (name == full or ShortName(name) == short) then
			return true
		end
	end
	return false
end

function questie.PartyCountOnQuest(questID)
	local QuestieComms = ns.ImportQuestieModule("QuestieComms")
	local logs = QuestieComms and QuestieComms.remoteQuestLogs
	local members = IsInParty() and type(logs) == "table" and logs[questID]
	local count = 0
	if type(members) == "table" then
		for _ in pairs(members) do
			count = count + 1
		end
	end
	return count
end
