--[[
* This addon is meant to be used in conjunction with atom0s's logs addon.
]]--

_addon.author   = 'Almavivaconte';
_addon.name     = 'findlog';
_addon.version  = '0.0.2';

require 'common'

local dynadrops = {};

local days_in_month = {
31,
28,
31,
30,
31,
30,
31,
31,
30,
31,
30,
31
}

local function clean_str(str)
    -- Parse auto-translate tags..
    str = ParseAutoTranslate(str, true);

    -- Strip the string of color tags..
    str = (str:gsub('[' .. string.char(0x1E, 0x1F, 0x7F) .. '].', ''));

    -- Strip the string of auto-translate tags..
    str = (str:gsub(string.char(0xEF) .. '[' .. string.char(0x27) .. ']', '{'));
    str = (str:gsub(string.char(0xEF) .. '[' .. string.char(0x28) .. ']', '}'));

    -- Trim linebreaks from end of strings..
    while true do
        local hasN = str:endswith('\n');
        local hasR = str:endswith('\r');
        if (hasN or hasR) then
            if (hasN) then
                str = str:trimend('\n');
            end
            if (hasR) then
                str = str:trimend('\r');
            end
        else
            break;
        end
    end
        
    -- Convert mid-linebreaks to real linebreaks..
    str = (str:gsub(string.char(0x07), '\n'));
    
    return str;
end

ashita.register_event('command', function(command, ntype)
    -- Ensure we should handle this command..
    local args = command:args();
    if (args[1] ~= '/findlog' and args[1] ~= '/fl' and args[1] ~= '/flcount' and args[1] ~= '/dynacount' and args[1] ~= '/dynalist' and args[1] ~= '/dynatest' and args[1] ~= '/findlast' and args[1] ~= '/flast') then
        return false;
    end
    
    local name = AshitaCore:GetDataManager():GetParty():GetMemberName(0);
    
    local searchstring = args[2];
    local d = os.date('*t');
    local yesterday_datestamp = string.format('%.4u.%.2u.%.2u.log', d.year, d.month, d.day-1);
    
    if d.year % 4 == 0 and (year % 100 ~= 0 or d.year % 400 == 0) then
        days_in_month[2] = 29
    end
    
    if d.day == 1 then
        if d.month == 1 then
            yesterday_datestamp = string.format('%.4u.%.2u.%.2u.log', d.year-1, 12, 31);
        else
            yesterday_datestamp = string.format('%.4u.%.2u.%.2u.log', d.year, d.month-1, days_in_month[d.month-1])
        end
    end
    
    folderpath = string.format('%s%s\\', AshitaCore:GetAshitaInstallPath(), 'chatlogs')
    
    local path;
    
    if(args[1] == '/findlast' or args[1] == '/flast') then
        path = folderpath .. name .. "_" .. string.format('%.4u.%.2u.%.2u.log', d.year, d.month, d.day) .. "\"";
    else
        path = folderpath .. name .. "_" .. string.format('%.4u.%.2u.%.2u.log', d.year, d.month, d.day) .. "\" \"" .. folderpath .. name .. "_" .. yesterday_datestamp;
    end
    
    for i=3,#args do 
        searchstring = searchstring .. " " .. args[i];
    end
    
    local d = os.date('*t'); 
    
    if searchstring ~= nil then
        command = "findstr /IRC:\"" .. searchstring .. "\" \"" .. path .. "\"";
    end
    
    if args[1] == '/flcount' then
        command = command .. " | find /c /v \"GarbageStringNotInThisSearchforNegativeMatch\""
    end    
    
    if args[1] ~= '/dynacount' then
        local handle = io.popen(command);
        local result = handle:read("*a");
        result = result:gsub(folderpath, "");
        if(args[1] == '/findlast' or args[1] == '/flast') then
            for str in result:gmatch("\n+") do
                print(str)
            end
        else
            print(result);
        end
    else
        command1 = "findstr /IRC:\"obtains a tukuku\" \"" .. path .. "\" | find /c /v \"GarbageStringNotInThisSearchforNegativeMatch\"";
        command2 = "findstr /IRC:\"obtains a one byne\" \"" .. path .. "\" | find /c /v \"GarbageStringNotInThisSearchforNegativeMatch\"";
        command3 = "findstr /IRC:\"obtains an ordelle bronze\" \"" .. path .. "\" | find /c /v \"GarbageStringNotInThisSearchforNegativeMatch\"";
        command4 = "findstr /IRC:\"obtains a lungo-nango\" \"" .. path .. "\" | find /c /v \"GarbageStringNotInThisSearchforNegativeMatch\"";
        command5 = "findstr /IRC:\"obtains a one hundred byne\" \"" .. path .. "\" | find /c /v \"GarbageStringNotInThisSearchforNegativeMatch\"";
        command6 = "findstr /IRC:\"obtains a montiont\" \"" .. path .. "\" | find /c /v \"GarbageStringNotInThisSearchforNegativeMatch\"";
        local handle1 = io.popen(command1);
        local result1 = handle1:read("*a");
        result1 = result1:gsub(folderpath, "");
        print("Tukuku Whiteshell: " .. result1);
        local handle2 = io.popen(command2);
        local result2 = handle2:read("*a");
        result2 = result2:gsub(folderpath, "");
        print("One Byne: " .. result2);
        local handle3 = io.popen(command3);
        local result3 = handle3:read("*a");
        result3 = result3:gsub(folderpath, "");
        print("Ordelle Bronzepiece: " .. result3);
        local handle4 = io.popen(command4);
        local result4 = handle4:read("*a");
        result4 = result4:gsub(folderpath, "");
        print("Lungo-Nango Jadeshell: " .. result4);
        local handle5 = io.popen(command5);
        local result5 = handle5:read("*a");
        result5 = result5:gsub(folderpath, "");
        print("One Hundred Byne: " .. result5);
        local handle6 = io.popen(command6);
        local result6 = handle6:read("*a");
        result6 = result6:gsub(folderpath, "");
        print("Montiont Silverpiece: " .. result6);
        local total = tonumber(result1) + tonumber(result2) + tonumber(result3) + tonumber(result4)*100 + tonumber(result5)*100 + tonumber(result6)*100
        print("Total: " .. total)
    end
    
    if args[1] == '/dynalist' then
        local total = 0;
        for k,v in pairs(dynadrops) do
            print(k .. ": " .. v);
            total = total + v;
        end
        print("Total: " .. total)
    end
    
    return false;
end);

ashita.register_event('incoming_text', function(mode, message)
    if (string.len(message) == 0) then
        return false;
    end
    
    message_clean = clean_str(message)
    
    if message_clean:contains("obtains an Ordelle bronze") or message_clean:contains("obtains a one byne") or message_clean:contains("obtains a Tukuku") then
        local words = {}
        words[1], words[2] = message_clean:match("(%w+)(.+)")
        name = words[1];
        if(dynadrops[tostring(name)] == nil) then
            dynadrops[tostring(name)] = 1;
        else
            dynadrops[tostring(name)] = dynadrops[tostring(name)] + 1;
        end
    end
    
    if message_clean:contains("You find a Lungo-Nango") or message_clean:contains("You find a one hundred byne bill") or message_clean:contains("You find a Montiont") then
        local fullpath = string.format('%s\\sounds\\mlg-airhorn.wav', _addon.path);
        ashita.misc.play_sound(fullpath);
        if(dynadrops[tostring(name)] == nil) then
            dynadrops[tostring(name)] = 100;
        else
            dynadrops[tostring(name)] = dynadrops[tostring(name)] + 100;
        end
    end
    return false;
end);

