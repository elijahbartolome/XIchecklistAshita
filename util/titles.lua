local titles_util = {}
local npcmaps = require('../maps/titles_npcs')
local titlescontnt = require('../maps/titles_bycontent')
local titlesexclusions = require('../maps/titles_exclusions')
local titles_howtoobtain = require('../maps/titles_howtoobtain')

local totaltitles, obtainedtitles = 0, 0

function titles_util.handle_npc_menu(npc, flags)
	for cat, ids in ipairs(npcmaps[npc].menu) do
		local category = flags:unpack('I', 1 + (cat - 1) * 4)
		for flag, id in ipairs(ids) do
			if bit.band(category, bit.lshift(1, flag)) == 0 then
				titles_util.add_title(id)
			end
		end
	end
end

function titles_util.check_titles_npc(data)
	parseddata = packets.parse('incoming', data)
	local index = parseddata['NPC Index']
	local npc = index and windower.ffxi.get_mob_by_index(index).name
	if not npc or not npcmaps[npc] then
		return
	end
	titles_util.handle_npc_menu(npc, data:sub(81, 104))
end

function titles_util.add_title(id)
	if (not (playertitles[tostring(id)] == true)) then
		playertitles[tostring(id)] = true
		playertitles:save()
		util.addon_log('Title added: ' .. res.titles[id].en)
	end
end

function titles_util.log_titles()
	output_list = {}
	local total, complete = 0,0
	for key, title in pairs(res.titles) do
		total = total+1
		local completion = false
		local obtainmethod = ''
		if (titles_howtoobtain[title.en]) then
			obtainmethod = '\\cs(255,255,255) [' .. titles_howtoobtain[title.en] .. ']\\cr'
		end
		if (playertitles[tostring(key)] == true) then
			complete = complete+1
			completion = true
		else
			if (titlesexclusions:contains(key)) then
				total = total - 1
			end
		end
		if (not titlesexclusions:contains(key)) then  
			table.insert(output_list, util.list_item(nil, res.titles[key].en .. obtainmethod, completion))
		end
	end
	playertracker['Titles_completed'] = complete
	playertracker['Titles_total'] = total
	return output_list
end

function titles_util.list_titles_bycontent()
	output_list = {}
	for content, titles in pairs(titlescontnt) do
		local total, complete = 0,0
		local completion = false
		for key, titleid in pairs(titles) do
			total = total+1
			if (titlesexclusions:contains(titleid)) then total = total-1 end
			if (playertitles[tostring(titleid)] == true) then
				complete = complete+1
				if (titlesexclusions:contains(titleid)) then total = total+1 end
			end
		end
		local red = 0
		if (complete == total) then completion = true end
		table.insert(output_list, util.list_item(nil, '--' .. content ..' titles %d/%d':format(complete, total), completion))
	end
	return output_list
end

return titles_util