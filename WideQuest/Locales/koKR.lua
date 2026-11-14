local L = LibStub("AceLocale-3.0"):NewLocale("WideQuest", "koKR")
if not L then
	return
end

L["ADDON_TITLE"] = "Wide Quest Log Forever"
L["ADDON_SHORT_NAME"] = "WQL"

L["LIST_SEPARATOR"] = ", "
L["CHAT_OPTIONS_IN_COMBAT"] = "안전을 위해 전투 중에는 설정 창을 열 수 없습니다."

L["ENABLE_WIDE_QUEST_LOG"] = "넓은 퀘스트 목록 사용"
L["FEATURE_QUEST_LOG_DESCRIPTION"] =
	"블리자드 퀘스트 목록을 지도가 옆에 붙은 넓은 퀘스트 목록으로 바꿉니다. UI를 다시 불러온 후에 적용됩니다."
L["FEATURE_QUEST_LOG_RELOAD_PENDING"] =
	"넓은 퀘스트 목록 사용은 UI를 다시 불러온 후에 적용되며, 설정 창을 닫을 때 다시 불러오기를 안내합니다."
L["RELOAD_PROMPT"] =
	"Wide Quest Log Forever는 UI를 다시 불러온 후에 퀘스트 목록을 전환합니다. 지금 다시 불러오시겠습니까?"

L["TAB_QUEST_LOG_DESCRIPTION"] =
	"블리자드 퀘스트 목록을 넓은 목록으로 바꿉니다. 퀘스트가 지역별로 나열되고, 옆에 선택한 퀘스트의 세부 정보와 지도가 표시됩니다."
L["QUEST_LOG_SORTING_HEADER"] = "정렬"
L["QUEST_LOG_SORTING_DESCRIPTION"] = "지역과 그 아래 퀘스트의 순서를 고르세요."
L["QUEST_LOG_ROWS_HEADER"] = "퀘스트 줄"
L["QUEST_LOG_ROWS_DESCRIPTION"] = "각 줄에 표시할 내용을 고르세요."
L["TAB_WINDOW_MAP"] = "창 및 지도"
L["QUEST_LOG_WINDOW_MAP_DESCRIPTION"] =
	"창과 지도 크기를 화면에 맞게 조절하고, 어떻게 동작할지 고르세요."
L["ZONE_ORDER"] = "지역 순서"
L["ZONE_ORDER_DESCRIPTION"] = "퀘스트 목록에서 지역의 순서를 바꿉니다."
L["SORT_AVERAGE_LEVEL_HIGHEST_DEFAULT"] = "평균 레벨, 높은 순 (기본값)"
L["SORT_AVERAGE_LEVEL_LOWEST"] = "평균 레벨, 낮은 순"
L["SORT_ALPHABETICAL"] = "이름순"
L["CURRENT_ZONE_FIRST"] = "현재 지역 먼저 표시"
L["CURRENT_ZONE_FIRST_DESCRIPTION"] =
	"지역 순서와 관계없이 지금 있는 지역을 목록 맨 위에 둡니다."
L["ZONE_GAP"] = "지역 이름 위에 여백 추가"
L["ZONE_GAP_DESCRIPTION"] =
	"각 지역 이름 위에 약간의 여백을 추가합니다. 퀘스트가 여러 지역에 흩어져 있다면 유용합니다."
L["QUEST_ORDER"] = "퀘스트 순서"
L["QUEST_ORDER_DESCRIPTION"] = "각 지역 아래 퀘스트의 순서를 바꿉니다."
L["SORT_LEVEL_HIGHEST_DEFAULT"] = "레벨, 높은 순 (기본값)"
L["SORT_LEVEL_LOWEST"] = "레벨, 낮은 순"
L["COMPLETED_FIRST"] = "완료한 퀘스트 먼저 표시"
L["COMPLETED_FIRST_DESCRIPTION"] = "완료 보고할 수 있는 퀘스트를 해당 지역의 맨 위로 옮깁니다."
L["SHOW_QUEST_LEVELS"] = "퀘스트 레벨 표시"

L["SHOW_QUEST_LEVELS_DESCRIPTION"] =
	"목록에서 각 퀘스트 이름 앞에 레벨과 유형을 붙입니다. 예를 들어 40레벨 던전 퀘스트는 %s(으)로 표시됩니다."
L["MARK_UNTRACKED"] = "추적하지 않는 퀘스트 표시"

L["MARK_UNTRACKED_DESCRIPTION"] =
	"추적 중인 퀘스트의 체크 %s 표시가 사라지고, 대신 추적하지 않는 퀘스트에 눈 %s 표시가 붙습니다. 거의 모든 퀘스트를 추적한다면 유용합니다."
L["CLOSE_IN_COMBAT"] = "전투 시작 시 닫기"
L["CLOSE_IN_COMBAT_DESCRIPTION"] =
	"전투가 시작되면 퀘스트 목록을 닫아 화면을 가리지 않게 합니다."
L["SHOW_OBJECTIVE_AREAS"] = "목표 구역 표시"
L["SHOW_OBJECTIVE_AREAS_DESCRIPTION"] =
	"퀘스트 목록 옆 지도에 각 목표의 몬스터와 사물이 있는 곳을 음영으로 표시하고, 생성 지점마다 아이콘을 두는 대신 구역마다 아이콘을 하나만 표시합니다."
L["NEEDS_QUESTIE_HINT"] = "이 기능을 사용하려면 Questie를 켜세요."
L["SHOW_ZONE_INFO"] = "지역 정보 표시"
L["SHOW_ZONE_INFO_DESCRIPTION"] =
	"지도 아래에 지도가 보여 주는 지역을 위해 다른 지역에서 받을 수 있는 퀘스트와, 그 지역 퀘스트가 요구하는 아이템을 보여 줍니다. 자리를 만들기 위해 지도가 창 높이의 절반으로 줄어듭니다."
L["WINDOW_SCALE"] = "퀘스트 목록 크기 비율"
L["WINDOW_SCALE_DESCRIPTION"] =
	"퀘스트 목록을 크게 또는 작게 만듭니다. 옆의 지도도 함께 커지고 작아집니다."
L["MAP_SCALE"] = "지도 크기 비율"
L["MAP_SCALE_DESCRIPTION"] =
	"퀘스트 목록 옆의 지도를 크게 또는 작게 만듭니다. 퀘스트 목록 크기 비율에 더해 적용됩니다."
L["RESET_WINDOW_BUTTON"] = "창 초기화"
L["RESET_WINDOW_MOVE_DESCRIPTION"] =
	"퀘스트 목록의 높이와 크기 비율, 지도 크기 비율을 기본값으로 되돌리고, 창을 처음 위치로 옮깁니다."
L["RESET_WINDOW_MOVE_CONFIRM"] =
	"퀘스트 목록의 높이와 크기 비율, 지도 크기 비율, 창의 화면 위치를 초기화할까요?"

L["FONT_HEADER"] = "글꼴"
L["FONT_LIST_DESCRIPTION"] = "퀘스트 리스트의 지역 이름과 퀘스트에 쓰는 글꼴입니다."
L["FONT_DETAILS_DESCRIPTION"] =
	"퀘스트 세부 정보의 제목, 소제목, 퀘스트 내용에 쓰는 글꼴입니다."
L["FONT_WINDOW_DESCRIPTION"] = "창 제목, 퀘스트 개수, 완료 보상 줄에 쓰는 글꼴입니다."
L["FONT_FACE"] = "글꼴"
L["FONT_FACE_DESCRIPTION"] =
	"글자 모양입니다. 게임 기본값은 게임 글꼴을 따르며, 게임 글꼴을 바꾸는 애드온도 따릅니다. SharedMedia로 추가한 글꼴도 목록에 표시됩니다."
L["FONT_GAME_DEFAULT"] = "게임 기본값"
L["FONT_GAME_STANDARD"] = "일반 텍스트"
L["FONT_GAME_NAMES"] = "캐릭터 이름"
L["FONT_GAME_DAMAGE"] = "피해량 숫자"
L["FONT_SIZE"] = "크기"
L["FONT_SIZE_DESCRIPTION"] =
	"게임 글자 크기를 기준으로 포인트 단위로 글자를 크게 또는 작게 만듭니다. 0이면 게임 크기를 그대로 유지합니다."
L["FONT_OUTLINE"] = "외곽선"
L["FONT_OUTLINE_DESCRIPTION"] =
	"각 글자 둘레의 검은 외곽선입니다. 게임 기본값은 게임 글꼴의 외곽선을 그대로 유지하고, 없음은 외곽선을 없앱니다."
L["FONT_OUTLINE_DEFAULT"] = "게임 기본값"
L["FONT_OUTLINE_NONE"] = "없음"
L["FONT_OUTLINE_THIN"] = "얇게"
L["FONT_OUTLINE_THICK"] = "두껍게"
L["FONT_SHADOW"] = "글자 그림자"
L["FONT_SHADOW_DESCRIPTION"] =
	"게임 글꼴이 글자 뒤에 넣는 그림자를 유지합니다. 끄면 그림자가 사라지며, 글꼴이 흐릿하거나 번져 보일 때 도움이 됩니다."
L["FONT_SLUG"] = "더 선명한 글자 (Slug)"
L["FONT_SLUG_DESCRIPTION"] =
	"블리자드의 새 Slug 렌더러로 글자를 그려, 어떤 크기에서도 글자가 더 선명해집니다. Slug는 두꺼운 외곽선이나 그림자를 그릴 수 없으므로, 둘 중 하나가 있는 글자는 원래 방식으로 그립니다."
L["FONT_RESET_BUTTON"] = "글꼴 초기화"
L["FONT_RESET_DESCRIPTION"] = "이 글꼴의 설정을 기본값으로 되돌립니다."

L["QUEST_SUFFIX_DUNGEON"] = "던"
L["QUEST_SUFFIX_RAID"] = "공"
L["QUEST_SUFFIX_PVP"] = "전"
L["QUEST_SUFFIX_ELITE"] = "정"

L["QUEST_TYPE_DUNGEON"] = "던전"
L["QUEST_TYPE_RAID"] = "공격대"
L["QUEST_TYPE_ELITE"] = "정예"
L["QUEST_TYPE_PVP"] = "PvP"

L["QUEST_LEVEL_LEGEND"] = "레벨 뒤 글자: %s."

L["QUEST_LEVEL_LEGEND_ENTRY"] = "%s(%s)"
L["QUEST_ID"] = "퀘스트 ID %d"

L["QUEST_CHAIN_PROGRESS"] = "연계 퀘스트 (%d/%d)"
L["WOWHEAD_LINK_TOOLTIP"] = "클릭하면 Wowhead 링크를 받습니다."
L["WOWHEAD_LINK_COPY"] = "Ctrl+C(Mac에서는 Cmd+C)를 눌러 Wowhead 링크를 복사하세요."
L["EXPAND_ALL"] = "모두 펼치기"
L["COLLAPSE_ALL"] = "모두 접기"
L["TRACK_ALL"] = "모두 추적"
L["UNTRACK_ALL"] = "모두 추적 해제"
L["HIDE_MAP"] = "지도 숨기기"
L["ZONE_INFO_QUESTS"] = "받을 수 있는 퀘스트"
L["ZONE_INFO_ITEMS"] = "챙겨 갈 것"
L["ZONE_INFO_BACK"] = "퀘스트로 돌아가기"
L["ZONE_INFO_ASK"] = "공유 요청"
L["ZONE_INFO_ASK_DESCRIPTION"] =
	"이곳에서 공유할 수 있는 퀘스트를 대화창에 적어 둡니다. 4번 채널(파티 찾기)에 들어가 있으면 그 채널로 적습니다. Enter를 누르기 전에는 아무것도 보내지 않습니다."

L["ZONE_INFO_ASK_MESSAGE"] = "%s 공유해 주실 분 있나요?"

L["ZONE_INFO_GIVER"] = "제공: %s"
L["ZONE_INFO_GIVER_PLACE"] = "%s - %s"
L["ZONE_INFO_SHAREABLE"] = "공유 가능"
L["ZONE_INFO_NOT_SHAREABLE"] = "공유 불가"
L["ZONE_INFO_NEEDED_FOR"] = "필요한 퀘스트"
L["ZONE_INFO_SHIFT_CLICK"] = "Shift-클릭"
L["ZONE_INFO_LINK_ITEM"] = "대화창에 링크"
L["ZONE_INFO_MENU_QUEST"] = "이 퀘스트"
L["ZONE_INFO_MENU_HERE"] = "현재 위치"
L["ZONE_INFO_MENU_LOG"] = "내 퀘스트"
L["ZONE_INFO_MENU_AVAILABLE"] = "퀘스트가 가장 많은 곳"
L["ZONE_INFO_NO_QUESTS"] = "이곳을 위해 다른 지역에서 받을 퀘스트가 없습니다."
L["ZONE_INFO_NO_ITEMS"] = "사거나 챙겨 갈 것이 없습니다."
L["ZONE_INFO_WORKING"] = "퀘스트 읽는 중..."
L["ZONE_INFO_NEEDS_QUESTIE"] = "Questie를 켜면 이곳의 정보를 볼 수 있습니다."

L["TURN_IN_XP"] = "경험치 %s"
L["TURN_IN_SEPARATOR"] = " / "

L["TURN_IN_SUMMARY"] = "완료 보상: %s"
L["TURN_IN_TOOLTIP"] = "완료 보고 가능"
L["RESIZE_TOOLTIP"] = "끌어서 퀘스트 목록 크기를 조절합니다."

L["CHAT_SHARING_AFTER_COMBAT"] = "전투가 끝나면 %s 퀘스트를 공유합니다."

L["QUESTIE_CANNOT_SHOW"] =
	"Questie 데이터베이스에 없는 퀘스트라서 Questie 추적기에 %s 퀘스트를 표시할 수 없습니다."
L["QUESTIE_CANNOT_TRACK"] = "Questie가 아직 이 퀘스트를 추적할 수 없습니다."
