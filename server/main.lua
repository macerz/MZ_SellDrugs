ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Wiet server functions
ESX.RegisterServerCallback('macerz:WietCount', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xWiet = xPlayer.getInventoryItem('marijuana').count
	cb(xWiet)
end)

RegisterServerEvent('macerz:SellWiet')
AddEventHandler('macerz:SellWiet', function(Amount, Price)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('marijuana', Amount)
	xPlayer.addAccountMoney('black_money', Price)

end)

-- Coke server functions
ESX.RegisterServerCallback('macerz:CokeCount', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xCoke = xPlayer.getInventoryItem('cokebag').count
	cb(xCoke)
end)

RegisterServerEvent('macerz:SellCoke')
AddEventHandler('macerz:SellCoke', function(Amount, Price)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('cokebag', Amount)
	xPlayer.addAccountMoney('black_money', Price)

end)

-- Meth server functions
ESX.RegisterServerCallback('macerz:MethCount', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xMeth = xPlayer.getInventoryItem('methbags').count
	cb(xMeth)
end)

RegisterServerEvent('macerz:SellMeth')
AddEventHandler('macerz:SellMeth', function(Amount, Price)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('methbags', Amount)
	xPlayer.addAccountMoney('black_money', Price)

end)
