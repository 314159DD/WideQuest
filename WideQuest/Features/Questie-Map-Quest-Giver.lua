local _, ns = ...

ns.AddWideQuestLogPart(function()
	local questMap = ns.questMap

	local function AreaMapID(ZoneDB, areaID)
		local parentID = areaID and ZoneDB.GetParentZoneId and ZoneDB:GetParentZoneId(areaID)
		local mapID = areaID and ZoneDB:GetUiMapIdByAreaId(parentID or areaID)
		return questMap.CanShowMap(mapID) and mapID or nil
	end

	local function BusiestArea(spawns)
		local bestAreaID, bestCount
		for areaID, list in pairs(type(spawns) == "table" and spawns or {}) do
			local count = type(list) == "table" and #list or 0
			if count > 0 and (not bestCount or count > bestCount or (count == bestCount and areaID < bestAreaID)) then
				bestAreaID, bestCount = areaID, count
			end
		end
		return bestAreaID
	end

	function questMap.QuestGiverMapID(questID)
		local QuestieDB = ns.ImportQuestieModule("QuestieDB")
		local ZoneDB = ns.ImportQuestieModule("ZoneDB")
		if not (questID and QuestieDB and QuestieDB.QueryQuestSingle and ZoneDB and ZoneDB.GetUiMapIdByAreaId) then
			return nil
		end

		local startedBy = QuestieDB.QueryQuestSingle(questID, "startedBy")
		if type(startedBy) == "table" then
			for kind, query in ipairs({ QuestieDB.QueryNPCSingle, QuestieDB.QueryObjectSingle }) do
				for _, id in ipairs(type(startedBy[kind]) == "table" and startedBy[kind] or {}) do
					local mapID = AreaMapID(ZoneDB, BusiestArea(query(id, "spawns")))
					if mapID then
						return mapID
					end
				end
			end
		end

		local zoneOrSort = QuestieDB.QueryQuestSingle(questID, "zoneOrSort")
		return type(zoneOrSort) == "number" and zoneOrSort > 0 and AreaMapID(ZoneDB, zoneOrSort) or nil
	end
end)
