local _, ns = ...

ns.AddWideQuestLogPart(function()
	local canvas = ns.questMap.canvas

	local function PieceSize(index, count, total, tileSize)
		if index < count then
			return tileSize, tileSize
		end
		local size = total % tileSize
		if size == 0 then
			size = tileSize
		end
		local fileSize = 16
		while fileSize < size do
			fileSize = fileSize * 2
		end
		return size, fileSize
	end

	local function DrawArea(pin, key, files, tileWidth, tileHeight, fullUpdate)
		local width, height, offsetX, offsetY = strsplit(":", key)
		width, height, offsetX, offsetY = tonumber(width), tonumber(height), tonumber(offsetX), tonumber(offsetY)
		local fileIDs = { strsplit(",", files) }
		local columns = math.ceil(width / tileWidth)
		local rows = math.ceil(height / tileHeight)

		for row = 1, rows do
			local pieceHeight, fileHeight = PieceSize(row, rows, height, tileHeight)
			for column = 1, columns do
				local pieceWidth, fileWidth = PieceSize(column, columns, width, tileWidth)
				local texture = pin.overlayTexturePool:Acquire()
				texture:SetSize(pieceWidth, pieceHeight)
				texture:SetTexCoord(0, pieceWidth / fileWidth, 0, pieceHeight / fileHeight)
				texture:SetPoint("TOPLEFT", offsetX + tileWidth * (column - 1), -(offsetY + tileHeight * (row - 1)))
				texture:SetTexture(tonumber(fileIDs[(row - 1) * columns + column]), nil, nil, "TRILINEAR")
				texture:SetDrawLayer("ARTWORK", -1)
				texture:Show()
				if fullUpdate then
					pin.textureLoadGroup:AddTexture(texture)
				end
			end
		end
	end

	local function RevealUnexplored(pin, fullUpdate)
		local mapID = canvas:GetMapID()
		local artID = mapID and C_Map.GetMapArtID(mapID)
		local areas = artID and ns.MAP_REVEAL_OVERLAYS[artID]
		if not areas then
			return
		end

		local layers = C_Map.GetMapArtLayers(mapID)
		local layer = layers and layers[canvas:GetCanvasContainer():GetCurrentLayerIndex()]
		if not layer then
			return
		end

		local explored = {}
		for _, info in ipairs(C_MapExplorationInfo.GetExploredMapTextures(mapID) or {}) do
			local key = info.textureWidth .. ":" .. info.textureHeight .. ":" .. info.offsetX .. ":" .. info.offsetY
			explored[key] = true
		end

		for key, files in pairs(areas) do
			if not explored[key] then
				DrawArea(pin, key, files, layer.tileWidth, layer.tileHeight, fullUpdate)
			end
		end
	end

	for pin in canvas:EnumeratePinsByTemplate("MapExplorationPinTemplate") do
		hooksecurefunc(pin, "RefreshOverlays", RevealUnexplored)
	end
end)
