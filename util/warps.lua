local warps_util = {}
local warps_data = nil
local maps = require('../maps/warps')
local zones = require('../maps/zones')

local warps_bytes = {
	homepoints = {0x08, 0x17},
	survivalguides = {0x18, 0x27},
	waypoints = {0x28 , 0x37},
	telepoints = {0x38, 0x3B},
	cavernousmaws = {0x3C, 0x3F},
	lycopodium = {0x3C, 0x3F},
	eschanportals = {0x40, 0x44},
	unknownwarps = {0x3C, 0x3F},
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
	local start = warps_bytes[warptype][1]
	local len = warps_bytes[warptype][2] - warps_bytes[warptype][1]
	local subdata = {}
	for i = 0, (len * 8) - 1 do
		subdata[i+1] = (ashita.bits.unpack_be(warps_util.warps_data, start, i, 1) == 1);
	end
	local total, complete = 0, 0
	output_list = {}
	-- check for obtained warp
	for index, name in pairs(maps[warptype]) do
		total = total+1
		local completion = false
		if util.has_bit(subdata, index+1) then
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

warps_util.log_visitedzones = function(e)
	local subdata = {}
	for i = 0, 375 do
		subdata[i+1] = (ashita.bits.unpack_be(e.data_raw, 0x04, i, 1) == 1);
	end
	local total, complete = 0, 0
	local zones_exclusion = {[0]=true, [131]=true} -- unknown and jail
	local output_list = {}
	for index, zone in pairs(zones) do
		total = total+1
		local completion = false
		if util.table_contains(zones_exclusion, zone.id) then total=total-1 end
		if util.has_bit(subdata, zone.id+1) and not util.table_contains(zones_exclusion, zone.id) then
			complete = complete+1
			completion = true
		end
		if not util.table_contains(zones_exclusion, zone.id) then
			--if zone.id == 227 or zone.id == 228 then
			--	zone.en = zone.en .. ' (Pirates)'
			--end
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
	local start = warps_bytes[warptype][1]
	local len = warps_bytes[warptype][2] - warps_bytes[warptype][1]
	local subdata = {}
	for i = 0, (len * 8) - 1 do
		subdata[i+1] = (ashita.bits.unpack_be(warps_util.warps_data, start, i, 1) == 1);
	end
	local total, complete = 0, 0
	local output_list = {}
	-- check for obtained warp
	for index, name in pairs(maps[warptype]) do
		total = total+1
		local completion = false
		if util.has_bit(subdata, index+1) then
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