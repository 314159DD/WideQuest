local ADDON_NAME, ns = ...

local zoneInfo = {}
ns.zoneInfo = zoneInfo

ns.AddWideQuestLogPart(function()
	local L = ns.L
	local LAYOUT = ns.LAYOUT
	local SPACE = LAYOUT.SPACE
	local questMap = ns.questMap
	local holder = questMap.holder
	local data = ns.zoneInfoData

	local ROW_HEIGHT = LAYOUT.QUEST_ROW_HEIGHT
	local TITLE_HEIGHT = LAYOUT.HEADER_ROW_HEIGHT
	local ICON_SIZE = 16

	local MARGIN = SPACE.GROUP
	local QUEST_SHARE = 2 / 3
	local ITEM_EXTRA = SPACE.GROUP
	local LEFT_IN = MARGIN - LAYOUT.CHECK_X
	local RIGHT_IN = MARGIN - LAYOUT.ROW_PADDING
	local TOP_IN = MARGIN - SPACE.LINE
	local MENU_SCROLL_HEIGHT = 512
	local AVAILABLE_ZONES_LISTED = 8
	local REFRESH_DELAY = 1
	local AVAILABLE_DELAY = 3
	local STARTING_DELAY = 2
	local LFG_CHANNEL = 4

	local ROW_HIGHLIGHT = "Interface\\QuestFrame\\UI-QuestLogTitleHighlight"
	local PLUS_TEXTURE = "Interface\\Buttons\\UI-PlusButton-Up"
	local MINUS_TEXTURE = "Interface\\Buttons\\UI-MinusButton-Up"
	local PARTY_TEXTURE = "Interface\\AddOns\\" .. ADDON_NAME .. "\\Includes\\Images\\Party-On-Quest"
	local SOLID_TEXTURE = "Interface\\Buttons\\WHITE8X8"

	local current = { mapID = nil, result = nil }
	local collapsed = {}

	local box = CreateFrame("Frame", nil, holder, "BackdropTemplate")
	local backdrop = CopyTable(holder.backdropInfo)
	backdrop.bgFile = SOLID_TEXTURE
	box:SetBackdrop(backdrop)
	box:SetBackdropColor(0, 0, 0, 1)
	box:EnableMouse(true)
	box:SetPoint("TOPLEFT", holder, "BOTTOMLEFT")
	box:SetPoint("TOPRIGHT", holder, "BOTTOMRIGHT")
	box:Hide()
	local inset = backdrop.insets.left

	local function FitHeight()
		box:SetHeight(math.max(1, questMap.SharedHeight() - holder:GetHeight()))
	end
	holder:HookScript("OnSizeChanged", FitHeight)

	local content = CreateFrame("Frame", nil, box)
	content:SetPoint("TOPLEFT", inset, -inset)
	content:SetPoint("BOTTOMRIGHT", -inset, inset)

	local divider = content:CreateTexture(nil, "ARTWORK")
	divider:SetColorTexture(ns.GetColorRGB("SEPARATOR"))
	divider:SetAlpha(0.25)
	divider:SetWidth(1)

	local function PlaceDivider(width)
		local x = math.floor(width * QUEST_SHARE + 0.5) - ITEM_EXTRA
		divider:ClearAllPoints()
		divider:SetPoint("TOP", content, "TOPLEFT", x, -TOP_IN)
		divider:SetPoint("BOTTOM", content, "BOTTOMLEFT", x, MARGIN)
	end
	PlaceDivider(content:GetWidth())
	content:SetScript("OnSizeChanged", function(_, width)
		PlaceDivider(width)
	end)

	local function Column(side)
		local column = CreateFrame("Frame", nil, content)
		column:SetPoint("TOP", 0, -TOP_IN)
		column:SetPoint("BOTTOM", 0, MARGIN)
		if side == "LEFT" then
			column:SetPoint("LEFT", LEFT_IN, 0)
			column:SetPoint("RIGHT", divider, "LEFT", -RIGHT_IN, 0)
		else
			column:SetPoint("LEFT", divider, "RIGHT", LEFT_IN, 0)
			column:SetPoint("RIGHT", -RIGHT_IN, 0)
		end

		column.title = column:CreateFontString(nil, "OVERLAY")
		column.title:SetFontObject(ns.AreaFont("list", "GameFontNormal"))
		column.title:SetPoint("TOPLEFT", LAYOUT.CHECK_X, 0)
		column.title:SetPoint("RIGHT", -LAYOUT.ROW_PADDING, 0)
		column.title:SetHeight(TITLE_HEIGHT)
		column.title:SetJustifyH("LEFT")
		column.title:SetWordWrap(false)

		local scroll = CreateFrame("ScrollFrame", nil, column)
		scroll:SetPoint("TOPLEFT", 0, -(TITLE_HEIGHT + SPACE.NEAR))
		scroll:SetPoint("BOTTOMRIGHT")

		local bar = CreateFrame("EventFrame", nil, column, "MinimalScrollBar")
		bar:SetPoint("TOP", scroll, "TOPRIGHT", RIGHT_IN / 2, 0)
		bar:SetPoint("BOTTOM", scroll, "BOTTOMRIGHT", RIGHT_IN / 2, 0)
		if bar.SetHideIfUnscrollable then
			bar:SetHideIfUnscrollable(true)
		end
		ScrollUtil.InitScrollFrameWithScrollBar(scroll, bar)

		local child = CreateFrame("Frame", nil, scroll)
		child:SetSize(1, 1)
		scroll:SetScrollChild(child)
		scroll:HookScript("OnSizeChanged", function(self, width)
			child:SetWidth(width)
		end)
		column.scroll, column.child, column.rows = scroll, child, {}

		column.empty = column:CreateFontString(nil, "OVERLAY")
		column.empty:SetFontObject(ns.AreaFont("list", "GameFontHighlight"))
		column.empty:SetPoint("TOPLEFT", scroll, "TOPLEFT", LAYOUT.QUEST_TEXT_X, -LAYOUT.ROW_PADDING)
		column.empty:SetPoint("RIGHT", scroll, "RIGHT", -LAYOUT.ROW_PADDING, 0)
		column.empty:SetJustifyH("LEFT")
		return column
	end

	local questColumn = Column("LEFT")
	local itemColumn = Column("RIGHT")

	local askButton = CreateFrame("Button", nil, questColumn, "UIPanelButtonTemplate")
	askButton:SetHeight(LAYOUT.ASK_BUTTON_HEIGHT)
	askButton:SetNormalFontObject(ns.AreaFont("list", "GameFontNormalSmall"))
	askButton:SetHighlightFontObject(ns.AreaFont("list", "GameFontHighlightSmall"))
	askButton:SetDisabledFontObject(ns.AreaFont("list", "GameFontDisableSmall"))
	askButton:SetMotionScriptsWhileDisabled(true)
	askButton:SetText(L["ZONE_INFO_ASK"])
	askButton:SetPoint("RIGHT", questColumn, "TOPRIGHT", -LAYOUT.ROW_PADDING, -TITLE_HEIGHT / 2)
	questColumn.title:SetPoint("RIGHT", askButton, "LEFT", -SPACE.LINE, 0)

	content:HookScript("OnShow", function()
		askButton:SetWidth(askButton:GetTextWidth() + LAYOUT.ASK_BUTTON_PADDING)
	end)

	local function QuestColors(level)
		local color, highlight = GetQuestDifficultyColor(level)
		if not highlight and QuestDifficultyHighlightColors then
			for key, value in pairs(QuestDifficultyColors) do
				if value == color then
					highlight = QuestDifficultyHighlightColors[key]
					break
				end
			end
		end
		return color, highlight or color
	end

	local function ItemColor(itemID)
		local _, _, quality = data.GetItemInfo(itemID)
		if quality and C_Item and C_Item.GetItemQualityColor then
			return C_Item.GetItemQualityColor(quality)
		elseif quality and GetItemQualityColor then
			return GetItemQualityColor(quality)
		end
		return ns.GetColorRGB("TEXT")
	end

	local function ColorRow(row, hovered)
		local r, g, b, hr, hg, hb
		if row.kind == "header" then
			local color = QuestDifficultyColors.header
			local highlight = QuestDifficultyHighlightColors and QuestDifficultyHighlightColors.header or color
			r, g, b, hr, hg, hb = color.r, color.g, color.b, highlight.r, highlight.g, highlight.b
		elseif row.kind == "quest" then
			local color, highlight = QuestColors(row.quest.level)
			r, g, b, hr, hg, hb = color.r, color.g, color.b, highlight.r, highlight.g, highlight.b
		else
			r, g, b = ItemColor(row.item.itemID)
			hr, hg, hb = r, g, b
		end
		if hovered then
			row.Text:SetTextColor(hr, hg, hb)
		else
			row.Text:SetTextColor(r, g, b)
		end

		if row.kind == "quest" then
			row.Tag:SetTextColor(ns.GetColorRGB(row.quest.shareable and "TEXT" or "MUTED"))
		end
		row.Highlight:SetVertexColor(r, g, b)
	end

	local Row_OnEnter, Row_OnLeave, Row_OnClick
	local DrawQuests

	local function NewRow(column)
		local row = CreateFrame("Button", nil, column.child)
		row:SetHeight(ROW_HEIGHT)

		row.Icon = row:CreateTexture(nil, "ARTWORK")
		row.Icon:SetSize(ICON_SIZE, ICON_SIZE)
		row.Icon:SetPoint("LEFT", LAYOUT.CHECK_X, 0)

		row.Text = row:CreateFontString(nil, "ARTWORK")
		row.Text:SetFontObject(ns.AreaFont("list", "GameFontNormal"))
		row.Text:SetJustifyH("LEFT")
		row.Text:SetWordWrap(false)

		row.Tag = row:CreateFontString(nil, "ARTWORK")
		row.Tag:SetFontObject(ns.AreaFont("list", "GameFontNormal"))
		row.Tag:SetPoint("RIGHT", -LAYOUT.ROW_PADDING, 0)
		row.Tag:SetJustifyH("RIGHT")

		row.PartyCount = row:CreateFontString(nil, "ARTWORK")
		row.PartyCount:SetFontObject(ns.AreaFont("list", "GameFontHighlight"))
		row.PartyCount:SetJustifyH("RIGHT")
		row.PartyCount:SetTextColor(ns.GetColorRGB("INFO"))
		row.PartyIcon = row:CreateTexture(nil, "ARTWORK")
		row.PartyIcon:SetTexture(PARTY_TEXTURE)
		row.PartyIcon:SetVertexColor(ns.GetColorRGB("INFO"))
		row.PartyIcon:SetSize(ICON_SIZE, ICON_SIZE)
		row.PartyIcon:SetPoint("RIGHT", row.PartyCount, "LEFT", -SPACE.TIGHT, 0)

		row.Highlight = row:CreateTexture(nil, "HIGHLIGHT")
		row.Highlight:SetTexture(ROW_HIGHLIGHT)
		row.Highlight:SetBlendMode("ADD")
		row.Highlight:SetAllPoints()

		row:SetScript("OnEnter", Row_OnEnter)
		row:SetScript("OnLeave", Row_OnLeave)
		row:SetScript("OnClick", Row_OnClick)
		return row
	end

	local function PlaceRow(column, index, y, height)
		local row = column.rows[index]
		if not row then
			row = NewRow(column)
			column.rows[index] = row
		end
		row:ClearAllPoints()
		row:SetPoint("TOPLEFT", 0, -y)
		row:SetPoint("TOPRIGHT", 0, -y)
		row:SetHeight(height)
		row.kind, row.quest, row.item, row.zone = nil, nil, nil, nil
		row.Icon:Hide()
		row.Tag:SetText(nil)
		row.PartyCount:SetText(nil)
		row.PartyIcon:Hide()
		row:Show()
		return row
	end

	local function FinishColumn(column, count, height)
		for index = count + 1, #column.rows do
			column.rows[index]:Hide()
		end
		column.child:SetHeight(math.max(1, height))
	end

	local function FitText(row, textX)
		row.Text:ClearAllPoints()
		row.Text:SetPoint("LEFT", textX, 0)
		if row.PartyIcon:IsShown() then
			row.Text:SetPoint("RIGHT", row.PartyIcon, "LEFT", -SPACE.LINE, 0)
		elseif row.Tag:GetText() then
			row.Text:SetPoint("RIGHT", row.Tag, "LEFT", -SPACE.LINE, 0)
		else
			row.Text:SetPoint("RIGHT", -LAYOUT.ROW_PADDING, 0)
		end
	end

	local function PartyCount(questID)
		return ns.questie.PartyCountOnQuest(questID)
	end

	local function SetHeaderRow(row, zoneName)
		row.kind, row.zone = "header", zoneName
		row:EnableMouse(true)
		row.Icon:SetTexture(collapsed[zoneName] and PLUS_TEXTURE or MINUS_TEXTURE)
		row.Icon:SetVertexColor(1, 1, 1)
		row.Icon:Show()
		row.Text:SetText(zoneName)
		FitText(row, LAYOUT.HEADER_TEXT_X)
		ColorRow(row, row:IsMouseOver())
	end

	local function SetQuestRow(row, quest)
		row.kind, row.quest = "quest", quest
		row:EnableMouse(true)
		local tagID, isElite = ns.GetQuestTagByID(quest.questID)
		row.Text:SetText(ns.QuestListTitle(quest.level, quest.name, ns.QuestSuffix(tagID, isElite)))
		row.Tag:SetText(L[quest.shareable and "ZONE_INFO_SHAREABLE" or "ZONE_INFO_NOT_SHAREABLE"])
		local onQuest = PartyCount(quest.questID)
		if onQuest > 0 then
			row.PartyCount:ClearAllPoints()
			if row.Tag:GetText() then
				row.PartyCount:SetPoint("RIGHT", row.Tag, "LEFT", -SPACE.LINE, 0)
			else
				row.PartyCount:SetPoint("RIGHT", -LAYOUT.ROW_PADDING, 0)
			end
			row.PartyCount:SetText(onQuest)
			row.PartyIcon:Show()
		end
		FitText(row, LAYOUT.QUEST_TEXT_X)
		ColorRow(row, row:IsMouseOver())
	end

	local function SetItemCount(row)
		local item = row.item
		local have = data.ItemCount(item.itemID)
		row.Tag:SetText(("%d / %d"):format(have, item.need))
		if have >= item.need then
			row.Tag:SetTextColor(ns.GetColorRGB("ON"))
		else
			row.Tag:SetTextColor(ns.GetColorRGB("TEXT"))
		end
	end

	local function SetItemRow(row, item)
		row.kind, row.item = "item", item
		row:EnableMouse(true)
		row.Icon:SetTexture(data.ItemIcon(item.itemID) or 134400)
		row.Icon:SetVertexColor(1, 1, 1)
		row.Icon:Show()
		local name = data.GetItemInfo(item.itemID)
		row.Text:SetText(name or item.name)
		SetItemCount(row)
		FitText(row, LAYOUT.QUEST_TEXT_X)
		ColorRow(row, row:IsMouseOver())
	end

	local function AddWrappedLine(text, colorKey)
		local r, g, b = ns.GetColorRGB(colorKey)
		GameTooltip:AddLine(text, r, g, b, true)
	end

	local function PlaceLine(quest)
		if quest.giverZone and quest.giverX and quest.giverY then
			local spot = ("%d,%d"):format(math.floor(quest.giverX + 0.5), math.floor(quest.giverY + 0.5))
			return L["ZONE_INFO_GIVER_PLACE"]:format(spot, quest.giverZone)
		end
		return quest.giverZone
	end

	local function ShowQuestTooltip(row)
		local quest = row.quest
		GameTooltip:SetOwner(row, "ANCHOR_RIGHT")
		local tagID, isElite = ns.GetQuestTagByID(quest.questID)
		GameTooltip:AddLine(
			ns.QuestListTitle(quest.level, quest.name, ns.QuestSuffix(tagID, isElite)),
			ns.GetColorRGB("TITLE")
		)
		if quest.giver then
			GameTooltip:AddLine(" ")
			AddWrappedLine(L["ZONE_INFO_GIVER"]:format(quest.giver), "TEXT")
		end
		local place = PlaceLine(quest)
		if place then
			GameTooltip:AddLine(" ")
			AddWrappedLine(place, "TEXT")
		end
		GameTooltip:Show()
	end

	local function AddOnHeading(text)
		GameTooltip:AddLine(
			ns.GetColor("INFO")
				.. L["ADDON_SHORT_NAME"]
				.. "|r "
				.. ns.GetColor("SEPARATOR")
				.. "//|r "
				.. ns.GetColor("TEXT")
				.. text
				.. "|r",
			nil,
			nil,
			nil,
			true
		)
	end

	local function ShowItemTooltip(row)
		local item = row.item
		GameTooltip:SetOwner(row, "ANCHOR_RIGHT")
		GameTooltip:SetItemByID(item.itemID)
		GameTooltip:AddLine(" ")
		AddOnHeading(L["ZONE_INFO_NEEDED_FOR"])
		for _, quest in ipairs(item.quests) do
			local tagID, isElite = ns.GetQuestTagByID(quest.questID)
			local title = ns.QuestListTitle(quest.level, quest.name, ns.QuestSuffix(tagID, isElite))
			GameTooltip:AddLine(" " .. title, ns.GetColorRGB("TEXT"))
		end
		ns.AddClickHints(GameTooltip, { { L["ZONE_INFO_SHIFT_CLICK"], L["ZONE_INFO_LINK_ITEM"] } })
		GameTooltip:Show()
	end

	function Row_OnEnter(row)
		ColorRow(row, true)
		if row.kind == "quest" then
			ShowQuestTooltip(row)
		elseif row.kind == "item" then
			ShowItemTooltip(row)
		end
	end

	function Row_OnLeave(row)
		if row.kind then
			ColorRow(row, false)
		end
		if GameTooltip:IsOwned(row) then
			GameTooltip:Hide()
		end
	end

	function Row_OnClick(row)
		if row.kind == "header" then
			PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
			collapsed[row.zone] = not collapsed[row.zone] or nil
			DrawQuests(current.result)
		elseif row.kind == "item" and IsModifiedClick("CHATLINK") then
			local _, link = data.GetItemInfo(row.item.itemID)
			local insert = ChatFrameUtil and ChatFrameUtil.InsertLink or ChatEdit_InsertLink
			if link and insert then
				insert(link)
			end
		end
	end

	local function SetTitle(column, label, count)
		column.title:SetText(label .. ns.GetColor("TEXT") .. " (" .. count .. ")|r")
	end

	function DrawQuests(result)
		local quests = result and result.quests or {}
		local index, y, lastZone, first = 0, 0, nil, true
		for _, quest in ipairs(quests) do
			local zone = quest.giverZone or UNKNOWN
			if first or zone ~= lastZone then
				if not first then
					y = y + LAYOUT.HEADER_GAP
				end
				index = index + 1
				SetHeaderRow(PlaceRow(questColumn, index, y, TITLE_HEIGHT), zone)
				y = y + TITLE_HEIGHT
				lastZone, first = zone, false
			end
			if not collapsed[zone] then
				index = index + 1
				SetQuestRow(PlaceRow(questColumn, index, y, ROW_HEIGHT), quest)
				y = y + ROW_HEIGHT
			end
		end
		FinishColumn(questColumn, index, y)
		SetTitle(questColumn, L["ZONE_INFO_QUESTS"], #quests)
	end

	local function DrawCounts()
		for _, row in ipairs(itemColumn.rows) do
			if row:IsShown() and row.kind == "item" then
				SetItemCount(row)
			end
		end
	end

	local function DrawItems(result)
		local items = result and result.items or {}
		for index, item in ipairs(items) do
			SetItemRow(PlaceRow(itemColumn, index, (index - 1) * ROW_HEIGHT, ROW_HEIGHT), item)
		end
		FinishColumn(itemColumn, #items, #items * ROW_HEIGHT)
		SetTitle(itemColumn, L["ZONE_INFO_ITEMS"], #items)
	end

	local function SetMessage(column, message)
		column.empty:SetText(message or "")
		column.empty:SetShown(message ~= nil)
	end

	local function Draw()
		local result = current.result
		if not result or result.mapID ~= current.mapID then
			DrawQuests(nil)
			DrawItems(nil)
			local message = current.mapID and L["ZONE_INFO_WORKING"] or nil
			SetMessage(questColumn, message)
			SetMessage(itemColumn, message)
			askButton:Disable()
			return
		end
		if result.unavailable then

			local starting = Questie ~= nil
			DrawQuests(nil)
			DrawItems(nil)
			SetMessage(questColumn, starting and L["ZONE_INFO_WORKING"] or L["ZONE_INFO_NEEDS_QUESTIE"])
			SetMessage(itemColumn, starting and L["ZONE_INFO_WORKING"] or nil)
			askButton:Disable()
			return
		end
		DrawQuests(result)
		DrawItems(result)
		SetMessage(questColumn, #result.quests == 0 and L["ZONE_INFO_NO_QUESTS"] or nil)
		SetMessage(itemColumn, #result.items == 0 and L["ZONE_INFO_NO_ITEMS"] or nil)
		askButton:SetEnabled(result.shareable > 0)
	end

	local dirty = true
	local RequestRefresh

	local function Refresh()
		if not box:IsVisible() then
			dirty = true
			return
		end
		dirty = false
		local mapID = current.mapID
		if not mapID then
			Draw()
			return
		end
		if not (current.result and current.result.mapID == mapID) then
			current.result = nil
			Draw()
		end
		data.Request(mapID, function(result)
			if result.mapID == current.mapID then
				current.result = result
				Draw()

				if result.unavailable and Questie ~= nil then
					RequestRefresh(STARTING_DELAY)
				end
			end
		end)
	end

	local refreshPending
	function RequestRefresh(delay)
		if refreshPending then
			return
		end
		refreshPending = true
		C_Timer.After(delay or REFRESH_DELAY, function()
			refreshPending = nil
			Refresh()
		end)
	end

	local function SetZone(mapID)
		mapID = data.ZoneOf(mapID) or mapID
		if mapID == current.mapID then
			return
		end
		current.mapID = mapID
		Refresh()
	end

	questMap.onZoneShown = function(mapID)
		SetZone(mapID)
	end

	box:SetScript("OnShow", function()
		FitHeight()
		if not current.mapID then
			SetZone(questMap.ShownZone and questMap.ShownZone() or data.PlayerZone())
		end
		if dirty or (current.result and current.result.unavailable) then
			Refresh()
		end
	end)

	local function Browse(mapID)
		if questMap.PickQuestZone and questMap.PickQuestZone(mapID) then
			return
		end
		questMap.browseMapID = mapID
		questMap.FollowQuest()
		SetZone(mapID)
	end

	function questMap.EndBrowse()
		questMap.browseMapID = nil
	end

	function questMap.AddZoneInfoMenu(root)
		local function IsShown(mapID)
			return mapID == current.mapID
		end
		local function Radio(parent, mapID, label)
			parent:CreateRadio(label or data.ZoneName(mapID) or tostring(mapID), IsShown, Browse, mapID)
		end

		local playerZone = data.PlayerZone()
		if playerZone then
			root:CreateTitle(L["ZONE_INFO_MENU_HERE"])
			Radio(root, playerZone)
		end
		local logZones = data.LogZones()
		if #logZones > 0 then
			root:CreateTitle(L["ZONE_INFO_MENU_LOG"])
			for _, mapID in ipairs(logZones) do
				Radio(root, mapID)
			end
		end
		local availableZones, counts = data.AvailableZones(AVAILABLE_ZONES_LISTED)
		if #availableZones > 0 then
			root:CreateTitle(L["ZONE_INFO_MENU_AVAILABLE"])
			for _, mapID in ipairs(availableZones) do
				local name = data.ZoneName(mapID) or tostring(mapID)
				Radio(root, mapID, name .. ns.GetColor("MUTED") .. " (" .. counts[mapID] .. ")|r")
			end
		end
		root:CreateDivider()
		for _, continent in ipairs(data.Continents()) do
			local submenu = root:CreateButton(continent.name)
			if submenu.SetScrollMode then
				submenu:SetScrollMode(MENU_SCROLL_HEIGHT)
			end
			for _, zone in ipairs(continent.zones) do
				Radio(submenu, zone.mapID, zone.name)
			end
		end
	end

	local function ChannelPrefix()
		local channel = GetChannelName and GetChannelName(LFG_CHANNEL)
		if channel and channel > 0 then
			return "/" .. LFG_CHANNEL .. " "
		end
		return ""
	end

	local function QuestReferences(questID)
		local references = {}
		local questieLink = ns.ImportQuestieModule("QuestieLink")
		for _, name in ipairs({ "GetNativeQuestLinkStringById", "GetQuestLinkStringById" }) do
			if questieLink and type(questieLink[name]) == "function" then
				local found, reference = pcall(questieLink[name], questID)
				if found and type(reference) == "string" and reference ~= "" then
					references[#references + 1] = reference
				end
			end
		end
		return references
	end

	local function AskMessage(quests, room)
		local references = {}
		local function Message(list)
			return L["ZONE_INFO_ASK_MESSAGE"]:format(table.concat(list, ", "))
		end
		for _, quest in ipairs(quests) do
			if quest.shareable and PartyCount(quest.questID) == 0 then
				local choices = QuestReferences(quest.questID)
				choices[#choices + 1] = "[" .. quest.name .. "]"
				local fitted
				for _, reference in ipairs(choices) do
					references[#references + 1] = reference
					if #Message(references) <= room then
						fitted = true
						break
					end
					references[#references] = nil
				end
				if not fitted then
					break
				end
			end
		end
		return #references > 0 and Message(references) or nil
	end

	askButton:SetScript("OnClick", function()
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
		local result = current.result
		local openChat = ChatFrameUtil and ChatFrameUtil.OpenChat or ChatFrame_OpenChat
		if not (result and result.quests and openChat) then
			return
		end
		local prefix = ChannelPrefix()
		local message = AskMessage(result.quests, ns.CHAT_MESSAGE_MAX_LENGTH - #prefix)
		if message then
			openChat(prefix .. message)
		end
	end)

	askButton:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip_AddNormalLine(GameTooltip, L["ZONE_INFO_ASK_DESCRIPTION"], true)
		GameTooltip:Show()
	end)
	askButton:SetScript("OnLeave", GameTooltip_Hide)

	function zoneInfo.Apply()
		local shown = ns.db.profile.showZoneInfo ~= false
		questMap.SetZoneInfoShown(shown)
		box:SetShown(shown)
		if not shown and questMap.browseMapID then
			questMap.EndBrowse()
			questMap.FollowQuest()
		end
	end

	zoneInfo.built = true
	zoneInfo.RequestRefresh = RequestRefresh
	zoneInfo.RequestAvailableRefresh = function()
		RequestRefresh(AVAILABLE_DELAY)
	end
	zoneInfo.DrawCounts = DrawCounts
	zoneInfo.Redraw = function()
		if box:IsVisible() and current.result then
			Draw()
		end
	end

end)

function zoneInfo:OnBagUpdateDelayed()
	if self.built then
		self.DrawCounts()
	end
end

function zoneInfo:OnQuestAccepted()
	if self.built then
		self.RequestRefresh()
	end
end
zoneInfo.OnQuestRemoved = zoneInfo.OnQuestAccepted
zoneInfo.OnQuestTurnedIn = zoneInfo.OnQuestAccepted

function zoneInfo:OnPlayerLevelUp()
	if self.built then
		self.RequestAvailableRefresh()
	end
end
zoneInfo.OnSkillLinesChanged = zoneInfo.OnPlayerLevelUp

function zoneInfo:OnGetItemInfoReceived(itemID, success)
	if ns.zoneInfoData.ItemArrived(itemID, success) and self.built then
		self.RequestRefresh()
	end
end

function zoneInfo:OnGroupRosterUpdate()
	if self.built then
		self.Redraw()
	end
end
zoneInfo.OnUnitQuestLogChanged = zoneInfo.OnGroupRosterUpdate
