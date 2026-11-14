local L = LibStub("AceLocale-3.0"):NewLocale("WideQuest", "esMX")
if not L then
	return
end

L["ADDON_TITLE"] = "Wide Quest Log Forever"
L["ADDON_SHORT_NAME"] = "WQL"

L["LIST_SEPARATOR"] = ", "
L["CHAT_OPTIONS_IN_COMBAT"] = "Por seguridad, la interfaz de opciones no se puede abrir durante el combate."

L["ENABLE_WIDE_QUEST_LOG"] = "Activar registro de misiones ancho"
L["FEATURE_QUEST_LOG_DESCRIPTION"] =
	"Cambia el registro de misiones de Blizzard por el ancho, con el mapa al lado. Se aplica después de recargar."
L["FEATURE_QUEST_LOG_RELOAD_PENDING"] =
	"Activar registro de misiones ancho se aplica después de recargar, algo que se te ofrecerá al cerrar la interfaz de opciones."
L["RELOAD_PROMPT"] = "Wide Quest Log Forever cambia de registro de misiones después de recargar. ¿Recargar ahora?"

L["TAB_QUEST_LOG_DESCRIPTION"] =
	"Reemplaza el registro de misiones de Blizzard por uno ancho: tus misiones agrupadas por zona, con los detalles de la misión seleccionada y su mapa al lado."
L["QUEST_LOG_SORTING_HEADER"] = "Orden"
L["QUEST_LOG_SORTING_DESCRIPTION"] = "Elige el orden de tus zonas y de las misiones que hay debajo."
L["QUEST_LOG_ROWS_HEADER"] = "Filas de misiones"
L["QUEST_LOG_ROWS_DESCRIPTION"] = "Elige qué muestra cada fila."
L["TAB_WINDOW_MAP"] = "Ventana y mapa"
L["QUEST_LOG_WINDOW_MAP_DESCRIPTION"] =
	"Ajusta el tamaño de la ventana y del mapa a tu pantalla, y elige cómo se comportan."
L["ZONE_ORDER"] = "Orden de zonas"
L["ZONE_ORDER_DESCRIPTION"] = "Cambia el orden de las zonas en la lista de misiones."
L["SORT_AVERAGE_LEVEL_HIGHEST_DEFAULT"] = "Nivel promedio, el más alto primero (predeterminado)"
L["SORT_AVERAGE_LEVEL_LOWEST"] = "Nivel promedio, el más bajo primero"
L["SORT_ALPHABETICAL"] = "Alfabético"
L["CURRENT_ZONE_FIRST"] = "Mostrar primero la zona actual"
L["CURRENT_ZONE_FIRST_DESCRIPTION"] =
	"Coloca la zona en la que estás al principio de la lista, sin importar el orden de zonas."
L["ZONE_GAP"] = "Agregar espacio sobre los nombres de zona"
L["ZONE_GAP_DESCRIPTION"] =
	"Agrega un poco de espacio sobre cada nombre de zona. Útil si tus misiones están repartidas en muchas zonas."
L["QUEST_ORDER"] = "Orden de misiones"
L["QUEST_ORDER_DESCRIPTION"] = "Cambia el orden de las misiones dentro de cada zona."
L["SORT_LEVEL_HIGHEST_DEFAULT"] = "Nivel, el más alto primero (predeterminado)"
L["SORT_LEVEL_LOWEST"] = "Nivel, el más bajo primero"
L["COMPLETED_FIRST"] = "Mostrar primero las misiones completadas"
L["COMPLETED_FIRST_DESCRIPTION"] = "Sube al principio de su zona las misiones que ya puedes entregar."
L["SHOW_QUEST_LEVELS"] = "Mostrar niveles de misión"

L["SHOW_QUEST_LEVELS_DESCRIPTION"] =
	"Pone el nivel y el tipo de cada misión antes de su nombre en la lista, como %s para una misión de calabozo de nivel 40."
L["MARK_UNTRACKED"] = "Marcar misiones sin seguir"

L["MARK_UNTRACKED_DESCRIPTION"] =
	"Las misiones seguidas pierden su marca de verificación %s y las misiones sin seguir llevan un ojo %s en su lugar. Útil si sigues casi todo."
L["CLOSE_IN_COMBAT"] = "Cerrar al entrar en combate"
L["CLOSE_IN_COMBAT_DESCRIPTION"] =
	"Cierra el registro de misiones cuando empieza un combate, para que nunca tape la acción."
L["SHOW_OBJECTIVE_AREAS"] = "Mostrar áreas de objetivos"
L["SHOW_OBJECTIVE_AREAS_DESCRIPTION"] =
	"Sombrea en el mapa junto al registro de misiones dónde se encuentran los enemigos y objetos de cada objetivo, con un ícono en cada área en vez de uno en cada punto de aparición."
L["NEEDS_QUESTIE_HINT"] = "Activa Questie para usar esto."
L["SHOW_ZONE_INFO"] = "Mostrar info de la zona"
L["SHOW_ZONE_INFO_DESCRIPTION"] =
	"Bajo el mapa, las misiones de otras zonas que podrías recoger para la zona que muestra, y los objetos que piden las misiones de esa zona. El mapa se reduce a la mitad de la altura de la ventana para dejar sitio."
L["WINDOW_SCALE"] = "Escala del registro de misiones"
L["WINDOW_SCALE_DESCRIPTION"] =
	"Hace el registro de misiones más grande o más pequeño. El mapa de al lado crece y se encoge con él."
L["MAP_SCALE"] = "Escala del mapa"
L["MAP_SCALE_DESCRIPTION"] =
	"Hace el mapa junto al registro de misiones más grande o más pequeño, además de la escala del registro de misiones."
L["RESET_WINDOW_BUTTON"] = "Restablecer ventana"
L["RESET_WINDOW_MOVE_DESCRIPTION"] =
	"Regresa la altura y la escala del registro de misiones, y la escala del mapa, a sus valores predeterminados, y regresa la ventana a su lugar inicial."
L["RESET_WINDOW_MOVE_CONFIRM"] =
	"¿Restablecer la altura y la escala del registro de misiones, la escala del mapa y el lugar de la ventana en la pantalla?"

L["FONT_HEADER"] = "Fuente"
L["FONT_LIST_DESCRIPTION"] = "La fuente de los nombres de zona y de las misiones en la lista de misiones."
L["FONT_DETAILS_DESCRIPTION"] =
	"La fuente de los detalles de la misión: el título, los encabezados y el texto de la misión."
L["FONT_WINDOW_DESCRIPTION"] = "La fuente del título de la ventana, el número de misiones y la línea de Entrega."
L["FONT_FACE"] = "Fuente"
L["FONT_FACE_DESCRIPTION"] =
	"El tipo de letra. Predeterminada del juego sigue la fuente del juego y cualquier accesorio que la cambie. También aparecen las fuentes agregadas con SharedMedia."
L["FONT_GAME_DEFAULT"] = "Predeterminada del juego"
L["FONT_GAME_STANDARD"] = "Texto estándar"
L["FONT_GAME_NAMES"] = "Nombres de personajes"
L["FONT_GAME_DAMAGE"] = "Números de daño"
L["FONT_SIZE"] = "Tamaño"
L["FONT_SIZE_DESCRIPTION"] =
	"Hace el texto más grande o más pequeño, en puntos respecto al tamaño del juego. 0 mantiene el tamaño del juego."
L["FONT_OUTLINE"] = "Contorno"
L["FONT_OUTLINE_DESCRIPTION"] =
	"Un contorno negro alrededor de cada letra. Predeterminado del juego mantiene el contorno que tenga la fuente del juego, y Ninguno lo quita."
L["FONT_OUTLINE_DEFAULT"] = "Predeterminado del juego"
L["FONT_OUTLINE_NONE"] = "Ninguno"
L["FONT_OUTLINE_THIN"] = "Delgado"
L["FONT_OUTLINE_THICK"] = "Grueso"
L["FONT_SHADOW"] = "Sombra del texto"
L["FONT_SHADOW_DESCRIPTION"] =
	"Mantiene la sombra que la fuente del juego proyecta detrás del texto. Desactívala para quitar la sombra, lo que ayuda con una fuente que se ve borrosa o corrida."
L["FONT_SLUG"] = "Texto más nítido (Slug)"
L["FONT_SLUG_DESCRIPTION"] =
	"Dibuja el texto con Slug, el renderizador más reciente de Blizzard, para letras más nítidas en cualquier tamaño. Slug no puede dibujar un contorno grueso ni una sombra, así que el texto con cualquiera de los dos se dibuja de la forma habitual."
L["FONT_RESET_BUTTON"] = "Restablecer fuente"
L["FONT_RESET_DESCRIPTION"] = "Regresa la configuración de esta fuente a sus valores predeterminados."

L["QUEST_SUFFIX_DUNGEON"] = "C"
L["QUEST_SUFFIX_RAID"] = "B"
L["QUEST_SUFFIX_PVP"] = "J"
L["QUEST_SUFFIX_ELITE"] = "E"

L["QUEST_TYPE_DUNGEON"] = "calabozo"
L["QUEST_TYPE_RAID"] = "banda"
L["QUEST_TYPE_ELITE"] = "élite"
L["QUEST_TYPE_PVP"] = "JcJ"

L["QUEST_LEVEL_LEGEND"] = "Letras después del nivel: %s."

L["QUEST_LEVEL_LEGEND_ENTRY"] = "%s %s"
L["QUEST_ID"] = "ID de misión %d"

L["QUEST_CHAIN_PROGRESS"] = "Cadena de misiones (%d de %d)"
L["WOWHEAD_LINK_TOOLTIP"] = "Haz clic para obtener un enlace de Wowhead."
L["WOWHEAD_LINK_COPY"] = "Presiona Ctrl+C (Cmd+C en una Mac) para copiar el enlace de Wowhead."
L["EXPAND_ALL"] = "Expandir todo"
L["COLLAPSE_ALL"] = "Contraer todo"
L["TRACK_ALL"] = "Seguir todas"
L["UNTRACK_ALL"] = "Dejar de seguir todas"
L["HIDE_MAP"] = "Ocultar mapa"
L["ZONE_INFO_QUESTS"] = "Misiones por recoger"
L["ZONE_INFO_ITEMS"] = "Cosas que llevar"
L["ZONE_INFO_BACK"] = "Volver a la misión"
L["ZONE_INFO_ASK"] = "Pedir que compartan"
L["ZONE_INFO_ASK_DESCRIPTION"] =
	"Escribe en tu chat las misiones de aquí que se pueden compartir, en el canal 4 (Buscar grupo) si estás en él. No se envía nada hasta que presiones Enter."

L["ZONE_INFO_ASK_MESSAGE"] = "¿Alguien puede compartir %s?"

L["ZONE_INFO_GIVER"] = "La ofrece %s"
L["ZONE_INFO_GIVER_PLACE"] = "%s en %s"
L["ZONE_INFO_SHAREABLE"] = "Compartible"
L["ZONE_INFO_NOT_SHAREABLE"] = "No compartible"
L["ZONE_INFO_NEEDED_FOR"] = "Necesario para"
L["ZONE_INFO_SHIFT_CLICK"] = "Shift-clic"
L["ZONE_INFO_LINK_ITEM"] = "Enlazar en el chat"
L["ZONE_INFO_MENU_QUEST"] = "Esta misión"
L["ZONE_INFO_MENU_HERE"] = "Donde estás"
L["ZONE_INFO_MENU_LOG"] = "Tus misiones"
L["ZONE_INFO_MENU_AVAILABLE"] = "Más misiones para ti"
L["ZONE_INFO_NO_QUESTS"] = "No hay misiones de otras zonas que recoger para aquí."
L["ZONE_INFO_NO_ITEMS"] = "Nada que comprar ni llevar."
L["ZONE_INFO_WORKING"] = "Leyendo misiones..."
L["ZONE_INFO_NEEDS_QUESTIE"] = "Activa Questie para ver qué hay aquí."

L["TURN_IN_XP"] = "%s EXP"
L["TURN_IN_SEPARATOR"] = " / "

L["TURN_IN_SUMMARY"] = "Entrega: %s"
L["TURN_IN_TOOLTIP"] = "Lista para entregar"
L["RESIZE_TOOLTIP"] = "Arrastra para cambiar el tamaño del registro de misiones."

L["CHAT_SHARING_AFTER_COMBAT"] = "Compartiendo %s cuando termine el combate."

L["QUESTIE_CANNOT_SHOW"] =
	"El seguimiento de Questie no puede mostrar %s porque la misión no está en la base de datos de Questie."
L["QUESTIE_CANNOT_TRACK"] = "Questie todavía no puede seguir esta misión."
