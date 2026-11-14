local _, ns = ...

ns.DATABASE_DEFAULTS = {
	profile = {
		enableWideQuestLog = true,
		zoneGap = true,
		showQuestLevels = true,
		markUntracked = true,
		zoneSort = "LEVEL_HIGHEST_FIRST",
		currentZoneFirst = true,
		questSort = "LEVEL_HIGHEST_FIRST",
		completedFirst = true,
		closeInCombat = false,
		showObjectiveAreas = true,
		showZoneInfo = true,

		fonts = {
			list = { face = "", size = 0, outline = "DEFAULT", shadow = true, slug = false },
			details = { face = "", size = 0, outline = "DEFAULT", shadow = true, slug = false },
			window = { face = "", size = 0, outline = "DEFAULT", shadow = true, slug = false },
		},
	},
	global = {
		scale = 1,
		mapScale = 1,
	},
}
