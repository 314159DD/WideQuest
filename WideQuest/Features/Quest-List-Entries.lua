local _, ns = ...

local zoneOrder

local function EntryIsComplete(entry)
	if entry.isComplete ~= nil then
		return entry.isComplete
	end
	return ns.IsQuestComplete(entry.questID)
end

local function EntryIsFailed(entry)
	if entry.isFailed ~= nil then
		return entry.isFailed
	end
	return ns.IsQuestFailed(entry.questID)
end

function ns.BuildQuestListEntries()
	local entries, zones = {}, {}
	local header

	ns.ShowEveryQuestLogEntry()
	for index = 1, ns.GetNumQuestLogEntries() do
		local entry = ns.GetQuestLogEntry(index)
		if entry and entry.isHeader then
			header = entry
			header.quests = {}
			header.sortKey = ns.NameSortKey(header.title)
			header.sortIndex = header.questLogIndex
			zones[#zones + 1] = header
		elseif entry and not entry.isHidden and not entry.isTask and (not entry.isBounty or EntryIsComplete(entry)) then
			entry.sortLevel = entry.difficultyLevel or entry.level or 0
			entry.sortIndex = entry.questLogIndex
			entry.sortKey = ns.NameSortKey(entry.title)
			entry.isComplete = EntryIsComplete(entry)
			entry.isFailed = EntryIsFailed(entry)
			entry.zone = header and header.title
			if header then
				header.quests[#header.quests + 1] = entry
			else
				entries[#entries + 1] = entry
			end
		end
	end

	local questSort, completedFirst = ns.db.profile.questSort, ns.db.profile.completedFirst
	ns.SortQuests(entries, questSort, completedFirst)
	for _, zone in ipairs(zones) do
		zone.averageLevel = ns.AverageLevel(zone.quests)
		ns.SortQuests(zone.quests, questSort, completedFirst)
	end
	zoneOrder = ns.SortZones(zones, ns.db.profile.zoneSort, ns.db.profile.currentZoneFirst, zoneOrder)

	local quests = {}
	for _, quest in ipairs(entries) do
		quests[#quests + 1] = quest
	end
	local anyHeader, anyExpanded = false, false
	for _, zone in ipairs(zones) do
		for _, quest in ipairs(zone.quests) do
			quests[#quests + 1] = quest
		end
		if #zone.quests > 0 then
			if #entries > 0 and ns.db.profile.zoneGap then
				entries[#entries + 1] = { isSpacer = true }
			end
			entries[#entries + 1] = zone
			anyHeader = true
			if not zone.isCollapsed then
				anyExpanded = true
				for _, quest in ipairs(zone.quests) do
					entries[#entries + 1] = quest
				end
			end
		end
	end

	return entries, quests, anyHeader and not anyExpanded
end

function ns.ResetZoneOrder()
	zoneOrder = nil
end
