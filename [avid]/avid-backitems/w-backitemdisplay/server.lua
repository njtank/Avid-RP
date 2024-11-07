-- Event to update the player's weapons data on the server
RegisterNetEvent("avid-backitems:updatePlayer", function(data, remove)
    local source = source
    UpdatePlayer(data, remove, source)
end)