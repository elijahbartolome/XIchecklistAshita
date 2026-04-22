local menus_util = {}
local menumaps = require('../maps/maps_menus')
local titlesexclusions = require('../maps/titles_exclusions')
local titles_howtoobtain = require('../maps/titles_howtoobtain')

menu_current = {
	npcindex = nil,
	zoneid = nil,
	['Option Index'] = nil,
	_unknown1 = nil,
	['Menu Parameters'] = nil,
}

function table_contains(tbl, x)
    return tbl[x]
end

function menus_util.handle_npc_menu(e)
	local index
	local menuId
	if (e.id == 0x033) then
		index = struct.unpack('H', e.data, 0x08 + 0x01)
		menuId = struct.unpack('H', e.data, 0x0C + 0x01)
	elseif (e.id == 0x034) then
		index = struct.unpack('H', e.data, 0x28 + 0x01)
		menuId = struct.unpack('H', e.data, 0x2C + 0x01)
	end
	local npc = index and AshitaCore:GetMemoryManager():GetEntity():GetName(index)
	if not npc or not menu_npcs[npc] then
		return
	end
	if (table_contains(menu_npcs[npc].zoneid, AshitaCore:GetMemoryManager():GetParty():GetMemberZone(0)) 
		and table_contains(menu_npcs[npc].menuid, menuId)) then
		menu_npcs[npc]['menu_function'](e)
	end
end

function menus_util.handle_npc_submenu(e)
	local index = (menu_current.npcindex and menu_current.zoneid==AshitaCore:GetMemoryManager():GetParty():GetMemberZone(0)) and menu_current.npcindex
	if (index == nil) then return false end
	local npc = index and AshitaCore:GetMemoryManager():GetEntity():GetName(index)
	if not npc or not menu_npcs[npc] then
		return
	end
	if table_contains(menu_npcs[npc].zoneid, AshitaCore:GetMemoryManager():GetParty():GetMemberZone(0)) then
		menu_npcs[npc]['menu_function'](e)
	end
end

function menus_util.reset_current_menu()
	menu_current = {
		npcindex = nil,
		zoneid = nil,
		['Option Index'] = nil,
		_unknown1 = nil,
		['Menu Parameters'] = nil,
	}
end

function menus_util.handle_menu_options(e)
	local TargetIndex = struct.unpack('H', e.data, 0x0C + 0x01)
	local Zone = struct.unpack('H', e.data, 0x10 + 0x01)
	local OptionIndex = struct.unpack('H', e.data, 0x08 + 0x01)
	local unknown1 = struct.unpack('H', e.data, 0x0A + 0x01)
	menu_current = {
		npcindex = TargetIndex,
		zoneid = Zone,
		['Option Index'] = OptionIndex,
		_unknown1 = unknown1,
	}
end

function get_menu_parameters(e)
	if (e.id == 0x033) then
		local MenuParameters = {}
		for i = 0,255 do
			MenuParameters[i+1] = (ashita.bits.unpack_be(e.data_raw, 0x50, i, 1) == 1);
		end
		return MenuParameters
	elseif (e.id == 0x034) then
		local MenuParameters = {}
		for i = 0,255 do
			MenuParameters[i+1] = (ashita.bits.unpack_be(e.data_raw, 0x08, i, 1) == 1);
		end
		return MenuParameters
	elseif (e.id == 0x05C) then
		local MenuParameters = {}
		for i = 0,255 do
			MenuParameters[i+1] = (ashita.bits.unpack_be(e.data_raw, 0x04, i, 1) == 1);
		end
		return MenuParameters
	end
end

function menus_util.handle_op_warps(e)
	menu = get_menu_parameters(e)
	subdata = {}
	for i = 229, 255 do
		subdata[i-229] = menu[i]
	end
	for key, name in pairs(menumaps.outposts) do
		if (not util.has_bit(subdata, key+1)) then
			menus_util.add_outpost(key)
		end
	end
	playertracker.talk_to_npc['outpostnpc'] = true
	menus_util.log_outposts()
end

function menus_util.add_outpost(id)
	if (not (playertracker.outposts_unlocks[tostring(id)] == true)) then
		playertracker.outposts_unlocks[tostring(id)] = true
		
		util.addon_log('Outpost added: ' .. menumaps.outposts[id])
	end
end

function menus_util.log_outposts()
	output_list = {}
	local total, complete = 0,0
	for key, name in pairs(menumaps.outposts) do
		total = total+1
		local completion = false
		if (playertracker.outposts_unlocks[tostring(key)] == true) then
			complete = complete+1
			completion = true
		end
		table.insert(output_list, util.list_item('outpost', name, completion, nil))
	end
	playertracker['outposts_completed'] = complete
	playertracker['outposts_total'] = total
	tab_logs.outposts = output_list
end

function menus_util.handle_chatnachoq(e)
	menu = get_menu_parameters(e)
	local mazes = struct.unpack('I', e.data, 21)
	playertracker['mmm_mazecount'] = mazes
	
	util.addon_log('Maze count: ' .. mazes)
	playertracker.talk_to_npc['chatnachoq'] = true
	
end

function menus_util.handle_protowaypoint(e)
	menu = get_menu_parameters(e)
	--subdata = menu:sub(0x1C+1, 0x1E+1)
	for key, name in pairs(menumaps.protowaypoints) do
		if (util.has_bit(menu, key+1)) then
			menus_util.add_protowaypoint(key)
		end
	end
	playertracker.talk_to_npc['protowaypoint'] = true
	menus_util.log_protowaypoints()
end

function menus_util.add_protowaypoint(id)
	if (not (playertracker.protowaypoints_unlocks[tostring(id)] == true)) then
		playertracker.protowaypoints_unlocks[tostring(id)] = true
		
		util.addon_log('Proto-Waypoint added: ' .. menumaps.protowaypoints[id])
	end
end

function menus_util.log_protowaypoints()
	output_list = {}
	local total, complete = 0,0
	for key, name in pairs(menumaps.protowaypoints) do
		total = total+1
		local completion = false
		if (playertracker.protowaypoints_unlocks[tostring(key)] == true) then
			complete = complete+1
			completion = true
		end
		table.insert(output_list, util.list_item('proto-waypoint', name, completion, nil))
	end
	playertracker['protowaypoints_completed'] = complete
	playertracker['protowaypoints_total'] = total
	tab_logs.protowaypoints = output_list
end

function menus_util.handle_burrowsnpc(e)
	menu = get_menu_parameters(e)
	local map_name = nil
	if ((menu_current['zoneid'] == 244 and menu_current['_unknown1'] == 1) -- Upper Jeuno / Sauromugue Menu
		or (menu_current['zoneid'] == 120 and menu_current['Option Index'] == 14)) then
		map_name = 'Sauromugue_Champaign'
		menus_util.handle_sauromugueburrowsmenu(map_name, menu)
		playertracker.talk_to_npc['meeble_sauromugue'] = true
		menus_util.log_meeble_burrows()
	elseif ((menu_current['zoneid'] == 244 and menu_current['_unknown1'] == 2) -- Upper Jeuno / Batallia Menu
			or (menu_current['zoneid'] == 105 and menu_current['Option Index'] == 14)) then
		map_name = 'Batallia_Downs'
		menus_util.handle_batalliaburrowsmenu(map_name, menu)
		playertracker.talk_to_npc['meeble_batallia'] = true
		menus_util.log_meeble_burrows()
	end
end

function menus_util.handle_sauromugueburrowsmenu(map_name, menu_parameters)
	local burrowmap = menumaps.meeble_burrows[map_name]
	for id, name in pairs(burrowmap) do
		if util.has_bit(menu_parameters, id+1) then
			menus_util.add_meeble_burrows(id,map_name)
		end
	end
end

function menus_util.handle_batalliaburrowsmenu(map_name, menu_parameters)
	local burrowmap = menumaps.meeble_burrows[map_name]
	local batallia_unlocks = util.twobits_to_table(menu_parameters)
	for id, name in pairs(burrowmap) do
		if batallia_unlocks[id] == 3 then
			menus_util.add_meeble_burrows(id,map_name)
		end
	end
end

function menus_util.add_meeble_burrows(id,map_name)
	if (not (playertracker.meeble_completed[map_name][tostring(id)] == true)) then
		playertracker.meeble_completed[map_name][tostring(id)] = true
		
		util.addon_log('Meeble Burrow added: ' .. menumaps.meeble_burrows[map_name][id])
	end
end

function menus_util.log_meeble_burrows()
	output_list = {}
	local total, complete = 0,0
	for zone, burrows in pairs(menumaps.meeble_burrows) do
		for id, name in pairs(burrows) do
			total = total+1
			local completion = false
			if (playertracker.meeble_completed[zone][tostring(id)] == true) then
				complete = complete+1
				completion = true
			end
			table.insert(output_list, util.list_item(zone, name, completion, nil))
		end
	end
	playertracker['meebleburrows_completed'] = complete
	playertracker['meebleburrows_total'] = total
	tab_logs.meeble_burrows = output_list
end

function menus_util.handle_katsunaga(e)
	if menu_current['_unknown1'] == 0 then
		menu = get_menu_parameters(e)
		for flag, id in ipairs(menumaps.fishes_menu) do
			if (id ~= false) then
				if util.has_bit(menu, flag+1) then
					menus_util.add_fish_caught(id)
				end
			end
		end
		playertracker.talk_to_npc['katsunaga'] = true
		menus_util.log_fishes()
	end
end

function menus_util.add_fish_caught(id)
	if (not (playertracker.fishes_caught[tostring(id)] == true)) then
		playertracker.fishes_caught[tostring(id)] = true
		
		util.addon_log('Fish added: ' .. AshitaCore:GetResourceManager():GetItemById(id).Name[2])
	end
end

function menus_util.log_fishes()
	output_list = {}
	local total, complete = 0,0
	for key, id in pairs(menumaps.fishes_menu) do
		total = total+1
		local completion = false
		if (playertracker.fishes_caught[tostring(id)] == true) then
			complete = complete+1
			completion = true
		end
		if (id) then
			table.insert(output_list, util.list_item('fish', AshitaCore:GetResourceManager():GetItemById(id).Name[1], completion, nil))
		end
	end
	playertracker['fishes_completed'] = complete
	tab_logs.fishes = output_list
end

function get_key_items()
	local playMgr = AshitaCore:GetMemoryManager():GetPlayer();
	local player_KI = {}
    for i = 1,3583 do
        if playMgr:HasKeyItem(i) then
			player_KI[i] = true
        end
    end
	return player_KI
end

function menus_util.handle_atmacitenpc(e)
	menu = get_menu_parameters(e)
	local atmacite_levels = util.fourbits_to_table(menu)
	local playerkeyitems = get_key_items()
	if (menu_current['_unknown1'] == 0 and menu_current['Option Index'] == 2) then
		for key, atmacite in pairs(menumaps.atmacite) do
			if (table_contains(playerkeyitems, atmacite.id)) then
				playertracker.atmacite_levels[tostring(key)] = atmacite_levels[key]
				util.addon_log('Atmacite Updated: Lv'..atmacite_levels[key].. ' ' .. atmacite.en)
			end
		end
		playertracker.talk_to_npc['atmacite_refiner'] = true
		menus_util.log_atmacitelevels()
	end
end

function menus_util.log_atmacitelevels()
	output_list = {}
	local total, complete = 0,0
	for key, atmacite in ipairs(menumaps.atmacite) do
		total = total+15
		local completion = false
		if (playertracker.atmacite_levels[tostring(key)] == 15) then
			completion = true
		end
		local level = playertracker.atmacite_levels[tostring(key)] or 0
		complete = complete+level
		table.insert(output_list, util.list_item('atmacite', 'Lv. ('..level..'/15) ' .. atmacite.en, completion, nil))
	end
	playertracker['atmacitelevels_completed'] = complete
	tab_logs.atmacite_levels = output_list
end

function menus_util.handle_chocobostablenpc(e)
	menu = get_menu_parameters(e)
	if (menu ~= nil) then
		local winglevel = ashita.bits.unpack_be(e.data_raw, 0x08 + 4, 0, 8)
		if (winglevel > playertracker['wingskill_completed']) then
			playertracker['wingskill_completed'] = winglevel
			playertracker.talk_to_npc['chocobokid'] = true
			
			util.addon_log('Wing Skill updated: '..winglevel)
		end
	end
end

function menus_util.handle_titles_npc(e)
	local flags = e.data:sub(81, 104)
	local index
	if (e.id == 0x033) then
		index = struct.unpack('H', e.data, 0x08 + 0x01)
	elseif (e.id == 0x034) then
		index = struct.unpack('H', e.data, 0x28 + 0x01)
	end
	local npc = index and AshitaCore:GetMemoryManager():GetEntity():GetName(index)
	for cat, ids in ipairs(menumaps.titlesnpc_menu[npc]) do
		local category = struct.unpack('I', flags, 1 + (cat - 1) * 4)
		for flag, id in ipairs(ids) do
			if bit.band(category, bit.lshift(1, flag)) == 0 then
				menus_util.add_title(id)
			end
		end
	end
	playertracker.talk_to_npc[util.cleanspaces(npc)] = true
	menus_util.log_titles()
end

function menus_util.add_title(id)
	local titles = require('maps/titles')
	if (not (playertracker.titles[id] == true)) then
		playertracker.titles[id] = true
		util.addon_log('Title added: ' .. titles[id].en)
	end
end

function menus_util.log_titles()
	output_list = {}
	local total, complete = 0,0
	local titles = require('maps/titles')
	for key= 0,1150 do
		total = total+1
		local completion = false
		local obtainmethod = ''
		if (titles[key]) then
			if (titles_howtoobtain[titles[key].en]) then
				obtainmethod = '[' .. titles_howtoobtain[titles[key].en] .. ']'
			end
			if (playertracker.titles[key] == true) then
				complete = complete+1
				completion = true
			else
				if (table_contains(titlesexclusions, key)) then
					total = total - 1
				end
			end
			if (not table_contains(titlesexclusions, key)) then  
				table.insert(output_list, util.list_item(nil, titles[key].en, completion, obtainmethod))
			end
		end
	end
	playertracker['Titles_completed'] = complete
	playertracker['Titles_total'] = total
	tab_logs.titles = output_list
end

function menus_util.list_titles_bycontent()
	output_list = {}
	local titlescontent = require('../maps/titles_bycontent')
	for _, titles in ipairs(titlescontent) do
		local total, complete = 0,0
		local completion = false
		local content = titles[1]
		for titleid in pairs(titles[2]) do
			total = total+1
			if table_contains(titlesexclusions, titleid) then total = total-1 end
			if (playertracker.titles[titleid] == true) then
				complete = complete+1
				if (table_contains(titlesexclusions, titleid)) then total = total+1 end
			end
		end
		if (complete == total) then completion = true end
		table.insert(output_list, util.list_item(nil, '--' .. content ..(' titles %d/%d'):format(complete, total), completion, nil))
	end
	return output_list
end

function menus_util.handle_odyssey_questionmark(e)
	menu = get_menu_parameters(e)
	menu_data = util.byte_to_table_reverse(menu)
	if (menu_current['Option Index'] == 2) then 
		-- SheolA todo
		
	elseif (menu_current['Option Index'] == 8 or menu_current['Option Index'] == 9 or menu_current['Option Index'] == 10) then -- Choose Sheo Gaol status report
		for byteidx, name in pairs (menumaps.odyssey.gaol[menu_current['Option Index']]) do
			local data = menu_data[byteidx]
			local venglevel = bit.band(data, 0x1F) -- 5 bits are the veng level
			if (not playertracker.sheolgaol[tostring(menu_current['Option Index'])][tostring(byteidx)]) then
				util.addon_log(name..' V'..venglevel..' Added')
			elseif (venglevel > playertracker.sheolgaol[tostring(menu_current['Option Index'])][tostring(byteidx)]) then
				util.addon_log(name..' V'..venglevel..' Updated')
			end 
			playertracker.sheolgaol[tostring(menu_current['Option Index'])][tostring(byteidx)] = venglevel
		end
		playertracker.talk_to_npc['sheolgaol'] = true
		menus_util.log_sheolgaol()
	end
end

function menus_util.log_sheolgaol()
	local output_list = {}
	local total, complete = 0,0
	for optionidx, optiontbl in pairs(menumaps.odyssey.gaol) do
		for byteidx, name in pairs (optiontbl) do
			local venglevel = playertracker.sheolgaol[tostring(optionidx)][tostring(byteidx)] or 0
			local completion = false
			if venglevel == 25 then completion = true end
			table.insert(output_list, util.list_item('ShelGaol', 'V'..venglevel..' '..name, completion))
			complete = complete+venglevel
		end
	end
	playertracker['sheolgaoltiers_completed'] = complete
	tab_logs.sheolgaol = output_list
end

menu_npcs = {
	-- Outpost Warp NPCs
	['Conrad'] = {zoneid={[234] = true}, menuid={[584] = true,[581] = true}, menu_function=menus_util.handle_op_warps},
	['Jeanvirgaud'] = {zoneid={[231] = true}, menuid={[716] = true,[864] = true}, menu_function=menus_util.handle_op_warps},
	['Rottata'] = {zoneid={[240] = true}, menuid={[653] = true,[552] = true}, menu_function=menus_util.handle_op_warps},
	-- MMM NPC
	['Chatnachoq'] = {zoneid={[245] = true}, menuid={[10095] = true}, menu_function=menus_util.handle_chatnachoq},
	-- Proto-Waypoint NPCs
	['Proto-Waypoint'] = {zoneid={[243] = true,[248] = true,[249] = true,[247] = true,[252] = true}, menuid={[10209] = true,[10012] = true,[345] = true,[141] = true,[266] = true}, menu_function=menus_util.handle_protowaypoint},
	
	-- Meenle Burrow
	['Burrow Investigator'] = {zoneid={[244] = true}, menuid={[5500] = true}, menu_function=menus_util.handle_burrowsnpc},
	['Burrow Researcher'] = {zoneid={[120] = true,[105] = true}, menuid={[5500] = true}, menu_function=menus_util.handle_burrowsnpc},
	
	-- Fishing NPC
	['Katsunaga'] = {zoneid={[249] = true}, menuid={[197] = true}, menu_function=menus_util.handle_katsunaga},
	
	-- Atmacite Refiner
	['Atmacite Refiner'] = {
	zoneid={[26] = true,[51] = true,[80] = true,[84] = true,[87] = true,[91] = true,[94] = true,[98] = true,[105] = true,[110] = true,[120] = true,[126] = true,[230] = true,[235] = true,[238] = true,[247] = true,[250] = true,[252] = true}, 
	menuid={[6] = true,[7] = true,[8] = true,[15] = true,[16] = true,[24] = true,[25] = true,[46] = true,[49] = true,[79] = true,[264] = true,[627] = true,[657] = true,[962] = true,[1023] = true}, 
	menu_function=menus_util.handle_atmacitenpc},
	
	-- Chocobo NPC
	['Arvilauge'] = {zoneid={[230] = true}, menuid={[846] = true}, menu_function=menus_util.handle_chocobostablenpc},
	['Gonija'] = {zoneid={[234] = true}, menuid={[534] = true}, menu_function=menus_util.handle_chocobostablenpc},
	['Kiria-Romaria'] = {zoneid={[241] = true}, menuid={[761] = true}, menu_function=menus_util.handle_chocobostablenpc},
	
	-- Title Changer NPCs
	["Aligi-Kufongi"] = {zoneid={[26] = true}, menuid={[342] = true}, menu_function=menus_util.handle_titles_npc},
	["Koyol-Futenol"] = {zoneid={[50] = true}, menuid={[644] = true}, menu_function=menus_util.handle_titles_npc},
	["Tamba-Namba"] = {zoneid={[80] = true}, menuid={[306] = true}, menu_function=menus_util.handle_titles_npc},
	["Bhio Fehriata"] = {zoneid={[87] = true}, menuid={[167] = true}, menu_function=menus_util.handle_titles_npc},
	["Cattah Pamjah"] = {zoneid={[94] = true}, menuid={[138] = true}, menu_function=menus_util.handle_titles_npc},
	["Moozo-Koozo"] = {zoneid={[230] = true}, menuid={[675] = true}, menu_function=menus_util.handle_titles_npc},
	["Styi Palneh"] = {zoneid={[236] = true}, menuid={[200] = true}, menu_function=menus_util.handle_titles_npc},
	["Burute-Sorute"] = {zoneid={[239] = true}, menuid={[10004] = true}, menu_function=menus_util.handle_titles_npc},
	["Tuh Almobankha"] = {zoneid={[245] = true}, menuid={[10014] = true}, menu_function=menus_util.handle_titles_npc},
	["Zuah Lepahnyu"] = {zoneid={[246] = true}, menuid={[330] = true}, menu_function=menus_util.handle_titles_npc},
	["Shupah Mujuuk"] = {zoneid={[247] = true}, menuid={[1011] = true}, menu_function=menus_util.handle_titles_npc},
	["Yulon-Polon"] = {zoneid={[248] = true}, menuid={[10001] = true}, menu_function=menus_util.handle_titles_npc},
	["Willah Maratahya"] = {zoneid={[249] = true}, menuid={[10001] = true}, menu_function=menus_util.handle_titles_npc},
	["Eron-Tomaron"] = {zoneid={[250] = true}, menuid={[10013] = true}, menu_function=menus_util.handle_titles_npc},
	["Quntsu-Nointsu"] = {zoneid={[252] = true}, menuid={[1011] = true}, menu_function=menus_util.handle_titles_npc},
	["Debadle-Levadle"] = {zoneid={[256] = true}, menuid={[15] = true}, menu_function=menus_util.handle_titles_npc},

	-- ??? Odyssey
	["???"] = {zoneid={[247] = true}, menuid={[2001] = true}, menu_function=menus_util.handle_odyssey_questionmark},
}

return menus_util