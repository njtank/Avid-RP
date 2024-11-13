EDITABLE = {}

---@param xPlayer xPlayer
---@return string
EDITABLE.GetBadge = function(xPlayer)
    --// Add your badge system below commented code is example use of my badges in esx

    -- local badge = json.decode(xPlayer.get('job_id'))
								
    -- if badge.id then
    --     badge.id = badge.id
    --     return '['..badge.id..']'
    -- else
    --     badge.id = 0
    --     return '['..badge.id..']'
    -- end

    -- return "[01]"
    return "[" .. xPlayer.source .. "]"
end

---@param xPlayer xPlayer
---@return int
EDITABLE.GetPhoneNumber = function(identifier)
    --// Add your function for get phone number
    if Config.Phones.hype_phone then
        if Config.Frameworks.ESX.enabled then
            local SELECT_PHONE_NUMBER = 'SELECT `phone_number` FROM `users` WHERE `identifier` = ?'
            local number = ''

            if not number or number == '' then
                local result = MySQL.Sync.fetchAll(SELECT_PHONE_NUMBER, { identifier })
                if result[1] then
                    number = result[1].phone_number
                end
            end
            
            return number
        elseif Config.Frameworks.QB.enabled then
            local SELECT_PHONE_NUMBER = 'SELECT `charinfo` FROM `players` WHERE `citizenid` = ?'
            local number = ''

            if not number or number == '' then
                local result = MySQL.Sync.fetchAll(SELECT_PHONE_NUMBER, { identifier })
                if result[1] then
                    number = json.decode(result[1].phone)
                end
            end
            
            return number
        else
            print('[^2INFO^0] [^5avid-mdt^0] Please configure [^2EDITABLE.GetPhoneNumber^0]')
            return 555555
        end
    elseif Config.Phones.qs_smartphone then
        if Config.Frameworks.ESX.enabled then
            local query = "SELECT JSON_UNQUOTE(JSON_EXTRACT(charinfo, '$.phone')) AS phone FROM users WHERE identifier = ?"
            local response = MySQL.query.await(query, {identifier})

            if response and #response > 0 then
                local phone = response[1].phone

                if phone ~= nil and phone ~= '' then
                    return phone
                end
            end

            return 555555
        elseif Config.Frameworks.QB.enabled then
            local query = "SELECT JSON_UNQUOTE(JSON_EXTRACT(charinfo, '$.phone')) AS phone FROM players WHERE citizenid = ?"
            local response = MySQL.query.await(query, {identifier})

            if response and #response > 0 then
                local phone = response[1].phone

                if phone ~= nil and phone ~= '' then
                    return phone
                end
            end

            return 555555
        else
            print('[^2INFO^0] [^5avid-mdt^0] Please configure [^2EDITABLE.GetPhoneNumber^0]')
            return 555555
        end
    elseif Config.Phones.lb_phone then
        if Config.Frameworks.ESX.enabled then
            local query = "SELECT phone_number AS phone FROM phone_phones WHERE id = ?"
            local response = MySQL.query.await(query, {identifier})

            if response and #response > 0 then
                local phone = response[1].phone

                if phone ~= nil and phone ~= '' then
                    return phone
                end
            end

            return 555555
        elseif Config.Frameworks.QB.enabled then
            local query = "SELECT phone_number AS phone FROM phone_phones WHERE id = ?"
            local response = MySQL.query.await(query, {identifier})

            if response and #response > 0 then
                local phone = response[1].phone

                if phone ~= nil and phone ~= '' then
                    return phone
                end
            end

            return 555555
        else
            print('[^2INFO^0] [^5avid-mdt^0] Please configure [^2EDITABLE.GetPhoneNumber^0]')
            return 555555
        end
    else
        print('[^2INFO^0] [^5avid-mdt^0] Please configure [^2EDITABLE.GetPhoneNumber^0]')
        return 555555
    end
end

---@param time number
---@return string
EDITABLE.ConvertTime = function(time)
    if not time then
        return "00:00:00"
    end

    local hours = math.floor(time / 3600)
    local remaining = time % 3600
    local minutes = math.floor(remaining / 60)
    remaining = remaining % 60
    local seconds = remaining

    if hours < 10 then
        hours = "0" .. tostring(hours)
    end
    if minutes < 10 then
        minutes = "0" .. tostring(minutes)
    end
    if seconds < 10 then
        seconds = "0" .. tostring(seconds)
    end

    local answer = hours .. ":" .. minutes .. ":" .. seconds
    
    return answer
end


EDITABLE.GetTime = function(xPlayer)
    --// Add your duty time system
    -- return EDITABLE.ConvertTime(MySQL.scalar.await('SELECT timespent FROM users WHERE identifier = ?', {xPlayer.getIdentifier()}))
    return EDITABLE.ConvertTime(28140) --// IF YOU USE SOME COUNTING USER DUTYTIME YOU CAN GET IT HERE
end

CALLBACK.RegisterServerCallback('avid-mdt:getCurrentHouse', function(source, cb, value)
    if Config.Properties.esx_property_old then
        local property = MySQL.single.await('SELECT label, name FROM properties WHERE LOWER(`name`) LIKE "%' .. value:lower() .. '%" LIMIT 30')

        local house_data = {
            label = property.label,
            name = property.name,
            data = {
                owned = false,
                owner = '',
            },
            notes = {}
        }

        local owner = MySQL.single.await('SELECT owner FROM owned_properties WHERE name = ?', {value})
        if owner and owner.owner then
            local a = MySQL.single.await('SELECT firstname, lastname FROM users WHERE identifier = ?', {owner.owner})
            house_data.data.owned = true
            house_data.data.owner = a.firstname .. ' ' .. a.lastname
        end

        local notes = MySQL.query.await('SELECT id, date, note, officer FROM avid-mdt_housenotes WHERE house_name = ?', {value})
        if #notes > 0 then
            for h, j in pairs(notes) do
                local notes_length = #house_data.notes
                house_data.notes[notes_length + 1] = {
                    id = j.id,
                    date = j.date,
                    reason = j.note,
                    officer = j.officer
                }
            end
        end

        cb(house_data)
    elseif Config.Properties.esx_property_legacy then
        local PropertiesList = LoadResourceFile("esx_property", 'properties.json')
        local Properties = {}

        if PropertiesList then
            Properties = json.decode(PropertiesList)

            for k, v in pairs(Properties) do       
                if v.Name:lower():find(value:lower()) then
                    local house_data = {
                        label = v.Name,
                        name = v.Name,
                        data = {
                            owned = false,
                            owner = '',
                        },
                        notes = {}
                    }

                    local owner = v.Owner

                    if owner then
                        local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(v.Owner)

                        if ownerPlayer then
                            house_data.data.owned = true
                            house_data.data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                        else
                            house_data.data.owned = false
                            house_data.data.owner = ''
                        end
                    end

                    local notes = MySQL.query.await('SELECT id, date, note, officer FROM avid-mdt_housenotes WHERE house_name = ?', {v.Name})
                    if #notes > 0 then
                        for h, j in pairs(notes) do
                            local notes_length = #house_data.notes
                            house_data.notes[notes_length + 1] = {
                                id = j.id,
                                date = j.date,
                                reason = j.note,
                                officer = j.officer
                            }
                        end
                    end

                    cb(house_data)
                end        
            end
        end
    elseif Config.Properties.qb_apartments then
        local property = MySQL.single.await('SELECT label, name FROM apartments WHERE LOWER(`name`) LIKE "%' .. value:lower() .. '%" LIMIT 30')

        local house_data = {
            label = property.label,
            name = property.name,
            data = {
                owned = false,
                owner = '',
            },
            notes = {}
        }

        local owner = MySQL.single.await('SELECT citizenid FROM apartments WHERE name = ?', {value})

        if owner then
            local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.citizenid)

            if ownerPlayer then
                house_data.data.owned = true
                house_data.data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
            else
                house_data.data.owned = false
                house_data.data.owner = ''
            end
        end

        local notes = MySQL.query.await('SELECT id, date, note, officer FROM avid-mdt_housenotes WHERE house_name = ?', {value})
        if #notes > 0 then
            for h, j in pairs(notes) do
                local notes_length = #house_data.notes
                house_data.notes[notes_length + 1] = {
                    id = j.id,
                    date = j.date,
                    reason = j.note,
                    officer = j.officer
                }
            end
        end

        cb(house_data)
    elseif Config.Properties.qs_housing then
        local property = MySQL.single.await('SELECT label, name FROM houselocations WHERE LOWER(`name`) LIKE "%' .. value:lower() .. '%" LIMIT 30')

        local house_data = {
            label = property.label,
            name = property.name,
            data = {
                owned = false,
                owner = '',
            },
            notes = {}
        }

        local owner = MySQL.single.await('SELECT identifier FROM player_houses WHERE house = ?', {value})

        if owner then
            local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.citizenid)

            if ownerPlayer then
                house_data.data.owned = true
                house_data.data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
            else
                house_data.data.owned = false
                house_data.data.owner = ''
            end
        end

        local notes = MySQL.query.await('SELECT id, date, note, officer FROM avid-mdt_housenotes WHERE house_name = ?', {value})
        if #notes > 0 then
            for h, j in pairs(notes) do
                local notes_length = #house_data.notes
                house_data.notes[notes_length + 1] = {
                    id = j.id,
                    date = j.date,
                    reason = j.note,
                    officer = j.officer
                }
            end
        end

        cb(house_data)
    else
        print('[^2INFO] ^0[^5avid-mdt^0] encountered a problem at [^5getCurrentHouse^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
        -- SCRIPT BY OWN
    end
end)

RegisterServerEvent('avid-mdt:searchHouses', function(value)
    local src = source
    local xPlayer = FRAMEWORK.GetPlayerFromId(src)
    
    if xPlayer then
        if Config.Jobs.OnDuty[xPlayer.job.name] then
            if Config.Properties.esx_property_old then
                local data = {}
        
                MySQL.query('SELECT label, name FROM properties WHERE CONCAT(name, " ", label) LIKE "%' .. value:lower() .. '%" LIMIT 30', {}, function(result)
                    for k, v in pairs(result) do
                        local data_length = #data
        
                        data[data_length + 1] = {
                            label = v.label,
                            name = v.name,
                            data = {
                                owned = false,
                                owner = '',
                            },
                            notes = {}
                        }
        
                        local owner = MySQL.single.await('SELECT owner FROM owned_properties WHERE name = ?', {v.name})
                        if owner and owner.owner then
                            local a = MySQL.single.await('SELECT firstname, lastname FROM users WHERE identifier = ?', {owner.owner})
                            data[data_length + 1].data.owned = true
                            data[data_length + 1].data.owner = a.firstname .. ' ' .. a.lastname
                        end
        
                        local notes = MySQL.query.await('SELECT id, date, note, officer FROM avid-mdt_housenotes WHERE house_name = ?', {v.name})
                        if #notes > 0 then
                            for h, j in pairs(notes) do
                                local notes_length = #data[data_length + 1].notes
                                data[data_length + 1].notes[notes_length + 1] = {
                                    id = j.id,
                                    date = j.date,
                                    reason = j.note,
                                    officer = j.officer
                                }
                            end
                        end
                    end
                    TriggerClientEvent('avid-mdt:housesResults', src, data)
                end)
            elseif Config.Properties.esx_property_legacy then
                local data = {}
        
                local PropertiesList = LoadResourceFile("esx_property", 'properties.json')
                local Properties = {}
        
                if PropertiesList then
                    Properties = json.decode(PropertiesList)
        
                    for k, v in pairs(Properties) do
                        local data_length = #data
        
                        if v.Name:lower():find(value:lower()) then
                            data[data_length + 1] = {
                                label = v.Name,
                                name = v.Name,
                                data = {
                                    owned = false,
                                    owner = '',
                                },
                                notes = {}
                            }
        
                            local owner = v.Owner
        
                            if owner then
                                local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(v.Owner)
        
                                if ownerPlayer then
                                    data[data_length + 1].data.owned = true
                                    data[data_length + 1].data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                                else
                                    data[data_length + 1].data.owned = false
                                    data[data_length + 1].data.owner = ''
                                end
                            end
        
                            local notes = MySQL.query.await('SELECT id, date, note, officer FROM avid-mdt_housenotes WHERE house_name = ?', {v.Name})
                            if #notes > 0 then
                                for h, j in pairs(notes) do
                                    local notes_length = #data[data_length + 1].notes
                                    data[data_length + 1].notes[notes_length + 1] = {
                                        id = j.id,
                                        date = j.date,
                                        reason = j.note,
                                        officer = j.officer
                                    }
                                end
                            end
        
                            TriggerClientEvent('avid-mdt:housesResults', src, data)
                        end             
                    end
                end
            elseif Config.Properties.qb_apartments then
                local data = {}
        
                MySQL.query('SELECT label, name FROM apartments WHERE CONCAT(name, " ", label) LIKE "%' .. value:lower() .. '%" LIMIT 30', {}, function(result)
                    for k, v in pairs(result) do
                        local data_length = #data
        
                        data[data_length + 1] = {
                            label = v.label,
                            name = v.name,
                            data = {
                                owned = false,
                                owner = '',
                            },
                            notes = {}
                        }
        
                        local owner = MySQL.single.await('SELECT citizenid FROM apartments WHERE name = ?', {value})
        
                        if owner then
                            local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.citizenid)
        
                            if ownerPlayer then
                                data[data_length + 1].data.owned = true
                                data[data_length + 1].data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                            else
                                data[data_length + 1].data.owned = false
                                data[data_length + 1].data.owner = ''
                            end
                        end
        
                        local notes = MySQL.query.await('SELECT id, date, note, officer FROM avid-mdt_housenotes WHERE house_name = ?', {v.name})
                        if #notes > 0 then
                            for h, j in pairs(notes) do
                                local notes_length = #data[data_length + 1].notes
                                data[data_length + 1].notes[notes_length + 1] = {
                                    id = j.id,
                                    date = j.date,
                                    reason = j.note,
                                    officer = j.officer
                                }
                            end
                        end
                    end
                    TriggerClientEvent('avid-mdt:housesResults', src, data)
                end)
            elseif Config.Properties.qs_housing then
                local data = {}
        
                MySQL.query('SELECT label, name FROM houselocations WHERE CONCAT(name, " ", label) LIKE "%' .. value:lower() .. '%" LIMIT 30', {}, function(result)
                    for k, v in pairs(result) do
                        local data_length = #data
        
                        data[data_length + 1] = {
                            label = v.label,
                            name = v.name,
                            data = {
                                owned = false,
                                owner = '',
                            },
                            notes = {}
                        }
        
                        local owner = MySQL.single.await('SELECT identifier FROM player_houses WHERE house = ?', {value})
        
                        if owner then
                            local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.citizenid)
        
                            if ownerPlayer then
                                data[data_length + 1].data.owned = true
                                data[data_length + 1].data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                            else
                                data[data_length + 1].data.owned = false
                                data[data_length + 1].data.owner = ''
                            end
                        end
        
                        local notes = MySQL.query.await('SELECT id, date, note, officer FROM avid-mdt_housenotes WHERE house_name = ?', {v.name})
                        if #notes > 0 then
                            for h, j in pairs(notes) do
                                local notes_length = #data[data_length + 1].notes
                                data[data_length + 1].notes[notes_length + 1] = {
                                    id = j.id,
                                    date = j.date,
                                    reason = j.note,
                                    officer = j.officer
                                }
                            end
                        end
                    end
                    TriggerClientEvent('avid-mdt:housesResults', src, data)
                end)
            else
                print('[^2INFO] ^0[^5avid-mdt^0] encountered a problem at [^5searchHouses^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
                -- SCRIPT BY OWN
            end
        end
    end
end)

RegisterServerEvent('avid-mdt:houses', function()
    local src = source
    local xPlayer = FRAMEWORK.GetPlayerFromId(src)

    if xPlayer then
        if Config.Jobs.OnDuty[xPlayer.job.name] then
            if Config.Properties.esx_property_old then
                local data = {}
        
                MySQL.query('SELECT label, name FROM properties', {}, function(result)
                    for k, v in pairs(result) do
                        local data_length = #data
        
                        data[data_length + 1] = {
                            label = v.label,
                            name = v.name,
                            data = {
                                owned = false,
                                owner = '',
                            },
                            notes = {}
                        }
        
                        local owner = MySQL.single.await('SELECT owner FROM owned_properties WHERE name = ?', {v.name})
                        if owner and owner.owner then
                            local a = MySQL.single.await('SELECT firstname, lastname FROM users WHERE identifier = ?', {owner.owner})
                            data[data_length + 1].data.owned = true
                            data[data_length + 1].data.owner = a.firstname .. ' ' .. a.lastname
                        end
        
                        local notes = MySQL.query.await('SELECT id, date, note, officer FROM avid-mdt_housenotes WHERE house_name = ?', {v.name})
                        if #notes > 0 then
                            for h, j in pairs(notes) do
                                local notes_length = #data[data_length + 1].notes
                                data[data_length + 1].notes[notes_length + 1] = {
                                    id = j.id,
                                    date = j.date,
                                    reason = j.note,
                                    officer = j.officer
                                }
                            end
                        end
                    end
                    TriggerClientEvent('avid-mdt:housesResults', src, data)
                end)
            elseif Config.Properties.esx_property_legacy then
                local data = {}
        
                local PropertiesList = LoadResourceFile("esx_property", 'properties.json')
                local Properties = {}
        
                if PropertiesList then
                    Properties = json.decode(PropertiesList)
        
                    for k, v in pairs(Properties) do
                        local data_length = #data
        
                        data[data_length + 1] = {
                            label = v.Name,
                            name = v.Name,
                            data = {
                                owned = false,
                                owner = '',
                            },
                            notes = {}
                        }
        
                        local owner = v.Owner
        
                        if owner then
                            local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(v.Owner)
        
                            if ownerPlayer then
                                data[data_length + 1].data.owned = true
                                data[data_length + 1].data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                            else
                                data[data_length + 1].data.owned = false
                                data[data_length + 1].data.owner = ''
                            end
                        end
        
                        local notes = MySQL.query.await('SELECT id, date, note, officer FROM avid-mdt_housenotes WHERE house_name = ?', {v.Name})
                        if #notes > 0 then
                            for h, j in pairs(notes) do
                                local notes_length = #data[data_length + 1].notes
                                data[data_length + 1].notes[notes_length + 1] = {
                                    id = j.id,
                                    date = j.date,
                                    reason = j.note,
                                    officer = j.officer
                                }
                            end
                        end
        
                        TriggerClientEvent('avid-mdt:housesResults', src, data)
                    end
                end
            elseif Config.Properties.qb_apartments then
                local data = {}
        
                MySQL.query('SELECT label, name FROM apartments', {}, function(result)
                    for k, v in pairs(result) do
                        local data_length = #data
        
                        data[data_length + 1] = {
                            label = v.label,
                            name = v.name,
                            data = {
                                owned = false,
                                owner = '',
                            },
                            notes = {}
                        }
        
                        local owner = MySQL.single.await('SELECT citizenid FROM apartments WHERE name = ?', {v.name})
        
                        if owner then
                            local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.citizenid)
        
                            if ownerPlayer then
                                data[data_length + 1].data.owned = true
                                data[data_length + 1].data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                            else
                                data[data_length + 1].data.owned = false
                                data[data_length + 1].data.owner = ''
                            end
                        end
        
                        local notes = MySQL.query.await('SELECT id, date, note, officer FROM avid-mdt_housenotes WHERE house_name = ?', {v.name})
                        if #notes > 0 then
                            for h, j in pairs(notes) do
                                local notes_length = #data[data_length + 1].notes
                                data[data_length + 1].notes[notes_length + 1] = {
                                    id = j.id,
                                    date = j.date,
                                    reason = j.note,
                                    officer = j.officer
                                }
                            end
                        end
                    end
        
                    TriggerClientEvent('avid-mdt:housesResults', src, data)
                end)
            elseif Config.Properties.qs_housing then
                local data = {}
        
                MySQL.query('SELECT label, name FROM houselocations', {}, function(result)
                    for k, v in pairs(result) do
                        local data_length = #data
        
                        data[data_length + 1] = {
                            label = v.label,
                            name = v.name,
                            data = {
                                owned = false,
                                owner = '',
                            },
                            notes = {}
                        }
        
                        local owner = MySQL.single.await('SELECT identifier FROM player_houses WHERE house = ?', {v.name})
        
                        if owner then
                            local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.citizenid)
        
                            if ownerPlayer then
                                data[data_length + 1].data.owned = true
                                data[data_length + 1].data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                            else
                                data[data_length + 1].data.owned = false
                                data[data_length + 1].data.owner = ''
                            end
                        end
        
                        local notes = MySQL.query.await('SELECT id, date, note, officer FROM avid-mdt_housenotes WHERE house_name = ?', {v.name})
                        if #notes > 0 then
                            for h, j in pairs(notes) do
                                local notes_length = #data[data_length + 1].notes
                                data[data_length + 1].notes[notes_length + 1] = {
                                    id = j.id,
                                    date = j.date,
                                    reason = j.note,
                                    officer = j.officer
                                }
                            end
                        end
                    end
        
                    TriggerClientEvent('avid-mdt:housesResults', src, data)
                end)
            else
                print('[^2INFO] ^0[^5avid-mdt^0] encountered a problem at [^5houses^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
                -- SCRIPT BY OWN
            end
        end
    end
end)

CALLBACK.RegisterServerCallback('avid-mdt:getData', function(source, cb, data)
    if data.type == 'vehicle' then
        local result = {}
        SQL.GetVehicle(data.identifier:upper(), function(results)
            result = results
            local notes = MySQL.query.await('SELECT * FROM avid-mdt_vehicle_notes WHERE plate = ? ORDER BY time DESC', {data.identifier:upper()})
            result.notes = notes or {}
            cb(result)
        end, source)
    elseif data.type == 'citizen' then
        SQL.SearchCitizenIdentifier(data.identifier, function(results)
            local result = {}
        
            if not results[1] then
                cb(nil)
                return
            end
        
            result = results[1]
            result.type = "citizen"
            result.licenses = {
                ['drive_bike'] = false,
                ['drive'] = false,
                ['drive_truck'] = false,
                ['weapon'] = false
            }
        
            result.phone = EDITABLE.GetPhoneNumber(data.identifier)

            local fines = MySQL.query.await('SELECT * FROM avid-mdt_fines WHERE identifier = ? ORDER BY date DESC', { data.identifier })
            result.fines = fines or {}
        
            local jails = MySQL.query.await('SELECT * FROM avid-mdt_jails WHERE identifier = ? ORDER BY date DESC', { data.identifier })
            result.jails = jails or {}
        
            local notes = MySQL.query.await('SELECT * FROM avid-mdt_citizen_notes WHERE identifier = ? ORDER BY date DESC', { data.identifier })
            result.notes = notes or {}
        
            result.vehicles = {}
            local vehicles = SQL.GetPlayerVehicles(data.identifier)
        
            if Config.Frameworks.ESX.enabled then
                for i = 1, #vehicles do
                    local vehicle = json.decode(vehicles[i].vehicle).model
                    if vehicle then
                        table.insert(result.vehicles, {
                            plate = vehicles[i].plate,
                            model = SERVER.getVehicleModel(source, vehicle),
                            status = "-"
                        })
                    end
                end

                local licenses = MySQL.query.await('SELECT type FROM user_licenses WHERE owner = ?', { data.identifier })
                for i = 1, #licenses do
                    if result.licenses[licenses[i].type] ~= nil then
                        result.licenses[licenses[i].type] = true
                    end
                end
            elseif Config.Frameworks.QB.enabled then
                for i = 1, #vehicles do
                    local vehicle = json.decode(vehicles[i].hash)
                    if vehicle then
                        table.insert(result.vehicles, {
                            plate = vehicles[i].plate,
                            model = SERVER.getVehicleModel(source, json.decode(vehicles[i].hash)),
                            status = "-"
                        })
                    end
                end
                
                local licenses = SQL.GetPlayerLicenses(data.identifier)
        
                for k, v in pairs(licenses) do
                    if k == 'driver' or k == 'drive' then
                        result.licenses.drive = true
                    end
                    if k == 'weapon' then
                        result.licenses.weapon = true
                    end
                    if k == 'drive_bike' or k == 'drive_truck' then
                        result.licenses[k] = true
                    end
                end
            else
                print('[^2INFO] ^0[^5avid-mdt^0] encountered a problem at [^5getData^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
                -- SCRIPT IT BY OWN
            end
        
            cb(result)
        end)
        
    end
end)

RegisterServerEvent('avid-mdt:addVehicleNote', function(data)
    local src = source
    local xPlayer = FRAMEWORK.GetPlayerFromId(src)

    if xPlayer then
        if not Config.Jobs.OnDuty[xPlayer.job.name] then
            return
        end

        if #data.note >= 250 then
            xPlayer.showNotification(_L('MAX_MARKS'))
            return
        end

        local officer = EDITABLE.GetBadge(xPlayer) .. " " .. FRAMEWORK.GetFirstName(xPlayer) .. " " .. FRAMEWORK.GetLastName(xPlayer)
        MySQL.insert('INSERT INTO avid-mdt_vehicle_notes (plate, date, note, officer) VALUES (LEFT(?, 100), ?, LEFT(?, 1000), LEFT(?, 100))', {data.plate:upper(), os.time(), data.note, officer})
        
        if Config.Frameworks.ESX.enabled then
            MySQL.query('SELECT owner, plate, vehicle FROM owned_vehicles WHERE plate = ? LIMIT 1', {data.plate:upper()}, function(results)
                if #SERVER.lastNotes.vehicles > 5 then
                    table.remove(SERVER.lastNotes.vehicles, 1)
                end
            
                local ownerIdentifier = SQL.GetVehicleOwnerIdentifier(data.plate:upper())
                local owner = SQL.GetName(ownerIdentifier)
                local vehicle = json.decode(results[1].vehicle).model
            
                table.insert(SERVER.lastNotes.vehicles, {
                    model = SERVER.getVehicleModel(src, vehicle),
                    plate = data.plate:upper(),
                    reason = data.note,
                    date = os.time(),
                    owner = owner or "",
                    officer = officer
                })
    
                if Config.UseWebhooks then 
                    SERVER.SendLog("addVehicleNote", (Config.Webhooks["addVehicleNote"].description):format(src, SERVER.getVehicleModel(src, vehicle), data.plate:upper(), data.note))
                end
            end)
        elseif Config.Frameworks.QB.enabled then
            MySQL.query('SELECT owner, plate, vehicle AS model FROM player_vehicles WHERE plate = ? LIMIT 1', {data.plate:upper()}, function(results)
                if #SERVER.lastNotes.vehicles > 5 then
                    table.remove(SERVER.lastNotes.vehicles, 1)
                end
            
                local ownerIdentifier = SQL.GetVehicleOwnerIdentifier(data.plate:upper())
                local owner = SQL.GetName(ownerIdentifier)
                local vehicle = json.decode(results[1].vehicle).model
            
                table.insert(SERVER.lastNotes.vehicles, {
                    model = SERVER.getVehicleModel(src, vehicle),
                    plate = data.plate:upper(),
                    reason = data.note,
                    date = os.time(),
                    owner = owner or "",
                    officer = officer
                })
    
                if Config.UseWebhooks then 
                    SERVER.SendLog("addVehicleNote", (Config.Webhooks["addVehicleNote"].description):format(src, SERVER.getVehicleModel(src, vehicle), data.plate:upper(), data.note))
                end
            end)
        else
            print('[^2INFO] ^0[^5avid-mdt^0] encountered a problem at [^5addVehicleNote^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
            -- SCRIPT BY OWN
        end
    end
end)

RegisterServerEvent('avid-mdt:addCitizenNote', function(data)
    local src = source
    local xPlayer = FRAMEWORK.GetPlayerFromId(src)

    if xPlayer then
        if not Config.Jobs.OnDuty[xPlayer.job.name] then
            return
        end
    
        if #data.note >= 250 then
            xPlayer.showNotification(_L('MAX_MARKS'))
            return
        end
    
        if Config.Frameworks.ESX.enabled then
            local officer = EDITABLE.GetBadge(xPlayer) .. " " .. FRAMEWORK.GetFirstName(xPlayer) .. " " .. FRAMEWORK.GetLastName(xPlayer)
            MySQL.insert('INSERT INTO avid-mdt_citizen_notes (identifier, date, reason, officer) VALUES (LEFT(?, 100), ?, LEFT(?, 1000), LEFT(?, 100))', {data.identifier, os.time(), data.note, officer})
            local name = MySQL.scalar.await('SELECT CONCAT(firstname, " ", lastname) FROM users WHERE identifier = ?', {data.identifier})
        
            if #SERVER.lastNotes.citizen > 5 then
                table.remove(SERVER.lastNotes.citizen, 1)
            end
        
            table.insert(SERVER.lastNotes.citizen, {
                name = name or "",
                date = os.time(),
                reason = data.note,
                officer = officer
            })
        
            if Config.UseWebhooks then 
                SERVER.SendLog("addCitizenNote", (Config.Webhooks["addCitizenNote"].description):format(src, name, data.note))
            end
        elseif Config.Frameworks.QB.enabled then
            local officer = EDITABLE.GetBadge(xPlayer) .. " " .. FRAMEWORK.GetFirstName(xPlayer) .. " " .. FRAMEWORK.GetLastName(xPlayer)
            MySQL.insert('INSERT INTO avid-mdt_citizen_notes (identifier, date, reason, officer) VALUES (LEFT(?, 100), ?, LEFT(?, 1000), LEFT(?, 100))', {data.identifier, os.time(), data.note, officer})
           
            local player = MySQL.Sync.fetchScalar('SELECT charinfo FROM players WHERE citizenid = ?', {data.identifier})
            local xCH = player
            local playerData = json.decode(xCH)

            if #SERVER.lastNotes.citizen > 5 then
                table.remove(SERVER.lastNotes.citizen, 1)
            end
        
            table.insert(SERVER.lastNotes.citizen, {
                name = (playerData.firstname .. ' ' .. playerData.lastname) or "",
                date = os.time(),
                reason = data.note,
                officer = officer
            })
        
            if Config.UseWebhooks then 
                SERVER.SendLog("addCitizenNote", (Config.Webhooks["addCitizenNote"].description):format(src, (playerData.firstname .. ' ' .. playerData.lastname) or "", data.note))
            end
        else
            print('[^2INFO] ^0[^5avid-mdt^0] encountered a problem at [^5addCitizenNote^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
            -- SCRIPT BY OWN
        end
    end
end)

RegisterServerEvent('avid-mdt:submitFine', function(data)
    local src = source
    local xPlayer = FRAMEWORK.GetPlayerFromId(src)

    if not Config.Jobs.OnDuty[xPlayer.job.name] then
        return
    end

    local zSource, zPlayer = nil, nil

    if not data.identifier then
        return
    end

    if Config.Frameworks.ESX.enabled then
        zSource = FRAMEWORK.GetPlayerFromIdentifier(data.identifier)
        if zSource then
            zPlayer = FRAMEWORK.GetPlayerFromId(zSource.source)
        end
    elseif Config.Frameworks.QB.enabled then
        zSource = FRAMEWORK.GetPlayerFromIdentifier(data.identifier)
        
        if zSource then
            zPlayer = FRAMEWORK.GetPlayerFromId(zSource.PlayerData.source)
        end
    else
        print('[^2INFO] ^0[^5avid-mdt^0] encountered a problem at [^5submitFine^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
    end

    if xPlayer then
        if zPlayer then
            local xCoords = GetEntityCoords(GetPlayerPed(xPlayer.source))
            local zCoords = GetEntityCoords(GetPlayerPed(zPlayer.source))

            if #(xCoords - zCoords) > Config.MaxDistanceToJailFine then
                return xPlayer.showNotification(_L('PLAYER_TOO_FAR'))
            end

            if xPlayer.source == zPlayer.source then
                return xPlayer.showNotification(_L('SAME_PEOPLE'))
            end

            if data.fine and data.fine > 0 then
                if Config.SocietyScripts.esx_society then
                    TriggerEvent('esx_addonaccount:getSharedAccount', Config.Society.name, function(account)
                        if account then
                            account.addMoney(data.fine * Config.Society.percentToPoliceJob)

                            if Config.UsingQFBanking then
                                TriggerEvent("qf-banking:addBankHistory", xPlayer.source, data.fine * Config.Society.percentToPoliceMan, '% from fine', 'bank', xPlayer.getAccount('bank').money) 
                            end
                        end
                    end)
        
                    xPlayer.addAccountMoney('bank', data.fine * Config.Society.percentToPoliceMan)
                    zPlayer.removeAccountMoney('bank', data.fine)
                    
                    if Config.UsingQFBanking then
                        TriggerEvent("qf-banking:addBankHistory", zPlayer.source, data.fine, 'Fine', 'bank', zPlayer.getAccount('bank').money)
                    end

                    if Config.UseWebhooks then 
                        SERVER.SendLog("submitFine", (Config.Webhooks["submitFine"].description):format(src, data.fine * Config.Society.percentToPoliceJob))
                    end
                elseif Config.SocietyScripts.qb_management then
                    exports['qb-management']:AddMoney(Config.Society.name, data.fine * Config.Society.percentToPoliceJob)
                    xPlayer.addAccountMoney('bank', data.fine * Config.Society.percentToPoliceMan)

                    if Config.UsingQFBanking then
                        TriggerEvent("qf-banking:addBankHistory", xPlayer.source, data.fine * Config.Society.percentToPoliceMan, '% from fine', 'bank', xPlayer.getAccount('bank').money) 
                    end

                    zPlayer.removeAccountMoney('bank', data.fine)
                    
                    if Config.UsingQFBanking then
                        TriggerEvent("qf-banking:addBankHistory", zPlayer.source, data.fine, 'Fine', 'bank', zPlayer.getAccount('bank').money)
                    end

                    if Config.UseWebhooks then 
                        SERVER.SendLog("submitFine", (Config.Webhooks["submitFine"].description):format(src, data.fine * Config.Society.percentToPoliceJob))
                    end
                else
                    xPlayer.addAccountMoney('bank', data.fine * Config.Society.percentToPoliceMan)

                    if Config.UsingQFBanking then
                        TriggerEvent("qf-banking:addBankHistory", xPlayer.source, data.fine * Config.Society.percentToPoliceMan, '% from fine', 'bank', xPlayer.getAccount('bank').money) 
                    end

                    zPlayer.removeAccountMoney('bank', data.fine)
                    
                    if Config.UsingQFBanking then
                        TriggerEvent("qf-banking:addBankHistory", zPlayer.source, data.fine, 'Fine', 'bank', zPlayer.getAccount('bank').money)
                    end

                    if Config.UseWebhooks then 
                        SERVER.SendLog("submitFine", (Config.Webhooks["submitFine"].description):format(src, data.fine * Config.Society.percentToPoliceJob))
                    end

                    print('[^2INFO] ^0[^5avid-mdt^0] encountered a problem at [^5submitFine^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
                    -- SCRIPT BY OWN
                end
            end

            if data.jail and data.jail > 0 then
                xPlayer.showNotification((_L('JAIL_POLICEMAN', zPlayer.source, FRAMEWORK.GetFirstName(zPlayer), FRAMEWORK.GetLastName(zPlayer), data.fine, data.jail)))
                zPlayer.showNotification((_L('JAIL_PLAYER', xPlayer.source, FRAMEWORK.GetFirstName(xPlayer), FRAMEWORK.GetLastName(xPlayer), data.fine, data.jail)))
                TriggerEvent('esx_jail:sendToJail070722', tonumber(zPlayer.source), tonumber(data.jail * 60)) 
                --// Add your jail event above there text is example event for this
                MySQL.insert('INSERT INTO avid-mdt_jails (identifier, reason, fine, jail, date, officer) VALUES (LEFT(?, 100), LEFT(?, 1000), ?, ?, ?, LEFT(?, 100))', {data.identifier, data.reason, data.fine, data.jail, os.time(), data.officer})
            else
                xPlayer.showNotification((_L('FINE_POLICEMAN', zPlayer.source, FRAMEWORK.GetFirstName(zPlayer), FRAMEWORK.GetLastName(zPlayer), data.fine)))
                zPlayer.showNotification((_L('FINE_PLAYER', xPlayer.source, FRAMEWORK.GetFirstName(xPlayer), FRAMEWORK.GetLastName(xPlayer), data.fine)))
                MySQL.insert('INSERT INTO avid-mdt_fines (identifier, reason, fine, date, officer) VALUES (LEFT(?, 100), LEFT(?, 1000), ?, ?, LEFT(?, 100))', {data.identifier, data.reason, data.fine, os.time(), data.officer})
            end
        else
            xPlayer.showNotification(_L('PLAYER_NOT_AVAILABLE'))
        end
    end
end)

RegisterCommand(Config.Jobs.AccessCode.command, function(source, args, message, rawCommand)
	local src = source
    local xPlayer = FRAMEWORK.GetPlayerFromId(src)

    if xPlayer then
        if (xPlayer.job and Config.Jobs.OnDuty[xPlayer.job.name]) then
            if xPlayer.job.grade < Config.Jobs.AccessCode.fromGrade then
                xPlayer.showNotification(_L('DONT_HAVE_ACCESS'))
            else
                if args[1] == "green" then
                    TriggerEvent('avid-mdt:updateCityStatus', 'zielony')
                    TriggerClientEvent('chat:addMessage1', -1, "LSPD", Config.MessageColors.GreenCode, _L('GREEN_CODE'), "fas fa-newspaper")
                elseif args[1] == "orange" then
                    TriggerEvent('avid-mdt:updateCityStatus', 'pomarancz')
                    TriggerClientEvent('chat:addMessage1', -1, "LSPD", Config.MessageColors.OrangeCode, _L('ORANGE_CODE'), "fas fa-newspaper")
                elseif args[1] == "red" then
                    TriggerEvent('avid-mdt:updateCityStatus', 'czerwony')
                    TriggerClientEvent('chat:addMessage1', -1, "LSPD", Config.MessageColors.RedCode, _L('RED_CODE'), "fas fa-newspaper")
                elseif args[1] == "black" then
                    TriggerEvent('avid-mdt:updateCityStatus', 'czarny')
                    TriggerClientEvent('chat:addMessage1', -1, "LSPD", Config.MessageColors.BlackCode, _L('BLACK_CODE'), "fas fa-newspaper")	
                else
                    xPlayer.showNotification(_L('INCORRECT_CODE'))
                end
    
                if Config.UseWebhooks then 
                    SERVER.SendLog("codeCommand", (Config.Webhooks["codeCommand"].description):format(src, args[1]))
                end
            end
        end
    end
end, false)