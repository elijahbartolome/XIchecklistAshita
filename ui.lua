local imgui = require('imgui');
local ui = {}
local tabs = {
    'Main', 'Missions', 'Quests', 'Campaign', 'Fish', 'Key Items', 'Magic', 'Warps', 'Monstrosity', 'Titles', 'RoE', 'Battle Content'
}

local function append_items(src)
    if type(src) ~= 'table' then
        return
    end
    for _, item in ipairs(src) do
		local text = item.text
		local display = true
		local menucolor = { 1.0, 0.0, 0.0, 1.0 }
		if (item.completed == true and trackermenusettings.showcompleted == false) then
			display = false
		end
		if item.category ~= nil then 
			text = '['..item.category..'] '..text
		end
		if item.category == 'Addon Help' then
			menucolor = {1.0, 1.0, 0.0, 1.0}
		end
		if item.completed == true then
			menucolor = {0.0, 1.0, 0.0, 1.0}
		end
		if item.obtainmethod ~= nil then 
			text = text..item.obtainmethod
		end
		if (display == true) then
			imgui.TextColored(menucolor, text)
		end
    end
end

local function append_maintab(text, ...)
	local args = {...}
	local menulinecolor = { 1.0, 0.0, 0.0, 1.0 }
	if (args[1]==args[2]) then menulinecolor = {0.0, 1.0, 0.0, 1.0} end
	imgui.TextColored(menulinecolor, '-'..text:format(...))
end

local function append_header(text, ...)
	local args = {...}
	local menulinecolor = { 1.0, 0.0, 0.0, 1.0 }
	if (args[1]==args[2]) then menulinecolor = {0.0, 1.0, 0.0, 1.0} end
	text = '==== '..text..' ===='
		imgui.TextColored(menulinecolor, text:format(...))
	if args[2] == 0 then
		imgui.TextColored({1.0, 235/255, 0.0, 0.0}, 'You must zone to update.')
	end
	
end

local function append_addonhelp(text, condition)
	append_items({util.list_item('Addon Help', text, condition)})
end

local function update_maintab()
	
	append_maintab('Mastery Rank: %d', tab_logs['mastery_rank'])
	append_maintab('Checklist Progress %d/%d', util.totalpoints())
	imgui.Text('======= RoE =======')
	append_maintab('RoE %d/%d', tab_logs['RoE_completed'], tab_logs['RoE_total'])
	
	imgui.Text('======= Missions =======')
	append_maintab('San d\'Oria Missions %d/%d', tab_logs['sandoriamissions_completed'], tab_logs['sandoriamissions_total'])
	append_maintab('Bastok Missions %d/%d', tab_logs['bastokmissions_completed'], tab_logs['bastokmissions_total'])
	append_maintab('Windurst Missions %d/%d', tab_logs['windurstmissions_completed'], tab_logs['windurstmissions_completed'])
	append_maintab('Zilart Missions %d/%d', tab_logs['zilartmissions_completed'], tab_logs['zilartmissions_total'])
	append_maintab('CoP Missions %d/%d', tab_logs['copmissions_completed'], tab_logs['copmissions_total'])
	append_maintab('TOAU Missions %d/%d', tab_logs['ahturhganmissions_completed'], tab_logs['ahturhganmissions_total'])
	append_maintab('WOTG Missions %d/%d', tab_logs['wotgmissions_completed'], tab_logs['wotgmissions_total'])
	append_maintab('ACP Missions %d/%d', tab_logs['acpmissions_completed'], tab_logs['acpmissions_total'])
	append_maintab('MKD Missions %d/%d', tab_logs['mkdmissions_completed'], tab_logs['mkdmissions_total'])
	append_maintab('ASA Missions %d/%d', tab_logs['asamissions_completed'], tab_logs['asamissions_total'])
	append_maintab('SoA Missions %d/%d', tab_logs['soamissions_completed'], tab_logs['soamissions_total'])
	append_maintab('RoV Missions %d/%d', tab_logs['rovmissions_completed'], tab_logs['rovmissions_total'])
	append_maintab('TVR Missions %d/%d', tab_logs['tvrmissions_completed'], tab_logs['tvrmissions_total'])

	imgui.Text( '======= Quests & Ops =======')
	append_maintab('Campaign Ops %d/%d', tab_logs['campaign_completed'], tab_logs['campaign_total'])
	append_maintab('Bastok Quests %d/%d', tab_logs['bastok_completed'], tab_logs['bastok_total'])
	append_maintab('San d\'Oria Quests %d/%d', tab_logs['sandoria_completed'], tab_logs['sandoria_total'])
	append_maintab('Windurst Quests %d/%d', tab_logs['windurst_completed'], tab_logs['windurst_total'])
	append_maintab('Jeuno Quests %d/%d', tab_logs['jeuno_completed'], tab_logs['jeuno_total'])
	append_maintab('Aht Urhgan Quests %d/%d', tab_logs['ahturhgan_completed'], tab_logs['ahturhgan_total'])
	append_maintab('Crystal War Quests %d/%d', tab_logs['crystalwar_completed'], tab_logs['crystalwar_total'])
	append_maintab('Outlands Quests %d/%d', tab_logs['outlands_completed'], tab_logs['outlands_total'])
	append_maintab('Other Quests %d/%d', tab_logs['other_completed'], tab_logs['other_total'])
	append_maintab('Abyssea Quests %d/%d', tab_logs['abyssea_completed'], tab_logs['abyssea_total'])
	append_maintab('Adoulin Quests %d/%d', tab_logs['adoulin_completed'], tab_logs['adoulin_total'])
	append_maintab('Coalition Assignments %d/%d', tab_logs['coalition_completed'], tab_logs['coalition_total'])
	
	imgui.Text( '======= Key Items =======')
	append_maintab('Permanent Key Items %d/%d', tab_logs['Permanent_Key_Items_completed'], tab_logs['Permanent_Key_Items_total'])
	append_maintab('Magical Maps %d/%d', tab_logs['Magical_Maps_completed'], tab_logs['Magical_Maps_total'])
	append_maintab('Mounts %d/%d', tab_logs['Mounts_completed'], tab_logs['Mounts_total'])
	append_maintab('Claim Slips %d/%d', tab_logs['Claim_Slips_completed'], tab_logs['Claim_Slips_total'])
	append_maintab('Active Effects %d/%d', tab_logs['Active_Effects_completed'], tab_logs['Active_Effects_total'])
	append_maintab('Voidwatch %d/%d', tab_logs['Voidwatch_completed'], tab_logs['Voidwatch_total'])
	append_maintab('Atmacite Levels %d/%d', playertracker['atmacitelevels_completed'], playertracker['atmacitelevels_total'])
	append_addonhelp( 'You must talk to any Atmacite Refiner (Menu: Enrich Atmas)', playertracker.talk_to_npc['atmacite_refiner'])
	
	imgui.Text( '======= Magic =======')
	append_maintab('White Magic %d/%d', tab_logs['WhiteMagic_completed'], tab_logs['WhiteMagic_total'])
	append_maintab('Black Magic %d/%d', tab_logs['BlackMagic_completed'], tab_logs['BlackMagic_total'])
	append_maintab('Summoner Pacts %d/%d', tab_logs['SummonerPact_completed'], tab_logs['SummonerPact_total'])
	append_maintab('Ninjutsu %d/%d', tab_logs['Ninjutsu_completed'], tab_logs['Ninjutsu_total'])
	append_maintab('Bard Songs %d/%d', tab_logs['BardSong_completed'], tab_logs['BardSong_total'])
	append_maintab('Blue Magic %d/%d', tab_logs['BlueMagic_completed'], tab_logs['BlueMagic_total'])
	append_maintab('Geomancy %d/%d', tab_logs['Geomancy_completed'], tab_logs['Geomancy_total'])
	append_maintab('Trusts %d/%d', tab_logs['Trust_completed'], tab_logs['Trust_total'])

	imgui.Text('======= Leveling =======')
	append_maintab('Craft Skills %d/%d', tab_logs['craftingskills_completed'], 790)
	append_maintab('Wing Skill %d/%d', playertracker['wingskill_completed'], 100)
	append_addonhelp( 'You must talk to any Chocobo stats NPC @ Nations Chocobo Stables', playertracker.talk_to_npc['chocobokid'])
	append_maintab('Merit Points %d/%d', tab_logs['Meritpoints_completed'], 919)
	append_maintab('Job Points %d/%d', tab_logs['Jobpoints_completed'], 46200)
	append_maintab('Master Levels %d/%d (Highest: %d)', tab_logs['Masterlevels_completed'], 1100, tab_logs['Masterlevels_highest'])
	
	imgui.Text( '======= Warps =======')
	append_maintab('Home Points %d/%d', tab_logs['homepoints_completed'], tab_logs['homepoints_total'])
	append_maintab('Survival Guides %d/%d', tab_logs['survivalguides_completed'], tab_logs['survivalguides_total'])
	append_maintab('Waypoints %d/%d', tab_logs['waypoints_completed'], tab_logs['waypoints_total'])
	append_maintab('Outposts %d/%d', playertracker['outposts_completed'], playertracker['outposts_total'])
	append_addonhelp( 'You must talk to any Outpost Teleporter NPC @ three nations.', playertracker.talk_to_npc['outpostnpc'])
	append_maintab('Proto-Waypoints %d/%d', playertracker['protowaypoints_completed'], playertracker['protowaypoints_total'])
	append_addonhelp( 'You must talk to any Proto-Waypoint.', playertracker.talk_to_npc['protowaypoint'])
	
	imgui.Text( '======= Fishing =======')
	append_maintab('Fishes Caught %d/%d', playertracker['fishes_completed'], 164)
	append_addonhelp( 'You must talk to Katsunaga @ Mhuaura (H-9) (Menu: Types of fishes caught)', playertracker.talk_to_npc['katsunaga'])
	
	imgui.Text( '======= Monstrosity =======')
	append_maintab('Monster Levels %d/%d', tab_logs['MonsterLevels_completed'], tab_logs['MonsterLevels_total'])
	append_maintab('Race/Job Instincts %d/%d', tab_logs['Racejobinstinct_completed'], tab_logs['Racejobinstinct_total'])
	append_maintab('Monster Variants %d/%d', tab_logs['MonsterVariants_completed'], tab_logs['MonsterVariants_total'])
	append_maintab('Monster Instincts %d/%d', tab_logs['MonsterInsincts_completed'], tab_logs['MonsterInsincts_total'])
	
	imgui.Text( '======= Battle Content =======')
	append_maintab('MMM Vouchers Unlocked %d/%d', tab_logs['mmmvouchers_completed'], tab_logs['mmmvouchers_total'])
	append_maintab('MMM Runes Unlocked %d/%d', tab_logs['mmmrunes_completed'], tab_logs['mmmrunes_total'])
	append_maintab('MMM Maze count %d', playertracker['mmm_mazecount'])
	append_addonhelp('You must talk to any Chatnachoq @ Lower Jeuno (H-9) ', playertracker.talk_to_npc['chatnachoq'])
	append_maintab('Meeble Burrows Goal #3 %d/%d', playertracker['meebleburrows_completed'], playertracker['meebleburrows_total'])
	append_addonhelp('You must talk to Burrow Investigator @ Upper Jeuno (I-8)', playertracker.talk_to_npc['meeble_sauromugue'])
	append_addonhelp( 'Menu: Review expedition specifics -> Sauromugue Champaign', playertracker.talk_to_npc['meeble_sauromugue'])
	append_addonhelp('You must talk to Burrow Investigator @ Upper Jeuno (I-8)', playertracker.talk_to_npc['meeble_batallia'])
	append_addonhelp('Menu: Review expedition specifics -> Batallia Downs', playertracker.talk_to_npc['meeble_batallia'])
	append_maintab('Sheol Gaol Vengeance (%d/%d)', playertracker['sheolgaoltiers_completed'], playertracker['sheolgaoltiers_total'])
	append_addonhelp('You must talk to ??? @ Rabao (I-8) (Status Report: Sheol Gaol)', playertracker.talk_to_npc['sheolgaol'])

	imgui.Text( '======= Titles =======')
	append_maintab('Titles %d/%d', playertracker['Titles_completed'], playertracker['Titles_total'])
	append_items(menus_util.list_titles_bycontent())
	
end

local function xichecklist_updatetabs(tab)
	if not player then return false
	
	elseif (tab == 'Missions') then
		-- log missions
		append_header('San d\'Oria Missions (%d/%d)', tab_logs['sandoriamissions_completed'], tab_logs['sandoriamissions_total'])
		append_items(tab_logs.quests['sandoriamissions'])
		append_header('Bastok Missions (%d/%d)', tab_logs['bastokmissions_completed'], tab_logs['bastokmissions_total'])
		append_items(tab_logs.quests['bastokmissions'])
		append_header('Windurst Missions (%d/%d)', tab_logs['windurstmissions_completed'], tab_logs['windurstmissions_total'])
		append_items(tab_logs.quests['windurstmissions'])
		append_header('Zilart Missions (%d/%d)', tab_logs['zilartmissions_completed'], tab_logs['zilartmissions_total'])
		append_items(tab_logs.quests['zilartmissions'])
		append_header('CoP Missions (%d/%d)', tab_logs['copmissions_completed'], tab_logs['copmissions_total'])
		append_items(tab_logs.quests['copmissions'])
		append_header('TOAU Missions (%d/%d)', tab_logs['ahturhganmissions_completed'], tab_logs['ahturhganmissions_total'])
		append_items(tab_logs.quests['ahturhganmissions'])
		append_header('WOTG Missions (%d/%d)', tab_logs['wotgmissions_completed'], tab_logs['wotgmissions_total'])
		append_items(tab_logs.quests['wotgmissions'])
		append_header('ACP Missions (%d/%d)', tab_logs['acpmissions_completed'], tab_logs['acpmissions_total'])
		append_items(tab_logs.quests['acpmissions'])
		append_header('MKD Missions (%d/%d)', tab_logs['mkdmissions_completed'], tab_logs['mkdmissions_total'])
		append_items(tab_logs.quests['mkdmissions'])
		append_header('ASA Missions (%d/%d)', tab_logs['asamissions_completed'], tab_logs['asamissions_total'])
		append_items(tab_logs.quests['asamissions'])
		append_header('SoA Missions (%d/%d)', tab_logs['soamissions_completed'], tab_logs['soamissions_total'])
		append_items(tab_logs.quests['soamissions'])
		append_header('RoV Missions (%d/%d)', tab_logs['rovmissions_completed'], tab_logs['rovmissions_total'])
		append_items(tab_logs.quests['rovmissions'])
		append_header('TVR Missions (%d/%d)', tab_logs['tvrmissions_completed'], tab_logs['tvrmissions_total'])
		append_items(tab_logs.quests['tvrmissions'])

	elseif (tab == 'Quests') then
		-- log quests
		append_header( 'San d\'Oria Quests (%d/%d)', tab_logs['sandoria_completed'], tab_logs['sandoria_total'])
		append_items(tab_logs.quests['sandoria'])
		append_header( 'Bastok Quests (%d/%d)', tab_logs['bastok_completed'], tab_logs['bastok_total'])
		append_items( tab_logs.quests['bastok'])
		append_header( 'Windurst Quests (%d/%d)', tab_logs['windurst_completed'], tab_logs['windurst_total'])
		append_items(tab_logs.quests['windurst'])
		append_header( 'Jeuno Quests (%d/%d)', tab_logs['jeuno_completed'], tab_logs['jeuno_total'])
		append_items(tab_logs.quests['jeuno'])
		append_header( 'Aht Urhgan Quests (%d/%d)', tab_logs['ahturhgan_completed'], tab_logs['ahturhgan_total'])
		append_items(tab_logs.quests['ahturhgan'])
		append_header( 'Crystal War Quests (%d/%d)', tab_logs['crystalwar_completed'], tab_logs['crystalwar_total'])
		append_items(tab_logs.quests['crystalwar'])
		append_header( 'Outlands Quests (%d/%d)', tab_logs['outlands_completed'], tab_logs['outlands_total'])
		append_items( tab_logs.quests['outlands'])
		append_header( 'Other Quests (%d/%d)', tab_logs['other_completed'], tab_logs['other_total'])
		append_items( tab_logs.quests['other'])
		append_header( 'Abyssea Quests (%d/%d)', tab_logs['abyssea_completed'], tab_logs['abyssea_total'])
		append_items( tab_logs.quests['abyssea'])
		append_header( 'Adoulin Quests (%d/%d)', tab_logs['adoulin_completed'], tab_logs['adoulin_total'])
		append_items( tab_logs.quests['adoulin'])
		append_header( 'Coalition Assignments (%d/%d)', tab_logs['coalition_completed'], tab_logs['coalition_total'])
		append_items( tab_logs.quests['coalition'])
	elseif (tab == "Campaign") then
	-- log campaign ops
		append_header( 'Campaign Ops (%d/%d)', tab_logs['campaign_completed'], tab_logs['campaign_total'])
		append_items( tab_logs.quests['campaign'])
	
	-- log Monstrosity levels & Race/Job Instincts
	elseif (tab == 'Monstrosity') then
		append_header( 'Species Levels (%d/%d)', tab_logs['MonsterLevels_completed'], tab_logs['MonsterLevels_total'])
		append_items( tab_logs.monsterlevels)
		append_header( 'Monster Variants (%d/%d)', tab_logs['MonsterVariants_completed'], tab_logs['MonsterVariants_total'])
		append_items( tab_logs.monstervariants)
		append_header( 'Race / Job Instincts (%d/%d)', tab_logs['Racejobinstinct_completed'], tab_logs['Racejobinstinct_total'])
		append_items( tab_logs.racejobinstincts)
		append_header( 'Monster Instincts (%d/%d)', tab_logs['MonsterInsincts_completed'], tab_logs['MonsterInsincts_total'])
		append_items( tab_logs.monster_instincts)
	
	-- log RoE
	elseif (tab == 'RoE') then
		append_header( 'RoE (%d/%d)', tab_logs['RoE_completed'], tab_logs['RoE_total'])
		append_items( roe_util.log_roe())
	
	elseif (tab == 'Battle Content') then
		-- log MMM
		append_header( 'MM/M Vouchers Unlocks (%d/%d)', tab_logs['mmmvouchers_completed'], tab_logs['mmmvouchers_total'])
		append_items( tab_logs.mmmvouchers)
		append_header( 'MMM Runes Unlocks (%d/%d)', tab_logs['mmmrunes_completed'], tab_logs['mmmrunes_total'])
		append_items( tab_logs.mmmrunes)
		-- log Meeble Burrows
		append_header( 'Meeble Burrows (%d/%d)', playertracker['meebleburrows_completed'], playertracker['meebleburrows_total'])
		append_addonhelp( 'You must talk to Burrow Investigator @ Upper Jeuno (I-8)', playertracker.talk_to_npc['meeble_sauromugue'])
		append_addonhelp( 'Menu: Review expedition specifics -> Sauromugue Champaign', playertracker.talk_to_npc['meeble_sauromugue'])
		append_addonhelp( 'You must talk to Burrow Investigator @ Upper Jeuno (I-8)', playertracker.talk_to_npc['meeble_batallia'])
		append_addonhelp( 'Menu: Review expedition specifics -> Batallia Downs', playertracker.talk_to_npc['meeble_batallia'])
		append_items( tab_logs.meeble_burrows)
		-- Log Sheol Gaol Vengeance Tiers
		append_header( 'Sheol Gaol Vengeance (%d/%d)', playertracker['sheolgaoltiers_completed'], playertracker['sheolgaoltiers_total'])
		append_addonhelp( 'You must talk to ??? @ Rabao (I-8)m (Status Report: Sheol Gaol)', playertracker.talk_to_npc['sheolgaol'])
		append_items( tab_logs.sheolgaol)
	
	elseif (tab == 'Key Items') then
		-- log keyitems
		append_header( 'Permanent Key Items (%d/%d)', tab_logs['Permanent_Key_Items_completed'], tab_logs['Permanent_Key_Items_total'])
		append_items( tab_logs.keyitems['Permanent Key Items'])
		append_header( 'Magical Maps (%d/%d)', tab_logs['Magical_Maps_completed'], tab_logs['Magical_Maps_total'])
		append_items( tab_logs.keyitems['Magical Maps'])
		append_header( 'Mounts (%d/%d)', tab_logs['Mounts_completed'], tab_logs['Mounts_total'])
		append_items( tab_logs.keyitems['Mounts'])
		append_header( 'Claim Slips (%d/%d)', tab_logs['Claim_Slips_completed'], tab_logs['Claim_Slips_total'])
		append_items( tab_logs.keyitems['Claim Slips'])
		append_header( 'Active Effects (%d/%d)', tab_logs['Active_Effects_completed'], tab_logs['Active_Effects_total'])
		append_items( tab_logs.keyitems['Active Effects'])
		append_header( 'Voidwatch Key Items (%d/%d)', tab_logs['Voidwatch_completed'], tab_logs['Voidwatch_total'])
		append_items( tab_logs.keyitems['Voidwatch'])
		append_header( 'Atmacite Levels (%d/%d)', playertracker['atmacitelevels_completed'], playertracker['atmacitelevels_total'])
		append_addonhelp( 'You must talk to any Atmacite Refiner (Menu: Enrich Atmas)', playertracker.talk_to_npc['atmacite_refiner'])
		append_items( tab_logs.atmacite_levels)
	
	elseif (tab == 'Magic') then
		-- log spells and trusts
		append_header( 'White Magic (%d/%d)', tab_logs['WhiteMagic_completed'], tab_logs['WhiteMagic_total'])
		append_items( tab_logs.magic['WhiteMagic'])
		append_header( 'Black Magic (%d/%d)', tab_logs['BlackMagic_completed'], tab_logs['BlackMagic_total'])
		append_items( tab_logs.magic['BlackMagic'])
		append_header( 'Summoner Pacts (%d/%d)', tab_logs['SummonerPact_completed'], tab_logs['SummonerPact_total'])
		append_items( tab_logs.magic['SummonerPact'])
		append_header( 'Ninjutsu (%d/%d)', tab_logs['Ninjutsu_completed'], tab_logs['Ninjutsu_total'])
		append_items( tab_logs.magic['Ninjutsu'])
		append_header( 'Bard Songs (%d/%d)', tab_logs['BardSong_completed'], tab_logs['BardSong_total'])
		append_items( tab_logs.magic['BardSong'])
		append_header( 'Blue Magic (%d/%d)', tab_logs['BlueMagic_completed'], tab_logs['BlueMagic_total'])
		append_items( tab_logs.magic['BlueMagic'])
		append_header( 'Geomancy (%d/%d)', tab_logs['Geomancy_completed'], tab_logs['Geomancy_total'])
		append_items( tab_logs.magic['Geomancy'])
		append_header( 'Trust Magic (%d/%d)', tab_logs['Trust_completed'], tab_logs['Trust_total'])
		append_items( tab_logs.magic['Trust'])
	elseif (tab == 'Warps') then
		-- log warps
		append_header( 'Home Points (%d/%d)', tab_logs['homepoints_completed'], tab_logs['homepoints_total'])
		append_items( tab_logs.homepoints)
		append_header( 'Survival Guides (%d/%d)', tab_logs['survivalguides_completed'], tab_logs['survivalguides_total'])
		append_items( tab_logs.survivalguides)
		append_header( 'Adoulin Waypoints (%d/%d)', tab_logs['waypoints_completed'], tab_logs['waypoints_total'])
		append_items( tab_logs.waypoints)
		append_header( 'Outpost Warps (%d/%d)', playertracker['outposts_completed'], playertracker['outposts_total'])
		append_addonhelp( 'You must talk to any Outpost Teleporter NPC @ three nations.', playertracker.talk_to_npc['outpostnpc'])
		append_items( tab_logs.outposts)
		append_header( 'Proto-Waypoints (%d/%d)', playertracker['protowaypoints_completed'], playertracker['protowaypoints_total'])
		append_addonhelp( 'You must talk to any Proto-Waypoint.', playertracker.talk_to_npc['protowaypoint'])
		append_items( tab_logs.protowaypoints)
	elseif (tab == 'Fish') then
		-- log fishes caught
		append_header( 'Type of Fishes Caught (%d/%d)', playertracker['fishes_completed'], playertracker['fishes_total'])
		append_addonhelp( 'You must talk to Katsunaga @ Mhuaura (H-9) (Menu: Types of fishes caught)', playertracker.talk_to_npc['katsunaga'])
		append_items( tab_logs.fishes)
	elseif (tab == 'Titles') then
			-- log Titles
		append_header( 'Titles (%d/%d)', playertracker['Titles_completed'], playertracker['Titles_total'])
		append_addonhelp( 'You must talk to Aligi-Kufongi @ Tavnazian Safehold (H-9)', playertracker.talk_to_npc['Aligi-Kufongi'])
		append_addonhelp( 'You must talk to Koyol-Futenol @ Aht Urhgan Whitegate (E-9)', playertracker.talk_to_npc['Koyol-Futenol'])
		append_addonhelp( 'You must talk to Tamba-Namba @ Southern San d\'Oria (S) (L-8)', playertracker.talk_to_npc['Tamba-Namba'])
		append_addonhelp( 'You must talk to Bhio Fehriata @ Bastok Markets (S) (I-10)', playertracker.talk_to_npc['Bhio_Fehriata'])
		append_addonhelp( 'You must talk to Cattah Pamjah @ Windurst Waters (S) (G-10)', playertracker.talk_to_npc['Cattah_Pamjah'])
		append_addonhelp( 'You must talk to Moozo-Koozo @ Southern San d\'Oria (K-6)', playertracker.talk_to_npc['Moozo-Koozo'])
		append_addonhelp( 'You must talk to Styi Palneh @ Port Bastok (I-7)', playertracker.talk_to_npc['Styi_Palneh'])
		append_addonhelp( 'You must talk to Burute-Sorute @ Windurst Walls (H-10)', playertracker.talk_to_npc['Burute-Sorute'])
		append_addonhelp( 'You must talk to Tuh Almobankha @ Lower Jeuno (I-8)', playertracker.talk_to_npc['Tuh_Almobankha'])
		append_addonhelp( 'You must talk to Zuah Lepahnyu @ Port Jeuno (J-8)', playertracker.talk_to_npc['Zuah_Lepahnyu'])
		append_addonhelp( 'You must talk to Shupah Mujuuk @ Rabao (G-8)', playertracker.talk_to_npc['Shupah_Mujuuk'])
		append_addonhelp( 'You must talk to Yulon-Polon @ Selbina (I-9)', playertracker.talk_to_npc['Yulon-Polon'])
		append_addonhelp( 'You must talk to Willah Maratahya @ Mhaura (I-8)', playertracker.talk_to_npc['Willah_Maratahya'])
		append_addonhelp( 'You must talk to Eron-Tomaron @ Kazham (G-7)', playertracker.talk_to_npc['Eron-Tomaron'])
		append_addonhelp( 'You must talk to Quntsu-Nointsu @ Norg (G-7)', playertracker.talk_to_npc['Quntsu-Nointsu'])
		append_addonhelp( 'You must talk to Debadle-Levadle @ Western Adoulin (H-8)', playertracker.talk_to_npc['Debadle-Levadle'])
		append_items( tab_logs.titles)
	end
end

-- UI HELPERS
function ui.render_items(tab)
	if trackermenusettings.initial then
		-- add active_tab helper text here
		imgui.TextColored({1.0, .5, .5, .5}, 'Change zones to update Quests / Campaigns / Warps / Monstrosity')
		imgui.TextColored({1.0, .5, .5, .5}, 'Check the README or "/xic help" to register NPC-related data')
        trackermenusettings.initial = false
	elseif tab == 'Main' then
		update_maintab()
	else
		xichecklist_updatetabs(tab)
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
				if (imgui.BeginTabItem(tab, nil)) then
					ui.render_items(tab)
					imgui.EndTabItem();
				end
			end
		end
		imgui.EndTabBar();
	end
	imgui.End();
end

return ui