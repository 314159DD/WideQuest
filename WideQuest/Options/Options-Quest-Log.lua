local _, ns = ...
local L = ns.L
local GetColor = ns.GetColor

local RESET_WINDOW_WIDTH = 1.25
local RESET_WINDOW_INDENT_WIDTH = ns.OPTIONS_ROW_WIDTH - RESET_WINDOW_WIDTH

local SORT_LABEL_WIDTH = 1.4
local SORT_CONTROL_WIDTH = ns.OPTIONS_ROW_WIDTH - SORT_LABEL_WIDTH

local function TrackingMarkIcon(mark, offsetY)
	local red, green, blue = ns.HexToRGB(mark.color)
	return format(
		"|T%s:16:16:0:%d:32:32:0:32:0:32:%d:%d:%d|t",
		mark.texture,
		offsetY or 0,
		red * 255,
		green * 255,
		blue * 255
	)
end

local MARK_UNTRACKED_TEXT = L["MARK_UNTRACKED_DESCRIPTION"]:format(
	TrackingMarkIcon(ns.TRACKING_MARKS.tracked),
	TrackingMarkIcon(ns.TRACKING_MARKS.untracked, 3)
)

local function Hidden()
	return not ns.db.profile.enableWideQuestLog
end

local function Inactive()
	return not ns.wideQuestLogActive
end

local function SortSelect(key, descriptionKey, values, sorting, order)
	return {
		type = "select",
		name = "",
		desc = L[descriptionKey],
		width = SORT_CONTROL_WIDTH,
		order = order,
		hidden = Hidden,
		disabled = Inactive,
		values = values,
		sorting = sorting,
		get = function()
			return ns.db.profile[key]
		end,
		set = function(_, value)
			ns.db.profile[key] = value
			ns.RefreshQuestLog()
		end,
	}
end

local function QuestLogToggle(key, nameKey, desc, order)
	return {
		type = "toggle",
		name = L[nameKey],
		desc = desc or L[nameKey .. "_DESCRIPTION"],
		width = "full",
		order = order,
		hidden = Hidden,
		disabled = Inactive,
		get = function()
			return ns.db.profile[key]
		end,
		set = function(_, value)
			ns.db.profile[key] = value
			ns.RefreshQuestLog()
		end,
	}
end

local function QuestieLoaded()
	return C_AddOns.IsAddOnLoaded(ns.QUESTIE_ADDON_NAME)
end

local function ObjectiveAreasToggle(order)
	local toggle = QuestLogToggle("showObjectiveAreas", "SHOW_OBJECTIVE_AREAS", nil, order)
	toggle.disabled = function()
		return Inactive() or not QuestieLoaded()
	end
	toggle.desc = function()
		if QuestieLoaded() then
			return L["SHOW_OBJECTIVE_AREAS_DESCRIPTION"]
		end
		return L["SHOW_OBJECTIVE_AREAS_DESCRIPTION"] .. "\n" .. GetColor("OFF") .. L["NEEDS_QUESTIE_HINT"] .. "|r"
	end
	toggle.set = function(_, value)
		ns.db.profile.showObjectiveAreas = value
		ns.questMap.RequestRefresh()
	end
	return toggle
end

local function ZoneInfoToggle(order)
	local toggle = QuestLogToggle("showZoneInfo", "SHOW_ZONE_INFO", nil, order)
	toggle.disabled = function()
		return Inactive() or not QuestieLoaded()
	end
	toggle.desc = function()
		if QuestieLoaded() then
			return L["SHOW_ZONE_INFO_DESCRIPTION"]
		end
		return L["SHOW_ZONE_INFO_DESCRIPTION"] .. "\n" .. GetColor("OFF") .. L["NEEDS_QUESTIE_HINT"] .. "|r"
	end
	toggle.set = function(_, value)
		ns.db.profile.showZoneInfo = value
		if ns.zoneInfo.Apply then
			ns.zoneInfo.Apply()
		end
	end
	return toggle
end

local function SortSubOption(key, nameKey, order)
	local toggle = QuestLogToggle(key, nameKey, nil, 2)
	toggle.name = function()
		return Inactive() and L[nameKey] or ns.OptionsSubLabel(L[nameKey])
	end
	toggle.width = ns.OPTIONS_ROW_WIDTH - ns.OPTIONS_SUB_INDENT_WIDTH
	toggle.hidden = nil
	return ns.OptionsSubRow(order, Hidden, { [key] = toggle })
end

local function FontGroup(area, order)
	local group = { type = "group", name = "", inline = true, order = order, hidden = Hidden, args = {} }
	ns.AddFontOptions(group.args, area, 1, Hidden, Inactive)
	return group
end

function ns.BuildQuestLogOptions()
	local args = {
		descIntro = ns.OptionsDesc(L["TAB_QUEST_LOG_DESCRIPTION"], 1),
		spaceIntro = ns.OptionsSpacer(2),
		enableWideQuestLog = ns.OptionsFeatureToggle(
			"enableWideQuestLog",
			"ENABLE_WIDE_QUEST_LOG",
			"FEATURE_QUEST_LOG_DESCRIPTION",
			3
		),
		reloadPending = ns.OptionsStatusLine(ns.QuestLogReloadPendingText, 4),

		spaceSorting0 = ns.OptionsSpacer(5, Hidden),
		headerSorting = ns.OptionsHeader(L["QUEST_LOG_SORTING_HEADER"], 6, Hidden),
		spaceSorting1 = ns.OptionsSpacer(7, Hidden),
		descSorting = ns.OptionsDesc(L["QUEST_LOG_SORTING_DESCRIPTION"], 8, Hidden),
		spaceSorting2 = ns.OptionsSpacer(9, Hidden),

		zoneSortLabel = ns.OptionsRowLabel(L["ZONE_ORDER"], 10, SORT_LABEL_WIDTH, Hidden, L["ZONE_ORDER_DESCRIPTION"]),
		zoneSort = SortSelect("zoneSort", "ZONE_ORDER_DESCRIPTION", {
			LEVEL_HIGHEST_FIRST = L["SORT_AVERAGE_LEVEL_HIGHEST_DEFAULT"],
			LEVEL_LOWEST_FIRST = L["SORT_AVERAGE_LEVEL_LOWEST"],
			ALPHABETICAL = L["SORT_ALPHABETICAL"],
		}, { "LEVEL_HIGHEST_FIRST", "LEVEL_LOWEST_FIRST", "ALPHABETICAL" }, 11),
		currentZoneFirstRow = SortSubOption("currentZoneFirst", "CURRENT_ZONE_FIRST", 12),
		spaceQuestSort = ns.OptionsSpacer(13, Hidden),
		questSortLabel = ns.OptionsRowLabel(
			L["QUEST_ORDER"],
			14,
			SORT_LABEL_WIDTH,
			Hidden,
			L["QUEST_ORDER_DESCRIPTION"]
		),
		questSort = SortSelect("questSort", "QUEST_ORDER_DESCRIPTION", {
			LEVEL_HIGHEST_FIRST = L["SORT_LEVEL_HIGHEST_DEFAULT"],
			LEVEL_LOWEST_FIRST = L["SORT_LEVEL_LOWEST"],
			ALPHABETICAL = L["SORT_ALPHABETICAL"],
		}, { "LEVEL_HIGHEST_FIRST", "LEVEL_LOWEST_FIRST", "ALPHABETICAL" }, 15),
		completedFirstRow = SortSubOption("completedFirst", "COMPLETED_FIRST", 16),

		spaceQuestRows0 = ns.OptionsSpacer(20, Hidden),
		headerQuestRows = ns.OptionsHeader(L["QUEST_LOG_ROWS_HEADER"], 21, Hidden),
		spaceQuestRows1 = ns.OptionsSpacer(22, Hidden),
		descQuestRows = ns.OptionsDesc(L["QUEST_LOG_ROWS_DESCRIPTION"], 23, Hidden),
		spaceQuestRows2 = ns.OptionsSpacer(24, Hidden),

		zoneGap = QuestLogToggle("zoneGap", "ZONE_GAP", nil, 25),
		spaceShowQuestLevels = ns.OptionsSpacer(26, Hidden),
		showQuestLevels = QuestLogToggle(
			"showQuestLevels",
			"SHOW_QUEST_LEVELS",
			L["SHOW_QUEST_LEVELS_DESCRIPTION"]:format(ns.LevelTag(40, L["QUEST_SUFFIX_DUNGEON"]))
				.. " "
				.. ns.QuestLevelLegend(),
			27
		),
		spaceMarkUntracked = ns.OptionsSpacer(28, Hidden),
		markUntracked = QuestLogToggle("markUntracked", "MARK_UNTRACKED", MARK_UNTRACKED_TEXT, 29),

		spaceWindowMap0 = ns.OptionsSpacer(30, Hidden),
		headerWindowMap = ns.OptionsHeader(L["TAB_WINDOW_MAP"], 31, Hidden),
		spaceWindowMap1 = ns.OptionsSpacer(32, Hidden),
		descWindowMap = ns.OptionsDesc(L["QUEST_LOG_WINDOW_MAP_DESCRIPTION"], 33, Hidden),
		spaceWindowMap2 = ns.OptionsSpacer(34, Hidden),

		closeInCombat = QuestLogToggle("closeInCombat", "CLOSE_IN_COMBAT", nil, 35),
		spaceObjectiveAreas = ns.OptionsSpacer(36, Hidden),
		showObjectiveAreas = ObjectiveAreasToggle(37),
		spaceZoneInfo = ns.OptionsSpacer(37.1, Hidden),
		showZoneInfo = ZoneInfoToggle(37.2),

		spaceWindowScale = ns.OptionsSpacer(38, Hidden),
		windowScaleLabel = ns.OptionsRowLabel(L["WINDOW_SCALE"], 39, nil, Hidden, L["WINDOW_SCALE_DESCRIPTION"]),
		windowScale = {
			type = "range",
			name = "",
			desc = L["WINDOW_SCALE_DESCRIPTION"],
			width = ns.OPTIONS_CONTROL_WIDTH,
			order = 40,
			hidden = Hidden,
			disabled = Inactive,
			min = 0.7,
			max = 1.3,
			step = 0.05,
			isPercent = true,
			get = function()
				return ns.db.global.scale
			end,
			set = function(_, value)
				ns.db.global.scale = value
				ns.ApplyWindowScale()
			end,
		},
		spaceMapScale = ns.OptionsSpacer(41, Hidden),
		mapScaleLabel = ns.OptionsRowLabel(L["MAP_SCALE"], 42, nil, Hidden, L["MAP_SCALE_DESCRIPTION"]),
		mapScale = {
			type = "range",
			name = "",
			desc = L["MAP_SCALE_DESCRIPTION"],
			width = ns.OPTIONS_CONTROL_WIDTH,
			order = 43,
			hidden = Hidden,
			disabled = Inactive,
			min = 0.7,
			max = 1.3,
			step = 0.05,
			isPercent = true,
			get = function()
				return ns.db.global.mapScale
			end,
			set = function(_, value)
				ns.db.global.mapScale = value
				ns.ApplyMapScale()
			end,
		},
		spaceResetWindow = ns.OptionsSpacer(44, Hidden),
		resetWindowIndent = ns.OptionsRowLabel(" ", 45, RESET_WINDOW_INDENT_WIDTH, Hidden),
		resetWindow = {
			type = "execute",
			name = L["RESET_WINDOW_BUTTON"],
			desc = L["RESET_WINDOW_MOVE_DESCRIPTION"],
			width = RESET_WINDOW_WIDTH,
			order = 46,
			hidden = Hidden,
			disabled = Inactive,
			confirm = true,
			confirmText = L["RESET_WINDOW_MOVE_CONFIRM"],
			func = function()
				ns.ResetWindow()
			end,
		},

		fontList = FontGroup("list", 50),
		fontDetails = FontGroup("details", 51),
		fontWindow = FontGroup("window", 52),
	}
	return { type = "group", name = L["ADDON_TITLE"], args = args }
end
