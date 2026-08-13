local imgui = require('imgui');
local chat = require('chat')
local ui = {}
local tabs = {
    {
        name = 'Main'
    },
    {
        name = 'Story',
		tabs = {'sandoriamissions', 'bastokmissions', 'windurstmissions', 'zilartmissions', 'copmissions', 'assaults', 'ahturhganmissions', 'campaign', 'wotgmissions', 'acpmissions', 'mkdmissions', 'asamissions', 'soamissions', 'rovmissions', 'tvrmissions', 'sandoria', 'bastok', 'windurst', 'jeuno', 'ahturhgan', 'crystalwar', 'outlands', 'other', 'abyssea', 'adoulin', 'coalition'},
    },
	{
        name = 'Other Content',
		tabs = {'fishes', 'ergonlocus', 'jobpoints', 'masterlevels'},
    },
	{
        name = 'Key Items',
		tabs = {'Permanent_Key_Items', 'Magical_Maps', 'Mounts', 'Active_Effects', 'Abyssea', 'Voidwatch', 'Mog_Garden', 'Claim_Slips', 'atmacite'},
    },
	{
        name = 'Magic',
		tabs = {'WhiteMagic', 'BlackMagic', 'SummonerPact', 'Ninjutsu', 'BardSong', 'BlueMagic', 'Geomancy', 'Trust', 'CorsairRoll', 'pupattachments'}
    },
	{
        name = 'Warps',
		tabs = {'homepoints', 'survivalguides', 'waypoints', 'telepoints', 'cavernousmaws', 'lycopodium', 'eschanportals', 'outposts', 'protowaypoints', 'zones', 'abysseaconflux',
		'unknownwarps',
		},
    },
	{
        name = 'Monstrosity',
		tabs = {'monsterlevels', 'monstervariants', 'racejobinstincts', 'monsterinstincts'},
    },
	{
        name = 'Titles',
		tabs = {'titles', 'titles_by_content', 'titles_by_content_detailed'},
    },
	{
        name = 'RoE',
		tabs = {'roe'},
    },
	{
        name = 'Battle Content',
		tabs = {'mmm_mazecount', 'mmmvouchers','mmmrunes','meebleburrows','sheola','sheolb','sheolc','sheolgaol','vorseals', 'emporox'},
    },
}

addonhelptext = {
	titles = {
		{'You must talk to Aligi-Kufongi @ Tavnazian Safehold (H-9)', 'Aligi-Kufongi'},
		{'You must talk to Koyol-Futenol @ Aht Urhgan Whitegate (E-9)', 'Koyol-Futenol'},
		{'You must talk to Tamba-Namba @ Southern San d\'Oria (S) (L-8)', 'Tamba-Namba'},
		{'You must talk to Bhio Fehriata @ Bastok Markets (S) (I-10)', 'Bhio_Fehriata'},
		{'You must talk to Cattah Pamjah @ Windurst Waters (S) (G-10)', 'Cattah_Pamjah'},
		{'You must talk to Moozo-Koozo @ Southern San d\'Oria (K-6)', 'Moozo-Koozo'},
		{'You must talk to Styi Palneh @ Port Bastok (I-7)', 'Styi_Palneh'},
		{'You must talk to Burute-Sorute @ Windurst Walls (H-10)', 'Burute-Sorute'},
		{'You must talk to Tuh Almobankha @ Lower Jeuno (I-8)', 'Tuh_Almobankha'},
		{'You must talk to Zuah Lepahnyu @ Port Jeuno (J-8)', 'Zuah_Lepahnyu'},
		{'You must talk to Shupah Mujuuk @ Rabao (G-8)', 'Shupah_Mujuuk'},
		{'You must talk to Yulon-Polon @ Selbina (I-9)', 'Yulon-Polon'},
		{'You must talk to Willah Maratahya @ Mhaura (I-8)', 'Willah_Maratahya'},
		{'You must talk to Eron-Tomaron @ Kazham (G-7)', 'Eron-Tomaron'},
		{'You must talk to Quntsu-Nointsu @ Norg (G-7)', 'Quntsu-Nointsu'},
		{'You must talk to Debadle-Levadle @ Western Adoulin (H-8)', 'Debadle-Levadle'},
	},
	meebleburrows = {
		{'You must talk to Burrow Investigator @ Upper Jeuno (I-8)', 'meeble_sauromugue'},
		{'Menu: Review expedition specifics -> Sauromugue Champaign', 'meeble_sauromugue'},
		{'You must talk to Burrow Investigator @ Upper Jeuno (I-8)', 'meeble_batallia'},
		{'Menu: Review expedition specifics -> Batallia Downs', 'meeble_batallia'},
	},
	sheola = {
		{'You must talk to ??? @ Rabao (I-8) (Status Report: Moogle Mastery)', 'sheola'},
	},
	sheolb = {
		{'You must talk to ??? @ Rabao (I-8) (Status Report: Moogle Mastery)', 'sheolb'},
	},
	sheolc = {
		{'You must talk to ??? @ Rabao (I-8) (Status Report: Moogle Mastery)', 'sheolc'},
	},
	sheolgaol = {
		{'You must talk to ??? @ Rabao (I-8) (Status Report: Sheol Gaol)', 'sheolgaol'},
	},
	vorseals = {
		{'You must talk to Shiftrix @ Reisenjima (F-12)', 'vorseals'},
	},
	outposts = {
		{'You must talk to any Outpost Teleporter NPC @ three nations.', 'outpostnpc'},
	},
	protowaypoints = {
		{'You must talk to any Proto-Waypoint.', 'protowaypoint'},
	},
	fishes = {
		{'You must talk to Katsunaga @ Mhuaura (H-9) (Menu: Types of fishes caught)', 'katsunaga'},
	},
	atmacite = {
		{'You must talk to any Atmacite Refiner (Menu: Enrich Atmas)', 'atmacite_refiner'},
	},
	ergonlocus = {
		{'You must talk to Rienne @ Western Adoulin (J-9)', 'ergonlocus'},
	},
	emporox = {
		{'You must talk to Emporox @ Reisenjima #8', 'emporox'},
	},
	abysseaconflux = {
		{'You must talk to Veridical Conflux #01 @ Abyssea - Konschtat', 'veridicalconflux_15'},
		{'You must talk to Veridical Conflux #01 @ Abyssea - Tahrongi', 'veridicalconflux_45'},
		{'You must talk to Veridical Conflux #01 @ Abyssea - La Theine', 'veridicalconflux_132'},
		{'You must talk to Veridical Conflux #01 @ Abyssea - Attohwa', 'veridicalconflux_215'},
		{'You must talk to Veridical Conflux #01 @ Abyssea - Misareaux', 'veridicalconflux_216'},
		{'You must talk to Veridical Conflux #01 @ Abyssea - Vunkerl', 'veridicalconflux_217'},
		{'You must talk to Veridical Conflux #01 @ Abyssea - Altepa', 'veridicalconflux_218'},
		{'You must talk to Veridical Conflux #01 @ Abyssea - Uleguerand', 'veridicalconflux_253'},
		{'You must talk to Veridical Conflux #01 @ Abyssea - Grauberg', 'veridicalconflux_254'},
	},
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

render_maintab = function()
	
	append_maintab('Mastery Rank: %d', playertracker.mastery_rank)
	append_maintab('Checklist Progress %d/%d', util.totalpoints())

	imgui.Text('======= General =======')
	append_maintab('RoE %d/%d', playertracker.roe_completed, playertracker.roe_total)
	append_maintab('Zones visited %d/%d', playertracker.zones_completed, playertracker.zones_total)
	append_maintab('Titles %d/%d', playertracker.Titles_completed, playertracker.Titles_total)
	append_maintab('Missions %d/%d', (playertracker.sandoriamissions_completed+playertracker.bastokmissions_completed+playertracker.windurstmissions_completed+playertracker.zilartmissions_completed+playertracker.copmissions_completed+playertracker.ahturhganmissions_completed+playertracker.assaults_completed+playertracker.wotgmissions_completed+playertracker.acpmissions_completed+playertracker.mkdmissions_completed+playertracker.asamissions_completed+playertracker.soamissions_completed+playertracker.rovmissions_completed+playertracker.tvrmissions_completed+playertracker.campaign_completed), (playertracker.sandoriamissions_total+playertracker.bastokmissions_total+playertracker.windurstmissions_total+playertracker.zilartmissions_total+playertracker.copmissions_total+playertracker.ahturhganmissions_total+playertracker.assaults_total+playertracker.wotgmissions_total+playertracker.acpmissions_total+playertracker.mkdmissions_total+playertracker.asamissions_total+playertracker.soamissions_total+playertracker.rovmissions_total+playertracker.tvrmissions_total+playertracker.campaign_total))
	append_maintab('Quests %d/%d', (playertracker.bastok_completed+playertracker.sandoria_completed+playertracker.windurst_completed+playertracker.jeuno_completed+playertracker.ahturhgan_completed+playertracker.crystalwar_completed+playertracker.outlands_completed+playertracker.other_completed+playertracker.abyssea_completed+playertracker.adoulin_completed+playertracker.coalition_completed), (playertracker.bastok_total+playertracker.sandoria_total+playertracker.windurst_total+playertracker.jeuno_total+playertracker.ahturhgan_total+playertracker.crystalwar_total+playertracker.outlands_total+playertracker.other_total+playertracker.abyssea_total+playertracker.adoulin_total+playertracker.coalition_total))
	append_maintab('Magic %d/%d', (playertracker.WhiteMagic_completed+playertracker.BlackMagic_completed+playertracker.SummonerPact_completed+playertracker.Ninjutsu_completed+playertracker.BardSong_completed+playertracker.BlueMagic_completed+playertracker.Geomancy_completed+playertracker.Trust_completed), (playertracker.WhiteMagic_total+playertracker.BlackMagic_total+playertracker.SummonerPact_total+playertracker.Ninjutsu_total+playertracker.BardSong_total+playertracker.BlueMagic_total+playertracker.Geomancy_total+playertracker.Trust_total))
	append_maintab('Warps %d/%d', (playertracker.homepoints_completed+playertracker.survivalguides_completed+playertracker.waypoints_completed+playertracker.telepoints_completed+playertracker.cavernousmaws_completed+playertracker.lycopodium_completed+playertracker.eschanportals_completed+playertracker.outposts_completed+playertracker.protowaypoints_completed+playertracker.abysseaconflux_completed), (playertracker.homepoints_total+playertracker.survivalguides_total+playertracker.waypoints_total+playertracker.telepoints_total+playertracker.cavernousmaws_total+playertracker.lycopodium_total+playertracker.eschanportals_total+playertracker.outposts_total+playertracker.protowaypoints_total+playertracker.abysseaconflux_total))	

	imgui.Text('======= Story =======')
	append_maintab('San d\'Oria Missions %d/%d', playertracker.sandoriamissions_completed, playertracker.sandoriamissions_total)
	append_maintab('Bastok Missions %d/%d', playertracker.bastokmissions_completed, playertracker.bastokmissions_total)
	append_maintab('Windurst Missions %d/%d', playertracker.windurstmissions_completed, playertracker.windurstmissions_total)
	append_maintab('RotZ Missions %d/%d', playertracker.zilartmissions_completed, playertracker.zilartmissions_total)
	append_maintab('CoP Missions %d/%d', playertracker.copmissions_completed, playertracker.copmissions_total)
	append_maintab('Assaults %d/%d', playertracker.assaults_completed, playertracker.assaults_total)
	append_maintab('ToAU Missions %d/%d', playertracker.ahturhganmissions_completed, playertracker.ahturhganmissions_total)
	append_maintab('Campaign Ops %d/%d', playertracker.campaign_completed, playertracker.campaign_total)
	append_maintab('WoTG Missions %d/%d', playertracker.wotgmissions_completed, playertracker.wotgmissions_total)
	append_maintab('ACP Missions %d/%d', playertracker.acpmissions_completed, playertracker.acpmissions_total)
	append_maintab('MKD Missions %d/%d', playertracker.mkdmissions_completed, playertracker.mkdmissions_total)
	append_maintab('ASA Missions %d/%d', playertracker.asamissions_completed, playertracker.asamissions_total)
	append_maintab('SoA Missions %d/%d', playertracker.soamissions_completed, playertracker.soamissions_total)
	append_maintab('RoV Missions %d/%d', playertracker.rovmissions_completed, playertracker.rovmissions_total)
	append_maintab('TVR Missions %d/%d', playertracker.tvrmissions_completed, playertracker.tvrmissions_total)
	append_maintab('San d\'Oria Quests %d/%d', playertracker.sandoria_completed, playertracker.sandoria_total)
	append_maintab('Bastok Quests %d/%d', playertracker.bastok_completed, playertracker.bastok_total)
	append_maintab('Windurst Quests %d/%d', playertracker.windurst_completed, playertracker.windurst_total)
	append_maintab('Jeuno Quests %d/%d', playertracker.jeuno_completed, playertracker.jeuno_total)
	append_maintab('Other Quests %d/%d', playertracker.other_completed, playertracker.other_total)
	append_maintab('Outlands Quests %d/%d', playertracker.outlands_completed, playertracker.outlands_total)
	append_maintab('Aht Urhgan Quests %d/%d', playertracker.ahturhgan_completed, playertracker.ahturhgan_total)
	append_maintab('Crystal War Quests %d/%d', playertracker.crystalwar_completed, playertracker.crystalwar_total)
	append_maintab('Abyssea Quests %d/%d', playertracker.abyssea_completed, playertracker.abyssea_total)
	append_maintab('Adoulin Quests %d/%d', playertracker.adoulin_completed, playertracker.adoulin_total)
	append_maintab('Coalition Assignments %d/%d', playertracker.coalition_completed, playertracker.coalition_total)
	
	imgui.Text( '======= Key Items =======')
	append_maintab('Permanent Key Items %d/%d', playertracker.Permanent_Key_Items_completed, playertracker.Permanent_Key_Items_total)
	append_maintab('Magical Maps %d/%d', playertracker.Magical_Maps_completed, playertracker.Magical_Maps_total)
	append_maintab('Mounts %d/%d', playertracker.Mounts_completed, playertracker.Mounts_total)
	append_maintab('Claim Slips %d/%d', playertracker.Claim_Slips_completed, playertracker.Claim_Slips_total)
	append_maintab('Abyssea %d/%d', playertracker.Abyssea_completed, playertracker.Abyssea_total)
	append_maintab('Voidwatch  %d/%d', playertracker.Voidwatch_completed, playertracker.Voidwatch_total)
	append_maintab('Mog Garden  %d/%d', playertracker.Mog_Garden_completed, playertracker.Mog_Garden_total)
	append_maintab('Active Effects %d/%d', playertracker.Active_Effects_completed, playertracker.Active_Effects_total)
	append_maintab('Atmacite Levels %d/%d', playertracker.atmacite_completed, playertracker.atmacite_total)
	append_addonhelp( 'You must talk to any Atmacite Refiner (Menu: Enrich Atmas)', playertracker.talk_to_npc.atmacite_refiner)
	
	imgui.Text( '======= Magic =======')
	append_maintab('White Magic %d/%d', playertracker.WhiteMagic_completed, playertracker.WhiteMagic_total)
	append_maintab('Black Magic %d/%d', playertracker.BlackMagic_completed, playertracker.BlackMagic_total)
	append_maintab('Summoner Pacts %d/%d', playertracker.SummonerPact_completed, playertracker.SummonerPact_total)
	append_maintab('Ninjutsu %d/%d', playertracker.Ninjutsu_completed, playertracker.Ninjutsu_total)
	append_maintab('Bard Songs %d/%d', playertracker.BardSong_completed, playertracker.BardSong_total)
	append_maintab('Blue Magic %d/%d', playertracker.BlueMagic_completed, playertracker.BlueMagic_total)
	append_maintab('Geomancy %d/%d', playertracker.Geomancy_completed, playertracker.Geomancy_total)
	append_maintab('Trusts %d/%d', playertracker.Trust_completed, playertracker.Trust_total)
	append_maintab('Corsair Rolls %d/%d', playertracker.CorsairRoll_completed, playertracker.CorsairRoll_total)
	append_maintab('Puppetmaster Attachments %d/%d', playertracker.pupattachments_completed, playertracker.pupattachments_total)

	imgui.Text('======= Leveling =======')
	append_maintab('Craft Skills %d/%d', playertracker.craftingskills_completed, 790)
	append_maintab('Wing Skill %d/%d', playertracker.wingskill_completed, 100)
	append_addonhelp( 'You must talk to any Chocobo stats NPC @ Nations Chocobo Stables', playertracker.talk_to_npc.chocobokid)
	append_maintab('Merit Points %d/%d', playertracker.meritpoints_completed, 919)
	append_maintab('Job Points Maxed %d/%d', playertracker.jobpoints_completed, 22)
	append_maintab('Master Levels %d/%d (Highest: %d)', playertracker.masterlevels_completed, 1100, playertracker.masterlevels_highest)
	append_maintab('Alter Ego Points %d/%d', playertracker.alteregopoint_completed, playertracker.alteregopoint_total)
	
	imgui.Text( '======= Warps =======')
	append_maintab('Home Points %d/%d', playertracker.homepoints_completed, playertracker.homepoints_total)
	append_maintab('Survival Guides %d/%d', playertracker.survivalguides_completed, playertracker.survivalguides_total)
	append_maintab('Waypoints %d/%d', playertracker.waypoints_completed, playertracker.waypoints_total)
	append_maintab('Telepoints %d/%d', playertracker.telepoints_completed, playertracker.telepoints_total)
	append_maintab('Cavernous Maws %d/%d', playertracker.cavernousmaws_completed, playertracker.cavernousmaws_total)
	append_maintab('Lycopodium %d/%d', playertracker.lycopodium_completed, playertracker.lycopodium_total)
	append_maintab('Eschan Portals %d/%d', playertracker.eschanportals_completed, playertracker.eschanportals_total)
	append_maintab('Outposts %d/%d', playertracker.outposts_completed, playertracker.outposts_total)
	append_addonhelp( 'You must talk to any Outpost Teleporter NPC @ three nations.', playertracker.talk_to_npc.outpostnpc)
	append_maintab('Proto-Waypoints %d/%d', playertracker.protowaypoints_completed, playertracker.protowaypoints_total)
	append_addonhelp( 'You must talk to any Proto-Waypoint.', playertracker.talk_to_npc.protowaypoint)
	append_maintab('Abyssea Conflux %d/%d', playertracker.abysseaconflux_completed, playertracker.abysseaconflux_total)

	imgui.Text( '======= Other Content =======')
	append_maintab('Fishes Caught %d/%d', playertracker.fishes_completed, 164)
	append_addonhelp( 'You must talk to Katsunaga @ Mhuaura (H-9) (Menu: Types of fishes caught)', playertracker.talk_to_npc.katsunaga)
	append_maintab('Ergon Locus %d/%d', playertracker.ergonlocus_completed, playertracker.ergonlocus_total)
	append_addonhelp('You must talk to Rienne @ (50,150,255)Western Adoulin (J-9)', playertracker.talk_to_npc.ergonlocus)

	imgui.Text( '======= Monstrosity =======')
	append_maintab('Monster Levels Maxed %d/%d', playertracker.monsterlevels_completed, playertracker.monsterlevels_total)
	append_maintab('Race/Job Instincts %d/%d', playertracker.racejobinstinct_completed, playertracker.racejobinstinct_total)
	append_maintab('Monster Variants %d/%d', playertracker.monstervariants_completed, playertracker.monstervariants_total)
	append_maintab('Monster Instincts %d/%d', playertracker.monsterinsincts_completed, playertracker.monsterinsincts_total)
	
	imgui.Text( '======= Battle Content =======')
	append_maintab('MMM Vouchers Unlocked %d/%d', playertracker.mmmvouchers_completed, playertracker.mmmvouchers_total)
	append_maintab('MMM Runes Unlocked %d/%d', playertracker.mmmrunes_completed, playertracker.mmmrunes_total)
	append_maintab('MMM Maze count %d/%d', playertracker.mmm_mazecount, 1000)
	append_addonhelp('You must talk to any Chatnachoq @ Lower Jeuno (H-9) ', playertracker.talk_to_npc.chatnachoq)
	append_maintab('Meeble Burrows Goal #3 %d/%d', playertracker.meebleburrows_completed, playertracker.meebleburrows_total)
	append_addonhelp('You must talk to Burrow Investigator @ Upper Jeuno (I-8)', playertracker.talk_to_npc.meeble_sauromugue)
	append_addonhelp( 'Menu: Review expedition specifics -> Sauromugue Champaign', playertracker.talk_to_npc.meeble_sauromugue)
	append_addonhelp('You must talk to Burrow Investigator @ Upper Jeuno (I-8)', playertracker.talk_to_npc.meeble_batallia)
	append_addonhelp('Menu: Review expedition specifics -> Batallia Downs', playertracker.talk_to_npc.meeble_batallia)
	append_maintab('Sheol A (%d/%d)', playertracker.sheola_completed, playertracker.sheola_total)
	append_addonhelp('You must talk to ??? @ Rabao (I-8) (Status Report: Moogle Mastery)', playertracker.talk_to_npc.sheola)
	append_maintab('Sheol B (%d/%d)', playertracker.sheolb_completed, playertracker.sheolb_total)
	append_addonhelp('You must talk to ??? @ Rabao (I-8) (Status Report: Moogle Mastery)', playertracker.talk_to_npc.sheolb)
	append_maintab('Sheol C (%d/%d)', playertracker.sheolc_completed, playertracker.sheolc_total)
	append_addonhelp('You must talk to ??? @ Rabao (I-8) (Status Report: Moogle Mastery)', playertracker.talk_to_npc.sheolc)
	append_maintab('Sheol Gaol Vengeance (%d/%d)', playertracker.sheolgaoltiers_completed, playertracker.sheolgaoltiers_total)
	append_addonhelp('You must talk to ??? @ Rabao (I-8) (Status Report: Sheol Gaol)', playertracker.talk_to_npc.sheolgaol)
	append_maintab('Eschan Vorseals (%d/%d)', playertracker.vorseals_completed, playertracker.vorseals_total)
	append_addonhelp('You must talk to Shiftrix @ Reisenjima (F-12)', playertracker.talk_to_npc.vorseals)
	append_maintab('Emporox Goodness %d/%d', playertracker.emporox_completed, playertracker.emporox_total)
	append_addonhelp('You must talk to Emporox @ Reisenjima #8', playertracker.talk_to_npc.emporox)

	imgui.Text( '======= Titles =======')
	append_maintab('Titles %d/%d', playertracker.Titles_completed, playertracker.Titles_total)
	append_items(tab_logs.titles_by_content.items)
	
end

local rendertabs = function(tab)
	for idx, tab in ipairs(tab.tabs) do
		append_header(tab_logs[tab].name..' (%d/%d)', tab_logs[tab].completed, tab_logs[tab].total)
		if (addonhelptext[tab]) then
			for hi, helptext in pairs(addonhelptext[tab]) do
				append_addonhelp(addonhelptext[tab][hi][1], playertracker.talk_to_npc[addonhelptext[tab][hi][2]])
			end
		end
		append_items(tab_logs[tab].items)
	end
end

append_addonhelp = function(text, condition)
	if not (condition and trackermenusettings.showcompleted) then
		append_items({util.list_item('Addon Help', text, condition)})
	end
end

-- UI HELPERS
function ui.render_items(tab)
	if trackermenusettings.initial then
		-- add active_tab helper text here
		imgui.TextColored({1.0, .5, .5, .5}, 'Change zones to update Quests / Campaigns / Warps / Monstrosity')
		imgui.TextColored({1.0, .5, .5, .5}, 'Check the README or "/xic help" to register NPC-related data')
        trackermenusettings.initial = false
	elseif tab.name == 'Main' then
		render_maintab()
	else
		rendertabs(tab)
	end
end

function ui.render()
	if (not trackermenusettings.visibility) then
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

return ui