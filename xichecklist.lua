addon.name     = 'xichecklist'
addon.author   = 'Anokata, ebartolome'
addon.version  = '0.3.0'
addon.commands = {'xichecklist', 'xic'}

local settings = require('settings')
local chat = require('chat')
local ui = require('ui')

-- Defaults
trackermenusettings = {
	pos = {x=50, y=80},
    visibility = true,
	showcompleted = false, -- true = display completed items listed in green
	showexcluded = false,  -- true = display hidden RoEs and excluded Titles and Crafting shield KIs
	initial=true
}

defaultplayertracker = {
	-- most initial values are zero, to be updated by addon
	mastery_rank = 0,
	-- Missions
	bastokmissions_completed = 0,
	bastokmissions_total = 0,
	sandoriamissions_completed = 0,
	sandoriamissions_total = 0,
	windurstmissions_completed = 0,
	windurstmissions_total = 0,
	zilartmissions_completed = 0,
	zilartmissions_total = 0,
	copmissions_completed = 0,
	copmissions_total = 0,
	ahturhganmissions_completed = 0,
	ahturhganmissions_total = 0,
	wotgmissions_completed = 0,
	wotgmissions_total = 0,
	acpmissions_completed = 0,
	acpmissions_total = 0,
	mkdmissions_completed = 0,
	mkdmissions_total = 0,
	asamissions_completed = 0,
	asamissions_total = 0,
	soamissions_completed = 0,
	soamissions_total = 0,
	rovmissions_completed = 0,
	rovmissions_total = 0,
	tvrmissions_completed = 0,
	tvrmissions_total = 0,
	-- Quests
	bastok_completed = 0,
	bastok_total = 0,
	sandoria_completed = 0,
	sandoria_total = 0,
	windurst_completed = 0,
	windurst_total = 0,
	jeuno_completed = 0,
	jeuno_total = 0,
	ahturhgan_completed = 0,
	ahturhgan_total = 0,
	assaults_completed = 0,
	assaults_total = 0,
	crystalwar_completed = 0,
	crystalwar_total = 0,
	outlands_completed = 0,
	outlands_total = 0,
	other_completed = 0,
	other_total = 0,
	abyssea_completed = 0,
	abyssea_total = 0,
	adoulin_completed = 0,
	adoulin_total = 0,
	coalition_completed = 0,
	coalition_total = 0,
	campaign_completed = 0,
	campaign_total = 0,
	-- Key items
	Permanent_Key_Items_completed = 0,
	Permanent_Key_Items_total = 0,
	Magical_Maps_completed = 0,
	Magical_Maps_total = 0,
	Mounts_completed = 0,
	Mounts_total = 0,
	Claim_Slips_completed = 0,
	Claim_Slips_total = 0,
	Active_Effects_completed = 0,
	Active_Effects_total = 0,
	Abyssea_completed = 0,
	Abyssea_total = 0,
	Voidwatch_completed = 0,
	Voidwatch_total = 0,
	Mog_Garden_completed = 0,
	Mog_Garden_total = 0,
	-- Magic / Corsair Roll / PUP attachments
	WhiteMagic_completed = 0,
	WhiteMagic_total = 0,
	BlackMagic_completed = 0,
	BlackMagic_total = 0,
	SummonerPact_completed = 0,
	SummonerPact_total = 0,
	Ninjutsu_completed = 0,
	Ninjutsu_total = 0,
	BardSong_completed = 0,
	BardSong_total = 0,
	BlueMagic_completed = 0,
	BlueMagic_total = 0,
	Geomancy_completed = 0,
	Geomancy_total = 0,
	Trust_completed = 0,
	Trust_total = 0,
	CorsairRoll_completed = 0,
	CorsairRoll_total = 31,
	pupattachments_completed = 0,
	pupattachments_total = 127,
	-- Exp
	meritpoints_completed = 0,
	meritpoints_total = 919,
	jobpoints_completed = 0,
	jobpoints_total = 22,
	masterlevels_completed = 0,
	masterlevels_total = 1100,
	masterlevels_highest = 0,
	-- Skills
	craftingskills_completed = 0,
	craftingskills_total = 790,
	-- Alter Ego
	alteregopoint_completed = 0,
	alteregopoint_total = 550,
	-- Warps
	zones_completed = 0,
	zones_total = 0,
	homepoints_completed = 0,
	homepoints_total = 0,
	survivalguides_completed = 0,
	survivalguides_total = 0,
	waypoints_completed = 0,
	waypoints_total = 0,
	telepoints_completed = 0,
	telepoints_total = 0,
	cavernousmaws_completed = 0,
	cavernousmaws_total = 9,
	lycopodium_completed = 0,
	lycopodium_total = 3,
	eschanportals_completed = 0,
	eschanportals_total = 0,
	-- unknown warp/map-related
	unknownwarps_unlocked = 0, -- not using _completed or _total, to avoid being calculated in total checklist progress
	unknownwarps_unlockable = 0,
	-- Monstrosity
	racejobinstinct_completed = 0,
	racejobinstinct_total = 0,
	monsterlevels_completed = 0,
	monsterlevels_total = 0,
	monstervariants_completed = 0,
	monstervariants_total = 0,
	monsterinsincts_completed = 0,
	monsterinsincts_total = 0,
	-- RoE
	roe_completed = 0,
	roe_total = 0,
	-- MMM
	mmmvouchers_completed = 0,
	mmmvouchers_total = 0,
	mmmrunes_completed = 0,
	mmmrunes_total = 0,
	-- NPC Menus
	mmm_mazecount = 0,
	wingskill_completed = 0,
	wingskill_total = 100,
	Titles_completed = 0,
	Titles_total = 0,
	outposts_completed = 0,
	outposts_total = 0,
	protowaypoints_completed = 0,
	protowaypoints_total = 0,
	fishes_completed = 0,
	fishes_total = 164,
	meebleburrows_completed = 0,
	meebleburrows_total = 0,
	atmacite_completed = 0,
	atmacite_total = 600,
	sheola_completed = 0,
	sheola_total = 0,
	sheolb_completed = 0,
	sheolb_total = 0,
	sheolc_completed = 0,
	sheolc_total = 0,
	sheolgaoltiers_completed = 0,
	sheolgaoltiers_total = 425,
	vorseals_completed = 0,
	vorseals_total = 0,
	ergonlocus_completed = 0,
	ergonlocus_total = 30,
	emporox_completed = 0,
	emporox_total = 0,
	titles = {}, -- {TitleId = true}
	outposts_unlocks = {}, -- {Menu Parameter Byte = true}
	protowaypoints_unlocks = {}, -- {Menu Parameter Byte = true}
	fishes_caught = {}, -- {Fish_ItemId = true}
	meeble_completed = {
		Sauromugue_Champaign = {},
		Batallia_Downs = {},
	},
	atmacite_levels = {},
	sheolabc = { --['Option Index'] = {[menu byte index] = value,},
		['2'] = {},
		['4'] = {},
		['5'] = {},
		['7'] = {},
	},
	sheolgaol = { --['Option Index'] = {[menu byte index] = true,},
		['8'] = {},
		['9'] = {},
		['10'] = {},
	},
	vorseals = {}, -- {Menu Parameter nibble = value}
	ergonlocus = {},
	emporox_unlocks = {}, -- {Menu Parameter Byte = true}
	abysseaconflux_completed = 0,
	abysseaconflux_total = 75,
	abysseaconflux_unlocks = { -- [zone id] = {menu bit index}
		["15"] = {}, -- Abyssea - Konschtat
		["45"] = {}, -- Abyssea - Tahrongi
		["132"] = {}, -- Abyssea - La Theine
		["215"] = {}, -- Abyssea - Attohwa
		["216"] = {}, -- Abyssea - Misareaux
		["217"] = {}, -- Abyssea - Vunkerl
		["218"] = {}, -- Abyssea - Altepa
		["253"] = {}, -- Abyssea - Uleguerand
		["254"] = {}, -- Abyssea - Grauberg
	},
	--
	corsairrolls = {},
	pupattachments = {
		['Available_Heads'] = {},
		['Available_Bodies'] = {},
		['Fire_Attachments'] = {},
		['Ice_Attachments'] = {},
		['Wind_Attachments'] = {},
		['Earth_Attachments'] = {},
		['Thunder_Attachments'] = {},
		['Water_Attachments'] = {},
		['Light_Attachments'] = {},
		['Dark_Attachments'] = {},
	},
	talk_to_npc = {
		outpostnpc = false,
		chatnachoq = false,
		protowaypoint = false,
		meeble_sauromugue = false,
		meeble_batallia = false,
		katsunaga = false,
		atmacite_refiner = false,
		chocobokid = false,
		['Aligi-Kufongi'] = false,
		['Koyol-Futenol'] = false,
		['Tamba-Namba'] = false,
		['Bhio_Fehriata'] = false,
		['Cattah_Pamjah'] = false,
		['Moozo-Koozo'] = false,
		['Styi_Palneh'] = false,
		['Burute-Sorute'] = false,
		['Tuh_Almobankha'] = false,
		['Zuah_Lepahnyu'] = false,
		['Shupah_Mujuuk'] = false,
		['Yulon-Polon'] = false,
		['Willah_Maratahya'] = false,
		['Eron-Tomaron'] = false,
		['Quntsu-Nointsu'] = false,
		['Debadle-Levadle'] = false,
		sheola = false,
		sheolb = false,
		sheolc = false,
		sheolgaol = false,
		vorseals = false,
		ergonlocus = false,
		emporox = false,
		['veridicalconflux_15'] = false,
		['veridicalconflux_45'] = false,
		['veridicalconflux_132'] = false,
		['veridicalconflux_215'] = false,
		['veridicalconflux_216'] = false,
		['veridicalconflux_217'] = false,
		['veridicalconflux_218'] = false,
		['veridicalconflux_253'] = false,
		['veridicalconflux_254'] = false,
	},
}

defaulttab_logs = {
	sandoriamissions = {name = 'San d\'Oria Missions', completed = 0, total = 0, items = {}},
	bastokmissions = {name = 'Bastok Missions', completed = 0, total = 0, items = {}},
	windurstmissions = {name = 'Windurst Missions', completed = 0, total = 0, items = {}},
	zilartmissions = {name = 'RotZ Missions', completed = 0, total = 0, items = {}},
	copmissions = {name = 'CoP Missions', completed = 0, total = 0, items = {}},
	assaults = {name = 'Assault Missions', completed = 0, total = 0, items = {}},
	ahturhganmissions = {name = 'ToAU Missions', completed = 0, total = 0, items = {}},
	campaign = {name = 'Campaign Ops', completed = 0, total = 0, items = {}},
	wotgmissions = {name = 'WotG Missions', completed = 0, total = 0, items = {}},
	acpmissions = {name = 'ACP  Missions', completed = 0, total = 0, items = {}},
	mkdmissions = {name = 'MKD  Missions', completed = 0, total = 0, items = {}},
	asamissions = {name = 'ASA  Missions', completed = 0, total = 0, items = {}},
	soamissions = {name = 'SoA  Missions', completed = 0, total = 0, items = {}},
	rovmissions = {name = 'RoV  Missions', completed = 0, total = 0, items = {}},
	tvrmissions = {name = 'TVR  Missions', completed = 0, total = 0, items = {}},
	sandoria = {name = 'San d\'Oria Quests', completed = 0, total = 0, items = {}},
	bastok = {name = 'Bastok Quests', completed = 0, total = 0, items = {}},
	windurst = {name = 'Windurst Quests', completed = 0, total = 0, items = {}},
	jeuno = {name = 'Jeuno Quests', completed = 0, total = 0, items = {}},
	ahturhgan = {name = 'Aht Urhgan Quests', completed = 0, total = 0, items = {}},
	crystalwar = {name = 'Crystal War Quests', completed = 0, total = 0, items = {}},
	outlands = {name = 'Outlands Quests', completed = 0, total = 0, items = {}},
	other = {name = 'Other Quests', completed = 0, total = 0, items = {}},
	abyssea = {name = 'Abyssea Quests', completed = 0, total = 0, items = {}},
	adoulin = {name = 'Adoulin Quests', completed = 0, total = 0, items = {}},
	coalition = {name = 'Coalition Assignments', completed = 0, total = 0, items = {}},
	atmacite = {name = 'Atmacite Levels', completed = 0, total = 600, items = {}},
	zones = {name = 'Zones Visited', completed = 0, total = 0, items = {}},
	homepoints = {name = 'Home Points', completed = 0, total = 0, items = {}},
	survivalguides = {name = 'Survival Guides', completed = 0, total = 0, items = {}},
	waypoints = {name = 'Adoulin Waypoint', completed = 0, total = 0, items = {}},
	telepoints = {name = 'Telepoints', completed = 0, total = 0, items = {}},
	cavernousmaws = {name = 'Cavernous Maws', completed = 0, total = 0, items = {}},
	unknownwarps = {name = 'Unknown Warps/Map-related', completed = 0, total = 0, items = {}},
	lycopodium = {name = 'Lycopodium', completed = 0, total = 0, items = {}},
	eschanportals = {name = 'Eschan Portals', completed = 0, total = 0, items = {}},
	outposts = {name = 'Outpost Warps', completed = 0, total = 0, items = {}},
	protowaypoints = {name = 'Proto-Waypoints', completed = 0, total = 0, items = {}},
	titles = {name = 'Titles', completed = 0, total = 0, items = {}},
	titles_by_content = {name = 'Titles by content (Sum)', completed = 0, total = 0, items = {}},
	titles_by_content_detailed = {name = 'Titles by content', completed = 0, total = 0, items = {}},
	fishes = {name = 'Types of Fishes Caught', completed = 0, total = 164, items = {}},
	monsterlevels = {name = 'Species Levels', completed = 0, total = 0, items = {}},
	monstervariants = {name = 'Monster Variants', completed = 0, total = 0, items = {}},
	racejobinstincts = {name = 'Race / Job Instincts', completed = 0, total = 0, items = {}},
	monsterinstincts = {name = 'Monster Instincts', completed = 0, total = 0, items = {}},
	roe = {name = 'RoE', completed = 0, total = 0, items = {}},
	mmm_mazecount = {name = 'MMM Maze count', completed = 0, total = 1000, items = {}},
	mmmvouchers = {name = 'MMM Vouchers Unlocked', completed = 0, total = 0, items = {}},
	mmmrunes = {name = 'MMM Runes Unlocked', completed = 0, total = 0, items = {}},
	meebleburrows = {name = 'Meeble Burrows', completed = 0, total = 0, items = {}},
	sheola = {name = 'Sheol A', completed = 0, total = 0, items = {}},
	sheolb = {name = 'Sheol B', completed = 0, total = 0, items = {}},
	sheolc = {name = 'Sheol C', completed = 0, total = 0, items = {}},
	sheolgaol = {name = 'Sheol Gaol Vengeance', completed = 0, total = 425, items = {}},
	vorseals = {name = 'Eschan Vorseals', completed = 0, total = 0, items = {}},
	ergonlocus = {name = 'Ergon Locus', completed = 0, total = 0, items = {}},
	emporox = {name = 'Emporox Goodness', completed = 0, total = 0, items = {}},
	WhiteMagic = {name = 'White Magic', completed = 0, total = 0, items = {}},
	BlackMagic = {name = 'Black Magic', completed = 0, total = 0, items = {}},
	SummonerPact = {name = 'Summoner Pacts', completed = 0, total = 0, items = {}},
	Ninjutsu = {name = 'Ninjutsu', completed = 0, total = 0, items = {}},
	BardSong = {name = 'Bard Songs', completed = 0, total = 0, items = {}},
	BlueMagic = {name = 'Blue Magic', completed = 0, total = 0, items = {}},
	Geomancy = {name = 'Geomancy', completed = 0, total = 0, items = {}},
	Trust = {name = 'Trust Magic', completed = 0, total = 0, items = {}},
	CorsairRoll = {name = 'Corsair Rolls', completed = 0, total = 31, items = {}},
	pupattachments = {name = 'PUP Attachments', completed = 0, total = 127, items = {}},
	Permanent_Key_Items = {name = 'Permanent Key Items', completed = 0, total = 0, items = {}},
	Magical_Maps = {name = 'Magical Maps', completed = 0, total = 0, items = {}},
	Mounts = {name = 'Mounts', completed = 0, total = 0, items = {}},
	Active_Effects = {name = 'Active Effects', completed = 0, total = 0, items = {}},
	Voidwatch = {name = 'Voidwatch', completed = 0, total = 0, items = {}},
	Abyssea = {name = 'Abyssea', completed = 0, total = 0, items = {}},
	Mog_Garden = {name = 'Mog Garden', completed = 0, total = 0, items = {}},
	Claim_Slips = {name = 'Claim Slips', completed = 0, total = 0, items = {}},
	jobpoints = {name = 'Job Points', completed = 0, total = 46200, items = {}},
	masterlevels = {name = 'Master Levels', completed = 0, total = 1100, items = {}},
	abysseaconflux = {name = 'Abyssea Conflux', completed = 0, total = 75, items = {}},
	--combatskills = {name = 'Combat Skills', completed = 0, total = 0, items = {}},
}

local default_settings = {
	playertracker=defaultplayertracker,
	trackermenusettings=trackermenusettings,
	tab_logs=defaulttab_logs
}

local charSettings = settings.load(default_settings);

playertracker=charSettings.playertracker
trackermenusettings=charSettings.trackermenusettings
tab_logs=charSettings.tab_logs

util = require('util/util')
quest_util = require('util/quests')
warps_util = require('util/warps')
mons_util = require('util/monstrosity')
roe_util = require('util/roe')
mmm_util = require('util/mmm')
menus_util = require('util/menus')


addon_setup = function()
	-- setup value instead of recalling/filtering them everytime
	local job_abilities = require('maps/job_abilities')
	local keyitem_exclusions = require('maps/keyitems_exclusions')
	local spells_exclusions = util.Set(require('maps/spells_exclusions'))
	local key_items = require('maps/key_items')
	local spells = require('maps/spells')

	keyitemids = {}
	
	for k, v in pairs(key_items) do
		local hidden = trackermenusettings.showexcluded and keyitem_exclusions.hidden or {}
		if not util.table_contains(util.Set(keyitem_exclusions.excluded), v.id) and not util.table_contains(util.Set(hidden), v.id) then table.insert(keyitemids, k) end
	end

	table.sort(keyitemids)

	keyitemids = util.Set(keyitemids)

	corsairrollsids = {}
	
	for k,v in pairs(job_abilities) do
		if v.type == "CorsairRoll" then table.insert(corsairrollsids, k) end
	end

	table.sort(corsairrollsids)

	corsairrollsids = util.Set(corsairrollsids)

	spellids = {}
	
	for k, v in pairs(spells) do
		if (not v.unlearnable) and (not spells_exclusions[v.id]) then table.insert(spellids, k) end
	end

	table.sort(spellids)

	spellids = util.Set(spellids)
end

addon_setup()

function get_bits_be(data, startByte, startBit, n)
	local result = {}
	for i = startBit, startBit+n-1 do
		result[i+1-startBit] = (ashita.bits.unpack_be(data, startByte, i, 1) == 1);
	end
	return result
end

ashita.events.register('packet_in', 'incoming chunk', function(e)
	
	if e.id == 0x008 then
		-- do visited zones
		warps_util.log_visitedzones(e)
	
	elseif e.id == 0x01B then
		--mastery rank
		local mastery_rank = struct.unpack('H', e.data, 0x66 + 0x01)
		if (mastery_rank > playertracker.mastery_rank) then
			if (playertracker.mastery_rank > 0) then
				util.addon_log('Mastery Rank increase '..mastery_rank)
			end
			playertracker.mastery_rank = mastery_rank
			settings.save()
		elseif (mastery_rank < playertracker.mastery_rank) then
			util.addon_log('Mastery Rank decrease: '..mastery_rank)
			playertracker.mastery_rank = mastery_rank
			settings.save()
		end

	elseif e.id == 0x044 then
		-- PUP attachments
		local job = struct.unpack('B', e.data, 0x04 + 0x01)
		local subjob = struct.unpack('B', e.data, 0x05 + 0x01)
		if job == 18 and subjob == 0 then -- if PUP main
			update_pupattachments(e)
		end

	
	elseif e.id == 0x056 then
		-- do quests
		local type = struct.unpack('H', e.data, 0x24 + 0x01)
		local log = quest_logs[type]
		if log then
			if ((type == 0x0080)) then -- if Aht Urhgan Current Quests
				local CurrentAhtUrhganQuests = get_bits_be(e.data_raw, 0x04, 0, 128)
				quests[log.type][log.area] = CurrentAhtUrhganQuests
			elseif ((type == 0x00C0)) then -- if Aht Urhgan Completed Quests
				local CompletedAhtUrhganQuests = get_bits_be(e.data_raw, 0x04, 0, 128)
				local CompletedAssaults = get_bits_be(e.data_raw, 0x14, 0, 128)
				quests[log.type][log.area] = CompletedAhtUrhganQuests
				quests.completed.assaults = CompletedAssaults
				quest_util.log_quests(log.area)
				quest_util.log_quests('assaults')
			elseif (type == 0x00D0) then -- if Nation, Zilart Completed Missions
				quests.completed.sandoriamissions = get_bits_be(e.data_raw, 0x04, 0, 64)
				quests.completed.bastokmissions = get_bits_be(e.data_raw, 0x0C, 0, 64)
				quests.completed.windurstmissions = get_bits_be(e.data_raw, 0x14, 0, 64)
				quests.completed.zilartmissions = get_bits_be(e.data_raw, 0x1C, 0, 64)
				quest_util.log_quests('sandoriamissions')
				quest_util.log_quests('bastokmissions')
				quest_util.log_quests('windurstmissions')
				quest_util.log_quests('zilartmissions')
			elseif (type == 0x00D8) then -- if TOAU, WOTG Completed Missions
				quests.completed.ahturhganmissions = get_bits_be(e.data_raw, 0x04, 0, 64)
				quests.completed.wotgmissions = get_bits_be(e.data_raw, 0x0C, 0, 64)
				quest_util.log_quests('ahturhganmissions')
				quest_util.log_quests('wotgmissions')
			elseif (type == 0xFFFE) then -- if TVR Current Missions
				quest_util.log_missions('tvrmissions', struct.unpack('I', e.data, 0x04 + 0x01))
			elseif (type == 0xFFFF) then -- if Other Current Missions
				quest_util.log_missions('copmissions', struct.unpack('I', e.data, 0x10 + 0x01))
				quest_util.log_missions('acpmissions', get_bits_be(e.data_raw, 0x18, 0, 4))
				quest_util.log_missions('mkdmissions', get_bits_be(e.data_raw, 0x18, 4, 4))
				quest_util.log_missions('asamissions', get_bits_be(e.data_raw, 0x19, 0, 4))
				quest_util.log_missions('soamissions', struct.unpack('I', e.data, 0x1C + 0x01))
				quest_util.log_missions('rovmissions', struct.unpack('I', e.data, 0x20 + 0x01))
			else
				local QuestFlags = get_bits_be(e.data_raw, 0x04, 0, 256)
				quests[log.type][log.area] = QuestFlags
				quest_util.log_quests(log.area)
			end
		end

	elseif e.id == 0x062 then
		-- crafting skills
		local total_crafting_skills = 0
		local craftBase = 4 + (31*4) + (48*2) + 1;
		for i = 0,8 do
			local offset = craftBase + i*2
			local skillBase = ashita.bits.unpack_be(e.data_raw, offset, 6, 10)
			local reversedValue = util.reverse(skillBase, 10)
			total_crafting_skills = total_crafting_skills + reversedValue
		end
		playertracker.craftingskills_completed = total_crafting_skills
	
	elseif e.id == 0x063 then
		local order = struct.unpack('H', e.data, 0x04 + 0x01)
		-- do warps
		if (order == 6) then 
			warps_util.warps_data = e.data_raw
			warps_util.log_warps('homepoints')
			warps_util.log_warps('survivalguides')
			warps_util.log_warps('waypoints')
			warps_util.log_warps('telepoints')
			warps_util.log_warps('cavernousmaws')
			warps_util.log_unknownwarps('unknownwarps')
			warps_util.log_warps('lycopodium')
			warps_util.log_warps('eschanportals')
		end
		-- do monstrosity
		if (order == 3) then
			local MonsterLevelCharField = {}
			for i = 0,1023 do
				MonsterLevelCharField[i+1] = (ashita.bits.unpack_be(e.data_raw, 0x5c, i, 1) == 1);
			end
			local InstinctBitfield = {}
			for i = 0,511 do
				InstinctBitfield[i+1] = (ashita.bits.unpack_be(e.data_raw, 0x1c, i, 1) == 1);
			end
			mons_util.monster_levelspacket[1] = MonsterLevelCharField
			mons_util.monsterinstincts = util.twobits_to_table(InstinctBitfield)
			mons_util.log_monsterlevels()
			mons_util.log_monsterinstincts()
		end
		if (order == 4) then
			local InstinctBitfield3 = {}
			for i = 0,95 do
				InstinctBitfield3[i+1] = (ashita.bits.unpack_be(e.data_raw, 0x88, i, 1) == 1);
			end
			local VariantsBitfield = {}
			for i = 0,255 do
				VariantsBitfield[i+1] = (ashita.bits.unpack_be(e.data_raw, 0x94, i, 1) == 1);
			end
			local MonsterLevelCharField2 = {}
			for i = 0,15 do
				MonsterLevelCharField2[i+1] = (ashita.bits.unpack_be(e.data_raw, 0x86, i, 1) == 1);
			end
			mons_util.monster_levelspacket[2] = MonsterLevelCharField2
			mons_util.racejobinstincts = InstinctBitfield3
			mons_util.variants_bitfield = VariantsBitfield
			mons_util.log_monsterlevels()
			mons_util.log_variants()
			mons_util.log_racejobinstincts()
		end

	elseif (e.id == 0x08c) then
		-- Log Merit points
		local count = struct.unpack('B', e.data, 0x04 + 0x01)

		local total_merit_upgrades = 0
		local meritBase = 1 + 3 + 1;
		for i=1,count do
			local offset = meritBase + i * 4
			local value = struct.unpack('B', e.data, offset + 3)
			total_merit_upgrades = total_merit_upgrades + value
		end
		playertracker.meritpoints_completed = total_merit_upgrades
	
	elseif (e.id == 0x033) or (e.id == 0x034) then
		-- handle npc menu
		menus_util.handle_npc_menu(e)
		updatemenulogs()

	elseif e.id == 0x061 then
		-- check player info (updated when opening menu)
		local title = struct.unpack('H', e.data, 0x44 + 0x01)
		menus_util.add_title(title)
		updatemenulogs()

	elseif e.id == 0x05C then
		if menu_current.npcindex then menus_util.handle_npc_submenu(e) end
		updatemenulogs()

	
	elseif e.id == 0x112 then
		-- do RoE
		if (not roe_data) then roe_data = {[0]=nil, [1]=nil, [2]=nil, [3]=nil} end
		local port = struct.unpack('I', e.data, 0x84 + 0x01)
		local RoEFlags = {}
		for i = 0,1023 do
			RoEFlags[i+1] = (ashita.bits.unpack_be(e.data_raw, 0x04, i, 1) == 1);
		end
		roe_data[port] = RoEFlags -- the packet will be repeated three times, gather the data first
		if (roe_data[0]~=nil and roe_data[1]~=nil and roe_data[2]~=nil and roe_data[3]~=nil) then
			local concatRoE = {}
			for i=0,3 do	
				util.table_concat(concatRoE, roe_data[i])
			end
			roe_util.log_roe(concatRoE)
		end

	
	elseif e.id == 0x0AD then
		-- do MMM
		mmm_util.handle_mmm_data(e.data_raw)
		mmm_util.log_vouchers()
		mmm_util.log_runes()

	elseif e.id == 0x052 then
		-- clear npc menu
		menus_util.reset_current_menu()
	
	elseif e.id == 0x08E then
		-- do Alter Ego Points
		local alteregopoint_completed = 0
		--local alteregopoint_total = 0
		for i = 17, 27 do -- Bytes 17 to 27 for HP MP etc etc -> Magic Skill (update when they add more)
			alteregopoint_completed = alteregopoint_completed + string.byte(e.data, i)
			--alteregopoint_total = alteregopoint_total + 50
		end
		playertracker.alteregopoint_completed = alteregopoint_completed
		--playertracker.alteregopoint_total = alteregopoint_total
	else
		return
	end
	updatetabs()
end)

ashita.events.register('packet_out', 'outgoing chunk', function(e)
	
	-- listen to menu options
	if (e.id==0x05B) then
		menus_util.handle_menu_options(e) -- READ outgoing menu selection to determine which menu
	end
end)

updatemenulogs = function()
	menus_util.log_outposts()
	menus_util.log_protowaypoints()
	menus_util.log_fishes()
	menus_util.log_atmacitelevels()
	menus_util.log_meeble_burrows()
	menus_util.log_titles()
	menus_util.list_titles_bycontent()
	menus_util.list_titles_bycontent_detailed()
	menus_util.log_sheolabc('sheola')
	menus_util.log_sheolabc('sheolb')
	menus_util.log_sheolabc('sheolc')
	menus_util.log_sheolgaol()
	menus_util.log_vorseals()
	menus_util.log_ergonlocus()
	menus_util.log_emporox()
	menus_util.log_abyssea_conflux()
end

updatetabs = function()
	if not player then return false end
	
	log_spells()
	log_keyitems()
	
	log_corsairrolls()
	log_pupattachments()
	log_exp()
	
	tab_logs.mmm_mazecount.completed = playertracker.mmm_mazecount
end

log_keyitems = function()
	local keyitems = require('maps/key_items')
	local playMgr = AshitaCore:GetMemoryManager():GetPlayer();
	local keyitemtypeTracker = {
		['Permanent Key Items'] = {total=0, completed=0, output_list={}},
		['Magical Maps'] = {total=0, completed=0, output_list={}},
		['Claim Slips'] = {total=0, completed=0, output_list={}},
		['Active Effects'] = {total=0, completed=0, output_list={}},
		['Voidwatch'] = {total=0, completed=0, output_list={}},
		['Mounts'] = {total=0, completed=0, output_list={}},
		['Mog Garden'] = {total=0, completed=0, output_list={}},
		['Abyssea'] = {total=0, completed=0, output_list={}}
	}
	for id, _ in pairs(keyitemids) do
		local keyitem_name = AshitaCore:GetResourceManager():GetString('keyitems.names', id):gsub("[^\x00-\x7F]", "")
		local keyitemtype = keyitems[id].category
		if keyitemtypeTracker[keyitemtype] then
			keyitemtypeTracker[keyitemtype].total = keyitemtypeTracker[keyitemtype].total + 1
			local completion = false
			if playMgr:HasKeyItem(id) then
				-- key item obtained
				keyitemtypeTracker[keyitemtype].completed = keyitemtypeTracker[keyitemtype].completed + 1
				completion = true
			end
			table.insert(keyitemtypeTracker[keyitemtype].output_list, util.list_item(nil, keyitem_name, completion))
		end
	end
	for keyitemtype, values in pairs(keyitemtypeTracker) do
		playertracker[util.cleanspaces(keyitemtype)..'_completed'] = values.completed
		playertracker[util.cleanspaces(keyitemtype)..'_total'] = values.total
		tab_logs[util.cleanspaces(keyitemtype)] = {
			name = tab_logs[util.cleanspaces(keyitemtype)].name,
			completed = values.completed,
			total = values.total,
			items = values.output_list
		}
	end
end

log_spells = function()
	local spells_exclusions = util.Set(require('maps/spells_exclusions'))
	local playMgr = AshitaCore:GetMemoryManager():GetPlayer();
	local magictypeTracker = {
		[1] = {name='WhiteMagic', total=0, completed=0, output_list={}},
		[2] = {name='BlackMagic', total=0, completed=0, output_list={}},
		[3] = {name='SummonerPact', total=0, completed=0, output_list={}},
		[4] = {name='Ninjutsu', total=0, completed=0, output_list={}},
		[5] = {name='BardSong', total=0, completed=0, output_list={}},
		[6] = {name='BlueMagic', total=0, completed=0, output_list={}},
		[7] = {name='Geomancy', total=0, completed=0, output_list={}},
		[8] = {name='Trust', total=0, completed=0, output_list={}},
	}
	for id, _ in pairs(spellids) do
		local completion = false
		local spell = AshitaCore:GetResourceManager():GetSpellById(id)
		local type = spell.Type
		magictypeTracker[type].total = magictypeTracker[type].total + 1
		if playMgr:HasSpell(id) then
			-- spell learned
			magictypeTracker[type].completed = magictypeTracker[type].completed + 1
			completion = true
		end
		table.insert(magictypeTracker[type].output_list, util.list_item(nil, spell.Name[1], completion))
	end
	for _, magictype in ipairs(magictypeTracker) do
		playertracker[magictype.name..'_completed'] = magictype.completed
		playertracker[magictype.name..'_total'] = magictype.total
		tab_logs[magictype.name] = {
			name = tab_logs[magictype.name].name,
			completed = magictype.completed,
			total = magictype.total,
			items = magictype.output_list
		}
	end
end

function check_exp()
	local total_jp_spent = 0
	local total_master_levels = 0
	local highest_master_level = 0
	local playerinfo = AshitaCore:GetMemoryManager():GetPlayer()

	-- job points
	for id=1,22 do
		local completion = false
		total_jp_spent = total_jp_spent + playerinfo:GetJobPointsSpent(id)
		if playerinfo:GetJobPointsSpent(id) == 2100 then completion = true end
		table.insert(jp_output_list, util.list_item(nil, job..' '..playerinfo.job_points[job].jp_spent..'/2100', completion))
		total_jp_spent = total_jp_spent + playerinfo:GetJobPointsSpent(id)
	end
	playertracker.jobpoints_completed = math.floor(total_jp_spent/2100)
	playertracker.jobpoints_total = 22
	-- master levels
	for id=1,22 do
		total_master_levels = total_master_levels + playerinfo:GetJobMasterLevel(id)
		if (playerinfo:GetJobMasterLevel(id) > highest_master_level) then highest_master_level = playerinfo:GetJobMasterLevel(id) end
	end
	tab_logs['Masterlevels_completed'] = total_master_levels
	tab_logs['Masterlevels_highest'] = highest_master_level
end

log_exp = function()
	local jp_output_list = {}
	local ml_output_list = {}
	local total_jp_spent = 0
	local total_master_levels = 0
	local highest_master_level = 0
	local playerinfo = AshitaCore:GetMemoryManager():GetPlayer()
	local jobs = require('maps/jobs')

	-- job points
	for id=1,22 do
		local completion = false
		total_jp_spent = total_jp_spent + playerinfo:GetJobPointsSpent(id)
		if playerinfo:GetJobPointsSpent(id) == 2100 then completion = true end
		table.insert(jp_output_list, util.list_item(nil, jobs[id].en..' '..playerinfo:GetJobPointsSpent(id)..'/2100', completion))
	end
	playertracker.jobpoints_completed = math.floor(total_jp_spent/2100)
	playertracker.jobpoints_total = 22
	-- master levels
	for id=1,22 do
		local completion = false
		total_master_levels = total_master_levels + playerinfo:GetJobMasterLevel(id)
		if playerinfo:GetJobMasterLevel(id) == 50 then completion = true end
		table.insert(ml_output_list, util.list_item(nil, jobs[id].en..' '..playerinfo:GetJobMasterLevel(id)..'/50', completion))
		if (playerinfo:GetJobMasterLevel(id) > highest_master_level) then highest_master_level = playerinfo:GetJobMasterLevel(id) end
	end
	playertracker.masterlevels_completed = total_master_levels
	playertracker.masterlevels_highest = highest_master_level
	tab_logs.jobpoints = {
		name = tab_logs.jobpoints.name,
		completed = total_jp_spent,
		total = 46200,
		items = jp_output_list
	}
	tab_logs.masterlevels = {
		name = tab_logs.masterlevels.name,
		completed = total_master_levels,
		total = 1100,
		items = ml_output_list
	}
end

log_corsairrolls = function()
	local output_list = {}
	local total, obtained = 0, 0
	local job_abilities = require('maps/job_abilities')
	local playerinfo = AshitaCore:GetMemoryManager():GetPlayer()

	for id, _ in pairs(corsairrollsids) do
		local completion = false
		total = total + 1
		if (playerinfo:HasAbility(id) == true) or (playertracker.corsairrolls[id] == true) then
			-- roll learned
			obtained = obtained + 1
			playertracker.corsairrolls[id] = true
			completion = true
		end
		table.insert(output_list, util.list_item(nil, job_abilities[id].en, completion))
	end
	playertracker.CorsairRoll_total = total
	if obtained > playertracker.CorsairRoll_completed then -- to avoid spam save()
		playertracker.CorsairRoll_completed = obtained
		settings.save()
	end
	tab_logs.CorsairRoll = {
		name = tab_logs.CorsairRoll.name,
		completed = obtained,
		total = total,
		items = output_list
	}
end

update_pupattachments = function(e)
	local total, obtained = 0, 0
	local pup_map = require('maps/pup')
	local pup_bitfields = {
		['Available_Heads'] = 0x018,
		['Available_Bodies'] = 0x01C,
		['Fire_Attachments'] = 0x038,
		['Ice_Attachments'] = 0x03C,
		['Wind_Attachments'] = 0x040,
		['Earth_Attachments'] = 0x044,
		['Thunder_Attachments'] = 0x048,
		['Water_Attachments'] = 0x04C,
		['Light_Attachments'] = 0x050,
		['Dark_Attachments'] = 0x054,
	}
	for pupattachments_category, start in pairs(pup_bitfields) do
		local bitfield = {}
		for i = 0,31 do
			bitfield[i+1] = (ashita.bits.unpack_be(e.data_raw, start, i, 1) == 1);
		end
		for id, name in pairs(pup_map[pupattachments_category]) do
			total = total + 1
			if util.has_bit(bitfield, id+1) then
				obtained = obtained + 1
				playertracker.pupattachments[pupattachments_category][id] = true
			end
		end
	end
	playertracker.pupattachments_total = total
	if obtained > playertracker.pupattachments_completed then -- to avoid spam save()
		playertracker.pupattachments_completed = obtained
		settings.save()
	end
end

log_pupattachments = function()
	local output_list = {}
	local total, obtained = 0, 0
	local pup_map = require('maps/pup')
	for pupattachments_category, attachments in pairs(pup_map) do
		for id, name in pairs(attachments) do
			local completion = false
			total = total + 1
			if playertracker.pupattachments[pupattachments_category][id] == true then
				obtained = obtained + 1
				completion = true
			end
			table.insert(output_list, util.list_item(nil, name, completion))
		end
	end
	tab_logs.pupattachments = {
		name = tab_logs.pupattachments.name,
		completed = obtained,
		total = total,
		items = output_list
	}
end
-------------------------------------------------
ashita.events.register('d3d_present', 'present_cb', ui.render);

ashita.events.register('command', 'checklist_command', function(e)
	local args = e.command:args();
    if (#args == 0 or (args[1] ~= "/xic" and args[1] ~= "/xichecklist")) then
        return;
    end
	local quests_location = {'sandoria', 'bastok', 'windurst', 'jeuno', 'ahturhgan', 'assaults', 'crystalwar', 'outlands', 'other', 'abyssea', 'adoulin', 'coalition', 'sandoriamissions', 'bastokmissions', 'windurstmissions', 'zilartmissions', 'ahturhganmissions', 'wotgmissions', 'copmissions', 'acpmissions', 'mkdmissions', 'asamissions', 'soamissions', 'rovmissions', 'tvrmissions'}
	if (#args == 2 or #args == 3) then
		if args[2] == 'showcomplete' then
			print(chat.header(addon.name):append(chat.message('Switched showcompleted setting')))
			if trackermenusettings.showcompleted then
				trackermenusettings.showcompleted = false
			else
				trackermenusettings.showcompleted = true
			settings.save()
			end
		elseif (args[2] == "h" or args[2] == "help") then
			print(chat.header(addon.name):append(chat.message('==== xichecklist / xic ====')))
			print(chat.header(addon.name):append(chat.message('/xic [show|hide] to show / hide UI')))
			print(chat.header(addon.name):append(chat.message('/xic log <category> to log in chat')))
			print(chat.header(addon.name):append(chat.message('==== ==== ==== ====')))
			print(chat.header(addon.name):append(chat.message('Require zoning to update Quests / Warps / Monstrosity / MMM')))
			print(chat.header(addon.name):append(chat.message('==== ==== ==== ====')))
			print(chat.header(addon.name):append(chat.message('Require talking to NPCs to register the following (Check README)')))
			print(chat.header(addon.name):append(chat.message(chat.color1(261, 'Titles')..'-> 16 Title Changer NPCs')))
			print(chat.header(addon.name):append(chat.message(chat.color1(261, 'Fish caught')..'-> Katsunaga in Mhaura (Menu: Types of fish caught)')))
			print(chat.header(addon.name):append(chat.message(chat.color1(261, 'Meeble Burrows')..'-> any Burrow Researcher or Burrow Investigator')))
			print(chat.header(addon.name):append(chat.message(chat.color1(261, 'Outpost Warps')..'-> any Nation Teleporter')))
			print(chat.header(addon.name):append(chat.message(chat.color1(261, 'MMM Maze Count')..'-> Chatnachoq (LowerJeuno)')))
			print(chat.header(addon.name):append(chat.message(chat.color1(261, 'Proto-Waypoint')..'-> any Proto-Waypoints')))
			print(chat.header(addon.name):append(chat.message(chat.color1(261, 'Atmacite Levels')..'-> any Atmacite Refiner (Enrich Atmacite)')))
			print(chat.header(addon.name):append(chat.message(chat.color1(261, 'Wing Skill')..'-> Nation Chocobo Stable kids')))
			print(chat.header(addon.name):append(chat.message(chat.color1(261, 'Sheol Gaol Vengeance')..'-> ??? in Rabao (Status Report: Sheol Gaol)')))
			print(chat.header(addon.name):append(chat.message(chat.color1(261, 'Escha Vorseals')..'-> Shiftrix in Reisenjima')))
			print(chat.header(addon.name):append(chat.message(chat.color1(261, 'Ergon Locus')..'-> Rienne in Western Adoulin')))
			print(chat.header(addon.name):append(chat.message(chat.color1(261, 'Emporox Goodness')..'-> Emporox in Reisenjima')))
		elseif args[2] == 'show' then
			trackermenusettings.visibility = true
			settings.save()
		elseif args[2] == 'hide' then
			trackermenusettings.visibility = false
			settings.save()
		elseif args[2] == 'reload' then
			settings.reload()
		elseif args[2] == 'showcompleted' then
			trackermenusettings.showcompleted = not trackermenusettings.showcompleted
			util.addon_log('showcompleted: '..tostring(trackermenusettings.showcompleted))
			settings.save()
			updatemenulogs()
		elseif args[2] == 'showexcluded' then
			trackermenusettings.showexcluded = not trackermenusettings.showexcluded
			util.addon_log('showexcluded: '..tostring(trackermenusettings.showexcluded))
			settings.save()
			updatemenulogs()
		elseif args[2] == 'log' then
			if (args[3]) then
				if args[3]:lower() == 'titles' then
					util.log_tablog(tab_logs.titles.items)
					print(chat.header(addon.name):append(chat.message(('=== Titles (%d/%d) ==='):format(playertracker.Titles_completed, playertracker.Titles_total))))
				elseif args[3]:lower() == 'monstrosity' then
					print(chat.header(addon.name):append(chat.message(('=== Species Levels (%d/%d) ==='):format(playertracker.monsterlevels_completed, playertracker.monsterlevels_total))))
					util.log_tablog(tab_logs.monsterlevels.items)
					print(chat.header(addon.name):append(chat.message(('=== Monster Variants (%d/%d) ==='):format(playertracker.monstervariants_completed, playertracker.monstervariants_total))))
					util.log_tablog(tab_logs.monstervariants.items)
					print(chat.header(addon.name):append(chat.message(('=== Race / Job Instincts (%d/%d) ==='):format(playertracker.racejobinstinct_completed, playertracker.racejobinstinct_total))))
					util.log_tablog(tab_logs.racejobinstincts.items)
					print(chat.header(addon.name):append(chat.message(('=== Monster Instincts (%d/%d) ==='):format(playertracker.monsterinsincts_completed, playertracker.monsterinsincts_total))))
					util.log_tablog(tab_logs.monster_instincts.items)
				elseif args[3]:lower() == 'mmm' then
					print(chat.header(addon.name):append(chat.message(('=== MMM Vouchers Unlocks (%d/%d) ==='):format(playertracker.mmmvouchers_completed, playertracker.mmmvouchers_total))))
					util.log_tablog(tab_logs.mmmvouchers.items)
					print(chat.header(addon.name):append(chat.message(('=== MMM Runes Unlocks (%d/%d) ==='):format(playertracker.mmmrunes_completed, playertracker.mmmrunes_total))))
					util.log_tablog(tab_logs.mmmrunes.items)
				elseif args[3]:lower() == 'meeble' then
					print(chat.header(addon.name):append(chat.message(('=== Meeble Burrows (%d/%d) ==='):format(playertracker.meebleburrows_completed, playertracker.meebleburrows_total))))
					util.log_tablog(tab_logs.meeble_burrows.items)
				elseif args[3]:lower() == 'zones' then
					print(chat.header(addon.name):append(chat.message(('=== Zones (%d/%d) ==='):format(playertracker.zones_completed, playertracker.zones_total))))
					util.log_tablog(tab_logs.zones.items)
				elseif args[3]:lower() == 'warps' then
					print(chat.header(addon.name):append(chat.message(('=== Home Points (%d/%d) ==='):format(playertracker.homepoints_completed, playertracker.homepoints_total))))
					util.log_tablog(tab_logs.homepoints.items)
					print(chat.header(addon.name):append(chat.message(('=== Survival Guides (%d/%d) ==='):format(playertracker.survivalguides_completed, playertracker.survivalguides_total))))
					util.log_tablog(tab_logs.survivalguides.items)
					print(chat.header(addon.name):append(chat.message(('=== Adoulin Waypoints (%d/%d) ==='):format(playertracker.waypoints_completed, playertracker.waypoints_total))))
					util.log_tablog(tab_logs.waypoints.items)
					print(chat.header(addon.name):append(chat.message(('=== Outpost Warps (%d/%d) ==='):format(playertracker.outposts_completed, playertracker.outposts_total))))
					util.log_tablog(tab_logs.outposts.items)
					print(chat.header(addon.name):append(chat.message(('=== Proto-Waypoints (%d/%d) ==='):format(playertracker.protowaypoints_completed, playertracker.protowaypoints_total))))
					util.log_tablog(tab_logs.protowaypoints.items)
					print(chat.header(addon.name):append(chat.message(('=== Cavernous Maws (%d/%d) ==='):format(playertracker.cavernousmaws_completed, playertracker.cavernousmaws_total))))
					util.log_tablog(tab_logs.cavernousmaws.items)
					print(chat.header(addon.name):append(chat.message(('=== Lycopodium (%d/%d) ==='):format(playertracker.lycopodium_completed, playertracker.lycopodium_total))))
					util.log_tablog(tab_logs.lycopodium.items)
					print(chat.header(addon.name):append(chat.message(('=== Eschan Portals (%d/%d) ==='):format(playertracker.eschanportals_completed, playertracker.eschanportals_total))))
					util.log_tablog(tab_logs.eschanportals.items)
				elseif args[3]:lower() == 'fish' then
					print(chat.header(addon.name):append(chat.message(('=== Type of Fish (%d/%d) ==='):format(playertracker.fishes_completed, playertracker.fishes_total))))
					util.log_tablog(tab_logs.fishes.items)
				elseif args[3]:lower() == 'missions' then
					print(chat.header(addon.name):append(chat.message(('=== San d\'Oria Missions (%d/%d) ==='):format(playertracker.sandoriamissions_completed, playertracker.sandoriamissions_total))))
					util.log_tablog(tab_logs.sandoriamissions.items)
					print(chat.header(addon.name):append(chat.message(('Bastok Missions (%d/%d) ==='):format(playertracker.bastokmissions_completed, playertracker.bastokmissions_total))))
					util.log_tablog(tab_logs.bastokmissions.items)
					print(chat.header(addon.name):append(chat.message(('Windurst Missions (%d/%d) ==='):format(playertracker.windurstmissions_completed, playertracker.windurstmissions_total))))
					util.log_tablog(tab_logs.windurstmissions.items)
					print(chat.header(addon.name):append(chat.message(('Zilart Missions (%d/%d) ==='):format(playertracker.zilartmissions_completed, playertracker.zilartmissions_total))))
					util.log_tablog(tab_logs.zilartmissions.items)
					print(chat.header(addon.name):append(chat.message(('CoP Missions (%d/%d) ==='):format(playertracker.copmissions_completed, playertracker.copmissions_total))))
					util.log_tablog(tab_logs.copmissions.items)
					print(chat.header(addon.name):append(chat.message(('TOAU Missions (%d/%d) ==='):format(playertracker.ahturhganmissions_completed, playertracker.ahturhganmissions_total))))
					util.log_tablog(tab_logs.ahturhganmissions.items)
					print(chat.header(addon.name):append(chat.message(('Assaults (%d/%d) ==='):format(playertracker.assaults_completed, playertracker.assaults_total))))
					util.log_tablog(tab_logs.assaults.items)
					print(chat.header(addon.name):append(chat.message(('WOTG Missions (%d/%d) ==='):format(playertracker.wotgmissions_completed, playertracker.wotgmissions_total))))
					util.log_tablog(tab_logs.wotgmissions.items)
					print(chat.header(addon.name):append(chat.message(('ACP Missions (%d/%d) ==='):format(playertracker.acpmissions_completed, playertracker.acpmissions_total))))
					util.log_tablog(tab_logs.acpmissions.items)
					print(chat.header(addon.name):append(chat.message(('MKD Missions (%d/%d) ==='):format(playertracker.mkdmissions_completed, playertracker.mkdmissions_total))))
					util.log_tablog(tab_logs.mkdmissions.items)
					print(chat.header(addon.name):append(chat.message(('ASA Missions (%d/%d) ==='):format(playertracker.asamissions_completed, playertracker.asamissions_total))))
					util.log_tablog(tab_logs.asamissions.items)
					print(chat.header(addon.name):append(chat.message(('SoA Missions (%d/%d) ==='):format(playertracker.soamissions_completed, playertracker.soamissions_total))))
					util.log_tablog(tab_logs.soamissions.items)
					print(chat.header(addon.name):append(chat.message(('RoV Missions (%d/%d) ==='):format(playertracker.rovmissions_completed, playertracker.rovmissions_total))))
					util.log_tablog(tab_logs.rovmissions.items)
					print(chat.header(addon.name):append(chat.message(('TVR Missions (%d/%d) ==='):format(playertracker.tvrmissions_completed, playertracker.tvrmissions_total))))
					util.log_tablog(tab_logs.tvrmissions.items)
				elseif args[3]:lower() == 'quests' then
					print(chat.header(addon.name):append(chat.message(('=== San d\'Oria Quests (%d/%d) ==='):format(playertracker.sandoria_completed, playertracker.sandoria_total))))
					util.log_tablog(tab_logs.sandoria.items)
					print(chat.header(addon.name):append(chat.message(('=== Bastok Quests (%d/%d) ==='):format(playertracker.bastok_completed, playertracker.bastok_total))))
					util.log_tablog(tab_logs.bastok.items)
					print(chat.header(addon.name):append(chat.message(('=== Windurst Quests (%d/%d) ==='):format(playertracker.windurst_completed, playertracker.windurst_total))))
					util.log_tablog(tab_logs.windurst.items)
					print(chat.header(addon.name):append(chat.message(('=== Jeuno Quests (%d/%d) ==='):format(playertracker.jeuno_completed, playertracker.jeuno_total))))
					util.log_tablog(tab_logs.jeuno.items)
					print(chat.header(addon.name):append(chat.message(('=== Aht Urhgan Quests (%d/%d) ==='):format(playertracker.ahturhgan_completed, playertracker.ahturhgan_total))))
					util.log_tablog(tab_logs.ahturhgan.items)
					print(chat.header(addon.name):append(chat.message(('=== Crystal War Quests (%d/%d) ==='):format(playertracker.crystalwar_completed, playertracker.crystalwar_total))))
					util.log_tablog(tab_logs.crystalwar.items)
					print(chat.header(addon.name):append(chat.message(('=== Outlands Quests (%d/%d) ==='):format(playertracker.outlands_completed, playertracker.outlands_total))))
					util.log_tablog(tab_logs.outlands.items)
					print(chat.header(addon.name):append(chat.message(('=== Other Quests (%d/%d) ==='):format(playertracker.other_completed, playertracker.other_total))))
					util.log_tablog(tab_logs.other.items)
					print(chat.header(addon.name):append(chat.message(('=== Abyssea Quests (%d/%d) ==='):format(playertracker.abyssea_completed, playertracker.abyssea_total))))
					util.log_tablog(tab_logs.abyssea.items)
					print(chat.header(addon.name):append(chat.message(('=== Adoulin Quests (%d/%d) ==='):format(playertracker.adoulin_completed, playertracker.adoulin_total))))
					util.log_tablog(tab_logs.adoulin.items)
					print(chat.header(addon.name):append(chat.message(('=== Coalition Assignments (%d/%d) ==='):format(playertracker.coalition_completed, playertracker.coalition_total))))
					util.log_tablog(tab_logs.coalition.items)
					print(chat.header(addon.name):append(chat.message(('=== Campaign Ops (%d/%d) ==='):format(playertracker.campaign_completed, playertracker.campaign_total))))
					util.log_tablog(tab_logs.campaign.items)
				elseif args[3]:lower() == 'campaign' then
					print(chat.header(addon.name):append(chat.message((('=== Campaign Ops (%d/%d) ==='):format(playertracker.campaign_completed, playertracker.campaign_total)))))
					util.log_tablog(tab_logs.campaign.items)
				elseif util.table_contains(quests_location, args[3]) then
					print(chat.header(addon.name):append(chat.message(('=== '.. args[3] ..' (%d/%d) ==='):format(playertracker[args[3]..'_completed'], playertracker[args[3]..'_total']))))
					util.log_tablog(tab_logs[args[3]])
				elseif (args[3] == 'main') or (args[3] == 'summary') then
					print(chat.header(addon.name):append(chat.message((('Mastery Rank: %d'):format(playertracker.mastery_rank)))))
					print(chat.header(addon.name):append(chat.message((('Checklist Progress %d/%d'):format(util.totalpoints())))))

					print(chat.header(addon.name):append(chat.message((('======= General =======')))))
					print(chat.header(addon.name):append(chat.message((('RoE %d/%d'):format(playertracker.roe_completed, playertracker.roe_total)))))
					print(chat.header(addon.name):append(chat.message((('Zones visited %d/%d'):format(playertracker.zones_completed, playertracker.zones_total)))))
					print(chat.header(addon.name):append(chat.message((('Titles %d/%d'):format(playertracker.Titles_completed, playertracker.Titles_total)))))
					print(chat.header(addon.name):append(chat.message((('Missions %d/%d'):format(playertracker.sandoriamissions_completed+playertracker.bastokmissions_completed+playertracker.windurstmissions_completed+playertracker.zilartmissions_completed+playertracker.copmissions_completed+playertracker.ahturhganmissions_completed+playertracker.assaults_completed+playertracker.wotgmissions_completed+playertracker.acpmissions_completed+playertracker.mkdmissions_completed+playertracker.asamissions_completed+playertracker.soamissions_completed+playertracker.rovmissions_completed+playertracker.tvrmissions_completed+playertracker.campaign_completed, playertracker.sandoriamissions_total+playertracker.bastokmissions_total+playertracker.windurstmissions_total+playertracker.zilartmissions_total+playertracker.copmissions_total+playertracker.ahturhganmissions_total+playertracker.assaults_total+playertracker.wotgmissions_total+playertracker.acpmissions_total+playertracker.mkdmissions_total+playertracker.asamissions_total+playertracker.soamissions_total+playertracker.rovmissions_total+playertracker.tvrmissions_total+playertracker.campaign_total)))))
					print(chat.header(addon.name):append(chat.message((('Quests %d/%d'):format(playertracker.bastok_completed+playertracker.sandoria_completed+playertracker.windurst_completed+playertracker.jeuno_completed+playertracker.ahturhgan_completed+playertracker.crystalwar_completed+playertracker.outlands_completed+playertracker.other_completed+playertracker.abyssea_completed+playertracker.adoulin_completed+playertracker.coalition_completed, playertracker.bastok_total+playertracker.sandoria_total+playertracker.windurst_total+playertracker.jeuno_total+playertracker.ahturhgan_total+playertracker.crystalwar_total+playertracker.outlands_total+playertracker.other_total+playertracker.abyssea_total+playertracker.adoulin_total+playertracker.coalition_total)))))
					print(chat.header(addon.name):append(chat.message((('Magic %d/%d'):format(playertracker.WhiteMagic_completed+playertracker.BlackMagic_completed+playertracker.SummonerPact_completed+playertracker.Ninjutsu_completed+playertracker.BardSong_completed+playertracker.BlueMagic_completed+playertracker.Geomancy_completed+playertracker.Trust_completed, playertracker.WhiteMagic_total+playertracker.BlackMagic_total+playertracker.SummonerPact_total+playertracker.Ninjutsu_total+playertracker.BardSong_total+playertracker.BlueMagic_total+playertracker.Geomancy_total+playertracker.Trust_total)))))
					print(chat.header(addon.name):append(chat.message((('Warps %d/%d'):format(playertracker.homepoints_completed+playertracker.survivalguides_completed+playertracker.waypoints_completed+playertracker.telepoints_completed+playertracker.cavernousmaws_completed+playertracker.lycopodium_completed+playertracker.eschanportals_completed+playertracker.outposts_completed+playertracker.protowaypoints_completed+playertracker.abysseaconflux_completed, playertracker.homepoints_total+playertracker.survivalguides_total+playertracker.waypoints_total+playertracker.telepoints_total+playertracker.cavernousmaws_total+playertracker.lycopodium_total+playertracker.eschanportals_total+playertracker.outposts_total+playertracker.protowaypoints_total+playertracker.abysseaconflux_total)))))

				elseif (args[3] == 'sheol') or (args[3] == 'odyssey') then
					print(chat.header(addon.name):append(chat.message(('=== Sheol A (%d/%d) ==='):format(playertracker.sheola_completed, playertracker.sheola_total))))
					util.log_tablog(tab_logs.sheola.items)
					print(chat.header(addon.name):append(chat.message(('=== Sheol B (%d/%d) ==='):format(playertracker.sheolb_completed, playertracker.sheolb_total))))
					util.log_tablog(tab_logs.sheolb.items)
					print(chat.header(addon.name):append(chat.message(('=== Sheol C (%d/%d) ==='):format(playertracker.sheolc_completed, playertracker.sheolc_total))))
					util.log_tablog(tab_logs.sheolc.items)
					print(chat.header(addon.name):append(chat.message(('=== Sheol Gaol (%d/%d) ==='):format(playertracker.sheolgaoltiers_completed, playertracker.sheolgaoltiers_total))))
					util.log_tablog(tab_logs.sheolgaol.items)
				elseif tab_logs[args[3]] then
					if not (args[3] == 'titles_by_content') then
						print(chat.header(addon.name):append(chat.message(('=== '.. tab_logs[args[3]].name .. ' (%d/%d) ==='):format(playertracker[args[3]..'_completed'], playertracker[args[3]..'_total']))))
					end
					util.log_tablog(tab_logs[args[3]].items)
				end
			else
				print(chat.header(addon.name):append(chat.message('Must specify category')))
				print(chat.header(addon.name):append(chat.message('Example: //xic log '..chat.color1(221, 'titles'))))
				print(chat.header(addon.name):append(chat.message('Available categories: main summary titles monstrosity mmm meeble warps fish quests')))
				print(chat.header(addon.name):append(chat.message('sandoria bastok windurst jeuno ahturhgan crystalwar outlands other abyssea adoulin coalition campaign')))
			end
		end
	end
end)

-- Init & Cleanup
function addon_init()
	player = AshitaCore:GetMemoryManager():GetParty():GetMemberIndex(0)
	player_name = AshitaCore:GetMemoryManager():GetParty():GetMemberName(0)
	if not player then return end
	kiCheck = nil
	mountCheck = nil
	key_data = nil
	updatemenulogs()
end

ashita.events.register('load', 'load_cb', addon_init);
ashita.events.register('unload', 'unload_cb', function()
	settings.save()
end)