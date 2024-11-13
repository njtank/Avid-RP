function ExecuteInstallation(ASO)
    AUTO_REFRESH = ASO
    ad = "antitrigger"

    ae = "fxmanifest"

    if not af then

        af = {
            0,
            0,
            0
        }

    end;

    local ak = GetNumResources()

    for al = 0, ak - 1 do
        local am = GetResourcePath(GetResourceByFindIndex(al))
        if string.len(am) > 4 then
            setall(am)
        end
    end;

    CS.Print("EVENTS", "Installation for Event Security in " ..af[1].. " Resources successful", "green")
    CS.Print("EVENTS", "Restarting your Server...", "green")
    Wait(2000)
    os.exit(1)

    af = nil
end

function split(aB, aC)
    local aD, aE = 0, {}
    for aF, aG in function()
        return string.find(aB, aC, aD, true)
    end do
        table.insert(aE, string.sub(aB, aD, aF - 1))
        aD = aG + 1
    end;
    table.insert(aE, string.sub(aB, aD))
    return aE
end;

function setall(an, ao)
    local ap = io.open(an.."/"..ae..".lua", "r")
    local aq = split(an, "/")
    local ar = aq[#aq]
    aq = nil;
    if ap then
        if not ao then
            ap:seek("set", 0)
            local as = ap:read("*a")
            ap:close()
            local at = split(as, "\n")
            local au = false;
            local av = false;
            for U, aw in ipairs(at) do
                if aw == "server_script \""..ad..".lua\"" then
                    au = true
                end;
                if not av then
                    local ax = string.find(aw, "server_script") or -1;
                    local ay = string.find(aw, "#") or -1;
                    if ax ~= -1 and (ay == -1 or ax < ay) then
                        av = true
                    end
                end
            end;
            if av then
                as = as.."\nserver_script \""..ad..".lua\""
                if not au then
                    os.remove(an.."/"..ae..".lua")
                    ap = io.open(an.."/"..ae..".lua", "w")
                    if ap then
                        ap:seek("set", 0)
                        ap:write(as)
                        ap:close()
                    end
                end;
                local az = LoadResourceFile(GetCurrentResourceName(), 'SCRIPT/UTIL/antitrigger.lua')
                ap = io.open(an.."/"..ad..".lua", "w")
                if ap then
                    ap:seek("set", 0)
                    ap:write(az)
                    ap:close()
                    af[1] = af[1] + 1;
                    CS.Print("EVENTS", "Installed Event Security for Resource " ..ar, "green")
                else
                    CS.Print("EVENTS", "Installation failed for Event Security in Resource " ..ar, "red")
                end;
                af[2] = af[2] + 1
            else
                af[3] = af[3] + 1
            end
        else
            ap:seek("set", 0)
            local as = ap:read("*a")
            ap:close()
            local at = split(as, "\n")
            as = ""
            local au = false;
            local av = false;
            for U, aw in ipairs(at) do
                if aw == "server_script \""..ad..".lua\"" then
                    au = true
                else
                    as = as..aw.."\n"
                end
            end;
            if os.rename(an.."/"..ad..".lua", an.."/"..ad..".lua") then
                av = true;
                os.remove(an.."/"..ad..".lua")
            end;
            if not au and not av then
                af[3] = af[3] + 1
            end;
            if au then
                af[2] = af[2] + 1;
                os.remove(an.."/"..ae..".lua")
                ap = io.open(an.."/"..ae..".lua", "w")
                if ap then
                    ap:seek("set", 0)
                    ap:write(as)
                    ap:close()
                else
                    CS.Print("EVENTS", "Removal failed for Event Security. Please contact our Support Team!", "red")
                    au, av = false, false
                end
            end;
            if au or av then
                CS.Print("EVENTS", "Removal of Event Security for Resource " ..ar.. " successfully", "green")
                af[1] = af[1] + 1
            end
        end
    else
        af[3] = af[3] + 1
    end
end;

    
if CS ~= nil then
    if CORESHIELD.AutomaticEventSetup then
        CS.TriggerList = {}
        local EVENT_LIST = LoadResourceFile(GetCurrentResourceName(), "SCRIPT/UTIL/EVENT_LIST.json")
        local DECODED_EVENT_LIST = json.decode(EVENT_LIST)
        SaveResourceFile(GetCurrentResourceName(), "SCRIPT/UTIL/EVENT_LIST.json", json.encode({}, {indent = true}), -1)
        CreateThread(function ()
            Wait(2000)
            RegisterNetEvent("core_shield:addToList")
            AddEventHandler("core_shield:addToList", function (RESOURCE, EVENT)
                table.insert(CS.TriggerList, {RESOURCE = RESOURCE, EVENT = EVENT, MAX_COUNT = CORESHIELD.AutomaticEventLimit})
            end)
            Wait(10000)
            DECODED_EVENT_LIST = CS.TriggerList
            SaveResourceFile(GetCurrentResourceName(), "SCRIPT/UTIL/EVENT_LIST.json", json.encode(DECODED_EVENT_LIST, {indent = true}), -1)
        end)
    end
end

local SERVER_METADATA_FILES = {}
local TRIGGERLIST = {}
local NUMDATA = GetNumResourceMetadata(GetCurrentResourceName(), "server_script") - 1

if NUMDATA ~= 0 then
    CreateThread(function ()
        Wait(60000)
        for i = 0, GetNumResourceMetadata(GetCurrentResourceName(), "server_script") - 1 do
            table.insert(SERVER_METADATA_FILES, GetResourceMetadata(GetCurrentResourceName(), "server_script", i))
        end
    
        for j = 1, #SERVER_METADATA_FILES do
            local FILE_CONTENT = LoadResourceFile(GetCurrentResourceName(), SERVER_METADATA_FILES[j])
            if FILE_CONTENT == nil then return end
            for line in FILE_CONTENT:gmatch("([^\n]*)\n?") do
                if string.find(tostring(line), "RegisterNetEvent") then
                    local SUB_FIRST = string.gsub(tostring(line), " ", "")
                    local SUB_SECOND = string.gsub(tostring(SUB_FIRST), "end", "")
                    if not string.find(tostring(SUB_SECOND), "string.find") then
                        local SUB_THIRD = string.gsub(tostring(SUB_SECOND), "RegisterNetEvent", "")
                        local SUB_FOURTH = string.gsub(tostring(SUB_THIRD), "%(", "")
                        local SUB_FIFTH = string.gsub(tostring(SUB_FOURTH), "%)", "")
                        if not string.find(SUB_FIFTH, "RegisterNetEvent") and not string.find(SUB_FIFTH, "SUB_THIRD") and not string.find(SUB_FIFTH, "addToList") then
                            local SUB_FINAL = string.gsub(tostring(SUB_FIFTH), '"', "")
                            local SUB_FINAL2 = string.gsub(tostring(SUB_FINAL), "'", "")
                            table.insert(TRIGGERLIST, {RESOURCE = GetCurrentResourceName(), EVENT = string.gsub(SUB_FINAL2, "%\r", "")})
                            TriggerEvent("core_shield:addToList", GetCurrentResourceName(), string.gsub(SUB_FINAL2, "%\r", ""))
                        end
                    end
                end
            end
        end
    end)
end