addon.name     = 'xichecklist'
addon.author   = 'Anokata'
addon.version  = '0.11.3'
addon.commands = {'xichecklist', 'xic'}

local settings = require('settings')
local chat = require('chat')
local imgui = require('imgui');
-- Defaults
trackermenusettings = {
	pos = {x=50, y=80},
	visibility={true, },
	showcompleted=false
}

defaultplayertracker = {
	['mastery_rank'] = 0,
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
	['craftingskills_completed'] = 0,
	['craftingskills_total'] = 790,
	
	['atmacitelevels_completed'] = 0,
	['atmacitelevels_total'] = 600,
	
	outposts_unlocks = {},
	protowaypoints_unlocks = {},
	fishes_caught = {},
	meeble_completed = {
		['Sauromugue_Champaign'] = {},
		['Batallia_Downs'] = {},
	},
	atmacite_levels = {},
	
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
	},
}

playertitles = {}
playerroe = {}

-- UI DATA
tabs = {
    {
        name = 'Main',
        items = {}
    },
    {
        name = 'Quests',
        items = {}
    },
    {
        name = 'Campaign',
        items = {}
    },
	{
        name = 'Fish',
        items = {}
    },
	{
        name = 'Key Items',
        items = {}
    },
	{
        name = 'Magic',
        items = {}
    },
	{
        name = 'Warps',
        items = {}
    },
	{
        name = 'Monstrosity',
        items = {}
    },
	{
        name = 'Titles',
        items = {}
    },
	{
        name = 'RoE',
        items = {}
    },
	{
        name = 'Battle Content',
        items = {}
    },
}

defaulttab_logs = {
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
	trackermenusettings=trackermenusettings,
	playertitles=playertitles,
	playerroe=playerroe,
	tab_logs=defaulttab_logs,
	tabs=tabs
}

local charSettings = settings.load(default_settings);

playertracker=charSettings.playertracker
trackermenusettings=charSettings.trackermenusettings
playertitles=charSettings.playertitles
playerroe=charSettings.playerroe
tab_logs=charSettings.tab_logs
tabs=charSettings.tabs

util = require('util/util')
quest_util = require('util/quests')
warps_util = require('util/warps')
mons_util = require('util/monstrosity')
roe_util = require('util/roe')
mmm_util = require('util/mmm')
menus_util = require('util/menus')

local function append_items(dst, src)
    if type(dst) ~= 'table' or type(src) ~= 'table' then
        return
    end
    for _, item in ipairs(src) do
		local text = item.text
		local display = true
		local menucolor = {1.0,1.0,1.0,0.0}
		if (item.completed == true and trackermenusettings.showcompleted == false) then
			display = false
		end
		if item.category ~= nil then 
			text = '['..item.category..'] '..text
		end
		if item.completed == true then
			menucolor = {1.0,0.0,1.0,0.0}
		end
		if item.obtainmethod ~= nil then 
			text = text..item.obtainmethod
		end
		local insert = {menucolor, text}
		if (display == true) then
			table.insert(dst, insert)
		end
    end
end

function append_maintab(text, ...)
	local args = {...}
	local menulinecolor = {1.0, 1.0, 1.0, 0.0}
	if (args[1]==args[2]) then menulinecolor = {1.0,0.0,1.0,0.0} end
	table.insert(tabs[1].items, {menulinecolor, '-'..text:format(...)})
end

function append_header(tab, text, ...)
	args = {...}
	local menulinecolor = {1.0, 1.0, 1.0, 0.0}
	if (args[1]==args[2]) then menulinecolor = {1.0,0.0,1.0,0.0} end
	text = '==== '..text..' ===='
		table.insert(tabs[tab].items, {menulinecolor, text:format(...)})
	if args[2] == 0 then
		table.insert(tabs[tab].items, {{1.0, 235/255, 0.0, 0.0}, 'You must zone to update.'})
	end
	
end

function append_addonhelp(tab, text, condition)
	append_items(tabs[tab].items, {util.list_item('Addon Help', text, condition)})
end

function update_maintab()
	
	tabs[1].items = {}
	
	append_maintab('Mastery Rank: %d', playertracker['mastery_rank'])
	append_maintab('Checklist Progress %d/%d', util.totalpoints())
	table.insert(tabs[1].items, '======= RoE =======')
	append_maintab('RoE %d/%d', playertracker['RoE_completed'], playertracker['RoE_total'])
	
	table.insert(tabs[1].items, '======= Quests & Ops =======')
	append_maintab('Campaign Ops %d/%d', playertracker['campaign_completed'], playertracker['campaign_total'])
	append_maintab('Bastok Quests %d/%d', playertracker['bastok_completed'], playertracker['bastok_total'])
	append_maintab('San d\'Oria Quests %d/%d', playertracker['sandoria_completed'], playertracker['sandoria_total'])
	append_maintab('Windurst Quests %d/%d', playertracker['windurst_completed'], playertracker['windurst_total'])
	append_maintab('Jeuno Quests %d/%d', playertracker['jeuno_completed'], playertracker['jeuno_total'])
	append_maintab('Aht Urhgan Quests %d/%d', playertracker['ahturhgan_completed'], playertracker['ahturhgan_total'])
	append_maintab('Crystal War Quests %d/%d', playertracker['crystalwar_completed'], playertracker['crystalwar_total'])
	append_maintab('Outlands Quests %d/%d', playertracker['outlands_completed'], playertracker['outlands_total'])
	append_maintab('Other Quests %d/%d', playertracker['other_completed'], playertracker['other_total'])
	append_maintab('Abyssea Quests %d/%d', playertracker['abyssea_completed'], playertracker['abyssea_total'])
	append_maintab('Adoulin Quests %d/%d', playertracker['adoulin_completed'], playertracker['adoulin_total'])
	append_maintab('Coalition Assignments %d/%d', playertracker['coalition_completed'], playertracker['coalition_total'])
	
	table.insert(tabs[1].items, '======= Key Items =======')
	append_maintab('Permanent Key Items %d/%d', playertracker['Permanent_Key_Items_completed'], playertracker['Permanent_Key_Items_total'])
	append_maintab('Magical Maps %d/%d', playertracker['Magical_Maps_completed'], playertracker['Magical_Maps_total'])
	append_maintab('Mounts %d/%d', playertracker['Mounts_completed'], playertracker['Mounts_total'])
	append_maintab('Claim Slips %d/%d', playertracker['Claim_Slips_completed'], playertracker['Claim_Slips_total'])
	append_maintab('Active Effects %d/%d', playertracker['Active_Effects_completed'], playertracker['Active_Effects_total'])
	append_maintab('Voidwatch %d/%d', playertracker['Voidwatch_completed'], playertracker['Voidwatch_total'])
	append_maintab('Atmacite Levels %d/%d', playertracker['atmacitelevels_completed'], playertracker['atmacitelevels_total'])
	append_addonhelp(1, 'You must talk to any \\cs(255,255,255)Atmacite Refiner\\cr \\cs(50,150,255)(Menu: Enrich Atmas)\\cr', playertracker.talk_to_npc['atmacite_refiner'])
	
	table.insert(tabs[1].items, '======= Magic =======')
	append_maintab('White Magic %d/%d', playertracker['WhiteMagic_completed'], playertracker['WhiteMagic_total'])
	append_maintab('Black Magic %d/%d', playertracker['BlackMagic_completed'], playertracker['BlackMagic_total'])
	append_maintab('Summoner Pacts %d/%d', playertracker['SummonerPact_completed'], playertracker['SummonerPact_total'])
	append_maintab('Ninjutsu %d/%d', playertracker['Ninjutsu_completed'], playertracker['Ninjutsu_total'])
	append_maintab('Bard Songs %d/%d', playertracker['BardSong_completed'], playertracker['BardSong_total'])
	append_maintab('Blue Magic %d/%d', playertracker['BlueMagic_completed'], playertracker['BlueMagic_total'])
	append_maintab('Geomancy %d/%d', playertracker['Geomancy_completed'], playertracker['Geomancy_total'])
	append_maintab('Trusts %d/%d', playertracker['Trust_completed'], playertracker['Trust_total'])

	table.insert(tabs[1].items, '======= Leveling =======')
	append_maintab('Craft Skills %d/%d', playertracker['craftingskills_completed'], 790)
	append_maintab('Wing Skill %d/%d', playertracker['wingskill_completed'], 100)
	append_addonhelp(1, 'You must talk to any \\cs(255,255,255)Chocobo stats NPC\\cr @ \\cs(50,150,255)Nations Chocobo Stables\\cr', playertracker.talk_to_npc['chocobokid'])
	append_maintab('Merit Points %d/%d', playertracker['Meritpoints_completed'], 919)
	append_maintab('Job Points %d/%d', playertracker['Jobpoints_completed'], 46200)
	append_maintab('Master Levels %d/%d (Highest: %d)', playertracker['Masterlevels_completed'], 1100, playertracker['Masterlevels_highest'])
	
	table.insert(tabs[1].items, '======= Warps =======')
	append_maintab('Home Points %d/%d', playertracker['homepoints_completed'], playertracker['homepoints_total'])
	append_maintab('Survival Guides %d/%d', playertracker['survivalguides_completed'], playertracker['survivalguides_total'])
	append_maintab('Waypoints %d/%d', playertracker['waypoints_completed'], playertracker['waypoints_total'])
	append_maintab('Outposts %d/%d', playertracker['outposts_completed'], playertracker['outposts_total'])
	append_addonhelp(1, 'You must talk to any \\cs(255,255,255)Outpost Teleporter NPC\\cr @ \\cs(50,150,255)three nations\\cr.', playertracker.talk_to_npc['outpostnpc'])
	append_maintab('Proto-Waypoints %d/%d', playertracker['protowaypoints_completed'], playertracker['protowaypoints_total'])
	append_addonhelp(1, 'You must talk to any \\cs(255,255,255)Proto-Waypoint\\cr.', playertracker.talk_to_npc['protowaypoint'])
	
	table.insert(tabs[1].items, '======= Fishing =======')
	append_maintab('Fishes Caught %d/%d', playertracker['fishes_completed'], 164)
	append_addonhelp(1, 'You must talk to \\cs(255,255,255)Katsunaga\\cr @ \\cs(50,150,255)Mhuaura (H-9)\\cr \\cs(255,255,255)(Menu: Types of fishes caught)\\cr', playertracker.talk_to_npc['katsunaga'])
	
	table.insert(tabs[1].items, '======= Monstrosity =======')
	append_maintab('Monster Levels %d/%d', playertracker['MonsterLevels_completed'], playertracker['MonsterLevels_total'])
	append_maintab('Race/Job Instincts %d/%d', playertracker['Racejobinstinct_completed'], playertracker['Racejobinstinct_total'])
	append_maintab('Monster Variants %d/%d', playertracker['MonsterVariants_completed'], playertracker['MonsterVariants_total'])
	append_maintab('Monster Instincts %d/%d', playertracker['MonsterInsincts_completed'], playertracker['MonsterInsincts_total'])
	
	table.insert(tabs[1].items, '======= Battle Content =======')
	append_maintab('MMM Vouchers Unlocked %d/%d', playertracker['mmmvouchers_completed'], playertracker['mmmvouchers_total'])
	append_maintab('MMM Runes Unlocked %d/%d', playertracker['mmmrunes_completed'], playertracker['mmmrunes_total'])
	append_maintab('MMM Maze count %d', playertracker['mmm_mazecount'])
	append_addonhelp(1, 'You must talk to any \\cs(255,255,255)Chatnachoq\\cr @ \\cs(50,150,255)Lower Jeuno (H-9) \\cr', playertracker.talk_to_npc['chatnachoq'])
	append_maintab('Meeble Burrows Goal #3 %d/%d', playertracker['meebleburrows_completed'], playertracker['meebleburrows_total'])
	append_addonhelp(1, 'You must talk to \\cs(255,255,255)Burrow Investigator\\cr @ \\cs(50,150,255)Upper Jeuno (I-8)\\cr', playertracker.talk_to_npc['meeble_sauromugue'])
	append_addonhelp(1, 'Menu: Review expedition specifics -> \\cs(255,255,255)Sauromugue Champaign\\cr', playertracker.talk_to_npc['meeble_sauromugue'])
	append_addonhelp(1, 'You must talk to \\cs(255,255,255)Burrow Investigator\\cr @ \\cs(50,150,255)Upper Jeuno (I-8)\\cr', playertracker.talk_to_npc['meeble_batallia'])
	append_addonhelp(1, 'Menu: Review expedition specifics -> \\cs(255,255,255)Batallia Downs\\cr', playertracker.talk_to_npc['meeble_batallia'])
	
	table.insert(tabs[1].items, '======= Titles =======')
	append_maintab('Titles %d/%d', playertracker['Titles_completed'], playertracker['Titles_total'])
	append_items(tabs[1].items, menus_util.list_titles_bycontent())
	
end

ashita.events.register('packet_in', 'incoming chunk', function(e)
	--mastery rank
	if e.id == 0x01B then
		local mastery_rank = struct.unpack('H', e.data, 0x66 + 0x01)
		if (mastery_rank > playertracker['mastery_rank']) then
			if (playertracker['mastery_rank'] > 0) then
				util.addon_log('Mastery Rank increase '..mastery_rank)
			end
			playertracker['mastery_rank'] = mastery_rank
		end
	end

	-- log keyitems
	if e.id == 0x055 then
		if (not key_data) then key_data = {[0]=nil, [1]=nil, [2]=nil, [3]=nil, [4]=nil, [5]=nil, [6]=nil, [7]=nil} end
		local port = struct.unpack('I', e.data, 0x84 + 0x01)
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
		tab_logs.keyitems['Permanent Key Items'] = check_keyitems('Permanent Key Items')
		tab_logs.keyitems['Magical Maps'] = check_keyitems('Magical Maps')			
		tab_logs.keyitems['Claim Slips'] = check_keyitems('Claim Slips')
		tab_logs.keyitems['Active Effects'] = check_keyitems('Active Effects')
		tab_logs.keyitems['Voidwatch'] = check_keyitems('Voidwatch')
		tab_logs.keyitems['Mounts'] = check_keyitems('Mounts')
		xichecklist_updatetabs('keyitems')
	end
	-- do quests
	if e.id == 0x056 then
		local type = struct.unpack('H', e.data, 0x24 + 0x01)
		local log = quest_logs[type]
		if log then
			if ((type == 128)) then -- if Aht Urhgan Current Quests
				local CurrentAhtUrhganQuests = {}
				for i = 0,127 do
					CurrentAhtUrhganQuests[i] = (ashita.bits.unpack_be(e.data_raw, 0x04, i, 1) == 1);
				end
				quests[log.type][log.area] = CurrentAhtUrhganQuests
			elseif ((type == 192)) then -- if Aht Urhgan Completed Quests
				local CompletedAhtUrhganQuests = {}
				for i = 0,127 do
					CompletedAhtUrhganQuests[i] = (ashita.bits.unpack_be(e.data_raw, 0x04, i, 1) == 1);
				end
				quests[log.type][log.area] = CompletedAhtUrhganQuests
				tab_logs.quests[log.area] = quest_util.log_quests(log.area)
			else
				local QuestFlags = {}
				for i = 0,255 do
					QuestFlags[i] = (ashita.bits.unpack_be(e.data_raw, 0x04, i, 1) == 1);
				end
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
		xichecklist_updatetabs('quests')
    end
	--magic skills
	if (e.id == 0x00AA) then
		tab_logs.magic['WhiteMagic'] = check_playerspells('WhiteMagic', 1)
		tab_logs.magic['BlackMagic'] = check_playerspells('BlackMagic', 2)
		tab_logs.magic['SummonerPact'] = check_playerspells('SummonerPact', 3)
		tab_logs.magic['Ninjutsu'] = check_playerspells('Ninjutsu', 4)
		tab_logs.magic['BardSong'] = check_playerspells('BardSong', 5)
		tab_logs.magic['BlueMagic'] = check_playerspells('BlueMagic', 6)
		tab_logs.magic['Geomancy'] = check_playerspells('Geomancy', 7)
		tab_logs.magic['Trust'] = check_playerspells('Trust', 8)
		xichecklist_updatetabs('magic')
	end
	
	-- crafting skills
	if e.id == 0x062 then
		local total_crafting_skills = 0
		local playMgr = AshitaCore:GetMemoryManager():GetPlayer();
		for i = 1,10 do
			total_crafting_skills = total_crafting_skills + playMgr:GetCraftSkill(i):GetSkill()
		end
		playertracker['craftingskills_completed'] = total_crafting_skills
	end
	
	if e.id == 0x063 then
		local order = struct.unpack('H', e.data, 0x04 + 0x01)
		-- do warps
		if (order == 6) then 
			warps_util.warps_data = e.data
			tab_logs.homepoints = warps_util.checkwarps('homepoints')
			tab_logs.survivalguides = warps_util.checkwarps('survivalguides')
			tab_logs.waypoints = warps_util.checkwarps('waypoints')
			xichecklist_updatetabs('warps')
		end
		-- do monstrosity
		if (order == 3) then
			local MonsterLevelCharField = {}
			for i = 0,1023 do
				MonsterLevelCharField[i] = (ashita.bits.unpack_be(e.data_raw, 0x5c, i, 1) == 1);
			end
			local InstinctBitfield = {}
			for i = 0,511 do
				InstinctBitfield[i] = (ashita.bits.unpack_be(e.data_raw, 0x1c, i, 1) == 1);
			end
			mons_util.monster_levelspacket[1] = MonsterLevelCharField
			mons_util.monster_instincts = util.twobits_to_table(InstinctBitfield)
			tab_logs.monsterlevels = mons_util.log_monsterlevels()
			tab_logs.monster_instincts = mons_util.log_monsterinstincts()
			xichecklist_updatetabs('monstrosity')
		end
		if (order == 4) then
			local InstinctBitfield3 = {}
			for i = 0,95 do
				InstinctBitfield3[i] = (ashita.bits.unpack_be(e.data_raw, 0x88, i, 1) == 1);
			end
			local VariantsBitfield = {}
			for i = 0,255 do
				VariantsBitfield[i] = (ashita.bits.unpack_be(e.data_raw, 0x94, i, 1) == 1);
			end
			local MonsterLevelCharField2 = {}
			for i = 0,126 do
				MonsterLevelCharField2[i] = (ashita.bits.unpack_be(e.data_raw, 0x08, i, 1) == 1);
			end
			mons_util.monster_levelspacket[2] = MonsterLevelCharField2
			mons_util.racejobinstincts = InstinctBitfield3
			mons_util.variants_bitfield = VariantsBitfield
			tab_logs.monsterlevels = mons_util.log_monsterlevels()
			tab_logs.monstervariants = mons_util.log_variants()
			tab_logs.racejobinstincts = mons_util.log_racejobinstincts()
			xichecklist_updatetabs('monstrosity')
		end
		-- Log Job Points Spent
		check_exp()
	end
	
	-- handle npc menu
	if (e.id == 0x033) or (e.id == 0x034) then
		menus_util.handle_npc_menu(e)
		xichecklist_updatemenulogs()
	elseif e.id == 0x061 then
		-- check player info (updated when openning menu)
		local title = struct.unpack('H', e.data, 0x44 + 0x01)
		menus_util.add_title(title)
		xichecklist_updatemenulogs()
	end
	
	if e.id == 0x05C then
		if menu_current.npcindex then menus_util.handle_npc_submenu(e) end
		xichecklist_updatemenulogs()
	end
	
	-- do RoE
	if e.id == 0x112 then
		if (not roe_data) then roe_data = {[0]=nil, [1]=nil, [2]=nil, [3]=nil} end
		local port = struct.unpack('I', e.data, 0x84 + 0x01)
		local RoEFlags = {}
		for i = 0,1023 do
			RoEFlags[i] = (ashita.bits.unpack_be(e.data_raw, 0x04, i, 1) == 1);
		end
		roe_data[port] = RoEFlags -- the packet will be repeated three times, gather the data first
		if (roe_data[0]~=nil and roe_data[1]~=nil and roe_data[2]~=nil and roe_data[3]~=nil) then
			local concatRoE = {}
			for i=0,3 do	
				util.table_concat(concatRoE, roe_data[i])
				util.table_concat(concatRoE, {67})
			end
			roe_util.handle_roe_data(concatRoE)
			roe_data = nil -- reset
			order = nil
			xichecklist_updatetabs('roe')
		end
	end
	
	-- do MMM
	if e.id == 0x0AD then
		mmm_util.handle_mmm_data(e)
		tab_logs.mmmvouchers = mmm_util.log_vouchers()
		tab_logs.mmmrunes = mmm_util.log_runes()
		xichecklist_updatetabs('battlecontent')
	end
	
	if e.id == 0x052 then
		-- claer npc menu
		menus_util.reset_current_menu()
	end
	
	update_maintab()
end)

ashita.events.register('packet_out', 'outgoing chunk', function(e)
	
	-- listen to menu options
	if (e.id==0x05B) then
		menus_util.handle_menu_options(e) -- READ outgoing menu selection to determine which menu
	end
end)

function xichecklist_updatemenulogs()
	tab_logs.outposts = menus_util.log_outposts()
	tab_logs.protowaypoints = menus_util.log_protowaypoints()
	tab_logs.fishes = menus_util.log_fishes()
	tab_logs.atmacite_levels = menus_util.log_atmacitelevels()
	tab_logs.meeble_burrows = menus_util.log_meeble_burrows()
	tab_logs.titles = menus_util.log_titles()
	xichecklist_updatetabs(nil)
end

function xichecklist_updatetabs(tab)
	if not player then return false
	
	elseif (tab == 'quests') then
		tabs[2].items = {} -- reset tab content
		tabs[3].items = {} -- reset tab content
		-- log quests
		append_header(2, 'San d\'Oria Quests (%d/%d)', playertracker['sandoria_completed'], playertracker['sandoria_total'])
		append_items(tabs[2].items, tab_logs.quests['sandoria'])
		append_header(2, 'Bastok Quests (%d/%d)', playertracker['bastok_completed'], playertracker['bastok_total'])
		append_items(tabs[2].items, tab_logs.quests['bastok'])
		append_header(2, 'Windurst Quests (%d/%d)', playertracker['windurst_completed'], playertracker['windurst_total'])
		append_items(tabs[2].items, tab_logs.quests['windurst'])
		append_header(2, 'Jeuno Quests (%d/%d)', playertracker['jeuno_completed'], playertracker['jeuno_total'])
		append_items(tabs[2].items, tab_logs.quests['jeuno'])
		append_header(2, 'Aht Urhgan Quests (%d/%d)', playertracker['ahturhgan_completed'], playertracker['ahturhgan_total'])
		append_items(tabs[2].items, tab_logs.quests['ahturhgan'])
		append_header(2, 'Crystal War Quests (%d/%d)', playertracker['crystalwar_completed'], playertracker['crystalwar_total'])
		append_items(tabs[2].items, tab_logs.quests['crystalwar'])
		append_header(2, 'Outlands Quests (%d/%d)', playertracker['outlands_completed'], playertracker['outlands_total'])
		append_items(tabs[2].items, tab_logs.quests['outlands'])
		append_header(2, 'Other Quests (%d/%d)', playertracker['other_completed'], playertracker['other_total'])
		append_items(tabs[2].items, tab_logs.quests['other'])
		append_header(2, 'Abyssea Quests (%d/%d)', playertracker['abyssea_completed'], playertracker['abyssea_total'])
		append_items(tabs[2].items, tab_logs.quests['abyssea'])
		append_header(2, 'Adoulin Quests (%d/%d)', playertracker['adoulin_completed'], playertracker['adoulin_total'])
		append_items(tabs[2].items, tab_logs.quests['adoulin'])
		append_header(2, 'Coalition Assignments (%d/%d)', playertracker['coalition_completed'], playertracker['coalition_total'])
		append_items(tabs[2].items, tab_logs.quests['coalition'])
		-- log campaign ops
		append_header(3, 'Campaign Ops (%d/%d)', playertracker['campaign_completed'], playertracker['campaign_total'])
		append_items(tabs[3].items, tab_logs.quests['campaign'])
	
	-- log Monstrosity levels & Race/Job Instincts
	elseif (tab == 'monstrosity') then
		tabs[8].items = {}
		append_header(8, 'Species Levels (%d/%d)', playertracker['MonsterLevels_completed'], playertracker['MonsterLevels_total'])
		append_items(tabs[8].items, tab_logs.monsterlevels)
		append_header(8, 'Monster Variants (%d/%d)', playertracker['MonsterVariants_completed'], playertracker['MonsterVariants_total'])
		append_items(tabs[8].items, tab_logs.monstervariants)
		append_header(8, 'Race / Job Instincts (%d/%d)', playertracker['Racejobinstinct_completed'], playertracker['Racejobinstinct_total'])
		append_items(tabs[8].items, tab_logs.racejobinstincts)
		append_header(8, 'Monster Instincts (%d/%d)', playertracker['MonsterInsincts_completed'], playertracker['MonsterInsincts_total'])
		append_items(tabs[8].items, tab_logs.monster_instincts)
	
	-- log RoE
	elseif (tab == 'roe') then
		tabs[10].items = {}
		append_header(10, 'RoE (%d/%d)', playertracker['RoE_completed'], playertracker['RoE_total'])
		append_items(tabs[10].items, roe_util.log_roe())
	
	elseif (tab == 'battlecontent') then
		tabs[11].items = {}
		-- log MMM
		append_header(11, 'MM/M Vouchers Unlocks (%d/%d)', playertracker['mmmvouchers_completed'], playertracker['mmmvouchers_total'])
		append_items(tabs[11].items, tab_logs.mmmvouchers)
		append_header(11, 'MMM Runes Unlocks (%d/%d)', playertracker['mmmrunes_completed'], playertracker['mmmrunes_total'])
		append_items(tabs[11].items, tab_logs.mmmrunes)
		-- log Meeble Burrows
		append_header(11, 'Meeble Burrows (%d/%d)', playertracker['meebleburrows_completed'], playertracker['meebleburrows_total'])
		append_addonhelp(11, 'You must talk to \\cs(255,255,255)Burrow Investigator\\cr @ \\cs(50,150,255)Upper Jeuno (I-8)\\cr', playertracker.talk_to_npc['meeble_sauromugue'])
		append_addonhelp(11, 'Menu: Review expedition specifics -> \\cs(255,255,255)Sauromugue Champaign\\cr', playertracker.talk_to_npc['meeble_sauromugue'])
		append_addonhelp(11, 'You must talk to \\cs(255,255,255)Burrow Investigator\\cr @ \\cs(50,150,255)Upper Jeuno (I-8)\\cr', playertracker.talk_to_npc['meeble_batallia'])
		append_addonhelp(11, 'Menu: Review expedition specifics -> \\cs(255,255,255)Batallia Downs\\cr', playertracker.talk_to_npc['meeble_batallia'])
		append_items(tabs[11].items, tab_logs.meeble_burrows)
	
	elseif (tab == 'keyitems') then
		tabs[5].items = {} -- reset tab content
		-- log keyitems
		append_header(5, 'Permanent Key Items (%d/%d)', playertracker['Permanent_Key_Items_completed'], playertracker['Permanent_Key_Items_total'])
		append_items(tabs[5].items, tab_logs.keyitems['Permanent Key Items'])
		append_header(5, 'Magical Maps (%d/%d)', playertracker['Magical_Maps_completed'], playertracker['Magical_Maps_total'])
		append_items(tabs[5].items, tab_logs.keyitems['Magical Maps'])
		append_header(5, 'Mounts (%d/%d)', playertracker['Mounts_completed'], playertracker['Mounts_total'])
		append_items(tabs[5].items, tab_logs.keyitems['Mounts'])
		append_header(5, 'Claim Slips (%d/%d)', playertracker['Claim_Slips_completed'], playertracker['Claim_Slips_total'])
		append_items(tabs[5].items, tab_logs.keyitems['Claim Slips'])
		append_header(5, 'Active Effects (%d/%d)', playertracker['Active_Effects_completed'], playertracker['Active_Effects_total'])
		append_items(tabs[5].items, tab_logs.keyitems['Active Effects'])
		append_header(5, 'Voidwatch Key Items (%d/%d)', playertracker['Voidwatch_completed'], playertracker['Voidwatch_total'])
		append_items(tabs[5].items, tab_logs.keyitems['Voidwatch'])
		append_header(5, 'Atmacite Levels (%d/%d)', playertracker['atmacitelevels_completed'], playertracker['atmacitelevels_total'])
		append_addonhelp(5, 'You must talk to any \\cs(255,255,255)Atmacite Refiner\\cr \\cs(50,150,255)(Menu: Enrich Atmas)\\cr', playertracker.talk_to_npc['atmacite_refiner'])
		append_items(tabs[5].items, tab_logs.atmacite_levels)
	
	elseif (tab == 'magic') then
		tabs[6].items = {} -- reset tab content

		-- log spells and trusts
		append_header(6, 'White Magic (%d/%d)', playertracker['WhiteMagic_completed'], playertracker['WhiteMagic_total'])
		append_items(tabs[6].items, tab_logs.magic['WhiteMagic'])
		append_header(6, 'Black Magic (%d/%d)', playertracker['BlackMagic_completed'], playertracker['BlackMagic_total'])
		append_items(tabs[6].items, tab_logs.magic['BlackMagic'])
		append_header(6, 'Summoner Pacts (%d/%d)', playertracker['SummonerPact_completed'], playertracker['SummonerPact_total'])
		append_items(tabs[6].items, tab_logs.magic['SummonerPact'])
		append_header(6, 'Ninjutsu (%d/%d)', playertracker['Ninjutsu_completed'], playertracker['Ninjutsu_total'])
		append_items(tabs[6].items, tab_logs.magic['Ninjutsu'])
		append_header(6, 'Bard Songs (%d/%d)', playertracker['BardSong_completed'], playertracker['BardSong_total'])
		append_items(tabs[6].items, tab_logs.magic['BardSong'])
		append_header(6, 'Blue Magic (%d/%d)', playertracker['BlueMagic_completed'], playertracker['BlueMagic_total'])
		append_items(tabs[6].items, tab_logs.magic['BlueMagic'])
		append_header(6, 'Geomancy (%d/%d)', playertracker['Geomancy_completed'], playertracker['Geomancy_total'])
		append_items(tabs[6].items, tab_logs.magic['Geomancy'])
		append_header(6, 'Trust Magic (%d/%d)', playertracker['Trust_completed'], playertracker['Trust_total'])
		append_items(tabs[6].items, tab_logs.magic['Trust'])
	else
		tabs[4].items = {} -- reset tab content	
		tabs[7].items = {} -- reset tab content
		tabs[9].items = {} -- reset tab content

		-- log fishes caught
		append_header(4, 'Type of Fishes Caught (%d/%d)', playertracker['fishes_completed'], playertracker['fishes_total'])
		append_addonhelp(4, 'You must talk to \\cs(255,255,255)Katsunaga\\cr @ \\cs(50,150,255)Mhuaura (H-9)\\cr \\cs(255,255,255)(Menu: Types of fishes caught)\\cr', playertracker.talk_to_npc['katsunaga'])
		append_items(tabs[4].items, tab_logs.fishes)

		-- log warps
		append_header(7, 'Home Points (%d/%d)', playertracker['homepoints_completed'], playertracker['homepoints_total'])
		append_items(tabs[7].items, tab_logs.homepoints)
		append_header(7, 'Survival Guides (%d/%d)', playertracker['survivalguides_completed'], playertracker['survivalguides_total'])
		append_items(tabs[7].items, tab_logs.survivalguides)
		append_header(7, 'Adoulin Waypoints (%d/%d)', playertracker['waypoints_completed'], playertracker['waypoints_total'])
		append_items(tabs[7].items, tab_logs.waypoints)
		append_header(7, 'Outpost Warps (%d/%d)', playertracker['outposts_completed'], playertracker['outposts_total'])
		append_addonhelp(7, 'You must talk to any \\cs(255,255,255)Outpost Teleporter NPC\\cr @ \\cs(50,150,255)three nations\\cr.', playertracker.talk_to_npc['outpostnpc'])
		append_items(tabs[7].items, tab_logs.outposts)
		append_header(7, 'Proto-Waypoints (%d/%d)', playertracker['protowaypoints_completed'], playertracker['protowaypoints_total'])
		append_addonhelp(7, 'You must talk to any \\cs(255,255,255)Proto-Waypoint\\cr.', playertracker.talk_to_npc['protowaypoint'])
		append_items(tabs[7].items, tab_logs.protowaypoints)

			-- log Titles
		append_header(9, 'Titles (%d/%d)', playertracker['Titles_completed'], playertracker['Titles_total'])
		append_addonhelp(9, 'You must talk to \\cs(255,255,255)Aligi-Kufongi\\cr @ \\cs(50,150,255)Tavnazian Safehold (H-9)\\cr', playertracker.talk_to_npc['Aligi-Kufongi'])
		append_addonhelp(9, 'You must talk to \\cs(255,255,255)Koyol-Futenol\\cr @ \\cs(50,150,255)Aht Urhgan Whitegate (E-9)\\cr', playertracker.talk_to_npc['Koyol-Futenol'])
		append_addonhelp(9, 'You must talk to \\cs(255,255,255)Tamba-Namba\\cr @ \\cs(50,150,255)Southern San d\'Oria (S) (L-8)\\cr', playertracker.talk_to_npc['Tamba-Namba'])
		append_addonhelp(9, 'You must talk to \\cs(255,255,255)Bhio Fehriata\\cr @ \\cs(50,150,255)Bastok Markets (S) (I-10)\\cr', playertracker.talk_to_npc['Bhio_Fehriata'])
		append_addonhelp(9, 'You must talk to \\cs(255,255,255)Cattah Pamjah\\cr @ \\cs(50,150,255)Windurst Waters (S) (G-10)\\cr', playertracker.talk_to_npc['Cattah_Pamjah'])
		append_addonhelp(9, 'You must talk to \\cs(255,255,255)Moozo-Koozo\\cr @ \\cs(50,150,255)Southern San d\'Oria (K-6)\\cr', playertracker.talk_to_npc['Moozo-Koozo'])
		append_addonhelp(9, 'You must talk to \\cs(255,255,255)Styi Palneh\\cr @ \\cs(50,150,255)Port Bastok (I-7)\\cr', playertracker.talk_to_npc['Styi_Palneh'])
		append_addonhelp(9, 'You must talk to \\cs(255,255,255)Burute-Sorute\\cr @ \\cs(50,150,255)Windurst Walls (H-10)\\cr', playertracker.talk_to_npc['Burute-Sorute'])
		append_addonhelp(9, 'You must talk to \\cs(255,255,255)Tuh Almobankha\\cr @ \\cs(50,150,255)Lower Jeuno (I-8)\\cr', playertracker.talk_to_npc['Tuh_Almobankha'])
		append_addonhelp(9, 'You must talk to \\cs(255,255,255)Zuah Lepahnyu\\cr @ \\cs(50,150,255)Port Jeuno (J-8)\\cr', playertracker.talk_to_npc['Zuah_Lepahnyu'])
		append_addonhelp(9, 'You must talk to \\cs(255,255,255)Shupah Mujuuk\\cr @ \\cs(50,150,255)Rabao (G-8)\\cr', playertracker.talk_to_npc['Shupah_Mujuuk'])
		append_addonhelp(9, 'You must talk to \\cs(255,255,255)Yulon-Polon\\cr @ \\cs(50,150,255)Selbina (I-9)\\cr', playertracker.talk_to_npc['Yulon-Polon'])
		append_addonhelp(9, 'You must talk to \\cs(255,255,255)Willah Maratahya\\cr @ \\cs(50,150,255)Mhaura (I-8)\\cr', playertracker.talk_to_npc['Willah_Maratahya'])
		append_addonhelp(9, 'You must talk to \\cs(255,255,255)Eron-Tomaron\\cr @ \\cs(50,150,255)Kazham (G-7)\\cr', playertracker.talk_to_npc['Eron-Tomaron'])
		append_addonhelp(9, 'You must talk to \\cs(255,255,255)Quntsu-Nointsu\\cr @ \\cs(50,150,255)Norg (G-7)\\cr', playertracker.talk_to_npc['Quntsu-Nointsu'])
		append_addonhelp(9, 'You must talk to \\cs(255,255,255)Debadle-Levadle\\cr @ \\cs(50,150,255)Western Adoulin (H-8)\\cr', playertracker.talk_to_npc['Debadle-Levadle'])
		append_items(tabs[9].items, tab_logs.titles)
	end
end

function get_key_items()
	local playMgr = AshitaCore:GetMemoryManager():GetPlayer();
	local player_KI = {}
    for i = 1,3374 do
        if playMgr:HasKeyItem(i) then
			table.insert(player_KI, i)
        end
    end
	return player_KI
end

function check_keyitems(keyitemtype)
	local output_list = T{}
	local keyitem_exclusions = require('maps/keyitems_exclusions')
	local keyitems = require('maps/key_items')
	local playerkeyitems = get_key_items()
	local total, obtained = 0, 0
	for id = 1,3374 do
		local keyitem_name = AshitaCore:GetResourceManager():GetString('keyitems.names', id)
		if ((not table_contains(keyitem_exclusions, id)) and keyitems[id] ~= nil and keyitemtype == keyitems[id].category) then
			total = total + 1
			local completion = false
			if table_contains(playerkeyitems, id) then
				-- key item obtained
				obtained = obtained + 1
				completion = true
			end
			local list_item = util.list_item(keyitemtype, keyitem_name, completion)
			table.insert(output_list, list_item)
		end
	end
	playertracker[util.cleanspaces(keyitemtype)..'_completed'] = obtained
	playertracker[util.cleanspaces(keyitemtype)..'_total'] = total
	return output_list
end

function get_spells()
	local playMgr = AshitaCore:GetMemoryManager():GetPlayer();
	local player_spells = {}
    for i = 1, 1019 do
        if playMgr:HasSpell(i) then
			table.insert(player_spells, i)
        end
    end
	return player_spells
end

function check_playerspells(spelltype, typeInt)
	local output_list = T{}
	local spells_exclusions = require('maps/spells_exclusions')
	local playerspells = get_spells()
	local total, obtained = 0, 0
	for id=1,1019 do
		local spell = AshitaCore:GetResourceManager():GetSpellById(id)
		local completion = false
		if ((spell.Type == typeInt) and (not table_contains(spells_exclusions, id))) then
			total = total + 1
			if table_contains(playerspells, id) then
				-- spell learned
				obtained = obtained + 1
				completion = true
			end
			local list_item = util.list_item(spelltype, spell.Name[1], completion, nil)
			table.insert(output_list, list_item)
		end
	end
	playertracker[spelltype..'_completed'] = obtained
	playertracker[spelltype..'_total'] = total
	return output_list
end

function check_exp()
	local total_merit_upgrades = 0
	local total_jp_spent = 0
	local total_master_levels = 0
	local highest_master_level = 0
	local playerinfo = AshitaCore:GetMemoryManager():GetPlayer()
	--[[
	-- merits points
	if (type(playerinfo.merits) == 'table') then 
		for merit, value in pairs(playerinfo.merits) do
			total_merit_upgrades = total_merit_upgrades + value
		end
	end
	]]
	playertracker['Meritpoints_completed'] = total_merit_upgrades
	-- job points
	for id=1,22 do
		total_jp_spent = total_jp_spent + playerinfo:GetJobPointsSpent(id)
	end
	playertracker['Jobpoints_completed'] = total_jp_spent
	-- master levels
	for id=1,22 do
		total_master_levels = total_master_levels + playerinfo:GetJobMasterLevel(id)
		if (playerinfo:GetJobMasterLevel(id) > highest_master_level) then highest_master_level = playerinfo:GetJobMasterLevel(id) end
	end
	playertracker['Masterlevels_completed'] = total_master_levels
	playertracker['Masterlevels_highest'] = highest_master_level
end

local ui ={}
-- UI HELPERS
function ui.render_items(tab)
	local items = tab.items
	local count = #items
	if count == 0 then
		-- add active_tab helper text here
		items = {{{1.0, .5, .5, .5}, 'Change zones to update Quests / Campaigns / Warps / Monstrosity'}, {{1, .5, .5, .5}, 'Check the README or "/xic help" to register NPC-related data'}}
		count = 1
	end
	for _, item in pairs(items) do
		if type(item) == 'table' then
			imgui.Text(item[2])
		else
			imgui.Text(item)
		end
	end
end

function ui.render()
	if (not trackermenusettings.visibility[1]) then
        return;
    end
	imgui.SetNextWindowSize({ 1000, 400, });
    imgui.SetNextWindowSizeConstraints({ 1000, 400, }, { FLT_MAX, FLT_MAX, });
    if (imgui.Begin('XIChecklist', trackermenusettings.visibility, ImGuiWindowFlags_AlwaysAutoResize)) then
		if (imgui.BeginTabBar('##checklist_tabbar', ImGuiTabBarFlags_NoCloseWithMiddleMouseButton)) then
			for i, tab in ipairs(tabs) do
				if (imgui.BeginTabItem(tab.name, nil)) then
					ui.render_items(tab)
					imgui.EndTabItem();
				end
			end
		end
		imgui.EndTabBar();
	end
	imgui.End();
end
-------------------------------------------------
ashita.events.register('d3d_present', 'present_cb', ui.render);

ashita.events.register('command', 'chronicle_command', function(e)
	local args = e.command:args();
    if (#args == 0 or (args[1] ~= "/xic" and args[1] ~= "/xichecklist")) then
        return;
    end
	if (#args == 2 or #args == 3) then
		if args[2] == 'eval' then
			assert(loadstring(table.concat(args, ' ',2)))()
		elseif (args[2] == "h" or args[2] == "help") then
			print(chat.header(addon.name):append(chat.message('==== xichecklist / xic ====')))
			print(chat.header(addon.name):append(chat.message('/xic [show|hide] to show / hide UI')))
			print(chat.header(addon.name):append(chat.message('/xic copy to copy current tab to clipboard')))
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
		elseif args[2] == 'show' then
			trackermenusettings.visibility = {true,}
			--settings.save()
		elseif args[2] == 'hide' then
			trackermenusettings.visibility = {false,}
			--settings.save()
		elseif args[2] == 'reload' then
			settings.reload()
			--settings.save()
		elseif args[2] == 'copy' then
			ashita.misc.set_clipboard(util.table_to_clipboard(tabs[1].items))
			print(chat.header(addon.name):append(chat.message('Copy to clipboard')))
		elseif args[2] == 'log' then
			if (args[3]) then
				if args[3]:lower() == 'titles' then
					util.log_tablog(tab_logs.titles)
					print(chat.header(addon.name):append(chat.message(('=== Titles (%d/%d) ==='):format(playertracker['Titles_completed'], playertracker['Titles_total']))))
				elseif args[3]:lower() == 'monstrosity' then
					print(chat.header(addon.name):append(chat.message(('=== Species Levels (%d/%d) ==='):format(playertracker['MonsterLevels_completed'], playertracker['MonsterLevels_total']))))
					util.log_tablog(tab_logs.monsterlevels)
					print(chat.header(addon.name):append(chat.message(('=== Monster Variants (%d/%d) ==='):format(playertracker['MonsterVariants_completed'], playertracker['MonsterVariants_total']))))
					util.log_tablog(tab_logs.monstervariants)
					print(chat.header(addon.name):append(chat.message(('=== Race / Job Instincts (%d/%d) ==='):format(playertracker['Racejobinstinct_completed'], playertracker['Racejobinstinct_total']))))
					util.log_tablog(tab_logs.racejobinstincts)
					print(chat.header(addon.name):append(chat.message(('=== Monster Instincts (%d/%d) ==='):format(playertracker['MonsterInsincts_completed'], playertracker['MonsterInsincts_total']))))
					util.log_tablog(tab_logs.monster_instincts)
				elseif args[3]:lower() == 'mmm' then
					print(chat.header(addon.name):append(chat.message(('=== MMM Vouchers Unlocks (%d/%d) ==='):format(playertracker['mmmvouchers_completed'], playertracker['mmmvouchers_total']))))
					util.log_tablog(tab_logs.mmmvouchers)
					print(chat.header(addon.name):append(chat.message(('=== MMM Runes Unlocks (%d/%d) ==='):format(playertracker['mmmrunes_completed'], playertracker['mmmrunes_total']))))
					util.log_tablog(tab_logs.mmmrunes)
				elseif args[3]:lower() == 'meeble' then
					print(chat.header(addon.name):append(chat.message(('=== Meeble Burrows (%d/%d) ==='):format(playertracker['meebleburrows_completed'], playertracker['meebleburrows_total']))))
					util.log_tablog(tab_logs.meeble_burrows)
				elseif args[3]:lower() == 'warps' then
					print(chat.header(addon.name):append(chat.message(('=== Home Points (%d/%d) ==='):format(playertracker['homepoints_completed'], playertracker['homepoints_total']))))
					util.log_tablog(tab_logs.homepoints)
					print(chat.header(addon.name):append(chat.message(('=== Survival Guides (%d/%d) ==='):format(playertracker['survivalguides_completed'], playertracker['survivalguides_total']))))
					util.log_tablog(tab_logs.survivalguides)
					print(chat.header(addon.name):append(chat.message(('=== Adoulin Waypoints (%d/%d) ==='):format(playertracker['waypoints_completed'], playertracker['waypoints_total']))))
					util.log_tablog(tab_logs.waypoints)
					print(chat.header(addon.name):append(chat.message(('=== Outpost Warps (%d/%d) ==='):format(playertracker['outposts_completed'], playertracker['outposts_total']))))
					util.log_tablog(tab_logs.outposts)
					print(chat.header(addon.name):append(chat.message(('=== Proto-Waypoints (%d/%d) ==='):format(playertracker['protowaypoints_completed'], playertracker['protowaypoints_total']))))
					util.log_tablog(tab_logs.protowaypoints)
				elseif args[3]:lower() == 'fish' then
					print(chat.header(addon.name):append(chat.message(('=== Type of Fish (%d/%d) ==='):format(playertracker['fishes_completed'], playertracker['fishes_total']))))
					util.log_tablog(tab_logs.fishes)
				elseif args[3]:lower() == 'quests' then
					print(chat.header(addon.name):append(chat.message(('=== San d\'Oria Quests (%d/%d) ==='):format(playertracker['sandoria_completed'], playertracker['sandoria_total']))))
					util.log_tablog(tab_logs.quests['sandoria'])
					print(chat.header(addon.name):append(chat.message(('=== Bastok Quests (%d/%d) ==='):format(playertracker['bastok_completed'], playertracker['bastok_total']))))
					util.log_tablog(tab_logs.quests['bastok'])
					print(chat.header(addon.name):append(chat.message(('=== Windurst Quests (%d/%d) ==='):format(playertracker['windurst_completed'], playertracker['windurst_total']))))
					util.log_tablog(tab_logs.quests['windurst'])
					print(chat.header(addon.name):append(chat.message(('=== Jeuno Quests (%d/%d) ==='):format(playertracker['jeuno_completed'], playertracker['jeuno_total']))))
					util.log_tablog(tab_logs.quests['jeuno'])
					print(chat.header(addon.name):append(chat.message(('=== Aht Urhgan Quests (%d/%d) ==='):format(playertracker['ahturhgan_completed'], playertracker['ahturhgan_total']))))
					util.log_tablog(tab_logs.quests['ahturhgan'])
					print(chat.header(addon.name):append(chat.message(('=== Crystal War Quests (%d/%d) ==='):format(playertracker['crystalwar_completed'], playertracker['crystalwar_total']))))
					util.log_tablog(tab_logs.quests['crystalwar'])
					print(chat.header(addon.name):append(chat.message(('=== Outlands Quests (%d/%d) ==='):format(playertracker['outlands_completed'], playertracker['outlands_total']))))
					util.log_tablog(tab_logs.quests['outlands'])
					print(chat.header(addon.name):append(chat.message(('=== Other Quests (%d/%d) ==='):format(playertracker['other_completed'], playertracker['other_total']))))
					util.log_tablog(tab_logs.quests['other'])
					print(chat.header(addon.name):append(chat.message(('=== Abyssea Quests (%d/%d) ==='):format(playertracker['abyssea_completed'], playertracker['abyssea_total']))))
					util.log_tablog(tab_logs.quests['abyssea'])
					print(chat.header(addon.name):append(chat.message(('=== Adoulin Quests (%d/%d) ==='):format(playertracker['adoulin_completed'], playertracker['adoulin_total']))))
					util.log_tablog(tab_logs.quests['adoulin'])
					print(chat.header(addon.name):append(chat.message(('=== Coalition Assignments (%d/%d) ==='):format(playertracker['coalition_completed'], playertracker['coalition_total']))))
					util.log_tablog(tab_logs.quests['coalition'])
					print(chat.header(addon.name):append(chat.message(('=== Campaign Ops (%d/%d) ==='):format(playertracker['campaign_completed'], playertracker['campaign_total']))))
					util.log_tablog(tab_logs.quests['campaign'])
				elseif args[3]:lower() == 'sandoria' then
					print(chat.header(addon.name):append(chat.message(('=== San d\'Oria Quests (%d/%d) ==='):format(playertracker['sandoria_completed'], playertracker['sandoria_total']))))
					util.log_tablog(tab_logs.quests['sandoria'])
				elseif args[3]:lower() == 'bastok' then
					print(chat.header(addon.name):append(chat.message(('=== Bastok Quests (%d/%d) ==='):format(playertracker['bastok_completed'], playertracker['bastok_total']))))
					util.log_tablog(tab_logs.quests['bastok'])
				elseif args[3]:lower() == 'windurst' then
					print(chat.header(addon.name):append(chat.message(('=== Windurst Quests (%d/%d) ==='):format(playertracker['windurst_completed'], playertracker['windurst_total']))))
					util.log_tablog(tab_logs.quests['windurst'])
				elseif args[3]:lower() == 'jeuno' then
					print(chat.header(addon.name):append(chat.message(('=== Jeuno Quests (%d/%d) ==='):format(playertracker['jeuno_completed'], playertracker['jeuno_total']))))
					util.log_tablog(tab_logs.quests['jeuno'])
				elseif args[3]:lower() == 'ahturhgan' then
					print(chat.header(addon.name):append(chat.message(('=== Aht Urhgan Quests (%d/%d) ==='):format(playertracker['ahturhgan_completed'], playertracker['ahturhgan_total']))))
					util.log_tablog(tab_logs.quests['ahturhgan'])
				elseif args[3]:lower() == 'crystalwar' then
					print(chat.header(addon.name):append(chat.message(('=== Crystal War Quests (%d/%d) ==='):format(playertracker['crystalwar_completed'], playertracker['crystalwar_total']))))
					util.log_tablog(tab_logs.quests['crystalwar'])
				elseif args[3]:lower() == 'outlands' then
					print(chat.header(addon.name):append(chat.message(('=== Outlands Quests (%d/%d) ==='):format(playertracker['outlands_completed'], playertracker['outlands_total']))))
					util.log_tablog(tab_logs.quests['outlands'])
				elseif args[3]:lower() == 'other' then
					print(chat.header(addon.name):append(chat.message(('=== Other Quests (%d/%d) ==='):format(playertracker['other_completed'], playertracker['other_total']))))
					util.log_tablog(tab_logs.quests['other'])
				elseif args[3]:lower() == 'abyssea' then
					print(chat.header(addon.name):append(chat.message(('=== Abyssea Quests (%d/%d) ==='):format(playertracker['abyssea_completed'], playertracker['abyssea_total']))))
					util.log_tablog(tab_logs.quests['abyssea'])
				elseif args[3]:lower() == 'adoulin' then
					print(chat.header(addon.name):append(chat.message(('=== Adoulin Quests (%d/%d) ==='):format(playertracker['adoulin_completed'], playertracker['adoulin_total']))))
					util.log_tablog(tab_logs.quests['adoulin'])
				elseif args[3]:lower() == 'coalition' then
					print(chat.header(addon.name):append(chat.message((('=== Coalition Assignments (%d/%d) ==='):format(playertracker['coalition_completed'], playertracker['coalition_total'])))))
					util.log_tablog(tab_logs.quests['coalition'])
				elseif args[3]:lower() == 'campaign' then
					print(chat.header(addon.name):append(chat.message((('=== Campaign Ops (%d/%d) ==='):format(playertracker['campaign_completed'], playertracker['campaign_total'])))))
					util.log_tablog(tab_logs.quests['campaign'])
				elseif (args[3]:lower() == 'main') or (args[3]:lower() == 'summary') then
					for key, text in pairs(tabs[1].items) do
						text = text:gsub('\\cs%(%d+,%d+,%d+%)', '')
						text = text:gsub('\\cr', '')
						print(chat.header(addon.name):append(chat.message((text))))
					end
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
	xichecklist_updatetabs(nil)
end

ashita.events.register('load', 'load_cb', addon_init);
ashita.events.register('unload', 'unload_cb', function()
	settings.save()
end)