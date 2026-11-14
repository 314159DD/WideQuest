local _, ns = ...

local function GroupUnits()
	local units = {}
	if IsInRaid() then
		for index = 1, GetNumGroupMembers() do
			local unit = "raid" .. index
			if not UnitIsUnit(unit, "player") then
				units[#units + 1] = unit
			end
		end
	else
		for index = 1, GetNumSubgroupMembers() do
			units[#units + 1] = "party" .. index
		end
	end
	return units
end

local function IsKnownOnQuest(unit, questID, questLogIndex)
	local onQuest = ns.IsUnitOnQuest(unit, questID, questLogIndex)
	if ns.IsReadable(onQuest) and onQuest then
		return true
	end
	return ns.questie.HasUnitOnQuest(unit, questID)
end

function ns.PartyNeedsQuest(questID, questLogIndex, units)
	for _, unit in ipairs(units or GroupUnits()) do
		local connected = UnitExists(unit) and UnitIsConnected(unit)
		local offline = ns.IsReadable(connected) and not connected
		if not offline and not IsKnownOnQuest(unit, questID, questLogIndex) then
			return true
		end
	end
	return false
end

local pendingShare
ns.shareNeeds = {}

function ns.shareNeeds:OnPlayerRegenEnabled()
	local questID = pendingShare
	pendingShare = nil
	if
		questID
		and C_QuestLog.GetLogIndexForQuestID(questID)
		and C_QuestLog.IsPushableQuest(questID)
		and IsInGroup()
	then
		QuestMapQuestOptions_ShareQuest(questID)
	end
end

function ns.ShareQuest(questID)
	if InCombatLockdown() then
		pendingShare = questID
		ns:PrintMessage(ns.L["CHAT_SHARING_AFTER_COMBAT"]:format(C_QuestLog.GetTitleForQuestID(questID) or questID))
		return
	end
	QuestMapQuestOptions_ShareQuest(questID)
end
