ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)



RegisterNetEvent('nuo:spawnVehicleBySql')
AddEventHandler('nuo:spawnVehicleBySql', function(model)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	ESX.UI.Menu.Open(
	  'dialog', GetCurrentResourceName(), 'givecar',
	  {
		title =_U('createPlate')
	  },
	  function(data, menu)
		local plate = 	string.upper(data.value)
		if plate == nil or string.len(plate)>8 then
		  ESX.ShowNotification(_('errorPlate'))
		else
		  menu.close()
		  ESX.Game.SpawnVehicle(model, coords, 90.0, function(vehicle)
			TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
			
			local newPlate     = plate
			local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
			vehicleProps.plate = newPlate
			SetVehicleNumberPlateText(vehicle, newPlate)
			TriggerServerEvent('nuo:setVehicleBySql', vehicleProps)
		end)	  
		end
	  end,function(data, menu)
	  menu.close()
	end)
	
	

	
end)

RegisterNetEvent('nuo:dvplateC')
AddEventHandler('nuo:dvplateC', function()
	ESX.UI.Menu.Open(
	  'dialog', GetCurrentResourceName(), 'dvplate',
	  {
		title =_U('createPlate')
	  },
	  function(data, menu)
		local plate = 	string.upper(data.value)
		if plate == nil or string.len(plate)>8 then
		  ESX.ShowNotification(_('errorPlate'))
		else
			menu.close()
			TriggerServerEvent('nuo:dvplatesql', plate)	  
		end
	  end,function(data, menu)
	  menu.close()
	end)

end)

RegisterNetEvent('nuo:spawnYouVehicleBySql')
AddEventHandler('nuo:spawnYouVehicleBySql', function(model,youId)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	ESX.UI.Menu.Open(
	  'dialog', GetCurrentResourceName(), 'giveyoucar',
	  {
		title =_U('createPlate')
	  },
	  function(data, menu)
		local plate = 	string.upper(data.value)
		if plate == nil or string.len(plate)>8 then
		  ESX.ShowNotification(_('errorPlate'))
		else
		  menu.close()
		  ESX.Game.SpawnVehicle(model, coords, 90.0, function(vehicle)
			TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
			
			local newPlate     = plate
			local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
			SetVehicleNumberPlateText(vehicle, newPlate)
			vehicleProps.plate = newPlate
			TriggerServerEvent('nuo:setYouVehicleBySql', vehicleProps,youId)
		end)	  
		end
	  end,function(data, menu)
	  menu.close()
	end)
	
	
	
	

	
end)