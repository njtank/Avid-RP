function UpdateGraffitiData()
    local Players = QBCore.Functions.GetQBPlayers()

    if Players and isLoaded then
        for k,v in pairs(Players) do
            if v then
                TriggerClientEvent('avid-graffiti:client:setGraffitiData', k, Config.Graffitis)
            end
        end
    end
end