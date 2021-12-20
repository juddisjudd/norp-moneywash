ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('norp-moneywash:notifiPolice')
AddEventHandler('norp-moneywash:notifiPolice', function()
    TriggerClientEvent("norp-moneywash:policenotify", -1)
end)

RegisterServerEvent('norp-moneywash:canWashMoney')
AddEventHandler('norp-moneywash:canWashMoney',function(amountToWash)
	local xPlayer = ESX.GetPlayerFromId(source)
    local bm = xPlayer.getAccount('black_money').money
    if bm >= amountToWash then
        xPlayer.removeAccountMoney('black_money', amountToWash)
        TriggerClientEvent("norp-moneywash:MoneyWashFunc", source, amountToWash)
    else
		TriggerClientEvent('norpNotify:Alert', source, "Money Laundering", "You dont have enough Black Money to wash it!", 5000, 'error')
    end
end)

RegisterServerEvent('norp-moneywash:washMoney')
AddEventHandler('norp-moneywash:washMoney',function(amountToWash)
	local xPlayer = ESX.GetPlayerFromId(source)
    if Config.EnableTax then
        local tax = Config.TaxRate
        local delete = amountToWash / 100 * tax
        local clean = amountToWash - delete
        xPlayer.addMoney(clean)
		TriggerClientEvent('norpNotify:Alert', source, "Money Laundering", "Your money was laundered, you got: $"..clean.."!", 5000, 'success')
    else
        xPlayer.addMoney(amountToWash)
		TriggerClientEvent('norpNotify:Alert', source, "Money Laundering", "Your money was laundered, you got: $"..amountToWash.."!", 5000, 'info')
    end
end)

ESX.RegisterServerCallback("norp-moneywash:checkIDCard", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem("moneywash_card")

    if item.count >= 1 then
        cb(true)
    else
        cb(false)
    end
end)

