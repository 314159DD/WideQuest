local _, ns = ...

local questieModules = {}
local function QuestieModule(name)
	questieModules[name] = questieModules[name] or ns.ImportQuestieModule(name)
	return questieModules[name]
end

local function Query(questID, field)
	local questieDB = QuestieModule("QuestieDB")
	if not (questieDB and type(questieDB.QueryQuestSingle) == "function") then
		return nil
	end
	local found, value = pcall(questieDB.QueryQuestSingle, questID, field)
	return found and value or nil
end

local function QuestTag(questID)
	local clientTagID, isElite = ns.GetQuestTagByID(questID)
	local questieDB = QuestieModule("QuestieDB")
	if questieDB and type(questieDB.GetQuestTagInfo) == "function" then
		local found, tagID = pcall(questieDB.GetQuestTagInfo, questID)
		if found and tagID then
			return tagID, isElite
		end
	end
	return clientTagID, isElite
end

local MAX_PARTS = 25

local function PreviousPart(questID)
	local group = Query(questID, "preQuestGroup")
	if type(group) == "table" and next(group) then
		return nil
	end
	local single = Query(questID, "preQuestSingle")
	if type(single) ~= "table" or #single ~= 1 then
		return nil
	end
	if Query(single[1], "nextQuestInChain") == questID then
		return single[1]
	end
end

local function NextPart(questID)
	local nextID = Query(questID, "nextQuestInChain")
	if type(nextID) == "number" and nextID ~= 0 then
		return nextID
	end
end

local lastChain = {}

function ns.GetQuestChain(questID)
	if lastChain.questID == questID then
		return lastChain.parts, lastChain.position
	end
	local parts, seen = { questID }, { [questID] = true }
	local previous = PreviousPart(questID)
	while previous and not seen[previous] and #parts < MAX_PARTS do
		table.insert(parts, 1, previous)
		seen[previous] = true
		previous = PreviousPart(previous)
	end
	local position = #parts
	local nextID = NextPart(questID)
	while nextID and not seen[nextID] and #parts < MAX_PARTS do
		parts[#parts + 1] = nextID
		seen[nextID] = true
		nextID = NextPart(nextID)
	end
	if #parts < 2 then
		return nil
	end
	lastChain.questID, lastChain.parts, lastChain.position = questID, parts, position
	return parts, position
end

local function PartLabel(questID)
	local title = ns.GetQuestTitleByID(questID) or Query(questID, "name") or tostring(questID)
	local level = Query(questID, "questLevel")
	if type(level) ~= "number" or level <= 0 then
		return nil, title
	end
	return format("%d%s", level, ns.QuestSuffix(QuestTag(questID))), title, level
end

local function PartColor(questID, level)
	local difficulty = C_PlayerInfo
		and C_PlayerInfo.GetContentDifficultyQuestForPlayer
		and C_QuestLog.GetLogIndexForQuestID
		and C_QuestLog.GetLogIndexForQuestID(questID)
		and C_PlayerInfo.GetContentDifficultyQuestForPlayer(questID)
	if difficulty and GetDifficultyColor then
		return GetDifficultyColor(difficulty)
	end
	if level then
		return GetQuestDifficultyColor(level)
	end
end

ns.QuestChainPartLabel = PartLabel
ns.QuestChainPartColor = PartColor
