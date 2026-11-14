local L = LibStub("AceLocale-3.0"):NewLocale("WideQuest", "itIT")
if not L then
	return
end

L["ADDON_TITLE"] = "Wide Quest Log Forever"
L["ADDON_SHORT_NAME"] = "WQL"

L["LIST_SEPARATOR"] = ", "
L["CHAT_OPTIONS_IN_COMBAT"] =
	"Per precauzione, l'interfaccia delle opzioni non può essere aperta durante il combattimento."

L["ENABLE_WIDE_QUEST_LOG"] = "Attiva registro delle missioni largo"
L["FEATURE_QUEST_LOG_DESCRIPTION"] =
	"Sostituisce il registro delle missioni di Blizzard con quello largo, con la mappa accanto. Ha effetto dopo un ricaricamento."
L["FEATURE_QUEST_LOG_RELOAD_PENDING"] =
	"Attiva registro delle missioni largo ha effetto dopo un ricaricamento, che ti verrà proposto alla chiusura dell'interfaccia delle opzioni."
L["RELOAD_PROMPT"] = "Wide Quest Log Forever cambia registro delle missioni dopo un ricaricamento. Ricaricare ora?"

L["TAB_QUEST_LOG_DESCRIPTION"] =
	"Sostituisce il registro delle missioni di Blizzard con uno largo: le tue missioni elencate per zona, con accanto i dettagli della missione selezionata e la sua mappa."
L["QUEST_LOG_SORTING_HEADER"] = "Ordinamento"
L["QUEST_LOG_SORTING_DESCRIPTION"] = "Scegli l'ordine delle tue zone e delle missioni sotto di esse."
L["QUEST_LOG_ROWS_HEADER"] = "Righe delle missioni"
L["QUEST_LOG_ROWS_DESCRIPTION"] = "Scegli cosa mostra ogni riga."
L["TAB_WINDOW_MAP"] = "Finestra e mappa"
L["QUEST_LOG_WINDOW_MAP_DESCRIPTION"] =
	"Adatta le dimensioni della finestra e della mappa al tuo schermo e scegli come si comportano."
L["ZONE_ORDER"] = "Ordine delle zone"
L["ZONE_ORDER_DESCRIPTION"] = "Cambia l'ordine delle zone nell'elenco delle missioni."
L["SORT_AVERAGE_LEVEL_HIGHEST_DEFAULT"] = "Livello medio, prima il più alto (predefinito)"
L["SORT_AVERAGE_LEVEL_LOWEST"] = "Livello medio, prima il più basso"
L["SORT_ALPHABETICAL"] = "Alfabetico"
L["CURRENT_ZONE_FIRST"] = "Mostra prima la zona attuale"
L["CURRENT_ZONE_FIRST_DESCRIPTION"] =
	"Mette in cima all'elenco la zona in cui ti trovi, qualunque sia l'ordine delle zone."
L["ZONE_GAP"] = "Aggiungi spazio sopra i nomi delle zone"
L["ZONE_GAP_DESCRIPTION"] =
	"Aggiunge un po' di spazio sopra ogni nome di zona. Utile se le tue missioni sono sparse in molte zone."
L["QUEST_ORDER"] = "Ordine delle missioni"
L["QUEST_ORDER_DESCRIPTION"] = "Cambia l'ordine delle missioni sotto ogni zona."
L["SORT_LEVEL_HIGHEST_DEFAULT"] = "Livello, prima il più alto (predefinito)"
L["SORT_LEVEL_LOWEST"] = "Livello, prima il più basso"
L["COMPLETED_FIRST"] = "Mostra prima le missioni completate"
L["COMPLETED_FIRST_DESCRIPTION"] = "Sposta in cima alla loro zona le missioni pronte da consegnare."
L["SHOW_QUEST_LEVELS"] = "Mostra i livelli delle missioni"

L["SHOW_QUEST_LEVELS_DESCRIPTION"] =
	"Mette il livello e il tipo di ogni missione davanti al suo nome nell'elenco, come %s per una missione da spedizione di livello 40."
L["MARK_UNTRACKED"] = "Segna le missioni non seguite"

L["MARK_UNTRACKED_DESCRIPTION"] =
	"Le missioni seguite perdono la spunta %s e quelle non seguite hanno invece un occhio %s. Utile se segui quasi tutto."
L["CLOSE_IN_COMBAT"] = "Chiudi all'inizio del combattimento"
L["CLOSE_IN_COMBAT_DESCRIPTION"] =
	"Chiude il registro delle missioni quando inizia un combattimento, così non copre mai l'azione."
L["SHOW_OBJECTIVE_AREAS"] = "Mostra le aree degli obiettivi"
L["SHOW_OBJECTIVE_AREAS_DESCRIPTION"] =
	"Ombreggia sulla mappa accanto al registro delle missioni i punti in cui si trovano i nemici e gli oggetti di ogni obiettivo, con un'icona per area invece di una su ogni punto di comparsa."
L["NEEDS_QUESTIE_HINT"] = "Attiva Questie per usare questa opzione."
L["SHOW_ZONE_INFO"] = "Mostra info zona"
L["SHOW_ZONE_INFO_DESCRIPTION"] =
	"Sotto la mappa, le missioni di altre zone che potresti prendere per la zona mostrata, e gli oggetti che chiedono le missioni di quella zona. La mappa si riduce a metà dell'altezza della finestra per fare spazio."
L["WINDOW_SCALE"] = "Scala del registro delle missioni"
L["WINDOW_SCALE_DESCRIPTION"] =
	"Ingrandisce o rimpicciolisce il registro delle missioni. La mappa accanto cresce e si riduce insieme a lui."
L["MAP_SCALE"] = "Scala della mappa"
L["MAP_SCALE_DESCRIPTION"] =
	"Ingrandisce o rimpicciolisce la mappa accanto al registro delle missioni, in aggiunta alla scala del registro delle missioni."
L["RESET_WINDOW_BUTTON"] = "Ripristina finestra"
L["RESET_WINDOW_MOVE_DESCRIPTION"] =
	"Riporta l'altezza e la scala del registro delle missioni, e la scala della mappa, ai valori predefiniti, e riporta la finestra nella sua posizione iniziale."
L["RESET_WINDOW_MOVE_CONFIRM"] =
	"Ripristinare l'altezza e la scala del registro delle missioni, la scala della mappa e la posizione della finestra sullo schermo?"

L["FONT_HEADER"] = "Carattere"
L["FONT_LIST_DESCRIPTION"] = "Il carattere dei nomi delle zone e delle missioni nell'elenco delle missioni."
L["FONT_DETAILS_DESCRIPTION"] =
	"Il carattere dei dettagli della missione: il titolo, le intestazioni e il testo della missione."
L["FONT_WINDOW_DESCRIPTION"] = "Il carattere del titolo della finestra, del numero di missioni e della riga Consegna."
L["FONT_FACE"] = "Tipo di carattere"
L["FONT_FACE_DESCRIPTION"] =
	"Il tipo di carattere. Predefinito del gioco segue il carattere del gioco e qualsiasi add-on che lo cambi. Sono elencati anche i caratteri aggiunti tramite SharedMedia."
L["FONT_GAME_DEFAULT"] = "Predefinito del gioco"
L["FONT_GAME_STANDARD"] = "Testo standard"
L["FONT_GAME_NAMES"] = "Nomi dei personaggi"
L["FONT_GAME_DAMAGE"] = "Numeri dei danni"
L["FONT_SIZE"] = "Dimensione"
L["FONT_SIZE_DESCRIPTION"] =
	"Ingrandisce o rimpicciolisce il testo, in punti rispetto alla dimensione del gioco. 0 mantiene la dimensione del gioco."
L["FONT_OUTLINE"] = "Contorno"
L["FONT_OUTLINE_DESCRIPTION"] =
	"Un contorno nero attorno a ogni lettera. Predefinito del gioco mantiene il contorno che ha il carattere del gioco, e Nessuno lo toglie."
L["FONT_OUTLINE_DEFAULT"] = "Predefinito del gioco"
L["FONT_OUTLINE_NONE"] = "Nessuno"
L["FONT_OUTLINE_THIN"] = "Sottile"
L["FONT_OUTLINE_THICK"] = "Spesso"
L["FONT_SHADOW"] = "Ombra del testo"
L["FONT_SHADOW_DESCRIPTION"] =
	"Mantiene l'ombra proiettata che il carattere del gioco ha dietro il testo. Disattivala per togliere l'ombra, il che aiuta con un carattere che sembra sfocato o sbavato."
L["FONT_SLUG"] = "Testo più nitido (Slug)"
L["FONT_SLUG_DESCRIPTION"] =
	"Disegna il testo con il più recente renderer Slug di Blizzard, per lettere più nitide a qualsiasi dimensione. Slug non può disegnare un contorno spesso né un'ombra, quindi il testo che ha l'uno o l'altra viene disegnato nel modo consueto."
L["FONT_RESET_BUTTON"] = "Ripristina carattere"
L["FONT_RESET_DESCRIPTION"] = "Riporta le impostazioni di questo carattere ai valori predefiniti."

L["QUEST_SUFFIX_DUNGEON"] = "S"
L["QUEST_SUFFIX_RAID"] = "I"
L["QUEST_SUFFIX_PVP"] = "P"
L["QUEST_SUFFIX_ELITE"] = "E"

L["QUEST_TYPE_DUNGEON"] = "spedizione"
L["QUEST_TYPE_RAID"] = "incursione"
L["QUEST_TYPE_ELITE"] = "élite"
L["QUEST_TYPE_PVP"] = "PvP"

L["QUEST_LEVEL_LEGEND"] = "Lettere dopo il livello: %s."

L["QUEST_LEVEL_LEGEND_ENTRY"] = "%s %s"
L["QUEST_ID"] = "ID missione %d"

L["QUEST_CHAIN_PROGRESS"] = "Catena di missioni (%d di %d)"
L["WOWHEAD_LINK_TOOLTIP"] = "Clicca per ottenere un link a Wowhead."
L["WOWHEAD_LINK_COPY"] = "Premi Ctrl+C (Cmd+C su Mac) per copiare il link a Wowhead."
L["EXPAND_ALL"] = "Espandi tutto"
L["COLLAPSE_ALL"] = "Comprimi tutto"
L["TRACK_ALL"] = "Segui tutte"
L["UNTRACK_ALL"] = "Non seguire nessuna"
L["HIDE_MAP"] = "Nascondi mappa"
L["ZONE_INFO_QUESTS"] = "Missioni da prendere"
L["ZONE_INFO_ITEMS"] = "Cose da portare"
L["ZONE_INFO_BACK"] = "Torna alla missione"
L["ZONE_INFO_ASK"] = "Chiedi condivisioni"
L["ZONE_INFO_ASK_DESCRIPTION"] =
	"Scrive nella chat le missioni di qui che i giocatori possono condividere, nel canale 4 (Cerca gruppo) se ci sei. Non viene inviato nulla finché non premi Invio."

L["ZONE_INFO_ASK_MESSAGE"] = "Qualcuno può condividere %s?"

L["ZONE_INFO_GIVER"] = "Assegnata da %s"
L["ZONE_INFO_GIVER_PLACE"] = "%s (%s)"
L["ZONE_INFO_SHAREABLE"] = "Condivisibile"
L["ZONE_INFO_NOT_SHAREABLE"] = "Non condivisibile"
L["ZONE_INFO_NEEDED_FOR"] = "Serve per"
L["ZONE_INFO_SHIFT_CLICK"] = "Maiusc-clic"
L["ZONE_INFO_LINK_ITEM"] = "Collega in chat"
L["ZONE_INFO_MENU_QUEST"] = "Questa missione"
L["ZONE_INFO_MENU_HERE"] = "Dove sei"
L["ZONE_INFO_MENU_LOG"] = "Le tue missioni"
L["ZONE_INFO_MENU_AVAILABLE"] = "Più missioni per te"
L["ZONE_INFO_NO_QUESTS"] = "Nessuna missione di altre zone da prendere per qui."
L["ZONE_INFO_NO_ITEMS"] = "Niente da comprare o portare."
L["ZONE_INFO_WORKING"] = "Lettura delle missioni..."
L["ZONE_INFO_NEEDS_QUESTIE"] = "Attiva Questie per vedere cosa c'è qui."

L["TURN_IN_XP"] = "%s PE"
L["TURN_IN_SEPARATOR"] = " / "

L["TURN_IN_SUMMARY"] = "Consegna: %s"
L["TURN_IN_TOOLTIP"] = "Pronta da consegnare"
L["RESIZE_TOOLTIP"] = "Trascina per ridimensionare il registro delle missioni."

L["CHAT_SHARING_AFTER_COMBAT"] = "Condivisione di %s alla fine del combattimento."

L["QUESTIE_CANNOT_SHOW"] =
	"Il tracker di Questie non può mostrare %s perché la missione manca dal database di Questie."
L["QUESTIE_CANNOT_TRACK"] = "Questie non può ancora seguire questa missione."
