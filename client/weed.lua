ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

IsSellingWiet = false
IsWaitingWiet = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        DrawMarker(27, Config.Locations.WietVerkoop.x, Config.Locations.WietVerkoop.y, Config.Locations.WietVerkoop.z, 0, 0, 0, 0, 0, 0, 4.0, 4.0, 1.0, 0, 255, 0, 100, 0, 0, 0, 0, 0, 0, 0)
    end
end)

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
        if GetDistanceBetweenCoords(Config.Locations.WietVerkoop.x, Config.Locations.WietVerkoop.y, Config.Locations.WietVerkoop.z, GetEntityCoords(GetPlayerPed(-1),true)) < 2.5 then
            if IsSellingWiet == false then
                HelpText("Press ~INPUT_CONTEXT~ to sell your weed",0,1,0.5,0.8,0.6,255,255,255,255)
            end
  
            if IsControlJustPressed(1,38) and IsSellingWiet == false then
                IsSellingWiet = true
            end
        else
            if IsSellingWiet == true then
                IsSellingWiet = false
                notify("~r~Action cancelled, you moved too far away.")
            end
        end

        if IsSellingWiet == true and IsWaitingWiet == false then
            IsWaitingWiet = true
            Citizen.Wait(500)
            ESX.TriggerServerCallback('macerz:WietCount', function(xWiet)
                if xWiet > 0 then
                    RandomZakjes = math.random(1, 3)
                    CalcWietPrice = math.random(Config.Pricing.Wiet.Min, Config.Pricing.Wiet.Max)

                    if RandomZakjes > xWiet then
                        RandomZakjes = xWiet
                    end

                    WietPrice = RandomZakjes * CalcWietPrice
                    TriggerServerEvent('macerz:SellWiet', RandomZakjes, WietPrice)
                    notify("You sold ~g~"..RandomZakjes.."x ~s~ coke, receiving ~g~$"..WietPrice)
                else
                    notify("~r~You dont have enough weed to sell.")
                    IsSellingWiet = false
                end
            end)
            Citizen.Wait(5000)
            IsWaitingWiet = false

        end
    end
  end)

function HelpText(text, state)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, state, 0, -1)
end

function notify(str)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(str)
    EndTextCommandThefeedPostTicker(true, false)
end
