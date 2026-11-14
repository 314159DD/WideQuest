local _, ns = ...

local questieTracker, redrawOnTrackerStart
local function IsQuestieTrackerPending()
	if not (Questie and Questie.db and Questie.db.profile and Questie.db.profile.trackerEnabled) then
		return false
	end
	questieTracker = questieTracker or ns.ImportQuestieModule("QuestieTracker")
	if not questieTracker or questieTracker.started then
		return false
	end
	if not redrawOnTrackerStart and type(questieTracker.HookBaseTracker) == "function" then
		redrawOnTrackerStart = true
		hooksecurefunc(questieTracker, "HookBaseTracker", function()
			if ns.wideQuestLogActive then
				ns.RefreshQuestLog()
			end
		end)
	end
	return true
end

function ns.ShowTrackingMark(texture, isTracked)
	local markUntracked = ns.db and ns.db.profile.markUntracked
	local mark = markUntracked and ns.TRACKING_MARKS.untracked or ns.TRACKING_MARKS.tracked
	texture:SetTexture(mark.texture)
	texture:SetVertexColor(ns.HexToRGB(mark.color))
	texture:SetShown(
		(isTracked and true or false) ~= (markUntracked and true or false) and not IsQuestieTrackerPending()
	)
end
