local QBCore = exports['qb-core']:GetCoreObject()

local started = false
local progress = 0
local pause = false
local quality = 0

RegisterNetEvent('avid-meth:stop')
AddEventHandler('avid-meth:stop', function()
	LastVehicle = QBCore.Functions.GetClosestVehicle()
	started = false
	progress = 0
	lib.notify({description = 'Production stopped...', type = 'success'})
	FreezeEntityPosition(LastVehicle, false)
end)

RegisterNetEvent('avid-meth:notify')
AddEventHandler('avid-meth:notify', function(message)
	lib.notify({description = (message), type = 'success'})
end)

RegisterNetEvent('avid-meth:startprod')
AddEventHandler('avid-meth:startprod', function()
	CurrentVehicle = GetVehiclePedIsUsing(cache.ped)
	started = true
	pause = false
	FreezeEntityPosition(CurrentVehicle, true)
	lib.notify({description = 'Production started', type = 'success'})
end)

RegisterNetEvent('avid-meth:smoke')
AddEventHandler('avid-meth:smoke', function(posx, posy, posz, bool)
	if bool == 'a' then
		if not HasNamedPtfxAssetLoaded("core") then
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do
				Citizen.Wait(1)
			end
		end
		SetPtfxAssetNextCall("core")
		local smoke = StartParticleFxLoopedAtCoord("exp_grd_bzgas_smoke", posx, posy, posz + 1.6, 0.0, 0.0, 0.0, 1.0, false, false, false, false)

		--local smoke = AddExplosion( posx, posy, posz + 1.6, 22, 0, true, 1.0, false, false, false, false)

		SetParticleFxLoopedColour(smoke, 255, 0.0, 0.0)
		SetParticleFxLoopedAlpha(smoke, 0.9)
		Citizen.Wait(60000)
		StopParticleFxLooped(smoke, 0)
	else
		StopParticleFxLooped(smoke, 0)
	end
end)

-------------------------------------------------------EVENTS NEGATIVE
RegisterNetEvent('avid-meth:boom', function()
	playerPed = cache.ped
	local pos = GetEntityCoords(cache.ped)
	pause = false
	Citizen.Wait(500)
	started = false
	Citizen.Wait(500)
	CurrentVehicle = GetVehiclePedIsUsing(cache.ped)
	TriggerServerEvent('avid-meth:blow', pos.x, pos.y, pos.z)
	TriggerEvent('avid-meth:stop')
end)

RegisterNetEvent('avid-meth:blowup')
AddEventHandler('avid-meth:blowup', function(posx, posy, posz)
	AddExplosion(posx, posy, posz + 2, 15, 20.0, true, false, 1.0, true)
	if not HasNamedPtfxAssetLoaded("core") then
		RequestNamedPtfxAsset("core")
		while not HasNamedPtfxAssetLoaded("core") do
			Citizen.Wait(1)
		end
	end
	SetPtfxAssetNextCall("core")
	local fire = StartParticleFxLoopedAtCoord("ent_ray_heli_aprtmnt_l_fire", posx, posy, posz-0.8 , 0.0, 0.0, 0.0, 0.8, false, false, false, false)
	Citizen.Wait(6000)
	StopParticleFxLooped(fire, 0)	
end)

RegisterNetEvent('avid-meth:drugged')
AddEventHandler('avid-meth:drugged', function()
	local pos = GetEntityCoords(cache.ped)
	SetTimecycleModifier("drug_drive_blend01")
	SetPedMotionBlur(cache.ped, true)
	SetPedMovementClipset(cache.ped, "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk(cache.ped, true)
	quality = quality - 3
	pause = false
	Wait(90000)
	ClearTimecycleModifier()
	TriggerServerEvent('avid-meth:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('avid-meth:q-1police', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	lib.notify({description = data.message, type = 'error'})		
	quality = quality - 1
	pause = false
	TriggerServerEvent('police:server:policeAlert', 'Person reports stange smell!')
	TriggerServerEvent('avid-meth:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('avid-meth:q-1', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	lib.notify({description = data.message, type = 'error'})
	quality = quality - 1
	pause = false
	TriggerServerEvent('avid-meth:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('avid-meth:q-3', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	lib.notify({description = data.message, type = 'error'})
	quality = quality - 3
	pause = false
	TriggerServerEvent('avid-meth:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('avid-meth:q-5', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	lib.notify({description = data.message, type = 'error'})	
	quality = quality - 5
	pause = false
	TriggerServerEvent('avid-meth:make', pos.x,pos.y,pos.z)
end)

-------------------------------------------------------EVENTS POSITIVE
RegisterNetEvent('avid-meth:q2', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	lib.notify({description = data.message, type = 'success'})	
	quality = quality + 2
	pause = false
	TriggerServerEvent('avid-meth:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('avid-meth:q3', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	lib.notify({description = data.message, type = 'success'})
	quality = quality + 3
	pause = false
	TriggerServerEvent('avid-meth:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('avid-meth:q5', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	lib.notify({description = data.message, type = 'success'})	
	quality = quality + 5
	pause = false
	TriggerServerEvent('avid-meth:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('avid-meth:gasmask', function(data)
	local pos = GetEntityCoords((PlayerPedId()))
	lib.notify({description = data.message, type = 'success'})	
	SetPedPropIndex(playerPed, 1, 26, 7, true)
	quality = quality + 2
	pause = false
	TriggerServerEvent('avid-meth:make', pos.x,pos.y,pos.z)
end)

RegisterNetEvent('avid-meth:cook', function()
	local pos = GetEntityCoords(cache.ped)
	playerPed = (cache.ped)
	local CurrentVehicle = QBCore.Functions.GetClosestVehicle()
	if IsVehicleSeatFree(CurrentVehicle, 3) and IsVehicleSeatFree(CurrentVehicle, -1) and IsVehicleSeatFree(CurrentVehicle, 0) and IsVehicleSeatFree(CurrentVehicle, 1)and IsVehicleSeatFree(CurrentVehicle, 2) then
		TaskWarpPedIntoVehicle(PlayerPedId(), CurrentVehicle, 3)
		SetVehicleDoorOpen(CurrentVehicle, 2)
		Wait(300)
		TriggerServerEvent('avid-meth:start')
		TriggerServerEvent('avid-meth:make', pos.x,pos.y,pos.z)
		Wait(1000)
		quality = 0
	else
		lib.notify({description = 'There is someone in your kitchen', type = 'error'})	
	end
end)

---------EVENTS------------------------------------------------------

RegisterNetEvent('avid-meth:proses', function()
	--
	--   EVENT 1
	--
	if progress > 9 and progress < 11 then
		pause = true
		--TriggerEvent('avid-meth:client:showmenu1')
		lib.registerContext({
			id = 'progress-1',
			title = 'Gas tank is leaking... now what?',
			canClose = true,
			options = {
				{ title = 'How do you fix the gas leak?', description = "Current Progress: " .. progress .. "%", icon = 'fas fa-question', disabled = false },
				{ event = 'avid-meth:q-3', icon = 'fas fa-tape', title = 'Use tape', description = 'Cover it with some tape', args = {message = "That kinda fixed it, I think?" } },
				{ event = 'avid-meth:boom', icon = 'fas fa-person-praying', title = 'Ignore it', description = 'Ignore it and pray for the best' },
				{ event = 'avid-meth:q5', icon = 'fas fa-wrench', title = 'Replace the tube', description = 'Fit a new tube', args = {message = "Replacing it was the best solution" } },
			},
		})
		lib.showContext('progress-1')
	end
	--
	--   EVENT 2
	--
	if progress > 19 and progress < 21 then
		pause = true
		lib.registerContext({
			id = 'progress-2',
			title = 'You spilled some acetone on the floor... now what?',
			canClose = true,
			options = {
				{ title = 'How are you going to clean this mess up?', description = "Current Progress: " .. progress .. "%", icon = 'fas fa-question', disabled = false },
				{ event = 'avid-meth:q-1police', icon = 'fas fa-person-through-window', title = 'Open a window', description = 'Fresh air never hurt anyone, right?', args = {message = "The pungent smell is attracting people!" } },
				{ event = 'avid-meth:drugged', icon = 'fas fa-lungs', title = 'Breathe it in', description = 'Try not to breathe too much', args = {message = "You start to see double of everything"} },
				{ event = 'avid-meth:gasmask', icon = 'fas fa-mask-face', title = 'Put on a mask', description = 'Does this mask suit my outfit?', args = {message = "Replacing it was the best solution" } },
			},
		})
		lib.showContext('progress-2')
	end
	--
	--   EVENT 3
	--
	if progress > 29 and progress < 31 then
		pause = true
		lib.registerContext({
			id = 'progress-3',
			title = 'Meth is being produced too quickly, what do you do?',
			canClose = true,
			options = {
				{ title = 'What would Heisenberg do?', description = "Current Progress: " .. progress .. "%", icon = 'fas fa-question', disabled = false },
				{ event = 'avid-meth:q-5', icon = 'fas fa-arrow-down', title = 'Lower the pressure', description = 'What happens if I turn this dial down?', args = {message = "That was the worst thing you could do!" } },
				{ event = 'avid-meth:q5', icon = 'fas fa-temperature-arrow-up', title = 'Add more heat', description = 'Just try not to burn it, will ya?', args = {message = "A higher temperture made the perfect balance!" } },
				{ event = 'avid-meth:q-5', icon = 'fas fa-plus', title = 'Add more pressure', description = 'What happens if I turn this dial up?', args = {message = "The pressure fluctuated a lot"} },
			},
		})
		lib.showContext('progress-3')
	end
	--
	--   EVENT 4
	--
	if progress > 39 and progress < 41 then
		pause = true
		lib.registerContext({
			id = 'progress-4',
			title = 'You added too much acetone, what to do?',
			canClose = true,
			options = {
				{ title = 'I really should use a measuring cup', description = "Current Progress: " .. progress .. "%", icon = 'fas fa-question', disabled = false },
				{ event = 'avid-meth:q-3', icon = 'fas fa-xmark', title = 'Do nothing', description = 'If I ignore it, will it fix it self?', args = {message = "The meth is smelling like pure acetone" } },
				{ event = 'avid-meth:q-5', icon = 'fas fa-face-grin-tongue', title = 'Use a straw', description = 'Put those lips to good use and suck', args = {message = "You start to see double of everything" } },
				{ event = 'avid-meth:q3', icon = 'fas fa-plus', title = 'Add lithium', description = 'Maybe if I add more lithium it\'ll stabilize', args = {message = "This was the best solution"} },
			},
		})
		lib.showContext('progress-4')
	end
	--
	--   EVENT 5
	--
	if progress > 49 and progress < 51 then
		pause = true
		lib.registerContext({
			id = 'progress-5',
			title = 'You found some blue dye',
			canClose = true,
			options = {
				{ title = 'What are you going to do?', description = "Current Progress: " .. progress .. "%", icon = 'fas fa-question', disabled = false },
				{ event = 'avid-meth:q2', icon = 'fas fa-wine-bottle', title = 'Pour it in', description = 'No harm in adding some dye, right?', args = {message = "Smart move. Output has increased" } },
				{ event = 'avid-meth:q-5', icon = 'fas fa-dumpster', title = 'Throw it away', description = 'Just throw it away', args = {message = "Not very creative, are you?" } },
				{ event = 'avid-meth:q-3', icon = 'fas fa-plus', title = 'You found another colour', description = 'You have never seen pink meth before', args = {message = "No one is buying this crap"} },
			},
		})
		lib.showContext('progress-5')
	end
	--
	--   EVENT 6
	--
	if progress > 59 and progress < 61 then
		pause = true
		lib.registerContext({
			id = 'progress-6',
			title = 'Your filter is dirty',
			canClose = true,
			options = {
				{ title = 'Clean the filter with what?', description = "Current Progress: " .. progress .. "%", icon = 'fas fa-question', disabled = false },
				{ event = 'avid-meth:q-5', icon = 'fas fa-wind', title = 'With a compressor', description = 'Blow it out with some compressed air', args = {message = "You blew the product everywhere" } },
				{ event = 'avid-meth:q5', icon = 'fas fa-wrench', title = 'Replace it', description = 'Try replacing the filter', args = {message = "You aren\'t stupid after all" } },
				{ event = 'avid-meth:q-3', icon = 'fas fa-brush', title = 'Use a brush', description = 'Try cleaning it with a brush', args = {message = "You just made things worse"} },
			},
		})
		lib.showContext('progress-6')
	end
	--
	--   EVENT 7
	--
	if progress > 69 and progress < 71 then
		pause = true
		lib.registerContext({
			id = 'progress-7',
			title = 'You spilled some acetone on the floor... now what?',
			canClose = true,
			options = {
				{ title = 'How are you going to clean this mess up?', description = "Current Progress: " .. progress .. "%", icon = 'fas fa-question', disabled = false },
				{ event = 'avid-meth:q-1police', icon = 'fas fa-person-through-window', title = 'Open a window', description = 'Fresh air never hurt anyone, right?', args = {message = "The pungent smell is attracting people!" } },
				{ event = 'avid-meth:drugged', icon = 'fas fa-lungs', title = 'Breathe it in', description = 'Try not to breathe too much', args = {message = "You start to see double of everything"} },
				{ event = 'avid-meth:q3', icon = 'fas fa-mask-face', title = 'Put on a mask', description = 'Does this mask suit my outfit?', args = {message = "Replacing it was the best solution" } },
			},
		})
		lib.showContext('progress-7')
	end
	--
	--   EVENT 8
	--
	if progress > 79 and progress < 81 then
		pause = true
		lib.registerContext({
			id = 'progress-8',
			title = 'Gas tank is leaking... now what?',
			canClose = true,
			options = {
				{ title = 'How do you fix the gas leak?', description = "Current Progress: " .. progress .. "%", icon = 'fas fa-question', disabled = false },
				{ event = 'avid-meth:q-3', icon = 'fas fa-tape', title = 'Use tape', description = 'Cover it with some tape', args = {message = "That kinda fixed it, I think?" } },
				{ event = 'avid-meth:boom', icon = 'fas fa-person-praying', title = 'Ignore it', description = 'Ignore it and pray for the best' },
				{ event = 'avid-meth:q5', icon = 'fas fa-wrench', title = 'Replace the tube', description = 'Fit a new tube', args = {message = "Replacing it was the best solution" } },
			},
		})
		lib.showContext('progress-8')
	end
	--
	--   EVENT 9
	--
	if progress > 89 and progress < 91 then
		pause = true
		lib.registerContext({
			id = 'progress-9',
			title = 'You really need to take a shit',
			canClose = true,
			options = {
				{ title = 'My toilet is busted', description = "Current Progress: " .. progress .. "%", icon = 'fas fa-question', disabled = false },
				{ event = 'avid-meth:q3', icon = 'fas fa-hand-holding', title = 'Hold it in', description = 'Squeeze them butt cheeks', args = {message = "Superb Job" } },
				{ event = 'avid-meth:q-1police', icon = 'fas fa-user-ninja', title = 'Go outside', description = 'Go find a nice bush to squat behind', args = {message = "Shit, you've been spotted"} },
				{ event = 'avid-meth:q-5', icon = 'fas fa-caravan', title = 'Go inside', description = 'Find a nice spot inside the camper', args = {message = "Why would you shit inside? Now everything smells" } },
			},
		})
		lib.showContext('progress-9')
	end
	--
	--   DONE
	--	
	if progress > 99 and progress < 101 then
		pause = true
		lib.registerContext({
			id = 'progress-finish',
			title = 'Job done',
			canClose = true,
			options = {
				{ title = 'You have finished cooking', description = "Current Progress: " .. progress .. "%", icon = 'fas fa-question', disabled = false },
				{ event = 'avid-meth:done', icon = 'fas fa-box', title = 'Collect meth', description = 'Package meth', },
			},
		})
		lib.showContext('progress-finish')
	end
end)

RegisterNetEvent('avid-meth:done', function()
	quality = quality + 5
	started = false
	TriggerEvent('avid-meth:stop')
	TriggerServerEvent('avid-meth:finish', quality)
	SetPedPropIndex(playerPed, 1, 0, 0, true)
end)

-----THREADS------------------------------------------------------------------------------

CreateThread(function()
	while true do
		Wait(250)
		if started == true then
			if pause == false and cache.vehicle then
				Citizen.Wait(250)
				progress = progress +  1
				quality = quality + 1
				lib.notify({description = 'Meth production: ' .. progress .. '%', type = 'inform'})	
				TriggerEvent('avid-meth:proses')
				Wait(2000)
			end
		end
	end
end)

AddEventHandler('baseevents:leftVehicle', function()
	if started then
	  playerPed = cache.ped
	  CurrentVehicle = cache.vehicle
	  pause = true
	  started = false
	  TriggerEvent('avid-meth:stop')
	  SetPedPropIndex(playerPed, 1, 0, 0, true)
	  FreezeEntityPosition(CurrentVehicle, false)
	end
end)

CreateThread(function()
	local methCar = 'journey'

    exports.ox_target:addModel(methCar, {
        {
			event = 'avid-meth:cook',
            icon = 'fas fa-fire-burner',
            label = 'Start Cooking',
            distance = 1.5,
			items = 'meth_equipment'
        }
    })

end)




