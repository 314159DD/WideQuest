local _, ns = ...

function ns.GetNumQuestLogEntries()
	return (C_QuestLog.GetNumQuestLogEntries())
end

local collapsedZones = {}

function ns.GetQuestLogEntry(index)
	local entry = C_QuestLog.GetInfo(index)
	if entry and entry.isHeader then
		entry.isCollapsed = collapsedZones[entry.title] and true or false
	end
	return entry
end

function ns.SetQuestZoneCollapsed(index, collapsed)
	local entry = C_QuestLog.GetInfo(index)
	if entry and entry.isHeader and entry.title then
		collapsedZones[entry.title] = collapsed or nil
	end
end

function ns.ShowEveryQuestLogEntry() end

function ns.GetLogIndexForQuestID(questID)
	return C_QuestLog.GetLogIndexForQuestID(questID)
end

function ns.GetHeaderIndexForQuest(questID)
	return C_QuestLog.GetHeaderIndexForQuest(questID)
end

ns.IsQuestComplete = C_QuestLog.IsComplete
ns.IsQuestFailed = C_QuestLog.IsFailed
ns.IsQuestDisabledForSession = C_QuestLog.IsQuestDisabledForSession

function ns.SelectQuest(questID)
	if C_QuestLog.GetSelectedQuest() ~= questID then
		C_QuestLog.SetSelectedQuest(questID)
	end
end

ns.IsPushableQuest = C_QuestLog.IsPushableQuest
ns.CanAbandonQuest = C_QuestLog.CanAbandonQuest

function ns.AskToAbandonQuest(questID)
	QuestMapQuestOptions_AbandonQuest(questID)
end

if C_QuestLog.GetQuestTagInfo then
	function ns.GetQuestTagByID(questID)
		local tagDetails = C_QuestLog.GetQuestTagInfo(questID)
		local isElite = (tagDetails and tagDetails.isElite) or C_QuestLog.IsEliteQuest(questID)
		return tagDetails and tagDetails.tagID, isElite and true or false, tagDetails and tagDetails.tagName
	end
else
	function ns.GetQuestTagByID(questID)
		if not GetQuestTagInfo then
			return nil, false
		end

		local tagID, tagName = GetQuestTagInfo(questID)
		return tagID, false, tagName
	end
end

if C_QuestLog.GetTitleForQuestID then
	function ns.GetQuestTitleByID(questID)
		return C_QuestLog.GetTitleForQuestID(questID)
	end
else
	function ns.GetQuestTitleByID(questID)
		return C_QuestLog.GetQuestInfo and C_QuestLog.GetQuestInfo(questID)
	end
end

if C_QuestLog.IsUnitOnQuest then
	function ns.IsUnitOnQuest(unit, questID)
		return C_QuestLog.IsUnitOnQuest(unit, questID)
	end
else
	function ns.IsUnitOnQuest(unit, questID, questLogIndex)
		local index = IsUnitOnQuest and (questLogIndex or ns.GetLogIndexForQuestID(questID))
		return index and IsUnitOnQuest(index, unit)
	end
end
