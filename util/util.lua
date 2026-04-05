local util = {}
local bit = require('bit')

function util.addon_log(str)
    windower.add_to_chat(161, '[Checklist] ' .. str)
end

function util.has_bit(data, position)
    return data:unpack('q', math.floor(position/8)+1, position%8+1)
end

function util.char_field_to_table(str)
    local t = {}
    for i = 1, #str do
        t[i - 1] = str:byte(i)
    end
    return t
end

function util.twobits_to_table(data)
-- Extract 2-bit values into a table
	local result = {}
	for i = 1, #data do
		local byte = data:byte(i)
		-- Each byte contains 4 values (2 bits each)
		for j = 0, 3 do
			local shift = j * 2
			local value = bit.band(bit.rshift(byte, shift), 0x03)
			result[#result + 1] = value
		end
	end
	return result
end

function util.cleanspaces(str)
    return str:gsub(" ", "_")
end

function util.list_item(category, text, completed)
	if (completed ~= true) then local completed = false end
	if (text == nil) then return end
	local item = {
		category = category,
		text = text,
		completed = completed,
	}
	return item
end

function util.totalpoints()
	local completed, total = 0,0
	for key, value in pairs(playertracker) do
		if (key:sub(-10) == "_completed" and type(value) == "number") then
			completed = completed + value
		elseif (key:sub(-6) == "_total" and type(value) == "number") then
			total = total + value
		end
	end
	return (completed - playertracker['Jobpoints_completed']), (total - playertracker['Jobpoints_total'])
end

return util