local L = LibStub("AceLocale-3.0"):NewLocale("WideQuest", "enUS", true)
if not L then
	return
end

L["ADDON_TITLE"] = "Wide Quest Log Forever"
L["ADDON_SHORT_NAME"] = "WQL"

L["LIST_SEPARATOR"] = ", "
L["CHAT_OPTIONS_IN_COMBAT"] = "As a safety precaution, the Options Interface cannot be opened during combat."

L["ENABLE_WIDE_QUEST_LOG"] = "Enable Wide Quest Log Forever"
L["FEATURE_QUEST_LOG_DESCRIPTION"] =
	"Swaps Blizzard's quest log for the wide one, with the map beside it. Takes effect after a reload."
L["FEATURE_QUEST_LOG_RELOAD_PENDING"] =
	"Enable Wide Quest Log Forever takes effect after a reload, offered when you close the Options Interface."
L["RELOAD_PROMPT"] = "Wide Quest Log Forever switches quest logs after a reload. Reload now?"

L["TAB_QUEST_LOG_DESCRIPTION"] =
	"Replaces Blizzard's quest log with a wide one: your quests listed by zone, with the selected quest's details and its map beside them."
L["QUEST_LOG_SORTING_HEADER"] = "Sorting"
L["QUEST_LOG_SORTING_DESCRIPTION"] = "Choose the order of your zones and the quests under them."
L["QUEST_LOG_ROWS_HEADER"] = "Quest Rows"
L["QUEST_LOG_ROWS_DESCRIPTION"] = "Choose what each row shows."
L["TAB_WINDOW_MAP"] = "Window & Map"
L["QUEST_LOG_WINDOW_MAP_DESCRIPTION"] = "Size the window and map to fit your screen, and choose how they behave."
L["ZONE_ORDER"] = "Zone Order"
L["ZONE_ORDER_DESCRIPTION"] = "Changes the order of the zones in the quest list."
L["SORT_AVERAGE_LEVEL_HIGHEST_DEFAULT"] = "Average Level, Highest First (Default)"
L["SORT_AVERAGE_LEVEL_LOWEST"] = "Average Level, Lowest First"
L["SORT_ALPHABETICAL"] = "Alphabetical"
L["CURRENT_ZONE_FIRST"] = "Show Current Zone First"
L["CURRENT_ZONE_FIRST_DESCRIPTION"] = "Puts the zone you're in at the top of the list, whatever the zone order."
L["ZONE_GAP"] = "Add Space Above Zone Names"
L["ZONE_GAP_DESCRIPTION"] =
	"Adds a little space above each zone name. Handy when your quests are spread across lots of zones."
L["QUEST_ORDER"] = "Quest Order"
L["QUEST_ORDER_DESCRIPTION"] = "Changes the order of the quests under each zone."
L["SORT_LEVEL_HIGHEST_DEFAULT"] = "Level, Highest First (Default)"
L["SORT_LEVEL_LOWEST"] = "Level, Lowest First"
L["COMPLETED_FIRST"] = "Show Completed Quests First"
L["COMPLETED_FIRST_DESCRIPTION"] = "Moves quests that are ready to turn in to the top of their zone."
L["SHOW_QUEST_LEVELS"] = "Show Quest Levels"

L["SHOW_QUEST_LEVELS_DESCRIPTION"] =
	"Puts each quest's level and type in front of its name in the list, like %s for a level 40 dungeon quest."
L["MARK_UNTRACKED"] = "Mark Untracked Quests"

L["MARK_UNTRACKED_DESCRIPTION"] =
	"Tracked quests lose their checkmark %s, and untracked quests get an eye %s instead. Handy if you track almost everything."
L["CLOSE_IN_COMBAT"] = "Close When Combat Starts"
L["CLOSE_IN_COMBAT_DESCRIPTION"] = "Closes the quest log when a fight starts, so it never covers the action."
L["SHOW_OBJECTIVE_AREAS"] = "Show Objective Areas"
L["SHOW_OBJECTIVE_AREAS_DESCRIPTION"] =
	"Shades where each objective's mobs and objects are found on the map beside the quest log, with one icon in each area instead of one on every spawn."
L["NEEDS_QUESTIE_HINT"] = "Turn on Questie to use this."
L["SHOW_ZONE_INFO"] = "Show Zone Info"
L["SHOW_ZONE_INFO_DESCRIPTION"] =
	"Under the map, the quests from other zones you could pick up for the zone it shows, and the items that zone's quests ask you to bring. The map shrinks to half the window's height to make room."
L["WINDOW_SCALE"] = "Quest Log Scale"
L["WINDOW_SCALE_DESCRIPTION"] = "Makes the quest log bigger or smaller. The map beside it grows and shrinks with it."
L["MAP_SCALE"] = "Map Scale"
L["MAP_SCALE_DESCRIPTION"] = "Makes the map beside the quest log bigger or smaller, on top of the Quest Log Scale."
L["RESET_WINDOW_BUTTON"] = "Reset Window"
L["RESET_WINDOW_MOVE_DESCRIPTION"] =
	"Puts the quest log's height and scale, and the map's scale, back to their defaults, and moves the window back to its starting spot."
L["RESET_WINDOW_MOVE_CONFIRM"] =
	"Reset the quest log's height and scale, the map's scale, and the window's spot on screen?"

L["FONT_HEADER"] = "Font"
L["FONT_LIST_DESCRIPTION"] = "The font of the zone names and quests in the quest list."
L["FONT_DETAILS_DESCRIPTION"] = "The font of the quest details: the title, the headings, and the quest text."
L["FONT_WINDOW_DESCRIPTION"] = "The font of the window's title, the quest count, and the Turn-In line."
L["FONT_FACE"] = "Font"
L["FONT_FACE_DESCRIPTION"] =
	"The typeface. Game Default follows the game's font, and any add-on that changes it. Fonts added through SharedMedia are listed too."
L["FONT_GAME_DEFAULT"] = "Game Default"
L["FONT_GAME_STANDARD"] = "Standard Text"
L["FONT_GAME_NAMES"] = "Character Names"
L["FONT_GAME_DAMAGE"] = "Damage Numbers"
L["FONT_SIZE"] = "Size"
L["FONT_SIZE_DESCRIPTION"] =
	"Makes the text bigger or smaller, in points from the game's size. 0 keeps the game's size."
L["FONT_OUTLINE"] = "Outline"
L["FONT_OUTLINE_DESCRIPTION"] =
	"A black outline around each letter. Game Default keeps whatever outline the game's font has, and None takes it away."
L["FONT_OUTLINE_DEFAULT"] = "Game Default"
L["FONT_OUTLINE_NONE"] = "None"
L["FONT_OUTLINE_THIN"] = "Thin"
L["FONT_OUTLINE_THICK"] = "Thick"
L["FONT_SHADOW"] = "Text Shadow"
L["FONT_SHADOW_DESCRIPTION"] =
	"Keeps the drop shadow the game's font has behind the text. Turn it off to take the shadow away, which helps a font that looks blurry or smudged."
L["FONT_SLUG"] = "Sharper Text (Slug)"
L["FONT_SLUG_DESCRIPTION"] =
	"Draws the text with Blizzard's newer Slug renderer, for crisper letters at any size. Slug can't draw a thick outline or a shadow, so text with either is drawn the usual way."
L["FONT_RESET_BUTTON"] = "Reset Font"
L["FONT_RESET_DESCRIPTION"] = "Puts this font's settings back to their defaults."

L["QUEST_SUFFIX_DUNGEON"] = "D"
L["QUEST_SUFFIX_RAID"] = "R"
L["QUEST_SUFFIX_PVP"] = "P"
L["QUEST_SUFFIX_ELITE"] = "E"

L["QUEST_TYPE_DUNGEON"] = "dungeon"
L["QUEST_TYPE_RAID"] = "raid"
L["QUEST_TYPE_ELITE"] = "elite"
L["QUEST_TYPE_PVP"] = "PvP"

L["QUEST_LEVEL_LEGEND"] = "Letters after the level: %s."

L["QUEST_LEVEL_LEGEND_ENTRY"] = "%s %s"
L["QUEST_ID"] = "Quest ID %d"

L["QUEST_CHAIN_PROGRESS"] = "Quest Chain (%d of %d)"
L["WOWHEAD_LINK_TOOLTIP"] = "Click for a Wowhead link."
L["WOWHEAD_LINK_COPY"] = "Press Ctrl+C (Cmd+C on a Mac) to copy the Wowhead link."
L["EXPAND_ALL"] = "Expand All"
L["COLLAPSE_ALL"] = "Collapse All"
L["TRACK_ALL"] = "Track All"
L["UNTRACK_ALL"] = "Untrack All"
L["HIDE_MAP"] = "Hide Map"
L["ZONE_INFO_QUESTS"] = "Quests to Pick Up"
L["ZONE_INFO_ITEMS"] = "Things to Bring"
L["ZONE_INFO_BACK"] = "Back to Quest"
L["ZONE_INFO_ASK"] = "Ask for Shares"
L["ZONE_INFO_ASK_DESCRIPTION"] =
	"Writes the quests here that players can share into your chat box, on channel 4 (Looking for Group) when you're in it. Nothing is sent until you press Enter."

L["ZONE_INFO_ASK_MESSAGE"] = "Could anyone share %s?"

L["ZONE_INFO_GIVER"] = "Given by %s"

L["ZONE_INFO_GIVER_PLACE"] = "%s in %s"
L["ZONE_INFO_SHAREABLE"] = "Shareable"
L["ZONE_INFO_NOT_SHAREABLE"] = "Not Shareable"

L["ZONE_INFO_NEEDED_FOR"] = "Needed For"
L["ZONE_INFO_SHIFT_CLICK"] = "Shift-Click"
L["ZONE_INFO_LINK_ITEM"] = "Link in Chat"
L["ZONE_INFO_MENU_QUEST"] = "This Quest"
L["ZONE_INFO_MENU_HERE"] = "Where You Are"
L["ZONE_INFO_MENU_LOG"] = "Your Quests"
L["ZONE_INFO_MENU_AVAILABLE"] = "Most Quests for You"
L["ZONE_INFO_NO_QUESTS"] = "No quests from other zones to pick up for here."
L["ZONE_INFO_NO_ITEMS"] = "Nothing to buy or bring for here."
L["ZONE_INFO_WORKING"] = "Reading quests..."
L["ZONE_INFO_NEEDS_QUESTIE"] = "Turn on Questie to see what's here."

L["TURN_IN_XP"] = "%s XP"
L["TURN_IN_SEPARATOR"] = " / "

L["TURN_IN_SUMMARY"] = "Turn-In: %s"
L["TURN_IN_TOOLTIP"] = "Ready to Turn In"
L["RESIZE_TOOLTIP"] = "Drag to resize the quest log."

L["CHAT_SHARING_AFTER_COMBAT"] = "Sharing %s when combat ends."

L["QUESTIE_CANNOT_SHOW"] = "Questie's tracker can't show %s because the quest is missing from Questie's database."
L["QUESTIE_CANNOT_TRACK"] = "Questie can't track this quest yet."
