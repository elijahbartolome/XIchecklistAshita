local mmm_util = {}
local map_mmm = require('../maps/maps_mmm')
local vouchers_unlocks = nil
local runes_unlocks = nil

function mmm_util.handle_mmm_data(data)
	mmm_util.vouchers_unlocks = data:sub(0x04+1, 0x0B+1)
	mmm_util.runes_unlocks = data:sub(0x0C+1, 0x4B+1)
end

function mmm_util.log_vouchers()
	if mmm_util.vouchers_unlocks==nil then return end
	local vouchers_list = {}
	local total, obtained = 0, 0
	for id, voucher in pairs(map_mmm['vouchers']) do
		total = total+1
		if util.has_bit(mmm_util.vouchers_unlocks, id) then
			obtained = obtained+1
			table.insert(vouchers_list, '\\cs(0,255,0) ' .. voucher ..'\\cr') -- add obtained MMM voucher
		else
			table.insert(vouchers_list, '\\cs(255,255,0) ' .. voucher ..'\\cr') -- add unobtained MMM voucher
		end
	end
	playertracker['mmmvouchers_completed'] = obtained
	playertracker['mmmvouchers_total'] = total
	return vouchers_list
end

function mmm_util.log_runes()
	if mmm_util.runes_unlocks==nil then return end
	local runes_list = {}
	local total, obtained = 0, 0
	for id, rune in pairs(map_mmm['runes']) do
		total = total+1
		if util.has_bit(mmm_util.runes_unlocks, id) then
			obtained = obtained+1
			table.insert(runes_list, '\\cs(0,255,0) ' .. rune ..'\\cr') -- add obtained MMM rune
		else
			table.insert(runes_list, '\\cs(255,255,0) ' .. rune ..'\\cr') -- add unobtained MMM rune
		end
	end
	playertracker['mmmrunes_completed'] = obtained
	playertracker['mmmrunes_total'] = total
	return runes_list
end

return mmm_util