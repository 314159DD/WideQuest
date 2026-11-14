local _, ns = ...

ns.AddWideQuestLogPart(function()
	local questMap = ns.questMap
	local canvas = questMap.canvas

	local PIN_TEMPLATE = questMap.QUESTIE_PIN_TEMPLATE
	local CLUSTER_DISTANCE = 0.015

	local ROW_INDENT = " "

	local function ObjectiveRow(data)
		local objective = data.ObjectiveData
		if not (objective and objective.Description) then
			return nil
		end
		local have, need = objective.Collected or 0, objective.Needed
		return {
			description = objective.Description,
			count = need and string.format("%s / %s", tostring(have), tostring(need)) or nil,
			done = objective.Completed or (need ~= nil and have >= need) or false,
		}
	end

	local function HasObjective(objectives, row)
		for _, other in ipairs(objectives) do
			if other.description == row.description then
				return true
			end
		end
		return false
	end

	function questMap.ShowPinTooltip(pin)
		local x, y = pin:GetPosition()
		local entries, byName = {}, {}
		for other in canvas:EnumeratePinsByTemplate(PIN_TEMPLATE) do
			local otherX, otherY = other:GetPosition()
			if math.abs(otherX - x) < CLUSTER_DISTANCE and math.abs(otherY - y) < CLUSTER_DISTANCE then
				local objective = ObjectiveRow(other.data)
				for _, name in ipairs(other.area and other.area.names or { other.data.Name or "" }) do
					local entry = byName[name]
					if not entry then
						entry = { name = name, objectives = {} }
						byName[name] = entry
						entries[#entries + 1] = entry
					end
					if objective and not HasObjective(entry.objectives, objective) then
						entry.objectives[#entry.objectives + 1] = objective
					end
				end
			end
		end

		GameTooltip:SetOwner(pin, "ANCHOR_RIGHT")
		local quest = pin.data.QuestData
		if quest and quest.name then
			GameTooltip:AddLine(quest.name)
		end
		for _, entry in ipairs(entries) do
			GameTooltip:AddLine(ROW_INDENT .. entry.name, ns.GetColorRGB("TEXT"))

			for _, objective in ipairs(entry.objectives) do
				local left = ROW_INDENT .. ns.CheckIcon(GameTooltipText, objective.done) .. " " .. objective.description
				local red, green, blue = ns.GetColorRGB(objective.done and "HELP" or "TEXT")
				if objective.count then
					GameTooltip:AddDoubleLine(left, objective.count, red, green, blue, red, green, blue)
				else
					GameTooltip:AddLine(left, red, green, blue)
				end
			end
		end
		GameTooltip:Show()
	end
end)
