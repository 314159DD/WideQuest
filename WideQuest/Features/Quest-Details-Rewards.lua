local _, ns = ...

local state = ns.questLog

local function ShowRewardTooltip(button)
	local reward = button.reward
	if not reward then
		return
	end
	GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
	if reward.kind == "spell" then
		GameTooltip:SetSpellByID(reward.spellID)
	else

		ns.SelectQuest(state.selectedQuestID)
		if reward.kind == "currency" then
			GameTooltip:SetQuestLogCurrency(reward.tooltipType, reward.tooltipIndex)
		else
			GameTooltip:SetQuestLogItem(reward.tooltipType, reward.tooltipIndex)
		end
	end
	GameTooltip:Show()
end

local function LinkReward(button)
	local reward = button.reward
	if not (reward and reward.kind == "item" and IsModifiedClick()) then
		return
	end
	ns.SelectQuest(state.selectedQuestID)
	local link = GetQuestLogItemLink(reward.tooltipType, reward.tooltipIndex)
	if link then
		HandleModifiedItemClick(link)
	end
end

local UNUSABLE_RED, UNUSABLE_GREEN, UNUSABLE_BLUE = 0.9, 0, 0

local function FillRewardButton(button, reward)
	button.reward = reward
	button.Icon:SetTexture(reward.texture)
	button.Name:SetText(reward.name or "")
	local quality = reward.quality and ITEM_QUALITY_COLORS and ITEM_QUALITY_COLORS[reward.quality]
	if quality and reward.quality > 1 then
		button.Name:SetTextColor(quality.r, quality.g, quality.b)
	else
		button.Name:SetTextColor(HIGHLIGHT_FONT_COLOR:GetRGB())
	end
	local count = reward.count or 0
	local showCount = (reward.kind == "currency" and count > 0) or count > 1
	button.Count:SetText(showCount and ns.FormatNumber(count) or "")
	if reward.isUsable == false then
		button.Icon:SetVertexColor(UNUSABLE_RED, UNUSABLE_GREEN, UNUSABLE_BLUE)
		button.NameFrame:SetVertexColor(UNUSABLE_RED, UNUSABLE_GREEN, UNUSABLE_BLUE)
	else
		button.Icon:SetVertexColor(1, 1, 1)
		button.NameFrame:SetVertexColor(1, 1, 1)
	end
end

local itemsAskedFor = {}
local function AskForItem(itemID)
	if itemsAskedFor[itemID] or not (Item and Item.CreateFromItemID) then
		return
	end
	itemsAskedFor[itemID] = true
	Item:CreateFromItemID(itemID):ContinueOnItemLoad(function()
		itemsAskedFor[itemID] = nil
		ns.RequestUpdate()
	end)
end

function ns.CreateRewardButtons(parent)
	local rewardButtons = {}

	local function RewardButton(index)
		local button = rewardButtons[index]
		if not button then
			button = CreateFrame("Button", nil, parent, "LargeItemButtonTemplate")
			button:SetScript("OnEnter", ShowRewardTooltip)
			button:SetScript("OnLeave", GameTooltip_Hide)
			button:SetScript("OnClick", LinkReward)
			rewardButtons[index] = button
		end
		return button
	end

	local set = {}
	function set.Fill(index, reward)
		local button = RewardButton(index)
		FillRewardButton(button, reward)
		if reward.kind == "item" and not reward.name and reward.itemID then
			AskForItem(reward.itemID)
		end
		return button
	end
	function set.HideFrom(index)
		for later = index, #rewardButtons do
			rewardButtons[later]:Hide()
			rewardButtons[later].reward = nil
		end
	end
	return set
end
