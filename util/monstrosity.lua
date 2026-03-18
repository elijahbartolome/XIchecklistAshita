local mons_util = {}


local map_species = require('../maps/monstrosity_species')
local map_species_variants = require('../maps/monstrosity_species_variants')
local map_racejobinstincts = require('../maps/monstrosity_racejobinstincts')
local monster_levels = {}
local racejobinstincts = {}
local variants_bitfield = nil

local totalspecies, obtainedspecies = 0, 0
local totalracejobinstincts, obtainedracejobinstincts = 0, 0


function mons_util.char_field_to_table(str)
    local t = {}

    for i = 1, #str do
        t[i - 1] = str:byte(i)
    end

    return t
end

function mons_util.has_bit(data, position)
    return data:unpack('q', math.floor(position/8)+1, position%8+1)
end

function mons_util.log_racejobinstincts()
	if mons_util.racejobinstincts==nil then return end
	local racejobinstincts_list = {}
	local total, obtained = 0, 0
	for id, instinctname in pairs(map_racejobinstincts) do
		total = total+1
		if mons_util.has_bit(mons_util.racejobinstincts, id) then
			obtained = obtained+1
			--table.insert(racejobinstincts_list, '\\cs(0,255,0) ' .. instinctname ..'\\cr') -- add obtained race/job instinct
		else
			table.insert(racejobinstincts_list, '\\cs(255,255,0) ' .. instinctname ..'\\cr') -- add unobtained race/job instinct
		end
	end
	playertracker['Racejobinstinct_completed'] = obtained
	playertracker['Racejobinstinct_total'] = total	
	return racejobinstincts_list
end

function mons_util.log_monsterlevels()
	local species_list = {}
	local total, complete = 0, 0
	
	for id, monster in pairs(map_species) do
		total = total+99
		table.insert(species_list, '\\cs(255,255,0) Lv. ' .. mons_util.monster_levels[id] .. ' ' .. monster ..'\\cr') -- add monster
		complete = complete + mons_util.monster_levels[id]
	end
	playertracker['MonsterLevels_completed'] = complete
	playertracker['MonsterLevels_total'] = total	
	return species_list
end

function mons_util.log_variants()
	if mons_util.variants_bitfield==nil then return end
	local variants_list = {}
	local total, obtained = 0, 0
	for id, variantname in pairs(map_species_variants) do
		total = total+1
		if mons_util.has_bit(mons_util.variants_bitfield, (id-256)) then
			obtained = obtained+1
			--table.insert(variants_list, '\\cs(0,255,0) ' .. variantname ..'\\cr') -- add obtained monster variant
		else
			--windower.add_to_chat(3, variantname)
			table.insert(variants_list, '\\cs(255,255,0) ' .. variantname ..'\\cr') -- add unobtained monster variant
		end
	end
	playertracker['MonsterVariants_completed'] = obtained
	playertracker['MonsterVariants_total'] = total	
	return variants_list
end


return mons_util