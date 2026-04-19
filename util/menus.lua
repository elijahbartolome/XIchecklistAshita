local menus_util = {}
local menumaps = require('../maps/maps_menus')
local titlescontnt = require('../maps/titles_bycontent')
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
    for _, value in pairs(tbl) do
        if value == x then return true end
    end
    return false
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
	if not npc or not menus_util.menu_npcs[npc] then
		return
	end
	if (table_contains(menus_util.menu_npcs[npc].zoneid, AshitaCore:GetMemoryManager():GetParty():GetMemberZone(0)) 
		and table_contains(menus_util.menu_npcs[npc].menuid, menuId)) then
		menus_util.menu_npcs[npc]['menu_function'](e)
	end
end

function menus_util.handle_npc_submenu(e)
	local index = (menu_current.npcindex and menu_current.zoneid==AshitaCore:GetMemoryManager():GetParty():GetMemberZone(0)) and menu_current.npcindex
	if (index == nil) then return false end
	local npc = index and AshitaCore:GetMemoryManager():GetEntity():GetName(index)
	if not npc or not menus_util.menu_npcs[npc] then
		return
	end
	if table_contains(menus_util.menu_npcs[npc].zoneid, AshitaCore:GetMemoryManager():GetParty():GetMemberZone(0)) then
		menus_util.menu_npcs[npc]['menu_function'](e)
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
			MenuParameters[i] = (ashita.bits.unpack_be(e.data_raw, 0x50, i, 1) == 1);
		end
		return MenuParameters
	elseif (e.id == 0x034) then
		local MenuParameters = {}
		for i = 0,255 do
			MenuParameters[i] = (ashita.bits.unpack_be(e.data_raw, 0x08, i, 1) == 1);
		end
		return MenuParameters
	elseif (e.id == 0x05C) then
		local MenuParameters = {}
		for i = 0,255 do
			MenuParameters[i] = (ashita.bits.unpack_be(e.data_raw, 0x04, i, 1) == 1);
		end
		return MenuParameters
	end
end

function menus_util.handle_op_warps(e)
	menu = get_menu_parameters(e)
	subdata = menu:sub(0x1C+1, 0x1E+1)
	for key, name in pairs(menumaps.outposts) do
		if (not util.has_bit(subdata, key+5)) then -- +5 because mapping starts from 6th byte
			menus_util.add_outpost(key)
		end
	end
	playertracker.talk_to_npc['outpostnpc'] = true
	
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
	return output_list
end

function menus_util.handle_chatnachoq(e)
	menu = get_menu_parameters(e)
	local mazes = menu:unpack('I', 13)
	playertracker['mmm_mazecount'] = mazes
	
	util.addon_log('Maze count: ' .. mazes)
	playertracker.talk_to_npc['chatnachoq'] = true
	
end

function menus_util.handle_protowaypoint(e)
	menu = get_menu_parameters(e)
	--subdata = menu:sub(0x1C+1, 0x1E+1)
	for key, name in pairs(menumaps.protowaypoints) do
		if (util.has_bit(menu, key)) then
			menus_util.add_protowaypoint(key)
		end
	end
	playertracker.talk_to_npc['protowaypoint'] = true
	
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
	return output_list
end

function menus_util.handle_burrowsnpc(e)
	menu = get_menu_parameters(e)
	local map_name = nil
	if ((menu_current['zoneid'] == 244 and menu_current['_unknown1'] == 1) -- Upper Jeuno / Sauromugue Menu
		or (menu_current['zoneid'] == 120 and menu_current['Option Index'] == 14)) then
		map_name = 'Sauromugue_Champaign'
		menus_util.handle_sauromugueburrowsmenu(map_name, menu)
		playertracker.talk_to_npc['meeble_sauromugue'] = true
		
	elseif ((menu_current['zoneid'] == 244 and menu_current['_unknown1'] == 2) -- Upper Jeuno / Batallia Menu
			or (menu_current['zoneid'] == 105 and menu_current['Option Index'] == 14)) then
		map_name = 'Batallia_Downs'
		menus_util.handle_batalliaburrowsmenu(map_name, menu)
		playertracker.talk_to_npc['meeble_batallia'] = true
		
	end
end

function menus_util.handle_sauromugueburrowsmenu(map_name, menu_parameters)
	local burrowmap = menumaps.meeble_burrows[map_name]
	for id, name in pairs(burrowmap) do
		if util.has_bit(menu_parameters, id) then
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
	return output_list
end

function menus_util.handle_katsunaga(e)
	if menu_current['_unknown1'] == 0 then
		menu = get_menu_parameters(e)
		for flag, id in ipairs(menumaps.fishes_menu) do
			if (id ~= false) then
				if util.has_bit(menu, flag) then
					menus_util.add_fish_caught(id)
				end
			end
		end
		playertracker.talk_to_npc['katsunaga'] = true
		
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
	return output_list
end

function get_key_items()
	local playMgr = AshitaCore:GetMemoryManager():GetPlayer();
	local player_KI = {}
    for i = 1,3583 do
        if playMgr:HasKeyItem(i) then
			table.insert(player_KI, i)
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
			if (table.find(playerkeyitems, atmacite.id)) then
				if (playertracker.atmacite_levels[tostring(key)] == nil) then
					playertracker.atmacite_levels[tostring(key)] = atmacite_levels[key]
					
					util.addon_log('Atmacite added: Lv'..atmacite_levels[key].. ' ' .. atmacite.en)
				elseif (atmacite_levels[key] > playertracker.atmacite_levels[tostring(key)]) then
					playertracker.atmacite_levels[tostring(key)] = atmacite_levels[key]
					
					util.addon_log('Atmacite Updated: Lv'..atmacite_levels[key].. ' ' .. atmacite.en)
				end
			end
		end
		playertracker.talk_to_npc['atmacite_refiner'] = true
		
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
	return output_list
end

function menus_util.handle_chocobostablenpc(e)
	menu = get_menu_parameters(e)
	if (menu ~= nil) then
		local winglevel = string.byte(menu, 5)
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
	
end

function menus_util.add_title(id)
	local titles = require('maps/titles')
	if (not (playertitles[id] == true)) then
		playertitles[id] = true
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
				obtainmethod = '\\cs(255,255,255) [' .. titles_howtoobtain[titles[key].en] .. ']\\cr'
			end
			if (playertitles[key] == true) then
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
	return output_list
end

function menus_util.list_titles_bycontent()
	output_list = {}
	for content, titles in pairs(titlescontnt) do
		local total, complete = 0,0
		local completion = false
		for key, titleid in ipairs(titles) do
			total = total+1
			if (titlesexclusions[titleid] ~= nil) then total = total-1 end
			if (playertitles[tostring(titleid)] == true) then
				complete = complete+1
				if (table_contains(titlesexclusions, titleid)) then total = total+1 end
			end
		end
		local red = 0
		if (complete == total) then completion = true end
		table.insert(output_list, util.list_item(nil, '--' .. content ..(' titles %d/%d'):format(complete, total), completion, nil))
	end
	return output_list
end


menus_util.menu_npcs = {
	-- Outpost Warp NPCs
	['Conrad'] = {zoneid={234}, menuid={584,581}, menu_function=menus_util.handle_op_warps},
	['Jeanvirgaud'] = {zoneid={231}, menuid={716,864}, menu_function=menus_util.handle_op_warps},
	['Rottata'] = {zoneid={240}, menuid={653,552}, menu_function=menus_util.handle_op_warps},
	-- MMM NPC
	['Chatnachoq'] = {zoneid={245}, menuid={10095}, menu_function=menus_util.handle_chatnachoq},
	-- Proto-Waypoint NPCs
	['Proto-Waypoint'] = {zoneid={243,248,249,247,252}, menuid={10209,10012,345,141,266}, menu_function=menus_util.handle_protowaypoint},
	
	-- Meenle Burrow
	['Burrow Investigator'] = {zoneid={244}, menuid={5500}, menu_function=menus_util.handle_burrowsnpc},
	['Burrow Researcher'] = {zoneid={120,105}, menuid={5500}, menu_function=menus_util.handle_burrowsnpc},
	
	-- Fishing NPC
	['Katsunaga'] = {zoneid={249}, menuid={197}, menu_function=menus_util.handle_katsunaga},
	
	-- Atmacite Refiner
	['Atmacite Refiner'] = {
	zoneid={26,51,80,84,87,91,94,98,105,110,120,126,230,235,238,247,250,252}, 
	menuid={6,7,8,15,16,24,25,46,49,79,264,627,657,962,1023}, 
	menu_function=menus_util.handle_atmacitenpc},
	
	-- Chocobo NPC
	['Arvilauge'] = {zoneid={230}, menuid={846}, menu_function=menus_util.handle_chocobostablenpc},
	['Gonija'] = {zoneid={234}, menuid={534}, menu_function=menus_util.handle_chocobostablenpc},
	['Kiria-Romaria'] = {zoneid={241}, menuid={761}, menu_function=menus_util.handle_chocobostablenpc},
	
	-- Title Changer NPCs
	["Aligi-Kufongi"] = {zoneid={26}, menuid={342}, menu_function=menus_util.handle_titles_npc},
	["Koyol-Futenol"] = {zoneid={50}, menuid={644}, menu_function=menus_util.handle_titles_npc},
	["Tamba-Namba"] = {zoneid={80}, menuid={306}, menu_function=menus_util.handle_titles_npc},
	["Bhio Fehriata"] = {zoneid={87}, menuid={167}, menu_function=menus_util.handle_titles_npc},
	["Cattah Pamjah"] = {zoneid={94}, menuid={138}, menu_function=menus_util.handle_titles_npc},
	["Moozo-Koozo"] = {zoneid={230}, menuid={675}, menu_function=menus_util.handle_titles_npc},
	["Styi Palneh"] = {zoneid={236}, menuid={200}, menu_function=menus_util.handle_titles_npc},
	["Burute-Sorute"] = {zoneid={239}, menuid={10004}, menu_function=menus_util.handle_titles_npc},
	["Tuh Almobankha"] = {zoneid={245}, menuid={10014}, menu_function=menus_util.handle_titles_npc},
	["Zuah Lepahnyu"] = {zoneid={246}, menuid={330}, menu_function=menus_util.handle_titles_npc},
	["Shupah Mujuuk"] = {zoneid={247}, menuid={1011}, menu_function=menus_util.handle_titles_npc},
	["Yulon-Polon"] = {zoneid={248}, menuid={10001}, menu_function=menus_util.handle_titles_npc},
	["Willah Maratahya"] = {zoneid={249}, menuid={10001}, menu_function=menus_util.handle_titles_npc},
	["Eron-Tomaron"] = {zoneid={250}, menuid={10013}, menu_function=menus_util.handle_titles_npc},
	["Quntsu-Nointsu"] = {zoneid={252}, menuid={1011}, menu_function=menus_util.handle_titles_npc},
	["Debadle-Levadle"] = {zoneid={256}, menuid={15}, menu_function=menus_util.handle_titles_npc},
}

return menus_util