local _, ns = ...

local sectionHeadingFont = CreateFont("WideQuestSectionHeadingFont")
local headingShrink = ns.LAYOUT.SECTION_HEADING_SHRINK

local function SyncSectionHeadingFont()
	local file, size, flags = QuestTitleFont:GetFont()
	if file and size then
		sectionHeadingFont:CopyFontObject(QuestTitleFont)
		sectionHeadingFont:SetFont(file, size - headingShrink, flags)
	end
end
SyncSectionHeadingFont()
for _, method in ipairs({ "SetFont", "SetShadowColor", "SetShadowOffset" }) do
	hooksecurefunc(QuestTitleFont, method, SyncSectionHeadingFont)
end

local function SetFontObjectKeepingColor(region, fontObject)
	local red, green, blue, alpha = region:GetTextColor()
	region:SetFontObject(fontObject)
	region:SetTextColor(red, green, blue, alpha)
end

function ns.StyleQuestText(region, sectionHeading, area)
	local font
	if sectionHeading then
		font = area and ns.AreaFont(area, sectionHeadingFont) or sectionHeadingFont
	elseif area then
		font = ns.AreaFont(area, region:GetFontObject())
	end
	if font and region:GetFontObject() ~= font then
		SetFontObjectKeepingColor(region, font)
	end
	region:SetSpacing(ns.LAYOUT.LINE_SPACING)
end
