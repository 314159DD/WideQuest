local L = LibStub("AceLocale-3.0"):NewLocale("WideQuest", "deDE")
if not L then
	return
end

L["ADDON_TITLE"] = "Wide Quest Log Forever"
L["ADDON_SHORT_NAME"] = "WQL"

L["LIST_SEPARATOR"] = ", "
L["CHAT_OPTIONS_IN_COMBAT"] = "Aus Sicherheitsgründen kann das Optionsmenü im Kampf nicht geöffnet werden."

L["ENABLE_WIDE_QUEST_LOG"] = "Breites Questlog aktivieren"
L["FEATURE_QUEST_LOG_DESCRIPTION"] =
	"Ersetzt Blizzards Questlog durch das breite, mit der Karte daneben. Wird nach einem Neuladen wirksam."
L["FEATURE_QUEST_LOG_RELOAD_PENDING"] =
	"Breites Questlog aktivieren wird nach einem Neuladen wirksam, das dir beim Schließen des Optionsmenüs angeboten wird."
L["RELOAD_PROMPT"] = "Wide Quest Log Forever wechselt das Questlog erst nach einem Neuladen. Jetzt neu laden?"

L["TAB_QUEST_LOG_DESCRIPTION"] =
	"Ersetzt Blizzards Questlog durch ein breites: deine Quests nach Zone sortiert, daneben die Details der gewählten Quest und ihre Karte."
L["QUEST_LOG_SORTING_HEADER"] = "Sortierung"
L["QUEST_LOG_SORTING_DESCRIPTION"] = "Wähle die Reihenfolge deiner Zonen und der Quests darunter."
L["QUEST_LOG_ROWS_HEADER"] = "Questzeilen"
L["QUEST_LOG_ROWS_DESCRIPTION"] = "Wähle, was jede Zeile zeigt."
L["TAB_WINDOW_MAP"] = "Fenster & Karte"
L["QUEST_LOG_WINDOW_MAP_DESCRIPTION"] =
	"Passe Fenster und Karte an deinen Bildschirm an und wähle, wie sie sich verhalten."
L["ZONE_ORDER"] = "Reihenfolge der Zonen"
L["ZONE_ORDER_DESCRIPTION"] = "Ändert die Reihenfolge der Zonen in der Questliste."
L["SORT_AVERAGE_LEVEL_HIGHEST_DEFAULT"] = "Durchschnittsstufe, höchste zuerst (Standard)"
L["SORT_AVERAGE_LEVEL_LOWEST"] = "Durchschnittsstufe, niedrigste zuerst"
L["SORT_ALPHABETICAL"] = "Alphabetisch"
L["CURRENT_ZONE_FIRST"] = "Aktuelle Zone zuerst zeigen"
L["CURRENT_ZONE_FIRST_DESCRIPTION"] =
	"Setzt die Zone, in der du dich befindest, an den Anfang der Liste, egal welche Reihenfolge der Zonen gewählt ist."
L["ZONE_GAP"] = "Abstand über Zonennamen einfügen"
L["ZONE_GAP_DESCRIPTION"] =
	"Fügt über jedem Zonennamen etwas Abstand ein. Praktisch, wenn deine Quests über viele Zonen verteilt sind."
L["QUEST_ORDER"] = "Reihenfolge der Quests"
L["QUEST_ORDER_DESCRIPTION"] = "Ändert die Reihenfolge der Quests unter jeder Zone."
L["SORT_LEVEL_HIGHEST_DEFAULT"] = "Stufe, höchste zuerst (Standard)"
L["SORT_LEVEL_LOWEST"] = "Stufe, niedrigste zuerst"
L["COMPLETED_FIRST"] = "Abgeschlossene Quests zuerst zeigen"
L["COMPLETED_FIRST_DESCRIPTION"] = "Verschiebt Quests, die abgegeben werden können, an den Anfang ihrer Zone."
L["SHOW_QUEST_LEVELS"] = "Queststufen anzeigen"

L["SHOW_QUEST_LEVELS_DESCRIPTION"] =
	"Setzt die Stufe und Art jeder Quest vor ihren Namen in der Liste, etwa %s für eine Dungeonquest der Stufe 40."
L["MARK_UNTRACKED"] = "Nicht verfolgte Quests markieren"

L["MARK_UNTRACKED_DESCRIPTION"] =
	"Verfolgte Quests verlieren ihr Häkchen %s, und nicht verfolgte Quests bekommen stattdessen ein Auge %s. Praktisch, wenn du fast alles verfolgst."
L["CLOSE_IN_COMBAT"] = "Bei Kampfbeginn schließen"
L["CLOSE_IN_COMBAT_DESCRIPTION"] =
	"Schließt das Questlog, sobald ein Kampf beginnt, damit es nie das Geschehen verdeckt."
L["SHOW_OBJECTIVE_AREAS"] = "Zielgebiete anzeigen"
L["SHOW_OBJECTIVE_AREAS_DESCRIPTION"] =
	"Schattiert auf der Karte neben dem Questlog, wo die Gegner und Objekte jedes Ziels zu finden sind, mit einem Symbol pro Gebiet statt einem auf jedem Spawnpunkt."
L["NEEDS_QUESTIE_HINT"] = "Aktiviere Questie, um dies zu nutzen."
L["SHOW_ZONE_INFO"] = "Zoneninfo anzeigen"
L["SHOW_ZONE_INFO_DESCRIPTION"] =
	"Unter der Karte die Quests aus anderen Zonen, die du für die gezeigte Zone annehmen könntest, und die Gegenstände, die die Quests dieser Zone verlangen. Die Karte schrumpft dafür auf die halbe Fensterhöhe."
L["WINDOW_SCALE"] = "Skalierung des Questlogs"
L["WINDOW_SCALE_DESCRIPTION"] = "Macht das Questlog größer oder kleiner. Die Karte daneben wächst und schrumpft mit."
L["MAP_SCALE"] = "Skalierung der Karte"
L["MAP_SCALE_DESCRIPTION"] =
	"Macht die Karte neben dem Questlog größer oder kleiner, zusätzlich zur Skalierung des Questlogs."
L["RESET_WINDOW_BUTTON"] = "Fenster zurücksetzen"
L["RESET_WINDOW_MOVE_DESCRIPTION"] =
	"Setzt Höhe und Skalierung des Questlogs sowie die Skalierung der Karte auf ihre Standardwerte zurück und bringt das Fenster an seine Ausgangsposition."
L["RESET_WINDOW_MOVE_CONFIRM"] =
	"Höhe und Skalierung des Questlogs, die Skalierung der Karte und die Position des Fensters auf dem Bildschirm zurücksetzen?"

L["FONT_HEADER"] = "Schrift"
L["FONT_LIST_DESCRIPTION"] = "Die Schrift der Zonennamen und Quests in der Questliste."
L["FONT_DETAILS_DESCRIPTION"] = "Die Schrift der Questdetails: der Titel, die Überschriften und der Questtext."
L["FONT_WINDOW_DESCRIPTION"] = "Die Schrift des Fenstertitels, der Questanzahl und der Abgabe-Zeile."
L["FONT_FACE"] = "Schriftart"
L["FONT_FACE_DESCRIPTION"] =
	"Die Schriftart. Spielstandard folgt der Schrift des Spiels und jedem Add-on, das sie ändert. Über SharedMedia hinzugefügte Schriftarten stehen ebenfalls zur Auswahl."
L["FONT_GAME_DEFAULT"] = "Spielstandard"
L["FONT_GAME_STANDARD"] = "Standardtext"
L["FONT_GAME_NAMES"] = "Charakternamen"
L["FONT_GAME_DAMAGE"] = "Schadenszahlen"
L["FONT_SIZE"] = "Größe"
L["FONT_SIZE_DESCRIPTION"] =
	"Macht den Text größer oder kleiner, in Punkten gegenüber der Größe des Spiels. 0 behält die Größe des Spiels bei."
L["FONT_OUTLINE"] = "Kontur"
L["FONT_OUTLINE_DESCRIPTION"] =
	"Eine schwarze Kontur um jeden Buchstaben. Spielstandard behält die Kontur bei, die die Schrift des Spiels hat, und Keine entfernt sie."
L["FONT_OUTLINE_DEFAULT"] = "Spielstandard"
L["FONT_OUTLINE_NONE"] = "Keine"
L["FONT_OUTLINE_THIN"] = "Dünn"
L["FONT_OUTLINE_THICK"] = "Dick"
L["FONT_SHADOW"] = "Textschatten"
L["FONT_SHADOW_DESCRIPTION"] =
	"Behält den Schlagschatten bei, den die Schrift des Spiels hinter dem Text hat. Schalte ihn aus, um den Schatten zu entfernen. Das hilft bei einer Schrift, die verschwommen oder verschmiert aussieht."
L["FONT_SLUG"] = "Schärferer Text (Slug)"
L["FONT_SLUG_DESCRIPTION"] =
	"Zeichnet den Text mit Blizzards neuerem Slug-Renderer, für schärfere Buchstaben in jeder Größe. Slug kann keine dicke Kontur und keinen Schatten zeichnen, daher wird Text mit einem von beiden wie gewohnt gezeichnet."
L["FONT_RESET_BUTTON"] = "Schrift zurücksetzen"
L["FONT_RESET_DESCRIPTION"] = "Setzt die Einstellungen dieser Schrift auf ihre Standardwerte zurück."

L["QUEST_SUFFIX_DUNGEON"] = "D"
L["QUEST_SUFFIX_RAID"] = "S"
L["QUEST_SUFFIX_PVP"] = "P"
L["QUEST_SUFFIX_ELITE"] = "E"

L["QUEST_TYPE_DUNGEON"] = "Dungeon"
L["QUEST_TYPE_RAID"] = "Schlachtzug"
L["QUEST_TYPE_ELITE"] = "Elite"
L["QUEST_TYPE_PVP"] = "PvP"

L["QUEST_LEVEL_LEGEND"] = "Buchstaben nach der Stufe: %s."

L["QUEST_LEVEL_LEGEND_ENTRY"] = "%s %s"
L["QUEST_ID"] = "Quest-ID %d"

L["QUEST_CHAIN_PROGRESS"] = "Questreihe (%d von %d)"
L["WOWHEAD_LINK_TOOLTIP"] = "Klicken für einen Wowhead-Link."
L["WOWHEAD_LINK_COPY"] = "Drücke Strg+C (Cmd+C auf dem Mac), um den Wowhead-Link zu kopieren."
L["EXPAND_ALL"] = "Alle ausklappen"
L["COLLAPSE_ALL"] = "Alle einklappen"
L["TRACK_ALL"] = "Alle verfolgen"
L["UNTRACK_ALL"] = "Keine verfolgen"
L["HIDE_MAP"] = "Karte verbergen"
L["ZONE_INFO_QUESTS"] = "Quests zum Annehmen"
L["ZONE_INFO_ITEMS"] = "Mitzubringen"
L["ZONE_INFO_BACK"] = "Zurück zur Quest"
L["ZONE_INFO_ASK"] = "Nach Teilen fragen"
L["ZONE_INFO_ASK_DESCRIPTION"] =
	"Schreibt die Quests hier, die Spieler teilen können, in dein Chatfenster, in Kanal 4 (Suche nach Gruppe), wenn du darin bist. Gesendet wird erst, wenn du Enter drückst."

L["ZONE_INFO_ASK_MESSAGE"] = "Kann jemand %s teilen?"

L["ZONE_INFO_GIVER"] = "Questgeber: %s"
L["ZONE_INFO_GIVER_PLACE"] = "%s in %s"
L["ZONE_INFO_SHAREABLE"] = "Teilbar"
L["ZONE_INFO_NOT_SHAREABLE"] = "Nicht teilbar"
L["ZONE_INFO_NEEDED_FOR"] = "Benötigt für"
L["ZONE_INFO_SHIFT_CLICK"] = "Umschalt-Klick"
L["ZONE_INFO_LINK_ITEM"] = "Im Chat verlinken"
L["ZONE_INFO_MENU_QUEST"] = "Diese Quest"
L["ZONE_INFO_MENU_HERE"] = "Wo du bist"
L["ZONE_INFO_MENU_LOG"] = "Deine Quests"
L["ZONE_INFO_MENU_AVAILABLE"] = "Die meisten Quests für dich"
L["ZONE_INFO_NO_QUESTS"] = "Keine Quests aus anderen Zonen für hier."
L["ZONE_INFO_NO_ITEMS"] = "Nichts zu kaufen oder mitzubringen."
L["ZONE_INFO_WORKING"] = "Quests werden gelesen..."
L["ZONE_INFO_NEEDS_QUESTIE"] = "Aktiviere Questie, um zu sehen, was es hier gibt."

L["TURN_IN_XP"] = "%s EP"
L["TURN_IN_SEPARATOR"] = " / "

L["TURN_IN_SUMMARY"] = "Abgabe: %s"
L["TURN_IN_TOOLTIP"] = "Bereit zur Abgabe"
L["RESIZE_TOOLTIP"] = "Ziehen, um die Größe des Questlogs zu ändern."

L["CHAT_SHARING_AFTER_COMBAT"] = "Teile %s, sobald der Kampf endet."

L["QUESTIE_CANNOT_SHOW"] =
	"Der Tracker von Questie kann %s nicht anzeigen, weil die Quest in der Datenbank von Questie fehlt."
L["QUESTIE_CANNOT_TRACK"] = "Questie kann diese Quest noch nicht verfolgen."
