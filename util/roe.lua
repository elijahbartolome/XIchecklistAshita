local roe_util = {}
local roemap = require('../maps/roe_objectives')
local roeextramap = require('../maps/roe_objectives_extra')
local settings = require('settings')
require('util/util')

function roe_util.handle_roe_data(roe_data)
	for id, roe in pairs(roemap) do
		if (util.has_bit(roe_data, id)) then
			table.insert(playerroe, id)
		end
	end
end

function roe_util.log_roe()
	output_list = {}
	local total, complete = 0,0
	local hiddentotal, hiddencomplete = 0,0
	for key= 1,4086  do
		total = total+1
		local completion = false
		if (roeextramap[key]) then hiddentotal = hiddentotal+1 end
		if table_contains(playerroe, key)  then
			complete = complete+1
			completion = true
			if (roeextramap[key]) then hiddencomplete = hiddencomplete+1 end
		end
		if (not table_contains(roeextramap, key) and roemap[key] ~= nil) then
			table.insert(output_list, util.list_item(nil, roemap[key].name, completion))
		end
		
	end
	playertracker['RoE_completed'] = complete - hiddencomplete
	playertracker['RoE_total'] = total - hiddentotal
	return output_list
end

return roe_util