local roe_util = {}
local roemap = require('../maps/roe_objectives')
local roe_exclusions = require('../maps/roe_objectives_extra')
local roeids = {}

for k,v in pairs(roemap) do
	if not util.table_contains(util.Set(roe_exclusions.excluded), v.id) then table.insert(roeids ,k) end
end

table.sort(roeids)

roeids = util.Set(roeids)

function roe_util.handle_roe_data(roe_data)
	local roe_table = {}
	for id=1,4086 do
		if (util.has_bit(roe_data, id)) then
			roe_table[id] = true
		end
	end
	return roe_table
end

roe_util.log_roe = function(roe_data)
	local roe_table = roe_util.handle_roe_data(roe_data)
	local output_list = {}
	local total, complete = 0,0
	local hiddentotal, hiddencomplete = 0,0
	local hiddenmap = util.Set(roe_exclusions.hidden)
	if trackermenusettings.showexcluded then hiddenmap = {} end
	for key, _ in pairs(roeids)  do
		if roemap[key] ~= nil then
			total = total+1
			local completion = false
			if (hiddenmap[key]) then hiddentotal = hiddentotal+1 end
			if util.table_contains(roe_table, key+1)  then
				complete = complete+1
				completion = true
				if (hiddenmap[key]) then hiddencomplete = hiddencomplete+1 end
			end
			if (not util.table_contains(hiddenmap, key)) then
				table.insert(output_list, util.list_item(nil, roemap[key].name, completion))
			end
		end
	end
	-- do only crafting shields
	for guildmaster_request_tier, roelist in pairs(roe_exclusions.shields) do
		total = total+1
		local tiercomplete = 0
		local completion = false
		for roe_id, _ in pairs(util.Set(roelist)) do
			if util.table_contains(roe_table, roe_id+1) then
				tiercomplete = 1
				completion = true
			end
		end
		complete = complete + tiercomplete
		table.insert(output_list, util.list_item(nil, guildmaster_request_tier, completion))
	end
	playertracker.roe_completed = complete - hiddencomplete
	playertracker.roe_total = total - hiddentotal
	tab_logs.roe = {
		name = tab_logs.roe.name,
		completed = complete,
		total = total,
		items = output_list
	}
end

return roe_util