local _, ns = ...

local GetRequiredMoney = C_QuestLog.GetRequiredMoney or GetQuestLogRequiredMoney
local GetSuggestedGroupSize = C_QuestLog.GetSuggestedGroupSize
local GetNextWaypointText = C_QuestLog.GetNextWaypointText
local GetChoiceLootType = GetQuestLogChoiceInfoLootType
local GetRewardCurrencies = C_QuestInfoSystem and C_QuestInfoSystem.GetQuestRewardCurrencies
local GetRewardSpells = C_QuestInfoSystem and C_QuestInfoSystem.GetQuestRewardSpells
local LOOT_LIST_CURRENCY = 1

local function ItemReward(tooltipType, tooltipIndex, name, texture, count, quality, isUsable, itemID)
	return {
		kind = "item",
		tooltipType = tooltipType,
		tooltipIndex = tooltipIndex,
		name = name,
		texture = texture,
		count = count,
		quality = quality,
		isUsable = isUsable ~= false,
		itemID = itemID,
	}
end

local function CurrencyReward(tooltipType, tooltipIndex, name, texture, count, quality)
	return {
		kind = "currency",
		tooltipType = tooltipType,
		tooltipIndex = tooltipIndex,
		name = name,
		texture = texture,
		count = count,
		quality = quality,
		isUsable = true,
	}
end

local function ChoiceRewards(questID)
	local choices = {}
	local itemIndex, currencyIndex = 0, 0
	for index = 1, GetNumQuestLogChoices(questID, true) or 0 do
		if GetChoiceLootType and GetChoiceLootType(index) == LOOT_LIST_CURRENCY then
			currencyIndex = currencyIndex + 1
			local info = C_QuestLog.GetQuestRewardCurrencyInfo(questID, index, true)
			if info and info.currencyID then
				choices[#choices + 1] = CurrencyReward(
					"choice",
					currencyIndex,
					info.name,
					info.texture,
					info.totalRewardAmount,
					info.quality
				)
			end
		else
			itemIndex = itemIndex + 1
			local name, texture, count, quality, isUsable, itemID = GetQuestLogChoiceInfo(index)
			choices[#choices + 1] = ItemReward("choice", itemIndex, name, texture, count, quality, isUsable, itemID)
		end
	end
	return choices
end

local function FixedRewards(questID)
	local rewards = {}
	for index = 1, GetNumQuestLogRewards() or 0 do
		local name, texture, count, quality, isUsable, itemID = GetQuestLogRewardInfo(index)
		rewards[#rewards + 1] = ItemReward("reward", index, name, texture, count, quality, isUsable, itemID)
	end
	if GetRewardCurrencies then
		for index, info in ipairs(GetRewardCurrencies(questID) or {}) do
			rewards[#rewards + 1] =
				CurrencyReward("reward", index, info.name, info.texture, info.totalRewardAmount, info.quality)
		end
	elseif GetQuestLogRewardCurrencyInfo and GetNumQuestLogRewardCurrencies then

		local wanted = GetNumQuestLogRewardCurrencies() or 0
		local found = 0
		for index = 1, (GetMaxRewardCurrencies and GetMaxRewardCurrencies()) or wanted do
			if found >= wanted then
				break
			end
			local name, texture, count, _, quality = GetQuestLogRewardCurrencyInfo(index)
			if name then
				found = found + 1
				rewards[#rewards + 1] = CurrencyReward("reward", index, name, texture, count, quality)
			end
		end
	end
	return rewards
end

local function SpellRewards(questID)
	local spells = {}
	if not GetRewardSpells then
		return spells
	end
	local spellBank = Enum.SpellBookSpellBank and Enum.SpellBookSpellBank.Player
	for _, spellID in ipairs(GetRewardSpells(questID) or {}) do
		local info = spellID and spellID > 0 and C_QuestInfoSystem.GetQuestRewardSpellInfo(questID, spellID)
		local known = C_SpellBook
			and C_SpellBook.IsSpellInSpellBook
			and spellBank
			and C_SpellBook.IsSpellInSpellBook(spellID, spellBank, true)
		if info and info.texture and not known and not info.isBoostSpell and not info.garrFollowerID then
			spells[#spells + 1] = { kind = "spell", spellID = spellID, name = info.name, texture = info.texture }
		end
	end
	return spells
end

local function ObjectiveLines()
	local lines = {}
	for index = 1, GetNumQuestLeaderBoards() or 0 do
		local text, objectiveType, finished = GetQuestLogLeaderBoard(index)
		if objectiveType ~= "spell" and objectiveType ~= "log" then
			lines[#lines + 1] =
				{ text = (text and text ~= "") and text or objectiveType, finished = finished and true or false }
		end
	end
	return lines
end

function ns.GetSelectedQuestDetails(questID)
	local description, objectivesText = GetQuestLogQuestText()
	local details = {
		title = ns.GetQuestTitleByID(questID),
		failed = IsCurrentQuestFailed() and true or false,
		objectivesText = objectivesText,
		description = description,
		waypoint = GetNextWaypointText and GetNextWaypointText(questID),
		timeLeft = GetQuestLogTimeLeft(),
		groupSize = GetSuggestedGroupSize and GetSuggestedGroupSize(questID) or 0,
		requiredMoney = GetRequiredMoney and GetRequiredMoney() or 0,
		objectives = ObjectiveLines(),
		choices = {},
		rewards = {},
		spells = SpellRewards(questID),
		money = 0,
		experience = 0,
	}
	if C_QuestLog.ShouldShowQuestRewards(questID) then
		details.choices = ChoiceRewards(questID)
		details.rewards = FixedRewards(questID)
		details.money = GetQuestLogRewardMoney() or 0
		details.experience = GetQuestLogRewardXP() or 0
	end
	return details
end
