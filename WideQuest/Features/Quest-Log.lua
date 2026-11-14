local _, ns = ...
local L = ns.L

ns.hasWideQuestLog = true

local LAYOUT = ns.LAYOUT
local BASE_WIDTH, BASE_HEIGHT, PANE_TOP, ROW_HEIGHT =
	LAYOUT.BASE_WIDTH, LAYOUT.BASE_HEIGHT, LAYOUT.PANE_TOP, LAYOUT.QUEST_ROW_HEIGHT
local DEFAULT_POINT = { "TOPLEFT", "UIParent", "TOPLEFT", 0, -104 }

local state = {}
ns.questLog = state

local currentHeight

local frame = CreateFrame("Frame", "WideQuestFrame", UIParent)
ns.questLogFrame = frame
frame:Hide()
frame:SetSize(BASE_WIDTH, BASE_HEIGHT)
frame:SetPoint(unpack(DEFAULT_POINT))
frame:SetFrameStrata("MEDIUM")
frame:SetToplevel(true)
frame:EnableMouse(true)
frame:SetMovable(true)
frame:SetClampedToScreen(true)
frame:RegisterForDrag("LeftButton")
tinsert(UISpecialFrames, frame:GetName())

local bookIcon = frame:CreateTexture(nil, "BACKGROUND")
bookIcon:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BookIcon")
bookIcon:SetSize(64, 64)
bookIcon:SetPoint("TOPLEFT", 4, -4)

local LayoutArt = ns.CreateWindowArt(frame)

local windowTitle = frame:CreateFontString(nil, "OVERLAY")
windowTitle:SetFontObject(ns.AreaFont("window", "GameFontNormal"))
windowTitle:SetPoint("TOP", 0, -17)
windowTitle:SetText(ns.BuildWindowTitle())

local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButtonNoScripts")
closeButton:SetPoint("CENTER", frame, "TOPRIGHT", -46, -24)
closeButton:SetScript("OnClick", function()
	frame:Hide()
end)

local questCountText = frame:CreateFontString(nil, "OVERLAY")
questCountText:SetFontObject(ns.AreaFont("window", "GameFontNormalSmall"))
questCountText:SetPoint("RIGHT", frame, "TOPRIGHT", -52, -53)

frame:SetScript("OnDragStart", function(self)
	local _, y = GetCursorPosition()
	if (self:GetTop() - y / self:GetEffectiveScale()) <= PANE_TOP then
		self:StartMoving()
	end
end)
frame:SetScript("OnDragStop", function(self)
	self:StopMovingOrSizing()
	local point, _, relativePoint, x, y = self:GetPoint(1)
	ns.db.global.point = { point, "UIParent", relativePoint, x, y }
end)

local function CreateBottomButton(text, width, onClick)
	local button = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
	button:SetSize(width or LAYOUT.BUTTON_WIDTH, LAYOUT.BUTTON_HEIGHT)
	button:SetText(text)
	button:SetScript("OnClick", onClick)
	return button
end

local function ForSelectedQuest(action)
	return function()
		if state.selectedQuestID then
			action(state.selectedQuestID)
		end
	end
end

local trackButton = CreateBottomButton(TRACK_QUEST_ABBREV, 125, ForSelectedQuest(ns.ToggleTracking))
trackButton:SetPoint("BOTTOMLEFT", LAYOUT.BUTTON_LEFT, LAYOUT.BUTTON_BOTTOM)

local abandonButton = CreateBottomButton(ABANDON_QUEST, nil, ForSelectedQuest(ns.AskToAbandonQuest))
abandonButton:SetPoint("LEFT", trackButton, "RIGHT")

local exitButton = CreateBottomButton(EXIT, 77, function()
	frame:Hide()
end)
exitButton:SetPoint("BOTTOMRIGHT", -LAYOUT.BUTTON_RIGHT, LAYOUT.BUTTON_BOTTOM)

local shareButton = CreateBottomButton(SHARE_QUEST, nil, ForSelectedQuest(ns.ShareQuest))
shareButton:SetPoint("RIGHT", exitButton, "LEFT")

ns.abandonButton, ns.shareButton = abandonButton, shareButton
ns.ExplainShareButton(shareButton)

trackButton:SetMotionScriptsWhileDisabled(true)
trackButton:SetScript("OnEnter", function(self)
	if self.untrackable and state.selectedQuestID then
		GameTooltip:SetOwner(self, "ANCHOR_TOP")
		GameTooltip:AddLine(L["QUESTIE_CANNOT_TRACK"], ns.GetColorRGB("TEXT"))
		GameTooltip:AddLine(ns.QuestieCannotShowText(state.selectedQuestID), nil, nil, nil, true)
		GameTooltip:Show()
	end
end)
trackButton:SetScript("OnLeave", GameTooltip_Hide)

function ns.QuestActions(questID)
	local disabled = ns.IsQuestDisabledForSession(questID)
	local tracked, trackable = ns.IsTracked(questID), ns.CanTrack(questID)
	return {
		tracked = tracked,
		trackable = trackable,
		canTrack = not InCombatLockdown()
			and trackable
			and ((tracked and ns.CanRemoveQuestWatch()) or (not tracked and not disabled)),
		canShare = not disabled and ns.IsPushableQuest(questID) and IsInGroup(),
		canAbandon = not disabled and ns.CanAbandonQuest(questID),
	}
end

local function UpdateButtons()
	local questID = state.selectedQuestID
	if not questID then
		abandonButton:Disable()
		shareButton:Disable()
		trackButton:Disable()
		return
	end

	local actions = ns.QuestActions(questID)
	abandonButton:SetEnabled(actions.canAbandon)
	shareButton:SetEnabled(actions.canShare)
	trackButton:SetText(actions.tracked and UNTRACK_QUEST_ABBREV or TRACK_QUEST_ABBREV)
	trackButton:SetEnabled(actions.canTrack)
	trackButton.untrackable = not actions.trackable
end

local function UpdateCount(questCount)
	local maximumQuests = C_QuestLog.GetMaxNumQuestsCanAccept()
	local color = (questCount > maximumQuests) and RED_FONT_COLOR_CODE or HIGHLIGHT_FONT_COLOR_CODE
	questCountText:SetFormattedText(QUEST_LOG_COUNT_TEMPLATE, color, questCount, maximumQuests)
end

local function UpdateAll(resetScroll)
	if not frame:IsShown() then
		return
	end

	UpdateCount(ns.UpdateQuestList())
	ns.DisplayQuestDetails(resetScroll)
	UpdateButtons()
end

function ns.ShowQuest(questID)
	state.selectedQuestID = questID
	state.scrollToQuestID = questID

	local headerIndex = ns.GetHeaderIndexForQuest(questID)
	local header = headerIndex and ns.GetQuestLogEntry(headerIndex)
	if header and header.isCollapsed then
		ns.SetQuestZoneCollapsed(headerIndex, false)
	end

	if frame:IsShown() then
		UpdateAll(true)
	else
		frame:Show()
	end
end

local updatePending
function ns.RequestUpdate()
	if updatePending or not frame:IsShown() then
		return
	end
	updatePending = true
	C_Timer.After(0, function()
		updatePending = nil
		UpdateAll()
	end)
end

function ns:OnQuestLogUpdate()
	ns.RequestUpdate()
end

function ns:OnQuestWatchListChanged()
	ns.RequestUpdate()
end

function ns:OnQuestAccepted()
	ns.RequestUpdate()
end

function ns:OnQuestRemoved()
	ns.RequestUpdate()
end

function ns:OnQuestTurnedIn()
	ns.RequestUpdate()
end

function ns:OnUnitQuestLogChanged(unit)
	if unit == "player" or (ns.IsReadable(unit) and unit and unit:find("^party")) then
		ns.RequestUpdate()
	end
end

function ns:OnGroupRosterUpdate()
	ns.RequestUpdate()
end

function ns:OnPlayerLevelUp()
	ns.RequestUpdate()
end

function ns:OnZoneChangedNewArea()
	ns.RequestUpdate()
end

function ns:OnPlayerRegenDisabled()
	if ns.db.profile.closeInCombat and frame:IsShown() then
		frame:Hide()
	end
	ns.RequestUpdate()
end

ns.questLogWindow = {}

function ns.questLogWindow:OnPlayerRegenEnabled()
	ns.RequestUpdate()
end

local function ApplyHeight(height)
	height = ns.ClampHeight(frame, height or BASE_HEIGHT, ROW_HEIGHT)
	if height == currentHeight then
		return
	end
	currentHeight = height

	frame:SetHeight(height)
	local paneHeight = height - LAYOUT.PANE_INSET
	ns.SetQuestListHeight(paneHeight)
	ns.SetQuestDetailsHeight(paneHeight + 4)
	LayoutArt(height)
end

ns.CreateResizeGrip(frame, ApplyHeight, function()
	return currentHeight
end)

local LEFT_PANEL_AREAS = { "left", "doublewide" }
local closedForPanel
hooksecurefunc("ShowUIPanel", function(panel)
	if (not frame:IsShown()) or not panel or (panel == frame) or ns.IsTakenOverPanel(panel) then
		return
	end
	local layout = UIPanelWindows[panel:GetName() or ""]
	local area = (layout and layout.area) or panel:GetAttribute("UIPanelLayout-area")
	if tContains(LEFT_PANEL_AREAS, area) then
		frame:Hide()
		closedForPanel = panel
		C_Timer.After(0, function()
			closedForPanel = nil
		end)
	end
end)

function ns.WasClosedForPanel(panel)
	return panel ~= nil and closedForPanel == panel
end

local function CloseLeftPanels()
	if InCombatLockdown() then
		return
	end
	for _, area in ipairs(LEFT_PANEL_AREAS) do
		local panel = GetUIPanel(area)
		if panel and panel ~= frame then
			HideUIPanel(panel)
		end
	end
end

local headersOpened
frame:SetScript("OnShow", function()
	CloseLeftPanels()
	PlaySound(SOUNDKIT.IG_QUEST_LOG_OPEN)
	frame:SetScale(ns.db.global.scale)
	ApplyHeight(ns.db.global.height)
	if not headersOpened then
		headersOpened = true
		ns.ExpandAllZones()
	end
	UpdateAll(true)
end)

frame:SetScript("OnHide", function()
	state.scrollToQuestID = nil
	ns.ResetZoneOrder()
	PlaySound(SOUNDKIT.IG_QUEST_LOG_CLOSE)
	StaticPopup_Hide("ABANDON_QUEST")
	StaticPopup_Hide("ABANDON_QUEST_WITH_ITEMS")
end)

local function Toggle()
	frame:SetShown(not frame:IsShown())
end
ns.ToggleQuestLogWindow = Toggle

function ns.ResetWindow()

	ns.db.global.height, ns.db.global.point = nil, nil
	ns.db.global.scale = ns.DATABASE_DEFAULTS.global.scale
	ns.db.global.mapScale = ns.DATABASE_DEFAULTS.global.mapScale
	frame:SetScale(ns.db.global.scale)
	if ns.hasQuestMap then
		ns.ApplyMapScale()
	end
	frame:ClearAllPoints()
	frame:SetPoint(unpack(DEFAULT_POINT))
	ApplyHeight(BASE_HEIGHT)
end

function ns.ApplyWindowScale()
	frame:SetScale(ns.db.global.scale)
	if frame:IsShown() then
		currentHeight = nil
		ApplyHeight(ns.db.global.height)
	end
end

function ns.RefreshQuestLog()
	ns.ResetZoneOrder()
	ns.RequestUpdate()
end

function ns:OnDatabaseReady()
	frame:SetScale(ns.db.global.scale)
	ApplyHeight(BASE_HEIGHT)

	if ns.wideQuestLogActive then
		ns.TakeOverQuestLog()
	end

	local point = ns.db.global.point
	if point then
		frame:ClearAllPoints()
		frame:SetPoint(point[1], UIParent, point[3], point[4], point[5])
	end

	local tracker = ns.ImportQuestieModule("QuestieTracker")
	if tracker and type(tracker.Update) == "function" then
		hooksecurefunc(tracker, "Update", function()
			ns.RequestUpdate()
		end)
	end
end
