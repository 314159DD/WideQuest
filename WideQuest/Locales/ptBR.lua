local L = LibStub("AceLocale-3.0"):NewLocale("WideQuest", "ptBR")
if not L then
	return
end

L["ADDON_TITLE"] = "Wide Quest Log Forever"
L["ADDON_SHORT_NAME"] = "WQL"

L["LIST_SEPARATOR"] = ", "
L["CHAT_OPTIONS_IN_COMBAT"] = "Por precaução, a interface de opções não pode ser aberta durante o combate."

L["ENABLE_WIDE_QUEST_LOG"] = "Ativar registro de missões largo"
L["FEATURE_QUEST_LOG_DESCRIPTION"] =
	"Troca o registro de missões da Blizzard pelo largo, com o mapa ao lado. Entra em vigor após recarregar."
L["FEATURE_QUEST_LOG_RELOAD_PENDING"] =
	"Ativar registro de missões largo entra em vigor após recarregar, o que será oferecido quando você fechar a interface de opções."
L["RELOAD_PROMPT"] = "O Wide Quest Log Forever troca de registro de missões após recarregar. Recarregar agora?"

L["TAB_QUEST_LOG_DESCRIPTION"] =
	"Substitui o registro de missões da Blizzard por um largo: suas missões listadas por zona, com os detalhes da missão selecionada e o mapa dela ao lado."
L["QUEST_LOG_SORTING_HEADER"] = "Ordenação"
L["QUEST_LOG_SORTING_DESCRIPTION"] = "Escolha a ordem das suas zonas e das missões dentro delas."
L["QUEST_LOG_ROWS_HEADER"] = "Linhas de missões"
L["QUEST_LOG_ROWS_DESCRIPTION"] = "Escolha o que cada linha mostra."
L["TAB_WINDOW_MAP"] = "Janela e mapa"
L["QUEST_LOG_WINDOW_MAP_DESCRIPTION"] =
	"Ajuste o tamanho da janela e do mapa à sua tela e escolha como eles se comportam."
L["ZONE_ORDER"] = "Ordem das zonas"
L["ZONE_ORDER_DESCRIPTION"] = "Muda a ordem das zonas na lista de missões."
L["SORT_AVERAGE_LEVEL_HIGHEST_DEFAULT"] = "Nível médio, maior primeiro (padrão)"
L["SORT_AVERAGE_LEVEL_LOWEST"] = "Nível médio, menor primeiro"
L["SORT_ALPHABETICAL"] = "Alfabética"
L["CURRENT_ZONE_FIRST"] = "Mostrar a zona atual primeiro"
L["CURRENT_ZONE_FIRST_DESCRIPTION"] =
	"Coloca a zona onde você está no topo da lista, seja qual for a ordem das zonas."
L["ZONE_GAP"] = "Adicionar espaço acima dos nomes de zona"
L["ZONE_GAP_DESCRIPTION"] =
	"Adiciona um pouco de espaço acima de cada nome de zona. Útil se suas missões estão espalhadas por muitas zonas."
L["QUEST_ORDER"] = "Ordem das missões"
L["QUEST_ORDER_DESCRIPTION"] = "Muda a ordem das missões dentro de cada zona."
L["SORT_LEVEL_HIGHEST_DEFAULT"] = "Nível, maior primeiro (padrão)"
L["SORT_LEVEL_LOWEST"] = "Nível, menor primeiro"
L["COMPLETED_FIRST"] = "Mostrar as missões concluídas primeiro"
L["COMPLETED_FIRST_DESCRIPTION"] = "Leva para o topo da zona as missões prontas para entregar."
L["SHOW_QUEST_LEVELS"] = "Mostrar níveis das missões"

L["SHOW_QUEST_LEVELS_DESCRIPTION"] =
	"Coloca o nível e o tipo de cada missão antes do nome dela na lista, como %s para uma missão de masmorra de nível 40."
L["MARK_UNTRACKED"] = "Marcar missões não acompanhadas"

L["MARK_UNTRACKED_DESCRIPTION"] =
	"Missões acompanhadas perdem a marca de seleção %s, e missões não acompanhadas ganham um olho %s no lugar. Útil se você acompanha quase tudo."
L["CLOSE_IN_COMBAT"] = "Fechar ao entrar em combate"
L["CLOSE_IN_COMBAT_DESCRIPTION"] =
	"Fecha o registro de missões quando uma luta começa, para que ele nunca cubra a ação."
L["SHOW_OBJECTIVE_AREAS"] = "Mostrar áreas dos objetivos"
L["SHOW_OBJECTIVE_AREAS_DESCRIPTION"] =
	"Sombreia no mapa ao lado do registro de missões onde ficam os inimigos e objetos de cada objetivo, com um ícone em cada área em vez de um em cada ponto de surgimento."
L["NEEDS_QUESTIE_HINT"] = "Ative o Questie para usar isto."
L["SHOW_ZONE_INFO"] = "Mostrar info da zona"
L["SHOW_ZONE_INFO_DESCRIPTION"] =
	"Abaixo do mapa, as missões de outras zonas que você poderia pegar para a zona mostrada, e os itens que as missões dessa zona pedem. O mapa encolhe para metade da altura da janela para abrir espaço."
L["WINDOW_SCALE"] = "Escala do registro de missões"
L["WINDOW_SCALE_DESCRIPTION"] =
	"Deixa o registro de missões maior ou menor. O mapa ao lado cresce e encolhe junto com ele."
L["MAP_SCALE"] = "Escala do mapa"
L["MAP_SCALE_DESCRIPTION"] =
	"Deixa o mapa ao lado do registro de missões maior ou menor, além da escala do registro de missões."
L["RESET_WINDOW_BUTTON"] = "Redefinir janela"
L["RESET_WINDOW_MOVE_DESCRIPTION"] =
	"Volta a altura e a escala do registro de missões, e a escala do mapa, aos valores padrão, e leva a janela de volta ao lugar inicial."
L["RESET_WINDOW_MOVE_CONFIRM"] =
	"Redefinir a altura e a escala do registro de missões, a escala do mapa e o lugar da janela na tela?"

L["FONT_HEADER"] = "Fonte"
L["FONT_LIST_DESCRIPTION"] = "A fonte dos nomes das zonas e das missões na lista de missões."
L["FONT_DETAILS_DESCRIPTION"] = "A fonte dos detalhes da missão: o título, os cabeçalhos e o texto da missão."
L["FONT_WINDOW_DESCRIPTION"] = "A fonte do título da janela, da contagem de missões e da linha de Entrega."
L["FONT_FACE"] = "Fonte"
L["FONT_FACE_DESCRIPTION"] =
	"O tipo de letra. Padrão do jogo segue a fonte do jogo e qualquer add-on que a mude. Fontes adicionadas pelo SharedMedia também aparecem na lista."
L["FONT_GAME_DEFAULT"] = "Padrão do jogo"
L["FONT_GAME_STANDARD"] = "Texto padrão"
L["FONT_GAME_NAMES"] = "Nomes de personagens"
L["FONT_GAME_DAMAGE"] = "Números de dano"
L["FONT_SIZE"] = "Tamanho"
L["FONT_SIZE_DESCRIPTION"] =
	"Deixa o texto maior ou menor, em pontos a partir do tamanho do jogo. 0 mantém o tamanho do jogo."
L["FONT_OUTLINE"] = "Contorno"
L["FONT_OUTLINE_DESCRIPTION"] =
	"Um contorno preto em volta de cada letra. Padrão do jogo mantém o contorno que a fonte do jogo tiver, e Nenhum o remove."
L["FONT_OUTLINE_DEFAULT"] = "Padrão do jogo"
L["FONT_OUTLINE_NONE"] = "Nenhum"
L["FONT_OUTLINE_THIN"] = "Fino"
L["FONT_OUTLINE_THICK"] = "Grosso"
L["FONT_SHADOW"] = "Sombra do texto"
L["FONT_SHADOW_DESCRIPTION"] =
	"Mantém a sombra projetada que a fonte do jogo tem atrás do texto. Desative para remover a sombra, o que ajuda quando uma fonte parece borrada ou manchada."
L["FONT_SLUG"] = "Texto mais nítido (Slug)"
L["FONT_SLUG_DESCRIPTION"] =
	"Desenha o texto com o novo renderizador Slug da Blizzard, para letras mais nítidas em qualquer tamanho. O Slug não consegue desenhar contorno grosso nem sombra, então o texto com qualquer um dos dois é desenhado do jeito normal."
L["FONT_RESET_BUTTON"] = "Redefinir fonte"
L["FONT_RESET_DESCRIPTION"] = "Volta as configurações desta fonte aos valores padrão."

L["QUEST_SUFFIX_DUNGEON"] = "M"
L["QUEST_SUFFIX_RAID"] = "R"
L["QUEST_SUFFIX_PVP"] = "J"
L["QUEST_SUFFIX_ELITE"] = "E"

L["QUEST_TYPE_DUNGEON"] = "masmorra"
L["QUEST_TYPE_RAID"] = "raide"
L["QUEST_TYPE_ELITE"] = "elite"
L["QUEST_TYPE_PVP"] = "JxJ"

L["QUEST_LEVEL_LEGEND"] = "Letras após o nível: %s."

L["QUEST_LEVEL_LEGEND_ENTRY"] = "%s %s"
L["QUEST_ID"] = "ID da missão %d"

L["QUEST_CHAIN_PROGRESS"] = "Sequência de missões (%d de %d)"
L["WOWHEAD_LINK_TOOLTIP"] = "Clique para obter um link do Wowhead."
L["WOWHEAD_LINK_COPY"] = "Pressione Ctrl+C (Cmd+C no Mac) para copiar o link do Wowhead."
L["EXPAND_ALL"] = "Expandir tudo"
L["COLLAPSE_ALL"] = "Recolher tudo"
L["TRACK_ALL"] = "Acompanhar todas"
L["UNTRACK_ALL"] = "Não acompanhar nenhuma"
L["HIDE_MAP"] = "Ocultar mapa"
L["ZONE_INFO_QUESTS"] = "Missões para pegar"
L["ZONE_INFO_ITEMS"] = "Coisas para levar"
L["ZONE_INFO_BACK"] = "Voltar à missão"
L["ZONE_INFO_ASK"] = "Pedir compartilhamento"
L["ZONE_INFO_ASK_DESCRIPTION"] =
	"Escreve no seu chat as missões daqui que os jogadores podem compartilhar, no canal 4 (Procurando Grupo) se você estiver nele. Nada é enviado até você apertar Enter."

L["ZONE_INFO_ASK_MESSAGE"] = "Alguém pode compartilhar %s?"

L["ZONE_INFO_GIVER"] = "Dada por %s"
L["ZONE_INFO_GIVER_PLACE"] = "%s em %s"
L["ZONE_INFO_SHAREABLE"] = "Compartilhável"
L["ZONE_INFO_NOT_SHAREABLE"] = "Não compartilhável"
L["ZONE_INFO_NEEDED_FOR"] = "Necessário para"
L["ZONE_INFO_SHIFT_CLICK"] = "Shift-clique"
L["ZONE_INFO_LINK_ITEM"] = "Linkar no chat"
L["ZONE_INFO_MENU_QUEST"] = "Esta missão"
L["ZONE_INFO_MENU_HERE"] = "Onde você está"
L["ZONE_INFO_MENU_LOG"] = "Suas missões"
L["ZONE_INFO_MENU_AVAILABLE"] = "Mais missões para você"
L["ZONE_INFO_NO_QUESTS"] = "Nenhuma missão de outras zonas para pegar para aqui."
L["ZONE_INFO_NO_ITEMS"] = "Nada para comprar ou levar."
L["ZONE_INFO_WORKING"] = "Lendo missões..."
L["ZONE_INFO_NEEDS_QUESTIE"] = "Ative o Questie para ver o que há aqui."

L["TURN_IN_XP"] = "%s XP"
L["TURN_IN_SEPARATOR"] = " / "

L["TURN_IN_SUMMARY"] = "Entrega: %s"
L["TURN_IN_TOOLTIP"] = "Pronta para entregar"
L["RESIZE_TOOLTIP"] = "Arraste para redimensionar o registro de missões."

L["CHAT_SHARING_AFTER_COMBAT"] = "Compartilhando %s quando o combate terminar."

L["QUESTIE_CANNOT_SHOW"] =
	"O rastreador do Questie não consegue mostrar %s porque a missão não está no banco de dados do Questie."
L["QUESTIE_CANNOT_TRACK"] = "O Questie ainda não consegue acompanhar esta missão."
