local L = LibStub("AceLocale-3.0"):NewLocale("WideQuest", "ruRU")
if not L then
	return
end

L["ADDON_TITLE"] = "Wide Quest Log Forever"
L["ADDON_SHORT_NAME"] = "WQL"

L["LIST_SEPARATOR"] = ", "
L["CHAT_OPTIONS_IN_COMBAT"] =
	"В целях безопасности окно настроек нельзя открыть во время боя."

L["ENABLE_WIDE_QUEST_LOG"] = "Включить широкий журнал заданий"
L["FEATURE_QUEST_LOG_DESCRIPTION"] =
	"Заменяет журнал заданий Blizzard широким, с картой рядом. Вступает в силу после перезагрузки интерфейса."
L["FEATURE_QUEST_LOG_RELOAD_PENDING"] =
	"Параметр Включить широкий журнал заданий вступит в силу после перезагрузки интерфейса, которую предложат при закрытии окна настроек."
L["RELOAD_PROMPT"] =
	"Wide Quest Log Forever сменит журнал заданий после перезагрузки интерфейса. Перезагрузить сейчас?"

L["TAB_QUEST_LOG_DESCRIPTION"] =
	"Заменяет журнал заданий Blizzard широким: задания сгруппированы по зонам, а рядом видны подробности выбранного задания и его карта."
L["QUEST_LOG_SORTING_HEADER"] = "Сортировка"
L["QUEST_LOG_SORTING_DESCRIPTION"] = "Выберите порядок зон и заданий в них."
L["QUEST_LOG_ROWS_HEADER"] = "Строки заданий"
L["QUEST_LOG_ROWS_DESCRIPTION"] = "Выберите, что показывать в каждой строке."
L["TAB_WINDOW_MAP"] = "Окно и карта"
L["QUEST_LOG_WINDOW_MAP_DESCRIPTION"] =
	"Подгоните размер окна и карты под свой экран и выберите их поведение."
L["ZONE_ORDER"] = "Порядок зон"
L["ZONE_ORDER_DESCRIPTION"] = "Меняет порядок зон в списке заданий."
L["SORT_AVERAGE_LEVEL_HIGHEST_DEFAULT"] =
	"Средний уровень, сначала высокий (по умолчанию)"
L["SORT_AVERAGE_LEVEL_LOWEST"] = "Средний уровень, сначала низкий"
L["SORT_ALPHABETICAL"] = "По алфавиту"
L["CURRENT_ZONE_FIRST"] = "Показывать текущую зону первой"
L["CURRENT_ZONE_FIRST_DESCRIPTION"] =
	"Ставит зону, в которой вы находитесь, в начало списка при любом порядке зон."
L["ZONE_GAP"] = "Добавлять отступ над названиями зон"
L["ZONE_GAP_DESCRIPTION"] =
	"Добавляет небольшой отступ над каждым названием зоны. Удобно, если ваши задания разбросаны по многим зонам."
L["QUEST_ORDER"] = "Порядок заданий"
L["QUEST_ORDER_DESCRIPTION"] = "Меняет порядок заданий внутри каждой зоны."
L["SORT_LEVEL_HIGHEST_DEFAULT"] = "Уровень, сначала высокий (по умолчанию)"
L["SORT_LEVEL_LOWEST"] = "Уровень, сначала низкий"
L["COMPLETED_FIRST"] = "Показывать выполненные задания первыми"
L["COMPLETED_FIRST_DESCRIPTION"] =
	"Поднимает задания, которые можно сдать, в начало их зоны."
L["SHOW_QUEST_LEVELS"] = "Показывать уровни заданий"

L["SHOW_QUEST_LEVELS_DESCRIPTION"] =
	"Ставит уровень и тип каждого задания перед его названием в списке, например %s для задания 40-го уровня в подземелье."
L["MARK_UNTRACKED"] = "Отмечать неотслеживаемые задания"

L["MARK_UNTRACKED_DESCRIPTION"] =
	"Отслеживаемые задания теряют галочку %s, а неотслеживаемые вместо этого получают глаз %s. Удобно, если вы отслеживаете почти всё."
L["CLOSE_IN_COMBAT"] = "Закрывать при начале боя"
L["CLOSE_IN_COMBAT_DESCRIPTION"] =
	"Закрывает журнал заданий, когда начинается бой, чтобы он никогда не загораживал происходящее."
L["SHOW_OBJECTIVE_AREAS"] = "Показывать области целей"
L["SHOW_OBJECTIVE_AREAS_DESCRIPTION"] =
	"Выделяет цветом на карте рядом с журналом заданий места, где находятся противники и объекты каждой цели, с одним значком на область вместо значка на каждой точке появления."
L["NEEDS_QUESTIE_HINT"] = "Включите Questie, чтобы пользоваться этим."
L["SHOW_ZONE_INFO"] = "Показывать сведения о зоне"
L["SHOW_ZONE_INFO_DESCRIPTION"] =
	"Под картой — задания из других зон, которые можно взять для показанной зоны, и предметы, которые просят задания этой зоны. Карта уменьшается до половины высоты окна, чтобы освободить место."
L["WINDOW_SCALE"] = "Масштаб журнала заданий"
L["WINDOW_SCALE_DESCRIPTION"] =
	"Увеличивает или уменьшает журнал заданий. Карта рядом с ним меняет размер вместе с ним."
L["MAP_SCALE"] = "Масштаб карты"
L["MAP_SCALE_DESCRIPTION"] =
	"Увеличивает или уменьшает карту рядом с журналом заданий, в дополнение к масштабу журнала заданий."
L["RESET_WINDOW_BUTTON"] = "Сбросить окно"
L["RESET_WINDOW_MOVE_DESCRIPTION"] =
	"Возвращает высоту и масштаб журнала заданий, а также масштаб карты к значениям по умолчанию и перемещает окно на начальное место."
L["RESET_WINDOW_MOVE_CONFIRM"] =
	"Сбросить высоту и масштаб журнала заданий, масштаб карты и положение окна на экране?"

L["FONT_HEADER"] = "Шрифт"
L["FONT_LIST_DESCRIPTION"] = "Шрифт названий зон и заданий в списке заданий."
L["FONT_DETAILS_DESCRIPTION"] =
	"Шрифт подробностей задания: название, заголовки и текст задания."
L["FONT_WINDOW_DESCRIPTION"] =
	'Шрифт заголовка окна, счётчика заданий и строки "Сдача".'
L["FONT_FACE"] = "Шрифт"
L["FONT_FACE_DESCRIPTION"] =
	'Начертание. Вариант "Как в игре" следует шрифту игры и любому аддону, который его меняет. Шрифты, добавленные через SharedMedia, тоже есть в списке.'
L["FONT_GAME_DEFAULT"] = "Как в игре"
L["FONT_GAME_STANDARD"] = "Обычный текст"
L["FONT_GAME_NAMES"] = "Имена персонажей"
L["FONT_GAME_DAMAGE"] = "Числа урона"
L["FONT_SIZE"] = "Размер"
L["FONT_SIZE_DESCRIPTION"] =
	"Увеличивает или уменьшает текст на заданное число пунктов относительно размера в игре. 0 оставляет размер как в игре."
L["FONT_OUTLINE"] = "Контур"
L["FONT_OUTLINE_DESCRIPTION"] =
	'Чёрный контур вокруг каждой буквы. Вариант "Как в игре" сохраняет контур, который есть у шрифта игры, а "Нет" убирает его.'
L["FONT_OUTLINE_DEFAULT"] = "Как в игре"
L["FONT_OUTLINE_NONE"] = "Нет"
L["FONT_OUTLINE_THIN"] = "Тонкий"
L["FONT_OUTLINE_THICK"] = "Толстый"
L["FONT_SHADOW"] = "Тень текста"
L["FONT_SHADOW_DESCRIPTION"] =
	"Сохраняет тень за текстом, которая есть у шрифта игры. Выключите, чтобы убрать тень: это помогает, если шрифт выглядит размытым или смазанным."
L["FONT_SLUG"] = "Более чёткий текст (Slug)"
L["FONT_SLUG_DESCRIPTION"] =
	"Рисует текст новым движком отрисовки Slug от Blizzard, чтобы буквы были чётче при любом размере. Slug не умеет рисовать толстый контур и тень, поэтому текст с любым из них рисуется обычным способом."
L["FONT_RESET_BUTTON"] = "Сбросить шрифт"
L["FONT_RESET_DESCRIPTION"] =
	"Возвращает параметры этого шрифта к значениям по умолчанию."

L["QUEST_SUFFIX_DUNGEON"] = "Д"
L["QUEST_SUFFIX_RAID"] = "Р"
L["QUEST_SUFFIX_PVP"] = "П"
L["QUEST_SUFFIX_ELITE"] = "Э"

L["QUEST_TYPE_DUNGEON"] = "подземелье"
L["QUEST_TYPE_RAID"] = "рейд"
L["QUEST_TYPE_ELITE"] = "элитное"
L["QUEST_TYPE_PVP"] = "ПвП"

L["QUEST_LEVEL_LEGEND"] = "Буквы после уровня: %s."

L["QUEST_LEVEL_LEGEND_ENTRY"] = "%s %s"
L["QUEST_ID"] = "ID задания %d"

L["QUEST_CHAIN_PROGRESS"] = "Цепочка заданий (%d из %d)"
L["WOWHEAD_LINK_TOOLTIP"] = "Щелкните, чтобы получить ссылку на Wowhead."
L["WOWHEAD_LINK_COPY"] =
	"Нажмите Ctrl+C (Cmd+C на Mac), чтобы скопировать ссылку на Wowhead."
L["EXPAND_ALL"] = "Развернуть все"
L["COLLAPSE_ALL"] = "Свернуть все"
L["TRACK_ALL"] = "Отслеживать все"
L["UNTRACK_ALL"] = "Снять отслеживание"
L["HIDE_MAP"] = "Скрыть карту"
L["ZONE_INFO_QUESTS"] = "Задания, которые можно взять"
L["ZONE_INFO_ITEMS"] = "Что принести"
L["ZONE_INFO_BACK"] = "Назад к заданию"
L["ZONE_INFO_ASK"] = "Попросить поделиться"
L["ZONE_INFO_ASK_DESCRIPTION"] =
	"Пишет в окно чата здешние задания, которыми игроки могут делиться, в канал 4 (Поиск спутников), если вы в нём. Ничего не отправляется, пока вы не нажмёте Enter."

L["ZONE_INFO_ASK_MESSAGE"] = "Кто-нибудь может поделиться: %s?"

L["ZONE_INFO_GIVER"] = "Выдаёт: %s"
L["ZONE_INFO_GIVER_PLACE"] = "%s, %s"
L["ZONE_INFO_SHAREABLE"] = "Можно передать"
L["ZONE_INFO_NOT_SHAREABLE"] = "Нельзя передать"
L["ZONE_INFO_NEEDED_FOR"] = "Нужно для"
L["ZONE_INFO_SHIFT_CLICK"] = "Shift-клик"
L["ZONE_INFO_LINK_ITEM"] = "Ссылка в чат"
L["ZONE_INFO_MENU_QUEST"] = "Это задание"
L["ZONE_INFO_MENU_HERE"] = "Где вы сейчас"
L["ZONE_INFO_MENU_LOG"] = "Ваши задания"
L["ZONE_INFO_MENU_AVAILABLE"] = "Больше всего заданий для вас"
L["ZONE_INFO_NO_QUESTS"] = "Нет заданий из других зон для этой зоны."
L["ZONE_INFO_NO_ITEMS"] = "Ничего не нужно покупать или приносить."
L["ZONE_INFO_WORKING"] = "Чтение заданий..."
L["ZONE_INFO_NEEDS_QUESTIE"] = "Включите Questie, чтобы увидеть, что здесь есть."

L["TURN_IN_XP"] = "%s опыта"
L["TURN_IN_SEPARATOR"] = " / "

L["TURN_IN_SUMMARY"] = "Сдача: %s"
L["TURN_IN_TOOLTIP"] = "Можно сдать"
L["RESIZE_TOOLTIP"] = "Перетащите, чтобы изменить размер журнала заданий."

L["CHAT_SHARING_AFTER_COMBAT"] = "Задание %s будет передано после окончания боя."

L["QUESTIE_CANNOT_SHOW"] =
	"Отслеживание Questie не может показать %s, потому что этого задания нет в базе данных Questie."
L["QUESTIE_CANNOT_TRACK"] = "Questie пока не может отслеживать это задание."
