local _, ns = ...

ns.AddWideQuestLogPart(function()
	local questMap = ns.questMap
	local canvas = questMap.canvas

	local hereBeDragons = ns.QuestieHereBeDragons()
	local hereBeDragonsPins = ns.QuestieHereBeDragonsPins()

	local PIN_TEMPLATE = "WideQuestQuestiePinTemplate"
	questMap.QUESTIE_PIN_TEMPLATE = PIN_TEMPLATE
	local ICON_SIZE = 16
	local REFRESH_DELAY = 0.2
	local ZONE_DROPDOWN_WIDTH = 180

	local shownQuestID

	local function IsShownIcon(icon)
		if icon.isManualIcon or icon.type == "line" or not (icon.data and icon.texture) then
			return false
		end
		local _, _, _, alpha = icon.texture:GetVertexColor()
		return alpha > 0
	end

	local function ForEachIcon(mapID, questID, callback)
		if not (hereBeDragons and hereBeDragonsPins and mapID and questID) then
			return
		end
		for icon, placement in pairs(hereBeDragonsPins.worldmapPins) do
			if placement.uiMapID == mapID and icon.data and icon.data.Id == questID and IsShownIcon(icon) then
				local x, y = hereBeDragons:GetZoneCoordinatesFromWorldInstance(
					placement.x,
					placement.y,
					placement.instanceID,
					mapID
				)
				if x and y then
					callback(icon, x, y)
				end
			end
		end
	end

	local function QuestZones(questID)
		local counts = {}
		if hereBeDragonsPins and questID then
			for icon, placement in pairs(hereBeDragonsPins.worldmapPins) do
				if placement.uiMapID and icon.data and icon.data.Id == questID and IsShownIcon(icon) then
					counts[placement.uiMapID] = (counts[placement.uiMapID] or 0) + 1
				end
			end
		end
		local zones = {}
		for mapID in pairs(counts) do
			if questMap.CanShowMap(mapID) then
				zones[#zones + 1] = mapID
			end
		end
		table.sort(zones, function(a, b)
			if counts[a] ~= counts[b] then
				return counts[a] > counts[b]
			end
			return a < b
		end)
		return zones
	end

	local GLOW_SCALE = 1.13

	local function SetGlow(pin, icon, size)
		local data = icon.data
		local color = data.ObjectiveData and data.ObjectiveData.Color
		local profile = Questie and Questie.db and Questie.db.profile
		local glowTexture = icon.glowTexture
		if
			not (color and glowTexture and profile and profile.alwaysGlowMap)
			or data.Type == "available"
			or data.Type == "complete"
		then
			pin.Glow:Hide()
			return
		end
		local _, _, _, alpha = icon.texture:GetVertexColor()
		pin.Glow:SetTexture(glowTexture:GetTexture())
		pin.Glow:SetVertexColor(color[1], color[2], color[3], alpha or 1)
		pin.Glow:SetSize(size * GLOW_SCALE, size * GLOW_SCALE)
		pin.Glow:Show()
	end

	local function IconSize(icon)
		local data = icon.data
		return ICON_SIZE * (data.GetIconScale and data:GetIconScale() or 1)
	end

	local function AddPin(map, icon, x, y, area)
		local pin = map:AcquirePin(PIN_TEMPLATE)
		pin.data = icon.data
		pin.area = area
		local size = IconSize(icon)
		pin:SetSize(size, size)
		pin.Texture:SetTexture(icon.texture:GetTexture())
		pin.Texture:SetTexCoord(icon.texture:GetTexCoord())
		pin.Texture:SetVertexColor(icon.texture:GetVertexColor())
		SetGlow(pin, icon, size)
		pin:SetScript("OnEnter", questMap.ShowPinTooltip)
		pin:SetScript("OnLeave", GameTooltip_Hide)
		pin:UseFrameLevelType("PIN_FRAME_LEVEL_ACTIVE_QUEST")
		pin:ApplyFrameLevel()

		pin:SetScalingLimits(1, 1.0, 1.2)
		pin:SetPosition(x, y)
		pin:ApplyCurrentScale()
	end

	local function SpawnObjective(data)
		local objective = data.ObjectiveData
		if data.Type ~= "available" and data.Type ~= "complete" and objective and objective.spawnList then
			return objective
		end
	end

	local TURN_IN_COLOR = { ns.GetColorRGB("TITLE") }

	local questieProvider = CreateFromMixins(MapCanvasDataProviderMixin)

	function questieProvider:RemoveAllData()
		local map = self:GetMap()
		map:RemoveAllPinsByTemplate(PIN_TEMPLATE)
		questMap.RemoveObjectiveAreas(map)
		questMap.areaCount = 0
	end

	function questieProvider:RefreshAllData()
		self:RemoveAllData()
		local map = self:GetMap()
		local mapID = map:GetMapID()
		local showAreas = ns.db.profile.showObjectiveAreas

		local icons, objectives, objectiveIcons = {}, {}, {}
		ForEachIcon(mapID, shownQuestID, function(icon, x, y)
			icons[#icons + 1] = { icon = icon, x = x, y = y }
			local objective = showAreas and SpawnObjective(icon.data)
			if objective then
				if not objectiveIcons[objective] then
					objectiveIcons[objective] = {}
					objectives[#objectives + 1] = objective
				end
				table.insert(objectiveIcons[objective], icon)
			end
		end)

		local areasByObjective, shapes = {}, {}
		for _, objective in ipairs(objectives) do
			local objectiveIconList = objectiveIcons[objective]
			local areas = questMap.ObjectiveAreas(objective, map, IconSize(objectiveIconList[1]))
			if #areas > 0 then
				areasByObjective[objective] = areas
				for _, area in ipairs(areas) do
					local look = objectiveIconList[1]
					for _, icon in ipairs(objectiveIconList) do
						if icon.data.Icon == area.icon then
							look = icon
							break
						end
					end
					AddPin(map, look, area.x, area.y, area)
					shapes[#shapes + 1] = { color = objective.Color, x = area.x, y = area.y, outline = area.outline }
				end
			end
		end

		for _, entry in ipairs(icons) do
			local data = entry.icon.data
			local objective = SpawnObjective(data)
			if not (objective and areasByObjective[objective]) then
				AddPin(map, entry.icon, entry.x, entry.y)
				local outline = showAreas and questMap.SpotOutline(map, entry.x, entry.y, IconSize(entry.icon))
				if outline then
					local color = data.Type == "complete" and TURN_IN_COLOR
						or (data.ObjectiveData and data.ObjectiveData.Color)
					shapes[#shapes + 1] = { color = color, x = entry.x, y = entry.y, outline = outline }
				end
			end
		end

		questMap.DrawObjectiveAreas(map, shapes)
		questMap.areaCount = #shapes
	end

	canvas:AddDataProvider(questieProvider)

	local zones, shownMapID, chosenMapID = {}, nil, nil

	local zoneChanged

	local zoneDropdown = CreateFrame("DropdownButton", nil, questMap.holder, "WowStyle2DropdownTemplate")
	zoneDropdown:SetPoint("TOPLEFT", canvas, "TOPLEFT", ns.LAYOUT.SPACE.NEAR, -ns.LAYOUT.SPACE.NEAR)
	zoneDropdown:SetWidth(ZONE_DROPDOWN_WIDTH)
	zoneDropdown:SetFrameLevel(canvas:GetFrameLevel() + 10)
	zoneDropdown:Hide()
	questMap.zoneDropdown = zoneDropdown

	local function ZoneName(mapID)
		local mapInfo = C_Map.GetMapInfo(mapID)
		return mapInfo and mapInfo.name or tostring(mapID)
	end

	local function ShowZone(mapID)
		mapID = questMap.browseMapID or mapID
		shownMapID = mapID
		if questMap.ShowMap(mapID) then
			zoneChanged = true
		end
		if zoneDropdown.OverrideText and mapID then
			zoneDropdown:OverrideText(ZoneName(mapID))
		end
		if questMap.onZoneShown then
			questMap.onZoneShown(mapID)
		end
	end

	function questMap.ShownZone()
		return shownMapID
	end

	function questMap.PickQuestZone(mapID)
		if not tContains(zones, mapID) then
			return false
		end
		if questMap.browseMapID and questMap.EndBrowse then
			questMap.EndBrowse()
		end
		chosenMapID = mapID
		ShowZone(mapID)
		return true
	end

	zoneDropdown:SetupMenu(function(_, rootDescription)
		local zoneInfo = questMap.zoneInfoShown and questMap.AddZoneInfoMenu
		if zoneInfo and questMap.browseMapID then
			rootDescription:CreateButton(ns.L["ZONE_INFO_BACK"], function()
				questMap.EndBrowse()
				questMap.FollowQuest()
			end)
			rootDescription:CreateDivider()
		end
		if zoneInfo and #zones > 0 then
			rootDescription:CreateTitle(ns.L["ZONE_INFO_MENU_QUEST"])
		end
		for _, mapID in ipairs(zones) do
			rootDescription:CreateRadio(ZoneName(mapID), function(data)
				return data == shownMapID and not questMap.browseMapID
			end, questMap.PickQuestZone, mapID)
		end
		if zoneInfo then
			questMap.AddZoneInfoMenu(rootDescription)
		end
	end)

	local menuStale = false
	local function FreshenMenu()
		if menuStale then
			menuStale = false
			zoneDropdown:GenerateMenu()
		end
	end
	if type(zoneDropdown.OpenMenu) == "function" then
		local OpenMenu = zoneDropdown.OpenMenu
		zoneDropdown.OpenMenu = function(self, ...)
			FreshenMenu()
			return OpenMenu(self, ...)
		end
	end
	local OnMouseDown = zoneDropdown:GetScript("OnMouseDown")
	if OnMouseDown then
		zoneDropdown:SetScript("OnMouseDown", function(self, ...)
			FreshenMenu()
			return OnMouseDown(self, ...)
		end)
	end
	local canWait = type(zoneDropdown.OpenMenu) == "function" and type(zoneDropdown.IsMenuOpen) == "function"

	local function UpdateZoneDropdown()
		local wasShown = zoneDropdown:IsShown()
		zoneDropdown:SetShown(#zones > 1 or questMap.zoneInfoShown or false)
		menuStale = true
		if not canWait or zoneDropdown:IsMenuOpen() or (zoneDropdown:IsShown() and not wasShown) then
			FreshenMenu()
		end
	end
	hooksecurefunc(questMap, "SetZoneInfoShown", UpdateZoneDropdown)

	function questMap.FollowQuestieQuest(questID, fallbackMapID)
		if questID ~= shownQuestID then
			chosenMapID = nil

			if questMap.browseMapID and shownQuestID ~= nil and questMap.EndBrowse then
				questMap.EndBrowse()
			end
		end
		shownQuestID = questID
		zones = QuestZones(questID)

		local playerMapID = MapUtil.GetDisplayableMapForPlayer()
		local mapID = zones[1]
		if not mapID then
			mapID = type(fallbackMapID) == "function" and fallbackMapID() or fallbackMapID
		end
		if chosenMapID and tContains(zones, chosenMapID) then
			mapID = chosenMapID
		elseif tContains(zones, playerMapID) then
			mapID = playerMapID
		end
		ShowZone(mapID)
		UpdateZoneDropdown()

		local hasIcons = #zones > 0
		questMap.questieQuestID = hasIcons and questID or nil
		return hasIcons
	end

	local refreshPending
	function questMap.RequestRefresh()
		if refreshPending or not canvas:IsVisible() then
			return
		end
		refreshPending = true
		C_Timer.After(REFRESH_DELAY, function()
			refreshPending = nil
			if canvas:IsVisible() then
				zoneChanged = false
				questMap.FollowQuest()
				if not zoneChanged then
					questieProvider:RefreshAllData()
				end
			end
		end)
	end

	canvas.ScrollContainer:HookScript("OnSizeChanged", questMap.RequestRefresh)

	if hereBeDragonsPins then
		for _, name in ipairs({
			"AddWorldMapIconMap",
			"AddWorldMapIconWorld",
			"RemoveWorldMapIcon",
			"RemoveAllWorldMapIcons",
		}) do
			if hereBeDragonsPins[name] then
				hooksecurefunc(hereBeDragonsPins, name, questMap.RequestRefresh)
			end
		end
	end
end)
