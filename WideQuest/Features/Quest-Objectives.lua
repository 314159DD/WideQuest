local _, ns = ...

local CHECK_TEXTURE = "Interface\\RaidFrame\\ReadyCheck-Ready"
local NO_CHECK_TEXTURE = "Interface\\Common\\spacer"

local CHECK_DROP = 0.25

local COORD_SCALE = 1024

function ns.InlineIcon(region, texture, coords)
	local _, size = region:GetFont()
	size = size or 12
	local pixels = math.floor(size + 0.5)
	local drop = math.floor(size * CHECK_DROP + 0.5)
	if coords then
		return format(
			"|T%s:%d:%d:0:%d:%d:%d:%d:%d:%d:%d|t",
			texture,
			pixels,
			pixels,
			-drop,
			COORD_SCALE,
			COORD_SCALE,
			coords[1] * COORD_SCALE,
			coords[2] * COORD_SCALE,
			coords[3] * COORD_SCALE,
			coords[4] * COORD_SCALE
		)
	end
	return format("|T%s:%d:%d:0:%d|t", texture, pixels, pixels, -drop)
end

function ns.CheckIcon(region, checked)
	return ns.InlineIcon(region, checked and CHECK_TEXTURE or NO_CHECK_TEXTURE)
end
local COUNT_GAP = ns.LAYOUT.SPACE.NEAR

local measure = UIParent:CreateFontString(nil, "ARTWORK")
measure:Hide()

function ns.TwoSpacesWide(fontSource)
	local fontObject = fontSource:GetFontObject()
	if fontObject then
		measure:SetFontObject(fontObject)
	else
		measure:SetFont(fontSource:GetFont())
	end
	measure:SetText("0  0")
	local spaced = measure:GetStringWidth()
	measure:SetText("00")
	return spaced - measure:GetStringWidth()
end

local function SplitObjective(text)
	local have, need, name = text:match("^%s*(%d+)%s*/%s*(%d+)%s+(.+)$")
	if not have then
		name, have, need = text:match("^(.-):%s*(%d+)%s*/%s*(%d+)%s*$")
	end
	if not have then
		name, have, need = text:match("^(.-)：%s*(%d+)%s*/%s*(%d+)%s*$")
	end
	if have then
		return name, format("%s / %s", have, need)
	end
	return text
end

local objectiveCounts = {}

local recolorPending
local function RecolorCounts()
	recolorPending = nil
	for line, count in pairs(objectiveCounts) do
		if count:IsShown() then
			count:SetTextColor(line:GetTextColor())
		end
	end
end

function ns.ClearObjectiveCounts()
	for _, count in pairs(objectiveCounts) do
		count:Hide()
	end
end

local function MatchFont(region, source)
	local red, green, blue, alpha = region:GetTextColor()
	local fontObject = source:GetFontObject()
	if fontObject then
		region:SetFontObject(fontObject)
	else
		region:SetFont(source:GetFont())
	end
	region:SetSpacing(source:GetSpacing())
	region:SetTextColor(red, green, blue, alpha)
end

function ns.StyleObjective(line, text, finished, width, fontSource)
	local name, countText = SplitObjective(text or "")
	MatchFont(line, fontSource)
	line:SetText(ns.CheckIcon(line, finished) .. " " .. name)

	local count = objectiveCounts[line]
	if not count then
		count = line:GetParent():CreateFontString(nil, "ARTWORK")
		count:SetJustifyH("RIGHT")
		objectiveCounts[line] = count
	end
	if not countText then
		line:SetWidth(width)
		return
	end

	MatchFont(count, line)
	count:SetTextColor(line:GetTextColor())
	if not recolorPending then
		recolorPending = true
		C_Timer.After(0, RecolorCounts)
	end
	local inset = ns.TwoSpacesWide(count)
	count:SetText(countText)
	count:ClearAllPoints()
	count:SetPoint("TOPRIGHT", line, "TOPLEFT", width - inset, 0)
	count:Show()
	line:SetWidth(width - inset - count:GetStringWidth() - COUNT_GAP)
end
