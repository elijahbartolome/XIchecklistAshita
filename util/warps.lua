local warps_util = {}
local warps_data = nil
local maps = require('../maps/warps')
local zones = require('../maps/zones')

local warps_bytes = {
	homepoints = {0x08+1, 0x17+1},
	survivalguides = {0x18+1, 0x27+1},
	waypoints = {0x28+1 , 0x37+1},
	telepoints = {0x38+1, 0x3B+1},
	cavernousmaws = {0x3C+1, 0x3F+1},
	lycopodium = {0x3C+1, 0x3F+1},
	eschanportals = {0x40+1, 0x44+1},
	unknownwarps = {0x3C+1, 0x3F+1},
}

function warps_util.checkwarps(warptype)
	if warps_util.warps_data == nil then return end
	local subdata = warps_util.warps_data:sub(warps[warptype].data[1], warps[warptype].data[2])
	local total, obtained = 0, 0
	output_list = {}
	-- check for obtained warp
	for index, name in pairs(warps[warptype].map) do
		total = total+1
		local completion = false
		if (util.has_bit(subdata, index+1)) then
			obtained = obtained+1
			completion = true
		end
		table.insert(output_list, util.list_item(warptype, name, completion))
	end
	tab_logs[warptype..'_completed'] = obtained
	tab_logs[warptype..'_total'] = total		
	return output_list
end

warps_util.log_warps = function(warptype)
	if warps_util.warps_data == nil then return end
	local subdata = warps_util.warps_data:sub(unpack(warps_bytes[warptype]))
	local total, complete = 0, 0
	output_list = {}
	-- check for obtained warp
	for index, name in pairs(maps[warptype]) do
		total = total+1
		local completion = false
		if util.has_bit(subdata, index) then
			complete = complete+1
			completion = true
		end
		table.insert(output_list, util.list_item(warptype, name, completion))
	end
	playertracker[warptype..'_completed'] = complete
	playertracker[warptype..'_total'] = total
	tab_logs[warptype] = {
		name = tab_logs[warptype].name,
		completed = complete,
		total = total,
		items = output_list
	}
end

warps_util.log_visitedzones = function(data)
	local subdata = data:sub(5, 52)
	local total, complete = 0, 0
	local zones_exclusion = {0, 131} -- unknown and jail
	local output_list = {}
	for index, zone in pairs(zones) do
		total = total+1
		local completion = false
		if util.table_contains(zones_exclusion, zone.id) then total=total-1 end
		if util.has_bit(subdata, zone.id) and not util.table_contains(zones_exclusion, zone.id) then
			complete = complete+1
			completion = true
		end
		if not util.table_contains(zones_exclusion, zone.id) then
			if zone.id == 227 or zone.id == 228 then
				zone.en = zone.en .. ' (Pirates)'
			end
			table.insert(output_list, util.list_item(nil, zone.en, completion))
		end
	end
	playertracker.zones_completed = complete
	playertracker.zones_total = total
	tab_logs.zones = {
		name = tab_logs.zones.name,
		completed = complete,
		total = total,
		items = output_list
	}
end

warps_util.log_unknownwarps = function(warptype) -- copy of log_warps, but avoiding counting this category in total checklist progress, until we figure out what they mean
	if warps_util.warps_data == nil then return end
	local subdata = warps_util.warps_data:sub(unpack(warps_bytes[warptype]))
	local total, complete = 0, 0
	local output_list = {}
	-- check for obtained warp
	for index, name in pairs(maps[warptype]) do
		total = total+1
		local completion = false
		if util.has_bit(subdata, index) then
			complete = complete+1
			completion = true
		end
		table.insert(output_list, util.list_item(warptype, name, completion))
	end
	playertracker.unknownwarps_unlocked = complete
	playertracker.unknownwarps_unlockable = total
	tab_logs[warptype] = {
		name = tab_logs[warptype].name,
		completed = complete,
		total = total,
		items = output_list
	}
	--return output_list
end

return warps_util