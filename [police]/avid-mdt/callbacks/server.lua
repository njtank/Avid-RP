local serverCallbacks = {}

local clientRequests = {}
local RequestId = 0

---@param eventName string
---@param callback function

CALLBACK = {}

CALLBACK.RegisterServerCustomCallback = function(eventName, callback)
	serverCallbacks[eventName] = callback
end

RegisterNetEvent('framework:triggerServerCustomCallback', function(eventName, requestId, invoker, ...)
	if not serverCallbacks[eventName] then
		return print(('[^1ERROR^7] Server Callback not registered, name: ^5%s^7, invoker resource: ^5%s^7'):format(eventName, invoker))
	end

	local source = source

	serverCallbacks[eventName](source, function(...)
		TriggerClientEvent('framework:serverCustomCallback', source, requestId, invoker, ...)
	end, ...)
end)
---@param player number playerId
---@param eventName string
---@param callback function
---@param ... any
CALLBACK.TriggerClientCustomCallback = function(player, eventName, callback, ...)
	clientRequests[RequestId] = callback

	TriggerClientEvent('framework:triggerClientCustomCallback', player, eventName, RequestId, GetInvokingResource() or "unknown", ...)

	RequestId = RequestId + 1
end

RegisterNetEvent('framework:clientCustomCallback', function(requestId, invoker, ...)
	if not clientRequests[requestId] then
		return print(('[^1ERROR^7] Client Custom Callback with requestId ^5%s^7 Was Called by ^5%s^7 but does not exist.'):format(requestId, invoker))
	end

	clientRequests[requestId](...)
	clientRequests[requestId] = nil
end)

---@param name string
---@param data function
CALLBACK.RegisterServerCallback = function(name, data)
    if Config.Frameworks.ESX.enabled then
        return ESX.RegisterServerCallback(name, data)
    elseif Config.Frameworks.QB.enabled then
        return QBCore.Functions.CreateCallback(name, data)
    else
        print('[^2INFO] ^0[^5avid-mdt^0] encountered a problem at [^5RegisterServerCallback^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
        return CALLBACK.RegisterServerCustomCallback(name, data)
        -- SCRIPT IT BY OWN
    end
end
