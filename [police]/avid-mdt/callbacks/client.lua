local RequestId = 0
local serverRequests = {}

local clientCallbacks = {}

---@param eventName string
---@param callback function
---@param ... any

CALLBACK = {}

CALLBACK.TriggerServerCustomCallback = function(eventName, callback, ...)
	serverRequests[RequestId] = callback

	TriggerServerEvent('framework:triggerServerCustomCallback', eventName, RequestId, GetInvokingResource() or "unknown", ...)

	RequestId = RequestId + 1
end

RegisterNetEvent('framework:serverCustomCallback', function(requestId, invoker, ...)
	if not serverRequests[requestId] then
		return print(('[^1ERROR^7] Server Callback with requestId ^5%s^7 Was Called by ^5%s^7 but does not exist.'):format(requestId, invoker))
	end

	serverRequests[requestId](...)
	serverRequests[requestId] = nil
end)

---@param eventName string
---@param callback function
CALLBACK.RegisterClientCustomCallback = function(eventName, callback)
	clientCallbacks[eventName] = callback
end

RegisterNetEvent('framework:triggerClientCustomCallback', function(eventName, requestId, invoker, ...)
	if not clientCallbacks[eventName] then
		return print(('[^1ERROR^7] Client Custom Callback not registered, name: ^5%s^7, invoker resource: ^5%s^7'):format(eventName, invoker))
	end

	clientCallbacks[eventName](function(...)
		TriggerServerEvent('framework:clientCustomCallback', requestId, invoker, ...)
	end, ...)
end)

---@param name string
---@param cb function
---@param ...? any
CALLBACK.TriggerServerCallback = function(name, cb, ...)
    if Config.Frameworks.ESX.enabled then
        return ESX.TriggerServerCallback(name, cb, ...)
    elseif Config.Frameworks.QB.enabled then
        return QBCore.Functions.TriggerCallback(name, cb, ...)
    else
        print('[^2INFO] ^0[^5avid-mdt^0] encountered a problem at [^5TriggerServerCallback^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
        return CALLBACK.TriggerServerCustomCallback(name, cb, ...)
    end
end