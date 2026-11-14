local _, ns = ...
local L = ns.L
local GetColor = ns.GetColor

function ns.OptionsHeader(text, order, hidden)
	return { type = "header", name = GetColor("TITLE") .. text .. "|r", order = order, hidden = hidden }
end

function ns.OptionsDesc(text, order, hidden)
	return { type = "description", name = text, fontSize = "medium", order = order, hidden = hidden }
end

function ns.OptionsSpacer(order, hidden)
	return { type = "description", name = " ", order = order, hidden = hidden }
end

function ns.OptionsRowLabel(text, order, width, hidden, desc)
	return {
		type = "description",
		name = text,
		desc = desc,
		dialogControl = desc and "InteractiveLabel" or nil,
		fontSize = "medium",
		width = width or ns.OPTIONS_LABEL_WIDTH,
		order = order,
		hidden = hidden,
	}
end

function ns.OptionsFeatureToggle(key, nameKey, descKey, order, width, onSet)
	return {
		type = "toggle",
		name = ns.L[nameKey],
		desc = ns.L[descKey],
		width = width or "full",
		order = order,
		get = function()
			return ns.db.profile[key]
		end,
		set = function(_, value)
			ns.db.profile[key] = value
			if onSet then
				onSet(value)
			end
		end,
	}
end

function ns.IsQuestLogReloadPending()
	return ns.hasWideQuestLog == true and (ns.db.profile.enableWideQuestLog and true or false) ~= ns.wideQuestLogActive
end

function ns.QuestLogReloadPendingText()
	if ns.IsQuestLogReloadPending() then
		return L["FEATURE_QUEST_LOG_RELOAD_PENDING"]
	end
end

function ns.OptionsStatusLine(getText, order)
	return {
		type = "description",
		name = function()
			local text = getText()
			return text and (GetColor("HELP") .. text .. "|r") or ""
		end,
		fontSize = "medium",
		order = order,
		hidden = function()
			return getText() == nil
		end,
	}
end

function ns.OptionsSubLabel(text)
	return GetColor("HELP") .. text .. "|r"
end

function ns.OptionsSubRow(order, hidden, controls)
	local args = {
		indent = { type = "description", name = " ", width = ns.OPTIONS_SUB_INDENT_WIDTH, order = 1 },
	}
	for key, control in pairs(controls) do
		args[key] = control
	end
	return { type = "group", name = "", inline = true, order = order, hidden = hidden, args = args }
end

StaticPopupDialogs.WIDEQUEST_RELOAD = {
	text = L["RELOAD_PROMPT"],
	button1 = RELOADUI,
	button2 = CANCEL,
	OnAccept = function()
		ReloadUI()
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 3,
}

local function OptionsWindow(panel)
	local window = panel
	while window:GetParent() and window:GetParent() ~= UIParent do
		window = window:GetParent()
	end
	return window
end

function ns.WatchOptionsForReload(panels)
	local hookedWindow
	local function PromptIfClosed()
		if ns.IsQuestLogReloadPending() then
			StaticPopup_Show("WIDEQUEST_RELOAD")
		end
	end
	for _, panel in ipairs(panels) do
		panel:HookScript("OnShow", function()
			local window = OptionsWindow(panel)
			if window ~= hookedWindow then
				hookedWindow = window
				window:HookScript("OnHide", function()
					C_Timer.After(0, PromptIfClosed)
				end)
			end
		end)
	end
end
