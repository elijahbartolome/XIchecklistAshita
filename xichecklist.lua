addon.name     = 'xichecklist'
addon.author   = 'Anokata, ebartolome'
addon.version  = '0.1.0'
addon.commands = {'xichecklist', 'xic'}

local settings = require('settings')
local chat = require('chat')
local ui = require('ui')

-- Defaults
trackermenusettings = {
	pos = {x=50, y=80},
	visibility={true, },
	showcompleted=false,
	initial=true
}

defaultplayertracker = {
	-- NPC Menus
	['mmm_mazecount'] = 0,
	
	['wingskill_completed'] = 0,
	['wingskill_total'] = 100,
	
	['Titles_completed'] = 0,
	['Titles_total'] = 0,
	
	['outposts_completed'] = 0,
	['outposts_total'] = 0,
	['protowaypoints_completed'] = 0,
	['protowaypoints_total'] = 0,
	
	['fishes_completed'] = 0,
	['fishes_total'] = 164,
	
	['meebleburrows_completed'] = 0,
	['meebleburrows_total'] = 0,
	
	['atmacitelevels_completed'] = 0,
	['atmacitelevels_total'] = 600,
	
	['sheolgaoltiers_completed'] = 0,
	['sheolgaoltiers_total'] = 425,

	outposts_unlocks = {},
	protowaypoints_unlocks = {},
	fishes_caught = {},
	meeble_completed = {
		['Sauromugue_Champaign'] = {},
		['Batallia_Downs'] = {},
	},
	atmacite_levels = {},
	sheolgaol = {
		--['Option Index'] = {[menu byte index] = true,},
		['8'] = {},
		['9'] = {},
		['10'] = {},
	},

	titles = {},

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
		['sheolgaol'] = false,
	},
}

-- UI DATA
tab_logs = {
	['mastery_rank'] = 0,
		-- Missions
	['bastokmissions_completed'] = 0,
	['bastokmissions_total'] = 0,
	['sandoriamissions_completed'] = 0,
	['sandoriamissions_total'] = 0,
	['windurstmissions_completed'] = 0,
	['windurstmissions_total'] = 0,
	['zilartmissions_completed'] = 0,
	['zilartmissions_total'] = 0,
	['copmissions_completed'] = 0,
	['copmissions_total'] = 0,
	['ahturhganmissions_completed'] = 0,
	['ahturhganmissions_total'] = 0,
	['wotgmissions_completed'] = 0,
	['wotgmissions_total'] = 0,
	['acpmissions_completed'] = 0,
	['acpmissions_total'] = 0,
	['mkdmissions_completed'] = 0,
	['mkdmissions_total'] = 0,
	['asamissions_completed'] = 0,
	['asamissions_total'] = 0,
	['soamissions_completed'] = 0,
	['soamissions_total'] = 0,
	['rovmissions_completed'] = 0,
	['rovmissions_total'] = 0,
	['tvrmissions_completed'] = 0,
	['tvrmissions_total'] = 0,
	-- Quests
	['bastok_completed'] = 0,
	['bastok_total'] = 0,
	['sandoria_completed'] = 0,
	['sandoria_total'] = 0,
	['windurst_completed'] = 0,
	['windurst_total'] = 0,
	['jeuno_completed'] = 0,
	['jeuno_total'] = 0,
	['ahturhgan_completed'] = 0,
	['ahturhgan_total'] = 0,
	['crystalwar_completed'] = 0,
	['crystalwar_total'] = 0,
	['outlands_completed'] = 0,
	['outlands_total'] = 0,
	['other_completed'] = 0,
	['other_total'] = 0,
	['abyssea_completed'] = 0,
	['abyssea_total'] = 0,
	['adoulin_completed'] = 0,
	['adoulin_total'] = 0,
	['coalition_completed'] = 0,
	['coalition_total'] = 0,
	['campaign_completed'] = 0,
	['campaign_total'] = 0,
	-- Key items
	['Permanent_Key_Items_completed'] = 0,
	['Permanent_Key_Items_total'] = 0,
	['Magical_Maps_completed'] = 0,
	['Magical_Maps_total'] = 0,
	['Mounts_completed'] = 0,
	['Mounts_total'] = 0,
	['Claim_Slips_completed'] = 0,
	['Claim_Slips_total'] = 0,
	['Active_Effects_completed'] = 0,
	['Active_Effects_total'] = 0,
	['Voidwatch_completed'] = 0,
	['Voidwatch_total'] = 0,
	-- Magic
	['WhiteMagic_completed'] = 0,
	['WhiteMagic_total'] = 0,
	['BlackMagic_completed'] = 0,
	['BlackMagic_total'] = 0,
	['SummonerPact_completed'] = 0,
	['SummonerPact_total'] = 0,
	['Ninjutsu_completed'] = 0,
	['Ninjutsu_total'] = 0,
	['BardSong_completed'] = 0,
	['BardSong_total'] = 0,
	['BlueMagic_completed'] = 0,
	['BlueMagic_total'] = 0,
	['Geomancy_completed'] = 0,
	['Geomancy_total'] = 0,
	['Trust_completed'] = 0,
	['Trust_total'] = 0,
	-- Exp
	['Meritpoints_completed'] = 0,
	['Meritpoints_total'] = 919,
	['Jobpoints_completed'] = 0,
	['Jobpoints_total'] = 46200,
	['Masterlevels_completed'] = 0,
	['Masterlevels_total'] = 1100,
	['Masterlevels_highest'] = 0,
	-- Skills
	['craftingskills_completed'] = 0,
	['craftingskills_total'] = 790,
	-- Warps
	['homepoints_completed'] = 0,
	['homepoints_total'] = 0,
	['survivalguides_completed'] = 0,
	['survivalguides_total'] = 0,
	['waypoints_completed'] = 0,
	['waypoints_total'] = 0,
	-- Monstrosity
	['Racejobinstinct_completed'] = 0,
	['Racejobinstinct_total'] = 0,
	['MonsterLevels_completed'] = 0,
	['MonsterLevels_total'] = 0,
	['MonsterVariants_completed'] = 0,
	['MonsterVariants_total'] = 0,
	['MonsterInsincts_completed'] = 0,
	['MonsterInsincts_total'] = 0,
	-- RoE
	['RoE_completed'] = 0,
	['RoE_total'] = 0,
	-- MMM
	['mmmvouchers_completed'] = 0,
	['mmmvouchers_total'] = 0,
	['mmmrunes_completed'] = 0,
	['mmmrunes_total'] = 0,


	quests = {
		sandoria = {},
		bastok = {},
		windurst = {},
		jeuno = {},
		ahturhgan = {},
		crystalwar = {},
		outlands = {},
		other = {},
		abyssea = {},
		adoulin = {},
		coalition = {},
		campaign = {},
	},
	atmacite_levels = {},
	homepoints = {},
	survivalguides = {},
	waypoints = {},
	outposts = {},
	protowaypoints = {},
	titles = {},
	fishes = {},
	monsterlevels = {},
	monstervariants = {},
	racejobinstincts = {},
	monster_instincts = {},

	roe = {},
	
	mmmvouchers = {},
	mmmrunes = {},
	meeble_burrows = {},
	
	magic = {
		['WhiteMagic'] = {},
		['BlackMagic'] = {},
		['SummonerPact'] = {},
		['Ninjutsu'] = {},
		['BardSong'] = {},
		['BlueMagic'] = {},
		['Geomancy'] = {},
		['Trust'] = {}
	},

	keyitems = {
		['Permanent Key Items'] = {},
		['Magical Maps'] = {},
		['Mounts'] = {},
		['Claim Slips'] = {},
		['Active Effects'] = {},
		['Voidwatch'] = {}
	}
}

local default_settings = T{
	playertracker=defaultplayertracker,
	trackermenusettings=trackermenusettings
}

local charSettings = settings.load(default_settings);

playertracker=charSettings.playertracker
trackermenusettings=charSettings.trackermenusettings

util = require('util/util')
quest_util = require('util/quests')
warps_util = require('util/warps')
mons_util = require('util/monstrosity')
roe_util = require('util/roe')
mmm_util = require('util/mmm')
menus_util = require('util/menus')

function get_bits_be(data, startByte, startBit, n)
	local result = {}
	for i = startBit, startBit+n-1 do
		result[i+1-startBit] = (ashita.bits.unpack_be(data, startByte, i, 1) == 1);
	end
	return result
end

ashita.events.register('packet_in', 'incoming chunk', function(e)
	--mastery rank
	if e.id == 0x01B then
		local mastery_rank = struct.unpack('H', e.data, 0x66 + 0x01)
		if (mastery_rank > tab_logs['mastery_rank']) then
			if (tab_logs['mastery_rank'] > 0) then
				util.addon_log('Mastery Rank increase '..mastery_rank)
			end
			tab_logs['mastery_rank'] = mastery_rank
		end
	end

	-- log keyitems
	if e.id == 0x055 then
		if (not key_data) then key_data = {[0]=nil, [1]=nil, [2]=nil, [3]=nil, [4]=nil, [5]=nil, [6]=nil, [7]=nil} end
		local port = struct.unpack('H', e.data, 0x84 + 0x01)
		key_data[port] = true
		if (key_data[0]~=nil and key_data[1]~=nil and key_data[2]~=nil and key_data[3]~=nil and key_data[4]~=nil and key_data[5]~=nil and key_data[6]~=nil and key_data[7]~=nil) then
			key_data = nil
			kiCheck = 1
		end
	end

	--mounts
	if e.id == 0x0AE then
		mountCheck = 1
	end

	if (kiCheck ~= nil) and (mountCheck ~= nil) then
		kiCheck = nil
		mountCheck = nil
		check_keyitems()
	end

	-- do quests
	if e.id == 0x056 then
		local type = struct.unpack('H', e.data, 0x24 + 0x01)
		local log = quest_logs[type]
		if log then
			if ((type == 128)) then -- if Aht Urhgan Current Quests
				local CurrentAhtUrhganQuests = get_bits_be(e.data_raw, 0x04, 0, 128)
				quests[log.type][log.area] = CurrentAhtUrhganQuests
			elseif ((type == 192)) then -- if Aht Urhgan Completed Quests
				local CompletedAhtUrhganQuests = get_bits_be(e.data_raw, 0x04, 0, 128)
				quests[log.type][log.area] = CompletedAhtUrhganQuests
				tab_logs.quests[log.area] = quest_util.log_quests(log.area)
			elseif (type == 208) then
				quests.completed['sandoriamissions'] = get_bits_be(e.data_raw, 0x04, 0, 64)
				quests.completed['bastokmissions'] = get_bits_be(e.data_raw, 0x0C, 0, 64)
				quests.completed['windurstmissions'] = get_bits_be(e.data_raw, 0x14, 0, 64)
				quests.completed['zilartmissions'] = get_bits_be(e.data_raw, 0x1C, 0, 64)
				tab_logs.quests['sandoriamissions'] = quest_util.log_quests('sandoriamissions')
				tab_logs.quests['bastokmissions'] = quest_util.log_quests('bastokmissions')
				tab_logs.quests['windurstmissions'] = quest_util.log_quests('windurstmissions')
				tab_logs.quests['zilartmissions'] = quest_util.log_quests('zilartmissions')
			elseif (type == 216) then -- if TOAU, WOTG Completed Missions
				quests.completed['ahturhganmissions'] = get_bits_be(e.data_raw, 0x04, 0, 64)
				quests.completed['wotgmissions'] = get_bits_be(e.data_raw, 0x0C, 0, 64)
				tab_logs.quests['ahturhganmissions'] = quest_util.log_quests('ahturhganmissions')
				tab_logs.quests['wotgmissions'] = quest_util.log_quests('wotgmissions')
			elseif (type == 65534) then -- if TVR Current Missions
				tab_logs.quests['tvrmissions'] = quest_util.log_missions('tvrmissions', struct.unpack('I', e.data, 0x04 + 0x01))
			elseif (type == 65535) then -- if Other Current Missions
				tab_logs.quests['copmissions'] = quest_util.log_missions('copmissions', struct.unpack('I', e.data, 0x10 + 0x01))
				tab_logs.quests['acpmissions'] = quest_util.log_missions('acpmissions', get_bits_be(e.data_raw, 0x18, 0, 4))
				tab_logs.quests['mkdmissions'] = quest_util.log_missions('mkdmissions', get_bits_be(e.data_raw, 0x18, 4, 4))
				tab_logs.quests['asamissions'] = quest_util.log_missions('asamissions', get_bits_be(e.data_raw, 0x19, 0, 4))
				tab_logs.quests['soamissions'] = quest_util.log_missions('soamissions', struct.unpack('I', e.data, 0x1C + 0x01))
				tab_logs.quests['rovmissions'] = quest_util.log_missions('rovmissions', struct.unpack('I', e.data, 0x20 + 0x01))
			else
				local QuestFlags = get_bits_be(e.data_raw, 0x04, 0, 256)
				quests[log.type][log.area] = QuestFlags
				if (log.area == 'campaign1' or log.area == 'campaign2') then
					local campaign_check = quest_util.log_quests(log.area)
					if campaign_check ~= false then
						tab_logs.quests['campaign'] = campaign_check
					end
				else
					tab_logs.quests[log.area] = quest_util.log_quests(log.area)
				end
			end
		end
    end

	--magic skills
	if (e.id == 0x00AA) then
		check_playerspells()
	end
	
	-- crafting skills
	if e.id == 0x062 then
		local total_crafting_skills = 0
		local craftBase = 4 + (31*4) + (48*2) + 1;
		for i = 0,8 do
			local offset = craftBase + i*2
			local skillBase = ashita.bits.unpack_be(e.data_raw, offset, 6, 10)
			local reversedValue = util.reverse(skillBase, 10)
			total_crafting_skills = total_crafting_skills + reversedValue
		end
		tab_logs['craftingskills_completed'] = total_crafting_skills
	end
	
	if e.id == 0x063 then
		local order = struct.unpack('H', e.data, 0x04 + 0x01)
		-- do warps
		if (order == 6) then 
			warps_util.warps_data = e.data
			tab_logs.homepoints = warps_util.checkwarps('homepoints')
			tab_logs.survivalguides = warps_util.checkwarps('survivalguides')
			tab_logs.waypoints = warps_util.checkwarps('waypoints')
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
			mons_util.monster_instincts = util.twobits_to_table(InstinctBitfield)
			tab_logs.monsterlevels = mons_util.log_monsterlevels()
			tab_logs.monster_instincts = mons_util.log_monsterinstincts()
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
			tab_logs.monsterlevels = mons_util.log_monsterlevels()
			tab_logs.monstervariants = mons_util.log_variants()
			tab_logs.racejobinstincts = mons_util.log_racejobinstincts()
		end
	end

	if (e.id == 0x08c) then
		-- Log Merit points
		local count = struct.unpack('B', e.data, 0x04 + 0x01)

		local total_merit_upgrades = 0
		local meritBase = 1 + 3 + 1;
		for i=1,count do
			local offset = meritBase + i * 4
			local value = struct.unpack('B', e.data, offset + 3)
			total_merit_upgrades = total_merit_upgrades + value
		end
		tab_logs['Meritpoints_completed'] = total_merit_upgrades
		--Log EXP and Job points
		check_exp()
	end
	
	-- handle npc menu
	if (e.id == 0x033) or (e.id == 0x034) then
		menus_util.handle_npc_menu(e)
		settings.save()
	elseif e.id == 0x061 then
		-- check player info (updated when opening menu)
		local title = struct.unpack('H', e.data, 0x44 + 0x01)
		menus_util.add_title(title)
		settings.save()
	end
	
	if e.id == 0x05C then
		if menu_current.npcindex then menus_util.handle_npc_submenu(e) end
		settings.save()
	end
	
	-- do RoE
	if e.id == 0x112 then
		if (not roe_data) then roe_data = {[0]=nil, [1]=nil, [2]=nil, [3]=nil} end
		local port = struct.unpack('H', e.data, 0x84 + 0x01)
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
			roe_util.handle_roe_data(concatRoE)
			roe_data = nil -- reset
			order = nil
		end
	end
	
	-- do MMM
	if e.id == 0x0AD then
		mmm_util.handle_mmm_data(e)
		tab_logs.mmmvouchers = mmm_util.log_vouchers()
		tab_logs.mmmrunes = mmm_util.log_runes()
	end
	
	if e.id == 0x052 then
		-- claer npc menu
		menus_util.reset_current_menu()
	end
end)

ashita.events.register('packet_out', 'outgoing chunk', function(e)
	
	-- listen to menu options
	if (e.id==0x05B) then
		menus_util.handle_menu_options(e) -- READ outgoing menu selection to determine which menu
		settings.save()
	end
end)

function check_keyitems()
	local keyitem_exclusions = require('maps/keyitems_exclusions')
	local keyitems = require('maps/key_items')
	local playMgr = AshitaCore:GetMemoryManager():GetPlayer();
	local keyitemtypeTracker = {
		['Permanent Key Items'] = {total=0, completed=0, output_list={}},
		['Magical Maps'] = {total=0, completed=0, output_list={}},
		['Claim Slips'] = {total=0, completed=0, output_list={}},
		['Active Effects'] = {total=0, completed=0, output_list={}},
		['Voidwatch'] = {total=0, completed=0, output_list={}},
		['Mounts'] = {total=0, completed=0, output_list={}}
	}
	for id = 1,3374 do
		local keyitem_name = AshitaCore:GetResourceManager():GetString('keyitems.names', id)
		if ((not table_contains(keyitem_exclusions, id)) and keyitems[id] ~= nil) then
			local keyitemtype = keyitems[id].category
			if keyitemtypeTracker[keyitemtype] then
				keyitemtypeTracker[keyitemtype].total = keyitemtypeTracker[keyitemtype].total + 1
				local completion = false
				if playMgr:HasKeyItem(id) then
					-- key item obtained
					keyitemtypeTracker[keyitemtype].completed = keyitemtypeTracker[keyitemtype].completed + 1
					completion = true
				end
				local list_item = util.list_item(keyitemtype, keyitem_name, completion)
				table.insert(keyitemtypeTracker[keyitemtype].output_list, list_item)
			end
		end
	end
	for keyitemtype, values in pairs(keyitemtypeTracker) do
		tab_logs[util.cleanspaces(keyitemtype)..'_completed'] = values.completed
		tab_logs[util.cleanspaces(keyitemtype)..'_total'] = values.total
		tab_logs.keyitems[keyitemtype] = values.output_list
	end
end

function check_playerspells()
	local spells_exclusions = require('maps/spells_exclusions')
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
	for id=1,1019 do
		local spell = AshitaCore:GetResourceManager():GetSpellById(id)
		local completion = false
		if (not table_contains(spells_exclusions, id)) then
			local type = spell.Type
			magictypeTracker[type].total = magictypeTracker[type].total + 1
			if playMgr:HasSpell(id) then
				-- spell learned
				magictypeTracker[type].completed = magictypeTracker[type].completed + 1
				completion = true
			end
			local list_item = util.list_item(magictypeTracker[type].name, spell.Name[1], completion, nil)
			table.insert(magictypeTracker[type].output_list, list_item)
		end
	end
	for _, magictype in ipairs(magictypeTracker) do
		tab_logs[util.cleanspaces(magictype.name)..'_completed'] = magictype.completed
		tab_logs[util.cleanspaces(magictype.name)..'_total'] = magictype.total
		tab_logs.magic[magictype.name] = magictype.output_list
	end
end

function check_exp()
	local total_jp_spent = 0
	local total_master_levels = 0
	local highest_master_level = 0
	local playerinfo = AshitaCore:GetMemoryManager():GetPlayer()

	-- job points
	for id=1,22 do
		total_jp_spent = total_jp_spent + playerinfo:GetJobPointsSpent(id)
	end
	tab_logs['Jobpoints_completed'] = total_jp_spent
	-- master levels
	for id=1,22 do
		total_master_levels = total_master_levels + playerinfo:GetJobMasterLevel(id)
		if (playerinfo:GetJobMasterLevel(id) > highest_master_level) then highest_master_level = playerinfo:GetJobMasterLevel(id) end
	end
	tab_logs['Masterlevels_completed'] = total_master_levels
	tab_logs['Masterlevels_highest'] = highest_master_level
end

function updatemenulogs()
	menus_util.log_outposts()
	menus_util.log_protowaypoints()
	menus_util.log_fishes()
	menus_util.log_atmacitelevels()
	menus_util.log_meeble_burrows()
	menus_util.log_titles()
	menus_util.log_sheolgaol()
end
-------------------------------------------------
ashita.events.register('d3d_present', 'present_cb', ui.render);

ashita.events.register('command', 'checklist_command', function(e)
	local args = e.command:args();
    if (#args == 0 or (args[1] ~= "/xic" and args[1] ~= "/xichecklist")) then
        return;
    end
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
			print(chat.header(addon.name):append(chat.message(chat.color1(261, 'Sheol Gaol')..'-> ??? in Rabao')))
		elseif args[2] == 'show' then
			trackermenusettings.visibility = {true,}
		elseif args[2] == 'hide' then
			trackermenusettings.visibility = {false,}
		elseif args[2] == 'reload' then
			settings.reload()
		elseif args[2] == 'log' then
			if (args[3]) then
				if args[3]:lower() == 'titles' then
					util.log_tablog(tab_logs.titles)
					print(chat.header(addon.name):append(chat.message(('=== Titles (%d/%d) ==='):format(tab_logs['Titles_completed'], tab_logs['Titles_total']))))
				elseif args[3]:lower() == 'monstrosity' then
					print(chat.header(addon.name):append(chat.message(('=== Species Levels (%d/%d) ==='):format(tab_logs['MonsterLevels_completed'], tab_logs['MonsterLevels_total']))))
					util.log_tablog(tab_logs.monsterlevels)
					print(chat.header(addon.name):append(chat.message(('=== Monster Variants (%d/%d) ==='):format(tab_logs['MonsterVariants_completed'], tab_logs['MonsterVariants_total']))))
					util.log_tablog(tab_logs.monstervariants)
					print(chat.header(addon.name):append(chat.message(('=== Race / Job Instincts (%d/%d) ==='):format(tab_logs['Racejobinstinct_completed'], tab_logs['Racejobinstinct_total']))))
					util.log_tablog(tab_logs.racejobinstincts)
					print(chat.header(addon.name):append(chat.message(('=== Monster Instincts (%d/%d) ==='):format(tab_logs['MonsterInsincts_completed'], tab_logs['MonsterInsincts_total']))))
					util.log_tablog(tab_logs.monster_instincts)
				elseif args[3]:lower() == 'mmm' then
					print(chat.header(addon.name):append(chat.message(('=== MMM Vouchers Unlocks (%d/%d) ==='):format(tab_logs['mmmvouchers_completed'], tab_logs['mmmvouchers_total']))))
					util.log_tablog(tab_logs.mmmvouchers)
					print(chat.header(addon.name):append(chat.message(('=== MMM Runes Unlocks (%d/%d) ==='):format(tab_logs['mmmrunes_completed'], tab_logs['mmmrunes_total']))))
					util.log_tablog(tab_logs.mmmrunes)
				elseif args[3]:lower() == 'meeble' then
					print(chat.header(addon.name):append(chat.message(('=== Meeble Burrows (%d/%d) ==='):format(tab_logs['meebleburrows_completed'], tab_logs['meebleburrows_total']))))
					util.log_tablog(tab_logs.meeble_burrows)
				elseif args[3]:lower() == 'warps' then
					print(chat.header(addon.name):append(chat.message(('=== Home Points (%d/%d) ==='):format(tab_logs['homepoints_completed'], tab_logs['homepoints_total']))))
					util.log_tablog(tab_logs.homepoints)
					print(chat.header(addon.name):append(chat.message(('=== Survival Guides (%d/%d) ==='):format(tab_logs['survivalguides_completed'], tab_logs['survivalguides_total']))))
					util.log_tablog(tab_logs.survivalguides)
					print(chat.header(addon.name):append(chat.message(('=== Adoulin Waypoints (%d/%d) ==='):format(tab_logs['waypoints_completed'], tab_logs['waypoints_total']))))
					util.log_tablog(tab_logs.waypoints)
					print(chat.header(addon.name):append(chat.message(('=== Outpost Warps (%d/%d) ==='):format(tab_logs['outposts_completed'], tab_logs['outposts_total']))))
					util.log_tablog(tab_logs.outposts)
					print(chat.header(addon.name):append(chat.message(('=== Proto-Waypoints (%d/%d) ==='):format(tab_logs['protowaypoints_completed'], tab_logs['protowaypoints_total']))))
					util.log_tablog(tab_logs.protowaypoints)
				elseif args[3]:lower() == 'fish' then
					print(chat.header(addon.name):append(chat.message(('=== Type of Fish (%d/%d) ==='):format(tab_logs['fishes_completed'], tab_logs['fishes_total']))))
					util.log_tablog(tab_logs.fishes)
				elseif args[3]:lower() == 'missions' then
					print(chat.header(addon.name):append(chat.message(('=== San d\'Oria Missions (%d/%d) ==='):format(playertracker['sandoriamissions_completed'], playertracker['sandoriamissions_total']))))
					util.log_tablog(tab_logs.quests['sandoriamissions'])
					print(chat.header(addon.name):append(chat.message(('Bastok Missions (%d/%d) ==='):format(playertracker['bastokmissions_completed'], playertracker['bastokmissions_total']))))
					util.log_tablog(tab_logs.quests['bastokmissions'])
					print(chat.header(addon.name):append(chat.message(('Windurst Missions (%d/%d) ==='):format(playertracker['windurstmissions_completed'], playertracker['windurstmissions_total']))))
					util.log_tablog(tab_logs.quests['windurstmissions'])
					print(chat.header(addon.name):append(chat.message(('Zilart Missions (%d/%d) ==='):format(playertracker['zilartmissions_completed'], playertracker['zilartmissions_total']))))
					util.log_tablog(tab_logs.quests['zilartmissions'])
					print(chat.header(addon.name):append(chat.message(('CoP Missions (%d/%d) ==='):format(playertracker['copmissions_completed'], playertracker['copmissions_total']))))
					util.log_tablog(tab_logs.quests['copmissions'])
					print(chat.header(addon.name):append(chat.message(('TOAU Missions (%d/%d) ==='):format(playertracker['ahturhganmissions_completed'], playertracker['ahturhganmissions_total']))))
					util.log_tablog(tab_logs.quests['ahturhganmissions'])
					print(chat.header(addon.name):append(chat.message(('WOTG Missions (%d/%d) ==='):format(playertracker['wotgmissions_completed'], playertracker['wotgmissions_total']))))
					util.log_tablog(tab_logs.quests['wotgmissions'])
					print(chat.header(addon.name):append(chat.message(('ACP Missions (%d/%d) ==='):format(playertracker['acpmissions_completed'], playertracker['acpmissions_total']))))
					util.log_tablog(tab_logs.quests['acpmissions'])
					print(chat.header(addon.name):append(chat.message(('MKD Missions (%d/%d) ==='):format(playertracker['mkdmissions_completed'], playertracker['mkdmissions_total']))))
					util.log_tablog(tab_logs.quests['mkdmissions'])
					print(chat.header(addon.name):append(chat.message(('ASA Missions (%d/%d) ==='):format(playertracker['asamissions_completed'], playertracker['asamissions_total']))))
					util.log_tablog(tab_logs.quests['asamissions'])
					print(chat.header(addon.name):append(chat.message(('SoA Missions (%d/%d) ==='):format(playertracker['soamissions_completed'], playertracker['soamissions_total']))))
					util.log_tablog(tab_logs.quests['soamissions'])
					print(chat.header(addon.name):append(chat.message(('RoV Missions (%d/%d) ==='):format(playertracker['rovmissions_completed'], playertracker['rovmissions_total']))))
					util.log_tablog(tab_logs.quests['rovmissions'])
					print(chat.header(addon.name):append(chat.message(('TVR Missions (%d/%d) ==='):format(playertracker['tvrmissions_completed'], playertracker['tvrmissions_total']))))
					util.log_tablog(tab_logs.quests['tvrmissions'])
				elseif args[3]:lower() == 'quests' then
					print(chat.header(addon.name):append(chat.message(('=== San d\'Oria Quests (%d/%d) ==='):format(tab_logs['sandoria_completed'], tab_logs['sandoria_total']))))
					util.log_tablog(tab_logs.quests['sandoria'])
					print(chat.header(addon.name):append(chat.message(('=== Bastok Quests (%d/%d) ==='):format(tab_logs['bastok_completed'], tab_logs['bastok_total']))))
					util.log_tablog(tab_logs.quests['bastok'])
					print(chat.header(addon.name):append(chat.message(('=== Windurst Quests (%d/%d) ==='):format(tab_logs['windurst_completed'], tab_logs['windurst_total']))))
					util.log_tablog(tab_logs.quests['windurst'])
					print(chat.header(addon.name):append(chat.message(('=== Jeuno Quests (%d/%d) ==='):format(tab_logs['jeuno_completed'], tab_logs['jeuno_total']))))
					util.log_tablog(tab_logs.quests['jeuno'])
					print(chat.header(addon.name):append(chat.message(('=== Aht Urhgan Quests (%d/%d) ==='):format(tab_logs['ahturhgan_completed'], tab_logs['ahturhgan_total']))))
					util.log_tablog(tab_logs.quests['ahturhgan'])
					print(chat.header(addon.name):append(chat.message(('=== Crystal War Quests (%d/%d) ==='):format(tab_logs['crystalwar_completed'], tab_logs['crystalwar_total']))))
					util.log_tablog(tab_logs.quests['crystalwar'])
					print(chat.header(addon.name):append(chat.message(('=== Outlands Quests (%d/%d) ==='):format(tab_logs['outlands_completed'], tab_logs['outlands_total']))))
					util.log_tablog(tab_logs.quests['outlands'])
					print(chat.header(addon.name):append(chat.message(('=== Other Quests (%d/%d) ==='):format(tab_logs['other_completed'], tab_logs['other_total']))))
					util.log_tablog(tab_logs.quests['other'])
					print(chat.header(addon.name):append(chat.message(('=== Abyssea Quests (%d/%d) ==='):format(tab_logs['abyssea_completed'], tab_logs['abyssea_total']))))
					util.log_tablog(tab_logs.quests['abyssea'])
					print(chat.header(addon.name):append(chat.message(('=== Adoulin Quests (%d/%d) ==='):format(tab_logs['adoulin_completed'], tab_logs['adoulin_total']))))
					util.log_tablog(tab_logs.quests['adoulin'])
					print(chat.header(addon.name):append(chat.message(('=== Coalition Assignments (%d/%d) ==='):format(tab_logs['coalition_completed'], tab_logs['coalition_total']))))
					util.log_tablog(tab_logs.quests['coalition'])
					print(chat.header(addon.name):append(chat.message(('=== Campaign Ops (%d/%d) ==='):format(tab_logs['campaign_completed'], tab_logs['campaign_total']))))
					util.log_tablog(tab_logs.quests['campaign'])
				elseif args[3]:lower() == 'sandoria' then
					print(chat.header(addon.name):append(chat.message(('=== San d\'Oria Quests (%d/%d) ==='):format(tab_logs['sandoria_completed'], tab_logs['sandoria_total']))))
					util.log_tablog(tab_logs.quests['sandoria'])
				elseif args[3]:lower() == 'bastok' then
					print(chat.header(addon.name):append(chat.message(('=== Bastok Quests (%d/%d) ==='):format(tab_logs['bastok_completed'], tab_logs['bastok_total']))))
					util.log_tablog(tab_logs.quests['bastok'])
				elseif args[3]:lower() == 'windurst' then
					print(chat.header(addon.name):append(chat.message(('=== Windurst Quests (%d/%d) ==='):format(tab_logs['windurst_completed'], tab_logs['windurst_total']))))
					util.log_tablog(tab_logs.quests['windurst'])
				elseif args[3]:lower() == 'jeuno' then
					print(chat.header(addon.name):append(chat.message(('=== Jeuno Quests (%d/%d) ==='):format(tab_logs['jeuno_completed'], tab_logs['jeuno_total']))))
					util.log_tablog(tab_logs.quests['jeuno'])
				elseif args[3]:lower() == 'ahturhgan' then
					print(chat.header(addon.name):append(chat.message(('=== Aht Urhgan Quests (%d/%d) ==='):format(tab_logs['ahturhgan_completed'], tab_logs['ahturhgan_total']))))
					util.log_tablog(tab_logs.quests['ahturhgan'])
				elseif args[3]:lower() == 'crystalwar' then
					print(chat.header(addon.name):append(chat.message(('=== Crystal War Quests (%d/%d) ==='):format(tab_logs['crystalwar_completed'], tab_logs['crystalwar_total']))))
					util.log_tablog(tab_logs.quests['crystalwar'])
				elseif args[3]:lower() == 'outlands' then
					print(chat.header(addon.name):append(chat.message(('=== Outlands Quests (%d/%d) ==='):format(tab_logs['outlands_completed'], tab_logs['outlands_total']))))
					util.log_tablog(tab_logs.quests['outlands'])
				elseif args[3]:lower() == 'other' then
					print(chat.header(addon.name):append(chat.message(('=== Other Quests (%d/%d) ==='):format(tab_logs['other_completed'], tab_logs['other_total']))))
					util.log_tablog(tab_logs.quests['other'])
				elseif args[3]:lower() == 'abyssea' then
					print(chat.header(addon.name):append(chat.message(('=== Abyssea Quests (%d/%d) ==='):format(tab_logs['abyssea_completed'], tab_logs['abyssea_total']))))
					util.log_tablog(tab_logs.quests['abyssea'])
				elseif args[3]:lower() == 'adoulin' then
					print(chat.header(addon.name):append(chat.message(('=== Adoulin Quests (%d/%d) ==='):format(tab_logs['adoulin_completed'], tab_logs['adoulin_total']))))
					util.log_tablog(tab_logs.quests['adoulin'])
				elseif args[3]:lower() == 'coalition' then
					print(chat.header(addon.name):append(chat.message((('=== Coalition Assignments (%d/%d) ==='):format(tab_logs['coalition_completed'], tab_logs['coalition_total'])))))
					util.log_tablog(tab_logs.quests['coalition'])
				elseif args[3]:lower() == 'campaign' then
					print(chat.header(addon.name):append(chat.message((('=== Campaign Ops (%d/%d) ==='):format(tab_logs['campaign_completed'], tab_logs['campaign_total'])))))
					util.log_tablog(tab_logs.quests['campaign'])
				--[[elseif (args[3]:lower() == 'main') or (args[3]:lower() == 'summary') then
					for key, text in pairs(tabs[1].items) do
						text = text:gsub('\\cs%(%d+,%d+,%d+%)', '')
						text = text:gsub('', '')
						print(chat.header(addon.name):append(chat.message((text))))
					end]]
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