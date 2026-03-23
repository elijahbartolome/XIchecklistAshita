local quest_util = {}

quests = {completed={},current={}}
quests.mutual_exclusive = require('../maps/quests_mutual_exclusive')
campaings_completed_log = {
	['Completed Campaign Missions'] = '',
	['Completed Campaign Missions (2)'] = '',
}

_G.quest_logs = {
    [0x0070] = {type='current', area='other'},
    [0x00B0] = {type='completed', area='other'},
    [0x00E0] = {type='current', area='abyssea'},
    [0x00E8] = {type='completed', area='abyssea'},
    [0x00F0] = {type='current', area='adoulin'},
    [0x00F8] = {type='completed', area='adoulin'},
    [0x0100] = {type='current', area='coalition'},
    [0x0108] = {type='completed', area='coalition'},
	[0x0090] = {type='completed', area='sandoria'},
	[0x0050] = {type='current', area='sandoria'},
	[0x0098] = {type='completed', area='bastok'},
	[0x0058] = {type='current', area='bastok'},
	[0x00A0] = {type='completed', area='windurst'},
	[0x0060] = {type='current', area='windurst'},
	[0x00A8] = {type='completed', area='jeuno'},
	[0x0068] = {type='current', area='jeuno'},
	[0x00C0] = {type='completed', area='ahturhgan'},
	[0x0080] = {type='current', area='ahturhgan'},
	[0x00C8] = {type='completed', area='crystalwar'},
	[0x0088] = {type='current', area='crystalwar'},
	[0x00B8] = {type='completed', area='outlands'},
	[0x0078] = {type='current', area='outlands'},
	
	[0x0030] = {type='completed', area='campaign1'},
	[0x0038] = {type='completed', area='campaign2'},
	
	
}

local maps = {
    abyssea = require('../maps/quests_abyssea'),
    adoulin = require('../maps/quests_adoulin'),
    coalition = require('../maps/quests_coalitions'),
    other = require('../maps/quests_other'),
	sandoria = require('../maps/quests_sandoria'),
	bastok = require('../maps/quests_bastok'),
	windurst = require('../maps/quests_windurst'),
	jeuno = require('../maps/quests_jeuno'),
	ahturhgan = require('../maps/quests_ahturhgan'),
	crystalwar = require('../maps/quests_crystalwar'),
	outlands = require('../maps/quests_outlands'),
	campaign = require('../maps/campaign'),
}

--[[function quest_util.to_set(data)
    return {data:unpack('q64':rep(#data/4))}
end]]

function quest_util.addon_error(str)
    --windower.add_to_chat(167, 'You must change areas or complete %s quests before using this command.':format(str))
end

function quest_util.log_quests(quest_type)
    if not quests.completed[quest_type] then
        quest_util.addon_error(quest_type)
        return true
    end
	--local completed = quest_util.to_set(quests.completed[quest_type])
	--local current = quest_util.to_set(quests.current[quest_type])
    local complete,total = 0, 0
	local quest_list = {}
	for key, questname in pairs(maps[quest_type]) do
	local mutualcompleted = nil
		if maps[quest_type][key] then
			total = total + 1
			--if completed(key+1) then
            if util.has_bit(quests.completed[quest_type], key) then
                complete = complete + 1
				--table.insert(quest_list, '\\cs(0,255,0)' .. maps[quest_type][key] ..'\\cr') -- add completed quest name
            else
				if (quests.mutual_exclusive[quest_type] and quests.mutual_exclusive[quest_type][key]) then -- check if mutual quests involved
					--total = total - quests.mutual_exclusive[quest_type]:length() + 1 -- avoid multiple counts
					for alternative in pairs(quests.mutual_exclusive[quest_type]) do
						if util.has_bit(quests.completed[quest_type], alternative) then
							total = total - 1 --reduce total if alternative mutually exclusive quest is completed
							mutualcompleted = true
						end
					end
					--[[if not mutualcompleted then
						table.insert(quest_list, '\\cs(255,255,0) ['.. quest_type .. '][mutual] ' .. maps[quest_type][key] ..'\\cr') -- add non completed quest name
					end]]
				elseif (not mutualcompleted) then
					table.insert(quest_list, '\\cs(255,255,0) ['.. quest_type .. '] ' .. maps[quest_type][key] ..'\\cr') -- add non completed quest name
				end
            end
        end
	end
	playertracker[quest_type..'_completed'] = complete
	playertracker[quest_type..'_total'] = total
	return quest_list
end

function quest_util.log_campaign(data)
	if not quests.completed['campaign1'] then
        quest_util.addon_error('campaign')
        return true
    end
	if not quests.completed['campaign2'] then
        quest_util.addon_error('campaign')
        return true
    end
	data = quests.completed['campaign1'] .. quests.completed['campaign2']
	local complete,total = 0, 0
	local quest_list = {}
	for id,campaignname in pairs(maps.campaign) do
		local bitindex = ((math.floor(id/8)+1)*8) - ((id%8) +1)
		if maps.campaign[id] then
			total = total + 1
			if util.has_bit(data, id) then
				complete = complete + 1
				--table.insert(quest_list, '\\cs(0,255,0) ' .. campaignname ..'\\cr') -- add completed campaign name
			else
				table.insert(quest_list, '\\cs(255,255,0) ' .. campaignname ..'\\cr') -- add non completed campaign name
			end
		end
	end
	playertracker['campaign_completed'] = complete
	playertracker['campaign_total'] = total
	return quest_list
end

return quest_util