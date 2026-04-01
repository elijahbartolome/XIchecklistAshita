local menus_util = {}
local opmaps = require('../maps/maps_outposts')

function menus_util.handle_npc_menu(data)
	parseddata = packets.parse('incoming', data)
	local index = parseddata['NPC Index']
	local npc = index and windower.ffxi.get_mob_by_index(index).name
	if not npc or not menus_util.menu_npcs[npc] then
		return
	end
	local zone_id = windower.ffxi.get_info().zone
	if ((menus_util.menu_npcs[npc].zoneid == windower.ffxi.get_info().zone) and (menus_util.menu_npcs[npc].menuid == parseddata['Menu ID'])) then
		menus_util.menu_npcs[npc]['menu_function'](data)
	end
end

function menus_util.handle_op_warps(data)
	parseddata = packets.parse('incoming', data)
	menu = parseddata['Menu Parameters']
	subdata = menu:sub(0x1C+1, 0x1E+1)
	for key, name in pairs(opmaps) do
		if (not util.has_bit(subdata, key+5)) then -- used+5 because mapping starts from 6th byte
			menus_util.add_outpost(key)
		end
	end
end

function menus_util.add_outpost(id)
	if (not (playertracker.outposts_unlocks[tostring(id)] == true)) then
		playertracker.outposts_unlocks[tostring(id)] = true
		playertracker:save()
		util.addon_log('Outpost added: ' .. opmaps[id])
	end
end

function menus_util.handle_chatnachoq(data)
	parseddata = packets.parse('incoming', data)
	menu = parseddata['Menu Parameters']
	local marbles = menu:unpack('I', 5)
	local mazes = menu:unpack('I', 13)
	playertracker['mmm_mazecount'] = mazes
	playertracker:save()
	--util.addon_log('Maze count: ' .. mazes)
end


menus_util.menu_npcs = {
	-- Outpost Warp NPCs
	['Conrad'] = {entityid=17735859, zoneid=234, menuid=584, menu_function=menus_util.handle_op_warps}, -- Bastok Mines
	['Jeanvirgaud'] = {entityid=17723597, zoneid=231, menuid=864, menu_function=menus_util.handle_op_warps}, -- Northern San d'Oria
	['Rottata'] = {entityid=17760439, zoneid=240, menuid=653, menu_function=menus_util.handle_op_warps}, -- Port Windurst
	-- MMM NPC
	['Chatnachoq'] = {entityid=17780943, zoneid=245, menuid=10095, menu_function=menus_util.handle_chatnachoq}, -- Lower Jeuno
}

return menus_util