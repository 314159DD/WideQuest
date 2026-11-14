local _, ns = ...
local L = ns.L

local QUEST_TAG_SUFFIX = {}
for tagID, kind in pairs(ns.QUEST_TAG_SUFFIXES) do
	QUEST_TAG_SUFFIX[tagID] = L["QUEST_SUFFIX_" .. kind]
end
local ELITE_SUFFIX = L["QUEST_SUFFIX_ELITE"]

function ns.QuestSuffix(tagID, isElite)
	return (tagID and QUEST_TAG_SUFFIX[tagID]) or (isElite and ELITE_SUFFIX) or ""
end

local LEGEND_ORDER = { "DUNGEON", "RAID", "GROUP", "ELITE", "PVP" }

local questLevelLegend
do
	local shown = { ELITE = true }
	for _, kind in pairs(ns.QUEST_TAG_SUFFIXES) do
		shown[kind] = true
	end
	local entries = {}
	for _, kind in ipairs(LEGEND_ORDER) do
		if shown[kind] then
			entries[#entries + 1] =
				L["QUEST_LEVEL_LEGEND_ENTRY"]:format(L["QUEST_SUFFIX_" .. kind], L["QUEST_TYPE_" .. kind])
		end
	end
	questLevelLegend = L["QUEST_LEVEL_LEGEND"]:format(table.concat(entries, L["LIST_SEPARATOR"]))
end

function ns.QuestLevelLegend()
	return questLevelLegend
end

function ns.LevelTag(level, suffix)
	return format("[%d%s]", level or 0, suffix or "")
end

function ns.LevelTitle(level, title, suffix)
	return ns.LevelTag(level, suffix) .. " " .. (title or "")
end

function ns.QuestListTitle(level, title, suffix)
	if ns.db.profile.showQuestLevels then
		return ns.LevelTitle(level, title, suffix)
	end
	return title or ""
end

local function QuestIDText(questID)
	return format(L["QUEST_ID"], questID)
end

local function ColorQuestID(text, source)
	local r, g, b = source:GetTextColor()
	text:SetTextColor(r, g, b)
	local label = QuestIDText(text.questID)
	if text.linksToWowhead then
		label = format(
			"|T%s:0:0:0:%d:32:32:0:32:0:32:%d:%d:%d|t %s",
			ns.WOWHEAD_LINK_ICON,
			-ns.LAYOUT.LINK_ICON_DROP,
			r * 255,
			g * 255,
			b * 255,
			label
		)
	end
	text:SetText(label)
end

function ns.StyleQuestID(text, questID, source)
	local file, size, flags = source:GetFont()
	if file and size then
		text:SetFont(file, size - ns.LAYOUT.QUEST_ID_FONT_SHRINK, flags)
	end
	text.questID = questID
	ColorQuestID(text, source)
	if not text.followsSourceColor then
		text.followsSourceColor = true
		hooksecurefunc(source, "SetTextColor", function()
			ColorQuestID(text, source)
		end)
	end
end
