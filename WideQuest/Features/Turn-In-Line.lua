local _, ns = ...
local L = ns.L

local questXP
local function QuestieXP()
	questXP = questXP or ns.ImportQuestieModule("QuestXP")
	if
		questXP
		and type(questXP.GetQuestLogRewardXP) == "function"
		and type(questXP.GetQuestRewardMoney) == "function"
	then
		return questXP
	end
end

local CoinText = C_CurrencyInfo and C_CurrencyInfo.GetCoinTextureString or GetCoinTextureString

local function RewardText(xp, money)
	local parts = {}
	if xp > 0 then
		parts[#parts + 1] = L["TURN_IN_XP"]:format(ns.FormatNumber(xp))
	end
	if money > 0 and CoinText then
		parts[#parts + 1] = CoinText(money)
	end
	return table.concat(parts, L["TURN_IN_SEPARATOR"])
end

local turnInTooltip = CreateFrame("GameTooltip", "WideQuestTurnInTooltip", UIParent, "GameTooltipTemplate")

local function MakeOpaque(tooltip)
	local nineSlice = tooltip.NineSlice
	if nineSlice and nineSlice.GetCenterColor then
		local r, g, b = nineSlice:GetCenterColor()
		nineSlice:SetCenterColor(r, g, b, 1)
	end
end

local function ShowTurnInTooltip(self)
	turnInTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	turnInTooltip:AddLine(L["TURN_IN_TOOLTIP"])
	local red, green, blue = ns.GetColorRGB("TEXT")
	for _, zone in ipairs(self.zones) do
		turnInTooltip:AddLine(" ")
		turnInTooltip:AddLine(zone.name, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
		for _, quest in ipairs(zone.quests) do
			turnInTooltip:AddDoubleLine(
				quest.title,
				RewardText(quest.xp, quest.money),
				red,
				green,
				blue,
				red,
				green,
				blue
			)
		end
	end
	turnInTooltip:Show()
	MakeOpaque(turnInTooltip)
end

local function HideTurnInTooltip()
	turnInTooltip:Hide()
end

function ns.CreateTurnInLine(parent)
	local line = CreateFrame("Frame", nil, parent)
	line.Text = line:CreateFontString(nil, "OVERLAY")
	line.Text:SetFontObject(ns.AreaFont("window", "GameFontNormalSmall"))
	line.Text:SetPoint("RIGHT")
	line:SetScript("OnEnter", ShowTurnInTooltip)
	line:SetScript("OnLeave", HideTurnInTooltip)
	line:Hide()
	return line
end

local function PlaceTurnInLine(line)
	if line.placed then
		return
	end
	line.placed = true
	local gap = CreateFrame("Frame", nil, line:GetParent())
	gap:SetPoint("TOPLEFT", ns.abandonButton, "TOPRIGHT")
	gap:SetPoint("BOTTOMRIGHT", ns.shareButton, "BOTTOMLEFT")
	line:SetPoint("CENTER", gap)
end

function ns.UpdateTurnInLine(line, readyQuests)
	local source = QuestieXP()
	if not source or #readyQuests == 0 then
		line:Hide()
		return
	end
	local atCap = UnitLevel("player") >= GetMaxPlayerLevel()
	local totalXP, totalMoney = 0, 0
	local zones, zoneByName = {}, {}
	for _, ready in ipairs(readyQuests) do
		local xp = 0
		if not atCap then
			local found, value = pcall(source.GetQuestLogRewardXP, source, ready.questID)
			xp = found and type(value) == "number" and value or 0
		end
		local found, value = pcall(source.GetQuestRewardMoney, ready.questID)
		local money = found and type(value) == "number" and value or 0
		if xp > 0 or money > 0 then
			totalXP, totalMoney = totalXP + xp, totalMoney + money
			local name = ready.zone or OTHER
			local zone = zoneByName[name]
			if not zone then
				zone = { name = name, quests = {} }
				zoneByName[name] = zone
				zones[#zones + 1] = zone
			end
			zone.quests[#zone.quests + 1] = { title = ready.title, xp = xp, money = money }
		end
	end
	if #zones == 0 then
		line:Hide()
		return
	end
	line.zones = zones
	line.Text:SetText(L["TURN_IN_SUMMARY"]:format(RewardText(totalXP, totalMoney)))
	line:SetSize(line.Text:GetStringWidth(), line.Text:GetStringHeight())
	PlaceTurnInLine(line)
	line:Show()
end
