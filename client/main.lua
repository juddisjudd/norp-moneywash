ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(0)
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
end)

RegisterNetEvent("norp-moneywash:policenotify")
AddEventHandler("norp-moneywash:policenotify", function()
	if Config.EnablePoliceNotify then
    	local player = ESX.GetPlayerData()
    	if player.job.name == "police" then
		local playerCoords = GetEntityCoords(PlayerPedId())
		local data = {displayCode = '211', description = 'Suspicious activity in progress', isImportant = 1, recipientList = {'police'}, length = '4000'}
		local dispatchData = {dispatchData = data, caller = 'Local', coords = playerCoords}
		TriggerServerEvent('wf-alerts:svNotify', dispatchData)
    	end
	end
end)

function WashMoney(amountToWash)
    if Config.NeedIDCardToWashMoney then
        ESX.TriggerServerCallback("norp-moneywash:checkIDCard", function(result)
            if result == true then
                     ESX.UI.Menu.Open("dialog",GetCurrentResourceName(),"MoneyWashing",
                    {title = "How Much Money do you want to wash?"},
                    function(l, m)
                        m.close()
                        amountToWash = tonumber(l.value)
                        if amountToWash == 0 or amountToWash == nil then
                            return
                        end
                        TriggerServerEvent("norp-moneywash:canWashMoney", amountToWash)
                    end,
                    function(l, m)
                        m.close()
                    end
                )
            else
				exports['norpNotify']:Alert("Money Laundering", "You dont have an ID Card to access Money Wash.", 5000, 'warning')
            end
        end)
    else
        ESX.UI.Menu.Open("dialog",GetCurrentResourceName(),"MoneyWashing",
                    {title = "How Much Money do you want to wash?"},
                    function(l, m)
                        m.close()
                        amountToWash = tonumber(l.value)
                        if amountToWash == 0 or amountToWash == nil then
                            return
                        end
                        TriggerServerEvent("norp-moneywash:canWashMoney", amountToWash)
                    end,
                    function(l, m)
                        m.close()
                    end
                )
    end
end

RegisterNetEvent("norp-moneywash:MoneyWashFunc")
AddEventHandler("norp-moneywash:MoneyWashFunc", function(amountToWash)
        exports.rprogress:Custom(
            {
                Duration = 25000,
                Label = "MONEY IS LAUNDERING. . .",
                Animation = {
                    scenario = "WORLD_HUMAN_MAID_CLEAN", -- https://pastebin.com/6mrYTdQv
                },
                DisableControls = {
                        Mouse = false,
                        Player = true,
                        Vehicle = true
                }
            },
            function(e)
                if not e then
                    ClearPedTasks(PlayerPedId())
                else
                    ClearPedTasks(PlayerPedId())
                end
            end) 
	Citizen.Wait(25000)
    TriggerServerEvent("norp-moneywash:washMoney", amountToWash)
    local laundromat = vector3(1137.46, -991.97, 46.11)
    local chance = math.random(0,100)
    if chance > 27 then
        TriggerServerEvent("norp-moneywash:policenotify", laundromat)
    end
end)

if Config.EnableMoneyWashBlip then
    Citizen.CreateThread(function()
		for k,v in pairs(Config.MoneyWash) do
			for i = 1, #v.WashMoney, 1 do
				local blip = AddBlipForCoord(v.WashMoney[i])
				
				SetBlipSprite (blip, 483)
				SetBlipDisplay(blip, 4)
				SetBlipScale  (blip, 0.8)
				SetBlipColour (blip, 17)
				SetBlipAsShortRange(blip, true)
				
				BeginTextCommandSetBlipName('STRING')
				AddTextComponentSubstringPlayerName(Config.WashMoneyBlipName)
				EndTextCommandSetBlipName(blip)
			end
		end
	end)
end

Citizen.CreateThread(function()
    exports.qtarget:AddBoxZone("MoneyWash", vector3(1135.65, -990.48, 46.11), 5.8, 2.4, {
        name="MoneyWash",
        heading=7,
        debugPoly=false,
        minZ=45.76,
        maxZ=47.56
    }, {
        options = {
        {
        event = "moneywash:qt",
        icon = "fas fa-money-bill",
        label = "Wash Money",
        },
    },
        distance = 4.0
    })
end)

RegisterNetEvent('moneywash:qt')
AddEventHandler('moneywash:qt', function()
    WashMoney(amountToWash)
end)  
