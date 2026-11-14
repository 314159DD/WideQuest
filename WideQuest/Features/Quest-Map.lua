local _, ns = ...

ns.hasQuestMap = true

WideQuestPinMixin = CreateFromMixins(MapCanvasPinMixin)
function WideQuestPinMixin.SetPassThroughButtons() end

ns.AddWideQuestLogPart(function()
	local L = ns.L
	local LAYOUT = ns.LAYOUT

	local window = ns.questLogFrame
	local canvas = WideQuestMapFrame

	local questMap = {}
	ns.questMap = questMap
	questMap.canvas = canvas

	local MAP_ASPECT = 1002 / 668
	local HEIGHT_SHARE = 0.66
	local SPLIT_SHARE = 0.5

	local style = {
		edge = window,
		x = -34,
		top = -9,
		bottom = 45,
		inset = 11,
	}

	local holder = CreateFrame("Frame", nil, window, "BackdropTemplate")
	holder:SetBackdrop({
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		tile = true,
		tileSize = 32,
		edgeSize = 32,
		insets = { left = style.inset, right = style.inset, top = style.inset, bottom = style.inset },
	})
	holder:EnableMouse(true)
	questMap.holder = holder

	canvas:SetParent(holder)
	canvas:SetFrameLevel(holder:GetFrameLevel() + 1)

	canvas.ScrollContainer:SetMouseWheelZoomMode(MAP_CANVAS_MOUSE_WHEEL_ZOOM_BEHAVIOR_NONE)

	local function LayOut()
		holder:ClearAllPoints()
		holder:SetPoint("TOPLEFT", style.edge, "TOPRIGHT", style.x, style.top)
		local share = questMap.zoneInfoShown and SPLIT_SHARE or HEIGHT_SHARE
		local height = (style.edge:GetHeight() + style.top - style.bottom) * share
		local mapHeight = height - 2 * style.inset
		holder:SetSize(mapHeight * MAP_ASPECT + 2 * style.inset, height)

		canvas:ClearAllPoints()
		canvas:SetPoint("TOPLEFT", style.inset, -style.inset)
		canvas:SetPoint("BOTTOMRIGHT", -style.inset, style.inset)
	end
	window:HookScript("OnSizeChanged", LayOut)

	function ns.ApplyMapScale()
		holder:SetScale(ns.db.global.mapScale)
	end
	window:HookScript("OnShow", ns.ApplyMapScale)

	function questMap.SetStyle(changes)
		for key, value in pairs(changes) do
			style[key] = value
		end
		LayOut()
	end

	function questMap.SharedHeight()
		return style.edge:GetHeight() + style.top - style.bottom
	end

	canvas.ScrollContainer:HookScript("OnSizeChanged", function()
		canvas:OnFrameSizeChanged()
	end)

	function questMap.CanShowMap(mapID)
		local layers = mapID and C_Map.GetMapArtLayers(mapID)
		return layers and #layers > 0 or false
	end

	local function DrawableMap(mapID)
		local seen = {}
		while mapID and mapID > 0 and not seen[mapID] do
			if questMap.CanShowMap(mapID) then
				return mapID
			end
			seen[mapID] = true
			local info = C_Map.GetMapInfo(mapID)
			mapID = info and info.parentMapID
		end
		return nil
	end

	local function CanvasMap()
		return canvas.mapID
	end

	local function CanDraw()
		return canvas.ScrollContainer.zoomLevels ~= nil
	end

	local drawPending = false

	function questMap.ShowMap(mapID)
		mapID = DrawableMap(mapID)
		if not mapID or CanvasMap() == mapID then
			return false
		end
		canvas:SetMapID(mapID)
		if drawPending and CanDraw() then
			drawPending = false
			MapCanvasMixin.OnShow(canvas)
		end
		return true
	end

	canvas:SetScript("OnShow", function(self)
		questMap.FollowQuest()
		if not CanvasMap() then
			if not questMap.ShowMap(MapUtil.GetDisplayableMapForPlayer()) and C_Map.GetFallbackWorldMapID then
				questMap.ShowMap(C_Map.GetFallbackWorldMapID())
			end
		end
		if CanDraw() then
			MapCanvasMixin.OnShow(self)
		else
			drawPending = true
		end
	end)
	canvas:HookScript("OnHide", function()
		drawPending = false
	end)

	ns.AddPlayerPin(canvas)

	local toggleButton = CreateFrame("Button", nil, window, "UIPanelButtonTemplate")
	toggleButton:SetSize(LAYOUT.BUTTON_WIDTH, LAYOUT.BUTTON_HEIGHT)
	toggleButton:SetPoint("LEFT", ns.listButtons[#ns.listButtons], "RIGHT", LAYOUT.LIST_BUTTONS_GAP, 0)
	questMap.toggleButton = toggleButton

	local fitted
	toggleButton:HookScript("OnShow", function(self)
		if fitted then
			return
		end
		fitted = true
		local current, width = self:GetText(), LAYOUT.BUTTON_WIDTH
		for _, label in ipairs({ SHOW_MAP, L["HIDE_MAP"] }) do
			self:SetText(label)
			width = math.max(width, self:GetTextWidth() + LAYOUT.LABEL_PADDING)
		end
		self:SetText(current)
		self:SetWidth(width)
	end)

	local closeButton = CreateFrame("Button", nil, holder, "UIPanelCloseButtonNoScripts")
	closeButton:SetPoint("TOPRIGHT", canvas, "TOPRIGHT")
	closeButton:SetFrameLevel(canvas:GetFrameLevel() + 10)
	questMap.closeButton = closeButton

	local logEmpty = false

	local function ApplyShown()
		local shown = not ns.db.global.mapHidden
		local hasUse = not logEmpty or questMap.zoneInfoShown
		holder:SetShown(shown and hasUse)
		toggleButton:SetShown(hasUse and true or false)
		toggleButton:SetText(shown and L["HIDE_MAP"] or SHOW_MAP)
	end

	function questMap.SetZoneInfoShown(shown)
		shown = shown and true or false
		if shown ~= (questMap.zoneInfoShown or false) then
			questMap.zoneInfoShown = shown
			LayOut()
			ApplyShown()
		end
	end

	function questMap.SetLogEmpty(isEmpty)
		isEmpty = isEmpty and true or false
		if isEmpty ~= logEmpty then
			logEmpty = isEmpty
			ApplyShown()
		end
	end

	function questMap.IsLogEmpty()
		return logEmpty
	end

	local function SetShown(shown)
		ns.db.global.mapHidden = (not shown) or nil
		PlaySound(shown and SOUNDKIT.IG_QUEST_LOG_OPEN or SOUNDKIT.IG_QUEST_LOG_CLOSE)
		ApplyShown()
	end

	toggleButton:SetScript("OnClick", function()
		SetShown(not holder:IsShown())
	end)
	closeButton:SetScript("OnClick", function()
		SetShown(false)
	end)
	window:HookScript("OnShow", ApplyShown)

	canvas:Show()
	LayOut()
end)
