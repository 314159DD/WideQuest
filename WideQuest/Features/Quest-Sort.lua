local _, ns = ...

function ns.NameSortKey(title)
	return strlower(title or "")
end

function ns.AverageLevel(quests)
	if #quests == 0 then
		return nil
	end
	local total = 0
	for _, quest in ipairs(quests) do
		total = total + quest.sortLevel
	end
	return total / #quests
end

function ns.SortQuests(quests, questSort, completedFirst)
	table.sort(quests, function(a, b)
		if completedFirst and a.isComplete ~= b.isComplete then
			return a.isComplete == true
		end
		if questSort == "ALPHABETICAL" then
			if a.sortKey ~= b.sortKey then
				return a.sortKey < b.sortKey
			end
		elseif a.sortLevel ~= b.sortLevel then
			if questSort == "LEVEL_HIGHEST_FIRST" then
				return a.sortLevel > b.sortLevel
			end
			return a.sortLevel < b.sortLevel
		end
		return a.sortIndex < b.sortIndex
	end)
end

function ns.IsCurrentZone(title)
	if title == nil then
		return false
	end
	return title == GetRealZoneText()
end

function ns.ZoneHeaderText(title)
	if ns.IsCurrentZone(title) then
		return title .. " " .. ns.CURRENT_ZONE_MARK
	end
	return title
end

local function CompareZones(a, b, zoneSort, currentZoneFirst)
	if currentZoneFirst and a.isCurrent ~= b.isCurrent then
		return a.isCurrent
	end
	if zoneSort ~= "ALPHABETICAL" and a.averageLevel ~= b.averageLevel then

		if not (a.averageLevel and b.averageLevel) then
			return a.averageLevel ~= nil
		end
		if zoneSort == "LEVEL_LOWEST_FIRST" then
			return a.averageLevel < b.averageLevel
		end
		return a.averageLevel > b.averageLevel
	end
	if a.sortKey ~= b.sortKey then
		return a.sortKey < b.sortKey
	end
	return a.sortIndex < b.sortIndex
end

function ns.SortZones(zones, zoneSort, currentZoneFirst, frozen)
	for _, zone in ipairs(zones) do
		zone.isCurrent = ns.IsCurrentZone(zone.title)
	end
	table.sort(zones, function(a, b)
		local rankA, rankB = frozen and frozen[a.title or ""], frozen and frozen[b.title or ""]
		if rankA and rankB then
			return rankA < rankB
		elseif rankA or rankB then
			return rankA ~= nil
		end
		return CompareZones(a, b, zoneSort, currentZoneFirst)
	end)
	if not frozen then
		frozen = {}
		for rank, zone in ipairs(zones) do
			frozen[zone.title or ""] = rank
		end
	end
	return frozen
end
