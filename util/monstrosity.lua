local mons_util = {}
local maps = require('../maps/monstrosity')
mons_util.monster_levelspacket = {
	[1] = nil,
	[2] = nil,
}
local monster_levels = nil
local racejobinstincts = nil
local variants_bitfield = nil
local monster_instincts = nil

mons_util.log_racejobinstincts = function()
	if mons_util.racejobinstincts==nil then return end
	local output_list = {}
	local total, obtained = 0, 0
	for id, name in pairs(maps.racejobinstincts) do
		total = total+1
		local completion = false
		if util.has_bit(mons_util.racejobinstincts, id+1) then
			obtained = obtained+1
			completion = true
		end
		table.insert(output_list, util.list_item(nil, name, completion))
	end
	playertracker.racejobinstinct_completed = obtained
	playertracker.racejobinstinct_total = total
	tab_logs.racejobinstincts = {
		name = tab_logs.racejobinstincts.name,
		completed = obtained,
		total = total,
		items = output_list
	}
	--return output_list
end

mons_util.log_monsterlevels = function()
	if (mons_util.monster_levelspacket[1] == nil or mons_util.monster_levelspacket[2] == nil) then 
		return
	else 
		mons_util.monsterlevels = util.table_concat(mons_util.monster_levelspacket[1], mons_util.monster_levelspacket[2])
	end
	if mons_util.monsterlevels==nil then return end
	local monster_level_bytes = util.byte_to_table_reverse(mons_util.monsterlevels)
	local output_list = {}
	local total, complete = 0, 0
	for id, monster in pairs(maps.species) do
		total = total+1
		local completion = false
		local monster_level = 0
		if (id ~= 254 and id ~= 255) then
			monster_level = monster_level_bytes[id+1]
		elseif (id == 254) then
			monster_level = monster_level_bytes[129]
		elseif (id == 255) then
			monster_level = monster_level_bytes[130]
		end
		complete = complete + math.floor(monster_level/99)
		if (monster_level == 99) then completion = true end
		table.insert(output_list, util.list_item(nil, 'Lv. ' .. monster_level .. ' ' .. monster, completion)) -- add monster
	end
	playertracker.monsterlevels_completed = complete
	playertracker.monsterlevels_total = total
	tab_logs.monsterlevels = {
		name = tab_logs.monsterlevels.name,
		completed = complete,
		total = total,
		items = output_list
	}
	--return output_list
end

mons_util.log_variants = function()
	if mons_util.variants_bitfield==nil then return end
	local output_list = {}
	local total, obtained = 0, 0
	for id, name in pairs(maps.species_variants) do
		total = total+1
		local completion = false
		if util.has_bit(mons_util.variants_bitfield, (id-256)) then
			obtained = obtained+1
			completion = true
		end
		table.insert(output_list, util.list_item(nil, name, completion))
	end
	playertracker.monstervariants_completed = obtained
	playertracker.monstervariants_total = total
	tab_logs.monstervariants = {
		name = tab_logs.monstervariants.name,
		completed = obtained,
		total = total,
		items = output_list
	}
	--return output_list
end

mons_util.log_monsterinstincts = function()
	if mons_util.monsterinstincts==nil then return end
	local output_list = {}
	--local instincts_unlocks = util.twobits_to_table(mons_util.monsterinstincts)
	local total, obtained = 0, 0
	for table_id, unlocked_level in pairs(mons_util.monsterinstincts) do
		--total = total+3
		local instinct_index_base = 3 * (table_id)
		for instinct_index=1, 3 do
			local completion = false
			if (maps.monsterinstincts[instinct_index_base+instinct_index]) then
				total = total+1
				if (unlocked_level >= instinct_index) then
					obtained = obtained+1
					completion = true
				end
				table.insert(output_list, util.list_item(nil, maps.monsterinstincts[instinct_index_base+instinct_index], completion))
			end
		end
	end
	playertracker.monsterinsincts_completed = obtained
	playertracker.monsterinsincts_total = total
	tab_logs.monsterinstincts = {
		name = tab_logs.monsterinstincts.name,
		completed = obtained,
		total = total,
		items = output_list
	}
	--return output_list
end

return mons_util