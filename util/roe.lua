local roe_util = {}
local roemap = require('../maps/roe_objectives')
local roeextramap = require('../maps/roe_objectives_extra')

function roe_util.handle_roe_data(data)
	for id, roe in pairs(roemap) do
		if (util.has_bit(roe_data, id)) then
			--windower.add_to_chat(100, '' .. roemap[id].name)
			roe_util.add_roe(id)
		end
	end
end

function roe_util.add_roe(id)
	if (not (playerroe[tostring(id)] == true)) then
		playerroe[tostring(id)] = true
		playerroe:save()
		--util.addon_log('RoE Completed: ' .. roemap[id].name)
	end
end

function roe_util.log_roe()
	roe_list = {}
	local total, complete = 0,0
	local hiddentotal, hiddencomplete = 0,0
	for key, roe in pairs(roemap) do
		total = total+1
		if (roeextramap[key]) then hiddentotal = hiddentotal+1 end
		if (playerroe[tostring(key)] == true) then
			complete = complete+1
			if (roeextramap[key]) then hiddencomplete = hiddencomplete+1 end
			--table.insert(roe_list, '\\cs(0,255,0) ' .. roemap[key].name ..'\\cr') -- add completed RoE
		else
			if (not roeextramap:contains(key)) then
				table.insert(roe_list, '\\cs(255,255,0) ' .. roemap[key].name ..'\\cr') -- add missing RoE
			end
		end
	end
	playertracker['RoE_completed'] = complete - hiddencomplete
	playertracker['RoE_total'] = total - hiddentotal
	return roe_list
end

return roe_util