Main = {}
picked = 0

QBCore.Functions.CreateCallback('bbv-atmaddmoney', function(source, cb, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if picked > 3 then return end -- anti exploit
    picked = picked + 1

    -- Generate a random amount between 47 and 58
    local randomAmount = math.random(47, 58)

    -- Add the item "folded_cash" with the random amount
    Player.Functions.AddItem('folded_cash', randomAmount)

    -- Optionally, you can notify the player that they received the item
    TriggerClientEvent('QBCore:Notify', src, 'You received ' .. randomAmount .. ' folded cash.', 'success')
end)

QBCore.Functions.CreateCallback('bbv-atm:cooldown', function(source, cb, args)
    if not cooldown then 
        cb(false)
    else
        cb(true)
    end
    Main:Cooldown()
end)

function Main:Cooldown()
    if cooldown then return end 
    cooldown = true
    Wait(Config.Settings.Cooldown * 60000)
    cooldown = false
    picked = 0
end