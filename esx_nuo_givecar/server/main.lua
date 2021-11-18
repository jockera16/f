ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)




--1:model
TriggerEvent('es:addGroupCommand', 'givecar', 'admin', function(source, args, user)
	TriggerClientEvent('nuo:spawnVehicleBySql',source,args[1])
	local xPlayer = ESX.GetPlayerFromId(source)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source,'')
end)


--1:model 2playerid
TriggerEvent('es:addGroupCommand', 'giveyoucar', 'admin', function(source, args, user)
	TriggerClientEvent('nuo:spawnYouVehicleBySql',source,args[1],args[2])
	local xPlayer = ESX.GetPlayerFromId(source)
	local yPlayer = ESX.GetPlayerFromId(args[2])
	TriggerEvent('nuo:giveyoucar',xPlayer.name,yPlayer.name,args[1],args[2])
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source,'')
end)  

--dvplate
TriggerEvent('es:addGroupCommand', 'dvplate', 'admin', function(source, args, user)
	TriggerClientEvent('nuo:dvplateC',source)	
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source,'')
end)

RegisterServerEvent('nuo:dvplatesql')
AddEventHandler('nuo:dvplatesql', function (plate)
MySQL.Async.execute('DELETE FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	})
	TriggerClientEvent('esx:showNotification', source,_U('dvPlate',plate))

end)





RegisterServerEvent('nuo:setVehicleBySql')
AddEventHandler('nuo:setVehicleBySql', function (vehicleProps)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps)
	}, function (rowsChanged)
		TriggerClientEvent('esx:showNotification', _source,_U('getCar',vehicleProps.plate))
	end)
end)

RegisterServerEvent('nuo:setYouVehicleBySql')
AddEventHandler('nuo:setYouVehicleBySql', function (vehicleProps,youId)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(youId)

	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps)
	}, function (rowsChanged)
		TriggerClientEvent('esx:showNotification', _source,_U('meAddCar',vehicleProps.plate))
		TriggerClientEvent('esx:showNotification', youId,_U('getCar',vehicleProps.plate))
	end)
end)