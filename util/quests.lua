local quest_util = {}
quests = {completed={},current={}}
quests.mutual_exclusive = require('../maps/quests_mutual_exclusive')
quests.missions_map = require('../maps/missions_map')

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
	[0x00D0] = {type='completed', area='nationzilartmissions'},
	[0x00D8] = {type='completed', area='toauwotgmissions'},
	[0xFFFE] = {type='current', area='currenttvrmissions'},
	[0xFFFF] = {type='current', area='currentothermissions'},
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
	sandoriamissions = require('../maps/missions_sandoria'),
	bastokmissions = require('../maps/missions_bastok'),
	windurstmissions = require('../maps/missions_windurst'),
	zilartmissions = require('../maps/missions_zilart'),
	ahturhganmissions = require('../maps/missions_ahturhgan'),
	wotgmissions = require('../maps/missions_wotg'),
}

function quest_util.log_quests(quest_area)
    if not quests.completed[quest_area] then return false end
	if (quest_area == 'campaign1' or quest_area == 'campaign2') then
		quest_area = 'campaign'
	end
	if (quest_area == 'campaign') then
		if not quests.completed['campaign1'] then return false end
		if not quests.completed['campaign2'] then return false end
		quests.completed[quest_area] = util.table_concat(quests.completed['campaign1'], quests.completed['campaign2'])
	end
    local complete,total = 0, 0
	local output_list = {}
	for key, name in pairs(maps[quest_area]) do
		local mutualcompleted = false
		local completion = false
		if maps[quest_area][key] then
			total = total + 1
            if util.has_bit(quests.completed[quest_area], key+1) then
                complete = complete + 1
				completion = true
			else
				if (quests.mutual_exclusive[quest_area] and quests.mutual_exclusive[quest_area][key]) then -- check if mutual quests involved
					--total = total - quests.mutual_exclusive[quest_type]:length() + 1 -- avoid multiple counts
					for alternative in pairs(quests.mutual_exclusive[quest_area]) do
						if util.has_bit(quests.completed[quest_area], alternative+1) then
							total = total - 1 --reduce total if alternative mutually exclusive quest is completed
							mutualcompleted = true
						end
					end
				end
            end
			if (not mutualcompleted) then
				table.insert(output_list, util.list_item(quest_area, maps[quest_area][key], completion))
			end
        end
	end
	tab_logs[quest_area..'_completed'] = complete
	tab_logs[quest_area..'_total'] = total
	return output_list
end

function quest_util.log_missions(mission_type, current_mission_id)
	if (not quests.missions_map[mission_type]) then return false end
	if (mission_type == 'acpmissions') or (mission_type == 'mkdmissions') or (mission_type == 'asamissions') then
		current_mission_id = util.fourbits(current_mission_id)
	end
	if current_mission_id == 1000 then current_mission_id = 0 end
	if current_mission_id < 0 then current_mission_id = current_mission_id + 2147483648 end
	local complete,total = 0, 0
	local output_list = {}
	for i, mission in ipairs(quests.missions_map[mission_type]) do
		total = total+1
		local completion = false
		if (current_mission_id > mission.id) then
			completion = true
			complete = complete+1
		end
		table.insert(output_list, util.list_item(nil, mission.name, completion))
	end
	tab_logs[mission_type..'_completed'] = complete
	tab_logs[mission_type..'_total'] = total
	return output_list
end

return quest_util