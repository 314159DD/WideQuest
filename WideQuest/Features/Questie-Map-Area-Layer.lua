local _, ns = ...

ns.AddWideQuestLogPart(function()
	local questMap = ns.questMap

	local AREA_PIN_TEMPLATE = "WideQuestAreaPinTemplate"
	local FILL_ALPHA = 0.3
	local OUTLINE_ALPHA = 0.75
	local OUTLINE_WIDTH = 1.5
	local FALLBACK_COLOR = { ns.GetColorRGB("TITLE") }
	local WHITE_TEXTURE = "Interface\\Buttons\\WHITE8X8"

	local UPPER_LEFT, LOWER_LEFT, UPPER_RIGHT, LOWER_RIGHT = 1, 2, 3, 4

	local areaPinMixin = {}

	function areaPinMixin:OutlineWidth()
		return OUTLINE_WIDTH / self:GetMap():GetCanvasScale()
	end

	function areaPinMixin:OnCanvasScaleChanged()
		local width = self:OutlineWidth()
		for i = 1, self.linesUsed do
			self.lines[i]:SetThickness(width)
		end
	end

	function areaPinMixin:AddTriangle(color, ax, ay, bx, by, cx, cy)
		self.fillsUsed = self.fillsUsed + 1
		local texture = self.fills[self.fillsUsed]
		if not texture then
			texture = self:CreateTexture(nil, "ARTWORK")
			texture:SetTexture(WHITE_TEXTURE)
			self.fills[self.fillsUsed] = texture
		end

		if (bx - ax) * (cy - ay) - (by - ay) * (cx - ax) < 0 then
			bx, by, cx, cy = cx, cy, bx, by
		end
		local left, right = math.min(ax, bx, cx), math.max(ax, bx, cx)
		local bottom, top = math.min(ay, by, cy), math.max(ay, by, cy)
		texture:ClearAllPoints()
		texture:SetPoint("TOPLEFT", self, "TOPLEFT", left, top)
		texture:SetSize(right - left, top - bottom)
		texture:SetVertexOffset(UPPER_LEFT, ax - left, ay - top)
		texture:SetVertexOffset(LOWER_LEFT, bx - left, by - bottom)
		texture:SetVertexOffset(UPPER_RIGHT, cx - right, cy - top)
		texture:SetVertexOffset(LOWER_RIGHT, cx - right, cy - bottom)
		texture:SetVertexColor(color[1], color[2], color[3], FILL_ALPHA)
		texture:Show()
	end

	function areaPinMixin:AddLine(color, width, ax, ay, bx, by)
		self.linesUsed = self.linesUsed + 1
		local line = self.lines[self.linesUsed]
		if not line then
			line = self:CreateLine(nil, "OVERLAY")
			line:SetTexture(WHITE_TEXTURE)
			self.lines[self.linesUsed] = line
		end
		line:SetStartPoint("TOPLEFT", self, ax, ay)
		line:SetEndPoint("TOPLEFT", self, bx, by)
		line:SetThickness(width)
		line:SetVertexColor(color[1], color[2], color[3], OUTLINE_ALPHA)
		line:Show()
	end

	function areaPinMixin:Draw(shapes)
		local mapWidth, mapHeight = self:GetSize()
		local outlineWidth = self:OutlineWidth()
		self.fillsUsed, self.linesUsed = 0, 0
		for _, shape in ipairs(shapes) do
			local color, outline = shape.color or FALLBACK_COLOR, shape.outline
			local middleX, middleY = shape.x * mapWidth, -shape.y * mapHeight
			for i = 1, #outline do
				local a, b = outline[i], outline[i % #outline + 1]
				local ax, ay, bx, by = a.x * mapWidth, -a.y * mapHeight, b.x * mapWidth, -b.y * mapHeight
				self:AddTriangle(color, middleX, middleY, ax, ay, bx, by)
				self:AddLine(color, outlineWidth, ax, ay, bx, by)
			end
		end
		for i = self.fillsUsed + 1, #self.fills do
			self.fills[i]:Hide()
		end
		for i = self.linesUsed + 1, #self.lines do
			self.lines[i]:Hide()
		end
	end

	function questMap.DrawObjectiveAreas(map, shapes)
		if #shapes == 0 then
			return
		end
		local pin = map:AcquirePin(AREA_PIN_TEMPLATE)
		if not pin.fills then
			Mixin(pin, areaPinMixin)
			pin.fills, pin.lines = {}, {}
		end
		pin:UseFrameLevelType("PIN_FRAME_LEVEL_QUEST_BLOB")
		pin:ApplyFrameLevel()
		pin:SetSize(map:GetCanvas():GetSize())
		pin:SetPosition(0.5, 0.5)
		pin:Draw(shapes)
	end

	function questMap.RemoveObjectiveAreas(map)
		map:RemoveAllPinsByTemplate(AREA_PIN_TEMPLATE)
	end
end)
