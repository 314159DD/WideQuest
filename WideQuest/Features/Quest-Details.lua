local _, ns = ...

local LAYOUT = ns.LAYOUT
local SPACE = LAYOUT.SPACE
local PANE_TOP = LAYOUT.PANE_TOP
local WIDTH = LAYOUT.CONTENT_WIDTH
local frame = ns.questLogFrame
local state = ns.questLog

local CoinText = C_CurrencyInfo and C_CurrencyInfo.GetCoinTextureString or GetCoinTextureString

local detail = CreateFrame("Frame", nil, frame)
detail:SetPoint("TOPLEFT", LAYOUT.PARCHMENT_LEFT, -(PANE_TOP - 2))
detail:SetWidth(LAYOUT.PARCHMENT_RIGHT - LAYOUT.PARCHMENT_LEFT)

detail.ContrastBG = detail:CreateTexture(nil, "BACKGROUND", nil, -1)
detail.ContrastBG:SetAllPoints()
detail.ContrastBG:Hide()

local detailScroll = CreateFrame("ScrollFrame", nil, detail)
detailScroll:SetPoint("TOPLEFT", 0, -2)
detailScroll:SetPoint("BOTTOMRIGHT", 0, 2)
local detailBar = CreateFrame("EventFrame", nil, detailScroll, "MinimalScrollBar")
local scrollBarX = (LAYOUT.DETAIL_SCROLL_SLOT_X - 4) - LAYOUT.PARCHMENT_RIGHT
detailBar:SetPoint("TOPLEFT", detailScroll, "TOPRIGHT", scrollBarX, -4)
detailBar:SetPoint("BOTTOMLEFT", detailScroll, "BOTTOMRIGHT", scrollBarX, 4)
ScrollUtil.InitScrollFrameWithScrollBar(detailScroll, detailBar)

local detailChild = CreateFrame("Frame", nil, detailScroll)
detailChild:SetSize(LAYOUT.PARCHMENT_RIGHT - LAYOUT.PARCHMENT_LEFT, 300)
detailScroll:SetScrollChild(detailChild)

local function Text(fontObject, sectionHeading)
	local text = detailChild:CreateFontString(nil, "ARTWORK")
	text:SetFontObject(ns.AreaFont("details", fontObject))
	text:SetJustifyH("LEFT")
	text:SetWidth(WIDTH)
	ns.StyleQuestText(text, sectionHeading, "details")
	text:Hide()
	return text
end

local titleText = Text("QuestTitleFont")
local objectivesText = Text("QuestFont")
local timerText = Text("QuestFont")
local timerExpires
local sinceTimer = 0

local function CountDown(_, elapsed)
	sinceTimer = sinceTimer + elapsed
	if sinceTimer < 1 or not timerExpires then
		return
	end
	sinceTimer = 0
	if timerText:IsShown() then
		timerText:SetText(TIME_REMAINING .. " " .. SecondsToTime(math.max(0, timerExpires - GetTime())))
	end
end
local groupSizeText = Text("QuestFont")
local requiredMoneyText = Text("QuestFont")
local waypointText = Text("QuestFont")
local descriptionHeading = Text("QuestTitleFont", true)
descriptionHeading:SetText(QUEST_DESCRIPTION)
local descriptionText = Text("QuestFont")
local rewardsHeading = Text("QuestTitleFont", true)
rewardsHeading:SetText(QUEST_REWARDS)
local choiceText = Text("QuestFont")
local spellText = Text("QuestFont")
spellText:SetText(REWARD_SPELL)
local receiveText = Text("QuestFont")
local experienceText = Text("QuestFont")
experienceText:SetText(EXPERIENCE_COLON)

local function Number()
	local number = detailChild:CreateFontString(nil, "ARTWORK")
	number:SetFontObject(ns.AreaFont("details", "QuestFont"))
	number:SetJustifyH("RIGHT")
	number:Hide()
	return number
end
local moneyNumber = Number()
local experienceNumber = Number()

local objectiveLines = {}
local function ObjectiveLine(index)
	local line = objectiveLines[index]
	if not line then
		line = Text("QuestFont")
		objectiveLines[index] = line
	end
	return line
end

local FALLBACK_TEXT_COLOR, FALLBACK_TITLE_COLOR = { 0.18, 0.12, 0.06 }, { 0, 0, 0 }
local FINISHED_COLOR = { 0.2, 0.2, 0.2 }

local function TextColors()
	local lightText = QuestTextContrast and QuestTextContrast.UseLightText and QuestTextContrast.UseLightText()
	local textColor, titleColor
	if GetMaterialTextColors then
		textColor, titleColor = GetMaterialTextColors(lightText and "Stone" or "Default")
	end
	return textColor or FALLBACK_TEXT_COLOR, titleColor or FALLBACK_TITLE_COLOR
end

local function SetColor(region, color)
	region:SetTextColor(color[1], color[2], color[3])
end

local rewardButtons = ns.CreateRewardButtons(detailChild)

local chainSection = ns.CreateQuestChainSection(detailChild)

local questIDRow = CreateFrame("Frame", nil, detailChild)
questIDRow:SetSize(WIDTH, 14)
questIDRow.Text = questIDRow:CreateFontString(nil, "ARTWORK")
questIDRow.Text:SetFontObject(ns.AreaFont("details", "QuestFontNormalSmall"))
questIDRow.Text:SetPoint("RIGHT")
questIDRow.Text:SetJustifyH("RIGHT")
ns.LinkQuestIDToWowhead(questIDRow, questIDRow.Text, function()
	return state.selectedQuestID
end)

local placed, last, height = {}, nil, 0

local function Place(region, gap)
	region:ClearAllPoints()
	if last then
		region:SetPoint("TOPLEFT", last, "BOTTOMLEFT", 0, -gap)
		height = height + gap
	else
		region:SetPoint("TOPLEFT", LAYOUT.CONTENT_LEFT - LAYOUT.PARCHMENT_LEFT, -(LAYOUT.CONTENT_TOP - PANE_TOP))
		height = LAYOUT.CONTENT_TOP - PANE_TOP
	end
	region:Show()
	height = height + region:GetHeight()
	placed[#placed + 1] = region
	last = region
end

local function PlaceText(region, text, gap)
	if not text or text == "" then
		return false
	end
	region:SetText(text)
	Place(region, gap)
	return true
end

local function HideEverything()
	for _, region in ipairs(placed) do
		region:Hide()
	end
	wipe(placed)
	moneyNumber:Hide()
	experienceNumber:Hide()
	ns.ClearObjectiveCounts()
	last, height = nil, 0
end

local function PlaceRewardButtons(rewards, nextButton)
	for index, reward in ipairs(rewards) do
		local button = rewardButtons.Fill(nextButton, reward)
		nextButton = nextButton + 1
		if index % 2 == 1 then
			Place(button, index == 1 and LAYOUT.REWARD_BUTTONS_SPACE or SPACE.TIGHT)
		else
			button:ClearAllPoints()
			button:SetPoint("TOPLEFT", last, "TOPRIGHT", 1, 0)
			button:Show()
			placed[#placed + 1] = button
		end
	end
	return nextButton
end

local function PlaceRewards(details)
	local choices, rewards, spells = details.choices, details.rewards, details.spells
	local money, experience = details.money or 0, details.experience or 0
	local hasGiven = #rewards > 0 or money > 0 or experience > 0
	if #choices == 0 and #spells == 0 and not hasGiven then
		return
	end

	Place(rewardsHeading, LAYOUT.HEADING_SPACE_ABOVE)
	local gap = LAYOUT.HEADING_SPACE_BELOW
	local nextButton = 1

	if #choices > 0 then
		PlaceText(choiceText, #choices == 1 and REWARD_ITEMS_ONLY or REWARD_CHOICES, gap)
		nextButton = PlaceRewardButtons(choices, nextButton)
		gap = LAYOUT.REWARD_BUTTONS_SPACE
	end

	if #spells > 0 then
		Place(spellText, gap)
		nextButton = PlaceRewardButtons(spells, nextButton)
		gap = LAYOUT.REWARD_BUTTONS_SPACE
	end

	if hasGiven then
		local also = #choices > 0 or #spells > 0
		PlaceText(receiveText, also and REWARD_ITEMS or REWARD_ITEMS_ONLY, gap)
		local inset = ns.TwoSpacesWide(descriptionText)
		if money > 0 and CoinText then
			moneyNumber:SetText(CoinText(money))
			moneyNumber:SetPoint("TOPRIGHT", receiveText, "TOPLEFT", WIDTH - inset, 0)
			moneyNumber:Show()
		end
		if experience > 0 then
			Place(experienceText, money > 0 and LAYOUT.MONEY_EXPERIENCE_SPACE or SPACE.LINE)
			experienceNumber:SetText(ns.FormatNumber(experience))
			experienceNumber:SetPoint("TOPRIGHT", experienceText, "TOPLEFT", WIDTH - inset, 0)
			experienceNumber:Show()
		end
		nextButton = PlaceRewardButtons(rewards, nextButton)
	end

	rewardButtons.HideFrom(nextButton)
end

local function PlaceObjectives(details, textColor)
	local gap = SPACE.GROUP
	if details.waypoint then
		SetColor(waypointText, textColor)
		local waypointFormat = WAYPOINT_OBJECTIVE_FORMAT_OPTIONAL
		PlaceText(waypointText, waypointFormat and waypointFormat:format(details.waypoint) or details.waypoint, gap)
		gap = SPACE.LINE
	end
	for index, objective in ipairs(details.objectives) do
		local line = ObjectiveLine(index)
		SetColor(line, objective.finished and FINISHED_COLOR or textColor)
		ns.StyleObjective(line, objective.text, objective.finished, WIDTH, descriptionText)
		Place(line, gap)
		gap = SPACE.LINE
	end
end

local TITLE_COLOR_REGIONS = { titleText, descriptionHeading, rewardsHeading }
local TEXT_COLOR_REGIONS = {
	objectivesText,
	timerText,
	groupSizeText,
	requiredMoneyText,
	descriptionText,
	choiceText,
	spellText,
	receiveText,
	experienceText,
	moneyNumber,
	experienceNumber,
}

function ns.DisplayQuestDetails(resetScroll)
	detailScroll:SetShown(state.selectedQuestID ~= nil)
	HideEverything()
	if not state.selectedQuestID then
		return
	end

	ns.SelectQuest(state.selectedQuestID)
	local details = ns.GetSelectedQuestDetails(state.selectedQuestID)

	if QuestTextContrast and QuestTextContrast.IsEnabled() then
		detail.ContrastBG:SetAtlas(QuestTextContrast.GetDefaultBackgroundAtlas())
		detail.ContrastBG:Show()
	else
		detail.ContrastBG:Hide()
	end
	local textColor, titleColor = TextColors()
	for _, region in ipairs(TITLE_COLOR_REGIONS) do
		SetColor(region, titleColor)
	end
	for _, region in ipairs(TEXT_COLOR_REGIONS) do
		SetColor(region, textColor)
	end

	local title = details.title or ""
	if details.failed then
		title = QUEST_TITLE_FORMAT_FAILED:format(title)
	end
	PlaceText(titleText, title, 0)
	PlaceText(objectivesText, details.objectivesText, LAYOUT.TITLE_SPACE_BELOW)
	timerExpires = details.timeLeft and (GetTime() + details.timeLeft) or nil
	detailChild:SetScript("OnUpdate", timerExpires and CountDown or nil)
	if details.timeLeft then
		PlaceText(timerText, TIME_REMAINING .. " " .. SecondsToTime(details.timeLeft), SPACE.NEAR)
	end
	if details.groupSize > 0 then
		PlaceText(groupSizeText, QUEST_SUGGESTED_GROUP_NUM:format(details.groupSize), SPACE.NEAR)
	end
	if details.requiredMoney > 0 and CoinText then
		PlaceText(requiredMoneyText, REQUIRED_MONEY .. " " .. CoinText(details.requiredMoney), SPACE.NEAR)
	end
	PlaceObjectives(details, textColor)

	if details.description and details.description ~= "" then
		Place(descriptionHeading, LAYOUT.HEADING_SPACE_ABOVE)
		PlaceText(descriptionText, details.description, LAYOUT.HEADING_SPACE_BELOW)
	end

	PlaceRewards(details)

	if ns.UpdateQuestChainSection(chainSection, state.selectedQuestID, descriptionHeading, descriptionText) then
		Place(chainSection, LAYOUT.HEADING_SPACE_ABOVE)
	else
		chainSection:Hide()
	end

	ns.StyleQuestID(questIDRow.Text, state.selectedQuestID, descriptionText)
	questIDRow.Text:ClearAllPoints()
	questIDRow.Text:SetPoint("RIGHT", -ns.TwoSpacesWide(descriptionText), 0)
	Place(questIDRow, LAYOUT.QUEST_ID_GAP)

	detailChild:SetHeight(height + LAYOUT.PAGE_TOP)
	detailScroll:UpdateScrollChildRect()
	if resetScroll then
		detailScroll:SetVerticalScroll(0)
	end
end

function ns.SetQuestDetailsHeight(paneHeight)
	detail:SetHeight(paneHeight)
end
