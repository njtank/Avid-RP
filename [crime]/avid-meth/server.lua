local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('avid-meth:start')
AddEventHandler('avid-meth:start', function()
	local _source = source
	local Player = QBCore.Functions.GetPlayer(source)
	local ItemAcetone = Player.Functions.GetItemByName(Config.Acetone)
    local ItemLithium = Player.Functions.GetItemByName(Config.Lithium)
	local Itemmeth_equipment = Player.Functions.GetItemByName(Config.meth_equipment)
	if ItemAcetone ~= nil and ItemLithium ~= nil and Itemmeth_equipment ~= nil then
		if ItemAcetone.count >= Config.AcetoneAmount and ItemLithium.count >= Config.LithiumAmount and Itemmeth_equipment.count >= 1 then
			Wait(1000)
			TriggerClientEvent("avid-meth:startprod", _source)
			Player.Functions.RemoveItem(Config.Acetone, Config.AcetoneAmount, false)
			Player.Functions.RemoveItem(Config.Lithium, Config.LithiumAmount, false)
		else
		TriggerClientEvent('avid-meth:stop', _source)
		TriggerClientEvent('ox_lib:notify', source, { type = 'error', description = 'You dont have enough ingredients to cook!' })
		end
	else
	TriggerClientEvent('avid-meth:stop', _source)
	TriggerClientEvent('ox_lib:notify', source, { type = 'error', description = 'Youre missing essential ingredients!' })
	end
end)

RegisterServerEvent('avid-meth:make')
AddEventHandler('avid-meth:make', function(posx,posy,posz)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(tonumber(source))
	if xPlayer.Functions.GetItemByName(Config.meth_equipment) ~= nil then
		if xPlayer.Functions.GetItemByName(Config.meth_equipment)?.count >= 1 then
			local xPlayers = QBCore.Functions.GetPlayers()
			for i=1, #xPlayers, 1 do
				TriggerClientEvent('avid-meth:smoke',xPlayers[i],posx,posy,posz, 'a')
			end
		else
			TriggerClientEvent('avid-meth:stop', _source)
		end
	else
		TriggerClientEvent('ox_lib:notify', source, { type = 'error', description = 'Youre missing a lab!' })
	end
end)

RegisterServerEvent('avid-meth:finish')
AddEventHandler('avid-meth:finish', function(qualtiy)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(tonumber(source))
	local rnd = math.random(-5, 5)
	local amount = math.floor(qualtiy / 2) + rnd
	xPlayer.Functions.AddItem(Config.Meth, amount)
	TriggerClientEvent('inventory:client:ItemBox', _source, QBCore.Shared.Items['meth'], "add", amount)
end)

RegisterServerEvent('avid-meth:blow')
AddEventHandler('avid-meth:blow', function(posx, posy, posz)
	local _source = source
	local xPlayers = QBCore.Functions.GetPlayers()
	local xPlayer = QBCore.Functions.GetPlayer(tonumber(source))
	for i=1, #xPlayers, 1 do
		TriggerClientEvent('avid-meth:blowup', xPlayers[i],posx, posy, posz)
	end
	xPlayer.Functions.RemoveItem(Config.meth_equipment, 1)
end)

