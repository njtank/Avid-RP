https://docs.codesign.pro/paid-scripts/dispatch

                        local data = exports['cd_dispatch']:GetPlayerInfo()
                        TriggerServerEvent('cd_dispatch:AddNotification', {
                            job_table = {'police'}, --{'police', 'sheriff}
                            coords = data.coords,
                            title = '10-15 - Store Robbery',
                            message = 'A '..data.sex..' robbing a store at '..data.street,
                            flash = 0,
                            unique_id = tostring(math.random(0000000,9999999)),
                            blip = {
                                sprite = 431,
                                scale = 1.2,
                                colour = 3,
                                flashes = false,
                                text = '911 - Store Robbery',
                                time = (5*60*1000), --(5 mins)
                                sound = 1,
                            }
                        })