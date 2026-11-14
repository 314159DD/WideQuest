local _, ns = ...
local L = ns.L

ns.FONT_AREAS = { "list", "details", "window" }

ns.FONT_OUTLINES = { "DEFAULT", "NONE", "OUTLINE", "THICKOUTLINE" }

ns.FONT_SIZE_MIN, ns.FONT_SIZE_MAX = -4, 6
local SMALLEST_SIZE = 6

local SharedMedia = LibStub("LibSharedMedia-3.0")

local GAME_FONTS = {
	{ key = "GAME_STANDARD", global = "STANDARD_TEXT_FONT", nameKey = "FONT_GAME_STANDARD" },
	{ key = "GAME_NAMES", global = "UNIT_NAME_FONT", nameKey = "FONT_GAME_NAMES" },
	{ key = "GAME_DAMAGE", global = "DAMAGE_TEXT_FONT", nameKey = "FONT_GAME_DAMAGE" },
}

local function FontFile(face)
	if not face or face == "" then
		return nil
	end
	for _, font in ipairs(GAME_FONTS) do
		if font.key == face then
			return _G[font.global]
		end
	end
	if SharedMedia:IsValid("font", face) then
		return SharedMedia:Fetch("font", face, true)
	end
end

function ns.FontChoices(saved)
	local values, sorting = { [""] = L["FONT_GAME_DEFAULT"] }, { "" }
	for _, font in ipairs(GAME_FONTS) do
		values[font.key] = L[font.nameKey]
		sorting[#sorting + 1] = font.key
	end
	for _, name in ipairs(SharedMedia:List("font")) do
		if not values[name] then
			values[name] = name
			sorting[#sorting + 1] = name
		end
	end
	if saved and saved ~= "" and not values[saved] then
		values[saved] = saved
		sorting[#sorting + 1] = saved
	end
	return values, sorting
end

function ns.FontSettings(area)
	local profile = ns.db and ns.db.profile
	return profile and profile.fonts and profile.fonts[area]
end

local function Flags(blizzardFlags, settings, shadowed)
	blizzardFlags = (blizzardFlags or ""):upper()
	local outline = settings and settings.outline or "DEFAULT"
	if outline == "DEFAULT" then
		if blizzardFlags:find("THICK", 1, true) then
			outline = "THICKOUTLINE"
		elseif blizzardFlags:find("OUTLINE", 1, true) then
			outline = "OUTLINE"
		else
			outline = "NONE"
		end
	end
	local monochrome = blizzardFlags:find("MONOCHROME", 1, true) ~= nil
	local slug
	if settings then
		slug = settings.slug
	else
		slug = blizzardFlags:find("SLUG", 1, true) ~= nil
	end

	local flags = {}
	if outline ~= "NONE" then
		flags[#flags + 1] = outline
	end
	if monochrome then
		flags[#flags + 1] = "MONOCHROME"
	end
	if slug and outline ~= "THICKOUTLINE" and not monochrome and not shadowed then
		flags[#flags + 1] = "SLUG"
	end
	return table.concat(flags, ",")
end

local function HasShadow(font)
	local x, y = font:GetShadowOffset()
	local _, _, _, alpha = font:GetShadowColor()
	return ((x or 0) ~= 0 or (y or 0) ~= 0) and (alpha or 0) > 0
end

local areaFonts = {}
local copies = {}
local followed = {}
local copyCount = 0

local function Sync(copy, blizzard, area)
	local file, size, flags = blizzard:GetFont()
	if not file or not size then
		return
	end
	copy:CopyFontObject(blizzard)
	local settings = ns.FontSettings(area)
	if settings then
		file = FontFile(settings.face) or file
		size = math.max(SMALLEST_SIZE, size + (settings.size or 0))
		if settings.shadow == false then
			copy:SetShadowOffset(0, 0)
			copy:SetShadowColor(0, 0, 0, 0)
		end
	end
	copy:SetFont(file, size, Flags(flags, settings, HasShadow(copy)))
end

local function SyncCopiesOf(blizzard)
	for area, fonts in pairs(areaFonts) do
		if fonts[blizzard] then
			Sync(fonts[blizzard], blizzard, area)
		end
	end
end

local FOLLOWED_METHODS = { "SetFont", "SetShadowColor", "SetShadowOffset" }

local function Follow(blizzard)
	if followed[blizzard] then
		return
	end
	followed[blizzard] = true
	for _, method in ipairs(FOLLOWED_METHODS) do
		if blizzard[method] then
			hooksecurefunc(blizzard, method, function()
				SyncCopiesOf(blizzard)
			end)
		end
	end
end

function ns.FontBase(fontObject)
	local copy = fontObject and copies[fontObject]
	return copy and copy.blizzard or fontObject
end

function ns.AreaFont(area, blizzard)
	if type(blizzard) == "string" then
		blizzard = _G[blizzard]
	end
	if not blizzard then
		return nil
	end
	blizzard = ns.FontBase(blizzard)
	local fonts = areaFonts[area]
	if not fonts then
		fonts = {}
		areaFonts[area] = fonts
	end
	local copy = fonts[blizzard]
	if copy then
		return copy
	end
	if not blizzard:GetFont() then
		return blizzard
	end
	copyCount = copyCount + 1
	local areaName = area:gsub("^%l", string.upper)
	copy = CreateFont(("WideQuest%sFont%d"):format(areaName, copyCount))
	fonts[blizzard] = copy
	copies[copy] = { blizzard = blizzard, area = area }
	Follow(blizzard)
	Sync(copy, blizzard, area)
	return copy
end

function ns.SyncFonts()
	for area, fonts in pairs(areaFonts) do
		for blizzard, copy in pairs(fonts) do
			Sync(copy, blizzard, area)
		end
	end
end

function ns.ApplyFontSettings()
	ns.SyncFonts()
	if ns.wideQuestLogActive and ns.RefreshQuestLog then
		ns.RefreshQuestLog()
	end
end

local function FontInUse(name)
	for _, area in ipairs(ns.FONT_AREAS) do
		local settings = ns.FontSettings(area)
		if settings and settings.face == name then
			return true
		end
	end
	return false
end

SharedMedia.RegisterCallback(ns, "LibSharedMedia_Registered", function(_, mediaType, name)
	if mediaType == "font" and ns.db and FontInUse(name) then
		ns.ApplyFontSettings()
	end
end)
