local mmm_util = {}
local map_mmm = require('../maps/maps_mmm')
local vouchers_unlocks = nil
local runes_unlocks = nil

function mmm_util.handle_mmm_data(e)
	local VoucherUnlocksField = {}
	for i = 0,8 do
		VoucherUnlocksField[i] = (ashita.bits.unpack_be(e.data_raw, 0x04, i, 1) == 1);
	end
	mmm_util.vouchers_unlocks = VoucherUnlocksField
	local RuneUnlocksField = {}
	for i = 0,99 do
		RuneUnlocksField[i] = (ashita.bits.unpack_be(e.data_raw, 0x0C, i, 1) == 1);
	end
	mmm_util.runes_unlocks = RuneUnlocksField
end

function mmm_util.log_vouchers()
	if mmm_util.vouchers_unlocks==nil then return end
	local output_list = {}
	local total, obtained = 0, 0
	for id, voucher in pairs(map_mmm['vouchers']) do
		total = total+1
		local completion = false
		if util.has_bit(mmm_util.vouchers_unlocks, id) then
			obtained = obtained+1
			completion = true
		end
		table.insert(output_list, util.list_item(nil, voucher, completion))
	end
	playertracker['mmmvouchers_completed'] = obtained
	playertracker['mmmvouchers_total'] = total
	return output_list
end

function mmm_util.log_runes()
	if mmm_util.runes_unlocks==nil then return end
	local output_list = {}
	local total, obtained = 0, 0
	for id, rune in pairs(map_mmm['runes']) do
		total = total+1
		local completion = false
		if util.has_bit(mmm_util.runes_unlocks, id) then
			obtained = obtained+1
			completion = true
		end
		table.insert(output_list, util.list_item(nil, rune, completion))
	end
	playertracker['mmmrunes_completed'] = obtained
	playertracker['mmmrunes_total'] = total
	return output_list
end

return mmm_util