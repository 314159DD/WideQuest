local _, ns = ...

local function HexToRGB(hex)
	return tonumber(hex:sub(1, 2), 16) / 255, tonumber(hex:sub(3, 4), 16) / 255, tonumber(hex:sub(5, 6), 16) / 255
end
ns.HexToRGB = HexToRGB

local COLORS, COLORS_RGB = {}, {}
for key, hex in pairs(ns.PALETTE) do
	COLORS[key] = "|cff" .. hex
	COLORS_RGB[key] = { HexToRGB(hex) }
end

function ns.GetColor(key)
	return COLORS[key] or COLORS.TEXT
end

function ns.GetColorRGB(key)
	return unpack(COLORS_RGB[key] or COLORS_RGB.TEXT)
end

local THOUSANDS_SEPARATOR = LARGE_NUMBER_SEPERATOR or ","

function ns.FormatNumber(number)
	local digits = tostring(math.floor(number))
	local head = #digits % 3
	if head == 0 then
		head = 3
	end
	local groups = { digits:sub(1, head) }
	for start = head + 1, #digits, 3 do
		groups[#groups + 1] = digits:sub(start, start + 2)
	end
	return table.concat(groups, THOUSANDS_SEPARATOR)
end

function ns.IsReadable(...)
	if not issecretvalue then
		return true
	end
	for index = 1, select("#", ...) do
		if issecretvalue((select(index, ...))) then
			return false
		end
	end
	return true
end

function ns.ImportQuestieModule(name)
	if not QuestieLoader then
		return
	end
	local loaded, module = pcall(QuestieLoader.ImportModule, QuestieLoader, name)
	return loaded and type(module) == "table" and module or nil
end

function ns.QuestieHereBeDragons()
	local library = LibStub("HereBeDragonsQuestie-2.0", true)
	if library then
		return library
	end
	local module = ns.ImportQuestieModule("HBD")
	return module and type(module.GetPlayerWorldPosition) == "function" and module or nil
end

function ns.QuestieHereBeDragonsPins()
	local library = LibStub("HereBeDragonsQuestie-Pins-2.0", true)
	if library then
		return library
	end
	local module = ns.ImportQuestieModule("HBDPins")
	return module and type(module.AddMinimapIconWorld) == "function" and module or nil
end

function ns.QuestieLogEntries()
	local activeQuests = ns.ImportQuestieModule("ActiveQuests")
	if activeQuests and type(activeQuests.GetAll) == "function" then
		local loaded, log = pcall(activeQuests.GetAll)
		if loaded and type(log) == "table" then
			return log, true
		end
	end
	local player = ns.ImportQuestieModule("QuestiePlayer")
	local log = player and player.currentQuestlog
	return type(log) == "table" and log or nil, false
end

function ns.BuildPrintLine(message)
	return ns.GetColor("INFO")
		.. ns.L["ADDON_SHORT_NAME"]
		.. "|r "
		.. ns.GetColor("SEPARATOR")
		.. "//"
		.. "|r "
		.. ns.GetColor("TEXT")
		.. message
		.. "|r"
end

function ns:PrintMessage(message)
	print(ns.BuildPrintLine(message))
end

function ns.AddClickHints(tooltip, hints)
	local red, green, blue = ns.GetColorRGB("INFO")
	if tooltip:NumLines() > 0 then
		tooltip:AddLine(" ")
	end
	for index, hint in ipairs(hints) do
		if index > 1 then
			tooltip:AddLine(" ")
		end
		tooltip:AddDoubleLine(hint[1], hint[2], red, green, blue, red, green, blue)
	end
end

function ns.ExplainShareButton(button)
	button:SetMotionScriptsWhileDisabled(true)
	button:HookScript("OnEnter", function(self)
		if not self:IsEnabled() and not IsInGroup() then
			GameTooltip:SetOwner(self, "ANCHOR_TOP")
			GameTooltip_SetTitle(GameTooltip, ERR_NOT_IN_GROUP)
			GameTooltip:Show()
		end
	end)
	button:HookScript("OnLeave", GameTooltip_Hide)
end
