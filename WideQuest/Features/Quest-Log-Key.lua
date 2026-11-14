local _, ns = ...

local QUEST_LOG_BINDING = "TOGGLEQUESTLOG"

local frame = ns.questLogFrame

local toggleButton = CreateFrame("Button", "WideQuestToggleButton", UIParent)
toggleButton:Hide()
toggleButton:SetScript("OnClick", function()
	ns.ToggleQuestLogWindow()
end)

local routePending
function ns.RouteQuestLogKey()
	if InCombatLockdown() then
		routePending = true
		return
	end
	routePending = nil
	ClearOverrideBindings(frame)
	for _, key in ipairs({ GetBindingKey(QUEST_LOG_BINDING) }) do
		SetOverrideBindingClick(frame, false, key, toggleButton:GetName())
	end
end

function ns:OnUpdateBindings()
	if ns.questLogTakenOver then
		ns.RouteQuestLogKey()
	end
end

function ns:OnPlayerRegenEnabled()
	if ns.questLogTakenOver and routePending then
		ns.RouteQuestLogKey()
	end
end

local function CanTakeOverFromMap()
	return WorldMapFrame and WorldMapFrame:IsShown() and not InCombatLockdown()
end

function ns.IsTakenOverPanel()
	return false
end

function ns.TakeOverQuestLog()
	ns.RouteQuestLogKey()

	hooksecurefunc("ToggleQuestLog", function()
		if CanTakeOverFromMap() then
			HideUIPanel(WorldMapFrame)
			if not ns.WasClosedForPanel(WorldMapFrame) then
				ns.ToggleQuestLogWindow()
			end
		end
	end)

	hooksecurefunc("QuestMapFrame_OpenToQuestDetails", function(questID)
		if questID and ns.GetLogIndexForQuestID(questID) and CanTakeOverFromMap() then
			HideUIPanel(WorldMapFrame)
			ns.ShowQuest(questID)
		end
	end)

	ns.questLogTakenOver = true
end
