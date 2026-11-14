local L = LibStub("AceLocale-3.0"):NewLocale("WideQuest", "frFR")
if not L then
	return
end

L["ADDON_TITLE"] = "Wide Quest Log Forever"
L["ADDON_SHORT_NAME"] = "WQL"

L["LIST_SEPARATOR"] = ", "
L["CHAT_OPTIONS_IN_COMBAT"] = "Par mesure de sécurité, l'interface des options ne peut pas être ouverte en combat."

L["ENABLE_WIDE_QUEST_LOG"] = "Activer le journal de quêtes large"
L["FEATURE_QUEST_LOG_DESCRIPTION"] =
	"Remplace le journal de quêtes de Blizzard par le journal large, avec la carte à côté. Prend effet après un rechargement."
L["FEATURE_QUEST_LOG_RELOAD_PENDING"] =
	"Activer le journal de quêtes large prend effet après un rechargement, proposé à la fermeture de l'interface des options."
L["RELOAD_PROMPT"] = "Wide Quest Log Forever change de journal de quêtes après un rechargement. Recharger maintenant ?"

L["TAB_QUEST_LOG_DESCRIPTION"] =
	"Remplace le journal de quêtes de Blizzard par un journal large : vos quêtes classées par zone, avec à côté les détails de la quête sélectionnée et sa carte."
L["QUEST_LOG_SORTING_HEADER"] = "Tri"
L["QUEST_LOG_SORTING_DESCRIPTION"] = "Choisissez l'ordre de vos zones et des quêtes en dessous."
L["QUEST_LOG_ROWS_HEADER"] = "Lignes de quêtes"
L["QUEST_LOG_ROWS_DESCRIPTION"] = "Choisissez ce qu'affiche chaque ligne."
L["TAB_WINDOW_MAP"] = "Fenêtre et carte"
L["QUEST_LOG_WINDOW_MAP_DESCRIPTION"] =
	"Adaptez la taille de la fenêtre et de la carte à votre écran, et choisissez leur comportement."
L["ZONE_ORDER"] = "Ordre des zones"
L["ZONE_ORDER_DESCRIPTION"] = "Change l'ordre des zones dans la liste des quêtes."
L["SORT_AVERAGE_LEVEL_HIGHEST_DEFAULT"] = "Niveau moyen, le plus haut d'abord (par défaut)"
L["SORT_AVERAGE_LEVEL_LOWEST"] = "Niveau moyen, le plus bas d'abord"
L["SORT_ALPHABETICAL"] = "Alphabétique"
L["CURRENT_ZONE_FIRST"] = "Afficher la zone actuelle en premier"
L["CURRENT_ZONE_FIRST_DESCRIPTION"] =
	"Place la zone où vous vous trouvez en haut de la liste, quel que soit l'ordre des zones."
L["ZONE_GAP"] = "Ajouter de l'espace au-dessus des noms de zone"
L["ZONE_GAP_DESCRIPTION"] =
	"Ajoute un peu d'espace au-dessus de chaque nom de zone. Pratique si vos quêtes sont réparties sur de nombreuses zones."
L["QUEST_ORDER"] = "Ordre des quêtes"
L["QUEST_ORDER_DESCRIPTION"] = "Change l'ordre des quêtes sous chaque zone."
L["SORT_LEVEL_HIGHEST_DEFAULT"] = "Niveau, le plus haut d'abord (par défaut)"
L["SORT_LEVEL_LOWEST"] = "Niveau, le plus bas d'abord"
L["COMPLETED_FIRST"] = "Afficher les quêtes terminées en premier"
L["COMPLETED_FIRST_DESCRIPTION"] = "Place en haut de leur zone les quêtes prêtes à être rendues."
L["SHOW_QUEST_LEVELS"] = "Afficher le niveau des quêtes"

L["SHOW_QUEST_LEVELS_DESCRIPTION"] =
	"Place le niveau et le type de chaque quête devant son nom dans la liste, comme %s pour une quête de donjon de niveau 40."
L["MARK_UNTRACKED"] = "Marquer les quêtes non suivies"

L["MARK_UNTRACKED_DESCRIPTION"] =
	"Les quêtes suivies perdent leur coche %s, et les quêtes non suivies ont un œil %s à la place. Pratique si vous suivez presque tout."
L["CLOSE_IN_COMBAT"] = "Fermer en début de combat"
L["CLOSE_IN_COMBAT_DESCRIPTION"] =
	"Ferme le journal de quêtes quand un combat commence, pour qu'il ne cache jamais l'action."
L["SHOW_OBJECTIVE_AREAS"] = "Afficher les zones d'objectifs"
L["SHOW_OBJECTIVE_AREAS_DESCRIPTION"] =
	"Colore sur la carte à côté du journal de quêtes les endroits où se trouvent les monstres et les objets de chaque objectif, avec une seule icône par zone au lieu d'une sur chaque point d'apparition."
L["NEEDS_QUESTIE_HINT"] = "Activez Questie pour utiliser cette option."
L["SHOW_ZONE_INFO"] = "Afficher les infos de zone"
L["SHOW_ZONE_INFO_DESCRIPTION"] =
	"Sous la carte, les quêtes d'autres zones que vous pourriez prendre pour la zone affichée, et les objets que demandent les quêtes de cette zone. La carte rétrécit à la moitié de la hauteur de la fenêtre pour faire de la place."
L["WINDOW_SCALE"] = "Échelle du journal de quêtes"
L["WINDOW_SCALE_DESCRIPTION"] =
	"Agrandit ou réduit le journal de quêtes. La carte à côté grandit et rétrécit avec lui."
L["MAP_SCALE"] = "Échelle de la carte"
L["MAP_SCALE_DESCRIPTION"] =
	"Agrandit ou réduit la carte à côté du journal de quêtes, en plus de l'échelle du journal de quêtes."
L["RESET_WINDOW_BUTTON"] = "Réinitialiser la fenêtre"
L["RESET_WINDOW_MOVE_DESCRIPTION"] =
	"Remet la hauteur et l'échelle du journal de quêtes, ainsi que l'échelle de la carte, à leurs valeurs par défaut, et ramène la fenêtre à son emplacement de départ."
L["RESET_WINDOW_MOVE_CONFIRM"] =
	"Réinitialiser la hauteur et l'échelle du journal de quêtes, l'échelle de la carte et l'emplacement de la fenêtre à l'écran ?"

L["FONT_HEADER"] = "Police"
L["FONT_LIST_DESCRIPTION"] = "La police des noms de zone et des quêtes dans la liste des quêtes."
L["FONT_DETAILS_DESCRIPTION"] =
	"La police des détails de la quête : le titre, les intertitres et le texte de la quête."
L["FONT_WINDOW_DESCRIPTION"] = "La police du titre de la fenêtre, du nombre de quêtes et de la ligne À rendre."
L["FONT_FACE"] = "Police"
L["FONT_FACE_DESCRIPTION"] =
	"Le style des caractères. Par défaut du jeu suit la police du jeu, et tout add-on qui la modifie. Les polices ajoutées via SharedMedia sont aussi proposées."
L["FONT_GAME_DEFAULT"] = "Par défaut du jeu"
L["FONT_GAME_STANDARD"] = "Texte standard"
L["FONT_GAME_NAMES"] = "Noms des personnages"
L["FONT_GAME_DAMAGE"] = "Chiffres de dégâts"
L["FONT_SIZE"] = "Taille"
L["FONT_SIZE_DESCRIPTION"] =
	"Agrandit ou réduit le texte, en points par rapport à la taille du jeu. 0 conserve la taille du jeu."
L["FONT_OUTLINE"] = "Contour"
L["FONT_OUTLINE_DESCRIPTION"] =
	"Un contour noir autour de chaque lettre. Par défaut du jeu garde le contour qu'a la police du jeu, quel qu'il soit, et Aucun le retire."
L["FONT_OUTLINE_DEFAULT"] = "Par défaut du jeu"
L["FONT_OUTLINE_NONE"] = "Aucun"
L["FONT_OUTLINE_THIN"] = "Fin"
L["FONT_OUTLINE_THICK"] = "Épais"
L["FONT_SHADOW"] = "Ombre du texte"
L["FONT_SHADOW_DESCRIPTION"] =
	"Garde l'ombre portée que la police du jeu a derrière le texte. Désactivez cette option pour retirer l'ombre, ce qui aide une police qui paraît floue ou baveuse."
L["FONT_SLUG"] = "Texte plus net (Slug)"
L["FONT_SLUG_DESCRIPTION"] =
	"Dessine le texte avec le nouveau moteur de rendu Slug de Blizzard, pour des lettres plus nettes à toutes les tailles. Slug ne peut pas dessiner de contour épais ni d'ombre, donc le texte qui a l'un ou l'autre est dessiné comme d'habitude."
L["FONT_RESET_BUTTON"] = "Réinitialiser la police"
L["FONT_RESET_DESCRIPTION"] = "Remet les paramètres de cette police à leurs valeurs par défaut."

L["QUEST_SUFFIX_DUNGEON"] = "D"
L["QUEST_SUFFIX_RAID"] = "R"
L["QUEST_SUFFIX_PVP"] = "J"
L["QUEST_SUFFIX_ELITE"] = "E"

L["QUEST_TYPE_DUNGEON"] = "donjon"
L["QUEST_TYPE_RAID"] = "raid"
L["QUEST_TYPE_ELITE"] = "élite"
L["QUEST_TYPE_PVP"] = "JcJ"

L["QUEST_LEVEL_LEGEND"] = "Lettres après le niveau : %s."

L["QUEST_LEVEL_LEGEND_ENTRY"] = "%s %s"
L["QUEST_ID"] = "ID de quête %d"

L["QUEST_CHAIN_PROGRESS"] = "Suite de quêtes (%d sur %d)"
L["WOWHEAD_LINK_TOOLTIP"] = "Cliquez pour obtenir un lien Wowhead."
L["WOWHEAD_LINK_COPY"] = "Appuyez sur Ctrl+C (Cmd+C sur Mac) pour copier le lien Wowhead."
L["EXPAND_ALL"] = "Tout développer"
L["COLLAPSE_ALL"] = "Tout réduire"
L["TRACK_ALL"] = "Tout suivre"
L["UNTRACK_ALL"] = "Ne rien suivre"
L["HIDE_MAP"] = "Masquer la carte"
L["ZONE_INFO_QUESTS"] = "Quêtes à prendre"
L["ZONE_INFO_ITEMS"] = "À apporter"
L["ZONE_INFO_BACK"] = "Retour à la quête"
L["ZONE_INFO_ASK"] = "Demander un partage"
L["ZONE_INFO_ASK_DESCRIPTION"] =
	"Écrit dans votre fenêtre de discussion les quêtes d'ici que les joueurs peuvent partager, sur le canal 4 (Recherche de groupe) si vous y êtes. Rien n'est envoyé avant que vous appuyiez sur Entrée."

L["ZONE_INFO_ASK_MESSAGE"] = "Quelqu'un peut partager %s ?"

L["ZONE_INFO_GIVER"] = "Donnée par %s"
L["ZONE_INFO_GIVER_PLACE"] = "%s (%s)"
L["ZONE_INFO_SHAREABLE"] = "Partageable"
L["ZONE_INFO_NOT_SHAREABLE"] = "Non partageable"
L["ZONE_INFO_NEEDED_FOR"] = "Requis pour"
L["ZONE_INFO_SHIFT_CLICK"] = "Maj-clic"
L["ZONE_INFO_LINK_ITEM"] = "Lier dans la discussion"
L["ZONE_INFO_MENU_QUEST"] = "Cette quête"
L["ZONE_INFO_MENU_HERE"] = "Où vous êtes"
L["ZONE_INFO_MENU_LOG"] = "Vos quêtes"
L["ZONE_INFO_MENU_AVAILABLE"] = "Le plus de quêtes pour vous"
L["ZONE_INFO_NO_QUESTS"] = "Aucune quête d'une autre zone à prendre pour ici."
L["ZONE_INFO_NO_ITEMS"] = "Rien à acheter ni à apporter."
L["ZONE_INFO_WORKING"] = "Lecture des quêtes..."
L["ZONE_INFO_NEEDS_QUESTIE"] = "Activez Questie pour voir ce qu'il y a ici."

L["TURN_IN_XP"] = "%s XP"
L["TURN_IN_SEPARATOR"] = " / "

L["TURN_IN_SUMMARY"] = "À rendre : %s"
L["TURN_IN_TOOLTIP"] = "Prête à être rendue"
L["RESIZE_TOOLTIP"] = "Faites glisser pour redimensionner le journal de quêtes."

L["CHAT_SHARING_AFTER_COMBAT"] = "Partage de %s à la fin du combat."

L["QUESTIE_CANNOT_SHOW"] =
	"Le suivi de Questie ne peut pas afficher %s, car la quête est absente de la base de données de Questie."
L["QUESTIE_CANNOT_TRACK"] = "Questie ne peut pas encore suivre cette quête."
