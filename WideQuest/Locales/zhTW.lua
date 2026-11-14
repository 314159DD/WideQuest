local L = LibStub("AceLocale-3.0"):NewLocale("WideQuest", "zhTW")
if not L then
	return
end

L["ADDON_TITLE"] = "Wide Quest Log Forever"
L["ADDON_SHORT_NAME"] = "WQL"

L["LIST_SEPARATOR"] = "、"
L["CHAT_OPTIONS_IN_COMBAT"] = "基於安全考量，戰鬥中無法開啟設定介面。"

L["ENABLE_WIDE_QUEST_LOG"] = "啟用寬版任務日誌"
L["FEATURE_QUEST_LOG_DESCRIPTION"] =
	"將暴雪任務日誌換成寬版任務日誌，地圖就在旁邊。重新載入介面後生效。"
L["FEATURE_QUEST_LOG_RELOAD_PENDING"] =
	"啟用寬版任務日誌需要重新載入介面才會生效，關閉設定介面時會提示你重新載入。"
L["RELOAD_PROMPT"] = "Wide Quest Log Forever 需要重新載入介面才能切換任務日誌。現在重新載入嗎？"

L["TAB_QUEST_LOG_DESCRIPTION"] =
	"以寬版任務日誌取代暴雪任務日誌：任務依區域列出，旁邊顯示所選任務的詳細資訊及其地圖。"
L["QUEST_LOG_SORTING_HEADER"] = "排序"
L["QUEST_LOG_SORTING_DESCRIPTION"] = "選擇區域及其下任務的順序。"
L["QUEST_LOG_ROWS_HEADER"] = "任務列"
L["QUEST_LOG_ROWS_DESCRIPTION"] = "選擇每列顯示的內容。"
L["TAB_WINDOW_MAP"] = "視窗與地圖"
L["QUEST_LOG_WINDOW_MAP_DESCRIPTION"] =
	"調整視窗和地圖大小以符合你的螢幕，並選擇它們的行為方式。"
L["ZONE_ORDER"] = "區域順序"
L["ZONE_ORDER_DESCRIPTION"] = "變更任務清單中區域的順序。"
L["SORT_AVERAGE_LEVEL_HIGHEST_DEFAULT"] = "平均等級，由高到低（預設）"
L["SORT_AVERAGE_LEVEL_LOWEST"] = "平均等級，由低到高"
L["SORT_ALPHABETICAL"] = "依名稱"
L["CURRENT_ZONE_FIRST"] = "優先顯示目前區域"
L["CURRENT_ZONE_FIRST_DESCRIPTION"] = "無論區域順序為何，都將你所在的區域置於清單頂端。"
L["ZONE_GAP"] = "在區域名稱上方加入空白"
L["ZONE_GAP_DESCRIPTION"] =
	"在每個區域名稱上方留出一點間距。如果你的任務分散在許多區域，會很方便。"
L["QUEST_ORDER"] = "任務順序"
L["QUEST_ORDER_DESCRIPTION"] = "變更每個區域下任務的順序。"
L["SORT_LEVEL_HIGHEST_DEFAULT"] = "等級，由高到低（預設）"
L["SORT_LEVEL_LOWEST"] = "等級，由低到高"
L["COMPLETED_FIRST"] = "優先顯示已完成任務"
L["COMPLETED_FIRST_DESCRIPTION"] = "將可以回報的任務移到所在區域的頂端。"
L["SHOW_QUEST_LEVELS"] = "顯示任務等級"

L["SHOW_QUEST_LEVELS_DESCRIPTION"] =
	"在清單中每個任務名稱前顯示其等級和類型，例如 %s 表示40級地城任務。"
L["MARK_UNTRACKED"] = "標記未追蹤的任務"

L["MARK_UNTRACKED_DESCRIPTION"] =
	"已追蹤的任務不再顯示勾號 %s，改為在未追蹤的任務前顯示眼睛 %s。如果你幾乎追蹤所有任務，會很方便。"
L["CLOSE_IN_COMBAT"] = "戰鬥開始時關閉"
L["CLOSE_IN_COMBAT_DESCRIPTION"] = "戰鬥開始時關閉任務日誌，避免遮住戰鬥畫面。"
L["SHOW_OBJECTIVE_AREAS"] = "顯示目標範圍"
L["SHOW_OBJECTIVE_AREAS_DESCRIPTION"] =
	"在任務日誌旁的地圖上，以陰影標出每個目標的怪物和物件所在的範圍，每個範圍只顯示一個圖示，而不是每個重生點各顯示一個。"
L["NEEDS_QUESTIE_HINT"] = "啟用 Questie 後才能使用此功能。"
L["SHOW_ZONE_INFO"] = "顯示區域資訊"
L["SHOW_ZONE_INFO_DESCRIPTION"] =
	"在地圖下方顯示：為地圖所示區域可在其他區域接取的任務，以及該區域任務要求帶去的物品。地圖會縮小到視窗高度的一半來騰出空間。"
L["WINDOW_SCALE"] = "任務日誌縮放"
L["WINDOW_SCALE_DESCRIPTION"] = "放大或縮小任務日誌。旁邊的地圖會隨之一起縮放。"
L["MAP_SCALE"] = "地圖縮放"
L["MAP_SCALE_DESCRIPTION"] = "在任務日誌縮放的基礎上，放大或縮小任務日誌旁的地圖。"
L["RESET_WINDOW_BUTTON"] = "重設視窗"
L["RESET_WINDOW_MOVE_DESCRIPTION"] =
	"將任務日誌的高度和縮放以及地圖縮放恢復為預設值，並將視窗移回初始位置。"
L["RESET_WINDOW_MOVE_CONFIRM"] =
	"要重設任務日誌的高度和縮放、地圖縮放以及視窗在螢幕上的位置嗎？"

L["FONT_HEADER"] = "字型"
L["FONT_LIST_DESCRIPTION"] = "任務清單中區域名稱和任務的字型。"
L["FONT_DETAILS_DESCRIPTION"] = "任務詳細資訊的字型：標題、小標題和任務文字。"
L["FONT_WINDOW_DESCRIPTION"] = "視窗標題、任務數量和回報列的字型。"
L["FONT_FACE"] = "字型"
L["FONT_FACE_DESCRIPTION"] =
	'字體樣式。"遊戲預設"會跟隨遊戲字型，以及任何變更遊戲字型的插件。透過 SharedMedia 加入的字型也會列出。'
L["FONT_GAME_DEFAULT"] = "遊戲預設"
L["FONT_GAME_STANDARD"] = "標準文字"
L["FONT_GAME_NAMES"] = "角色名稱"
L["FONT_GAME_DAMAGE"] = "傷害數字"
L["FONT_SIZE"] = "大小"
L["FONT_SIZE_DESCRIPTION"] = "以遊戲字級為基準，依點數放大或縮小文字。0 表示維持遊戲字級。"
L["FONT_OUTLINE"] = "外框"
L["FONT_OUTLINE_DESCRIPTION"] =
	'每個字周圍的黑色外框。"遊戲預設"保留遊戲字型原有的外框，"無"則移除外框。'
L["FONT_OUTLINE_DEFAULT"] = "遊戲預設"
L["FONT_OUTLINE_NONE"] = "無"
L["FONT_OUTLINE_THIN"] = "細"
L["FONT_OUTLINE_THICK"] = "粗"
L["FONT_SHADOW"] = "文字陰影"
L["FONT_SHADOW_DESCRIPTION"] =
	"保留遊戲字型在文字後方的投影。關閉後會移除陰影，有助於改善看起來模糊或暈開的字型。"
L["FONT_SLUG"] = "更清晰的文字（Slug）"
L["FONT_SLUG_DESCRIPTION"] =
	"使用暴雪較新的 Slug 繪製引擎來繪製文字，在任何字級下都更清晰。Slug 無法繪製粗外框或陰影，因此帶有其中任一效果的文字會以一般方式繪製。"
L["FONT_RESET_BUTTON"] = "重設字型"
L["FONT_RESET_DESCRIPTION"] = "將此字型的設定恢復為預設值。"

L["QUEST_SUFFIX_DUNGEON"] = "副"
L["QUEST_SUFFIX_RAID"] = "團"
L["QUEST_SUFFIX_PVP"] = "戰"
L["QUEST_SUFFIX_ELITE"] = "精"

L["QUEST_TYPE_DUNGEON"] = "地城"
L["QUEST_TYPE_RAID"] = "團隊副本"
L["QUEST_TYPE_ELITE"] = "精英"
L["QUEST_TYPE_PVP"] = "PvP"

L["QUEST_LEVEL_LEGEND"] = "等級後的字：%s。"

L["QUEST_LEVEL_LEGEND_ENTRY"] = "%s（%s）"
L["QUEST_ID"] = "任務ID %d"

L["QUEST_CHAIN_PROGRESS"] = "任務鏈（%d/%d）"
L["WOWHEAD_LINK_TOOLTIP"] = "點擊取得 Wowhead 連結。"
L["WOWHEAD_LINK_COPY"] = "按 Ctrl+C（Mac 上為 Cmd+C）複製 Wowhead 連結。"
L["EXPAND_ALL"] = "全部展開"
L["COLLAPSE_ALL"] = "全部收合"
L["TRACK_ALL"] = "全部追蹤"
L["UNTRACK_ALL"] = "全部取消追蹤"
L["HIDE_MAP"] = "隱藏地圖"
L["ZONE_INFO_QUESTS"] = "可接任務"
L["ZONE_INFO_ITEMS"] = "需要帶的東西"
L["ZONE_INFO_BACK"] = "返回任務"
L["ZONE_INFO_ASK"] = "請求分享"
L["ZONE_INFO_ASK_DESCRIPTION"] =
	"把這裡可分享的任務寫進你的聊天框；若你在 4 號頻道（尋求組隊），就寫在該頻道。按 Enter 前不會送出任何內容。"

L["ZONE_INFO_ASK_MESSAGE"] = "有人能分享%s嗎？"

L["ZONE_INFO_GIVER"] = "發布者：%s"
L["ZONE_INFO_GIVER_PLACE"] = "%s，%s"
L["ZONE_INFO_SHAREABLE"] = "可分享"
L["ZONE_INFO_NOT_SHAREABLE"] = "不可分享"
L["ZONE_INFO_NEEDED_FOR"] = "需要它的任務"
L["ZONE_INFO_SHIFT_CLICK"] = "Shift-點擊"
L["ZONE_INFO_LINK_ITEM"] = "在聊天中連結"
L["ZONE_INFO_MENU_QUEST"] = "此任務"
L["ZONE_INFO_MENU_HERE"] = "你所在的位置"
L["ZONE_INFO_MENU_LOG"] = "你的任務"
L["ZONE_INFO_MENU_AVAILABLE"] = "適合你的任務最多"
L["ZONE_INFO_NO_QUESTS"] = "沒有可在其他區域為這裡接取的任務。"
L["ZONE_INFO_NO_ITEMS"] = "沒有需要購買或帶上的東西。"
L["ZONE_INFO_WORKING"] = "正在讀取任務..."
L["ZONE_INFO_NEEDS_QUESTIE"] = "啟用 Questie 以查看這裡的內容。"

L["TURN_IN_XP"] = "%s 經驗"
L["TURN_IN_SEPARATOR"] = " / "

L["TURN_IN_SUMMARY"] = "回報：%s"
L["TURN_IN_TOOLTIP"] = "可以回報"
L["RESIZE_TOOLTIP"] = "拖曳以調整任務日誌大小。"

L["CHAT_SHARING_AFTER_COMBAT"] = "戰鬥結束後分享 %s。"

L["QUESTIE_CANNOT_SHOW"] = "Questie 追蹤器無法顯示 %s，因為 Questie 資料庫中缺少該任務。"
L["QUESTIE_CANNOT_TRACK"] = "Questie 暫時無法追蹤此任務。"
