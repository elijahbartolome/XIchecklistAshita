local menus_util = {}
local menumaps = require('../maps/maps_menus')
local titlescontent = require('../maps/titles_bycontent')
local titlesexclusions = util.Set(require('../maps/titles_exclusions'))
local titles_howtoobtain = require('../maps/titles_howtoobtain')
local settings = require('settings')
local titles = require('../maps/titles')
local titleids = util.keyset(titles)
table.sort(titleids)
local zones = require('../maps/zones')

menu_current = {
	npcindex = nil,
	zoneid = nil,
	['Option Index'] = nil,
	['Secondary Option Index'] = nil,
	_unknown1 = nil,
	['Menu Parameters'] = nil,
}

menus_util.handle_npc_menu = function(e)
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
	if (util.table_contains(menus_util.menu_npcs[npc].zoneid, AshitaCore:GetMemoryManager():GetParty():GetMemberZone(0)) 
		and util.table_contains(menus_util.menu_npcs[npc].menuid, menuId)) then
		menus_util.menu_npcs[npc].menu_function(e) -- second parameter is data because 0x033 menu is bugged, until kayte's PR fixes it.
	end
end

menus_util.handle_npc_submenu = function(e)
	local index = (menu_current.npcindex and menu_current.zoneid==AshitaCore:GetMemoryManager():GetParty():GetMemberZone(0)) and menu_current.npcindex
	if (index == nil) then return false end
	local npc = index and AshitaCore:GetMemoryManager():GetEntity():GetName(index)
	if not npc or not menus_util.menu_npcs[npc] then
		return
	end
	if util.table_contains(menus_util.menu_npcs[npc].zoneid, AshitaCore:GetMemoryManager():GetParty():GetMemberZone(0)) then
		menus_util.menu_npcs[npc].menu_function(e)
	end
end

menus_util.reset_current_menu = function()
	menu_current = {
		npcindex = nil,
		zoneid = nil,
		['Option Index'] = nil,
		['Secondary Option Index'] = nil,
		_unknown1 = nil,
		['Menu Parameters'] = nil,
	}
end

menus_util.handle_menu_options = function(e)
	local TargetIndex = struct.unpack('H', e.data, 0x0C + 0x01)
	local Zone = struct.unpack('H', e.data, 0x10 + 0x01)
	local OptionIndex = struct.unpack('H', e.data, 0x08 + 0x01)
	local unknown1 = struct.unpack('H', e.data, 0x0A + 0x01)
	menu_current = {
		npcindex = TargetIndex,
		zoneid = Zone,
		['Option Index'] = OptionIndex,
		['Secondary Option Index'] = string.byte(e.data, 12),
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

menus_util.handle_op_warps = function(e)
	local menu = get_menu_parameters(e)
	local subdata = {}
	for i = 229, 255 do
		subdata[i-229] = menu[i]
	end
	for key, name in pairs(menumaps.outposts) do
		if (not util.has_bit(subdata, key+1)) then
			menus_util.add_outpost(key)
		end
	end
	playertracker.talk_to_npc.outpostnpc = true
	settings.save()
end

menus_util.add_outpost = function(id)
	if (not (playertracker.outposts_unlocks[tostring(id)] == true)) then
		playertracker.outposts_unlocks[tostring(id)] = true		
		util.addon_log('Outpost added: ' .. menumaps.outposts[id])
	end
end

menus_util.log_outposts = function()
	local output_list = {}
	local total, complete = 0,0
	for key, name in pairs(menumaps.outposts) do
		total = total+1
		local completion = false
		if (playertracker.outposts_unlocks[tostring(key)] == true) then
			complete = complete+1
			completion = true
		end
		table.insert(output_list, util.list_item(nil, name, completion, nil))
	end
	playertracker.outposts_completed = complete
	playertracker.outposts_total = total
	tab_logs.outposts = {
		name = tab_logs.outposts.name,
		completed = complete,
		total = total,
		items = output_list
	}
end

menus_util.handle_chatnachoq = function(e)
	local menu = get_menu_parameters(e)
	local mazes = struct.unpack('I', e.data, 21)
	playertracker.mmm_mazecount = mazes
	playertracker.talk_to_npc.chatnachoq = true
	settings.save()
	util.addon_log('Maze count: ' .. mazes)
	
end

menus_util.handle_protowaypoint = function(e)
	local menu = get_menu_parameters(e)
	for key, name in pairs(menumaps.protowaypoints) do
		if (util.has_bit(menu, key+1)) then
			menus_util.add_protowaypoint(key)
		end
	end
	playertracker.talk_to_npc.protowaypoint = true
	settings.save()
end

menus_util.add_protowaypoint = function(id)
	if (not (playertracker.protowaypoints_unlocks[tostring(id)] == true)) then
		playertracker.protowaypoints_unlocks[tostring(id)] = true	
		util.addon_log('Proto-Waypoint added: ' .. menumaps.protowaypoints[id])
	end
end

menus_util.log_protowaypoints = function()
	local output_list = {}
	local total, complete = 0,0
	for key, name in pairs(menumaps.protowaypoints) do
		total = total+1
		local completion = false
		if (playertracker.protowaypoints_unlocks[tostring(key)] == true) then
			complete = complete+1
			completion = true
		end
		table.insert(output_list, util.list_item(nil, name, completion, nil))
	end
	playertracker.protowaypoints_completed = complete
	playertracker.protowaypoints_total = total
	tab_logs.protowaypoints = {
		name = tab_logs.protowaypoints.name,
		completed = complete,
		total = total,
		items = output_list
	}
end

menus_util.handle_burrowsnpc = function(e)
	local menu = get_menu_parameters(e)
	local map_name = nil
	if ((menu_current['zoneid'] == 244 and menu_current['_unknown1'] == 1) -- Upper Jeuno / Sauromugue Menu
		or (menu_current['zoneid'] == 120 and menu_current['Option Index'] == 14)) then
		map_name = 'Sauromugue_Champaign'
		menus_util.handle_sauromugueburrowsmenu(map_name, menu)
		playertracker.talk_to_npc.meeble_sauromugue = true
		settings.save()
	elseif ((menu_current['zoneid'] == 244 and menu_current['_unknown1'] == 2) -- Upper Jeuno / Batallia Menu
			or (menu_current['zoneid'] == 105 and menu_current['Option Index'] == 14)) then
		map_name = 'Batallia_Downs'
		menus_util.handle_batalliaburrowsmenu(map_name, menu)
		playertracker.talk_to_npc.meeble_batallia = true
		settings.save()
	end
end

menus_util.handle_sauromugueburrowsmenu = function(map_name, menu_parameters)
	local burrowmap = menumaps.meeble_burrows[map_name]
	for id, name in pairs(burrowmap) do
		if util.has_bit(menu_parameters, id+1) then
			menus_util.add_meeble_burrows(id,map_name)
		end
	end
end

menus_util.handle_batalliaburrowsmenu = function(map_name, menu_parameters)
	local burrowmap = menumaps.meeble_burrows[map_name]
	local batallia_unlocks = util.twobits_to_table(menu_parameters)
	for id, name in pairs(burrowmap) do
		if batallia_unlocks[id] == 3 then
			menus_util.add_meeble_burrows(id,map_name)
		end
	end
end

menus_util.add_meeble_burrows = function(id,map_name)
	if (not (playertracker.meeble_completed[map_name][tostring(id)] == true)) then
		playertracker.meeble_completed[map_name][tostring(id)] = true
		settings.save()
		util.addon_log('Meeble Burrow added: ' .. menumaps.meeble_burrows[map_name][id])
	end
end

menus_util.log_meeble_burrows = function()
	local output_list = {}
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
	playertracker.meebleburrows_completed = complete
	playertracker.meebleburrows_total = total
	tab_logs.meebleburrows = {
		name = tab_logs.meebleburrows.name,
		completed = complete,
		total = total,
		items = output_list
	}
end

menus_util.handle_katsunaga = function(e)
	if menu_current['_unknown1'] == 0 then
		menu = get_menu_parameters(e)
		for flag, id in ipairs(menumaps.fishes_menu) do
			if (id ~= false) then
				if util.has_bit(menu, flag+1) then
					menus_util.add_fish_caught(id)
				end
			end
		end
		playertracker.talk_to_npc.katsunaga = true
		settings.save()
	end
end

menus_util.add_fish_caught = function(id)
	if (not (playertracker.fishes_caught[tostring(id)] == true)) then
		playertracker.fishes_caught[tostring(id)] = true
		util.addon_log('Fish added: ' .. AshitaCore:GetResourceManager():GetItemById(id).Name[2])
	end
end

menus_util.log_fishes = function()
	local output_list = {}
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
	playertracker.fishes_completed = complete
	tab_logs.fishes = {
		name = tab_logs.fishes.name,
		completed = complete,
		total = 164,
		items = output_list
	}
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

menus_util.handle_atmacitenpc = function(e)
	local menu = get_menu_parameters(e)
	local atmacite_levels = util.fourbits_to_table(menu)
	local playerkeyitems = get_key_items()
	if (menu_current['_unknown1'] == 0 and menu_current['Option Index'] == 2) then
		for key, atmacite in pairs(menumaps.atmacite) do
			if (util.table_contains(playerkeyitems, atmacite.id)) then
				if (playertracker.atmacite_levels[tostring(key)] == nil) then
					util.addon_log('Atmacite added: Lv'..atmacite_levels[key].. ' ' .. atmacite.en)
				elseif (atmacite_levels[key] > playertracker.atmacite_levels[tostring(key)]) then
					util.addon_log('Atmacite Updated: Lv'..atmacite_levels[key].. ' ' .. atmacite.en)
				end
				playertracker.atmacite_levels[tostring(key)] = atmacite_levels[key]
			end
		end
		playertracker.talk_to_npc.atmacite_refiner = true
		settings.save()
	end
end

menus_util.log_atmacitelevels = function()
	local output_list = {}
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
	playertracker.atmacite_completed = complete
	tab_logs.atmacite = {
		name = tab_logs.atmacite.name,
		completed = complete,
		total = 600,
		items = output_list
	}
	return output_list
end

menus_util.handle_chocobostablenpc = function(e)
	menu = get_menu_parameters(e)
	if (menu ~= nil) then
		local winglevel = ashita.bits.unpack_be(e.data_raw, 0x08 + 4, 0, 8)
		if (winglevel > playertracker['wingskill_completed']) then
			playertracker.wingskill_completed = winglevel
			playertracker.talk_to_npc.chocobokid = true
			settings.save()
			util.addon_log('Wing Skill updated: '..winglevel)
		end
	end
end

menus_util.handle_titles_npc = function(e)
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
	settings.save()
end

menus_util.add_title = function(id, defer_save)
	if (not (playertracker.titles[tostring(id)] == true)) then
		playertracker.titles[tostring(id)] = true
		util.addon_log('Title added: ' .. titles[id].en)
		if not defer_save then
			settings.save()
		end
	end
end

menus_util.log_titles = function()
	local output_list = {}
	local total, complete = 0,0
	local exclusions = titlesexclusions
	if (trackermenusettings.showexcluded) then exclusions = {} end
	for _, id in ipairs(titleids) do
		total = total+1
		local completion = false
		local obtainmethod = ''
		if (titles_howtoobtain[titles[id].en]) then
			obtainmethod = titles_howtoobtain[titles[id].en]
		end
		if (playertracker.titles[tostring(id)] == true) then
			complete = complete+1
			completion = true
		else
			if (util.table_contains(exclusions, id)) then
				total = total - 1
			end
		end
		if (not util.table_contains(exclusions, id)) then  
			table.insert(output_list, util.list_item('Titles', titles[id].en, completion, obtainmethod))
		end
	end
	playertracker.Titles_completed = complete
	playertracker.Titles_total = total
	tab_logs.titles = {
		name = tab_logs.titles.name,
		completed = complete,
		total = total,
		items = output_list
	}
end

menus_util.list_titles_bycontent = function()
	local output_list = {}
	for content, titlesincontent in pairs(titlescontent) do
		local total, complete = 0,0
		local completion = false
		for titleid, _ in pairs(util.Set(titlesincontent)) do
			total = total+1
			if util.table_contains(titlesexclusions, titleid) then total = total-1 end
			if (playertracker.titles[tostring(titleid)] == true) then
				complete = complete+1
				if (util.table_contains(titlesexclusions, titleid)) then total = total+1 end
			end
		end
		if (complete == total) then completion = true end
		table.insert(output_list, util.list_item(nil, '--' .. content ..(' titles %d/%d'):format(complete, total), completion, nil))
	end
	tab_logs.titles_by_content = {
		name = tab_logs.titles_by_content.name,
		completed = tab_logs.titles.completed,
		total = tab_logs.titles.total,
		items = output_list
	}
end

menus_util.list_titles_bycontent_detailed = function()
	local output_list = {}
	for content, titlesincontent in pairs(titlescontent) do
		table.insert(output_list, util.list_item(nil, '==== ' .. content ..' ====', false))
		for titleid, _ in pairs(util.Set(titlesincontent)) do
			local completion = false
			if (playertracker.titles[tostring(titleid)] == true) then
				completion = true
			end
			if (titles_howtoobtain[titles[titleid].en]) then
				obtainmethod = titles_howtoobtain[titles[titleid].en]
			end
			table.insert(output_list, util.list_item(nil, titles[titleid].en, completion, obtainmethod))
		end
	end
	tab_logs.titles_by_content_detailed = {
		name = tab_logs.titles_by_content_detailed.name,
		completed = tab_logs.titles.completed,
		total = tab_logs.titles.total,
		items = output_list
	}
end

menus_util.handle_odyssey_questionmark = function(e)
	local need_save = false
	local menu = get_menu_parameters(e)
	local menu_data = util.byte_to_table_reverse(menu)
	if (menu_current['Option Index'] == 2 or menu_current['Option Index'] == 4 or menu_current['Option Index'] == 5 or menu_current['Option Index'] == 7) then 
		-- SheolABC
		local nostos = 0
		for byteidx, entry in pairs(menumaps.odyssey.sheolabc[menu_current['Option Index']]) do
			byteidx = tonumber(byteidx)
			if (byteidx) then -- if its a number, aka not nostos or talk_to_npc
				local data = menu_data[byteidx]
				playertracker.sheolabc[tostring(menu_current['Option Index'])][tostring(byteidx)] = data
				need_save = true
			end
		end
		if menumaps.odyssey.sheolabc[menu_current['Option Index']].nostos then
			local subdata = {}
			local nostos_data = menumaps.odyssey.sheolabc[menu_current['Option Index']].nostos.data
			for i = (nostos_data*8)-7, (nostos_data*8)+8 do
				subdata[i-(nostos_data*8-7)] = menu[i]
			end
			nostos = util.sixteenbits(subdata)
			playertracker.sheolabc[tostring(menu_current['Option Index'])].nostos = nostos
			need_save = true
		end
		if menumaps.odyssey.sheolabc[menu_current['Option Index']].talk_to_npc then
			playertracker.talk_to_npc[menumaps.odyssey.sheolabc[menu_current['Option Index']].talk_to_npc] = true
			need_save = true
		end
	elseif (menu_current['Option Index'] == 8 or menu_current['Option Index'] == 9 or menu_current['Option Index'] == 10) then -- Choose Sheo Gaol status report
		-- Sheol Gaol
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
		playertracker.talk_to_npc.sheolgaol = true
		need_save = true
	end
	if need_save then
		settings.save()
	end
end

menus_util.log_sheolgaol = function()
	local output_list = {}
	local total, complete = 0,0
	for optionidx, optiontbl in pairs(menumaps.odyssey.gaol) do
		for byteidx, name in pairs (optiontbl) do
			local venglevel = playertracker.sheolgaol[tostring(optionidx)][tostring(byteidx)] or 0
			local completion = false
			if venglevel == 25 then completion = true end
			table.insert(output_list, util.list_item(nil, 'V'..venglevel..' '..name, completion))
			complete = complete+venglevel
		end
	end
	playertracker.sheolgaoltiers_completed = complete
	tab_logs.sheolgaol = {
		name = tab_logs.sheolgaol.name,
		completed = complete,
		total = 425,
		items = output_list
	}
	return output_list
end

menus_util.log_sheolabc = function(sheol)
	local output_list = {}
	local total, complete = 0,0
	local map_optionindex = 0
	if sheol == 'sheola' then map_optionindex = {2}
	elseif sheol == 'sheolb' then map_optionindex = {4,5}
	elseif sheol == 'sheolc' then map_optionindex = {7}
	end
	for _, optionindex in pairs(map_optionindex) do
		for byteidx, entry in pairs(menumaps.odyssey.sheolabc[optionindex]) do
			local completion = false
			if byteidx ~= 'talk_to_npc' then
				total = total+1
				if (playertracker.sheolabc[tostring(optionindex)][tostring(byteidx)]) then
					if playertracker.sheolabc[tostring(optionindex)][tostring(byteidx)] >= entry.goal then
						completion = true
						complete = complete+1
					end
				end
				table.insert(output_list, util.list_item(nil, (playertracker.sheolabc[tostring(optionindex)][tostring(byteidx)] or 0)..'/'..entry.goal..' '..entry.name, completion))
			end
		end
	end
	playertracker[sheol..'_completed'] = complete
	playertracker[sheol..'_total'] = total
	tab_logs[sheol] = {
		name = tab_logs[sheol].name,
		completed = complete,
		total = total,
		items = output_list
	}
end

menus_util.handle_vorseals_npc = function(e)
	local menu = get_menu_parameters(e)
	local nibble_table = util.fourbits_to_table(menu)
	local menuId
	if (e.id == 0x033) then
		menuId = struct.unpack('H', e.data, 0x0C + 0x01)
	elseif (e.id == 0x034) then
		menuId = struct.unpack('H', e.data, 0x2C + 0x01)
	end
	if (menuId == 9701) then -- initial interaction with NPC, no Option Index
		for nibble, vorseal in pairs(menumaps.vorseals) do
			if (playertracker.vorseals[tostring(nibble)] == nil) then
				util.addon_log('Vorseal added: ['..nibble_table[nibble]..'/'..vorseal.goal..'] '..vorseal.name)
			elseif (nibble_table[nibble] > playertracker.vorseals[tostring(nibble)]) then
				util.addon_log('Vorseal updated: ['..nibble_table[nibble]..'/'..vorseal.goal..'] '..vorseal.name)
			end
			playertracker.vorseals[tostring(nibble)] = nibble_table[nibble]
		end
	end
	playertracker.talk_to_npc.vorseals = true
	settings.save()
end

menus_util.log_vorseals = function()
	local output_list = {}
	local total, complete = 0,0
	for nibble, vorseal in pairs(menumaps.vorseals) do
		local completion = false
		total = total+vorseal.goal
		if (playertracker.vorseals[tostring(nibble)]) then
			complete = complete+playertracker.vorseals[tostring(nibble)]
			if playertracker.vorseals[tostring(nibble)] == vorseal.goal then
				completion = true
			end
		end
		table.insert(output_list, util.list_item(nil, (playertracker.vorseals[tostring(nibble)] or 0)..'/'..vorseal.goal..' '..vorseal.name, completion))
	end
	playertracker.vorseals_completed = complete
	playertracker.vorseals_total = total
	tab_logs.vorseals = {
		name = tab_logs.vorseals.name,
		completed = complete,
		total = total,
		items = output_list
	}
end

menus_util.handle_rienne = function(e)
	local menu = get_menu_parameters(e)
	local nibble_table = util.fourbits_to_table(menu)
	local subdata = {}
	for i = 128, 160 do
		subdata[i-128] = menu[i]
		print(subdata[i-128])
	end
	for idx, ergonlocus in pairs(menumaps.ergonlocus) do
		if util.has_bit(subdata, idx+1) and not playertracker.ergonlocus[tostring(idx)] then
			util.addon_log('Ergon Locus added: '..ergonlocus)
			playertracker.ergonlocus[tostring(idx)] = true
		end
	end
	playertracker.talk_to_npc.ergonlocus = true
	settings.save()
end

menus_util.log_ergonlocus = function()
	local output_list = {}
	local total, complete = 0,0
	for id, ergonlocus in pairs(menumaps.ergonlocus) do
		total = total+1
		local completion = false
		if playertracker.ergonlocus[tostring(id)] == true then
			complete = complete+1
			completion = true
		end
		table.insert(output_list, util.list_item(nil, ergonlocus, completion))
	end
	playertracker.ergonlocus_completed = complete
	playertracker.ergonlocus_total = total
	tab_logs.ergonlocus = {
		name = tab_logs.ergonlocus.name,
		completed = complete,
		total = total,
		items = output_list
	}
end

menus_util.handle_emporox = function(e)
	if e.id ~= 52 then return end
	local menu = get_menu_parameters(e)
	for key, name in pairs(menumaps.emporox) do
		if (util.has_bit(menu, key+1)) then
			menus_util.add_emporox(key)
		end
	end
	playertracker.talk_to_npc.emporox = true
	settings.save()
end

menus_util.add_emporox = function(id)
	if (not (playertracker.emporox_unlocks[tostring(id)] == true)) then
		playertracker.emporox_unlocks[tostring(id)] = true
		util.addon_log('Emporox added: ' .. menumaps.emporox[id])
	end
end

menus_util.log_emporox = function()
	local output_list = {}
	local total, complete = 0,0
	for key, name in pairs(menumaps.emporox) do
		total = total+1
		local completion = false
		if (playertracker.emporox_unlocks[tostring(key)] == true) then
			complete = complete+1
			completion = true
		end
		table.insert(output_list, util.list_item(nil, name, completion))
	end
	playertracker.emporox_completed = complete
	playertracker.emporox_total = total
	tab_logs.emporox = {
		name = tab_logs.emporox.name,
		completed = complete,
		total = total,
		items = output_list
	}
end

menus_util.handle_abyssea_conflux = function(e)
	if e.id ~= 52 then return end
	local zoneid = AshitaCore:GetMemoryManager():GetParty():GetMemberZone(0)
	local menu = get_menu_parameters(e)
	for bit_index, conflux in pairs(menumaps.abysseaconflux_unlocks[zoneid]) do
		if util.has_bit(menu, bit_index+1) and not playertracker.abysseaconflux_unlocks[tostring(zoneid)][tostring(bit_index)] then
			playertracker.abysseaconflux_unlocks[tostring(zoneid)][tostring(bit_index)] = true
			util.addon_log(conflux..' Unlocked')
		end
	end
	playertracker.talk_to_npc['veridicalconflux_'..zoneid] = true
	settings.save()
end

menus_util.log_abyssea_conflux = function()
	local output_list = {}
	local total, complete = 0,0
	for zoneid, tbl in pairs(menumaps.abysseaconflux_unlocks) do
		table.insert(output_list, util.list_item(nil, '==== ' .. zones[zoneid].en ..' ====', false))
		for bit_index, conflux in pairs(tbl) do
			total = total+1
			local completion = false
			if (playertracker.abysseaconflux_unlocks[tostring(zoneid)][tostring(bit_index)] == true) then
				complete = complete+1
				completion = true
			end
			table.insert(output_list, util.list_item(nil, conflux, completion))
		end
	end
	playertracker.abysseaconflux_completed = complete
	--playertracker.abysseaconflux_total = total
	tab_logs.abysseaconflux = {
		name = tab_logs.abysseaconflux.name,
		completed = complete,
		total = 75,
		items = output_list
	}
end

menus_util.menu_npcs = {
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
	
	-- Vorseals
	["Shiftrix"] = {zoneid={[291] = true}, menuid={[9701] = true}, menu_function=menus_util.handle_vorseals_npc},
	
	-- Ergon Locus
	["Rienne"] = {zoneid={[256] = true}, menuid={[7543] = true}, menu_function=menus_util.handle_rienne},
	
	-- Emporox
	["Emporox"] = {zoneid={[291] = true}, menuid={[9751] = true}, menu_function=menus_util.handle_emporox},
	
	-- Abyssea Veridical Conflux
	["Veridical Conflux #01"] = {
	zoneid={[15]=true, [45]=true, [132]=true, [215]=true, [216]=true, [217]=true, [218]=true, [253]=true, [254]=true},
	menuid={[2132] = true}, menu_function=menus_util.handle_abyssea_conflux},
}
return menus_util