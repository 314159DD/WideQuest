local L = LibStub("AceLocale-3.0"):NewLocale("WideQuest", "zhCN")
if not L then
	return
end

L["ADDON_TITLE"] = "Wide Quest Log Forever"
L["ADDON_SHORT_NAME"] = "WQL"

L["LIST_SEPARATOR"] = "、"
L["CHAT_OPTIONS_IN_COMBAT"] = "出于安全考虑，战斗中无法打开设置界面。"

L["ENABLE_WIDE_QUEST_LOG"] = "启用宽版任务日志"
L["FEATURE_QUEST_LOG_DESCRIPTION"] =
	"将暴雪任务日志换成宽版任务日志，地图就在旁边。重新加载界面后生效。"
L["FEATURE_QUEST_LOG_RELOAD_PENDING"] =
	"启用宽版任务日志需要重新加载界面才能生效，关闭设置界面时会提示你重新加载。"
L["RELOAD_PROMPT"] = "Wide Quest Log Forever 需要重新加载界面才能切换任务日志。现在重新加载吗？"

L["TAB_QUEST_LOG_DESCRIPTION"] =
	"用宽版任务日志替换暴雪任务日志：任务按区域列出，旁边显示所选任务的详情及其地图。"
L["QUEST_LOG_SORTING_HEADER"] = "排序"
L["QUEST_LOG_SORTING_DESCRIPTION"] = "选择区域及其下任务的顺序。"
L["QUEST_LOG_ROWS_HEADER"] = "任务行"
L["QUEST_LOG_ROWS_DESCRIPTION"] = "选择每行显示的内容。"
L["TAB_WINDOW_MAP"] = "窗口与地图"
L["QUEST_LOG_WINDOW_MAP_DESCRIPTION"] =
	"调整窗口和地图大小以适合你的屏幕，并选择它们的行为方式。"
L["ZONE_ORDER"] = "区域顺序"
L["ZONE_ORDER_DESCRIPTION"] = "更改任务列表中区域的顺序。"
L["SORT_AVERAGE_LEVEL_HIGHEST_DEFAULT"] = "平均等级，从高到低（默认）"
L["SORT_AVERAGE_LEVEL_LOWEST"] = "平均等级，从低到高"
L["SORT_ALPHABETICAL"] = "按名称"
L["CURRENT_ZONE_FIRST"] = "优先显示当前区域"
L["CURRENT_ZONE_FIRST_DESCRIPTION"] = "无论区域顺序如何，都将你所在的区域置于列表顶部。"
L["ZONE_GAP"] = "在区域名称上方添加空白"
L["ZONE_GAP_DESCRIPTION"] =
	"在每个区域名称上方留出一点间距。如果你的任务分布在许多区域，会很方便。"
L["QUEST_ORDER"] = "任务顺序"
L["QUEST_ORDER_DESCRIPTION"] = "更改每个区域下任务的顺序。"
L["SORT_LEVEL_HIGHEST_DEFAULT"] = "等级，从高到低（默认）"
L["SORT_LEVEL_LOWEST"] = "等级，从低到高"
L["COMPLETED_FIRST"] = "优先显示已完成任务"
L["COMPLETED_FIRST_DESCRIPTION"] = "将可以交付的任务移到所在区域的顶部。"
L["SHOW_QUEST_LEVELS"] = "显示任务等级"

L["SHOW_QUEST_LEVELS_DESCRIPTION"] =
	"在列表中每个任务名称前显示其等级和类型，例如 %s 表示40级地下城任务。"
L["MARK_UNTRACKED"] = "标记未追踪的任务"

L["MARK_UNTRACKED_DESCRIPTION"] =
	"已追踪的任务不再显示对勾 %s，改为在未追踪的任务前显示眼睛 %s。如果你几乎追踪所有任务，会很方便。"
L["CLOSE_IN_COMBAT"] = "战斗开始时关闭"
L["CLOSE_IN_COMBAT_DESCRIPTION"] = "战斗开始时关闭任务日志，避免遮挡战斗画面。"
L["SHOW_OBJECTIVE_AREAS"] = "显示目标范围"
L["SHOW_OBJECTIVE_AREAS_DESCRIPTION"] =
	"在任务日志旁的地图上，用阴影标出每个目标的怪物和物体所在的范围，每个范围只显示一个图标，而不是每个刷新点各显示一个。"
L["NEEDS_QUESTIE_HINT"] = "启用 Questie 后才能使用此功能。"
L["SHOW_ZONE_INFO"] = "显示区域信息"
L["SHOW_ZONE_INFO_DESCRIPTION"] =
	"在地图下方显示：为地图所示区域可在其他区域接取的任务，以及该区域任务要求带去的物品。地图会缩小到窗口高度的一半来腾出空间。"
L["WINDOW_SCALE"] = "任务日志缩放"
L["WINDOW_SCALE_DESCRIPTION"] = "放大或缩小任务日志。旁边的地图会随之一起缩放。"
L["MAP_SCALE"] = "地图缩放"
L["MAP_SCALE_DESCRIPTION"] = "在任务日志缩放的基础上，放大或缩小任务日志旁的地图。"
L["RESET_WINDOW_BUTTON"] = "重置窗口"
L["RESET_WINDOW_MOVE_DESCRIPTION"] =
	"将任务日志的高度和缩放以及地图缩放恢复为默认值，并将窗口移回初始位置。"
L["RESET_WINDOW_MOVE_CONFIRM"] =
	"重置任务日志的高度和缩放、地图缩放以及窗口在屏幕上的位置？"

L["FONT_HEADER"] = "字体"
L["FONT_LIST_DESCRIPTION"] = "任务列表中区域名称和任务的字体。"
L["FONT_DETAILS_DESCRIPTION"] = "任务详情的字体：标题、小标题和任务文本。"
L["FONT_WINDOW_DESCRIPTION"] = "窗口标题、任务数量和交付行的字体。"
L["FONT_FACE"] = "字体"
L["FONT_FACE_DESCRIPTION"] =
	'字体样式。"游戏默认"会跟随游戏字体，以及任何更改游戏字体的插件。通过 SharedMedia 添加的字体也会列出。'
L["FONT_GAME_DEFAULT"] = "游戏默认"
L["FONT_GAME_STANDARD"] = "标准文字"
L["FONT_GAME_NAMES"] = "角色名称"
L["FONT_GAME_DAMAGE"] = "伤害数字"
L["FONT_SIZE"] = "大小"
L["FONT_SIZE_DESCRIPTION"] = "以游戏字号为基准，按磅数放大或缩小文字。0 表示保持游戏字号。"
L["FONT_OUTLINE"] = "描边"
L["FONT_OUTLINE_DESCRIPTION"] =
	'每个字周围的黑色描边。"游戏默认"保留游戏字体原有的描边，"无"则去掉描边。'
L["FONT_OUTLINE_DEFAULT"] = "游戏默认"
L["FONT_OUTLINE_NONE"] = "无"
L["FONT_OUTLINE_THIN"] = "细"
L["FONT_OUTLINE_THICK"] = "粗"
L["FONT_SHADOW"] = "文字阴影"
L["FONT_SHADOW_DESCRIPTION"] =
	"保留游戏字体在文字后面的投影。关闭后会去掉阴影，有助于改善看起来模糊或发虚的字体。"
L["FONT_SLUG"] = "更清晰的文字（Slug）"
L["FONT_SLUG_DESCRIPTION"] =
	"使用暴雪较新的 Slug 渲染器绘制文字，在任何字号下都更清晰。Slug 无法绘制粗描边或阴影，因此带有其中任一效果的文字会按常规方式绘制。"
L["FONT_RESET_BUTTON"] = "重置字体"
L["FONT_RESET_DESCRIPTION"] = "将此字体的设置恢复为默认值。"

L["QUEST_SUFFIX_DUNGEON"] = "副"
L["QUEST_SUFFIX_RAID"] = "团"
L["QUEST_SUFFIX_PVP"] = "战"
L["QUEST_SUFFIX_ELITE"] = "精"

L["QUEST_TYPE_DUNGEON"] = "地下城"
L["QUEST_TYPE_RAID"] = "团队副本"
L["QUEST_TYPE_ELITE"] = "精英"
L["QUEST_TYPE_PVP"] = "PvP"

L["QUEST_LEVEL_LEGEND"] = "等级后的字：%s。"

L["QUEST_LEVEL_LEGEND_ENTRY"] = "%s（%s）"
L["QUEST_ID"] = "任务ID %d"

L["QUEST_CHAIN_PROGRESS"] = "任务链（%d/%d）"
L["WOWHEAD_LINK_TOOLTIP"] = "点击获取 Wowhead 链接。"
L["WOWHEAD_LINK_COPY"] = "按 Ctrl+C（Mac 上为 Cmd+C）复制 Wowhead 链接。"
L["EXPAND_ALL"] = "全部展开"
L["COLLAPSE_ALL"] = "全部折叠"
L["TRACK_ALL"] = "全部追踪"
L["UNTRACK_ALL"] = "全部取消追踪"
L["HIDE_MAP"] = "隐藏地图"
L["ZONE_INFO_QUESTS"] = "可接任务"
L["ZONE_INFO_ITEMS"] = "需要带的东西"
L["ZONE_INFO_BACK"] = "返回任务"
L["ZONE_INFO_ASK"] = "请求共享"
L["ZONE_INFO_ASK_DESCRIPTION"] =
	"把这里可共享的任务写进你的聊天框；若你在 4 号频道（寻求组队），就写在该频道。按回车前不会发送任何内容。"

L["ZONE_INFO_ASK_MESSAGE"] = "有人能共享%s吗？"

L["ZONE_INFO_GIVER"] = "发布者：%s"
L["ZONE_INFO_GIVER_PLACE"] = "%s，%s"
L["ZONE_INFO_SHAREABLE"] = "可共享"
L["ZONE_INFO_NOT_SHAREABLE"] = "不可共享"
L["ZONE_INFO_NEEDED_FOR"] = "需要它的任务"
L["ZONE_INFO_SHIFT_CLICK"] = "Shift-点击"
L["ZONE_INFO_LINK_ITEM"] = "在聊天中链接"
L["ZONE_INFO_MENU_QUEST"] = "此任务"
L["ZONE_INFO_MENU_HERE"] = "你所在的位置"
L["ZONE_INFO_MENU_LOG"] = "你的任务"
L["ZONE_INFO_MENU_AVAILABLE"] = "适合你的任务最多"
L["ZONE_INFO_NO_QUESTS"] = "没有可在其他区域为这里接取的任务。"
L["ZONE_INFO_NO_ITEMS"] = "没有需要购买或带上的东西。"
L["ZONE_INFO_WORKING"] = "正在读取任务..."
L["ZONE_INFO_NEEDS_QUESTIE"] = "启用 Questie 以查看这里的内容。"

L["TURN_IN_XP"] = "%s 经验"
L["TURN_IN_SEPARATOR"] = " / "

L["TURN_IN_SUMMARY"] = "交付：%s"
L["TURN_IN_TOOLTIP"] = "可以交付"
L["RESIZE_TOOLTIP"] = "拖动以调整任务日志大小。"

L["CHAT_SHARING_AFTER_COMBAT"] = "战斗结束后分享 %s。"

L["QUESTIE_CANNOT_SHOW"] = "Questie 追踪器无法显示 %s，因为 Questie 数据库中缺少该任务。"
L["QUESTIE_CANNOT_TRACK"] = "Questie 暂时无法追踪此任务。"
